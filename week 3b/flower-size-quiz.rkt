;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname flower-size-quiz) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; a flower that grows over time

;; =================
;; CONSTANTS
(define WIDTH 400)
(define HEIGHT 600)
(define MTS (empty-scene WIDTH HEIGHT "lightblue"))

(define FLOWER-MIDDLE (circle 15 "solid" "black"))
(define FLOWER-PETAL (ellipse 30 50 "solid" "orange"))
(define FLOWER
  (overlay (above FLOWER-MIDDLE (rectangle 1 10 0 "white"))
           (overlay/align "center" "top" (above (beside (rotate 216 FLOWER-PETAL) (rectangle 1 1 0 "white") (rotate 144 FLOWER-PETAL))
                                                (rotate 180 (beside (rotate 72 FLOWER-PETAL) (rectangle 10 0 0 "white") (rotate 288 FLOWER-PETAL))))
                          (above (rectangle 1 61 0 "white") FLOWER-PETAL))))

;; ==================
;; Data Definitions

(define-struct flower (x y size))
;; flower is (make-flower Integer Integer Natural)
;; interp. a flower with an x and y position as well as a side length in pixels
(define F1 (make-flower 0 0 0))
(define F2 (make-flower (/ WIDTH 2) (/ HEIGHT 2) 15))

#;
(define (fn-for-flower)
  (... (flower-x f)
       (flower-y f)
       (flower-size f)))

;; Template rules used:
;; Compound: Three fields

;; ===================
;; FUNCTIONS

;; Flower -> Flower
;; starts the program
;; (main (make-flower (/ WIDTH 2) (/ HEIGHT 2) 0))

(define (main f)
  (big-bang f
    (on-tick   next-f)          ; Flower -> Flower
    (to-draw   render-f)        ; Flower -> Image
    (on-mouse  handle-mouse)))  ; Flower Integer Integer MouseEvent -> Flower

;; Flower -> Flower
;; incrementor for the size of the flower that increaed per tick
(check-expect (next-f (make-flower  0  0 10)) (make-flower  0  0 11))
(check-expect (next-f (make-flower 10 20 30)) (make-flower 10 20 31))
(check-expect (next-f (make-flower 40 50 60)) (make-flower 40 50 61))

; (define (next-f) f)   ; stub
;; used the template for Flower

(define (next-f f)
  (make-flower (flower-x f)
               (flower-y f)
               (+ 1 (flower-size f))))

;; Flower -> Image
;; renders the image of the flower size on the scene within the parameters of the MTS
(check-expect (render-f (make-flower 10 10  0)) (place-image empty-image
                                                         10 10 MTS))
(check-expect (render-f (make-flower 20 20  10)) (place-image (rotate  10 (scale (/ 10 100) FLOWER))
                                                         20 20 MTS))
(check-expect (render-f (make-flower 30 30  20)) (place-image (rotate  20 (scale (/ 20 100) FLOWER))
                                                         30 30 MTS))
(check-expect (render-f (make-flower 30 30 361)) (place-image (rotate 361 (scale (/ 361 100) FLOWER))
                                                         30 30 MTS))

; (define (render-f f) MTS) ; stub
;; used the template for Flower

(define (render-f f)
  (place-image (if (zero? (flower-size f))
                   empty-image
                   (rotate (remainder (flower-size f) 360) (scale (/ (flower-size f) 100) FLOWER)))
               (flower-x f)
               (flower-y f)
               MTS))

;; Flower Integer Integer MouseEvent -> Flower
;; resets the size of the flower with one at has a size of 0 on mouse-click
(check-expect (handle-mouse (make-flower  0  0  0) 10 10 "button-down") (make-flower 10 10 0))
(check-expect (handle-mouse (make-flower  0  0  0) 20 20 "button-down") (make-flower 20 20 0))
(check-expect (handle-mouse (make-flower 30 30 40) 50 50 "button-down") (make-flower 50 50 0))
(check-expect (handle-mouse (make-flower 35 35 40) 50 50 "button-up")   (make-flower 35 35 40))

; (define (handle-mouse f x y mo) f)   ;stub
;; used the template for MouseEvent

(define (handle-mouse f x y mo)
  (cond [(mouse=? mo "button-down") (make-flower x y 0)]
        [else f]))