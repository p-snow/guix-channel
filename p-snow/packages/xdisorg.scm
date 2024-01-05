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
   (version "0.8.13")
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
            "0wigwmcj99y456b43rair8dgv4500nmw1jzjq66a2ilxra1vyd5l")
           ((string= display-server "gnome")
            "0plab94kl3wr3yc38zzrghsr6rcml3z5z2c87kpgwvx5a4x9yiqp")
           ((string= display-server "kde")
            "0jvw2xq7mnk8a2mdivddlnhngc2sq0jjq3r5ppsvz124kr1nkg51")
           ((string= display-server "sway")
            "1d1kmi69881wxjw2w9dsisf0f34xcaz1if32awf6v2760g33z93c")))
         ("aarch64-linux"
          (cond
           ((string= display-server "x11")
            "0jfnag3d0rh7xwz4665hakkcjaq906i6nwa85pr9j6cqalcvl5xh")
           ((string= display-server "gnome")
            "1nvcapv08lzfdysqwfgbz9dsrmdbqa7mdqb6z7vai712wpzqrfy7")
           ((string= display-server "kde")
            "1a8i1bzvlx4dhzb4bxgqxp6xjb0lhcm59y0xa7ng6mwmiwav0ndh")
           ((string= display-server "sway")
            "1dndiva1fdr0wl4sh9bjs7mi8490h5rks0yif4q2c0cmpf84x8bm"))))))))
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
