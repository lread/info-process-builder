;; correlate results to something readable.
;; we have out complete list of tests

(ns summarize
  (:require [babashka.fs :as fs]
            [clojure.edn :as edn]
            [clojure.string :as str]))

(defn parse-results [f encoding]
  (loop [lines (-> (slurp f :encoding encoding)
                   (str/split-lines))
         section nil
         test nil
         res []]
    (let [line (first lines)]
      (cond
        (not line)
        (if test (conj res test) res)

        ;; section title applies to subsequent tests
        (str/starts-with? line "====")
        (recur (rest lines)
               (second (re-find #"==== (.*)" line))
               nil
               (if test (conj res test) res))

        ;; start of test
        (str/starts-with? line "cwd  ")
        (recur (rest lines)
               section
               {:cwd (re-find #"\[.*\]" line) :section section}
               (if test (conj res test) res))

        ;; scenario workdir
        (str/starts-with? line "workdir [")
        (recur (rest lines)
               section
               (assoc test :workdir (re-find #"\[.*\]" line))
               res)

        ;; scenario on-path
        (str/starts-with? line "on-path [")
        (recur (rest lines)
               section
               (assoc test :on-path (re-find #"\[.*\]" line))
               res)

        ;; program we ran
        (str/starts-with? line "program: ")
        (recur (rest lines)
               section
               (assoc test :program (second (re-find #"program: (.*)" line)))
               res)

        ;; output from program
        (str/starts-with? line "exepath: ")
        (recur (rest lines)
               section
               (assoc test :program-exepath (second (re-find #"exepath: (.*)" line)))
               res)

        ;; output from program
        (str/starts-with? line "workdir: ")
        (recur (rest lines)
               section
               (assoc test :program-workdir (second (re-find #"workdir: (.*)" line)))
               res)

        (str/blank? line)
        (recur (rest lines)
               section
               test
               res)

        :else
        ;; other output from program
        (recur (rest lines)
               section
               (update test :other-output (fnil str "") (str line "\n"))
               res)))))

(defn result->scenario [t]
  (->> (reduce (fn [m k]
                 (if (k t)
                   (assoc m k (->> t k edn/read-string (mapv keyword)))
                   m))
               {}
               [:cwd :workdir :on-path])
       (reduce-kv (fn [m k v]
                    (if (seq v)
                      (assoc m k v)
                      m))
                  {})))

(defn abridgements [res]
  (->> res
       (mapv (fn [{:keys [program-exepath program-workdir other-output cwd workdir on-path program] :as t}]
               (cond-> (assoc t :scenario (result->scenario t))

                 program-exepath
                 ;; would use babashka fs but I'm sometimes processing windows paths on linux and don't
                 ;; want to veer too far from windows syntax
                 (assoc :program-exepath-abridged
                        (second (re-find #".*\\([^\\]+\\[^\\]+)$" program-exepath)))

                 program-workdir
                 (assoc :program-workdir-abridged (second (re-find #".*\\([^\\]+)$" program-workdir)))

                 other-output
                 (as-> t
                     (cond
                       (str/includes? other-output "fake-notepad.exe")
                       (assoc t :other-output-abridged (format "<opened notepad with %s>"
                                                               (second (re-find  #".*\\scenario\\([^\\]+\\[^\\]+)]" other-output))))

                       (or (str/includes? other-output "not recognized as an internal or external command")
                           (str/includes? other-output "CommandNotFoundException")
                           (str/includes? other-output "CreateProcess error=2, The system cannot find the file specified"))
                       (assoc t :other-output-abridged "<not found>")

                       (str/includes? other-output "is not a valid Win32 application")
                       (assoc t :other-output-abridged "<not a valid Win32 application>")

                       :else
                       t)))))))

(defn section [res]
  (group-by :section res))

(defn res-indexed [res]
  (reduce (fn [acc n]
            (assoc acc (select-keys n [:section :scenario :program ])
                    n))
          {}
          res))

(defn amalg [res-cmd res-pwr res-pb]
  (let [all-tests (-> "scenario/all-tests.edn" slurp edn/read-string)]
    (for [{:keys [desc tests workdir]} all-tests
          {:keys [program scenario]} tests]
      (let [lookup {:section desc :scenario scenario :program program }
            res-cmd-ndxed (res-indexed res-cmd)
            res-pwr-ndxed (res-indexed res-pwr)
            res-pb-ndxed (res-indexed res-pb)]
        (cond-> lookup
          workdir
          (assoc :scenario-workdir workdir)

          (get res-cmd-ndxed lookup)
          (assoc :cmd-shell-res (get res-cmd-ndxed lookup))

          (get res-pwr-ndxed lookup)
          (assoc :pwr-shell-res (get res-pwr-ndxed lookup))

          (get res-pb-ndxed lookup)
          (assoc :pb-res (get res-pb-ndxed lookup)))))))

(defn scenario->result [t k]
  (if-not (-> t :scenario k)
    []
    (->> t :scenario k (mapv symbol))))

(defn adoc-res-cell [res k]
  (if-let [res (k res)]
    (if (:other-output-abridged res)
      [(format "a|%s" (:other-output-abridged res))]
      ["a|[.nowrap]"
       "----"
       (:program-exepath-abridged res)
       (:program-workdir-abridged res)
       "----"])
    ["a|TODO..."]))

(defn program-abridged [program]
  (if (re-find #"^[A-Z]:\\" program)
    ;; abbreviate absolute paths to ex. Z:\\...\\cmd\a.exe
    (str/replace program
                 #"^([A-Z]:\\).*\\([^\\]+\\[^\\]+)$" "$1...\\\\$2")
    program))

(comment
  (program-abridged "Z:\\foo\\bar\\laasdafd\\bingo\\a.com")
  ;; => "Z:\\...\\bingo\\a.com"

  )

(defn to-adoc-lines [res]
  (->> res
       (partition-by :section)
       (reduce (fn [acc section-tests]
                 (let [header (-> section-tests first :section)
                       scenario-workdir (-> section-tests first :scenario-workdir)
                       adoc-header [(str "==== " header)]
                       adoc-table-heading ["|==="
                                           (if scenario-workdir
                                             "| | Scenario | ProcessBuilder"
                                             "| | Scenario | Cmd Shell | PowerShell | ProcessBuilder")]
                       adoc-table-body (reduce (fn [acc n]
                                                 (let [program-cell [(format "a|[.nowrap]#`+%s+`#"
                                                                             (program-abridged (:program n)))]
                                                       scenario-cell ["a|[.nowrap]"
                                                                      "----"
                                                                      (format "cwd:     %s" (scenario->result n :cwd))
                                                                      (format "workdir: %s" (scenario->result n :workdir))
                                                                      (format "on-path: %s" (scenario->result n :on-path))
                                                                      "----"]
                                                       cmd-cell (when-not scenario-workdir (adoc-res-cell n :cmd-shell-res))
                                                       pwr-cell (when-not scenario-workdir (adoc-res-cell n :pwr-shell-res))
                                                       pb-cell (adoc-res-cell n :pb-res)]
                                                   (concat
                                                     acc
                                                     [""]
                                                     program-cell
                                                     scenario-cell
                                                     (when-not scenario-workdir cmd-cell)
                                                     (when-not scenario-workdir pwr-cell)
                                                     pb-cell)))
                                               []
                                               section-tests)
                       adoc-table-footer ["|==="]]
                   (concat acc
                           adoc-header
                           [""]
                           adoc-table-heading
                           adoc-table-body
                           adoc-table-footer
                           [""])))
               [])))

(let [res-cmd (-> (parse-results "results/cmd-res.out" "ASCII") abridgements)
      res-pwr (-> (parse-results "results/pwr-res.out" "UTF-16") abridgements)
      ;; since all pb files are equivalent, we'll grab output from 1 of them
      res-pb (-> (parse-results "results/pb-cmd-jdk-21.0.3-res.out" "ASCII") abridgements)
      amalg (amalg res-cmd res-pwr res-pb)
      adoc-lines (to-adoc-lines amalg)]
  (spit "results/summary.adoc" (str/join "\n" adoc-lines)))

(comment
  (let [res-cmd (-> (parse-results "results/cmd-res.out" "ASCII") abridgements)
      res-pwr (-> (parse-results "results/pwr-res.out" "UTF-16") abridgements)
      res-pb (-> (parse-results "results/pb-cmd-jdk-21.0.3-res.out" "ASCII") abridgements)
      amalg (amalg res-cmd res-pwr res-pb)]
    amalg)

  :eoc)
