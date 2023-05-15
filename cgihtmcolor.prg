// Programa   : CGIHTMCOLOR
// Fecha/Hora : 04/06/2003 15:05:02
// Propósito  : Determinar Hex/Dec Colores Según Paleta
// Creado Por : Juan Navas
// Llamado por: DpXbase
// Aplicación : Programación
// Tabla      : Todas
#INCLUDE "DPXBASE.CH"

PROCE MAIN(nClr)

  LOCAL oSelClr,bBlq,oGet1,oGet2,oGet3,oGet4,bUpdate,nBlue,nGreen,nRed,cHex,nColor
  LOCAL bBlq:={||NIL}

  oSelClr:=Dialog("Seleccionar Color" ,"CGISELCOLOR.EDT")

  @ .1,2 SAY oSelClr:oSay PROMPT " COLOR SELECCIONADO " SIZE 55,25 BORDER

//  IF nClr!=NIL
//    oSelClr:oSay:SetColor(nClr,NIL)
//  ENDIF

  nColor:=oSelClr:oSay:nClrPane
  
  IF ValType(nClr)="N"
     bBlq:={||oSelClr:oSay:SetColor(NIL,nColor)}
     oSelClr:oSay:SetColor(NIL,nColor)
     nColor:=nClr
  ENDIF
 
  bBlq:={||nRed   :=nRGBRed(nColor)  ,;
           nBlue  :=nRGBBlue(nColor) ,;
           nGreen :=nRGBGreen(nColor),;
           cHex   :=WebRgb(nRed,nGreen,nBlue)}

  bUpDate:={||oGet1:VarPut(nRGBRed(nColor  ),.T.),;
              oGet2:VarPut(nRGBBlue(nColor ),.T.),;
              oGet3:VarPut(nRGBGreen(nColor),.T.),;
              oGet4:VarPut(WebRgb(nRed,nGreen,nBlue),.T.)}


  EVAL(bBlq)
 
  @ 3,1 SAY "Número RGB:"
  @ 4,1 SAY "Red:"
  @ 5,1 SAY "Green:"
  @ 6,1 SAY "Blue:"
  @ 7,1 SAY "Hexadecimal:"


  @ 4,1 BMPGET oSelClr:oGet VAR nColor NAME "BITMAPS\COLORS.BMP";
                            SIZE 50,10;
                            ACTION (oSelClr:oSay:SetColor(NIL,nColor),;
                                    oSelClr:oSay:SelColor(),;
                                    nColor:=oSelClr:oSay:nClrPane,EVAL(bUpDate));
                            VALID (EVAL(bBlq),oSelClr:oDlg:UpDate(),.T.)

  @ 5,1 GET oGet1 VAR nRed   PICT "999" 
  @ 6,1 GET oGet2 VAR nBlue  PICT "999" 
  @ 7,1 GET oGet3 VAR nGreen PICT "999" 
  @ 8,1 GET oGet4 VAR cHex   

  @ 6,1 BUTTON " Cerrar "              ACTION (oDp:nColor:=nColor,oSelClr:Close())
  @ 7,1 BUTTON " Copiar Hexadecimal "  ACTION (oDp:nColor:=nColor,oSelClr:ClpCopy(cHex,oSelClr),oSelClr:Close())
  @ 8,1 BUTTON " Copiar Decimal "      ACTION (oDp:nColor:=nColor,oSelClr:ClpCopy(alltrim(Str(nColor)),oSelClr),oSelClr:Close())

  oSelClr:Activate(bBlq)

RETURN cHex

FUNCTION ClpCopy(cText,oSelClr) 

   local oClp
   
   DEFINE CLIPBOARD oClp OF oSelClr:oDlg:oWnd ;
      FORMAT TEXT

   if oClp:Open()
      oClp:Clear()
      oClp:SetText( cText )
      oClp:End()
   else
      MsgAlert( "The clipboard not Esta Disponible" )
   endif

return nil





