;;; p-snow's guix channel --- spigot package definition
;;; Copyright © 2026 p-snow
;;;
;;; This file is not part of GNU Guix.
;;;
;;; This channel is free software: you can redistribute it and/or modify it
;;; under the terms of the GNU General Public License as published by the
;;; Free Software Foundation, either version 3 of the License, or (at your
;;; option) any later version.
;;;
;;; This channel is distributed in the hope that it will be useful, but
;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;;; General Public License for more details.

(define-module (p-snow packages rust-apps)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system cargo)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages))

;; Note: The repository does not contain an explicit LICENSE file.
;; MIT license is assumed as a reasonable default for Rust projects.
;; If this is incorrect, please open an issue or submit a patch.

(define-public spigot
  (let ((commit "1d5935be661dc072b608b3ad05f57a1b8168c5b5")
        (revision "0"))
    (package
      (name "spigot")
      (version (git-version "0.1.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/p-snow/spigot.git")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "02b2ym7cg5r5zavl2bz6j45q9v04mp4x1vxjym55fj0gycisjrij"))))
      (build-system cargo-build-system)
      (arguments (list #:install-source? #f))
      (home-page "https://github.com/p-snow/spigot")
      (synopsis "A simple HTTP server connecting via Unix Socket")
      (description "Spigot is a simple Unix Domain Socket server providing an HTTP service
that interprets requests into command strings and invokes them on the machine.

It listens on @file{/tmp/machine-info.sock} for incoming HTTP requests over a Unix
socket, providing a secure and efficient way for local applications to access
system information.")
      ;; MIT license is assumed based on common Rust project conventions
      (license license:expat))))
