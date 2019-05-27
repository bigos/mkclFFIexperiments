(declaim (optimize (debug 3)))

(ql:quickload :cffi)

(defpackage :experiment1
  (:use :common-lisp))

(in-package :experiment1)

(cffi:define-foreign-library libcurl
  (:unix (:or "libcurl.so.4.5.0"))
  (T (:default "libcurl-4")))

(cffi:use-foreign-library libcurl)

;;; code example
;; https://curl.haxx.se/libcurl/c/ftpgetinfo.html
;;
;;; tutorial
;; https://common-lisp.net/project/cffi/manual/cffi-manual.html#SEC_Contents

;;; TODO finish me

;;; A CURLcode is the universal error code.  curl/curl.h says
;;; no return code will ever be removed, and new ones will be
;;; added to the end.
(cffi:defctype curl-code :int)

;;; Initialize libcurl with FLAGS.
(cffi:defcfun "curl_global_init" curl-code
  (flags :long))

(cffi:defcfun "curl_easy_init" :pointer)

(cffi:defcfun "curl_easy_cleanup" :void
  (easy-handle :pointer))

(defun main ()
  (curl-global-init 0)

  (let ((curl (curl-easy-init)))
    (/ 2 0)
    (if curl
        (progn
          (format t "ok")
          ;; curl easy setopt ...
          ;; res = curl_easy_perform(curl)
          ;; curl_easy_getinfo( args ... )
          )
        (format t "booooooo"))
    (curl-easy-cleanup curl)))

(main)
