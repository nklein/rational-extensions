;;;; test/mathrun.lisp

(in-package #:rational-extensions/test/math)

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

  (nst:def-test multiply-rational-by-rational-extnension (:equalp (re 2/9 '(1/3 . 2)))
    (* 1/3
       (re 2/3 '(1 . 2))))

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

  (nst:def-test divide-rational-by-rational-extnension (:equalp (re -1/7 '(3/14 . 2)))
    (/ 1/3
       (re 2/3 '(1 . 2))))

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

  (nst:def-test <-test (:seq (:not :true) :true (:not :true))
    (list (< (make-rational-extension 1)
             1)
          (< (make-rational-extension 1 '(3 . 2))
             15)
          (< (make-rational-extension 1 '(2 . 3))
             (make-rational-extension 1 '(2 . 3)))))

  (nst:def-test less-equal-p-test (:seq (:not :true) :true (:not :true))
    (list (less-equal-p (make-rational-extension 2)
                        (make-rational-extension 1))
          (less-equal-p (make-rational-extension 1 '(4 . 2))
                        (make-rational-extension 1 '(4 . 2)))
          (less-equal-p (make-rational-extension 1 '(3 . 2))
                        (make-rational-extension 1 '(2 . 3)))))

  (nst:def-test <=-test (:seq (:not :true) :true (:not :true))
    (list (<= (make-rational-extension 1)
              (make-rational-extension 2)
              (make-rational-extension 1))
          (<= (make-rational-extension 1 '(3 . 2))
              (make-rational-extension 1 '(4 . 2))
              (make-rational-extension 1 '(4 . 2)))
          (<= (make-rational-extension 1 '(3 . 2))
              (make-rational-extension 1 '(2 . 3)))))

  (nst:def-test greaterp-test (:seq (:not :true) :true (:not :true))
    (list (greaterp (make-rational-extension 1)
                    (make-rational-extension 1))
          (greaterp 15
                    (make-rational-extension 1 '(3 . 2)))
          (greaterp (make-rational-extension 1 '(2 . 3))
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
              (make-rational-extension 1 '(3 . 2))))))
