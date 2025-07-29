;;;; package.lisp

(defpackage #:rational-extensions
  (:use #:cl)
  (:export :square-free
           :square-free-p)
  (:export :rational-extension
           :rational-extension-p
           :re-coefficient-of
           :re-coefficients-alist
           :make-rational-extension)
  (:export :re+
           :re-
           :re*
           :re/))
