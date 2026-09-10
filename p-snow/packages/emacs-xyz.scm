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
  #:use-module (gnu packages rust-apps)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages base)
  #:use-module (gnu packages search)
  #:use-module (gnu packages maths))

(define-public emacs-org-web-track
  (let ((revision "0")
        (commit "2c4215499c0851e85b480bc19e96a236fb9af8f1"))
    (package
      (name "emacs-org-web-track")
      (version (git-version "0.1.1" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
                (url "https://github.com/p-snow/org-web-track.git")
                (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "1al99lixw56yg5wvg6x3rvclkvfncgs6rz6ry6iniam62pdhp80s"))))
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
      (license license:gpl3+))))

(define-public emacs-org-tag-tree
  (package
    (name "emacs-org-tag-tree")
    (version "0.1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
              (url "https://github.com/p-snow/org-tag-tree")
              (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32
         "0vq29bb6v8i4rbancp46rvg7sr2l6vllp12j9lm0ciaj9akcl279"))))
    (build-system emacs-build-system)
    (arguments
     (list
      #:tests? #t
      #:test-command #~(list "make" "test")))
    (home-page "https://github.com/p-snow/org-tag-tree")
    (synopsis "Define Org-mode tag hierarchies from Org subtrees")
    (description
     "org-tag-tree lets you describe Org tag hierarchies as ordinary Org trees.")
    (license license:gpl3+)))

(define-public emacs-ol-locate-file
  (package
    (name "emacs-ol-locate-file")
    (version "0.1.2")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
              (url "https://github.com/p-snow/ol-locate-file")
              (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1zlkixv2w3hrbw1jgd6qhfllxbkliqxhv71y8ghj63508vwr34jn"))))
    (build-system emacs-build-system)
    (arguments
     (list
      #:tests? #t
      #:test-command #~(list "make" "unit-test")))
    (home-page "https://github.com/p-snow/ol-locate-file")
    (synopsis "Locate-based Org file link with which users can abbreviate file paths.")
    (description
     "This package provides an Org link type that resolves partial file path
substrings into full paths using `locate' or a configurable search command.")
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

(define-public emacs-org-hide-drawers
  (package
    (name "emacs-org-hide-drawers")
    (version "2.0.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
              (url "https://github.com/krisbalintona/org-hide-drawers")
              (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32
         "1s1wlhbd0k10p1d93f7vi29jsm2kh2ws7bqwc9r2fjqd0hgcaz8x"))))
    (build-system emacs-build-system)
    (home-page "https://github.com/krisbalintona/org-hide-drawers")
    (synopsis "Hide drawers in org-mode with overlays")
    (description
     "Hide drawers in org-mode buffers using overlays.  These overlays replace the
visual display of drawers using their \"display\" property.")
    (license license:gpl3+)))

(define-public emacs-org-expose-emphasis-markers
  (package
    (name "emacs-org-expose-emphasis-markers")
    (version "0.2.1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
              (url "https://github.com/lorniu/org-expose-emphasis-markers")
              (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32
         "1sn90262rcrqmmwy45dz8vdd10sv7d5m2dmzz79f5lj6kh90h5zw"))))
    (build-system emacs-build-system)
    (home-page "https://github.com/lorniu/org-expose-emphasis-markers")
    (synopsis "Automatically show hidden emphasis markers at point in org mode")
    (description
     "Automatically show hidden emphasis markers at point in org mode. This is useful
for editing org file when `org-hide-emphasis-markers' is on. In org mode, hide
emphasis markers can make reading nice, but not good for editing. Here provide a
mode to let hidden markers auto expose when the cursor on, and auto hide when
cursor leave.")
    (license license:gpl3+)))

(define-public emacs-avy-migemo-workaround
  (let ((revision "0")
        (commit "922a6dd82c0bfa316b0fbb56a9d4dd4ffa5707e7"))
    (package
      (name "emacs-avy-migemo-workaround")
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
      (arguments
       '(#:exclude (cons* "^avy-migemo-e\\.g\\.[^/]*\\.el$" %default-exclude)))
      (propagated-inputs (list emacs-avy
                               (@ (guix-jp packages emacs-xyz) emacs-migemo)))
      (home-page "https://github.com/momomo5717/avy-migemo")
      (synopsis "Emacs Avy for Japanese")
      (description
       "This package enables support for Japanese when using Avy in Emacs.  Avy is a
completion method for characters, words, and similar elements based on a
balanced decision tree.  With this package, Japanese characters are added to
Avy's targets, allowing users to narrow down the decision tree using kana input.")
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

(define-public emacs-pangu-spacing
  (let ((revision "0")
        (commit "6509df9c90bbdb9321a756f7ea15bb2b60ed2530"))
    (package
      (name "emacs-pangu-spacing")
      (version (git-version "0.4" revision commit))
      (source (origin
                (method git-fetch)
                (uri (git-reference
                       (url "https://github.com/coldnew/pangu-spacing")
                       (commit commit)))
                (file-name (git-file-name name version))
                (sha256
                 (base32 "1i52qmky0azwp5pn20nh1zrikn71m95v4hgfc3l3cgq2rqkzzm8x"))))
      (propagated-inputs
       (list emacs-plz emacs-dash))
      (build-system emacs-build-system)
      (home-page "https://github.com/coldnew/pangu-spacing")
      (synopsis "Emacs minor-mode to add space between Chinese/Japanese/Korean and English characters. ")
      (description
       "pangu-spacing-mode is an minor-mode to auto add space between Chinese and
English characters. Note that these whitespace characters are not really added
to your file. It's just a local visual change.")
      (license license:gpl3+))))

(define-public emacs-tinee
  (package
    (name "emacs-tinee")
    (version "0.4.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
              (url "https://codeberg.org/tusharhero/tinee")
              (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1i6q7az7qprynkyiff64kb6k39j7az8wf9ac26f2cnyjb82wvbkd"))))
    (build-system emacs-build-system)
    (home-page "https://codeberg.org/tusharhero/tinee")
    (synopsis "This Is Not Emacs Everywhere, in the sense that it's not as featureful as Emacs-everywhere, and hence tinee.")
    (description
     "Tinee allows you to use GNU Emacs for writing anywhere on your
system. That is, compose your text from within Emacs, and automatically send it
to any text area.

The package name stands for @code{This Is Not Emacs Everywhere}, as it is not as
featureful or ambitious (in terms of supported systems) as
@code{emacs-everywhere}, but it is still good enough while being tinee.

It only supports Wayland GNU/Linux systems.")
    (license license:gpl3+)))

(define-public emacs-org-review
  ;; No releases/tags available; use latest commit.
  (let ((commit "1f24fa504d58d619bb81a2c16058f685d85c2151")
        (revision "0"))
    (package
      (name "emacs-org-review")
      (version (git-version "0.4" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
                (url "https://github.com/brabalan/org-review")
                (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "1va21vgfaxwz19qg378vbq1dnb09l9klc2x31mc0r07p14dqhfy1"))))
      (build-system emacs-build-system)
      (arguments
       (list #:tests? #f))            ; no test suite
      (home-page "https://github.com/brabalan/org-review")
      (synopsis "Schedule reviews for Org entries")
      (description
       "This package allows scheduling reviews of Org entries.  Entries
will be scheduled for review if their NEXT_REVIEW or their LAST_REVIEW
property is set.  Checking of review dates is done through an agenda
view, using the @code{org-review-agenda-skip} skipping function.
To mark an entry as reviewed, use the function
@code{org-review-insert-last-review} to set the LAST_REVIEW date to
the current date.")
      (license license:gpl3+))))

(define-public emacs-kirigami
  (package
    (name "emacs-kirigami")
    (version "1.1.5")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
              (url "https://github.com/jamescherti/kirigami.el")
              (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "03ql2x4npkw60mjvfn83gnp6dbshf6ikhj7558mwdk8qi695q2fc"))))
    (build-system emacs-build-system)
    (arguments
     (list #:tests? #f))
    (home-page "https://github.com/jamescherti/kirigami.el")
    (synopsis
     "Unified method to fold and unfold text in Emacs across many modes")
    (description
     "The kirigami Emacs package provides a unified method to fold and
unfold text in Emacs across a diverse set of major and minor modes,
including outline-mode, outline-minor-mode, org-mode, markdown-mode,
hs-minor-mode (hideshow), treesit-fold, vdiff, origami, and many more.

With Kirigami, folding key bindings only need to be configured once.
After that, the same keys work consistently across all supported modes,
providing a unified and predictable experience for opening and closing
folds.  It also fixes upstream Emacs outline bugs such as bug#79286,
and preserves cursor position and window stability during fold
operations.")
    (license license:gpl3+)))
