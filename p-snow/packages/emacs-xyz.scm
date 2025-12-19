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
  #:use-module (gnu packages emacs-build)
  #:use-module (gnu packages texinfo)
  #:use-module (gnu packages curl)
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
      #:tests? #f
      #:phases #~(modify-phases %standard-phases
                   (add-after 'unpack 'build-info-manual
                     (lambda _
                       (invoke "emacs"
                               "--batch"
                               "--eval=(require 'ox-texinfo)"
                               "--eval=(find-file \"README.org\")"
                               "--eval=(org-texinfo-export-to-info)"))))))
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
      (arguments
       (list
        #:tests? #t
        #:test-command #~(list "make" "test")))
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

(define-public emacs-gptel-latest
  (let ((revision "0")
        (commit "0f65be08ead0c9bc882fad5a4dcb604448e366a6"))
    (package
      (name "emacs-gptel-latest")
      (version (git-version "0.9.9.3" revision commit))
      (source (origin
                (method git-fetch)
                (uri (git-reference
                       (url "https://github.com/karthink/gptel")
                       (commit commit)))
                (file-name (git-file-name name version))
                (sha256
                 (base32 "0vrzmxg5xaazjpagavbx297vk042qjvygy6ffbxgjvkz68j8vy7v"))))
      (build-system emacs-build-system)
      (arguments
       (list
        #:phases
        #~(modify-phases %standard-phases
            (add-after 'unpack 'use-appropriate-curl
              (lambda* (#:key inputs #:allow-other-keys)
                (emacs-substitute-variables "gptel-request.el"
                  ("gptel-use-curl" (search-input-file inputs "/bin/curl"))))))))
      (inputs (list curl))
      (propagated-inputs (list emacs-compat emacs-transient))
      (home-page "https://github.com/karthink/gptel")
      (synopsis "GPTel is a simple ChatGPT client for Emacs")
      (description
       "GPTel is a simple ChatGPT asynchronous client for Emacs with no external
dependencies.  It can interact with ChatGPT from any Emacs buffer with ChatGPT
responses encoded in Markdown or Org markup.  It supports conversations, not
just one-off queries and multiple independent sessions.  It requires an OpenAI
API key.")
      (license license:gpl3+))))

(define-public emacs-gptel-prompts-latest
  ;; No releases.
  (let ((commit "f1c29208c1f0b62918ac6682038da5db4184fc51")
        (revision "1"))
    (package
      (name "emacs-gptel-prompts-latest")
      (version (git-version "1.0" revision commit))
      (source
       (origin
         (uri (git-reference
                (url "https://github.com/jwiegley/gptel-prompts/")
                (commit commit)))
         (method git-fetch)
         (sha256
          (base32 "1bw98biq7m1xigjmgm3w7dzac99vww619d0n24rq15kcrra7sg84"))
         (file-name (git-file-name name version))))
      (build-system emacs-build-system)
      (arguments (list #:tests? #f))    ;no tests
      (propagated-inputs (list emacs-gptel-latest))
      (home-page "https://github.com/jwiegley/gptel-prompts/")
      (synopsis "Alternative Gptel directives management")
      (description
       "This package offers an advanced way to manage Gptel directives, using
files rather than customizing the variable directly.")
      (license license:gpl2+))))

(define-public emacs-ob-gptel-latest
  (let ((commit "60e704a390d767a7d06c8d3845ba8786b75f7da3")
        (revision "2"))
    (package
      (name "emacs-ob-gptel-latest")
      (version (git-version "0.1.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
                (url "https://github.com/jwiegley/ob-gptel/")
                (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32
           "0l4abglx5q8ym2ii6my58001v98jhqd0c0jpvbk4dz2i3h9rsxqv"))))
      (build-system emacs-build-system)
      (arguments (list #:tests? #f))    ;no tests
      (propagated-inputs
       (list emacs-gptel-latest))
      (home-page "https://github.com/jwiegley/ob-gptel/")
      (synopsis "Org Babel support for evaluating @code{gptel} prompts.")
      (description "@code{ob-gptel} is a backend for Org Babel.  It provides
an alternative interface to evaluate @{gptel} prompts as Org mode blocks.")
      (license license:gpl3+))))
