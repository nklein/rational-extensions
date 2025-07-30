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

(defun re-coefficient-size (re)
  (%re-coefficient-size (%re-coefficients re)))

(defun re-map-coefficients (fn re)
  (%re-map-coefficients fn (%re-coefficients re)))

(defun make-rational-extension-from-rational (q)
  (make-rational-extension q))

(defun make-rational-extension (&rest cfs)
  (let ((coefficients (%re-default-coefficients)))
    (loop :for cc :in cfs
          :for (q . s) := (cond
                            ((rationalp cc)
                             (cons cc 1))
                            (t
                             cc))
          :do (progn
                (check-type q rational)
                (check-type s square-free)
                (when (minusp s)
                  (setf q (- q)
                        s (- s)))
                (incf (%re-coefficient-of s coefficients 0) q)))
    (%make-rational-extension :coefficients coefficients)))

(defmethod make-load-form ((object rational-extension) &optional environment)
  (declare (ignorable environment))
  `(make-rational-extension ,@(mapcar (lambda (c)
                                        (destructuring-bind (q . s) c
                                          (if (= s 1)
                                              q
                                              `'(,q . ,s))))
                                      (re-coefficients-alist object))))

(defmethod print-object ((object rational-extension) stream)
  (flet ((print-coeffs ()
           (let ((cfs (sort (re-coefficients-alist object)
                            #'<
                            :key #'cdr)))
             (if (null cfs)
                 (format stream "0")
                 (loop :with firstp := t
                       :for ( q . s ) :in cfs
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
