(declaim (optimize (debug 3)))

(ql:quickload :cffi)

(defpackage :experiment-gtk
  (:use :common-lisp))

;; Example 2.1: A simple window in the programming language C
;; http://www.crategus.com/books/cl-gtk/gtk-tutorial_2.html#SEC4

(in-package :experiment-gtk)

;; on Windows the library can be found at
;; c:/msys64/mingw64/bin

(cffi:define-foreign-library libgtk
    (:unix (:or  "libgtk-3.so.0" "libgtk-3.so"))
  (T (:default "libgtk-3-0")))

(cffi:use-foreign-library libgtk)

;; (sb-int:set-floating-point-modes :traps '(:overflow :invalid :divide-by-zero))

(cffi:defctype my-string :string
  "My own string type.")

(cffi:defcfun "strlen" :int
  "Calculate the length of a string."
  (n :string))

(cffi:defcfun "gtk_init" :pointer
  "init"
  (argc :int)
  (argv :int))

(cffi:defcfun "gtk_window_new" :pointer
  "new window"
  (toplevel :int))

(cffi:defcfun "gtk_widget_show" :void
  "show"
  (w :pointer))

(cffi:defcfun "gtk_main" :void
  "gtk main")

(defun main ()
  (gtk-init 0 2)
  (let ((window (gtk-window-new 0)))
    (gtk-widget-show window)
    (gtk-main)))

;;; the above shows window that results in error
; Evaluation aborted on #<DIVISION-BY-ZERO {100BB47103}>.
