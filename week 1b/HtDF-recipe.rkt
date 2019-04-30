;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname HtDF-recipe) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Number -> Number
;; produce 2 times the given number

(check-expect (double 3) 6)
(check-expect (double 4.2) (* 2 4.2))

;(define (double n) 0) ;this is a stub

(define (double n) ;this is a template
  (* 2 n))