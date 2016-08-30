; Some utility functions that you may find useful.
(define (cons-all first rests)
  ; BEGIN Question 19
  (cond ((null? rests) nil)
        (else (cons (append (list first) (car rests)) (cons-all first (cdr rests))))
  )
)
  ; END Question 19

; (cons-all 1 '((2 3) (2 4) (3 5)))
; (cons-all 1 '(()) )
; expect ((1 2 3) (1 2 4) (1 3 5))


(define (apply-to-all proc items)
  ; BEGIN Question 20
  'REPLACE-THIS-LINE
  (cond ((null? items) nil)
        (else (cons (proc (car items)) (apply-to-all proc (cdr items))))
  )
)
  ; END Question 20


(define (zip pairs)
  ; BEGIN Question 20
  'REPLACE-THIS-LINE
  (define (helper result lst)
    (cond ((null? lst) result)
          (else (helper 
                        (cons 
                          (append (car result) (cons (car (car lst)) nil) ) 
                          (cons (append (car (cdr result)) (cons (car (cdr (car lst))) nil)) nil) ) 
                        (cdr lst)))
    )
  )
  (helper (cons nil (cons nil nil)) pairs)
)


; (define (zip pairs)
;   ; BEGIN Question 20
;   'REPLACE-THIS-LINE
;   (define (helper result lst)
;     (cond ((null? lst) result)
;           (else (helper 
;                         (cons 
;                           (append (car result) (cons (car (car lst)) nil) ) 
;                           (cons (append (car (cdr result)) (cons (car (cdr (car lst))) nil)) nil) ) 
;                         (cdr lst)))
;     )
;   )
;   (helper (cons nil (cons nil nil)) pairs)


; )


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



(zip '((1 2 3) (4 5 6) (7 8 9)))
;expect ((1 4 7) (2 5 8) (3 6 9))

  ; END Question 20



(zip '((1 2) (3 4) (5 6)))
; expect ((1 3 5) (2 4 6))

(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cddr x) (cdr (cdr x)))
(define (cadar x) (car (cdr (car x))))

; Problem 18

;; Returns a list of two-element lists
(define (enumerate lst)
  (define (helper lst index)
    (cond ((null? lst) nil)
          (else (cons (list index  (car lst)) (helper (cdr lst) (+ index 1))))
    )
  )
  (helper lst 0)
)
  ; END Question 18

(enumerate '(5 6 7 8))
; expect ((0 5) (1 6) (2 7) (3 8))

; Problem 19

;; List all ways to make change for TOTAL with DENOMS
(define (list-change total denoms)
  ; BEGIN Question 20
  (cond ((null? denoms) nil)
        ((< total (car denoms)) (list-change total (cdr denoms)))
        ((= total (car denoms)) (cons (cons total nil) (list-change total (cdr denoms))))
        (else (append (cons-all (car denoms) (list-change (- total (car denoms)) denoms )) (list-change total (cdr denoms))))
  )
)
  ; END Question 20

; Make sure the lists are in descending order
(list-change 10 '(25 10 5 1))
; expect ((10) (5 5) (5 1 1 1 1 1) (1 1 1 1 1 1 1 1 1 1))
(list-change 5 '(4 3 2 1))
; expect ((4 1) (3 2) (3 1 1) (2 2 1) (2 1 1 1) (1 1 1 1 1))

;; Problem 20 (optional)
;; Draw the hax image using turtle graphics.
(define (hax d k)
  ; BEGIN Question 20
  (circle 100)
)
  ; END Question 20

; Problem 21
;; Returns a function that takes in an expression and checks if it is the special
;; form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))
(define define? (check-special 'define))
(define quoted? (check-special 'quote))
(define let?    (check-special 'let))

; Converts all let special forms in EXPR into equivalent forms using lambda
(define (analyze expr)
  (cond ((atom? expr)
         ; BEGIN Question 21
         expr
         ; END Question 21
         )
        ((quoted? expr)
         ; BEGIN Question 21
         expr
         ; END Question 21
         )
        ((or (lambda? expr)
             (define? expr))
         (let ((form   (car expr))
               (params (cadr expr))
               (body   (cddr expr)))
           ; BEGIN Question 21
           (append (list form params) (analyze body))
           ; END Question 21
           ))
        ((let? expr)
         (let ((body   (analyze (cddr expr)))
               (values (analyze (cadr expr))))
           ; BEGIN Question 21
           (append (cons (append (list 'lambda (car (zip values))) body) nil) (cadr (zip values)))
           ; END Question 21
           ))
        (else
         ; BEGIN Question 21
         (apply-to-all analyze expr)
         ; END Question 21
         )))
(analyze '(let ( (a (let ((a 2)) a)) (b 2)) (+ a b)))

; expect ((lambda (a b) (+ a b)) ((lambda (a) a) 2) 2)
(analyze '(let ((a 1) (b 2)) (+ a b)))
(analyze '(lambda (x) a (let ((a x)) a)))


(analyze '(a ((lambda (a) a) x)))

(analyze 1)
; expect 1
(analyze 'a)
; expect a
(analyze '(+ 1 2))
; expect (+ 1 2)

; Quoted expressions remain the same
(analyze '(quote (let ((a 1) (b 2)) (+ a b))))
; expect (quote (let ((a 1) (b 2)) (+ a b)))

; Lambda parameters not affected, but body affected
(analyze '(lambda (let a b) (+ let a b)))
; expect (lambda (let a b) (+ let a b))

(analyze '(lambda (x) a (let ((a x)) a)))
; expect (lambda (x) a ((lambda (a) a) x))

(analyze '(let ((a 1)
               (b 2))
           (+ a b)))
; expect ((lambda (a b) (+ a b)) 1 2)
(analyze '(let ((a (let ((a 2)) a))
               (b 2))
           (+ a b)))
; expect ((lambda (a b) (+ a b)) ((lambda (a) a) 2) 2)
(analyze '(let ((a 1))
           (let ((b a))
             b)))
; expect ((lambda (a) ((lambda (b) b) a)) 1)
(analyze '(+ 1 (let ((a 1)) a)))
; expect (+ 1 ((lambda (a) a) 1))

