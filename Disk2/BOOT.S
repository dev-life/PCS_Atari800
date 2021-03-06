 LST OFF
*
* DUMMY PCS BOOT SECTOR
*  FOR ELECTRONIC ARTS
*
GTSCTR EQU $52
*
DUNIT EQU $301
DCOMND EQU $302
DSTATS EQU $303
DBUFR EQU $304
DSCTR EQU $30A
*
PIECE1 EQU $0680 ;BOOT FILE
INTERRUPTS EQU $49DC
GOATARI EQU $4B45
DISKINV EQU $E453
*
 ORG $600
 OBJ $7000
*
 HEX 00
 HEX 01 ;1 SECTOR DUMMY BOOT
 DA  $600
 DA NULL ;INIT
*
STAGE2 LDA #0 ;GET BOOT FILE
 STA DSCTR+1
 LDA #$80
 STA DBUFR
 LDA #>PIECE1
 LDX #$36
 LDY #$8A
 JSR GETSECTORS
 JSR GOATARI
 JSR INTERRUPTS
 JMP PIECE1
*
GETSECTORS STA DBUFR+1
 STX DSCTR
 STY SECTORCOUNT
*
 LDA #1
 STA DUNIT
 LDA #GTSCTR
 STA DCOMND
*
GETS2 JSR DISKINV
 LDA DSTATS
 CMP #1
 BNE GETS2
*
 LDA DBUFR
 ADC #127 ;C=1!
 STA DBUFR
 LDA DBUFR+1
 ADC #0
 STA DBUFR+1
 INC DSCTR
 BNE GETS3
 INC DSCTR+1
GETS3 DEC SECTORCOUNT
 BNE GETS2
NULL RTS
*
SECTORCOUNT HEX 00
