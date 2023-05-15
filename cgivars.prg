// Programa   : CGIVARS
// Fecha/Hora : 19/05/2003 01:17:03
// Propósito  : Visualizar todas las Variables del Formulario
// Creado Por : Juan Navas
// Llamado por: Cualquier CGI
// Aplicación : DPCGI General
// Tabla      : Todas
#INCLUDE "DPXBASE.CH"

FUNCTION CGIVARS()
   LOCAL I,uValue
   FOR I=1 TO LEN(oCgi:aVars)
      uValue:=oCgi:aVars[i,2]
      oCgi:SAYHTML(STRZERO(I,2)+":"+oCgi:aVars[I,1]+" = "+CTOO(uValue,"C"))
      oCgi:NewLine()
   NEXT I   
   oCgi:SAYHTML("Salida  :"+oCgi:Output_File)
   oCgi:NewLine()
   oCgi:SAYHTML("Query   :"+oCgi:Query_String)
   oCgi:NewLine()
   oCgi:SAYHTML("SoftWare:"+oCgi:Server_Software)
   oCgi:NewLine()
   oCgi:SAYHTML("Entrada :"+oCgi:cIniFile)
   oCgi:NewLine()
   oCgi:SAYHTML("Mehodo  :"+oCgi:Request_Method)
RETURN NIL

