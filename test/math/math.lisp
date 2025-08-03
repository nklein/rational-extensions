;;;; test/mathrun.lisp

(in-package #:rational-extensions/test/math)

(nst:def-criterion (:real= (given &optional (tolerance 1/100000)) (actual))
  (let ((delta (abs (- actual given))))
    (cond
      ((< delta tolerance)
       (nst:make-success-report))
      (t
       (nst:make-failure-report :format "Actual number ~A does not match given ~A"
                                :args (list actual given))))))

(nst:def-test-group arithmetic-tests ()
  (nst:def-test unary-plus (:equalp (re 3 '(2 . 3)))
    (* (re 3 '(2 . 3))))

  (nst:def-test add-rational-extension-to-rational-extension (:equalp (re 1 '(1 . 2)))
    (+ (re 1 '(3/4 . 2) '( 2/3 . 3))
       (re 0 '(1/4 . 2) '(-2/3 . 3))))

  (nst:def-test add-rational-extension-to-rational (:equalp (re 1 '(1 . 2)))
    (+ (re 2/3 '(1 . 2))
       1/3))

  (nst:def-test add-rational-to-rational-extension (:equalp (re 1 '(1 . 2)))
    (+ 1/3
       (re 2/3 '(1 . 2))))

  (nst:def-test add-real-to-rational-extension (:real= 6.8736434300714215d0)
    (+ pi (re 2 '(1 . 3))))

  (nst:def-test add-rational-extension-to-real (:real= 6.8736434300714215d0)
    (+ (re 2 '(1 . 3)) pi))

  (nst:def-test add-mixed (:equalp (re 4 '(1 . 2) '(1/3 . 3)))
    (+ (re 1 '(3/4 . 2) '( 2/3 . 3))
       3
       (re 0 '(1/4 . 2) '(-2/3 . 3))
       (re '(1/3 . 3))))

  (nst:def-test unary-minus (:equalp (re -3 '(-2 . 3)))
    (- (re 3 '(2 . 3))))

  (nst:def-test subtract-rational-extension-from-rational-extension (:equalp (re 1 '(1/2 . 2)))
    (- (re 1 '(3/4 . 2) '(2/3 . 3))
       (re 0 '(1/4 . 2) '(2/3 . 3))))

  (nst:def-test subtract-rational-from-rational-extension (:equalp (re 1/3 '(1 . 2)))
    (- (re 2/3 '(1 . 2))
       1/3))

  (nst:def-test subtract-rational-extension-from-rational (:equalp (re -1/3 '(-1 . 2)))
    (- 1/3
       (re 2/3 '(1 . 2))))

  (nst:def-test subtract-real-from-rational-extension (:real= 0.5904582421011249d0)
    (- (re 2 '(1 . 3)) pi))

  (nst:def-test from-rational-extension-from-real (:real= -0.5904582421011249d0)
    (- pi (re 2 '(1 . 3))))

  (nst:def-test subtract-mixed (:equalp (re -2 '(1/2 . 2) '(1 . 3)))
    (- (re 1 '(3/4 . 2) '( 2/3 . 3))
       3
       (re 0 '(1/4 . 2) '(-2/3 . 3))
       (re '(1/3 . 3))))

  (nst:def-test unary-times (:equalp (re 1 '(2 . 3)))
    (* (re 1 '(2 . 3))))

  (nst:def-test multiply-rational-extension-by-rational-extension (:equalp (re 41/24
                                                                               '(1/4 . 2)
                                                                               '(2/3 . 3)
                                                                               '(2/3 . 6)))
    (* (re 1 '(3/4 . 2) '(2/3 . 3))
       (re 0 '(1/4 . 2) '(2/3 . 3))))

  (nst:def-test multiply-rational-extension-by-rational (:equalp (re 2/9 '(1/3 . 2)))
    (* (re 2/3 '(1 . 2))
       1/3))

  (nst:def-test multiply-rational-by-rational-extension (:equalp (re 2/9 '(1/3 . 2)))
    (* 1/3
       (re 2/3 '(1 . 2))))

  (nst:def-test multiply-real-by-rational-extension (:real= 11.724583676725794d0)
    (* pi (re 2 '(1 . 3))))

  (nst:def-test multiply-rational-extension-to-real (:real= 11.724583676725794d0)
    (* (re 2 '(1 . 3)) pi))

  (nst:def-test multiply-mixed (:equalp (re -2 '(-1 . 2) '(-23/24 . 3) '(1/4 . 6)))
    (* (re 1 '(3/4 . 2) '( 2/3 . 3))
       3
       (re 0 '(1/4 . 2) '(-2/3 . 3))
       (re '(1/3 . 3))))

  (nst:def-test unary-divide (:equalp (re '(1/6 . 3)))
    (/ (re '(2 . 3))))

  (nst:def-test divide-rational-extension-by-rational-extension (:equalp (re 23/29
                                                                             '(-6/29 . 2)
                                                                             '(16/29 . 3)
                                                                             '(8/29 . 6)))
    (/ (re 1 '(3/4 . 2) '(2/3 . 3))
       (re 0 '(1/4 . 2) '(2/3 . 3))))

  (nst:def-test divide-rational-extension-by-rational (:equalp (re 2 '(3 . 2)))
    (/ (re 2/3 '(1 . 2))
       1/3))

  (nst:def-test divide-rational-by-rational-extension (:equalp (re -1/7 '(3/14 . 2)))
    (/ 1/3
       (re 2/3 '(1 . 2))))

  (nst:def-test divide-real-by-rational-extension (:real= 0.8417871946004604d0)
    (/ pi (re 2 '(1 . 3))))

  (nst:def-test divide-rational-extension-to-real (:real= 1.1879486958394903d0)
    (/ (re 2 '(1 . 3)) pi))

  (nst:def-test divide-mixed (:equalp (re -16/29
                                          '(-16/29 . 2)
                                          '(-41/87 . 3)
                                          '(-2/29 . 6)))
    (/ (re 1 '(3/4 . 2) '( 2/3 . 3))
       3
       (re 0 '(1/4 . 2) '(-2/3 . 3))
       (re '(1/3 . 3)))))

(nst:def-test-group comparison-tests ()
  (nst:def-test zerop (:seq :true (:not :true) (:not :true))
    (list (zerop (make-rational-extension 0))
          (zerop (make-rational-extension 1))
          (zerop (make-rational-extension '(-1 . 2)))))

  (nst:def-test plusp (:seq (:not :true) :true :true (:not :true))
    (list (plusp (make-rational-extension 0))
          (plusp (make-rational-extension 1))
          (plusp (make-rational-extension 15/100 '(1 . 2) '(-9/10 . 3)))
          (plusp (make-rational-extension 14/100 '(1 . 2) '(-9/10 . 3)))))

  (nst:def-test minusp (:seq (:not :true) (:not :true) (:not :true) :true)
    (list (minusp (make-rational-extension 0))
          (minusp (make-rational-extension 1))
          (minusp (make-rational-extension 15/100 '(1 . 2) '(-9/10 . 3)))
          (minusp (make-rational-extension 14/100 '(1 . 2) '(-9/10 . 3)))))

  (nst:def-test =-test (:seq :true :true (:not :true) (:not :true))
    (list (= (make-rational-extension 1)
             (make-rational-extension 1)
             (make-rational-extension 1))
          (= (make-rational-extension 1 '(3 . 2))
             (make-rational-extension '(3 . 2) 1)
             (make-rational-extension '(3 . 2) 1))
          (= (make-rational-extension 1 '(3 . 2))
             (make-rational-extension 1 '(2 . 3))
             (make-rational-extension 1 '(2 . 3)))
          (= (make-rational-extension 1 '(2 . 3))
             (make-rational-extension 1 '(2 . 3))
             (make-rational-extension 1 '(3 . 2)))))

  (nst:def-test equalp-test (:seq :true :true (:not :true) (:not :true))
    (list (equalp (make-rational-extension 1)
                  1)
          (equalp (make-rational-extension 1 '(3 . 2))
                  (make-rational-extension '(3 . 2) 1))
          (equalp (make-rational-extension 1 '(3 . 2))
                  (make-rational-extension 1 '(2 . 3)))
          (equalp (make-rational-extension 1 '(2 . 3))
                  (make-rational-extension 1 '(3 . 2)))))

  (nst:def-test equalp-string-test (:seq :true (:not :true))
    (list (equalp (make-rational-extension 1 '(-2 . 3))
                  "1 - 2·√3")
          (equalp (make-rational-extension 1 '(-2 . 5))
                  "1 - 2·√3")))

  (nst:def-test lessp-test (:seq (:not :true) :true (:not :true))
    (list (lessp (make-rational-extension 1)
                 1)
          (lessp (make-rational-extension 1 '(3 . 2))
                 (make-rational-extension 1 '(4 . 2)))
          (lessp (make-rational-extension 1 '(2 . 3))
                 (make-rational-extension 1 '(2 . 3)))))

  (nst:def-test lessp-with-reals-test (:seq (:not :true) :true)
    (list (lessp (make-rational-extension 1)
                 1.0d0)
          (lessp pi
                 (make-rational-extension 4))))

  (nst:def-test <-test (:seq (:not :true) :true (:not :true))
    (list (< (make-rational-extension 1)
             1)
          (< (make-rational-extension 1 '(3 . 2))
             15)
          (< (make-rational-extension 1 '(2 . 3))
             (make-rational-extension 1 '(2 . 3)))))

  (nst:def-test <-with-reals-test (:seq (:not :true) :true)
    (list (< 1.0d0
             (make-rational-extension 1))
          (< (make-rational-extension 1 '(3 . 2))
             5.25d0)))

  (nst:def-test less-equal-p-test (:seq (:not :true) :true (:not :true))
    (list (less-equal-p (make-rational-extension 2)
                        (make-rational-extension 1))
          (less-equal-p (make-rational-extension 1 '(4 . 2))
                        (make-rational-extension 1 '(4 . 2)))
          (less-equal-p (make-rational-extension 1 '(3 . 2))
                        (make-rational-extension 1 '(2 . 3)))))

  (nst:def-test less-equal-p-with-reals-test (:seq (:not :true) :true)
    (list (less-equal-p 2.0d0
                        (make-rational-extension 1))
          (less-equal-p (make-rational-extension 1)
                        1.0d0)))

  (nst:def-test <=-test (:seq (:not :true) :true (:not :true))
    (list (<= (make-rational-extension 1)
              (make-rational-extension 2)
              (make-rational-extension 1))
          (<= (make-rational-extension 1 '(3 . 2))
              (make-rational-extension 1 '(4 . 2))
              (make-rational-extension 1 '(4 . 2)))
          (<= (make-rational-extension 1 '(3 . 2))
              (make-rational-extension 1 '(2 . 3)))))

  (nst:def-test <=-with-reals-test (:seq (:not :true) :true)
    (list (<= 1.001d0
              (make-rational-extension 1))
          (<= (make-rational-extension 1 '(3 . 2))
              (make-rational-extension 1 '(4 . 2))
              6.656854249492381d0)))

  (nst:def-test greaterp-test (:seq (:not :true) :true (:not :true))
    (list (greaterp (make-rational-extension 1)
                    (make-rational-extension 1))
          (greaterp 15
                    (make-rational-extension 1 '(3 . 2)))
          (greaterp (make-rational-extension 1 '(2 . 3))
                    (make-rational-extension 1 '(3 . 2)))))

  (nst:def-test greaterp-with-reals-test (:seq (:not :true) :true)
    (list (greaterp (make-rational-extension 1)
                    1.0d0)
          (greaterp 15.0d0
                    (make-rational-extension 1 '(3 . 2)))))

  (nst:def-test >-test (:seq (:not :true) :true (:not :true))
    (list (> (make-rational-extension 2)
             (make-rational-extension 1)
             (make-rational-extension 1))
          (> (make-rational-extension 15)
             (make-rational-extension 1 '(4 . 2))
             (make-rational-extension 1 '(3 . 2)))
          (> (make-rational-extension 1 '(2 . 3))
             (make-rational-extension 1 '(3 . 2))
             (make-rational-extension 1 '(3 . 2)))))

  (nst:def-test >-with-reals-test (:seq (:not :true) :true)
    (list (> (make-rational-extension 2)
             1.0d0
             (make-rational-extension 1))
          (> (make-rational-extension 15)
             (make-rational-extension 1 '(4 . 2))
             5.242640687119286d0)))

  (nst:def-test greater-equal-p-test (:seq (:not :true) :true (:not :true))
    (list (greater-equal-p (make-rational-extension 1)
                           (make-rational-extension 2))
          (greater-equal-p (make-rational-extension 1 '(4 . 2))
                           (make-rational-extension 1 '(3 . 2)))
          (greater-equal-p (make-rational-extension 1 '(2 . 3))
                           (make-rational-extension 1 '(3 . 2)))))

  (nst:def-test >=-test (:seq (:not :true) :true (:not :true))
    (list (>= (make-rational-extension 1)
              (make-rational-extension 2)
              (make-rational-extension 1))
          (>= (make-rational-extension 1 '(4 . 2))
              (make-rational-extension 1 '(4 . 2))
              (make-rational-extension 1 '(3 . 2)))
          (>= (make-rational-extension 1 '(2 . 3))
              (make-rational-extension 1 '(3 . 2)))))

  (nst:def-test >=-with-reals-test (:seq (:not :true) :true)
    (list (>= (make-rational-extension 1)
              2.0d0
              (make-rational-extension 1))
          (>= (make-rational-extension 1 '(4 . 2))
              (make-rational-extension 1 '(4 . 2))
              5.242640687119286d0))))

(nst:def-test-group sqrt-tests ()
  (nst:def-test square-root-of-square-rational (:equalp (re 3/5))
    (sqrt 9/25))

  (nst:def-test square-root-of-non-square-rational (:equalp (re '(7/15 . 6)))
    (sqrt 98/75))

  (nst:def-test square-root-of-rational-extension (:real= 1.272019649514069d0)
    (sqrt (re 1/2 '(1/2 . 5)))))
