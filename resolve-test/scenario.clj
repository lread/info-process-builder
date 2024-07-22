(ns scenario
  (:require [babashka.fs :as fs]
            [babashka.cli :as cli]
            [clojure.string :as str]))

(defn file-scenario [{:keys [dir] :as scenario}]
  (doseq [p [:on-path :cwd :workdir]
          :let [dest-dir (fs/file dir "scenario" (name p))]]
    (fs/create-dirs dest-dir)
    (doseq [ext [:bat :cmd :exe :ps1 :com :sh]]
      (let [dest (fs/file dir "scenario" (name p) (str "a." (name ext)))]
        (fs/delete-if-exists dest )
        (when (some-> scenario p set ext)
          (let [src (fs/file dir (str "print-dirs." (name ext)))]
            (fs/copy src dest)
            (when (or (= :bat ext) (= :cmd ext))
              ;; I'm not sure I'm trusting windows %~dpnx0, add a line for the explicit truth
              (spit dest (str "echo realdir: " (name p) "\n")
                    :append true))))))))

(comment
  (file-scenario {:cwd [:bat :com :cmd :exe :ps1]
                  :on-path [:bat :com :cmd :exe :ps1]
                  :workdir [:bat :com :cmd :exe :ps1]}))

(defn show-scenario [{:keys [opts]}]
  (doseq [p [:cwd :workdir :on-path]]
    (let [files (->> (fs/list-dir (fs/file (:dir opts) "scenario" (name p))
                                 "a.*")
                     (mapv fs/extension)
                     sort
                     vec)]
      (println (format "%-7s" (name p)) files))))

(defn set-scenario [{:keys [opts]}]
  (file-scenario opts)
  (show-scenario {:opts opts}))

(defn help [m]
  (println "TODO help" m))

(defn exts->kws [opt]
  (let [s (str opt)]
    (mapv keyword (str/split s #","))))

(defn kw-exts? [kws]
  (every? #{:bat :com :cmd :exe :ps1 :sh} kws))

(def table
  (let [dir (-> *file* fs/canonicalize fs/parent str)]
    [{:cmds ["show"] :fn show-scenario
      :spec {:dir {:default dir}}}
     {:cmds ["set"]  :fn set-scenario
      :spec {:cwd {:coerce exts->kws :validate kw-exts?}
             :workdir {:coerce exts->kws :validate kw-exts?}
             :on-path {:coerce exts->kws :validate kw-exts?}
             :dir {:default dir}}}
     {:cmds [] :fn help}]))

(defn -main [& args]
  (cli/dispatch table args ))

(when (= *file* (System/getProperty "babashka.file"))
 (apply -main *command-line-args*))
