(define-module (p-snow packages video)
  #:use-module (guix packages)
  #:use-module (guix build-system copy)
  #:use-module (guix git-download)
  #:use-module (guix gexp)
  #:use-module (guix utils)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module ((ice-9 ftw) #:select (scandir))
  #:use-module (gnu packages video)
  #:use-module (gnu packages backup))

(define-public mpv-libarchive
  (package
    (inherit mpv)
    (name "mpv-libarchive")
    (inputs (modify-inputs (package-inputs mpv)
              (prepend libarchive)))))

;; FIXME: -c:v av1_amf does not work due to driver problem
(define-public ffmpeg-amf
  (package
    (inherit ffmpeg)
    (name "ffmpeg-amf")
    (inputs (modify-inputs (package-inputs ffmpeg)
              (prepend amf)))
    (arguments
     (append (list #:out-of-source? #t)
             (substitute-keyword-arguments (package-arguments ffmpeg)
               ((#:configure-flags flags)
                #~(cons "--enable-amf" #$flags))
               ((#:phases phases)
                #~(modify-phases #$phases
                    (add-before 'configure 'embed-amf-source
                      (lambda* (#:key outputs configure-flags #:allow-other-keys)
                        (let ((dest-dir (string-append #$output
                                                       "/usr/local/include/AMF/"))
                              (src-dir (search-input-directory
                                        %build-inputs "usr/local/include/AMF/")))
                          (define (copy-contents src dst)
                            (use-modules (ice-9 ftw))
                            (use-modules (ice-9 match))
                            (for-each
                             (lambda (entry)
                               (let ((src-path (string-append src "/" entry))
                                     (dst-path (string-append dst "/" entry)))
                                 (and (not (file-is-directory? src-path))
                                      (copy-file src-path dst-path))))
                             (scandir src)))
                          (mkdir-p (string-append dest-dir "components"))
                          (mkdir-p (string-append dest-dir "core"))
                          (copy-contents (string-append src-dir "components")
                                         (string-append dest-dir "components"))
                          (copy-contents (string-append src-dir "core")
                                         (string-append dest-dir "core")))))
                    (replace 'configure
                      ;; configure does not work followed by "SHELL=..." and
                      ;; "CONFIG_SHELL=..."; set environment variables instead
                      (lambda* (#:key outputs configure-flags #:allow-other-keys)
                        (let ((out (assoc-ref outputs "out")))
                          (substitute* "configure"
                            (("#! /bin/sh") (string-append "#!" (which "sh"))))
                          (setenv "C_INCLUDE_PATH"
                                  (string-append out "/usr/local/include:"
                                                 (getenv "C_INCLUDE_PATH")))
                          (setenv "SHELL" (which "bash"))
                          (setenv "CONFIG_SHELL" (which "bash"))
                          (apply invoke
                                 "./configure"
                                 (string-append "--prefix=" out)
                                 ;; (string-append "--incdir=" out "/usr/local/include")
                                 ;; Add $libdir to the RUNPATH of all the binaries.
                                 (string-append "--extra-ldflags=-Wl,-rpath="
                                                out "/lib")
                                 configure-flags)))))))))))

(define amf
  (package
    (name "amf")
    (version "1.4.35")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/GPUOpen-LibrariesAndSDKs/AMF.git")
                    (commit "8f5a645e89380549368eec68935b151b238aa17b")))
              (sha256
               (base32
                "1xn8yn70mwdxqya82pq984ggnw8pxr3f9kjlsffyjwasrmsjza5v"))))
    (build-system copy-build-system)
    (arguments
     (list #:install-plan #~`(("./amf/public/include/core"
                               "usr/local/include/AMF/")
                              ("./amf/public/include/components"
                               "usr/local/include/AMF/"))))
    (home-page "https://gpuopen.com/advanced-media-framework/")
    (synopsis "Optimal access to AMD GPUs for multimedia processing")
    (description "The Advanced Media Framework SDK provides developers with optimal access to AMD GPUs for multimedia processing.")
    (license license:lgpl2.1)))
