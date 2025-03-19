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
