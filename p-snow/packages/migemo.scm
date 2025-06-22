(define-module (p-snow packages migemo)
  #:use-module (guix packages)
  #:use-module ((guix licenses)
                #:prefix license:)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system gnu)
  #:use-module (guix utils)
  #:use-module (gnu packages base)
  #:use-module (gnu packages textutils)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages wget)
  #:use-module (gnu packages shells)
  #:use-module (gnu packages code)
  #:use-module (gnu packages dictionaries))

(define-public cmigemo
  (package
    (name "cmigemo")
    (version "1.3e")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/koron/cmigemo")
             (commit "9a1cec4622621e78953ffa8c55cdb561e45657ba")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1bwjf7w2f1li7q59d244q3b6xaygpaw5rwp5z0bj055qbkz22sah"))))
    (build-system gnu-build-system)
    (arguments
     `(#:phases (modify-phases %standard-phases
                  (replace 'build
                    (lambda* (#:key (make-flags '())
                              (parallel-build? #t) #:allow-other-keys)
                      (apply invoke "make" "gcc"
                             `(,@(if parallel-build?
                                     `("-j" ,(number->string (parallel-job-count)))) ,@make-flags))))
                  (add-before 'install 'pre-install
                    (lambda* (#:key outputs #:allow-other-keys)
                      (mkdir-p (string-append (assoc-ref outputs "out") "/lib"))))
                  (replace 'install
                    (lambda* (#:key outputs
                              (make-flags '()) #:allow-other-keys)
                      (apply invoke
                             "make"
                             "-f"
                             "compile/Make_gcc.mak"
                             "install-lib"
                             make-flags)
                      (install-file "src/migemo.h"
                                    (string-append (assoc-ref outputs "out")
                                                   "/include"))
                      (install-file "build/cmigemo"
                                    (string-append (assoc-ref outputs "out")
                                                   "/bin")))))
       #:tests? #f
       #:make-flags (list "INSTALL=install -c"
                          ,(string-append "CC="
                                          (cc-for-target))
                          (string-append "LDFLAGS_MIGEMO=-Wl,-rpath,"
                                         (assoc-ref %outputs "out") "/lib"))))
    (native-inputs (list which
                         nkf
                         wget
                         perl
                         tcsh
                         universal-ctags))
    (home-page "https://www.kaoriya.net/software/cmigemo/")
    (synopsis
     "An incremental regular expression generator from romaji to Japanese")
    (description
     "C/Migemo is a C language implementation of Migemo(Ruby/Migemo).
A software using this can incrementally search Japanese text with romaji.")
    (license license:expat)))

(define-public migemo-dict
  (package
    (name "migemo-dict")
    (version "1.3e")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/koron/cmigemo")
             (commit "9a1cec4622621e78953ffa8c55cdb561e45657ba")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1bwjf7w2f1li7q59d244q3b6xaygpaw5rwp5z0bj055qbkz22sah"))))
    (build-system gnu-build-system)
    (arguments
     `(#:phases (modify-phases %standard-phases
                  (replace 'build
                    (lambda* (#:key outputs inputs
                              (make-flags '())
                              (parallel-build? #t) #:allow-other-keys)
                      (system (string-append "perl tools/skk2migemo.pl < "
                                             (assoc-ref inputs "skk-jisyo")
                                             "/share/skk/SKK-JISYO.L | perl tools/optimize-dict.pl | nkf -s > dict/migemo-dict"))
                      (with-directory-excursion "dict"
                        (let ((files '("migemo-dict" "zen2han.dat"
                                       "han2zen.dat" "hira2kata.dat"
                                       "roma2hira.dat")))
                          (map (lambda (charcode)
                                 (mkdir-p (string-append charcode ".d"))
                                 (map (lambda (file)
                                        (system (string-append
                                                 "nkf --ic=CP932 --oc="
                                                 charcode
                                                 " "
                                                 file
                                                 " > "
                                                 charcode
                                                 ".d/"
                                                 file))) files))
                               '("euc-jp" "utf-8"))))))
                  (add-before 'install 'pre-install
                    (lambda* (#:key outputs #:allow-other-keys)
                      (mkdir-p (string-append (assoc-ref outputs "out")
                                              "/share/migemo"))
                      (map (lambda (arg)
                             (mkdir-p (string-append (assoc-ref outputs "out")
                                                     "/share/migemo/" arg)))
                           '("cp932" "euc-jp" "utf-8"))))
                  (replace 'install
                    (lambda* (#:key outputs
                              (make-flags '()) #:allow-other-keys)
                      (invoke "make"
                              "-f"
                              "compile/unix.mak"
                              "install-dict"
                              (string-append "dictdir="
                                             (assoc-ref outputs "out")
                                             "/share/migemo")
                              "INSTALL_DATA=install -c -m 644"))))
       #:tests? #f))
    (inputs `(("skk-jisyo" ,skk-jisyo)))
    (native-inputs (list which
                         nkf
                         wget
                         perl
                         tcsh
                         universal-ctags))
    (home-page "https://www.kaoriya.net/software/cmigemo/")
    (synopsis "Dictionary for Migemo")
    (description
     "This is dictionary for Migemo.
This dictionary is generated from SKK dictionary @code{skk-jisyo} by tool
included in @{cmigemo}.")
    (license license:expat)))
