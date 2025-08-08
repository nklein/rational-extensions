;;;; test/math.lisp

(in-package #:rational-extensions/test)

(nst:def-test-group re+-tests ()
  (nst:def-test no-argument-addition (:equalp "0")
    (%to-string (re+)))

  (nst:def-test one-argument-addition (:equalp "1/4 - 1/3·√2")
    (%to-string (re+ (make-rational-extension 1/4 '(-1/3 . 2)))))

  (nst:def-test two-argument-addition-with-no-overlap (:equalp "1/4 - 1/3·√2 + 5/9·√3")
    (%to-string (re+ (make-rational-extension 1/4 '(5/9 . 3))
                     (make-rational-extension '(-1/3 . 2)))))

  (nst:def-test three-argument-addition-with-no-overlap (:equalp "1/4 - 1/3·√2 + 5/9·√3")
    (%to-string (re+ (make-rational-extension 1/4)
                     (make-rational-extension '(5/9 . 3))
                     (make-rational-extension '(-1/3 . 2)))))

  (nst:def-test addition-with-overlap (:equalp "3/4 + √2 + 5/9·√3")
    (%to-string (re+ (make-rational-extension 1/4 '(1/3 . 2))
                     (make-rational-extension 1/2 '(1/6 . 2))
                     (make-rational-extension '(1/2 . 2) '(5/9 . 3))))))

(nst:def-test-group re--tests ()
  (nst:def-test no-argument-subtraction (:equalp "0")
    (%to-string (re-)))

  (nst:def-test one-argument-subtraction (:equalp "-1/4 + 1/3·√2")
    (%to-string (re- (make-rational-extension 1/4 '(-1/3 . 2)))))

  (nst:def-test two-argument-subtraction-with-no-overlap (:equalp "1/4 + 1/3·√2 + 5/9·√3")
    (%to-string (re- (make-rational-extension 1/4 '(5/9 . 3))
                     (make-rational-extension '(-1/3 . 2)))))

  (nst:def-test three-argument-subtraction-with-no-overlap (:equalp "1/4 + 1/3·√2 - 5/9·√3")
    (%to-string (re- (make-rational-extension 1/4)
                     (make-rational-extension '(5/9 . 3))
                     (make-rational-extension '(-1/3 . 2)))))

  (nst:def-test subtraction-with-overlap (:equalp "-1/4 - 1/3·√2 - 5/9·√3")
    (%to-string (re- (make-rational-extension 1/4 '(1/3 . 2))
                     (make-rational-extension 1/2 '(1/6 . 2))
                     (make-rational-extension '(1/2 . 2) '(5/9 . 3))))))

(nst:def-test-group re*-tests ()
  (nst:def-test no-argument-multiplication (:equalp "1")
    (%to-string (re*)))

  (nst:def-test one-argument-multiplication (:equalp "1/4 - 1/3·√2")
    (%to-string (re* (make-rational-extension 1/4 '(-1/3 . 2)))))

  (nst:def-test two-argument-multiplication (:equalp "1/4 - 1/12·√2 + 5/9·√3 - 5/27·√6")
    (%to-string (re* (make-rational-extension 1/4 '(5/9 . 3))
                     (make-rational-extension 1 '(-1/3 . 2)))))

  (nst:def-test three-argument-multiplication (:equalp "-10/9 + 5/3·√2 - 1/6·√3 + 1/4·√6")
    (%to-string (re* (make-rational-extension 1/4 '(5/9 . 3))
                     (make-rational-extension 1 '(-1/3 . 2))
                     (make-rational-extension '(1 . 6))))))

(nst:def-test-group re/-tests ()
  (nst:def-test no-argument-division (:equalp "1")
    (%to-string (re/)))

  (nst:def-test rational-one-argument-division (:equalp "2/3")
    (%to-string (re/ (make-rational-extension 3/2))))

  (nst:def-test pure-one-argument-division (:equalp "1/3·√2")
    (%to-string (re/ (make-rational-extension '(3/2 . 2)))))

  (nst:def-test two-term-one-argument-division (:equalp "-2/7 + 3/7·√2")
    (%to-string (re/ (make-rational-extension 1 '(3/2 . 2)))))

  (nst:def-test division-as-inverse (:equalp "1")
    (%to-string (let ((re (make-rational-extension 1 '(3/2 . 2))))
                  (re/ re re)))))

(nst:def-test-group realify-tests ()
  (nst:def-test realify-rational (:equalp 3/5)
    (re-realify (re 3/5)))

  (nst:def-test realify-rational-is-rational (:predicate rationalp)
    (re-realify (re 3/5)))

  (nst:def-test realify-irrational (:true)
    (< (abs (- (re-realify (re 1/2 '(1/2 . 5)))
               1.618033988749))
       1/100000))

  (nst:def-test realify-irrational-is-real (:predicate realp)
    (re-realify (re 1/2 '(1/2 . 5)))))

(nst:def-test-group re-comparison-tests ()
  (nst:def-test zerop (:seq :true (:not :true) (:not :true))
    (list (re-zerop (make-rational-extension 0))
          (re-zerop (make-rational-extension 1))
          (re-zerop (make-rational-extension '(-1 . 2)))))

  (nst:def-test re-signum-tests (:seq (:equalp -1) (:equalp 0) (:equalp 1))
    (list (re-signum (re 2 '(19/180 . 3) '(-109/90 . 6) '(1/60 . 2158)))
          (re-signum (re 0))
          (re-signum (re (+ 2 1/8) '(19/180 . 3) '(-109/90 . 6) '(1/60 . 2158)))))

  (nst:def-test plusp (:seq (:not :true) :true :true (:not :true))
    (list (re-plusp (make-rational-extension 0))
          (re-plusp (make-rational-extension 1))
          (re-plusp (make-rational-extension 15/100 '(1 . 2) '(-9/10 . 3)))
          (re-plusp (make-rational-extension 14/100 '(1 . 2) '(-9/10 . 3)))))

  (nst:def-test minusp (:seq (:not :true) (:not :true) (:not :true) :true)
    (list (re-minusp (make-rational-extension 0))
          (re-minusp (make-rational-extension 1))
          (re-minusp (make-rational-extension 15/100 '(1 . 2) '(-9/10 . 3)))
          (re-minusp (make-rational-extension 14/100 '(1 . 2) '(-9/10 . 3)))))

  (nst:def-test re=-test (:seq :true :true (:not :true) (:not :true))
    (list (re= (make-rational-extension 1)
               (make-rational-extension 1)
               (make-rational-extension 1))
          (re= (make-rational-extension 1 '(3 . 2))
               (make-rational-extension '(3 . 2) 1)
               (make-rational-extension '(3 . 2) 1))
          (re= (make-rational-extension 1 '(3 . 2))
               (make-rational-extension 1 '(2 . 3))
               (make-rational-extension 1 '(2 . 3)))
          (re= (make-rational-extension 1 '(2 . 3))
               (make-rational-extension 1 '(2 . 3))
               (make-rational-extension 1 '(3 . 2)))))

  (nst:def-test re<-test (:seq (:not :true) :true (:not :true))
    (list (re< (make-rational-extension 1)
               (make-rational-extension 1)
               (make-rational-extension 2))
          (re< (make-rational-extension 1 '(3 . 2))
               (make-rational-extension 1 '(4 . 2))
               (make-rational-extension 15))
          (re< (make-rational-extension 1 '(3 . 2))
               (make-rational-extension 1 '(2 . 3))
               (make-rational-extension 1 '(2 . 3)))))

  (nst:def-test re<=-test (:seq (:not :true) :true (:not :true))
    (list (re<= (make-rational-extension 1)
                (make-rational-extension 2)
                (make-rational-extension 1))
          (re<= (make-rational-extension 1 '(3 . 2))
                (make-rational-extension 1 '(4 . 2))
                (make-rational-extension 1 '(4 . 2)))
          (re<= (make-rational-extension 1 '(3 . 2))
                (make-rational-extension 1 '(2 . 3)))))

  (nst:def-test re>-test (:seq (:not :true) :true (:not :true))
    (list (re> (make-rational-extension 2)
               (make-rational-extension 1)
               (make-rational-extension 1))
          (re> (make-rational-extension 15)
               (make-rational-extension 1 '(4 . 2))
               (make-rational-extension 1 '(3 . 2)))
          (re> (make-rational-extension 1 '(2 . 3))
               (make-rational-extension 1 '(3 . 2))
               (make-rational-extension 1 '(3 . 2)))))

  (nst:def-test re>=-test (:seq (:not :true) :true (:not :true))
    (list (re>= (make-rational-extension 1)
                (make-rational-extension 2)
                (make-rational-extension 1))
          (re>= (make-rational-extension 1 '(4 . 2))
                (make-rational-extension 1 '(4 . 2))
                (make-rational-extension 1 '(3 . 2)))
          (re>= (make-rational-extension 1 '(2 . 3))
                (make-rational-extension 1 '(3 . 2))))))
