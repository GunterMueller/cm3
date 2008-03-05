MODULE Subranges EXPORTS Main

; TYPE U1 = [ 0 .. 16_7F ]
; TYPE S1 = [ 0 .. 16_FF ]
; TYPE U2 = [ 0 .. 16_7FFF ]
; TYPE S2 = [ 0 .. 16_FFFF ]
; TYPE U3 = [ 0 .. 16_7FFFFF ]
; TYPE S3 = [ 0 .. 16_FFFFFF ]
; TYPE U4 = [ 0 .. 16_7FFFFFFF ]
; TYPE S4 = [ 16_FFFFFFFF .. 16_FFFFFFFF ]

; TYPE LU4 = [ 0L .. 16_7FFFFFFFL ]
; TYPE LS4 = [ 0L .. 16_FFFFFFFFL ]
; TYPE LU5 = [ 0L .. 16_7FFFFFFFFFL ]
; TYPE LS5 = [ 0L .. 16_FFFFFFFFFFL ]
; TYPE LU6 = [ 0L .. 16_7FFFFFFFFFFFL ]
; TYPE LS6 = [ 0L .. 16_FFFFFFFFFFFFL ]
; TYPE LU7 = [ 0L .. 16_7FFFFFFFFFFFFFL ]
; TYPE LS7 = [ 0L .. 16_FFFFFFFFFFFFFFL ]
; TYPE LU8 = [ 0L .. 16_7FFFFFFFFFFFFFFFL ]
; TYPE LS8 = [ 0L .. 16_FFFFFFFFFFFFFFFFL ]

; PROCEDURE Work ( )

  = VAR VU1 : U1 := 0
  ; VAR VS1 : S1 := 0
  ; VAR VU2 : U2 := 0
  ; VAR VS2 : S2 := 0
  ; VAR VU3 : U3 := 0
  ; VAR VS3 : S3 := 0
  ; VAR VU4 : U4 := 0
  ; VAR VS4 : S4 := 16_FFFFFFFF

  ; VAR VLU4 : LU4 := 0L 
  ; VAR VLS4 : LS4 := 0L 
  ; VAR VLU5 : LU5 := 0L
  ; VAR VLS5 : LS5 := 0L
  ; VAR VLU6 : LU6 := 0L
  ; VAR VLS6 : LS6 := 0L
  ; VAR VLU7 : LU7 := 0L
  ; VAR VLS7 : LS7 := 0L
  ; VAR VLU8 : LU8 := 0L
  ; VAR VLS8 : LS8 := 0L 
  ; VAR X : INTEGER 

  ; BEGIN
      X := VU1
    END Work

; BEGIN
    Work ()
  END Subranges
.
