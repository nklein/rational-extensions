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
