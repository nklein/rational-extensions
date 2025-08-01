;;;; test/class.lisp

(in-package #:rational-extensions/test)

(nst:def-test-group constructor-tests ()
  (nst:def-test constructor-with-no-arguments (:equalp "0")
    (%to-string (make-rational-extension)))

  (nst:def-test constructor-with-rational (:equalp "2/3")
    (%to-string (make-rational-extension 2/3)))

  (nst:def-test constructor-with-arguments (:equalp "1/4 - 1/3·√2 + 5/9·√3")
    (%to-string (make-rational-extension 1/4 '(-1/3 . 2) '(5/9 . 3))))

  (nst:def-test constructor-with-arguments-out-of-order (:equalp "1/4 - 1/3·√2 + 5/9·√3")
    (%to-string (make-rational-extension '(5/9 . 3) 1/4 '(-1/3 . 2))))

  (nst:def-test shortname-constructor-with-arguments-out-of-order (:equalp "1/4 - 1/3·√2 + 5/9·√3")
    (%to-string (re '(5/9 . 3) 1/4 '(-1/3 . 2))))

  (nst:def-test constructor-accumulates (:equalp "1 + √2")
    (%to-string (make-rational-extension 2/3 '(3/4 . 2) 1/3 '(1/4 . 2))))

  (nst:def-test constructor-fixes-non-square-frees (:equalp "24 + 2·√3")
    (%to-string (make-rational-extension '(3 . 64) '(1 . 12))))

  (nst:def-test format-with-first-coefficient-negative (:equalp "-1/3·√2 + 5/9·√3")
    (%to-string (make-rational-extension '(-1/3 . 2) '(5/9 . 3))))

  (nst:def-test constructor-with-zero-coefficient (:equalp "1/4 - 1/3·√2")
    (%to-string (make-rational-extension 1/4 '(-1/3 . 2) '(0 . 3))))

  (nst:def-test printer-with-one-coefficient (:equalp "1/4 + √2")
    (%to-string (make-rational-extension 1/4 '(1 . 2))))

  (nst:def-test printer-with-minus-one-coefficient (:equalp "1/4 - √2")
    (%to-string (make-rational-extension 1/4 '(-1 . 2)))))

(nst:def-test-group rational-extension-type-tests ()
  (nst:def-test type-exists (:true)
    (typep (make-rational-extension) 'rational-extension))

  (nst:def-test type-okay-with-bad-types (:values (:not :true)
                                                  (:not :true)
                                                  (:not :true))
    (values (typep t 'rational-extension)
            (typep nil 'rational-extension)
            (typep 3/5 'rational-extension)))

  (nst:def-test predicate-exists (:true)
    (rational-extension-p (make-rational-extension))))

(nst:def-test-group accessor-tests ()
  (nst:def-test get-coefficient-that-exists (:eql -1/3)
    (re-coefficient-of 2 (make-rational-extension 1/4 '(-1/3 . 2))))

  (nst:def-test get-coefficient-that-does-not-exist (:eql 0)
    (re-coefficient-of 2 (make-rational-extension 1/4 '(5/9 . 3)))))
