;;;; math/math.lisp

(in-package #:rational-extensions/math)

;;; RATIONAL-EXTENSION Methods

(defmacro defbinary (name fn)
  `(progn
     (defmethod ,name ((a rational-extension) (b rational-extension))
       (,fn a b))
     (defmethod ,name ((a rational-extension) (b rational))
       (,fn a (re b)))
     (defmethod ,name ((a rational) (b rational-extension))
       (,fn (re a) b))))

(defbinary add re+)
(defbinary subtract re-)
(defbinary multiply re*)
(defbinary divide re/)
(defbinary equalp re=) ; not sure why this one is not happy using the exported name
(defbinary lessp re<)
(defbinary less-equal-p re<=)
(defbinary greaterp re>)
(defbinary greater-equal-p re>=)

(defmethod equalp ((a rational-extension) (b string))
  (string= (let ((*print-pretty* t))
             (with-output-to-string (str)
               (princ a str)))
           b))

(defmethod equalp ((a string) (b rational-extension))
  (equalp b a))

(defmacro defunary (name fn)
  `(defmethod ,name ((a rational-extension))
     (,fn a)))

(defmethod negate ((a rational-extension))
  (re* (re -1) a))

(defunary zerop re-zerop)
(defunary plusp re-plusp)
(defunary minusp re-minusp)
