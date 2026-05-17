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

(define-public emacs-whole-line-or-region
  (let ((revision "0")
        (commit "e854a446d36bf0af54b13730ceaaf0c75e636662"))
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
          (base32 "1gphhl8l0hl7wsxih59bbc4a3p5wridhwcqp7lnc9bs89xhb2z6j"))))
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

(define-public emacs-minuet-latest
  (let ((revision "0")
        (commit "cf31d5f31f271d9b97352146fc614e9475a4726d"))
    (package
      (name "emacs-minuet-latest")
      (version (git-version "0.7.1" revision commit))
      (source (origin
                (method git-fetch)
                (uri (git-reference
                       (url "https://github.com/milanglacier/minuet-ai.el")
                       (commit commit)))
                (file-name (git-file-name name version))
                (sha256
                 (base32
                  "1amkrhaab24z2v9mgqywx1rnwdxa7i1j42phs78al3dgykpk81g8"))))
      (propagated-inputs
       (list emacs-plz emacs-dash))
      (build-system emacs-build-system)
      (home-page "https://github.com/milanglacier/minuet-ai.el")
      (synopsis "AI-powered code completion for Emacs using multiple LLM backends")
      (description
       "Minuet is an Emacs package that provides AI-powered code completion and
 suggestions.  It supports various Large Language Model (LLM) backends,
 including OpenAI, Anthropic, Gemini, and local providers via Ollama or
 llama.cpp.  Minuet features configurable inline completion, similar to GitHub
 Copilot, and can be integrated with existing Emacs completion frameworks.")
      (license license:gpl3+))))

(define-public emacs-gptel-latest
  (let ((revision "0")
        (commit "675a19aa68df693fa26070bf19b5d6fd53f2990f"))
    (package
      (name "emacs-gptel-latest")
      (version (git-version "0.9.9.5" revision commit))
      (source (origin
                (method git-fetch)
                (uri (git-reference
                       (url "https://github.com/karthink/gptel")
                       (commit commit)))
                (file-name (git-file-name name version))
                (sha256
                 (base32 "0kvz6wln41k22kjrcs2hp3n5yghy0yfda9rg68yzhdnrgmzk7il9"))))
      (build-system emacs-build-system)
      (arguments
       (list
        #:test-command #~(list "make" "-C" "test" "test")
        #:phases
        #~(modify-phases %standard-phases
            (add-after 'unpack 'unpack-tests
              (lambda _
                (copy-recursively
                 #$(this-package-native-input "emacs-gptel-test-files")
                 "test")))
            ;; gptel-pkg.el produces an error during the check phase.
            (add-before 'check 'rename-pkg
              (lambda _ (rename-file "gptel-pkg.el" "gptel-pkg.el_")))
            (add-after 'check 'rename-pkg-back
              (lambda _ (rename-file "gptel-pkg.el_" "gptel-pkg.el")))
            (add-after 'unpack 'use-appropriate-curl
              (lambda* (#:key inputs #:allow-other-keys)
                ;; These two alternatives error on the substitution.
                (emacs-substitute-variables "gptel-request.el"
                  ("gptel-use-curl"
                   (search-input-file inputs "/bin/curl"))))))))
      (inputs (list curl))
      (propagated-inputs (list emacs-compat emacs-transient))
      (native-inputs
       (list
        (origin
          (method git-fetch)
          (uri (git-reference
                 (url "https://github.com/karthink/gptel-test")
                 (commit "c62e2f78d843f3454e068eb7ec6bb8d6001b0649")))
          (file-name "emacs-gptel-test-files")
          (sha256
           (base32
            "1xixi1fa2iwixi6f0wdva2pyisxb8myljwbx2v5nxd3v0i3fbgq9")))))
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
  (let ((commit "7ce497590b006bb4b167abcdcbf2f069d9d72549")
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
          (base32 "0jqxpc93bdbfq8agq8jfkkkgjj9asir8szhzhxzc58xq2ycc0qn0"))
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
  (let ((commit "cbed018a7d81de9ba8dc3220e1c4d10b7bb29b11")
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
          (base32 "08ybvkzqpmb40kjd8apcp4yzjaf5350wjw7bzrcxbmdnlnxv6wcr"))))
      (build-system emacs-build-system)
      (arguments (list #:tests? #f))    ;no tests
      (propagated-inputs
       (list emacs-gptel-latest))
      (home-page "https://github.com/jwiegley/ob-gptel/")
      (synopsis "Org Babel support for evaluating @code{gptel} prompts.")
      (description "@code{ob-gptel} is a backend for Org Babel.  It provides
an alternative interface to evaluate @{gptel} prompts as Org mode blocks.")
      (license license:gpl3+))))

(define-public emacs-gptel-agent-latest
  (let ((commit "e2ef97d6b566b2ad751c8a0a87b8272710c95808")
        (revision "0"))
    (package
      (name "emacs-gptel-agent-latest")
      (version (git-version "20251210.453" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
                (url "https://github.com/karthink/gptel-agent")
                (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "0k88fav640ckjjv269zx6zlhjghr551bcamx7argvs8i5ca7r9jx"))))
      (build-system emacs-build-system)
      (arguments
       (list
        #:include #~(cons "^agents\\/" %default-include)))
      (propagated-inputs
       (list emacs-compat
             emacs-gptel-latest
             emacs-yaml
             emacs-orderless))
      (inputs
       (list ripgrep
             tree
             patch))
      (home-page "https://github.com/karthink/gptel-agent")
      (synopsis "Agentic LLM use for gptel")
      (description
       "gptel-agent is a collection of tools and prompts to use gptel agentically
with any LLM, to autonomously perform tasks.  It has access to the web, local
files, Emacs state, and Bash.")
      (license license:gpl3+))))
