# RATIONAL-EXTENSIONS

This package implements extension fields of the rationals by adding square roots of integers.

## The `RATIONAL-EXTENSIONS` Package

### Constructor

Initializing them is somewhat awkward. You specify a list of terms.
Each term is either a rational number of a `CONS` containing a rational number and a square-free integer.
The returned value represents the sum of the lone rational-numbers plus the
sum of the paired rational numbers times the square root of the corresponding square-free integer.

For example:

    (make-rational-extension 1
                             (cons -3/2 2)
                             (cons 1 2)
                             (cons 4/5 3))    => 1 - 1/2·√2 + 4/5·√3

Note: technically, the integers do not have to be square-free:

    (make-rational-extension '(3 . 64) '(1 . 12))  => 24 + 2·√3

There is also a more conveniently-named wrapper for this function:

    (re '(3 . 64) '(1 . 12)) => 24 + 2·√3

### Accessors

You can get the coefficient of a given (positive) square-free integer's square root:

    (re-coefficient-of 3 (make-rational-extension (cons 6 3))) => 6

You can get an alist of pairs of rational coefficients and square-free integers:

    (re-coefficients-alist (make-rational-extension 3 (cons 1 2))) => '((3 . 1) (1 . 2))

### Arithmetic

You can add any number of these numbers:

    (re+ re1 re2...reN)

You can negate any number:
    (re- re0)

You can subtract any number of these numbers from an original number:

    (re- re0 re1 re2...reN)

You can multiply any number of these numbers:

    (re* re0 re1 re2...reN)

You can take the reciprocal of one of these numbers:

    (re/ re0)

You can divide one of these numbers by any number of these numbers:

    (re/ re0 re1 re2...reN)

## The `RATIONAL-EXTENSIONS/MATH` Package

The `RATIONAL-EXTENSIONS/MATH` package uses the `GENERIC-CL` package to allow
these rational extensions to operate with many of the standard `CL` arithmetic and math functions.

You can put your REPL in the `RATIONAL-EXTENSIONS/MATH-USER` package to operate somewhat seamlessly
with the rational extensions.

For example:

    (/ (1+ (sqrt 5)) 2)   => #<RATIONAL-EXTENSION 1/2 + 1/2·√5>

The supported operations are:

* The basic arithmetic functions: `+`, `-`, `*`, `/`, `1+`, `1-`, `incf`, `decf`, `signum`, and `abs`;
* Some `GENERIC-CL` math functions: `negate`, `add`, `subtract`, `multiply`, and `divide`;
* The sign-predicate functions: `minusp`, `zerop`, and `plusp`;
* Comparison functions: `<`, `<=`, `=`, `>=`, `>`, `min`, `max`, and `equalp`;
* Some `GENERIC-CL` comparison functions: `lessp`, `less-equal-p`, `greater-equal-p`, and `greaterp`; and
* The `sqrt` function

### Future enhancements

**Back conversion**: Casting mathematical results back to real numbers when possible.
As it is, those values are still wrapped:

    (* (+ 1 (sqrt 2)) (- 1 (sqrt 2)))   => #<RATIONAL-EXTENSION -1>

When really, you would prefer the answer just be `-1` so that predicates like `#'REALP` respond appropriately.

**Coerce**: Support coercing rational extensions to `float`, `single-float`, and `double-float`.
Right now, you can use `RE-REALIFY` to turn integers into integers, rationals into rationals, and
more complicated numbers into `double-float`:

    (RE-REALIFY (RE 3)) => 3
    (RE-REALIFY (RE 3/2)) => 3/2
    (RE-REALIFY (RE 3 '(1 . 2))) => 4.414213562373095d0

**Conjugate**: Support the `conjugate` function. This is tricky though as there will often be more than one conjugate.
For example, each of these numbers is a conjugate of all of the others:

    1 + √2 + √3 + √6
    1 + √2 - √3 - √6
    1 - √2 + √3 - √6
    1 - √2 - √3 + √6

So, it is unclear whether we should return multiple values, a list of conjugates, or the product of the conjugates.
I am leaning toward multiple values where the first is the product of the conjugates and the remaining are the individual ones.
So, for example:

    (conjugate (1+ (sqrt 2) (sqrt 3) (sqrt 6))) => #<RATIONAL-EXTENSION 2 - 2·√2 - 2·√3 + 2·√6>
                                                   #<RATIONAL-EXTENSION 1 + √2 - √3 - √6>
                                                   #<RATIONAL-EXTENSION 1 - √2 + √3 - √6>
                                                   #<RATIONAL-EXTENSION 1 - √2 - √3 + √6>

The advantage of this is that, as you've come to expect from complex conjugates:

    (* a (conjugate a))    =>  a real number

**Other `GENERIC-CL` Math Functions**: The `NUMERATOR`, `DENOMINATOR`, `REALPART`, and `IMAGPART` functions seem straightforward:

    (numerator (+ 1/2 (/ (sqrt 3) 3) (/ (sqrt 5) 6))  =>  #<RATIONAL-EXTENSION 3 + 2·√3 + √5>
    (numerator (+ 1/2 (/ (sqrt 3) 3) (/ (sqrt 5) 6))  =>  6
    (realpart re) => re
    (imagpart re) => 0

Though, maybe, I should allow imaginaries, too:

    (+ (sqrt 9/2) (sqrt -24/5)) => #<RATIONAL-EXTENSION 3/2·√2 + 2/5·i√30>

Though, that is a big undertaking.

For many other `COMMON-LISP` math functions, it makes sense to at least convert to a real and then run the function.

The exponential and trig functions are prime candidates for this:

    (log (/ (1+ (sqrt 5)) 2)) => 0.48121182505960347d0
    (cis (/ (1+ (sqrt 5)) 2)) => #C(-0.04722009625435989d0 0.9988845090948848d0)
