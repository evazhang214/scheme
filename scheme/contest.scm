;;; Scheme Recursive Art Contest Entry
;;;
;;; Please do not include your name or personal info in this file.
;;;
;;; Title: <Endless Hallway>
;;;
;;; Description:
;;;   <Just keep walking down
;;;    Click-clack click-clack wandering
;;;	   You won't reach the end>
 


(define (draw_fractal center_pos length ratio depth)
	(define a (list (- (car center_pos) (/ length 2)) (- (cadr center_pos) (/ length 2))))
	(define b (list (- (car center_pos) (/ (* length ratio) 2 )) (- (cadr center_pos) (/ (* length ratio) 2))))
	(define m (list (/ (+ (car a) (car b)) 2) (/ (+ (cadr a) (cadr b)) 2)))
	(define (draw_tile i_side o_side mode num)
			(define e (list (- (car center_pos) (/ i_side 2)) (- (cadr center_pos) (/ i_side 2))))
			(define f (list (- (car center_pos) (/ o_side 2)) (- (cadr center_pos) (/ o_side 2))))
			(define (loop i)
				(penup)
				(goto (+ (car f) (/ (* (+ mode (* 2 i)) o_side) 7) ) (cadr f))
				(pendown)
				(begin_fill)
				(forward (/ o_side 7))
				(goto (+ (car e) (/ (* (+ (+ (* 2 i) 1) mode) i_side) 7)) (cadr e) )
				(backward (/ i_side 7))
				(goto (+ (car f) (/ (* (+ mode (* 2 i)) o_side) 7) ) (cadr f))
				(end_fill)
				(if (> i 0)
					(loop (- i 1))
				)	
			)
			(loop (- num 1))
	)

	(draw_tile (/ (+ (* ratio (* length 3)) length) 4) (* ratio length) 0 4)
	(draw_tile (/ (+ (* ratio length) length) 2) (/ (+ (* ratio (* length 3)) length) 4) 1 3)
	(draw_tile (/ (+ (* ratio length) (* 3 length) ) 4) (/ (+ (* ratio length) length) 2) 0 4)
	(draw_tile length (/ (+ (* ratio length) (* 3 length) ) 4) 1 3)
	(penup)

	(define (draw_door mode)
		(define (door x r color)
			(goto (* mode (car b)) (cadr b))
			(pendown)
			(fillcolor color)
			(begin_fill)
			(goto (* mode (car b)) (/ (- (cadr b)) r))
			(goto (* mode (car x)) (/ (- (cadr x)) r))
			(goto (* mode (car x)) (cadr x))
			(end_fill)
		)

		(door a 1 'black)
		(door m 2 'yellow)

		(pencolor 'white)
		(fillcolor 'black)
		(begin_fill)
		(define c (* mode (* length (/ (- 1 ratio) 4))))
		(define d (* 0.75 (/ (* length (+ ratio 1)) 2)))
		(forward c)
		(left 90)
		(forward d)
		(left 90)
		(forward c)
		(left 90)
		(forward d)
		(end_fill)

		(left 90)
		(penup)
	)

	(draw_door 1)
	(draw_door -1)

	(goto (car m) (- (cadr m)))
	(pendown)
	(begin_fill)
	(goto (- (car m)) (- (cadr m)))
	(goto (- (car a)) (- (cadr a)))
	(goto (car a) (- (cadr a)))
	(goto (car m) (- (cadr m)))
	(end_fill)

	
	(if (> depth 0)
		(draw_fractal center_pos (* length ratio) ratio (- depth 1))
	)
)



(define (draw)
  ; *YOUR CODE HERE*
  (speed 1000000000)
  (right 90)
  ;(bgcolor 'oranges)
  (draw_fractal (list 0 0) 3 2 10)

)


  (exitonclick)

; Please leave this last line alone.  You may add additional procedures above
; this line.
(draw)
