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

(define-public emacs-migemo
  (let ((revision "0")
        (commit "7d78901773da3b503e5c0d5fa14a53ad6060c97f"))
    (package
      (name "emacs-migemo")
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
                   (search-input-directory inputs "/share/migemo/utf-8"))))))))
      (inputs
       (list cmigemo migemo-dict))
      (home-page "http://0xcc.net/migemo/")
      (synopsis "Japanese incremental search in Emacs")
      (description
       "This package enables incremental search of Japanese text using the Roman
alphabet (romaji) in Emacs. It is an Emacs plugin for Migemo, a backend program
that allows various editors to offer this functionality.")
      (license license:gpl2+))))
