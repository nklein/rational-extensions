;;;; math/package.lisp

(defpackage #:rational-extensions/math-user
  (:use #:static-dispatch-cl
        #:rational-extensions)
  (:shadowing-import-from #:rational-extensions/math
      :+ :- :* :/
      :negate
      :add :subtract :multiply :divide
      :plusp :minusp :zerop
      :signum :abs
      :1+ :1-
      :incf :decf)
  (:shadowing-import-from #:rational-extensions/math
      :< :<= := :>= :>
      :lessp :less-equal-p :equalp :greater-equal-p :greaterp
      :min :max))
