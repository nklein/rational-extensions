;;;; src/math.lisp

(in-package :rational-extensions)

(defun %re+= (a b)
  (loop :for (s . q) :in (re-coefficients-alist b)
        :do (incf (re-coefficient-of s a) q))
  a)

(defun re+ (&rest res)
  (cond
    ((null res)
     #.(make-rational-extension))
    ((rest res)
     (reduce #'%re+= (rest res) :initial-value (re-copy (first res))))
    (t
     (first res))))

(defun %re-= (a b)
  (loop :for (s . q) :in (re-coefficients-alist b)
        :do (decf (re-coefficient-of s a) q))
  a)

(defun re- (&rest res)
  (cond
    ((null res)
     #.(make-rational-extension))
    ((rest res)
     (reduce #'%re-= (rest res) :initial-value (re-copy (first res))))
    (t
     (%re-= (make-rational-extension) (first res)))))

(defun %re*= (a b)
  (let ((ans (make-rational-extension)))
    (loop :for (sa . qa) :in (re-coefficients-alist a)
          :do (loop :for (sb . qb) :in (re-coefficients-alist b)
                    :for g := (gcd sa sb)
                    :for s := (/ (* sa sb) (* g g))
                    :for q := (* qa qb g)
                    :do (incf (re-coefficient-of s ans) q)))
    ans))

(defun re* (&rest res)
  (cond
    ((null res)
     #.(make-rational-extension '(1 . 1)))
    ((rest res)
     (reduce #'%re*= (rest res) :initial-value (re-copy (first res))))
    (t
     (first res))))

(defun re/ (&rest res)
  res)
