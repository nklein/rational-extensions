;;;; rational-extensions.asd

(asdf:defsystem #:rational-extensions
  :description "RATIONAL-EXTENSIONS is implements extension fields of rationals by square roots of integers."
  :author "Patrick Stein <pat@nklein.com>"
  :license "UNLICENSE"
  :version "0.1.20250729"
  :depends-on (#:alexandria)
  :in-order-to ((asdf:test-op (asdf:test-op :rational-extensions/test)))
  :components
  ((:static-file "README.md")
   (:static-file "UNLICENSE.txt")
   (:module "src"
    :components ((:file "package")
                 (:file "square-free" :depends-on ("package"))
                 (:file "coefficients" :depends-on ("package"
                                                    "square-free"))
                 (:file "class" :depends-on ("package"
                                             "square-free"
                                             "coefficients"))
                 (:file "math" :depends-on ("package"
                                            "square-free"
                                            "coefficients"
                                            "class"))))))

(asdf:defsystem #:rational-extensions/test
  :description "Tests for the RATIONAL-EXTENSIONS package."
  :author "Patrick Stein <pat@nklein.com>"
  :license "UNLICENSE"
  :version "0.1.20250729"
  :depends-on ((:version #:rational-extensions "0.1.20250729") #:nst)
  :perform (asdf:test-op (o c)
                         (uiop:symbol-call :rational-extensions/test :run-all-tests))
  :components
  ((:static-file "README.md")
   (:static-file "UNLICENSE.txt")
   (:module "test"
    :components ((:file "package")
                 (:file "util" :depends-on ("package"))
                 (:file "square-free" :depends-on ("package"))
                 (:file "class" :depends-on ("package"
                                             "util"))
                 (:file "math" :depends-on ("package"
                                            "util"))
                 (:file "run" :depends-on ("package"))))))
