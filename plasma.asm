'
'                           PSEUDO ASCII CRACKTRO
'                           =====================
'
'
'
'                             WIDOW MAKER  2007
'
'
'-------------------------------------------------------------------------------

        OPTION STATIC
        OPTION EXPLICIT
        
'       SCREEN RES

        CONST   XRES = 640
        CONST   YRES = 480

'       GRID RES

        CONST   GRID = 4

        DIM SHARED AS INTEGER WXRES 
        DIM SHARED AS INTEGER WYRES 
        
        WXRES = XRES / GRID
        WYRES = YRES / GRID        

'       INCLUDES

        #INCLUDE "TINYPTC_EXT.BI"
        #INCLUDE "WINDOWS.BI"
        
'-------------------------------------------------------------------------------

'       VARIABLES

        DIM SHARED AS UINTEGER  BUFFER ( XRES * YRES )
        DIM SHARED AS UINTEGER WBUFFER ( WXRES * WYRES )
        dim shared as double fuckfuck(xres)
        DIM SHARED AS UINTEGER COL_PAL(10000)
        DIM SHARED AS DOUBLE GADD,GADD2
'-------------------------------------------------------------------------------    

'       SUBS

        DECLARE SUB BLIT_BUFFER()
        DECLARE SUB ERASE_GRID()
        DECLARE SUB PRECALC()
        DECLARE SUB PLASMA()
        
        
'-------------------------------------------------------------------------------    

'       OPEN SCREEN

        PTC_ALLOWCLOSE(0)
        PTC_SETDIALOG(0,"",0,0)    
        IF (PTC_OPEN("P0STM0RT3M",XRES,YRES)=0) THEN
            END-1
        END IF  
        PRECALC()
        
'-------------------------------------------------------------------------------
'       MAIN LOOP;
'-------------------------------------------------------------------------------

WHILE(GETASYNCKEYSTATE(VK_ESCAPE)<>-32767)    
    GADD=GADD-1.5
    GADD2=GADD2-1.4
'    ERASE_GRID()
    PLASMA()
    BLIT_BUFFER()
    PTC_UPDATE@BUFFER(0)
    
WEND
END


SUB PLASMA()
    
    DIM AS INTEGER YY,XX,VALL,QQ,RR
    dim as double ll,mm
    
    for xx=0 to xres
        fuckfuck(xx)=171+50*sin((GADD+xx)/39) 
    next

    FOR YY=0 TO WYRES-1
   
        
        QQ = 599 * SIN (( GADD2 + YY) /69)  
        rr = 599 * SIN (( GADD  - YY) /87)  
        
        mm=171+50*sin((GADD+yy)/237)
        FOR XX=0 TO WXRES-1
            VALL = 5000+(2499*cos((gadd2-YY+QQ)/fuckfuck(xx))+2499*SIN((gadd-YY+rr)/mm))
            
            WBUFFER(XX+(YY*WXRES))=COL_PAL(VALL)
        NEXT
    NEXT
    
END SUB

SUB PRECALC()
    DIM X AS INTEGER
    DIM AS DOUBLE RR,GG,BB
    RR=125
    GG=125
    BB=125
    FOR X=0 TO 10000

        rr=125+124*sin(X/1813)
        gg=125+124*sin((X+1000)/1813)
        bb=125+124*sin((X+2000)/1813)

        COL_PAL(X) = RGB( INT(RR),INT(GG),INT(BB) )
        
    NEXT
    
END SUB

'-------------------------------------------------------------------------------
'   DRAWS THE SCREEN ACCORDING TO WHAT IS IN WBUFFER.
'-------------------------------------------------------------------------------

SUB BLIT_BUFFER()
    DIM AS INTEGER XX,YY,Y2,SLICE,tc
    DIM PP AS UINTEGER PTR
    
    FOR YY=0 TO WYRES-1
    FOR XX=0 TO WXRES-1
        
        FOR Y2=0 TO GRID-1
        pp=@buffer((XX*GRID)+(((YY*GRID)+Y2)*XRES))    
        SLICE = GRID
        TC=WBUFFER(XX+(YY*WXRES))
        
            asm
                
            mov eax,dword ptr[TC]
            mov ecx, [SLICE]
            mov edi, [PP]
            rep stosd
            
            end asm   
    
        NEXT
        
    NEXT
    NEXT

END SUB

'-------------------------------------------------------------------------------
'   FOR NOW JUST GENERATE RANDOM PIXELS, LATER IT WILL BE JUST DRAWN OVER.
'-------------------------------------------------------------------------------

SUB ERASE_GRID()
        DIM AS INTEGER XX,YY
        FOR YY=0 TO WYRES-1
        FOR XX=0 TO WXRES-1   
            WBUFFER(XX+(YY*WXRES))=RGB(INT(RND(1)*255),INT(RND(1)*255),INT(RND(1)*255))
        NEXT
        NEXT
END SUB
