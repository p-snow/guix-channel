(define-module (p-snow packages video)
  #:use-module (guix packages)
  #:use-module (gnu packages video)
  #:use-module (gnu packages backup))

(define-public mpv-libarchive
  (package
   (inherit mpv)
   (name "mpv-libarchive")
   (inputs (modify-inputs (package-inputs mpv)
                          (prepend libarchive)))))
