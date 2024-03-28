(define-module (p-snow packages xdisorg)
  #:use-module (gnu packages compression)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system copy)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (ice-9 match))

(define (make-xremap display-server)
  ;; Return a xremap package built for DISPLAY-SERVER.
  (package
   (name (string-append "xremap-" display-server))
   (version "0.8.18")
   (source
    (origin
     (method url-fetch)
     (uri (string-append "https://github.com/k0kubun/xremap/releases/download/v"
                         version "/xremap-"
                         (match (%current-system)
                           ("x86_64-linux" "linux-x86_64")
                           ("aarch64-linux" "linux-aarch64"))
                         "-" display-server ".zip"))
     (sha256
      (base32
       (match (%current-system)
         ("x86_64-linux"
          (cond
           ((string= display-server "x11")
            "1v3n146nr72ppdk4jdb3j0s428mfhmn6ij615cb09zi8y723m632")
           ((string= display-server "gnome")
            "13jjd7xw2ng1w9w7rywdxi66q56gmrd28c23ix764pd53vw47dyg")
           ((string= display-server "kde")
            "13hyshaxy4qjck2z76hmxvm8m3p73k7hbsxfgs15c3asxdh63b8m")
           ((string= display-server "sway")
            "03ylnxlrnx9n07g85w22qn9b71xjnwiy2rxcnlyinx734qx8kbf7")))
         ("aarch64-linux"
          (cond
           ((string= display-server "x11")
            "0l4sxvp1m60y1y382dmafsnswrrjq7irknqj6clasd9rzinfakpa")
           ((string= display-server "gnome")
            "15czk35k2c4f116w8vz3d67c86882hbq8jddg6vdwnvz9cfbmg5q")
           ((string= display-server "kde")
            "1c662dk2lgqglalnz4vl37xdmk96h7y8sc7nbhqd8vw7g2azpkrx")
           ((string= display-server "sway")
            "1wlpmyialpc5zf74df0yigsqv10yclhj610q3sb75rqqfqkcplnp"))))))))
   (build-system copy-build-system)
   (arguments
    (list #:install-plan ''(("xremap" "bin/"))))
   (native-inputs
    (list unzip))
   (synopsis "Key remapper for X11 and Wayland.")
   (description "Xremap is a key remapper for Linux. Unlike xmodmap,
it supports app-specific remapping and Wayland.")
   (home-page "https://github.com/k0kubun/xremap")
   (license license:expat)))

(define-public xremap-x11
  (make-xremap "x11"))

(define-public xremap-gnome
  (make-xremap "gnome"))

(define-public xremap-kde
  (make-xremap "kde"))

(define-public xremap-sway
  (make-xremap "sway"))
