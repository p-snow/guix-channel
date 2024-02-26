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
   (version "0.8.14")
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
            "14bldm35rvcbvxyciw550fdbv24kn44qdabzw795kp7xsgaha7x7")
           ((string= display-server "gnome")
            "0b69nbfn0vx45k9xqbw06msgbj343bmxk4vkr1ps8v1f6lrv9fqw")
           ((string= display-server "kde")
            "18g1fvklfczg027mxy60j83pkln38sf4dmx34w07j9jxc257ksvv")
           ((string= display-server "sway")
            "1j1rza8nws0gqbp15ldxc9d4111iiwpjp678ifshz1wnnjqbyykm")))
         ("aarch64-linux"
          (cond
           ((string= display-server "x11")
            "03kpwl5632qkhsqgvyc7crias7jaz994r3dslpfq7vps2bmzzkig")
           ((string= display-server "gnome")
            "1bsw75q8zw7zkvq5bcf6g9zcar9c104pcd9zprzm6sl6vxckn6q1")
           ((string= display-server "kde")
            "17pjrggg5g7837cxfmxarmrj415k012hm7gi76rgiiirr1sgb851")
           ((string= display-server "sway")
            "120yrbnln3yjr2gvrjh8la24x9bgjjm2jd4xqx4l0lkzp2glvflm"))))))))
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
