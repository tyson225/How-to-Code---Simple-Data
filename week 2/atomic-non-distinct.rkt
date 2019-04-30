;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname atomic-non-distinct) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; CityName is String
;; interp. the name of a city

(define CN1 "Boston")
(define CN2 "Vancover")
#;
(define (fn-for-city-name cn)
  (... cn))

;; Template rules used:
;; - atomic non-distint: String

;; Functions

;; CityName -> Boolean
;; produce true if the given city is the best in the world

(check-expect (best? "Boston") false)
(check-expect (best? "Hogsmeade") true)

;(define (best? cn) false) ;stub

; took template from CityName
#;
(define (best? cn)
  (if (string=? cn "Hogsmeade")
      true
      false))

(define (best? cn)
  (string=? cn "Hogsmeade"))

