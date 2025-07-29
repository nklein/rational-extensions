;;;; src/class.lisp

(in-package :rational-extensions)

(defstruct (rational-extension (:conc-name %re-)
                               (:constructor %make-rational-extension))
  (coefficients (%re-default-coefficients) :type %re-coefficients-table :read-only t))

(declaim (inline re-coefficient-of))
(defun re-coefficient-of (s re &optional (default 0))
  (%re-coefficient-of s (%re-coefficients re) default))

(declaim (inline (setf re-coefficient-of)))
(defun (setf re-coefficient-of) (v s re)
  (setf (%re-coefficient-of s (%re-coefficients re)) v))

(defun re-coefficients-alist (re)
  (%re-coefficients-alist (%re-coefficients re)))

(defun re-copy (re)
  (%make-rational-extension :coefficients (%re-coefficients-copy (%re-coefficients re))))

(defun make-rational-extension (&rest cfs)
  (let ((coefficients (%re-default-coefficients)))
    (loop :for (q . s) :in cfs
          :do (progn
                (check-type q rational)
                (check-type s square-free)
                (when (minusp s)
                  (setf q (- q)
                        s (- s)))
                (setf (%re-coefficient-of s coefficients) q)))
    (%make-rational-extension :coefficients coefficients)))

(defmethod make-load-form ((object rational-extension) &optional environment)
  (declare (ignorable environment))
  `(make-rational-extension ,@(mapcar (lambda (c)
                                        (destructuring-bind (s . q) c
                                          `'(,q . ,s)))
                                      (re-coefficients-alist object))))

(defmethod print-object ((object rational-extension) stream)
  (flet ((print-coeffs ()
           (let ((cfs (sort (re-coefficients-alist object)
                            #'<
                            :key #'first)))
             (if (null cfs)
                 (format stream "0")
                 (loop :with firstp := t
                       :for ( s . q ) :in cfs
                       :unless firstp
                         :do (if (plusp q)
                                 (princ " + " stream)
                                 (prog1
                                     (princ " - " stream)
                                   (setf q (- q))))
                       :do (setf firstp nil)
                       :do (if (= s 1)
                               (format stream "~A" q)
                               (if (= q 1)
                                   (format stream "√~A" s)
                                   (format stream "~A·√~A" q s))))))))
    (cond
      (*print-readably*
       (call-next-method))
      (*print-pretty*
       (print-coeffs))
      (t
       (print-unreadable-object (object stream :type t)
         (print-coeffs))))))
