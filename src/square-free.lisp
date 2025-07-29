;;;; src/square-free.lisp

(in-package :rational-extensions)

(eval-when (:compile-toplevel :load-toplevel)
  (defun square-free-p (n)
    (when (integerp n)
      (let ((n (abs n)))
        (or (loop :for x :from 2
                  :for s := (* x x)
                  :while (<= s n)
                  :when (zerop (mod n s))
                    :do (return-from square-free-p nil))
            t)))))

(deftype square-free ()
  '(and integer (satisfies square-free-p)))
