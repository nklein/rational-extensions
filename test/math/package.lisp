;;;; test/math/package.lisp

(defpackage #:rational-extensions/test/math
  (:use #:cl
        #:rational-extensions
        #:rational-extensions/math)
  (:shadowing-import-from :rational-extensions/math
      :+ :- :* :/
      :negate
      :plusp :minusp :zerop
      :signum :abs
      :1+ :1-
      :incf :decf)
  (:shadowing-import-from :rational-extensions/math
      :< :<= := :>= :>
      :lessp :less-equal-p :equalp :greater-equal-p :greaterp
      :min :max)
  (:export :run-all-tests))
