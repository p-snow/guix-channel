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
    (version "0.8.7")
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
              "1dr5bbhq32hq0x8qszs34gw32innkv5ng65zc2ymm3cakb1p86vh")
             ((string= display-server "gnome")
              "0sgvc23pj1dng0clhid4lhm9xsjkicwvzn6dplfgmqgjsldnm3g5")
             ((string= display-server "kde")
              "00vb3bq8g8prg8gbk92csvp8lbv6dk4jyx2l1762jzpgmqgkbkq0")
             ((string= display-server "sway")
              "1n3d63s113dgh4wa0phfbgxswpwjwx3ypdwkxv4m67r6ac3xkkxb")))
           ("aarch64-linux"
            (cond
             ((string= display-server "x11")
              "0hndiczjw4hf9wsp9s3njqc5z7n6as6x2rlbl1hi83j6cvi9lw8r")
             ((string= display-server "gnome")
              "1imwhq82jkf79vz3qgx563h856j9j875sj151bzcln603130h63b")
             ((string= display-server "kde")
              "1kdh3yyzffpi8kpbw4haw8dl1n5fmav00xixbdsczm4bdyfbk044")
             ((string= display-server "sway")
              "1zmhynkfi18cis31gjrxz4alfcfajkf6cwk7zr9zy060win2xlkk"))))))))
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
