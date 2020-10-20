(require '[clojure.string :as string])
(import '[java.lang ProcessBuilder])

(defn get-os []
  (let [os-name (string/lower-case (System/getProperty "os.name"))]
    (condp #(re-find %1 %2) os-name
      #"win" :win
      #"mac" :mac
      #"(nix|nux|aix)" :unix
      #"sunos" :solaris
      :unknown)))

(defn exe-fname []
  (str "exe-test" (when (= :win (get-os)) ".exe")) )

(def arg-lists
  [{:description "plain and simple"
    :args ["a" "b" "c" "d"]}
   {:description "args with spaces"
    :args ["a b c" "d e"]}
   {:description "args with leading and trailing spaces"
    :args ["  a b c  " "  d e  "]}
   {:description "embedded single quote"
    :args ["single ' quote"]}
   {:description "embedded single quoteses"
    :args ["single '' quotes"]}
   {:description "embedded double quote"
    :args ["double \" quote"]}
   {:description "embedded double quoteses"
    :args ["double \"\" quotes"]}
   {:description "trailing double quotes"
    :args ["trailing double \"quotes\""]}
   {:description "dos batch characters"
    :args ["%notavar%"
           "%1"
           "> nottofile"
           ">> notconcat"
           "< notfromfile"
           "| nottopipe"
           "& notanothercommand"
           "^not-escaped"]}
   {:description "empty arg"
    :args ["empty->" "" "<-empty"]}
   {:description "edn arg"
    :args ["{:deps {clj-kondo/clj-kondo {:mvn/version \"RELEASE\"}}}"]}
   {:description "nested strings with carets"
    :args ["\"^src\" \"^test\" \"^script\""]}
   {:description "edn with carets are special"
    :args ["{:output {:include-files [\"^src\" \"^test\" \"^script\"]}}"]}])

(defn win-pshell-escape [args]
  (map (fn [a]
         (str "'" (-> a
                      (.replace "\"" "\"\"\"")
                      (.replace "'" "''"))
              "'"))
        args))

;; this is not correct yet
(defn win-batch-escape [args]
  (map (fn [a]
         (str "\""
              (-> a
                  (string/replace "^" "^^")
                  (string/replace "\"" "^\""))
              "\""))
       args))

(comment
  (string/replace ">^" #"([>^])" "^$1"))

(defn win-exe-escape [args]
  (map (fn [a]
         (str "\""
              (.replace a "\"" "\\\"")
              "\""))
       args))

(def launchers
  [{:oses #{:win}
    :description "PowerShell script"
    :test-via ["powershell" ".\\ps-test.ps1"]
    :escape-fn win-pshell-escape}
   {:oses #{:win}
    :description "Windows command script"
    :test-via ["cmd-test.cmd"]
    :escape-fn win-batch-escape}
   {:oses #{:win}
    :description "MSDOS batch file"
    :test-via ["bat-test.bat"]
    :escape-fn win-batch-escape}
   {:oses #{:win}
    :description "Native executable"
    :test-via ["exe-test"]
    :escape-fn win-exe-escape}
   {:oses #{:linux :mac}
    :description "Native executable"
    :test-via ["./exe-test"]}
   {:oses #{:linux :mac}
    :description "Bash script"
    :test-via ["./sh-test.sh"]}])

(defn args-escaped [launcher args]
  (if-let [efn (:escape-fn launcher)]
    (efn (:args args))
    (:args args)))

(defn process [args]
  (let [p (ProcessBuilder. args)]
    (-> p (.inheritIO) (.start) (.waitFor))))

(defn print-args [args]
  (doseq [[a ndx] (zipmap args (range))]
    (println (str "arg" ndx ":") a)))

(defn main[]
  (println "creating native executable")
  (process ["gcc" "exe-test.c" "-o" (exe-fname)])
  (doseq [args arg-lists]
    (println (apply str (repeat 80 "-")))
    (println "args description:" (:description args) )
    (print-args (:args args))

    (doseq [l launchers]
      (when ((:oses l) (get-os))
        (println "\ntesting:" (:description l))
        (println "via: " (:test-via l))
        (let [args (args-escaped l args)]
          (print-args args)
          (println "\nOUTPUT:")
          (process (concat (:test-via l) args)))
        (println "----")))))

(main)
