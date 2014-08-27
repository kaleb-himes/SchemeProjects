#lang racket


(define (printArray x)
  (cond 
    [(null? x) '()]
    [(car x) printArray(cdr x) car x] ))