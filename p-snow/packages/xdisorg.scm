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
    (version "0.8.11")
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
              "0i0lmyy2x2y83x0w4s38adv8h0b59gvgfppzgj8lki5rgzyw76vm")
             ((string= display-server "gnome")
              "1dp4jcw45awzfw0sghh39zhh41s2q48pwcmqypg1bv61mmlmp0ha")
             ((string= display-server "kde")
              "1saa80xv9z9ip88g2b1v5j6ysak12nsxmwmg79nnkv2hh1wwki1p")
             ((string= display-server "sway")
              "0rw47nhbj50479v14hhm9bn4l5dg44j3jkj6wwlbz5wz9as2kfy2")))
           ("aarch64-linux"
            (cond
             ((string= display-server "x11")
              "02dppcpqrxr8d2wdr1b3ipil7vsc1vs1bmiw3pm7h9a1m4rxv181")
             ((string= display-server "gnome")
              "128giq0zcyrm2g6invj0xh8fj9np28mxiimm8cgdq2hcsd5bd7z1")
             ((string= display-server "kde")
              "1bbqrz7xmps86irw0gaplyvhn3zzmv97pw6nw65ybg162dqsx2qk")
             ((string= display-server "sway")
              "1pb0ssvnf3vpwslv5scq9rkb4kzn8cabayakmwvrqg7yjfagb4xm"))))))))
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
