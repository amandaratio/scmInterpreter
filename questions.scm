(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))

; Some utility functions that you may find useful to implement.

(define (cons-all first rests)
  (if (null? rests)
    nil
    (cons (cons first (car rests)) (cons-all first (cdr rests)))
  ))

(define (zip pairs)
  (list 
        (map car pairs)
        (map car (map cdr pairs))
    )
  )

;; Problem 17
;; Returns a list of two-element lists
(define (enumerate s)
  ; BEGIN PROBLEM 17
  (define (helper s x)
    (if (null? s)
      nil
      (cons (list x (car s)) (helper (cdr s) (+ 1 x)))
    )
  )
  (helper s 0)
  )
  ; END PROBLEM 17

;; Problem 18
;; List all ways to make change for TOTAL with DENOMS
(define (list-change total denoms)
  ; BEGIN PROBLEM 18
  (define (helper total denoms)
    (if (or (< total 0) (null? denoms))
      nil
      (if (= total 0)
        (list nil)
        (append (cons-all (car denoms) (helper (- total (car denoms)) denoms)) (helper total (cdr denoms)))
      )
    )
  )
  (helper total denoms)
)
  ; END PROBLEM 18

;; Problem 19
;; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))
(define define? (check-special 'define))
(define quoted? (check-special 'quote))
(define let?    (check-special 'let))

;; Converts all let special forms in EXPR into equivalent forms using lambda
(define (let-to-lambda expr)
  (cond ((atom? expr)
         ; BEGIN PROBLEM 19
         expr
         ; END PROBLEM 19
         )
        ((quoted? expr)
         ; BEGIN PROBLEM 19
         expr
         ; END PROBLEM 19
         )
        ((or (lambda? expr)
             (define? expr))
         (let ((form   (car expr))
               (params (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 19
           (cons form (cons (map let-to-lambda params) (map let-to-lambda body)))
           ; END PROBLEM 19
           ))
        ((let? expr)
         (let ((values (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 19
           (cons 
                (cons 'lambda (list (car (zip (let-to-lambda values))) (car (let-to-lambda body)))) 
                (cadr (zip (let-to-lambda values)))
            )
           ; END PROBLEM 19
           ))
        (else
         ; BEGIN PROBLEM 19
         (map let-to-lambda expr)
         ; END PROBLEM 19
         )))
