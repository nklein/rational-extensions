;;;; src/coefficients.lisp

(in-package :rational-extensions)

(deftype %re-coefficients-table ()
  'hash-table)

(defun %re-coefficients-table-p (x)
  (hash-table-p x))

(defun %re-make-coefficients-table ()
  (make-hash-table))

(defun %re-coefficient-size (cfs)
  (hash-table-count cfs))

(defun %re-map-coefficients (fn cfs)
  (maphash fn cfs))

(defun %re-coefficient-of (s cfs &optional (default 0))
  (values (gethash s cfs default)))

(defun (setf %re-coefficient-of) (v s cfs &optional (default))
  (declare (ignore default))
  (if (zerop v)
      (remhash s cfs)
      (setf (gethash s cfs) v))
  v)

(defun %re-coefficients-copy (cfs)
  (alexandria:copy-hash-table cfs))

(defun %re-coefficients-alist (cfs)
  (mapcar (lambda (cc)
            (cons (cdr cc)
                  (car cc)))
          (alexandria:hash-table-alist cfs)))

(defun %re-default-coefficients ()
  (%re-make-coefficients-table))
