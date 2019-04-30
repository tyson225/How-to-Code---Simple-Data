;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname htdf-itemization) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; Data definition

;; Countdown is one of:
;; - false
;; - Natural [1 - 10]
;; - "complete"
;; interp.
;;    false         means countdown has not yet started
;;    Natural[1-10] means countdown is running and how many seconds left
;;    "complete"    means countdown is over
(define CD1 false)
(define CD2 10)  ; just started runing
(define CD3 1)   ; countdown almost over
(define CD4 "complete")
#;
(define (fn-for-countdown c)
  (cond [(false? c) (...)]
        [(number? c) (... c)]
        [else (...)]))

;; Template rules used:
;; - one of three cases
;; - atomic distinct false
;; - atomic non oistinct Natural [1-10]
;; -atomic distinct "complete"

;; Functions

;; Countdown -> Image
;; produces image of the current state of the countdown
(check-expect (countdown-to-image false) (square 0 "solid" "white"))
(check-expect (countdown-to-image 5)(text (number->string 5) 24 "black"))
(check-expect (countdown-to-image "complete") (text "Happy New Year!" 24 "red"))

;(define (countdown-to-image c) (square 0 "solid" "white")) ;stub

; use template from Countdown
(define (countdown-to-image c)
  (cond [(false? c)
         (square 0 "solid" "white")]
        [(and (number? c) (<= 1 c) (<= c 10))
        (text (number->string c) 24 "black")]
        [else
         (text "Happy New Year!" 24 "red")]))