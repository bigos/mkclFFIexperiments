(declaim (optimize (debug 3)))

(ql:quickload :cffi)

(defpackage :experiment-gtk
  (:use :common-lisp))

;; Example 2.1: A simple window in the programming language C
;; http://www.crategus.com/books/cl-gtk/gtk-tutorial_2.html#SEC4

(in-package :experiment-gtk)

;; on Windows the library can be found at
;; c:/msys64/mingw64/bin

;; Searching for functions
;; got to folder /usr/include
;; M-x find-grep gtk_main_quit

(cffi:define-foreign-library libgtk
    (:unix (:or  "libgtk-3.so.0" "libgtk-3.so"))
  (T (:default "libgtk-3-0")))

(cffi:use-foreign-library libgtk)

(when
    (equalp (lisp-implementation-type) "SBCL")
  (sb-int:set-floating-point-modes :traps '(:overflow :invalid :divide-by-zero)))

(cffi:defctype my-string :string
  "My own string type.")

(cffi:defcfun "strlen" :int
  "Calculate the length of a string."
  (n :string))

;; void     gtk_init                 (int    *argc,
;;                                           char ***argv);
(cffi:defcfun "gtk_init" :pointer
  "init"
  (argc :int)
  (argv :int))

;; GtkWidget* gtk_window_new                      (GtkWindowType        type);
(cffi:defcfun "gtk_window_new" :pointer
  "new window"
  (toplevel :int))

;; #define g_signal_connect(instance, detailed_signal, c_handler, data) \
(cffi:defcfun "g_signal_connect" :int
  "connect a callback function to a particular object"
  (instance :pointer)
  (detailed-signal :string)
  (c-handler :pointer)
  (data :pointer))

;; void       gtk_main_quit           (void);
(cffi:defcfun "gtk_main_quit" :void
  "quit")

;; void       gtk_widget_show                (GtkWidget           *widget);
(cffi:defcfun "gtk_widget_show" :void
  "show"
  (w :pointer))

;; void       gtk_main                (void);
(cffi:defcfun "gtk_main" :void
  "gtk main")

(defun main ()
  (gtk-init 0 2)
  (let ((window (gtk-window-new 0)))
    ;; (g-signal-connect window "destroy" (lambda (window) (declare (ignorable window)) (gtk-main-quit)) (cffi:null-pointer))
    (gtk-widget-show window)
    (gtk-main)))

;;; i want to replicate thin program

;;; C example
;; #include <gtk/gtk.h>

;; int main (int argc, char *argv[])
;; {
;; GtkWidget *window;
;; gtk_init (&argc, &argv);
;; window = gtk_window_new (GTK_WINDOW_TOPLEVEL);
;; g_signal_connect (window, "destroy", G_CALLBACK (gtk_main_quit), NULL);
;; gtk_widget_show (window);
;; gtk_main ();
;; return 0;
;; }
