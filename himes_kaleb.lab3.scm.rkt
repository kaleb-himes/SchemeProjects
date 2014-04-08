#lang racket
;@ author Kaleb

;DEBUGGING
(require racket/trace)

(define (f lst)
  ; (a) ;
  (if 
   [null? lst]
      ; (b) ;
      '()
      ;(c);
      [cons (+ 1 (car lst)) (f (cdr lst))])
  )

;DEBUGGING
;(trace f)

(define (member? e lst)
  ; step through the list, if a match is found return #t else #f
  (cond
    ;if null, reached the end, obviously not a member
    [(null? lst) #f]
    ;if equal, short circuit out with true
    [[equal? (car lst) e] #t]
    ;otherwise continue checking till true or false
    [else (member? e (cdr lst))]
    )
  )
;DEBUGGING
;(trace member?)

(define (set? lst)
  (cond
    ;if first is empty return true 
    [(empty? lst) #t]
    ;else check if car first is a member of cdr first to eliminate duplicates
    [(member? (car lst) (cdr lst)) #f]
    ;finally recurse on set? till duplicate is found or first is empty
    [else (set? (cdr lst))])
  )

;DEBUGGING
;(trace set?)

(define (union lst1 lst2)
  (cond 
    ;base case, list two is empty, so list 1 is the union of both
    [(null? lst2) lst1]
    ;check if car first is a member of list two, if not then run union again till list 1 is empty
    [(member? (car lst2) lst1)(union lst1 (cdr lst2))]
    ;finally run union on list 2 checking for duplicates in list 2 till done
    [else (union (cons (car lst2) lst1) (cdr lst2))]
    )
  )

;DEBUGGING
;(trace union)

(define (intersect lst1 lst2)
  ;base case, return empty list if list 1 is null
  [if (null? lst1) '()
      ;[let ; "methods i wrote but was able to eliminate later on"
          ;[(included (member? (car lst1) lst2))]; "see prev comment "
          ;[if (null? (cdr lst1)); "see prev comment"
          ;[if included lst1 '()]; "see prev comment"
      ;check if car first is member of second
       [if (member? (car lst1) lst2)
           ;if it is a member (#t) then cons car first with the recursive call of cdr first and second
           [cons (car lst1) (intersect (cdr lst1) lst2)]
           ;continue recursing till all elements in first and second have been checked
           [intersect (cdr lst1) lst2]]]
  )

;take all arguments and mashes them into one list, this allows for any number of lists to flatten
;rather than just the two assigned in the extra credit.
(define (flatten . lists)
  ;now run flatten1 on our singular argument that is now "lists"
  (flatten1 lists)
  )

;DEBUGGING
;(trace flatten)

(define (flatten1 combinedlist)
  (cond
   ;base case, lst = null
    [(null? combinedlist) '()]
    ;check if the combined list contains a pair or not (get's last atom first).
    [(not (pair? combinedlist)) (list combinedlist)]
    ;otherwise append the flattened car with the flattened cdr of comblst
    [else (append (flatten1 (car combinedlist))
                  [flatten1 (cdr combinedlist)])]
      )
)

;DEBUGGING
;(trace flatten1)