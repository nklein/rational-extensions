RATIONAL-EXTENSIONS
===================

This package implements extension fields of the rationals by adding square roots of integers.

Constructor
-----------

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

Accessors
---------

You can get the coefficient of a given (positive) square-free integer's square root:

    (re-coefficient-of 3 (make-rational-extension (cons 6 3))) => 6

You can get an alist of pairs of rational coefficients and square-free integers:

    (re-coefficients-alist (make-rational-extension 3 (cons 1 2))) => '((3 . 1) (1 . 2))

Arithmetic
----------

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
