(define-module (p-snow packages bittorrent)
  #:use-module (guix packages)
  #:use-module (gnu packages bittorrent)
  #:use-module (gnu packages xml))

(define-public rtorrent-xmlrpc
  (package
   (inherit rtorrent)
   (name "rtorrent-xmlrpc")
   (arguments `(#:configure-flags
                (list "--with-xmlrpc-c")))
   (native-inputs
     (modify-inputs (package-native-inputs rtorrent)
       (prepend xmlrpc-c)))
   (synopsis "BitTorrent client with ncurses interface and XMLRPC support")))
