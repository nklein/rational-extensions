;;;; math/package.lisp

(defpackage #:rational-extensions/math
  (:use #:static-dispatch-cl
        #:rational-extensions)
  (:shadowing-import-from #:generic-cl.arithmetic
      :+ :- :* :/
      :negate
      :add :subtract :multiply :divide
      :plusp :minusp :zerop
      :signum :abs
      :1+ :1-
      :incf :decf)
  (:shadowing-import-from #:generic-cl.math
      :sqrt)
  (:shadowing-import-from #:generic-cl.comparison
      :< :<= := :>= :>
      :lessp :less-equal-p :equalp :greater-equal-p :greaterp
      :min :max)
  (:export :+ :- :* :/
      :negate
      :plusp :minusp :zerop
      :signum :abs
      :1+ :1-
      :incf :decf)
  (:export :sqrt)
  (:export :< :<= := :>= :>
      :lessp :less-equal-p :equalp :greater-equal-p :greaterp
      :min :max))
