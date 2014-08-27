#lang racket

(require racket/gui)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; BEGIN FRAME ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Create a frame.
(define frame (new frame%
                   [label "Test GUI"]
                   [width 500]
                   [height 500]))
 

; Default message
(define top-center-banner (new message% [parent frame]
                          [label "Nothing has happened yet"]))
 
; Make a button
(new button% [parent frame]
             [label "Click Me"]
             ; Callback procedure for a button click:
             [callback (lambda (button event)
                         (send top-center-banner set-label "Button has been clicked"))])


;================== create a canvas for the game board =========================;
(define my-canvas%
  (class canvas% ; The base class is canvas%
    ; Define method to track mouse events
    (define/override (on-event event)
      (send top-center-banner set-label "Mouse has focus in frame"))
    ; Define method to track keyboard events
    (define/override (on-char event)
      (send top-center-banner set-label "Keyboard has focus in frame"))
    ; Call the superclass init, passing on all init args
    (super-new)))


; Make a canvas that handles events in the frame
(new my-canvas% [parent frame]
     [paint-callback
      (lambda (canvas display)
        (send display set-scale 3 3)
        (send display set-text-foreground "black")
        (send display draw-text "HI" 72 20))])
;================== create a canvas for the game board =========================;


;================== make a panel for options ===================================;
(define panel-1 (new horizontal-panel% [parent frame]))
(new button% [parent panel-1]
             [label "Human vs Human"]
             [callback (lambda (button event)
                         (send top-center-banner set-label "Human vs Human"))])
(new button% [parent panel-1]
             [label "Human vs AI"]
             [callback (lambda (button event)
                         (send top-center-banner set-label "Human vs AI"))])
(new button% [parent panel-1]
             [label "AI vs AI"]
             [callback (lambda (button event)
                         (send top-center-banner set-label "AI vs AI"))])
;================== make a panel for options ===================================;


; Display the frame in windowed mode
(send frame show #t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; END FRAME ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
