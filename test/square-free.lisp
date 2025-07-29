;;;; test/square-free.lisp

(in-package #:rational-extensions/test)

(nst:def-test-group square-free-tests ()
  (nst:def-test type-exists (:values :true
                                     (:not :true))
    (values (typep 6 'square-free)
            (typep 12 'square-free)))

  (nst:def-test type-okay-with-bad-types (:values (:not :true)
                                                  (:not :true)
                                                  (:not :true))
    (values (typep t 'square-free)
            (typep nil 'square-free)
            (typep 3/5 'square-free)))

  (nst:def-test predicate-exists (:values :true
                                          (:not :true))
    (values (square-free-p 6)
            (square-free-p 12)))

  (nst:def-test predicate-okay-with-bad-types (:values (:not :true)
                                                       (:not :true)
                                                       (:not :true))
    (values (square-free-p t)
            (square-free-p nil)
            (square-free-p 3/5))))
