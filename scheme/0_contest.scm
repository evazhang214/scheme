;;; Scheme Recursive Art Contest Entry
;;;
;;; Please do not include your name or personal info in this file.
;;;
;;; Title: <The All Seeing All Knowing Eye of Albert Wu>
;;;
;;; Description:
;;;   <As you look within
;;;    the eye of a CS God
;;;    you tremble in awe.>

(define (draw)
  (speed 0)
  (color "red")
  (repeat_fn 360 draw_big_circle 1)
  (color "black")
  (repeat_fn 180 draw_big_circle 2)

  (exitonclick)

 )

(define (draw_square)
  (fd 130) (rt 90) (fd 130) (rt 90) (fd 130) (rt 90) (fd 130) (rt 90))

(define (draw_small_circle)

  (circle 15))

(define (draw_big_circle)
  (circle 120))

;repeat function k times
(define (repeat_fn k fn degrees)
  (if (> k 0)
      (begin (fn) (rt degrees) 
        (repeat_fn (- k 1) fn degrees)))
)






; Please leave this last line alone.  You may add additional procedures above
; this line.
(draw)