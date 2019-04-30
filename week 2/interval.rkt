;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname interval) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; SeatNum is Natural [1, 32]
;; interp. seat numbers in a row, 1 and 32 are aisle seats
(define SN1 1) ; aisle
(define SN2 12) ;middle
(define SN3 32) ;aisle

(define (fn-for-seat-num sn)
(... sn))

;; Template rules used:
;; -atomic non-distinct: Natural [1,32]
