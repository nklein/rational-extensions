;;;; package.lisp

(defpackage #:rational-extensions
  (:use #:cl)
  (:export :square-free
           :square-free-p)
  (:export :rational-extension
           :rational-extension-p
           :re-coefficient-of
           :re-coefficients-alist
           :make-rational-extension
           :re)
  (:export :re+
           :re-
           :re*
           :re/
           :re-zerop
           :re-plusp
           :re-minusp
           :re=
           :re<
           :re<=
           :re>
           :re>=
           ))
