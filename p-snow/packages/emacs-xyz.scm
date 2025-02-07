(define-module (p-snow packages emacs-xyz)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system emacs)
  #:use-module (guix gexp)
  #:use-module ((guix licenses) #:prefix license:)
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
