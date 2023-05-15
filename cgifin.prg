// Programa   : CGIFIN
// Fecha/Hora : 15/05/2003 23:32:04
// Propósito  : Cerrar ejecución del CGI
// Creado Por : Juan Navas
// Llamado por: CGIINI
// Aplicación : DPCGI
// Tabla      : Todas

#INCLUDE "DPXBASE.CH"
#INCLUDE "DPCGI.CH"

FUNCTION MAIN(oCgi)
   LOCAL I,cPublic:="",uValue:=""

   FOR I=1 TO LEN(oCgi:aPublics)
     cPublic:=cPublic+IIF(EMPTY(cPublic),"",",")+oCgi:aPublics[I,1]
   NEXT I
  
   oCgi:cPublic:=cPublic
   IF !EMPTY(cPublic)
      oCgi:SayHtml([<INPUT TYPE="HIDDEN" NAME="CPUBLIC" VALUE="]+cPublic+[">])
   ENDIF
   FOR I=1 TO LEN(oCgi:aPublics)
      cPublic:=oCgi:aPublics[I,1]
      uValue :=CTOO(oCgi:aPublics[I,2],"C")
      oCgi:SayHtml([<INPUT TYPE="HIDDEN" NAME="]+cPublic+[" VALUE="]+uValue+[">])
   NEXT I

IF oCgi:nSeconds>0
  oCgi:SayHtml(STR(Seconds()-oCgi:nSeconds))
ENDIF
 
   IF oCgi:lIniForm // Formulario Iniciado
      oCgi:SayHtml([</FORM>])
   ENDIF


RETURN NIL






















































