;;;; test/package.lisp

(defpackage #:rational-extensions/test
  (:use #:cl #:rational-extensions)
  (:export :run-all-tests))
