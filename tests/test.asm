; main start -------------------------
.import print
.import init
.import new
.import delete
lis $4
.word 4
lis $11
.word 1
sub $29, $30, $4  ; Set frame pointer
sw $1, -4($30)
sub $30, $30, $4
sw $2, -4($30)
sub $30, $30, $4
; Heap initialization
sw $2, -8($29)
; Generate init
sw $31, -4($30)  ; Push $31
sub $30, $30, $4
lis $5
.word init
jalr $5
lw $31, 0($30)  ; Pop to $31
add $30, $30, $4
; -------------
; ------------------------------------
lis $3
.word 1
sw $3, -4($30)  ; Push $3
sub $30, $30, $4
lis $3
.word 0
sw $3, -4($30)  ; Push $3
sub $30, $30, $4
lis $3
.word 0
sw $3, -4($30)  ; Push $3
sub $30, $30, $4
lis $3
.word 1
sw $3, -4($30)  ; Push $3
sub $30, $30, $4
loop1:
lw $3, -12($29)
sw $3, -4($30)  ; Push $3
sub $30, $30, $4
lis $3
.word 32
lw $5, 0($30)  ; Pop to $5
add $30, $30, $4
slt $3, $5, $3
beq $3, $0, endwhile1
lis $3
.word 1023
add $1, $3, $0
; Generate alloc
sw $31, -4($30)  ; Push $31
sub $30, $30, $4
lis $5
.word new
jalr $5
lw $31, 0($30)  ; Pop to $31
add $30, $30, $4
; --------------
bne $3, $0, 1
add $3, $11, $0
sw $3, -20($29)
lis $3
.word 0
sw $3, -16($29)
loop2:
lw $3, -16($29)
sw $3, -4($30)  ; Push $3
sub $30, $30, $4
lis $3
.word 1023
lw $5, 0($30)  ; Pop to $5
add $30, $30, $4
slt $3, $5, $3
beq $3, $0, endwhile2
lw $3, -12($29)
sw $3, -4($30)  ; Push $3
sub $30, $30, $4
lw $3, -16($29)
lw $5, 0($30)  ; Pop to $5
add $30, $30, $4
mult $5, $3
mflo $3
sw $3, -4($30)  ; Push $3
sub $30, $30, $4
lw $3, -20($29)
sw $3, -4($30)  ; Push $3
sub $30, $30, $4
lw $3, -16($29)
mult $3, $4
mflo $3
lw $5, 0($30)  ; Pop to $5
add $30, $30, $4
add $3, $5, $3
lw $5, 0($30)  ; Pop to $5
add $30, $30, $4
sw $5, 0($3)
lw $3, -16($29)
sw $3, -4($30)  ; Push $3
sub $30, $30, $4
lis $3
.word 1
lw $5, 0($30)  ; Pop to $5
add $30, $30, $4
add $3, $5, $3
sw $3, -16($29)
beq $0, $0, loop2
endwhile2:
lw $3, -20($29)
beq $3, $11, skipDelete1
add $1, $3, $0
; Generate dealloc
sw $31, -4($30)  ; Push $31
sub $30, $30, $4
lis $5
.word delete
jalr $5
lw $31, 0($30)  ; Pop to $31
add $30, $30, $4
; ----------------
skipDelete1:
lw $3, -12($29)
sw $3, -4($30)  ; Push $3
sub $30, $30, $4
lis $3
.word 1
lw $5, 0($30)  ; Pop to $5
add $30, $30, $4
add $3, $5, $3
sw $3, -12($29)
beq $0, $0, loop1
endwhile1:
lis $3
.word 0
; main end ---------------------------
jr $31
; ------------------------------------
