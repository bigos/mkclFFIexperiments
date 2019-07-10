(format t "Welcome to Man Kai~%")

(in-package "COMPILER")

(compile-file "hello.lisp" :system-p t)

(mkcl-extensions:quit)
