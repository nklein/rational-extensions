;;;; src/math.lisp

(in-package :rational-extensions)

(defun %re+= (a b)
  (loop :for (q . s) :in (re-coefficients-alist b)
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
  (loop :for (q . s) :in (re-coefficients-alist b)
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
    (loop :for (qa . sa) :in (re-coefficients-alist a)
          :do (loop :for (qb . sb) :in (re-coefficients-alist b)
                    :for g := (gcd sa sb)
                    :for s := (/ (* sa sb) (* g g))
                    :for q := (* qa qb g)
                    :do (incf (re-coefficient-of s ans) q)))
    ans))

(defun re* (&rest res)
  (cond
    ((null res)
     #.(make-rational-extension 1))
    ((rest res)
     (reduce #'%re*= (rest res) :initial-value (re-copy (first res))))
    (t
     (first res))))

(defun %re/=1 (re)
  (or (/= (re-coefficient-of 1 re) 1)
       (/= (re-coefficient-size re) 1)))

(defun %re/-find-coefficient (re)
  (let ((best-s)
        (best-q))
    (re-map-coefficients (lambda (s q)
                           (when (and (/= s 1)
                                      (or (null best-s)
                                          (< 1 s best-s)))
                             (setf best-s s
                                   best-q q)))
                         re)
    (if best-s
        (values best-s
                best-q)
        (values 1
                (re-coefficient-of 1 re)))))

(defun %re/-make-conjugate (re target)
  (apply #'make-rational-extension
         (loop :for (q . s) :in (re-coefficients-alist re)
               :collecting (if (zerop (mod s target))
                               (cons (- q) s)
                               (cons q s)))))

(defun %re/ (re)
  (let ((numerator (make-rational-extension 1)))
    (flet ((scale (v)
             (setf numerator (re* numerator v)
                   re (re* re v))))
      (loop :while (%re/=1 re)
            :do (multiple-value-bind (s q) (%re/-find-coefficient re)
                  (cond
                    ((= s 1)
                     (scale (make-rational-extension (/ q))))
                    (t
                     (scale (%re/-make-conjugate re s))))))
      numerator)))

(defun re/ (&rest res)
  (cond
    ((null res)
     #.(make-rational-extension 1))
    ((rest res)
     (re* (first res) (%re/ (apply #'re* (rest res)))))
    (t
     (%re/ (first res)))))


(defun pluses-and-minuses (re)
  (let ((pluses)
        (minuses))
    (loop :for (q . s) :in (re-coefficients-alist re)
          :do (if (plusp q)
                  (push (cons q s) pluses)
                  (push (cons (- q) s) minuses)))
    (format *debug-io* "~A vs. ~A~%" pluses minuses)
    (values (apply #'re pluses)
            (apply #'re minuses))))

(defun re-zerop (re)
  (zerop (re-coefficient-size re)))

(defun %re-signum-initial-bounds (rts)
  (flet ((root-bounds (rt)
           (if (= rt 1)
               (cons 1 1)
               (let ((sqrt (isqrt rt)))
                 (cons (1+ sqrt) sqrt)))))
    (mapcar #'root-bounds rts)))

(defun %re-signum-tighten-bounds (rts bounds)
  (flet ((tighten (rt bound)
           (unless (= rt 1)
             (let ((mid (/ (+ (car bound) (cdr bound)) 2)))
               (if (< (* mid mid) rt)
                   (setf (cdr bound) mid)
                   (setf (car bound) mid))))))
    (map nil #'tighten rts bounds))
  bounds)

(defun %re-signum-sum-bounds (cfs bounds)
  (let ((high 0)
        (low 0))
    (flet ((sum (cf bound)
             (cond
               ((plusp cf)
                (incf low (* cf (cdr bound)))
                (incf high (* cf (car bound))))
               (t
                (incf low (* cf (car bound)))
                (incf high (* cf (cdr bound)))))))
      (map nil #'sum cfs bounds))
    (values high low)))

(defun re-signum (re)
  (cond
    ((re-zerop re)
     0)
    (t
     (labels ((rec (cfs rts bounds)
                (multiple-value-bind (high low) (%re-signum-sum-bounds cfs bounds)
                  (cond
                    ((plusp low)
                     1)
                    ((minusp high)
                     -1)
                    (t
                     (rec cfs rts (%re-signum-tighten-bounds rts bounds)))))))
       (let* ((alist (re-coefficients-alist re))
              (cfs (mapcar #'car alist))
              (rts (mapcar #'cdr alist)))
         (rec cfs rts (%re-signum-initial-bounds rts)))))))

(defun re-plusp (re)
  (< 0 (re-signum re)))

(defun re-minusp (re)
  (< (re-signum re) 0))

(defmacro defcompare (name unless/when cond)
  `(defun ,name (&rest vs)
     (loop :for a :in vs
           :for b :in (rest vs)
           ,unless/when (,cond (re- b a))
             :do (return nil)
           :finally (return t))))

(defcompare re= :unless re-zerop)
(defcompare re< :unless re-plusp)
(defcompare re<= :when re-minusp)
(defcompare re> :unless re-minusp)
(defcompare re>= :when re-plusp)
