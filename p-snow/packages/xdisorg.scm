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
   (version "0.8.12")
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
            "06j0w9f8xv9ypaav8kkdaqs9ab6nj4x12m4x9gg6zx1hzk4v0i8c")
           ((string= display-server "gnome")
            "107pr8qfifgaz4hyh4jn4pzgflwpq0x7mc14gxs64cm31c48hd69")
           ((string= display-server "kde")
            "1w2xnfzlmihnmq2mhk4ni35l0mclgdl0wgmgs3mjp1zs4qafihn9")
           ((string= display-server "sway")
            "0xcp6mswsq17c53li63zpn22wlmi958r1dr5dd9pzpj93zpaw39q")))
         ("aarch64-linux"
          (cond
           ((string= display-server "x11")
            "1n8xqgl2czyvyjql3y09h7kx3vgfiqqgkw4ai37i40xlv5frk9zv")
           ((string= display-server "gnome")
            "072kg4lnqlsqlcfr0x9wzrlry7nm4x0zjjz0rim1n4g82vbjjxqa")
           ((string= display-server "kde")
            "14mh0wzzy438yr776bj2x6zqwfjr6js6dmspnkxv5ml4rlqy6lw4")
           ((string= display-server "sway")
            "1wb245idg08wljpra1bylcybk3v5iqfwv395wz5z378c29d343ij"))))))))
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
