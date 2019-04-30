;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname booleans) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;true
;false

(require 2htdp/image)

(define WIDTH 100)
(define HEIGHT 100)

;(> WIDTH HEIGHT)
;(>= WIDTH HEIGHT)

;(= 1 1)
;(= 1 2)
;(> 3 9)

;(string=? "foo" "bar")

(define i1 (rectangle 10 20 "solid" "red"))
(define i2 (rectangle 20 10 "solid" "blue"))

(> (image-height i1) (image-height i2))

(< (image-width i1) (image-width i2))

(and (> (image-height i1) (image-height i2))
     (< (image-width i1) (image-width i2)))
   
    
 