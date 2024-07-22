(ns compare-results
  (:require [babashka.fs :as fs]
            [babashka.process :as p]
            [clojure.string :as str]))

(defn convert [f]
  ;; TIL bat files emit ASCII (or maybe code page 437, but seems to not to require conversion for me here)
  ;; and PowerShell emits UTF16 LE
  ;; So many time-suck-boring puzzles to solve on Windows!
  (if-not (str/includes? f "pwr")
    f
    (let [c (fs/read-all-bytes f)
          new-c (String. c "UTF-16")
          new-f (str f ".converted")]
      (spit new-f new-c)
      new-f)))

(let [files (->> (fs/glob "." "results/pb*.out")
                 (map str)
                 (map convert)
                 sort
                 vec)]
  (println "Comparing:"  files)
  (let [differences (reduce (fn [acc [f1 f2]]
                              (let [{:keys [exit]} (p/shell {:continue true} "git --no-pager diff --no-index --ignore-cr-at-eol --ignore-space-at-eol" f1 f2)]
                                (if (zero? exit)
                                  (do (println "- same:" f1 f2)
                                      acc)
                                  (do (println "^ DIFF:" f1 f2)
                                      (conj acc [f1 f2])))))
                            []
                            (partition 2 1 files))]
    (println)
    (if (seq differences)
      (println "WARNING: There are differences.")
      (println "Great, no differences."))))
