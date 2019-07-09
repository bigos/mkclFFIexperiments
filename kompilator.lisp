(defconstant +standalone-exe+ (compile-file-pathname "standalone" :type :program))
(c::build-program +standalone-exe+
		  :lisp-files
		  (list (compile-file-pathname "hello.lisp" :type :object))
		  :ld-flags
		  (list (namestring (compile-file-pathname "hello_aux.c" :type :object)))
		  :epilogue-code
		  '(si::quit))
