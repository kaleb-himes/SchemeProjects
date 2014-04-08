#lang racket
(define (f 1st)
  ; (a) ;
  (if (null? 1st)
      ; (b) ;
      '()
      ;(c);
      (cons (+ 1 (car 1st)) (f (cdr 1st)))
      )
  )
(define (member? e 1st)
  ; step through the list, if a match is found return #t else #f
  (not (equal? (member e 1st) #f))
  )
(define (set? 1st)
  (cond
  [(empty? 1st) #t]
  [(member? (car 1st) (cdr 1st)) #f]
  [else (set? (cdr 1st))])
  )
(define (union 1st1 1st2)
  (cond ((null? 1st2) 1st1)
        ((member? (car 1st2) 1st1)
         (union 1st1 (cdr 1st2)))
        (#t (union (cons (car 1st2) 1st1) (cdr 1st2))))
  )
(define (intersect 1st1 1st2)
  (if (null? 1st1) '()
      (let ((included (member? (car 1st1) 1st2)))
        (if (null? (cdr 1st1))
            (if included 1st1 '())
            (if included
                (cons (car 1st1) (intersect (cdr 1st1) 1st2))
                (intersect (cdr 1st1) 1st2))))))