;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname designing-with-lists) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Data Definitions:

;; ListOfNumber is one of:
;; -empty
;; - (cons Number ListOfNumber)
;; interp. each number in the list is an owl weight in ounces
(define LON1 empty)
(define LON2 (cons 60 (cons 42 empty)))
#;
(define (fn-for-lon lon)
  (cond [(empty? lon) (...)]
        [else
         (... (first lon)
              (fn-for-lon (rest lon)))]))

;; Template rules used:
;; - one of: 2 cases
;; - atomic distinct: empty
;; - compound: (cons Number ListOfNumber)

;; Functions:

;; ListOfNumber -> Number
;; produce total weight of the owls in the list
(check-expect (sum empty) 0)
(check-expect (sum (cons 60 empty)) (+ 60 0))
(check-expect (sum (cons 60 (cons 42 empty))) (+ 60 (+ 42 0)))

; (define (sum lon) 0) ;stub

(define (sum lon)
  (cond [(empty? lon) 0]
        [else
         (+ (first lon)                  
              (sum (rest lon)))]))

;; ListOfNumber -> Natural
;; produces the total number of weights in the list
(check-expect (count empty) 0)
(check-expect (count (cons 12 empty)) (+ 1 0))
(check-expect (count (cons 35 (cons 12 empty))) (+ 1 (+ 1 0)))

;(define (count lon) 0) ; stub

(define (count lon)
  (cond [(empty? lon) 0]
        [else
         (+ 1
              (count (rest lon)))]))