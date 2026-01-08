include Irvine32.inc
include macros.inc






BallPath STRUCT
    xPos        BYTE ?
    yPos        BYTE ?
    VDir        SBYTE ?
    HDir        SBYTE ?
    active      BYTE 0
    color       BYTE ?
    moveStage   BYTE 0
    moveCount   BYTE 0
    prevXDir    SBYTE ?
    prevYDir    SBYTE ?
    prevXPos    BYTE ?
    prevYPos    BYTE ?
    prevMoveStage BYTE ?
    prevMoveCount BYTE ?
    invis   BYTE 0

BallPath ENDS

.data

LEVEL1_DELAY equ 75  ; Original delay
LEVEL2_DELAY equ 50  ; Faster level delay
LEVEL3_DELAY equ 25

CurrentLevelDelay DWORD LEVEL1_DELAY  ;

PlayerName BYTE 50 DUP(?)  ; Buffer to store player's name
PlayerNamePrompt BYTE "Enter your name : ", 0
InstructionText BYTE "Instructions:", 0
InstructionMove BYTE "- Press Q,W,E,A,D,Z,X,C to move", 0
InstructionShoot BYTE "- Press space to shoot", 0
PressEnterToContinue BYTE "Press ENTER to start the game", 0

MAX_FILENAME_LENGTH equ 50
ScoreFile BYTE "highscores.txt", 0
ScoreBuffer BYTE MAX_FILENAME_LENGTH DUP(?)
CurrentScore DWORD 0

NextBallColor BYTE ?  

MAX_BALL_LENGTH equ 20; Maximum number of balls in the line
MAX_BALL_SPAWNS equ 10; Maximum number of ball spawns
MAX_BALL_POSS equ 100

TotalBallSpawns BYTE 0

walls BYTE " _____________________________________________________________________________ ", 0
BYTE "|    ---       ________________________________________________________       |", 0
BYTE "|   |   |     |                                                        |      |", 0
BYTE "|    | |      | |----------------------------------------------------| |      |", 0
BYTE "|    | |      | |                                                    | |      |", 0
BYTE "|    | |      | |                                                    | |      |", 0
BYTE "|    | |     /   \                                                   | |      |", 0
BYTE "|    | |    |    |                                                   | |      |", 0
BYTE "|    | |    |    |                                                   | |      |", 0
BYTE "|    | |     ----                                                    | |      |", 0
BYTE "|    | |                             ---                             | |      |", 0
BYTE "|    | |                            |   |                            | |      |", 0
BYTE "|    | |                            |   |                            | |      |", 0
BYTE "|    | |                            |   |                            | |      |", 0
BYTE "|    | |                             ---                             | |      |", 0
BYTE "|    | |                                                             | |      |", 0
BYTE "|    | |                                                             | |      |", 0
BYTE "|    | |                                                             | |      |", 0
BYTE "|    | |                                                             | |      |", 0
BYTE "|    | |                                                             | |      |", 0
BYTE "|    | |____________________________________________________________ | |      |", 0
BYTE "|    |                                                                 |      |", 0
BYTE "|    |-----------------------------------------------------------------|      |", 0
BYTE "|                                                                             |", 0
BYTE "|_____________________________________________________________________________|", 0

walls2 BYTE " _____________________________________________________________________________ ", 0
BYTE "|    ---______________________________________________________                |", 0
BYTE "|   |                                                         \               |", 0
BYTE "|    ___-----------------------------------------------------\ \              |", 0
BYTE "|          ______________________________--                   \ \             |", 0
BYTE "|         /                                |                   \ \            |", 0
BYTE "|        / / ----------------------------__                     \ \           |", 0
BYTE "|       / /                                                      \ \          |", 0
BYTE "|      / /                                                        \ \         |", 0
BYTE "|     / /                                                          \ \        |", 0
BYTE "|    { }                             ---                            { }       |", 0
BYTE "|    { }                            |   |                           { }       |", 0
BYTE "|    { }                            |   |                           { }       |", 0
BYTE "|    { }                            |   |                           { }       |", 0
BYTE "|    \ \                             ---                            { }       |", 0
BYTE "|     \ \                                                           / /       |", 0
BYTE "|      \ \                                                         / /        |", 0
BYTE "|       \ \                                                       / /         |", 0
BYTE "|        \ \                                                     / /          |", 0
BYTE "|         \ \                                                   / /           |", 0
BYTE "|          \ \                                                 / /            |", 0
BYTE "|           \ \_______________________________________________/ /             |", 0
BYTE "|            \                                                 /              |", 0
BYTE "|             \-----------------------------------------------/               |", 0
BYTE "|_____________________________________________________________________________|", 0

walls3 BYTE " _____________________________________________________________________________ ", 0
BYTE "|    ---__________________________________________________________            |", 0
BYTE "|   |                                                             \           |", 0
BYTE "|    ___---------------------------------------------------------\ \          |", 0
BYTE "|                                                                 \ \         |", 0
BYTE "|                                                                / /          |", 0
BYTE "|        _______________________________________________________/ /           |", 0
BYTE "|       /                                                        /            |", 0
BYTE "|      / /------------------------------------------------------/             |", 0
BYTE "|     / /                                                                     |", 0
BYTE "|    { }                             ---                                      |", 0
BYTE "|    { }                            |   |                                     |", 0
BYTE "|    { }                            |   |                                     |", 0
BYTE "|    { }                            |   |                                     |", 0
BYTE "|    { }                             ---                                      |", 0
BYTE "|     \ \                                                                     |", 0
BYTE "|      \ \___________________________________________________________         |", 0
BYTE "|       \                                                            \        |", 0
BYTE "|        \----------------------------------------------------------\ \       |", 0
BYTE "|                                                                    \ \      |", 0
BYTE "|                                                                   / /       |", 0
BYTE "|           _---___________________________________________________/ /        |", 0
BYTE "|           |                                                       /         |", 0
BYTE "|           -__----------------------------------------------------/          |", 0
BYTE "|_____________________________________________________________________________|", 0




player_right BYTE "   ", 0
BYTE "  -", 0
BYTE "   ", 0

player_left BYTE "   ", 0
BYTE "-  ", 0
BYTE "   ", 0

player_up BYTE " | ", 0
BYTE "   ", 0
BYTE "   ", 0

player_down BYTE "   ", 0
BYTE "   ", 0
BYTE " | ", 0

player_upright BYTE "  /", 0
BYTE "   ", 0
BYTE "   ", 0

player_upleft BYTE "\  ", 0
BYTE "   ", 0
BYTE "   ", 0

player_downright BYTE "   ", 0
BYTE "   ", 0
BYTE "  \", 0

player_downleft BYTE "   ", 0
BYTE "   ", 0
BYTE "/  ", 0

BallColors BYTE 4, 1, 14, 2, 5
CurrentColorIndex BYTE 0

BallLine BallPath MAX_BALL_POSS dup(<>)
NumActiveBalls BYTE 0
CurrentPathStage BYTE 0
PathStep BYTE 0
BallSpawnTimer BYTE 0
GameTickCount DWORD 0;

xPos BYTE 56
yPos BYTE 15

xDir SBYTE 0
yDir SBYTE 0

inputChar BYTE 0
direction BYTE "d"

color_red BYTE 4
color_green BYTE 2
color_yellow BYTE 14

fire_color BYTE 14
fire_symbol BYTE "*", 0
fire_row BYTE 0
fire_col BYTE 0

score BYTE 0
lives BYTE 3
levelInfo BYTE 1

counter1 BYTE 0
counter2 BYTE 0

NextBallIndex BYTE 0
GameActive BYTE 1


BallsStartedSpawning BYTE 0  









.code

DisplayInstructionsScreen PROC
    call Clrscr

    mov eax, White + (Blue * 16)
    call SetTextColor

    ; Center the title
    mov dl, 35
    mov dh, 5
    call GoToXY
    mWrite "GAME INSTRUCTIONS"

    mov dl, 25
    mov dh, 8
    call GoToXY
    mov edx, OFFSET InstructionText
    call WriteString

    mov dl, 30
    mov dh, 10
    call GoToXY
    mov edx, OFFSET InstructionMove
    call WriteString

    mov dl, 30
    mov dh, 11
    call GoToXY
    mov edx, OFFSET InstructionShoot
    call WriteString

    ; Prompt for name
    mov dl, 25
    mov dh, 14
    call GoToXY
    mov edx, OFFSET PlayerNamePrompt
    call WriteString

    ; Read player name
    mov edx, OFFSET PlayerName
    mov ecx, 50
    call ReadString

    mov dl, 30
    mov dh, 16
    call GoToXY
    mov edx, OFFSET PressEnterToContinue
    call WriteString

wait_for_enter:
    mov eax, 50
    call Delay

    mov eax, 0
    call ReadKey
    jz wait_for_enter

    cmp al, VK_RETURN
    jne wait_for_enter

    ret
DisplayInstructionsScreen ENDP

DrawColorIndicator PROC
    pushad
    
    ; Save cursor position
    mov dl, 57
    mov dh, 16
    call GoToXY
    
    ; Set color based on the next ball color
    movzx eax, fire_color
    call SetTextColor

    mov al, '*'
    call WriteChar
    
    ; Reset text color
    mov eax, white + (black * 16)
    call SetTextColor
    
    popad
    ret
DrawColorIndicator ENDP

SaveHighScore PROC
    pushad
    
    mov edx, OFFSET ScoreFile
    call CreateOutputFile
    mov ebx, eax    
    
    mov eax, CurrentScore
    call WriteDec
    

    mov eax, ebx
    call CloseFile
    
    popad
    ret
SaveHighScore ENDP

LoadHighScore PROC
    pushad
    
    ; Open file for reading
    mov edx, OFFSET ScoreFile
    call OpenInputFile
    mov ebx, eax    ; Save file handle
    
    ; Read score
    mov edx, OFFSET ScoreBuffer
    mov ecx, MAX_FILENAME_LENGTH
    call ReadFromFile
   
    
    mov eax, ebx
    call CloseFile
    
    popad
    ret
LoadHighScore ENDP


; Pause Scre
DrawPauseScreen PROC
    pushad
    call Clrscr
    
    ; Set color
    mov eax, White + (Blue * 16)
    call SetTextColor
    
    mov dl, 35
    mov dh, 10
    call GoToXY
    mWrite "GAME PAUSED"
    
    mov dl, 30
    mov dh, 12
    call GoToXY
    mWrite "Press P to continue"
    
    mov dl, 30
    mov dh, 13
    call GoToXY
    mWrite "Press ESC to quit"
    
    popad
    ret
DrawPauseScreen ENDP

;sfnskfnsknfksnfknf
DrawLoseScreen PROC
    pushad
    call Clrscr
    

    mov eax, White + (Red * 16)
    call SetTextColor
    
    mov dl, 35
    mov dh, 10
    call GoToXY
    mWrite "GAME OVER"
    
    ; Display score
    mov dl, 33
    mov dh, 12
    call GoToXY
    mWrite "Your Score: "
    mov al, score
    call WriteDec
    
    ; Save high score
    mov CurrentScore, eax
    call SaveHighScore
    
    mov dl, 30
    mov dh, 14
    call GoToXY
    mWrite "Press ESC to exit"
    
    popad
    ret
DrawLoseScreen ENDP


CheckChain PROC
    pushad

    mov esi, OFFSET BallLine
    mov ecx, MAX_BALL_LENGTH
    dec ecx 

check_ball:
    ; Skip if current ball is inactive
    cmp [esi].BallPath.active, 0
    je next_ball

    ; Get the color of the current ball
    mov al, [esi].BallPath.color


    mov edi, esi  ; Save start of potential chain
    add esi, TYPE BallPath
    
    ; First check if next ball is active and same color
    cmp [esi].BallPath.active, 0
    je next_ball
    cmp [esi].BallPath.color, al
    jne next_ball

    add esi, TYPE BallPath
    cmp [esi].BallPath.active, 0
    je next_ball
    cmp [esi].BallPath.color, al
    jne next_ball

    mov esi, edi  

    ; Deactivate first ball
    mov [esi].BallPath.active, 0
    sub NumActiveBalls, 1

    add esi, TYPE BallPath
    ; Deactivate second ball
    mov [esi].BallPath.active, 0
    sub NumActiveBalls, 1

    add esi, TYPE BallPath
    ; Deactivate third ball
    mov [esi].BallPath.active, 0
    sub NumActiveBalls, 1

    add score,10

next_ball:
    add esi, TYPE BallPath
    loop check_ball

    popad
    ret
CheckChain ENDP

MaintainChain PROC
    pushad
    
    ; First pass---------------------Mark gaps between active balls
    mov esi, OFFSET BallLine
    mov ecx, MAX_BALL_LENGTH
    dec ecx                     ; Need at least one more ball to check
    
find_gaps:
    ; Skip if current ball is inactive
    cmp [esi].BallPath.active, 0
    je next_check
    
    ; Look ahead for gaps
    push esi
    push ecx
    add esi, TYPE BallPath
    
gap_check:
    cmp [esi].BallPath.active, 0
    jne end_gap_check          ; Found next active ball, no gap
    
    push esi                   ; Save gap position
    
find_next_active:
    add esi, TYPE BallPath
    cmp esi, OFFSET BallLine + (MAX_BALL_LENGTH * TYPE BallPath)
    jae no_more_active         ; Reached end of array
    
    cmp [esi].BallPath.active, 1
    je found_active_ball
    jmp find_next_active
    
found_active_ball:
    ; Move active ball to gap position
    pop edi                    ; Recover gap position
    
    ; Copy ball data
    push ecx
    mov ecx, TYPE BallPath
    rep movsb
    pop ecx
    
    ; Mark original position as inactive
    mov BYTE PTR [esi - TYPE BallPath], 0
    jmp end_gap_check
    
no_more_active:
    pop esi                    
    
end_gap_check:
    pop ecx
    pop esi
    
next_check:
    add esi, TYPE BallPath
    loop find_gaps
    
    popad
    ret
MaintainChain ENDP


AddBallAtEnd PROC
    pushad
    
    ; Find the last active ball in the chain
    mov esi, offset BallLine
    mov ebx, 0        ; Will hold address of last active ball
    mov ecx, MAX_BALL_LENGTH

find_last_ball:
    cmp [esi].BallPath.active, 1
    jne check_found   ; If  hit an inactive ball check if we found any active balls
    mov ebx, esi      ; Save address of current active ball
    add esi, TYPE BallPath
    loop find_last_ball
    jmp found_active_ball

check_found:
    test ebx, ebx     ; Check if found any active balls
    jz done           
    
found_active_ball:
    ; ebx contains last active ball's address
    
    ; Find next available slot
    mov esi, offset BallLine
    mov ecx, MAX_BALL_LENGTH

find_slot:
    cmp [esi].BallPath.active, 0
    je found_slot
    add esi, TYPE BallPath
    loop find_slot
    jmp done  ; No empty slots found  IDDDD

found_slot:
    ; Initialize the new ball with the last active ball's previous state
    mov al, [ebx].BallPath.prevXPos
    mov [esi].BallPath.xPos, al
    
    mov al, [ebx].BallPath.prevYPos
    mov [esi].BallPath.yPos, al
    
    mov al, [ebx].BallPath.prevXDir
    mov [esi].BallPath.VDir, al
    
    mov al, [ebx].BallPath.prevYDir
    mov [esi].BallPath.HDir, al
    
    mov al, [ebx].BallPath.prevMoveStage
    mov [esi].BallPath.moveStage, al
    
    mov al, [ebx].BallPath.prevMoveCount
    mov [esi].BallPath.moveCount, al

    ; Set ball color
    movzx eax, CurrentColorIndex
    mov ebx, OFFSET BallColors
    mov cl, [ebx + eax]
    mov [esi].BallPath.color, cl

    ; Increment and wrap color index
; Update color cycling logic
inc CurrentColorIndex

; Check number of colors based on level
cmp levelInfo, 3
je use_five_colors
cmp CurrentColorIndex, 4
jb skip_reset_color
mov CurrentColorIndex, 0
jmp skip_reset_color

use_five_colors:
cmp CurrentColorIndex, 5
jb skip_reset_color
mov CurrentColorIndex, 0

skip_reset_color:

    mov [esi].BallPath.active, 1
    inc NumActiveBalls
    inc TotalBallSpawns

done:
    popad
    ret
AddBallAtEnd ENDP



; Helper procedure to clear a specific position
ClearPosition PROC
call GoToXY
mov al, ' '
call WriteChar
ret
ClearPosition ENDP

DrawBalls PROC
pushad
mov ecx, MAX_BALL_LENGTH
mov esi, offset BallLine

draw_loop:
cmp[esi].BallPath.active, 1
jne skip_ball

; Skip drawing if ball is invisible
cmp[esi].BallPath.invis, 1
je skip_ball

; Clear old position first
mov dl, [esi].BallPath.xPos
mov dh, [esi].BallPath.yPos
call GoToXY

; Set ball color
movzx eax, [esi].BallPath.color
call SetTextColor
mWrite "*"

skip_ball:
add esi, TYPE BallPath
loop draw_loop

mov eax, White + (Black * 16)
call SetTextColor

popad
ret
DrawBalls ENDP


;INI BALLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLll
InitializeBall PROC
pushad

; Check if max ball spawns reached
cmp TotalBallSpawns, MAX_BALL_SPAWNS
jae done

; Find next available slot
mov esi, offset BallLine
mov ecx, MAX_BALL_LENGTH

find_slot:
cmp [esi].BallPath.active, 0
je found_slot
add esi, TYPE BallPath
loop find_slot
jmp done

found_slot:

mov BallsStartedSpawning, 1

; Initialize the new ball
mov [esi].BallPath.xPos, 25
mov [esi].BallPath.yPos, 6
mov [esi].BallPath.VDir, 1
mov [esi].BallPath.HDir, 0
mov [esi].BallPath.moveStage, 0
mov [esi].BallPath.moveCount, 0

; Set ball COLOEERRRRRR
movzx eax, CurrentColorIndex
mov ebx, OFFSET BallColors
mov cl, [ebx + eax]
mov [esi].BallPath.color, cl

; Increment and wrap color index
; Update color cycling logic
inc CurrentColorIndex

; Check number o level
cmp levelInfo, 3
je use_five_colors
cmp CurrentColorIndex, 4
jb skip_reset_color
mov CurrentColorIndex, 0
jmp skip_reset_color

use_five_colors:
cmp CurrentColorIndex, 5
jb skip_reset_color
mov CurrentColorIndex, 0
skip_reset_color:

mov [esi].BallPath.active, 1
inc NumActiveBalls
inc TotalBallSpawns

done:
popad
ret
InitializeBall ENDP

ClearBallPosition PROC
pushad
call GoToXY
mov al, ' '
call WriteChar
popad
ret
ClearBallPosition ENDP

UpdateBall PROC
    pushad

    ; Check if the ball is active
    cmp [esi].BallPath.active, 0
    je done_update

    ; FIRST, save current state to previous state variables BEFORE moving
    mov al, [esi].BallPath.xPos
    mov [esi].BallPath.prevXPos, al
    
    mov al, [esi].BallPath.yPos
    mov [esi].BallPath.prevYPos, al
    
    mov al, [esi].BallPath.VDir
    mov [esi].BallPath.prevXDir, al
    
    mov al, [esi].BallPath.HDir
    mov [esi].BallPath.prevYDir, al
    
    mov al, [esi].BallPath.moveStage
    mov [esi].BallPath.prevMoveStage, al
    
    mov al, [esi].BallPath.moveCount
    mov [esi].BallPath.prevMoveCount, al

    ; Clear the ball's current position before moving it
    mov dl, [esi].BallPath.xPos
    mov dh, [esi].BallPath.yPos
    call ClearBallPosition

    ; Use a jump table approach for movement stages
    movzx eax, [esi].BallPath.moveStage
    cmp eax, 4
    ja done_update; Invalid stage, skip

    ; Jump to the appropriate movement stage
    mov edx, OFFSET move_stages
    mov edx, [edx + eax * 4]
    jmp edx

move_stages LABEL DWORD
    DD OFFSET move_down; Stage 0
    DD OFFSET move_right; Stage 1
    DD OFFSET move_up; Stage 2
    DD OFFSET move_left; Stage 3
    DD OFFSET move_final; Stage 4

move_down:
    mov [esi].BallPath.VDir, 1
    mov [esi].BallPath.HDir, 0
    inc [esi].BallPath.moveCount
    movzx eax, [esi].BallPath.moveCount
    cmp eax, 20
    jb update_position
    jmp advance_stage

move_right:
    mov [esi].BallPath.VDir, 0
    mov [esi].BallPath.HDir, 1
    inc [esi].BallPath.moveCount
    movzx eax, [esi].BallPath.moveCount
    cmp eax, 65
    jb update_position
    jmp advance_stage

move_up:
    mov [esi].BallPath.VDir, -1
    mov [esi].BallPath.HDir, 0
    inc [esi].BallPath.moveCount
    movzx eax, [esi].BallPath.moveCount
    cmp eax, 20
    jb update_position
    jmp advance_stage

move_left:
    mov [esi].BallPath.VDir, 0
    mov [esi].BallPath.HDir, -1
    inc [esi].BallPath.moveCount
    movzx eax, [esi].BallPath.moveCount
    cmp eax, 56
    jb update_position
    jmp advance_stage

move_final:
    mov [esi].BallPath.VDir, 1
    mov [esi].BallPath.HDir, 0
    inc [esi].BallPath.moveCount
    movzx eax, [esi].BallPath.moveCount
    cmp eax, 6
    jb update_position

    ; Clear final position before deactivating
    mov dl, [esi].BallPath.xPos
    mov dh, [esi].BallPath.yPos
    call ClearBallPosition

    ; Deactivate ball after final moves
    mov [esi].BallPath.active, 0
    dec NumActiveBalls
    mov eax, 1; Flag to potentially spawn a new ball
    jmp done_update

update_position:
    ; Update position
    movsx eax, [esi].BallPath.VDir
    add [esi].BallPath.yPos, al

    movsx eax, [esi].BallPath.HDir
    add [esi].BallPath.xPos, al
    jmp done_update

advance_stage:
    ; Reset move count and advance stage
    mov [esi].BallPath.moveCount, 0
    inc [esi].BallPath.moveStage

done_update:
    popad
    ret
UpdateBall ENDP


UpdateBallLevel2 PROC
    pushad

    ; Check if the ball is active
    cmp [esi].BallPath.active, 0
    je done_update

    ; FIRST, save current state to previous state variables BEFORE moving
    mov al, [esi].BallPath.xPos
    mov [esi].BallPath.prevXPos, al
    
    mov al, [esi].BallPath.yPos
    mov [esi].BallPath.prevYPos, al
    
    mov al, [esi].BallPath.VDir
    mov [esi].BallPath.prevXDir, al
    
    mov al, [esi].BallPath.HDir
    mov [esi].BallPath.prevYDir, al
    
    mov al, [esi].BallPath.moveStage
    mov [esi].BallPath.prevMoveStage, al
    
    mov al, [esi].BallPath.moveCount
    mov [esi].BallPath.prevMoveCount, al

    ; Clear the ball's current position before moving it
    mov dl, [esi].BallPath.xPos
    mov dh, [esi].BallPath.yPos
    call ClearBallPosition

    movzx eax, [esi].BallPath.moveStage
    cmp eax, 8
    ja done_update; Invalid stage, skip

    ; Jump to the appropriate movement stage
    mov edx, OFFSET move_stages_level2
    mov edx, [edx + eax * 4]
    jmp edx

move_stages_level2 LABEL DWORD
    DD OFFSET move_right_l2  ; Stage 0
    DD OFFSET move_down_right_l2  ; Stage 1
    DD OFFSET move_down_l2 ; Stage 2
    DD OFFSET move_down_left_l2  ; Stage 3
    DD OFFSET move_left_l2  ; Stage 4
    DD OFFSET move_up_left_l2    ; Stage 5
    DD OFFSET move_up_l2    ; Stage 6
    DD OFFSET move_up_right_l2    ; Stage 7
    DD OFFSET move_final_l2 ; Stage 8

move_right_l2:
    mov [esi].BallPath.VDir, 0
    mov [esi].BallPath.HDir, 1
    inc [esi].BallPath.moveCount
    movzx eax, [esi].BallPath.moveCount
    cmp eax, 56  ; Different move count for level 2
    jb update_position
    jmp advance_stage

move_down_right_l2:
    mov [esi].BallPath.VDir, 1
    mov [esi].BallPath.HDir, 1
    inc [esi].BallPath.moveCount
    movzx eax, [esi].BallPath.moveCount
    cmp eax, 9  ; Different move count for level 2
    jb update_position
    jmp advance_stage

move_down_l2:
    mov[esi].BallPath.invis, 1
    mov [esi].BallPath.VDir, 1
    mov [esi].BallPath.HDir, 0
    inc [esi].BallPath.moveCount
    movzx eax, [esi].BallPath.moveCount
    cmp eax, 6  ; Different move count for level 2
    jb update_position
    jmp advance_stage

move_down_left_l2:
    mov[esi].BallPath.invis, 0
    mov [esi].BallPath.VDir, 1
    mov [esi].BallPath.HDir, -1
    inc [esi].BallPath.moveCount
    movzx eax, [esi].BallPath.moveCount
    cmp eax, 8  ; Different move count for level 2
    jb update_position
    jmp advance_stage

move_left_l2:
    mov [esi].BallPath.VDir, 0
    mov [esi].BallPath.HDir, -1
    inc [esi].BallPath.moveCount
    movzx eax, [esi].BallPath.moveCount
    cmp eax, 49  ; Different move count for level 2
    jb update_position
    jmp advance_stage

move_up_left_l2:
    mov [esi].BallPath.VDir, -1
    mov [esi].BallPath.HDir, -1
    inc [esi].BallPath.moveCount
    movzx eax, [esi].BallPath.moveCount
    cmp eax, 9  ; Different move count for level 2
    jb update_position
    jmp advance_stage

move_up_l2:
    mov[esi].BallPath.invis, 1
    mov [esi].BallPath.VDir, -1
    mov [esi].BallPath.HDir, 0
    inc [esi].BallPath.moveCount
    movzx eax, [esi].BallPath.moveCount
    cmp eax, 5  ; Different move count for level 2
    jb update_position
    jmp advance_stage


move_up_right_l2:
    mov[esi].BallPath.invis, 0
    mov [esi].BallPath.VDir, -1
    mov [esi].BallPath.HDir, 1
    inc [esi].BallPath.moveCount
    movzx eax, [esi].BallPath.moveCount
    cmp eax, 6  ; Different move count for level 2
    jb update_position
    jmp advance_stage


move_final_l2:
    mov [esi].BallPath.VDir, 0
    mov [esi].BallPath.HDir, 1
    inc [esi].BallPath.moveCount
    movzx eax, [esi].BallPath.moveCount
    cmp eax, 31  ; Different move count for final stage
    jb update_position

    ; Clear final position before deactivating
    mov dl, [esi].BallPath.xPos
    mov dh, [esi].BallPath.yPos
    call ClearBallPosition

    ; Deactivate ball after final moves
    mov [esi].BallPath.active, 0
    dec NumActiveBalls
    mov eax, 1; Flag to potentially spawn a new ball
    jmp done_update

update_position:
    ; Update position
    movsx eax, [esi].BallPath.VDir
    add [esi].BallPath.yPos, al

    movsx eax, [esi].BallPath.HDir
    add [esi].BallPath.xPos, al
    jmp done_update

advance_stage:
    ; Reset move count and advance stage
    mov [esi].BallPath.moveCount, 0
    inc [esi].BallPath.moveStage

done_update:
    popad
    ret
UpdateBallLevel2 ENDP


UpdateBallLevel3 PROC
    pushad

    ; Check if the ball is active
    cmp [esi].BallPath.active, 0
    je done_update

    ; Save current state to PREV  VADF
    mov al, [esi].BallPath.xPos
    mov [esi].BallPath.prevXPos, al

    mov al, [esi].BallPath.yPos
    mov [esi].BallPath.prevYPos, al

    mov al, [esi].BallPath.VDir
    mov [esi].BallPath.prevXDir, al

    mov al, [esi].BallPath.HDir
    mov [esi].BallPath.prevYDir, al

    mov al, [esi].BallPath.moveStage
    mov [esi].BallPath.prevMoveStage, al

    mov al, [esi].BallPath.moveCount
    mov [esi].BallPath.prevMoveCount, al

    ; Clear current position
    mov dl, [esi].BallPath.xPos
    mov dh, [esi].BallPath.yPos
    call ClearBallPosition

    ; Use movement stages for level 3
    movzx eax, [esi].BallPath.moveStage
    cmp eax, 11
    ja done_update

    ; Jump to appropriate movement stage
    mov edx, OFFSET move_stages_level3
    mov edx, [edx + eax * 4]
    jmp edx

move_stages_level3 LABEL DWORD
    DD OFFSET right_l3           ; Stage 0
    DD OFFSET down_right_l3      ; Stage 1
    DD OFFSET down_left_l3   ; Stage 2
    DD OFFSET left_l3    ; Stage 3
    DD OFFSET down_left_l3
    DD OFFSET down_l3  ; Stage 4
    DD OFFSET down_right_l3_2    ; Stage 5
    DD OFFSET right_l3  ; Stage 6
    DD OFFSET down_right_l3 ; stage 7
    DD OFFSET down_left_l3 ;stage 8
    DD OFFSET move_final_l3; stage 9

right_l3:
    mov [esi].BallPath.VDir, 0
    mov [esi].BallPath.HDir, 1
    inc [esi].BallPath.moveCount
    movzx eax, [esi].BallPath.moveCount
    cmp eax, 60
    jb update_position
    jmp advance_stage

down_right_l3:
    mov [esi].BallPath.VDir, 1
    mov [esi].BallPath.HDir, 1
    inc [esi].BallPath.moveCount
    movzx eax, [esi].BallPath.moveCount
    cmp eax, 3
    jb update_position
    jmp advance_stage

down_left_l3:
    ;mov [esi].BallPath.invis, 1
    mov [esi].BallPath.VDir, 1
    mov [esi].BallPath.HDir, -1
    inc [esi].BallPath.moveCount
    movzx eax, [esi].BallPath.moveCount
    cmp eax, 4
    jb update_position
    jmp advance_stage

left_l3:
    ;mov [esi].BallPath.invis, 0
    mov [esi].BallPath.VDir, 0
    mov [esi].BallPath.HDir, -1
    inc [esi].BallPath.moveCount
    movzx eax, [esi].BallPath.moveCount
    cmp eax, 56
    jb update_position
    jmp advance_stage

down_l3:
    mov [esi].BallPath.invis, 1
    mov [esi].BallPath.VDir, 1
    mov [esi].BallPath.HDir, 0
    inc [esi].BallPath.moveCount
    movzx eax, [esi].BallPath.moveCount
    cmp eax, 5
    jb update_position
    jmp advance_stage

down_right_l3_2:
    mov [esi].BallPath.invis, 0
    mov [esi].BallPath.VDir, 1
    mov [esi].BallPath.HDir, 1
    inc [esi].BallPath.moveCount
    movzx eax, [esi].BallPath.moveCount
    cmp eax, 4
    jb update_position
    jmp advance_stage

move_final_l3:
    mov [esi].BallPath.VDir, 0
    mov [esi].BallPath.HDir, -1
    inc [esi].BallPath.moveCount
    movzx eax, [esi].BallPath.moveCount
    cmp eax, 54
    jb update_position

    ; Clear final position before deactivating
    mov dl, [esi].BallPath.xPos
    mov dh, [esi].BallPath.yPos
    call ClearBallPosition

    ; Deactivate ball after final moves
    mov [esi].BallPath.active, 0
    dec NumActiveBalls
    mov eax, 1    ; Flag to potentially spawn a new ball
    jmp done_update

update_position:
    ; Update position
    movsx eax, [esi].BallPath.VDir
    add [esi].BallPath.yPos, al

    movsx eax, [esi].BallPath.HDir
    add [esi].BallPath.xPos, al
    jmp done_update

advance_stage:
    ; Reset move count and advance stage
    mov [esi].BallPath.moveCount, 0
    inc [esi].BallPath.moveStage

done_update:
    popad
    ret
UpdateBallLevel3 ENDP





UpdateBalls PROC
    pushad

    mov esi, offset BallLine
    mov ecx, MAX_BALL_LENGTH
    mov ebx, 0    ; Track if need spawn ball

update_loop:
    ; Check current level to determine which UpdateBall procedure to use
    cmp levelInfo, 3
    je use_level3_update
    cmp levelInfo, 2
    je use_level2_update

    ; original UpdateBall for Level 1
    push esi
    call UpdateBall
    pop esi
    jmp check_spawn

use_level2_update:
    ; Level 2 specific UpdateBall
    push esi
    call UpdateBallLevel2
    pop esi
    jmp check_spawn

use_level3_update:
    ; Level 3 specific UpdateBall
    push esi
    call UpdateBallLevel3
    pop esi

check_spawn:
    ; Check if a ball was deactivated and needs replacement
    cmp eax, 1
    je spawn_ball

next_ball:
    add esi, TYPE BallPath
    loop update_loop
    jmp done_update

spawn_ball:
    call InitializeBall
    jmp next_ball

done_update:
    popad
    ret
UpdateBalls ENDP





FireBall PROC
; Save initial player position
mov dl, xPos
mov dh, yPos

mov fire_col, dl
mov fire_row, dh

; Handle different firing directions
mov al, direction
cmp al, "w"
je fire_up
cmp al, "x"
je fire_down
cmp al, "a"
je fire_left
cmp al, "d"
je fire_right
cmp al, "q"
je fire_upleft
cmp al, "e"
je fire_upright
cmp al, "z"
je fire_downleft
cmp al, "c"
je fire_downright
jmp end_fire

fire_up :
mov fire_row, 14
mov fire_col, 57
mov xDir, 0
mov yDir, -1
jmp fire_loop

fire_down :
mov fire_row, 18
mov fire_col, 57
mov xDir, 0
mov yDir, 1
jmp fire_loop

fire_left :
mov fire_col, 55
mov fire_row, 16
mov xDir, -1
mov yDir, 0
jmp fire_loop

fire_right :
mov fire_col, 59
mov fire_row, 16
mov xDir, 1
mov yDir, 0
jmp fire_loop

fire_upleft :
mov fire_row, 14
mov fire_col, 55
mov xDir, -1
mov yDir, -1
jmp fire_loop

fire_upright :
mov fire_row, 14
mov fire_col, 59
mov xDir, 1
mov yDir, -1
jmp fire_loop

fire_downleft :
mov fire_row, 18
mov fire_col, 55
mov xDir, -1
mov yDir, 1
jmp fire_loop

fire_downright :
mov fire_row, 18
mov fire_col, 59
mov xDir, 1
mov yDir, 1
jmp fire_loop

fire_loop :
mov dl, fire_col
mov dh, fire_row
call GoToXY

L1 :
; Check boundary conditions
cmp dl, 20
jle end_fire
cmp dl, 96
jge end_fire
cmp dh, 5
jle end_fire
cmp dh, 27
jge end_fire

; Check for ball collision
push esi
push ecx
mov esi, offset BallLine
mov ecx, MAX_BALL_LENGTH

collision_check :
; Skip inactive balls
cmp[esi].BallPath.active, 0
je next_ball

; Skip invisible balls
cmp[esi].BallPath.invis, 1
je next_ball

; Compare fire position with ball position
mov al, [esi].BallPath.xPos
mov ah, [esi].BallPath.yPos
cmp al, dl
jne next_ball
cmp ah, dh
jne next_ball

; Collision detected!

push esi; Save incident ball position

; Add new ball at the end
call AddBallAtEnd

; Now implement color propagation
mov esi, offset BallLine
mov ecx, MAX_BALL_LENGTH
dec ecx; Start from second - to - last position

; Find the last active ball
mov edi, offset BallLine; edi will hold last active ball
find_last :
cmp[esi + TYPE BallPath].BallPath.active, 0
je found_last
add esi, TYPE BallPath
loop find_last

found_last :
mov edi, esi; 
pop ebx; Restore incident ball position to ebx

color_propagation :
cmp edi, ebx; Check if we've reached the incident ball
je done_propagation

; Get the previous ball's position
mov esi, edi
sub esi, TYPE BallPath

mov al, [esi].BallPath.color
mov[edi].BallPath.color, al

; Move to previous position
mov edi, esi
jmp color_propagation

done_propagation :
; Set the color of the ball before incident ball to shot ball's color
mov al, fire_color
mov[edi].BallPath.color, al

pop ecx
pop esi
jmp end_fire

next_ball :
add esi, TYPE BallPath
loop collision_check

pop ecx
pop esi

; Draw the fire animation
movzx eax, fire_color
call SetTextColor

; Update fire position
add dl, xDir
add dh, yDir
call Gotoxy

mWrite "*"

; Save current position
push edx

; Update and redraw game state
call UpdateGame
call DrawBalls
call PrintPlayer

; Restore position
pop edx

; Add delay for animation
mov eax, 110
call Delay

; Clear previous fire position
call GoToXY
mWrite " "

jmp L1

end_fire :
; Reset cursor position
mov dx, 0
call GoToXY

; Cycle to the next fire color
movzx eax, CurrentColorIndex
mov ebx, OFFSET BallColors
mov cl, [ebx + eax]
mov fire_color, cl

; Increment and wrap color index
inc CurrentColorIndex

; Check number of colors based on level
cmp levelInfo, 3
je use_five_colors
cmp CurrentColorIndex, 4
jb skip_reset_color
mov CurrentColorIndex, 0
jmp skip_reset_color

use_five_colors:
cmp CurrentColorIndex, 5
jb skip_reset_color
mov CurrentColorIndex, 0
skip_reset_color:

; Update the color indicator
call DrawWall
call DrawColorIndicator


ret
FireBall ENDP


DrawWall PROC
call clrscr

; Draw score
mov dl, 19
mov dh, 2
call Gotoxy
mWrite <"Score: ">
mov eax, Blue + (black * 16)
call SetTextColor
mov al, score
call WriteDec

; Draw lives
mov eax, White + (black * 16)
call SetTextColor
mov dl, 90
mov dh, 2
call Gotoxy
mWrite <"Lives: ">
mov eax, Red + (black * 16)
call SetTextColor
mov al, lives
call WriteDec

; Draw level indicator
mov eax, white + (black * 16)
call SetTextColor
mov dl, 55
mov dh, 2
call Gotoxy
mWrite "LEVEL "
mov al, levelInfo
call WriteDec

; Set wall color
mov eax, gray + (black * 16)
call SetTextColor

; Set initial position for wall drawing
mov dl, 19
mov dh, 4
call Gotoxy

; Choose wall layout based on level
cmp levelInfo, 3
je use_walls3
cmp levelInfo, 2
je use_walls2
mov esi, offset walls   ; Level 1 walls
jmp draw_walls
use_walls2:
mov esi, offset walls2  ; Level 2 walls
jmp draw_walls
use_walls3:
mov esi,offset walls3
jmp draw_walls

draw_walls:
mov counter1, 50
mov counter2, 80
movzx ecx, counter1
printcolumn:
    mov counter1, cl
    movzx ecx, counter2
    printrow:
        mov eax, [esi]
        call WriteChar
        inc esi
        loop printrow

    dec counter1
    movzx ecx, counter1
    mov dl, 19
    inc dh
    call Gotoxy
    loop printcolumn

ret
DrawWall ENDP
PrintPlayer PROC
mov eax, brown + (black * 16)
call SetTextColor

mov al, direction
cmp al, "w"
je print_up

cmp al, "x"
je print_down

cmp al, "a"
je print_left

cmp al, "d"
je print_right

cmp al, "q"
je print_upleft

cmp al, "e"
je print_upright

cmp al, "z"
je print_downleft

cmp al, "c"
je print_downright

ret

print_up :
mov esi, offset player_up
jmp print

print_down :
mov esi, offset player_down
jmp print

print_left :
mov esi, offset player_left
jmp print

print_right :
mov esi, offset player_right
jmp print

print_upleft :
mov esi, offset player_upleft
jmp print

print_upright :
mov esi, offset player_upright
jmp print

print_downleft :
mov esi, offset player_downleft
jmp print

print_downright :
mov esi, offset player_downright
jmp print

print :
mov dl, xPos
mov dh, yPos
call GoToXY

mov counter1, 3
mov counter2, 4
movzx ecx, counter1
printcolumn :
mov counter1, cl
movzx ecx, counter2
printrow :
mov eax, [esi]
call WriteChar

inc esi
loop printrow

movzx ecx, counter1

mov dl, xPos
inc dh
call Gotoxy
loop printcolumn

ret
PrintPlayer ENDP

ClearPlayer PROC
pushad
mov dl, xPos
mov dh, yPos
mov ecx, 3
clear_loop:
call GoToXY
push ecx
mov ecx, 3
mov al, ' '
clear_row :
    call WriteChar
    loop clear_row
    pop ecx
    inc dh
    loop clear_loop
    popad
    ret
    ClearPlayer ENDP

UpdateGame PROC

    inc GameTickCount

    ; Spawn new balls periodically
    call InitializeBall

    ; Update existing balls
    call UpdateBalls
    
    ; Draw color indicator
    call DrawColorIndicator

    ret
UpdateGame ENDP

HandleInput PROC
    mov eax, 50
    call Delay

    mov eax, 0
    call ReadKey
    jz no_input

    mov inputChar, al

    ; Handle ESC key
    cmp inputChar, VK_ESCAPE
    je set_game_inactive

    ; Handle SPACE key
    cmp inputChar, VK_SPACE
    je handle_fire

    ; Handle PAUSE key
    cmp inputChar, 'p'
    je handle_pause

    ; Handle NEW LEVEL key
    cmp inputChar, 'n'
    je handle_new_level

    ; Handle movement keys
    mov al, inputChar
    cmp al, 'w'
    je valid_move
    cmp al, 'a'
    je valid_move
    cmp al, 's'
    je valid_move
    cmp al, 'd'
    je valid_move
    cmp al, 'q'
    je valid_move
    cmp al, 'e'
    je valid_move
    cmp al, 'z'
    je valid_move
    cmp al, 'c'
    je valid_move
    jmp no_input

handle_pause:
    call DrawPauseScreen
    
    ; Wait for P or ESC to unpause
pause_loop:
    mov eax, 50
    call Delay
    
    mov eax, 0
    call ReadKey
    jz pause_loop
    
    mov inputChar, al
    cmp inputChar, 'p'
    je resume_game
    cmp inputChar, VK_ESCAPE
    je set_game_inactive
    jmp pause_loop

resume_game:
    call DrawWall
    call PrintPlayer
    jmp no_input

handle_new_level:
    ; Increment level
    inc levelInfo
    mov CurrentColorIndex, 0

    cmp levelInfo, 4
    jne skip_level_reset
    mov levelInfo, 1
skip_level_reset:

    ; Reset bal variables
    mov TotalBallSpawns, 0
    mov NumActiveBalls, 0
    mov BallsStartedSpawning, 0
    mov CurrentColorIndex, 0

    ; Clear all existing balls
    mov esi, offset BallLine
    mov ecx, MAX_BALL_LENGTH
clear_balls:
    mov [esi].BallPath.active, 0
    add esi, TYPE BallPath
    loop clear_balls

    ; Set delay based on level
    cmp levelInfo, 1
    je set_level1_delay
    cmp levelInfo, 2
    je set_level2_delay
    cmp levelInfo, 3
    je set_level3_delay
    jmp set_level1_delay    ; Default to level 1 delay

set_level1_delay:
    mov CurrentLevelDelay, LEVEL1_DELAY
    jmp finish_level_change

set_level2_delay:
    mov CurrentLevelDelay, LEVEL2_DELAY
    jmp finish_level_change

set_level3_delay:
    mov CurrentLevelDelay, LEVEL3_DELAY
    jmp finish_level_change
    
finish_level_change:
    ; Redraw the wall to show new level
    call DrawWall
    call PrintPlayer
    jmp no_input

valid_move:
    mov direction, al
    jmp no_input

handle_fire:
    call FireBall
    jmp no_input

set_game_inactive:
    mov GameActive, 0

no_input:
    ret
HandleInput ENDP

main PROC
call DisplayInstructionsScreen

    ; Initialize game state
    mov CurrentLevelDelay, LEVEL1_DELAY
    mov levelInfo, 1

    ; Draw initial game screen
    call DrawWall
    call PrintPlayer

    ; Load high score at game start
    call LoadHighScore

    ; Draw initial color indicator
    call DrawColorIndicator


    ; Main game loop HEREEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
    game_loop:
        ; Check if game should exit
        cmp GameActive, 0
        je exit_game


        cmp BallsStartedSpawning, 1
        jne continue_game    ; Skip game over check if balls haven't started spawning
        cmp NumActiveBalls, 0
        je game_over

    continue_game:
        ; Use level specfic delay for game speed
        mov eax, CurrentLevelDelay
        call Delay

        ; Clear previous frame
        call ClearPlayer

        ; Update game state
        call UpdateGame
        call CheckChain

        ; Handle input
        call HandleInput

        call DrawBalls
        call PrintPlayer

        jmp game_loop

    game_over:
        call DrawLoseScreen

    wait_exit:
        mov eax, 50
        call Delay
        
        mov eax, 0
        call ReadKey
        jz wait_exit
        
        cmp al, VK_ESCAPE
        jne wait_exit

    exit_game:
        exit
main ENDP
end MAIN