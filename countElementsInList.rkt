#lang racket
(require racket/trace)
(define count
   (lambda (list)
      (cond
         [(not (list? list)) 0]
         [(null? list) 0]
         [else (+ 1 (count (cdr list)))])
     )
  )
(trace count)