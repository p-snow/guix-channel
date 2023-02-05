(define-module (p-snow packages migemo)
  #:use-module (guix packages)
  #:use-module (guix-jp packages migemo)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix gexp))

(define-public migemo-dict-azik
  (package
    (inherit migemo-dict)
    (name "migemo-dict-azik")
    (version "1.3e")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/p-snow/cmigemo")
                    (commit "7805f90a0852ff067ac2bd5bf59b351d7e74e068")))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "0jhjb871r3dwp3gwwvcb6znm1r0ifnlc10x5h1289xw65pdv7ynz"))))
    (synopsis "AZIK-compliant dictionary for Migemo")
    (description
     "A set of resources including a dictionary for Migemo.
Unlike @code{migemo-dict}, this package aims to support for AZIK romaji input style.")))
