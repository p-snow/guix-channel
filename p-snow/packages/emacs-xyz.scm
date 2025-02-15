(define-module (p-snow packages emacs-xyz)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system emacs)
  #:use-module (guix gexp)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix-jp packages emacs-xyz)
  #:use-module (guix-jp packages migemo)
  #:use-module (gnu packages)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages emacs-xyz)
  #:use-module (gnu packages texinfo)
  #:use-module (gnu packages maths))

(define-public emacs-org-web-track
  (package
    (name "emacs-org-web-track")
    (version "0.1.1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/p-snow/org-web-track")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32
         "0ski1bvmxvjr2kf819hjr0lgx1q5y48g4g21mm0wmjcqjngfsh1r"))))
    (build-system emacs-build-system)
    (propagated-inputs
     (list emacs-request
           emacs-enlive
           emacs-gnuplot))
    (native-inputs (list texinfo))
    (inputs (list gnuplot))
    (arguments
     (list
      #:phases #~(modify-phases %standard-phases
                   (add-after 'unpack 'build-info-manual
                     (lambda _
                       (import (guix build utils))
                       (invoke (string-append #$emacs "/bin/emacs")
                               "README.org"
                               "--batch"
                               "-f"
                               "org-texinfo-export-to-info"
                               "--kill") #t)))))
    (home-page "https://github.com/p-snow/org-web-track")
    (synopsis "Web data tracking framework in Org Mode")
    (description
     "A framework in Org Mode to assist users in managing data that changes over time
from web pages and web APIs.")
    (license license:gpl3+)))

(define-public emacs-org-drill-head
  (package
    (inherit emacs-org-drill)
    (name "emacs-org-drill-head")
    (version "2.7.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://gitlab.com/phillord/org-drill")
             (commit "bf8fe812d44a3ce3e84361fb39b8ef28ca10fd0c")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "079x6rcz50rpw0vdq5q2kjpixz95k9f3j9dwk91r5111vvr428w3"))))))

(define-public emacs-migemo-draft
  (let ((revision "0")
        (commit "7d78901773da3b503e5c0d5fa14a53ad6060c97f"))
    (package
      (name "emacs-migemo-draft")
      (version (git-version "1.9.2" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/emacs-jp/migemo")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "1098lf50fcm25wb41g1b27wg8hc3g2w6cgjq02sc8pq6qnrr0ql2"))))
      (build-system emacs-build-system)
      (arguments
       (list
        #:tests? #f
        #:phases
        #~(modify-phases %standard-phases
            (add-after 'unpack 'patch-migemo-directory
              (lambda* (#:key inputs #:allow-other-keys)
                (emacs-substitute-variables "migemo.el"
                  ("migemo-directory"
                   (search-input-directory inputs "share/migemo/utf-8"))
                  ("migemo-command"
                   (search-input-file inputs "bin/cmigemo"))))))))
      (inputs (list cmigemo migemo-dict))
      (home-page "http://0xcc.net/migemo/")
      (synopsis "Japanese incremental search in Emacs")
      (description
       "@code{emacs-migemo} enables incremental search of Japanese text using Romaji in
Emacs.  It serves as an Emacs plugin for @code{migemo}, which is a backend
program that allows various editors to offer this functionality.")
      (license license:gpl2+))))

(define-public emacs-avy-migemo-draft
  (let ((revision "0")
        (commit "922a6dd82c0bfa316b0fbb56a9d4dd4ffa5707e7"))
    (package
      (name "emacs-avy-migemo-draft")
      (version (git-version "0.3.2" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/momomo5717/avy-migemo")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "1a4421h15ba7lsnbh8kqm3hvs06fp830wb1nvwgpsk7vmqqi2qgl"))))
      (build-system emacs-build-system)
      (propagated-inputs (list emacs-avy emacs-migemo))
      (home-page "https://github.com/momomo5717/avy-migemo")
      (synopsis "Emacs avy for Japanese")
      (description
       "This package enables support for Japanese when using avy in Emacs.  Avy is a
completion method for characters, words, and the like based on a balanced
decision tree.  With this package, Japanese characters are added to avy's
targets.  Users can narrow down the decision tree using kana input.")
      (license license:gpl3+))))
