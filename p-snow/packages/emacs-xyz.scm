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
  #:use-module (gnu packages image-processing)
  #:use-module (gnu packages video)
  #:use-module (gnu packages maths))

(define-public emacs-org-web-track
  (package
    (name "emacs-org-web-track")
    (version "0.1.1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/p-snow/org-web-track.git")
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

(define-public emacs-org-clock-convenience
  (let ((revision "0")
        (commit "5a9e32af581ecca0359de1815e3d37b563f9f8b2"))
    (package
      (name "emacs-org-clock-convenience")
      (version (git-version "1.3" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/dfeich/org-clock-convenience.git")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "1yhzmbflaw1gkg37i0ri6fxidqrkggfkl8mk5bq1s5xfd1jpp971"))))
      (build-system emacs-build-system)
      (arguments
       (list
        #:tests? #t
        #:test-command #~(list "make" "test")))
      (home-page "https://github.com/dfeich/org-clock-convenience")
      (synopsis "Convenience functions for org time")
      (description
       "Convenience functions for easier time tracking. Provides commands for changing
timestamps directly from the agenda view.")
      (license license:gpl3+))))

(define-public emacs-org-tidy
  (let ((revision "0")
        (commit "0bea3a2ceaa999e0ad195ba525c5c1dcf5fba43b"))
    (package
      (name "emacs-org-tidy")
      (version (git-version "0.1" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/jxq0/org-tidy.git")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "1rwq53j31vixyhsi7khb1xc0fcqdmqyp7ycq5hinligfxk87sr4s"))))
      (propagated-inputs (list emacs-dash))
      (build-system emacs-build-system)
      (home-page "https://github.com/jxq0/org-tidy")
      (synopsis "A minor mode to tidy org-mode buffers")
      (description
       "A minor mode to tidy org-mode buffers.")
      (license license:gpl3+))))

(define-public emacs-whole-line-or-region
  (let ((revision "0")
        (commit "052676394c675303d6b953209e5d2ef090fbc45d"))
    (package
      (name "emacs-whole-line-or-region")
      (version (git-version "2.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/purcell/whole-line-or-region.git")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "036x6nzij6h7s8ad89clx58hdkcw6kh31blhksdarwl7ssmi2ajg"))))
      (build-system emacs-build-system)
      (home-page "https://github.com/purcell/whole-line-or-region")
      (synopsis "Operate on current line if region undefined")
      (description
       "This minor mode allows functions to operate on the current line if they would
normally operate on a region and region is currently undefined.")
      (license license:gpl3+))))

(define-public emacs-define-word
  (let ((revision "0")
        (commit "31a8c67405afa99d0e25e7c86a4ee7ef84a808fe"))
    (package
      (name "emacs-define-word")
      (version (git-version "0.1.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/abo-abo/define-word.git")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "0h3dasg81f1b08xvz38nyd887pdlv60kj8q50kk2aqlpkr8j0y18"))))
      (build-system emacs-build-system)
      (home-page "https://github.com/abo-abo/define-word")
      (synopsis "Display the definition of word at point")
      (description
       "This package will send an anonymous request to https://wordnik.com/ to get the
definition of word or phrase at point, parse the resulting HTML page, and
display it with `message'.")
      (license license:gpl3+))))

(define-public emacs-jaword
  (let ((revision "0")
        (commit "783544a265f91b2e568b52311afb36e3691d5ad3"))
    (package
      (name "emacs-jaword")
      (version (git-version "1.0.1" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/zk-phi/jaword.git")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "09gn08c9wz60jc8jh5y3bv7qymp0ciz62bk5sjwkwgnq5mkpsf49"))))
      (build-system emacs-build-system)
      (propagated-inputs (list emacs-tinysegmenter))
      (home-page "http://zk-phi.github.io/")
      (synopsis "Minor-mode for handling Japanese words")
      (description
       "This script provides a minor-mode that improves backward/forward-word behavior
for Japanese words.")
      (license license:gpl3+))))

(define-public emacs-try
  (let ((revision "0")
        (commit "8831ded1784df43a2bd56c25ad3d0650cdb9df1d"))
    (package
      (name "emacs-try")
      (version (git-version "0.0.1" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/larstvei/Try.git")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "0y26ybdsljph49w2834wssxgdx8ij7b6v4gp8jpgnbx118gr4jsz"))))
      (build-system emacs-build-system)
      (home-page "https://github.com/larstvei/try")
      (synopsis "Try out Emacs packages")
      (description
       "Try is a package that allows you to try out Emacs packages without installing
them. If you pass a URL to a plain text `.el`-file it evaluates the content,
without storing the file.")
      (license license:gpl3+))))

(define-public emacs-dicom
  (package
    (name "emacs-dicom")
    (version "0.5")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/minad/dicom.git")
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32
         "02n5wagcznl5fhyfh222kklj4z90pfrqpzm7q97agyx8bynzwr2p"))))
    (build-system emacs-build-system)
    (propagated-inputs (list emacs-compat))
    (inputs (list dcmtk ffmpeg mpv))
    (home-page "https://github.com/minad/dicom")
    (synopsis "Emacs DICOM viewer")
    (description
     "This package enables the viewing of DICOM files, which stands for Digital
Imaging and Communications in Medicine, within Emacs. The images and metadata
are displayed in regular Emacs buffers.")
    (license license:gpl3+)))

(define-public emacs-japanese-holidays
  (let ((revision "0")
        (commit "324b6bf2f55ec050bef49e001caedaabaf4fa35d"))
    (package
      (name "emacs-japanese-holidays")
      (version (git-version "1.190317" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/emacs-jp/japanese-holidays")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "1bxbxczsf0b7jiim2anjh16h243khyrcv4k07qg0yy8c9zrl18aq"))))
      (build-system emacs-build-system)
      (arguments
       (list
        #:tests? #t
        #:test-command #~(list "make" "test")))
      (home-page "https://github.com/emacs-jp/japanese-holidays")
      (synopsis "Japanese holidays for Emacs calendar")
      (description
       "This package defines Japanese holidays for Emacs calendar and provides
highlighting capabilities for holidays and weekends.")
      (license license:gpl2+))))
