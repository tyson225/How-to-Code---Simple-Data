;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |function composition|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; =====================
;; CONSTANTS

(define BLANK (square 0 "solid" "white"))

;; for testing:
(define I1 (rectangle 10 20 "solid" "blue"))
(define I2 (rectangle 20 30 "solid" "red"))
(define I3 (rectangle 30 40 "solid" "green"))

;; =====================
;; Data definitions:

;; ListOfImage is one of:
;; - empty
;; - (cons Image ListOfImage)
;; interp. An arbitrary number of images
(define LOI1 empty)
(define LOI2 (cons I1 (cons I2 empty)))

#;
(define (fn-for-loi loi)
  (cond [(empty? loi) (...)]
        [else
         (... (first loi)
              (fn-for-loi (rest loi)))]))

;; ====================
;; FUNCTIONS

;; ListOfImage -> Image
;; lay out images left to right in increasing order of sine
;; sort images in increasing order of size then lay htem out left to right
(check-expect (arrange-images (cons I1 (cons I2 empty)))
              (beside I1 I2  BLANK))
(check-expect (arrange-images (cons I2 (cons I1 empty)))
              (beside I1 I2 BLANK))

; (define (arrange-images loi) BLANK) ; stub

(define (arrange-images loi)
  (layout-images (sort-images loi)))

;; ListOfImage -> Image
;; place images beside eachother in order of list
(check-expect (layout-images empty) BLANK)
(check-expect (layout-images (cons I1 (cons I2  empty)))
              (beside I1 I2 BLANK))

; (define (layout-images loi) BLANK) ; stub

(define (layout-images loi)
  (cond [(empty? loi) BLANK]
        [else
         (beside (first loi)
                 (layout-images (rest loi)))]))

;; ListOfImage -> ListOfImage
;; sort images in increasing order of size
(check-expect (sort-images empty) empty)
(check-expect (sort-images (cons I1 (cons I2 empty)))
              (cons I1 (cons I2 empty)))
(check-expect (sort-images (cons I2 (cons I1 empty)))
              (cons I1 (cons I2  empty)))
(check-expect (sort-images (cons I3 (cons I1 (cons I2 empty))))
              (cons I1 (cons I2  (cons I3 empty))))

; (define (sort-images loi) loi) ; stub

(define (sort-images loi)
  (cond [(empty? loi) empty]
        [else
         (insert (first loi)
                 (sort-images (rest loi)))]))

;; Image ListOfImage -> ListOfImage
;; produces new list with sorted images in increasing order of size
;; ASSUME: loi is already sorted
(check-expect (insert I1 empty) (cons I1 empty))
(check-expect (insert I1 (cons I2 (cons I3 empty))) (cons I1 (cons I2 (cons I3 empty))))
(check-expect (insert I2 (cons I1 (cons I3 empty))) (cons I1 (cons I2 (cons I3 empty))))
(check-expect (insert I3 (cons I1 (cons I2 empty))) (cons I1 (cons I2 (cons I3 empty))))

; (define (insert img loi) loi) ; stub

(define (insert img loi)
  (cond [(empty? loi) (cons img empty)]
        [else
         (if (larger? img (first loi))
             (cons (first loi)
                   (insert img
                           (rest loi)))
             (cons img loi))]))

;; Image Image -> Boolean
;; produce true if img1 is bigger than img2
(check-expect (larger? (rectangle 3 4 "solid" "red") (rectangle 2 6 "solid" "red")) false)
(check-expect (larger? (rectangle 5 4 "solid" "red") (rectangle 2 6 "solid" "red")) true)
(check-expect (larger? (rectangle 3 5 "solid" "red") (rectangle 2 6 "solid" "red")) true)
(check-expect (larger? (rectangle 3 4 "solid" "red") (rectangle 5 6 "solid" "red")) false)
(check-expect (larger? (rectangle 3 4 "solid" "red") (rectangle 2 7 "solid" "red")) false)

; (define (larger? img1 img2) true) ; stub

(define (larger? img1 img2)
  (> (* (image-width img1) (image-height img1))
     (* (image-width img2) (image-height img2))))

