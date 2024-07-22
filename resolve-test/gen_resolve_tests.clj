(ns gen-resolve-tests
  (:require
   [babashka.fs :as fs]
   [clojure.java.io :as io]
   [clojure.pprint :as pprint]
   [clojure.string :as str]))

; given 3 directories and 5 extension variants, we have only 2^15 (or 32768) possible variations.
; I suppose I could exhaustively test all these variations, but, for now, meh, let's focus on what
; we find interesting

; I'll break up tests to match tables in README.adoc

; We'll generate:
; cmd.bat file for CMD shell
; pwr.ps1 file for PowerShell
; pb-cmd.bat file for ProcessBuilder
; pb-pwr.ps1 file for Processbuilder
; It is tempting to use bb for some of this but I'd like to keep things closer to the Windows shells


(defn echo [f s]
  (let [ext (fs/extension f)]
    (if (= "\n" s)
      (case ext
        "ps1" (spit f "echo \"\"\n" :append true)
        "bat" (spit f "echo:\n" :append true))
      (case ext
        "ps1" (spit f (str "echo '" (str/escape s {\' "''"} ) "'\n")
                    :append true)
        "bat" (spit f (str "echo " (str/replace s #"([<>|&`\"])" "^$1") "\n")
                    :append true)))))

(def all-tests
  [{:desc "How does `a` resolve from cwd?"
    :tests (->> (for [scenario [{:cwd [:bat :cmd :com :exe :ps1]}
                                {:cwd [:bat :cmd :exe :ps1]}
                                {:cwd [:bat :cmd :ps1]}
                                {:cwd [:cmd :ps1]}
                                {:cwd [:ps1]}]]
                 {:program "a" :scenario scenario})
                (into []))}
   {:desc "How does `a.<ext>` resolve from cwd?"
    :tests (->> (for [program ["a.ps1" "a.com" "a.exe" "a.bat" "a.cmd"]]
                  {:program program :scenario {:cwd [:bat :cmd :com :exe :ps1]}})
                (into []))}
   {:desc "How does `a.<ext>` resolve from cwd when also on PATH?"
    :tests (->> (for [scenario [{:cwd [:bat :cmd :com :exe :ps1]
                                 :on-path [:bat :cmd :com :exe :ps1]}
                                {:on-path [:bat :cmd :com :exe :ps1]}]
                      program ["a.ps1" "a.com" "a.exe" "a.bat" "a.cmd"]]
                  {:program program :scenario scenario})
                (into []))}
   {:desc "How does `a` resolve from cwd when also on `PATH`?"
    :tests (->> (for [scenario [{:cwd [:bat :cmd :com :exe :ps1]
                                 :on-path [:bat :cmd :com :exe :ps1]}
                                {:cwd [:bat :cmd :exe :ps1]
                                 :on-path [:bat :cmd :com :exe :ps1]}
                                {:cwd [:bat :cmd :ps1]
                                 :on-path [:bat :cmd :com :exe :ps1]}
                                {:cwd [:cmd :ps1]
                                 :on-path [:bat :cmd :com :exe :ps1]}
                                {:cwd [:ps1]
                                 :on-path [:bat :cmd :com :exe :ps1]}
                                {:cwd [:ps1]
                                 :on-path [:bat :cmd :com :exe]}
                                {:cwd [:ps1]
                                 :on-path [:bat :cmd :exe]}
                                {:cwd [:ps1]
                                 :on-path [:bat :cmd]}
                                {:cwd [:ps1]
                                 :on-path [:cmd]}
                                {:cwd [:ps1]}]]
                  {:program "a" :scenario scenario}))}
   {:desc "How does `.\\a` resolve from cwd?"
    :tests (->> (for [scenario [{:cwd [:bat :cmd :com :exe :ps1]}
                                {:cwd [:bat :cmd :com :exe]}
                                {:cwd [:bat :cmd :exe]}
                                {:cwd [:bat :cmd]}
                                {:cwd [:cmd]}]]
                  {:program ".\\a" :scenario scenario})
                (into []))}
   {:desc "How does `.\\a.<ext>` resolve from cwd?"
    :tests (->> (for [program [".\\a.ps1" ".\\a.com" ".\\a.exe" ".\\a.bat" ".\\a.cmd"]]
                  {:program program :scenario {:cwd [:bat :cmd :com :exe :ps1]}})
                (into []))}
   {:desc "We expect absolute path of `a.<ext>` to work fine, do they?"
    :tests (->> (for [dir ["cwd" "workdir" "on-path"]
                      program ["a.ps1" "a.com" "a.exe" "a.bat" "a.cmd"]]
                  {:program (-> (fs/file "scenario" dir program)
                                fs/canonicalize
                                str)
                   :scenario {:cwd     [:bat :cmd :com :exe :ps1]
                              :workdir [:bat :cmd :com :exe :ps1]
                              :on-path [:bat :cmd :com :exe :ps1]}}))}
   {:desc "How does `a` with workdir resolve from cwd, workdir, `PATH`?"
    :workdir "..\\workdir"
    :tests (->> (for [scenario [{:cwd     [:bat :cmd :com :exe :ps1]
                                 :workdir [:bat :cmd :com :exe :ps1]
                                 :on-path [:bat :cmd :com :exe :ps1]}
                                {:cwd     [:bat :cmd :com :ps1]
                                 :workdir [:bat :cmd :com :exe :ps1]
                                 :on-path [:bat :cmd :com :exe :ps1]}
                                {:cwd     [:bat :cmd :com :ps1]
                                 :workdir [:bat :cmd :com :exe :ps1]
                                 :on-path [:bat :cmd :com :ps1]}]]
                  {:program "a" :scenario scenario})
                (into []))}

   {:desc "How does `a.<ext>` with workdir resolve from cwd, workdir, `PATH``?"
    ;; this one shows some quite peculiar behaviours from ProcessBuilder
    :workdir "..\\workdir"
    :tests [{:program "a.ps1"
             :scenario {:cwd     [:bat :cmd :com :exe :ps1]
                        :workdir [:bat :cmd :com :exe :ps1]
                        :on-path [:bat :cmd :com :exe :ps1]}}
            {:program "a.ps1"
             :scenario {:cwd     [:bat :cmd :com :exe]
                        :workdir [:bat :cmd :com :exe :ps1]
                        :on-path [:bat :cmd :com :exe :ps1]}}
            {:program "a.com"
             :scenario {:cwd     [:bat :cmd :com :exe]
                        :workdir [:bat :cmd :com :exe :ps1]
                        :on-path [:bat :cmd :com :exe :ps1]} }
            {:program "a.com"
             :scenario {:cwd     [:bat :cmd :exe]
                        :workdir [:bat :cmd :com :exe :ps1]
                        :on-path [:bat :cmd :com :exe :ps1]} }
            {:program "a.exe"
             :scenario {:cwd     [:bat :cmd :exe]
                        :workdir [:bat :cmd :com :exe :ps1]
                        :on-path [:bat :cmd :com :exe :ps1]} }
            {:program "a.exe"
             :scenario {:cwd     [:bat :cmd]
                        :workdir [:bat :cmd :com :exe :ps1]
                        :on-path [:bat :cmd :com :exe :ps1]} }
            {:program "a.bat"
             :scenario {:cwd     [:bat :cmd]
                        :workdir [:bat :cmd :com :exe :ps1]
                        :on-path [:bat :cmd :com :exe :ps1]} }
            {:program "a.bat"
             :scenario {:cwd     [:bat :cmd]
                        :workdir [:cmd :com :exe :ps1]
                        :on-path [:bat :cmd :com :exe :ps1]} }
            {:program "a.cmd"
             :scenario {:cwd     [:cmd]
                        :workdir [:cmd]
                        :on-path [:cmd]}}
            {:program "a.cmd"
             :scenario {:cwd     [:cmd]
                        :on-path [:cmd]}}]}
   {:desc "How does `.\\a` with workdir resolve from cwd, workdir?"
    :workdir "..\\workdir"
    :tests (->> (for [scenario [{:cwd     [:bat :cmd :com :exe :ps1]
                                 :workdir [:bat :cmd :com :exe :ps1]
                                 :on-path [:bat :cmd :com :exe :ps1]}
                                {:cwd     [:bat :cmd :com :ps1]
                                 :workdir [:bat :cmd :com :exe :ps1]
                                 :on-path [:bat :cmd :com :exe :ps1]}]]
                  {:program ".\\a" :scenario scenario})
                (into []))}
   {:desc "How does `.\\a.<ext>` with workdir resolve from cwd, workdir?"
    ;; this one shows some quite peculiar behaviours from ProcessBuilder
    :workdir "..\\workdir"
    :tests [{:program ".\\a.ps1"
             :scenario {:cwd     [:bat :cmd :com :exe :ps1]
                        :workdir [:bat :cmd :com :exe :ps1]
                        :on-path [:bat :cmd :com :exe :ps1]}}
            {:program ".\\a.com"
             :scenario {:cwd     [:bat :cmd :com :exe :ps1]
                        :workdir [:bat :cmd :com :exe :ps1]
                        :on-path [:bat :cmd :com :exe :ps1]}}
            {:program ".\\a.exe"
             :scenario {:cwd     [:bat :cmd :com :exe :ps1]
                        :workdir [:bat :cmd :com :exe :ps1]
                        :on-path [:bat :cmd :com :exe :ps1]}}
            {:program ".\\a.bat"
             :scenario {:cwd     [:bat :cmd :com :exe :ps1]
                        :workdir [:bat :cmd :com :exe :ps1]
                        :on-path [:bat :cmd :com :exe :ps1]}}
            {:program ".\\a.bat"
             :scenario {:cwd     [:cmd :com :exe :ps1]
                        :workdir [:bat :cmd :com :exe :ps1]
                        :on-path [:bat :cmd :com :exe :ps1]}}
            {:program ".\\a.cmd"
             :scenario {:cwd     [:bat :cmd :com :exe :ps1]
                        :workdir [:bat :cmd :com :exe :ps1]
                        :on-path [:bat :cmd :com :exe :ps1]}}
            {:program ".\\a.cmd"
             :scenario {:cwd     [:bat :com :exe :ps1]
                        :workdir [:bat :cmd :com :exe :ps1]
                        :on-path [:bat :cmd :com :exe :ps1]}}]}
   {:desc "We expect absolute path of `a.<ext>` with workdir to work fine, do they?"
    :workdir "..\\workdir"
    :tests (->> (for [dir ["cwd" "workdir" "on-path"]
                      program ["a.ps1" "a.com" "a.exe" "a.bat" "a.cmd"]]
                  {:program (-> (fs/file "scenario" dir program)
                                fs/canonicalize
                                str)
                   :scenario {:cwd     [:bat :cmd :com :exe :ps1]
                              :workdir [:bat :cmd :com :exe :ps1]
                              :on-path [:bat :cmd :com :exe :ps1]}})
                (into []))}])

(defn scenario-opts [opts]
  (reduce (fn [acc [k v]]
            (str acc
                 (str " --" (name k) "=")
                 (apply str (->> v
                                 (mapv name)
                                 (str/join ",")))))
          ""
          opts))

(let [cmd "scenario/cmd.bat"
      pwr "scenario/pwr.ps1"
      pb-cmd "scenario/pb-cmd.bat"
      pb-pwr "scenario/pb-pwr.ps1"
      shell [cmd pwr]
      pb [pb-cmd pb-pwr]
      all (into [] (concat shell pb))]
  (fs/create-dirs "scenario/cwd")

  (pprint/pprint all-tests (io/writer "scenario/all-tests.edn"))

  (doseq [f [cmd pb-cmd]]
    (spit f "@echo off\nset PATH=%CD%\\on-path;%PATH%\ncd cwd\n"))
  (doseq [f [pwr pb-pwr]]
    (spit f "$env:PATH = \"$PWD\\on-path;$env:PATH\"\ncd cwd\n"))

  (doseq [{:keys [desc workdir tests]} all-tests
          :let [all (if workdir pb all)]]

    (doseq [f all]
      (echo f (str "==== " desc)))

    (doseq [{:keys [program scenario]} tests]
      (doseq [f all]
        (spit f (str "bb ..\\..\\scenario.clj set "
                     (scenario-opts scenario) "\n")
              :append true)
        (echo f (str "program: " program)))

      ;; workdir tests only apply to powerbuilder
      (when-not workdir
        ;; stinkin' windows, I'd rather not use call, but if I don't control
        ;; will not return to the parent .bat/.cmd file
        (spit cmd (str "call " program "\n") :append true)
        ;; no need to call in powershell
        (spit pwr (str program "\n") :append true))

      (doseq [f pb]
        (spit f (str "java -cp ..\\.. PBResolveTest " program
                     (when workdir
                       (str " " workdir))
                     "\n")
              :append true))
      ;; newline
      (doseq [f all]
        (echo f "\n")))))
