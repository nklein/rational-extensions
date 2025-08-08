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
       (,fn (re a) b))
     (defmethod ,name ((a rational-extension) (b number))
       (,name (re-realify a) b))
     (defmethod ,name ((a number) (b rational-extension))
       (,name a (re-realify b)))))

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
(defunary signum re-signum)
(defunary plusp re-plusp)
(defunary minusp re-minusp)

(defmethod sqrt ((a rational))
  (cond
    ((zerop a)
     0)
    ((minusp a)
     (sqrt (coerce a 'double-float)))
    (t
     ;;
     ;; (sqrt kkp/llq)
     ;;    = (k/l)(sqrt p/q)
     ;;    = (k/lq)(sqrt pq)
     ;;
     (let* ((p/q (make-square-free a))
            (p (numerator p/q))
            (q (denominator p/q))
            (kk/ll (/ a p/q))
            (kk (numerator kk/ll))
            (ll (denominator kk/ll)))
       (re (cons (/ (isqrt kk)
                    (* (isqrt ll)
                       q))
                 (* p q)))))))

(defmethod sqrt ((a rational-extension))
    (sqrt (re-realify a)))
