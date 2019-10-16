#|PROBLEM:
You have 2 pitchers which can hold x and y liters without any markings.
You need n liters of water in the x pitcher, how can you do it?
This code solves the problem using breadth first.
It returns a series of numbers which make reference to some instructions.
1 is fill x
2 is fill y
3 is empty x
4 is empty y
5 is pass the water from y to x
6 is pass the water from x to y|#

(DEFUN FILL-X ()  ;FUNCTION 1
  "Pitcher problem: fills the pitcher x"
  (IF (NOT (EQ X (CAR LS)))
    (LIST (CONS X (CDR LS)) (+ 1 (SECOND (CAR (LAST ABIERTO)))) P (+ 1 P2) 1)))

(DEFUN FILL-Y ()  ;FUNCTION 2
  "Pitcher problem: fills the pitcher y"
  (IF (NOT (EQ Y (CADR LS)))
    (LIST (LIST (CAR LS) Y) (+ 2 (SECOND (CAR (LAST ABIERTO)))) P (+ 1 P2) 2)))

(DEFUN EMPTY-X ()  ;FUNCTION 3
  "Pitcher problem: empties the pitcher x"
  (IF (NOT (EQ 0 (CAR LS)))
    (LIST (CONS 0 (CDR LS)) (+ 3 (SECOND (CAR (LAST ABIERTO)))) P (+ 1 P2) 3)))

(DEFUN EMPTY-Y ()  ;FUNCTION 4
  "Pitcher problem: empties the pitcher y"
  (IF (NOT (EQ 0 (CADR LS)))
  (LIST (LIST (CAR LS) 0)(+ 4 (SECOND (CAR (LAST ABIERTO)))) P (+ 1 P2) 4)))

(DEFUN PASS-YX ()  ;FUNCTION 5
  "Pitcher problem: passes water from y to x"
  (IF (NOT (OR (EQ 0 (CADR LS)) (EQ X (CAR LS))))
    (IF (>= (- X (CAR LS)) (CADR LS))
      (LIST (LIST (+ (CAR LS) (CADR LS)) 0) (+ 5 (SECOND (CAR (LAST ABIERTO)))) P (+ 1 P2) 5)
      (LIST (LIST X (- (CADR LS) (- X (CAR LS)))) (+ 5 (SECOND (CAR (LAST ABIERTO)))) P (+ 1 P2) 5))))

(DEFUN PASS-XY ()  ;FUNCTION 6
  "Pitcher problem: passes water from x to y"
  (IF (NOT (OR (EQ 0 (CAR LS)) (EQ Y (CADR LS))))
    (IF (>= (- Y (CADR LS)) (CAR LS))
      (LIST (LIST 0 (+ (CAR LS) (CADR LS))) (+ 6 (SECOND (CAR (LAST ABIERTO)))) P (+ 1 P2) 6)
      (LIST (LIST (- (CAR LS) (- Y (CADR LS))) Y) (+ 6 (SECOND (CAR (LAST ABIERTO)))) P (+ 1 P2) 6))))

(DEFUN ADD-TO-END (OBJ LST)
  (COND
    ((NULL LST) (LIST OBJ))
    (T (PUSH OBJ (CDR (LAST LST))) LST)))

;(SITUACION NUMERO PADRE PROFUNDIDAD OPERACION)
(DEFUN SOLVE-PITCHERS (X1 Y1 N1)
  (SETQ X X1 Y Y1 N N1 ABIERTO NIL CERRADO NIL R NIL)
  (IF(INTEGERP (/ N (GCD X Y))) ;GCD=GREATEST COMMON DIVISOR
    (PROGN (PUSH '(NIL 0 0 0 NIL) ABIERTO)
    (PUSH '((0 0) 0 0 0 NIL) ABIERTO)
    (SOLVE-PITCHERS-AUX))
    (WRITE "NO ES POSIBLE"))
    R)

(DEFUN SOLVE-PITCHERS-AUX ()
  (COND
    ((NULL (FIRST (CAR ABIERTO)))(POP ABIERTO)(SOLVE-PITCHERS-AUX))
    ((NULL ABIERTO) (WRITE "NO SE PUDO"))
    ((> (FOURTH (CAR ABIERTO)) 49) (WRITE "DEMASIADAS OPERACIONES"))
    (T (PUSH (POP ABIERTO) CERRADO)
      (IF (EXPAND (CAR CERRADO))
        (RWGRESO (CAR (LAST ABIERTO)))
        (SOLVE-PITCHERS-AUX)))))

(DEFUN EXPAND (LST)
  (SETQ LS (FIRST LST) P (SECOND LST) P2 (FOURTH LST))
  (SETQ AUX (LIST
    (FILL-X) (FILL-Y) (EMPTY-X) (EMPTY-Y) (PASS-YX) (PASS-XY)))
  (EVALUAR))

(DEFUN EVALUAR ()
  (IF (NULL AUX)
    NIL
    (PROGN (SETQ AUX1 (POP AUX))
      (IF (NOT (NULL AUX1))
        (IF (EQ N (CAAR AUX1))
          (PROGN (ADD-TO-END AUX1 ABIERTO) T)
          (PROGN (IF (NOT-IN)
              (ADD-TO-END AUX1 ABIERTO))
            (EVALUAR)))
        (EVALUAR)))))

(DEFUN NOT-IN ()
  (OR (NULL (MEMBER (FIRST AUX1) (MAPCAR #'FIRST ABIERTO) :test #'equal))
    (NULL (MEMBER (FIRST AUX1) (MAPCAR #'FIRST CERRADO) :test #'equal))))

(DEFUN RWGRESO (LST)
  (IF (NOT (EQ (SECOND LST) 0))
    (PROGN (PUSH (FIFTH LST) R)
    (LOOP
      (SETQ AUX (POP CERRADO))
      (WHEN (EQ (SECOND AUX) (THIRD LST)) (RWGRESO (RWGRESO AUX)))))))
