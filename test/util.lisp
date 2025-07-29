;;;; test/util.lisp

(in-package #:rational-extensions/test)

(defun %to-string (re)
  (let ((*print-readably* nil)
        (*print-pretty* t))
    (format nil "~A" re)))
