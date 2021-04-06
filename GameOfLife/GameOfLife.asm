// The game of life world consists of 2D grid 16x32, the grid is mapped in memory:
// RAM[100] == grid(0, 0)
// RAM[131] == grid(1, 0)
// RAM[611] == grid(16, 31)
//
// RAM[99] contains number of generations to iterate over the Game of life world (aka grid)
//
// Iteration rules:
// For a space that is 'populated':
// * Each cell with one or no neighbors dies, as if by solitude.
// * Each cell with four or more neighbors dies, as if by overpopulation.
// * Each cell with two or three neighbors survives.
//
// For a space that is 'empty' or 'unpopulated'
// * Each cell with three neighbors becomes populated.
//
// initial values are set by test. The are only two values allowed:
// 1 -- the cell is populated
// 0 -- the cell is empty

// your code here




//  გადავუყვები [100-611] და [screem; screen+611]
//  ვინახავ რამდენი მეზობელი ყავს გარშემო ##

//  შემდეგ გადავუყვები [screel; screen+611]
//  და მეზობლების მიხედვიტ [100;611] ჩავწერ 1/0 ##

//  და ვიყენებ სქრიინ აბდეითს რომ ეკრანი განახლდეს თავის [100:611]
//  შუალედში 
//  



//  ყველაზე გადაყოლა და checkAbove ით 
//  რომელიც გააგრძელებს სხვა checkზე
//  დათვლა მეზობლების
//  

// iter
// checkRow
// checkCol
// colStartIterMin


//  ITERATE
//  TransportScreenToRam
//  UPDATESCREEN



(PROCESS)
@99
D=M
@END
D;JEQ
// dabrunebebu


@ITERATE
0;JMP
(AfterIterate)


@TransportScreenToRam
0;JMP
(AfterTransportScreenToRam)


@UPDATESCREEN
0;JMP
(AfterUPDATESCREEN)

@1
D=A
@99
M=M-D
@PROCESS
0;JMP


(END)
@END
0;JMP

//-----------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------

(ITERATE)

    @100
    D=A
    @checkIndex
    M=D
    @0
    D=A
    @checkRow
    M=D
    @checkCol
    M=D
    @31
    D=A
    @colStartIterMin
    M=D
    @IteerLoop
    0;JMP

(IteerLoop)
@checkIndex
D=M
@612
D=A-D
//*------------  afterItearate
@AfterIterate
D;JEQ
@CheckAbove
0;JMP
(afterChek)
@checkIndex
M=M+1
@checkCol
M=M+1
@colStartIterMin
MD=M-1
@UpdateRowSzIter
D;JLT
@IteerLoop
0;JMP



(UpdateRowSzIter)
@checkRow
M=M+1
@0
D=A
@checkCol
M=D
@31
D=A
@colStartIterMin
M=D
@IteerLoop
0;JMP







//  გატსტისთვის ინფორმაცია უნდა იყოს შენახული row; col; index
//  
//  checkIndex
//  checkRow[0;15]
//  checkCol[0;31]
//


//above three

(CheckAbove)
    @checkIndex
    D=M
    @curP
    M=D
    @100
    D=A
    @curP
    M=M-D
    @9000
    D=A
    @curP
    M=M+D
    @curP
    A=M
    M=0

@checkIndex
D=M
@checkPrime
M=D
@checkRow
D=M
@CheckLeft
D;JLE
@32
D=A
@checkPrime
M=M-D
A=M
D=M 
@notAdd
D;JEQ
    @checkIndex
    D=M
    @curP
    M=D
    @100
    D=A
    @curP
    M=M-D
    @9000
    D=A
    @curP
    M=M+D
    @curP
    A=M
    M=0
    @1
    D=A
    @curP
    A=M
    M=M+D
(notAdd)

@checkCol
D=M
@AfterCheckLeftAbove
D;JLE
@1
D=A
@checkPrime
M=M-D
A=M
D=M
@notAdd1
D;JEQ
    @checkIndex
    D=M
    @curP
    M=D
    @100
    D=A
    @curP
    M=M-D
    @9000
    D=A
    @curP
    M=M+D
    @1
    D=A
    @curP
    A=M
    M=M+D
(notAdd1)
@1
D=A
@checkPrime
M=M+D
(AfterCheckLeftAbove)

@checkCol
D=M
@checkCol1
M=D
@31
D=A
@checkCol1
M=D-M
@checkCol1
D=M
@AfterCheckrightAbove
D;JLE
@1
D=A
@checkPrime
M=M+D
A=M
D=M
@notAdd2
D;JEQ
    @checkIndex
    D=M
    @curP
    M=D
    @100
    D=A
    @curP
    M=M-D
    @9000
    D=A
    @curP
    M=M+D
    @1
    D=A
    @curP
    A=M
    M=M+D
(notAdd2)
@1
D=A
@checkPrime
M=M-D
(AfterCheckrightAbove)

//index-1
(CheckLeft)
@checkIndex
D=M
@checkPrime
M=D
@checkCol
D=M
@AfterCheckLeft
D;JLE
@1
D=A
@checkPrime
M=M-D
A=M
D=M
@notAdd11
D;JEQ
    @checkIndex
    D=M
    @curP
    M=D
    @100
    D=A
    @curP
    M=M-D
    @9000
    D=A
    @curP
    M=M+D
    @1
    D=A
    @curP
    A=M
    M=M+D
(notAdd11)
@1
D=A
@checkPrime
M=M+D
(AfterCheckLeft)

 


//index+1
(CheckRight)
@checkIndex
D=M
@checkPrime
M=D
@checkCol
D=M
@checkCol1
M=D
@31
D=A
@checkCol1
M=D-M
@checkCol1
D=M
@AfterCheckright
D;JLE
@1
D=A
@checkPrime
M=M+D
A=M
D=M
@notAdd22
D;JEQ
    @checkIndex
    D=M
    @curP
    M=D
    @100
    D=A
    @curP
    M=M-D
    @9000
    D=A
    @curP
    M=M+D
    @1
    D=A
    @curP
    A=M
    M=M+D
(notAdd22)
@1
D=A
@checkPrime
M=M-D
(AfterCheckright)




//ends "AfterCheckAbove"
//down three
(CheckDown)
@checkRow
D=M
@checkRowPr
M=D
@15
D=A
@checkRowPr
M=D-M
@checkRowPr
D=M
@AfterCheckAbove
D;JLE
@checkIndex
D=M
@checkPrime
M=D
@32
D=A
@checkPrime
M=M+D
A=M
D=M
@notAdd31
D;JEQ
    @checkIndex
    D=M
    @curP
    M=D
    @100
    D=A
    @curP
    M=M-D
    @9000
    D=A
    @curP
    M=M+D
    @1
    D=A
    @curP
    A=M
    M=M+D
(notAdd31)

@checkCol
D=M
@AfterCheckLeftDown
D;JLE
@1
D=A
@checkPrime
M=M-D
A=M
D=M
@notAdd33
D;JEQ
    @checkIndex
    D=M
    @curP
    M=D
    @100
    D=A
    @curP
    M=M-D
    @9000
    D=A
    @curP
    M=M+D
    @1
    D=A
    @curP
    A=M
    M=M+D
(notAdd33)
@1
D=A
@checkPrime
M=M+D
(AfterCheckLeftDown)

@checkCol
D=M
@checkCol1
M=D
@31
D=A
@checkCol1
M=D-M
@checkCol1
D=M
@AfterCheckrightDown
D;JLE
@1
D=A
@checkPrime
M=M+D
A=M
D=M
@notAdd32
D;JEQ
    @checkIndex
    D=M
    @curP
    M=D
    @100
    D=A
    @curP
    M=M-D
    @9000
    D=A
    @curP
    M=M+D
    @1
    D=A
    @curP
    A=M
    M=M+D
(notAdd32)
@1
D=A
@checkPrime
M=M-D
(AfterCheckrightDown)
(AfterCheckAbove)
@afterChek
0;JMP
//----------------------------------





//-----------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------



(UPDATESCREEN)

//ეს ნაწილი საჭიროა  ეკრანის განახლების ალოკაციისთვია
    @100
    D=A
    @index
    M=D
    @0
    D=A
    @rowStartAdd
    M=D
    @0
    D=A
    @colStartAdd
    M=D
    @31
    D=A
    @colStartMin
    M=D
    @UpdateScreenLoop
    0;JMP

(makeAlive)




//  index [100-612]
//  612ს აკლებს ინდექს
//  თუ 0 ეკრანის აბდეითი დამთავრებულია  გადასვლა ^^^^^შესაცვლელია^^^^^
//  ამ ინდექსის მემომრის მიხედვით ქლეარში ან ფილში
//  და ბრუნდება ReturnpdateScreenLoop
//  და ზრდის ინდექს
//  ა1 მოდის ინდექსში 100_ით

(UpdateScreenLoop)
@index
D=M
@612
D=A-D
@AfterUPDATESCREEN
D;JEQ
@index
D=D
@index
A=M
D=M
@clear
D;JEQ
@draw
D;JGT
(ReturnUpdateScreenLoop)
@index
M=M+1
@colStartAdd
M=M+1
@colStartMin
MD=M-1
@UpdateRowSz
D;JLT
@UpdateScreenLoop
0;JMP



(UpdateRowSz)
@rowStartAdd
M=M+1
@0
D=A
@colStartAdd
M=D
@31
D=A
@colStartMin
M=D
@UpdateScreenLoop
0;JMP


(fill)
@SCREEN
D=A
@startInd
M=D
@rowStartAdd
D=M
   
    @512
    D=A
    @a
    M=D
    @rowStartAdd
    D=M
    @b
    M=D
    @i         
    M=D
    @c
    M=0

    (LOOPMult)
    @i          
    D=M
    @ENDFILL
    D;JLE
    @a
    D=M
    @c
    M=M+D       
    @i
    M=M-1
    @LOOPMult
    0;JMP


(ENDFILL)
@c
D=M
@adder
M=D
@colStartAdd
D=M
@adder
D=D+M
@startInd
M=M+D


    (loopOverOnePoint)
    @startInd
    D=M
    @curPon
    M=D
   
        @32
        D=A
        @a
        M=D
        @15
        D=A
        @b
        M=D
        @i         
        M=D

        (LOOPMult2)
        @i          
        D=M
        @END2
        D;JLT
        @ch
        D=M
        @curPon
        A=M 
        M=D    
        @a
        D=M
        @curPon
        M=M+D   
        @i
        M=M-1
        @LOOPMult2
        0;JMP

    (END2)

    @ReturnUpdateScreenLoop // გავდივარ აქედან
    D;JLT
    


(clear)
@ch
M=0
@fill
0;JMP

(draw)
@ch
M=-1
@fill
0;JMP




    





//-----------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------

(TransportScreenToRam)
@9000
D=A
@pointer
M=D
@511
D=A
@i
M=D
@100
D=A
@ramPointer
M=D
    
    (LOOPTransport)
    @i          
    D=M
    @AfterTransportScreenToRam
    D;JLT
    @pointer
    A=M
    D=M
    @value
    M=D
    @ramPointer
    A=M
    D=M
    @dead
    D;JEQ
    @alive
    0;JMP

    (dead)
    @3
    D=A
    @value
    MD=M-D
    @continue
    D;JNE
    @ramPointer
    A=M
    M=1
    @continue
    0;JMP

    (alive)
    @1
    D=A
    @value
    MD=M-D
    @continueChecking
    D;JNE
    @ramPointer
    A=M
    M=0
    (continueChecking)
    @3
    D=A
    @value
    MD=M-D
    @continue
    D;JLT
    @ramPointer
    A=M
    M=0

    (continue)
    @1
    D=A
    @ramPointer
    M=M+D
    @pointer
    M=M+D
    @i
    M=M-D
    @LOOPTransport
    0;JMP





