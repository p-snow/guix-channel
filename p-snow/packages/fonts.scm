(define-module (p-snow packages fonts)
  #:use-module (guix packages)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix build-system font))

(define-public font-ipa
  (package
   (name "font-ipa")
   (version "003.03")
   (source (origin
            (method url-fetch/zipbomb)
            (uri (string-append
                  "https://moji.or.jp/wp-content/ipafont/IPAfont" "IPAfont"
                  (string-join (string-split version #\.) "") ".zip"))
            (sha256
             (base32
              "1rbgfq14ld0cwas6bx5h7pwyv2hkfa8ihnphsaz1brxqliwysmgp"))))
   (build-system font-build-system)
   (arguments
    (list #:phases
          #~(modify-phases
             %standard-phases
             (add-after 'unpack 'make-read-only
                        (lambda _
                          (for-each (lambda (file)
                                      (chmod file #o444))
                                    (find-files "."
                                                #:directories? #f))))
             (add-after 'install 'install-doc
                        (lambda* (#:key outputs #:allow-other-keys)
                          (let ((font+version #$(string-append
                                                 "IPAfont"
                                                 (string-join (string-split
                                                               version
                                                               #\.)
                                                              "")))
                                (doc-dir (string-append #$output
                                                        "/share/doc/"
                                                        #$name)))
                            (with-directory-excursion
                             font+version
                             (mkdir-p doc-dir)
                             (copy-file (string-append "Readme_"
                                                       font+version ".txt")
                                        (string-append doc-dir "/README"))
                             (copy-file
                              "IPA_Font_License_Agreement_v1.0.txt"
                              (string-append doc-dir "/LICENSE")))))))))
   (home-page "https://moji.or.jp/ipafont/")
   (synopsis "Japanese font from the Information-technology Promotion Agency")
   (description
    "IPA Fonts are JIS X 0213:2004 compliant OpenType fonts based on TrueType
 outlines provided by Information-technology Promotion Agency, Japan (IPA) from 2003.
These are suitable for both display and printing.
Japanese and Western characters are mono-space pitch in IPAMincho and IPAGothic,
 whereas they are proportinal pitch in IPAPMincho and IPAPGothic.")
   (license license:ipa)))
