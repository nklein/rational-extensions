;;;; package.lisp

(defpackage #:rational-extensions
  (:use #:cl)
  (:export :square-free
           :square-free-p)
  (:export :rational-extension
           :rational-extension-p
           :re-coefficient-of
           :re-coefficients-alist
           :make-square-free
           :make-rational-extension
           :re
           :re-realify)
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
