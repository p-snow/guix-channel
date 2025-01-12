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
   (version "0.1.0")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/p-snow/org-web-track")
           (commit "0c328de425f6e00d86700a47e946933776af3f82")))
     (file-name (git-file-name name version))
     (sha256
      (base32
       "0svrc00p4ld5lfh6scds104rlhwr4liv3s6h7gl44653mb7ag90d"))))
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
