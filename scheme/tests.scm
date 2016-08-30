;;; Test cases for Scheme.
;;;
;;; In order to run only a prefix of these examples, add the line
;;;
;;; (exit)
;;;
;;; after the last test you wish to run.

;;; **********************************
;;; *** Add more of your own here! ***
;;; **********************************

;;; These are examples from several sections of "The Structure
;;; and Interpretation of Computer Programs" by Abelson and Sussman.

;;; License: Creative Commons share alike with attribution

;;; 1.1.1

10
; expect 10

(+ 137 349)
; expect 486

(- 1000 334)
; expect 666

(* 5 99)
; expect 495

(/ 10 5)
; expect 2

(+ 2.7 10)
; expect 12.7

(+ 21 35 12 7)
; expect 75

(* 25 4 12)
; expect 1200

(+ (* 3 5) (- 10 6))
; expect 19

(+ (* 3 (+ (* 2 4) (+ 3 5))) (+ (- 10 7) 6))
; expect 57

(+ (* 3
      (+ (* 2 4)
         (+ 3 5)))
   (+ (- 10 7)
      6))
; expect 57


;;; Q 04

(+ 1 3)
; expect 4

(odd? 2 2)
; expect Error: Wrong number of parameters


;;; Q 05

(define size 2)
; expect size
size
; expect 2

(* 5 size)
; expect 10

(define pi 3.14159)
(define radius 10)
(* pi (* radius radius))
; expect 314.159

(define circumference (* 2 pi radius))
circumference
; expect 62.8318

(define (square x) (* x x))
; expect square
(square 21)
; expect 441

(define x (define y (+ 2 3)))
; expect x
x
;expect y
y 
; expect 5

(eval (define add (+ 2 2)))
;expect 4

(eval (define (circle-area d) (* d d 3.14)))
;expect (lambda (d) (* d d 3.14))
(eval (circle-area 4))
;expect 50.24
(circle-area 2)
;expect 12.56


;;; Q 06

'hi
; expect hi

'(2 . 4)
; expect (2 . 4)

'(1 (2 three . (4 . 5)))
; expect (1 (2 three 4 . 5))

(car '(a b))
; expect a

(eval (cons 'car '('(1 2))))
; expect 1


;;; Q 07

(begin (* 2 4 8) (+ 3 2 1) (- 1 9))
;expect -8

(begin (define x (define y 3)) x)
;expect y
(begin y)
;expect 3

(begin (define x (cond ((< 3 0) -1) ((= 3 0) 0) (else 1))) x)
;expect 1 


;;; Q 08

(lambda (x y) (+ x y))
; expect (lambda (x y) (+ x y))

(lambda () 2)
; expect (lambda () 2)


;;; Q 09

(define (rectangle-area x y) (* x y))
;expect rectangle-area
rectangle-area
;expect (lambda (x y) (* x y))

(define f1 (define (f2 y z) (+ y z)))
;expect f1
f1
;expect f2
f2
;expect (lambda (y z) (+ y z))



;;; Q 10

(define a 1)
; expect a

(define b (define c a))
; expect b

b
; expect c

c
; expect 1


;;; Q 12

(define square (lambda (x) (* x x)))
(square 21)
; expect 441

(square (+ 2 5))
; expect 49

(square (square 3))
; expect 81

(define (sum-of-squares x y)
  (+ (square x) (square y)))
(sum-of-squares 3 4)
; expect 25

(define (f a)
  (sum-of-squares (+ a 1) (* a 2)))
(f 5)
; expect 136

(define (abs x)
  (cond ((> x 0) x)
        ((= x 0) 0)
        ((< x 0) (- x))))
(abs -3)
; expect 3

(abs 0)
; expect 0

(abs 3)
; expect 3

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))
(a-plus-abs-b 3 -2)


;;; Q 13
(if False True)
;expect okay

(if '#f True False)
;expect False

(if nil 'empty 'non-empty)
;expect empty

(if #t 1 2)
;expect 1

(if #f 1 2)
;expect 2

(if 'pass 'yeahhh)
;expect yeahhh

(if (not ()) 'list 'integer)
;expect integer


;;; Q 14

(and)
; expect True

(and 1 5 6)
; expect 6

(and 2 5 (/ 3 3))
; expect 1

(and True False 56 (/ 2 0))
; expect False

(or)
; expect False

(or 2 8 4)
; expect 2

(or False (- 3 3) 1)
; expect 0

(define y 1)
; expext y

(or (begin (define y (* 2 y)) #f)
    (begin (define y (* 3 y)) #f))
; expect False

y
; expect 6


;;; Q 15
(define (check x)
  (cond
    ((< x 0) 'negative)
    ((= x 0) 'zero)
    (else 'positive)))
;expect check
(check 5)
;expect positive


;;; Q 16

(let ((h 2)) (- h 2))
; expect 0

h
; expect Error: unknown identifier: h

(let ((h 3) (w h)) w)
; expect Error: unknown identifier: h

(define x 5)
(+ (let ((x 3))
     (+ x (* x 10)))
   x)
; expect 38

(let ((x 3)
      (y (+ x 2)))
  (* x y))
; expect 21

(let ((a 1 1)) a)
; expect Error: too many operands in form

(let ((a 1) (2 2)) a)
; expect Error: Parameters invalid


;;; Q 17
(define f1 (* 2 9))
;expect f1
(define f2 (mu (x) (* x f1)))
;expect f2
(define f3 (lambda (x y) (f2 (* x f1))))
;expect f3
(f3 4 8)
;expect 1296


;;; Q 18

(define (enumerate lst)
  (define (helper lst index)
    (cond ((null? lst) nil)
          (else (cons (list index  (car lst)) (helper (cdr lst) (+ index 1))))
    )
  )
  (helper lst 0)
)

(enumerate '(2 7 5 6))
; expect ((0 2) (1 7) (2 5) (3 6))

(enumerate '())
; expect ()


;;; Q 19

(define (cons-all first rests)
  ; BEGIN Question 19
  (cond ((null? rests) nil)
        (else (cons (append (list first) (car rests)) (cons-all first (cdr rests))))
  )
)

(define (apply-to-all proc items)
  (cond ((null? items) nil)
        (else (cons (proc (car items)) (apply-to-all proc (cdr items))))
  )
)


(define (zip pairs)
  (define (distribute lst result)
    (cond ((null? lst) result)
          ((null? result) (cons (cons (car lst) nil) (distribute (cdr lst) nil)))
          (else  (cons (append (car result) (cons (car lst) nil) ) (distribute (cdr lst) (cdr result)) ))
    )
  )
  (define (helper pairs result)
    (cond ((null? pairs) result)
          (else (helper (cdr pairs) (distribute (car pairs) result)))
    )
  )
  (helper pairs nil)
)

(define (list-change total denoms)
  (cond ((null? denoms) nil)
        ((< total (car denoms)) (list-change total (cdr denoms)))
        ((= total (car denoms)) (cons (cons total nil) (list-change total (cdr denoms))))
        (else (append (cons-all (car denoms) (list-change (- total (car denoms)) denoms )) (list-change total (cdr denoms))))
  )
)

(cons-all 0 (cons-all 1 '((2 3) (4 5) (6 7))))
;expect ((0 1 2 3) (0 1 4 5) (0 1 6 7))

(list-change 25 '(25 10 5))
;expect ((25) (10 10 5) (10 5 5 5) (5 5 5 5 5))

(list-change 3 '(25 10 5))
;expect ()


;;; Q 21

(define (circle-area r) (let ((pi 3.14)) (* pi r r)))
;expect circle-area
(circle-area 2)
;expect 12.56

(zip '((1 2 3) (4 5 6) (7 8 9)))
;expect ((1 4 7) (2 5 8) (3 6 9))


;;; Q 22

(define (sum n total)
  (if (zero? n)
      total
      (let ((n-1 (- n 1)))
            (sum n-1 (+ n total)))))
; expect sum

(sum 2000 0)
; expect 2001000


;;; Q 23

(define bar (cons-stream 1 (cons-stream 2 3)))
;expect bar
bar
;expect (1 . #[promise (not forced)])
(stream-cdr bar)
;expect (2 . #[promise (not forced)])

(define x (delay (* 2 10)))
;expect x
x
;expect #[promise (not forced)]
scm> (force x)
;expect 20
scm> x
;expect #[promise (forced)]



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Move the following (exit) line to run additional tests. ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
                 x)))
(define (improve guess x)
  (average guess (/ x guess)))
(define (average x y)
  (/ (+ x y) 2))
(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))
(define (sqrt x)
  (sqrt-iter 1.0 x))
(sqrt 9)
; expect 3.00009155413138

(sqrt (+ 100 37))
; expect 11.704699917758145

(sqrt (+ (sqrt 2) (sqrt 3)))
; expect 1.7739279023207892

(square (sqrt 1000))
; expect 1000.000369924366

;;; 1.1.8

(define (sqrt x)
  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess)
    (average guess (/ x guess)))
  (define (sqrt-iter guess)
    (if (good-enough? guess)
        guess
        (sqrt-iter (improve guess))))
  (sqrt-iter 1.0))
(sqrt 9)
; expect 3.00009155413138

(sqrt (+ 100 37))
; expect 11.704699917758145

(sqrt (+ (sqrt 2) (sqrt 3)))
; expect 1.7739279023207892

(square (sqrt 1000))
; expect 1000.000369924366

;;; 1.3.1

(define (cube x) (* x x x))
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))
(define (inc n) (+ n 1))
(define (sum-cubes a b)
  (sum cube a inc b))
(sum-cubes 1 10)
; expect 3025

(define (identity x) x)
(define (sum-integers a b)
  (sum identity a inc b))
(sum-integers 1 10)
; expect 55

;;; 1.3.2

((lambda (x y z) (+ x y (square z))) 1 2 3)
; expect 12

(define (f x y)
  (let ((a (+ 1 (* x y)))
        (b (- 1 y)))
    (+ (* x (square a))
       (* y b)
       (* a b))))
(f 3 4)
; expect 456



;;; 2.1.1

(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))
(define (sub-rat x y)
  (make-rat (- (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))
(define (mul-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y))))
(define (div-rat x y)
  (make-rat (* (numer x) (denom y))
            (* (denom x) (numer y))))
(define (equal-rat? x y)
  (= (* (numer x) (denom y))
     (* (numer y) (denom x))))

(define x (cons 1 2))
(car x)
; expect 1

(cdr x)
; expect 2

(define x (cons 1 2))
(define y (cons 3 4))
(define z (cons x y))
(car (car z))
; expect 1

(car (cdr z))
; expect 3

z
; expect ((1 . 2) 3 . 4)

(define (make-rat n d) (cons n d))
(define (numer x) (car x))
(define (denom x) (cdr x))
(define (print-rat x)
  (display (numer x))
  (display '/)
  (display (denom x))
  (newline))
(define one-half (make-rat 1 2))
(print-rat one-half)
; expect 1/2 ; okay

(define one-third (make-rat 1 3))
(print-rat (add-rat one-half one-third))
; expect 5/6 ; okay

(print-rat (mul-rat one-half one-third))
; expect 1/6 ; okay

(print-rat (add-rat one-third one-third))
; expect 6/9 ; okay

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))
(define (make-rat n d)
  (let ((g (gcd n d)))
    (cons (/ n g) (/ d g))))
(print-rat (add-rat one-third one-third))
; expect 2/3 ; okay

(define one-through-four (list 1 2 3 4))
one-through-four
; expect (1 2 3 4)

(car one-through-four)
; expect 1

(cdr one-through-four)
; expect (2 3 4)

(car (cdr one-through-four))
; expect 2

(cons 10 one-through-four)
; expect (10 1 2 3 4)

(cons 5 one-through-four)
; expect (5 1 2 3 4)

(define (map proc items)
  (if (null? items)
      nil
      (cons (proc (car items))
            (map proc (cdr items)))))
(map abs (list -10 2.5 -11.6 17))
; expect (10 2.5 11.6 17)

(map (lambda (x) (* x x))
     (list 1 2 3 4))
; expect (1 4 9 16)

(define (scale-list items factor)
  (map (lambda (x) (* x factor))
       items))
(scale-list (list 1 2 3 4 5) 10)
; expect (10 20 30 40 50)

(define (count-leaves x)
  (cond ((null? x) 0)
        ((not (pair? x)) 1)
        (else (+ (count-leaves (car x))
                 (count-leaves (cdr x))))))
(define x (cons (list 1 2) (list 3 4)))
(count-leaves x)
; expect 4

(count-leaves (list x x))
; expect 8

;;; 2.2.3

(define (odd? x) (= 1 (remainder x 2)))
(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))
(filter odd? (list 1 2 3 4 5))
; expect (1 3 5)

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))
(accumulate + 0 (list 1 2 3 4 5))
; expect 15

(accumulate * 1 (list 1 2 3 4 5))
; expect 120

(accumulate cons nil (list 1 2 3 4 5))
; expect (1 2 3 4 5)

(define (enumerate-interval low high)
  (if (> low high)
      nil
      (cons low (enumerate-interval (+ low 1) high))))
(enumerate-interval 2 7)
; expect (2 3 4 5 6 7)

(define (enumerate-tree tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (list tree))
        (else (append (enumerate-tree (car tree))
                      (enumerate-tree (cdr tree))))))
(enumerate-tree (list 1 (list 2 (list 3 4)) 5))
; expect (1 2 3 4 5)

;;; 2.3.1

(define a 1)

(define b 2)

(list a b)
; expect (1 2)

(list 'a 'b)
; expect (a b)

(list 'a b)
; expect (a 2)

(car '(a b c))
; expect a

(cdr '(a b c))
; expect (b c)

(define (memq item x)
  (cond ((null? x) false)
        ((eq? item (car x)) x)
        (else (memq item (cdr x)))))
(memq 'apple '(pear banana prune))
; expect False

(memq 'apple '(x (apple sauce) y apple pear))
; expect (apple pear)

(define (equal? x y)
  (cond ((pair? x) (and (pair? y)
                        (equal? (car x) (car y))
                        (equal? (cdr x) (cdr y))))
        ((null? x) (null? y))
        (else (eq? x y))))
(equal? '(1 2 (three)) '(1 2 (three)))
; expect True

(equal? '(1 2 (three)) '(1 2 three))
; expect False

(equal? '(1 2 three) '(1 2 (three)))
; expect False

;;; Peter Norvig tests (http://norvig.com/lispy2.html)

(define double (lambda (x) (* 2 x)))
(double 5)
; expect 10

(define compose (lambda (f g) (lambda (x) (f (g x)))))
((compose list double) 5)
; expect (10)

(define apply-twice (lambda (f) (compose f f)))
((apply-twice double) 5)
; expect 20

((apply-twice (apply-twice double)) 5)
; expect 80

(define fact (lambda (n) (if (<= n 1) 1 (* n (fact (- n 1))))))
(fact 3)
; expect 6

(fact 50)
; expect 30414093201713378043612608166064768844377641568960512000000000000

(define (combine f)
  (lambda (x y)
    (if (null? x) nil
      (f (list (car x) (car y))
         ((combine f) (cdr x) (cdr y))))))
(define zip (combine cons))
(zip (list 1 2 3 4) (list 5 6 7 8))
; expect ((1 5) (2 6) (3 7) (4 8))

(define riff-shuffle (lambda (deck) (begin
    (define take (lambda (n seq) (if (<= n 0) (quote ()) (cons (car seq) (take (- n 1) (cdr seq))))))
    (define drop (lambda (n seq) (if (<= n 0) seq (drop (- n 1) (cdr seq)))))
    (define mid (lambda (seq) (/ (length seq) 2)))
    ((combine append) (take (mid deck) deck) (drop (mid deck) deck)))))
(riff-shuffle (list 1 2 3 4 5 6 7 8))
; expect (1 5 2 6 3 7 4 8)

((apply-twice riff-shuffle) (list 1 2 3 4 5 6 7 8))
; expect (1 3 5 7 2 4 6 8)

(riff-shuffle (riff-shuffle (riff-shuffle (list 1 2 3 4 5 6 7 8))))
; expect (1 2 3 4 5 6 7 8)

;;; Additional tests

(apply square '(2))
; expect 4

(apply + '(1 2 3 4))
; expect 10

(apply (if false + append) '((1 2) (3 4)))
; expect (1 2 3 4)

(if 0 1 2)
; expect 1

(if '() 1 2)
; expect 1

(or false true)
; expect True

(or)
; expect False

(and)
; expect True

(or 1 2 3)
; expect 1

(and 1 2 3)
; expect 3

(and False (/ 1 0))
; expect False

(and True (/ 1 0))
; expect Error

(or 3 (/ 1 0))
; expect 3

(or False (/ 1 0))
; expect Error

(or (quote hello) (quote world))
; expect hello

(if nil 1 2)
; expect 1

(if 0 1 2)
; expect 1

(if (or false False #f) 1 2)
; expect 2

(define (loop) (loop))
(cond (false (loop))
      (12))
; expect 12

((lambda (x) (display x) (newline) x) 2)
; expect 2 ; 2

(define g (mu () x))
(define (high f x)
  (f))

(high g 2)
; expect 2

(define (print-and-square x)
  (print x)
  (square x))
(print-and-square 12)
; expect 12 ; 144

(/ 1 0)
; expect Error

(define addx (mu (x) (+ x y)))
(define add2xy (lambda (x y) (addx (+ x x))))
(add2xy 3 7)
; expect 13


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Scheme Implementations ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; len outputs the length of list s
(define (len s)
  (if (eq? s '())
    0
    (+ 1 (len (cdr s)))))
(len '(1 2 3 4))
; expect 4


;;;;;;;;;;;;;;;;;;;;
;;; Extra credit ;;;
;;;;;;;;;;;;;;;;;;;;


; Tail call optimization tests

(define (sum n total)
  (if (zero? n) total
    (sum (- n 1) (+ n total))))
(sum 1001 0)
; expect 501501

(define (sum n total)
  (cond ((zero? n) total)
        (else (sum (- n 1) (+ n total)))))
(sum 1001 0)
; expect 501501

(define (sum n total)
  (begin 2 3
    (if (zero? n) total
      (and 2 3
        (or false
          (begin 2 3
            (let ((m n))
              (sum (- m 1) (+ m total)))))))))
(sum 1001 0)
; expect 501501
