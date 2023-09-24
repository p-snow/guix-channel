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
    (version "0.8.9")
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
              "0pnqnsrmidr19f4h00ag8cgf3bipd0jj0ysrkjy0fxf9mcw4p125")
             ((string= display-server "gnome")
              "17kkwaskpb4csddaz6484c3zdy13giyah0c95lhxjzb7a21xbw5q")
             ((string= display-server "kde")
              "1mxz9pgyffjr0y886pifknijw7rq2fjhqbsga68360xwxp3rpayr")
             ((string= display-server "sway")
              "1mz5anzwc1rzqa36kvnzd76rh1azfn4yzwdk93s48vh3pjnddzgh")))
           ("aarch64-linux"
            (cond
             ((string= display-server "x11")
              "1vpqalsijaifdwyx7v8kwrn1v5zhc99qynp83fvik9jprdxxa1iw")
             ((string= display-server "gnome")
              "1xvz0l0ckniw4gpbmk5knqnpqjgxw62z1vh02lwvn3bl5bkpj63l")
             ((string= display-server "kde")
              "0fxj9ac4rlbdc8cpr92sa5v114x8544hc6yxaz18sxn6wv153ky3")
             ((string= display-server "sway")
              "1ws69ziiz919apxyq2kr20p2y3cfmkm0y5v8za3rqc97by8vakc1"))))))))
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
