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
    (version "0.8.2")
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
              "065xlicmyzw5d3r1si2kh608fqxyxpi127zvl19f0cqhl28xx72j")
             ((string= display-server "gnome")
              "0wgc4bqnh7qddxvpwwy2g28wqhmx6lzf3yps0za73xk33cc5m0ak")
             ((string= display-server "sway")
              "141n38ibnf3g49n4vhsgs9rrgkg0cr7a2j8q42wikfnmiy5bbbnp")))
           ("aarch64-linux"
            (cond
             ((string= display-server "x11")
              "0kmcpvi3c9cfp33wmw43nj6njzpmn3mbb2x82xasibc6jb6s45wn")
             ((string= display-server "gnome")
              "0j7v8mbr3yhylgkjs38937fx5j0j524h9qqsx4ziaz7la76nlgxj")
             ((string= display-server "sway")
              "0drkqsk8m0vldg5r99gs4mlhxfigb5yanwnnsz2zhpslidqg9m3a"))))))))
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

(define-public xremap-sway
  (make-xremap "sway"))
