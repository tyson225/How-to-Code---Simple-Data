;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname space-invaders-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

;; Space Invaders
;; the purpose of this program is to bring together all the skills that I haved gained while enrolled in the
;; course. The program will simulate the classic game Space Invaders with a player controlled vehicle that
;; can fire projectiles at enemy ships that are coming toward the player form the top of the screen to the
;; bottom. If an enemy ship successfully reaches the bottom of the screen then the game stops

;; ====================
;; Constants:

(define WIDTH  300)
(define HEIGHT 500)

(define INVADER-X-SPEED 1.5)  ; speeds (not velocities) in pixels per tick
(define INVADER-Y-SPEED 1.5)
(define MOVE-INVADER-X (+ 150 INVADER-X-SPEED))
(define MOVE-INVADER-Y (+ 100 INVADER-Y-SPEED))
(define TANK-SPEED 2)
(define MISSILE-SPEED 10)

(define HIT-RANGE 10)

(define INVADE-RATE 100)

(define BACKGROUND (empty-scene WIDTH HEIGHT))

(define INVADER
  (overlay/xy (ellipse 10 15 "outline" "blue")              ; cockpit cover
              -5 6
              (ellipse 20 10 "solid"   "blue")))            ; saucer

(define TANK
  (overlay/xy (overlay (ellipse 28 8 "solid" "black")       ; tread center
                       (ellipse 30 10 "solid" "green"))     ; tread outline
              5 -14
              (above (rectangle 5 10 "solid" "black")       ; gun
                     (rectangle 20 10 "solid" "black"))))   ; main body

(define TANK-HEIGHT/2 (/ (image-height TANK) 2))

(define MISSILE (ellipse 5 15 "solid" "red"))

;; ======================
;; Data Definitions:

(define-struct game (invaders missiles tank))

;; Game is (make-game  (listof Invader) (listof Missile) Tank)
;; interp. the current state of a space invaders game
;;         with the current invaders, missiles and tank position

;; Game constants defined below Missile data definition

#;
(define (fn-for-game s)
  (... (fn-for-loinvader (game-invaders s))
       (fn-for-lom (game-missiles s))
       (fn-for-tank (game-tank s))))

(define-struct tank (x dir))

;; Tank is (make-tank Number Integer[-1, 1])
;; interp. the tank location is x, HEIGHT - TANK-HEIGHT/2 in screen coordinates
;;         the tank moves TANK-SPEED pixels per clock tick left if dir -1, right if dir 1

(define T0 (make-tank (/ WIDTH 2) 1))   ; center going right
(define T1 (make-tank 50 1))            ; going right
(define T2 (make-tank 50 -1))           ; going left

#;
(define (fn-for-tank t)
  (... (tank-x t) (tank-dir t)))

(define-struct invader (x y dx))

;; Invader is (make-invader Number Number Number)
;; interp. the invader is at (x, y) in screen coordinates
;;         the invader along x by dx pixels per clock tick

(define I1 (make-invader 150 100 12))           ; not landed, moving right
(define I2 (make-invader 150 HEIGHT -10))       ; exactly landed, moving left
(define I3 (make-invader 150 (+ HEIGHT 10) 10)) ; > landed, moving right

#;
(define (fn-for-invader invader)
  (... (invader-x invader) (invader-y invader) (invader-dx invader)))

(define-struct missile (x y))

;; Missile is (make-missile Number Number)
;; interp. the missile's location is x y in screen coordinates

(define M1 (make-missile 150 300))                               ; not hit U1
(define M2 (make-missile (invader-x I1) (+ (invader-y I1) 10)))  ; exactly hit U1
(define M3 (make-missile (invader-x I1) (+ (invader-y I1)  5)))  ; > hit U1

#;
(define (fn-for-missile m)
  (... (missile-x m) (missile-y m)))

(define G0 (make-game empty empty T0))
(define G1 (make-game empty empty T1))
(define G2 (make-game (list I1) (list M1) T1))
(define G3 (make-game (list I1 I2) (list M1 M2) T1))

;; ListOfInvader is one of:
;; - empty
;; - (cons invader ListOfInvader)
;; interp. a list of the invaders

(define LOI0 empty)
(define LOI1 (list I1))
(define LOI2 (list I1 I2 I3))

#;
(define (fn-for-loi loi)
  (cond [(empty? loi) (...)]
        [else
         (... (fn-for-invader (first loi))
              (fn-for-loi (rest loi)))]))

;; ListOfMissile is one of:
;; - empty
;; (cons missile ListOfMissile)
;; interp. a list of missiles that exist in the game

(define LOM0 empty)
(define LOM1 (list M1))
(define LOM2 (list M1 M2 M3))

#;
(define (fn-for-lom lom)
  (cond [(empty? lom) (...)]
        [else
         (... (fn-for-missile (first lom))
              (fn-for-lom (rest lom)))]))

;; =====================
;; Functions
;; start the program with (main 0)

(define (main s)
  (big-bang (make-game empty empty (make-tank (/ WIDTH 2) s))
    (on-tick   continue)
    (to-draw   render)
    (stop-when game-over go)
    (on-key    handle-key)))

;; Game -> Game
;; Continues the game to the next tick
;; - moves the following:
;; - invaders
;; - missiles
;; - tank
;; Also creates new invaders

; (define (continue s) s) ; stub

(define (continue s)
  (make-game (destroy-invader (game-missile s) (create-invader (move-invaders (game-invader s))))
             (move-missile (game-missile s))
             (move-tank (game-tank s))))

;; Game -> Image
;; Renders the image onto the screen

; (define (render s) BACKGROUND ; stub

(define (render s)
  (render-invader (game-invader s)
                  (render-missile (game-missile s)
                                  (render-tank (game-tank s)))))

;; Game -> Boolean
;; Determines wheither or not the game has been finished.
;; The condition for a game over is that an invader must "land"
;; at the bottom of the screen

; (define (game-over s) false)

(define (game-over s)
  (cond [(empty? (gmae-invader s)) false]
        [else
         (landed (game-imvader s))]))

;; Game -> Image
;; Displays the game over text on the screen

; (define (go s) BACKGROUND)

(define (go s)
  (place-image (text "GAME OVER!" 24 "black") (/ WIDTH 2) (/ HEIGHT 2) (render s)))

;; ListOfInvader -> Boolean
;; determines if the invader has landed which ends the game

; (define (landed l) false) ; stub

(define (landed loi)
  (cond [(empty? loi) false]
         [else
          (if (>= (invader-y (firsr loi)) HEIGHT)
              true
              (landed (rest loi)))]))

;; ListOfInvader Image -> Image
;; Creates the list of invaders for the image

; (define (render-invader loi img) img)

(define (render-invader loi ing)
  (cond [(empty? loi) img]
        [else
         (place-image INVADER
                      (invader-x (first loi))
                      (invader-y (first loi))
                      (render-invader (rest loi) img))]))

;; ListOf"Invader -> ListOfInvader
;; moves the invaders down one tick in the direction that they were travelling
(check-expect (move-invaders empty) empty)
(check-expect (move-invaders LOI2) (cons (make-invader MOVE-INVADER-X MOVE-INVADER-Y 1) empty))

; (define (move-invaders loi) loi)

(define (move-invaders loi)
  (cond [(empty? loi) empty]
        [else
         (cons (move-invader (first loi))
               (move-invaders (rest loi)))]))

;; Invader -> Invader
;; Moves the invader in the direction it is travelling
;; When the invader reaches the edge of the screen it will change
;; its direction.
(check-expect (move-invader I1) (make-invader MOVE-INVADER-X MOVE-INVADER-Y 1))
(check-expect (move-invader (make-invader WIDTH 100 1)) (make-invader WIDTH MOVE-INVADER-Y -1))
(check-expect (move-invader (make-invader WIDTH 100 -1)) (make-invader (- WIDTH INVADER-X-SPEED) MOVE-INVADER-Y -1))
(check-expect (move-invader (make-invader 0 100 -1)) (make-invader 0 MOVE-INVADER-Y 1))
(check-expect (move-invader (make-invader (+ 0 (- invader-x-speed 1)) 100 -1)) (make-invader 0 MOVE-INVADER-Y))

; (define (move-invader i) i) ; stub

(define (move-invader i)
  (cond [(< (+ (invader-x i) (* (invader-dx i) INVADER-X-SPEED)) 0)
         (make-invader 0 (+ (invader-y i) INVADER-Y-SPEED) (- (invader-dx i)))]
        [(> (+ (invader-x i) (+ (invader-dx i) INVADER-X-SPEED)) WIDTH)
         (make-invader WIDTH (+ (invader-y i) INVADER-Y-SPEED) (- (invader-dx i)))]
        [else
         (make-imvader (+ (invader-x i) (* INVADER-X-SPEED (invader-dx i))) (+ (invader-y i) INVADER-Y-SPEED) (invder-dx i))]))

;; ListOfInvader -> ListOfInvader
;; Adds new invaders to the list of invaders at a rate specified by
;; the INVADE-RATE constant

; (define (create-invader loi) loi)

(define (create-invader loi)
  (cond [(< (random 150) INVADE-RATE