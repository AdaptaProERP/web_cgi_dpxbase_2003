// Programa   : CGIPRUEBA
// Fecha/Hora : 05/06/2003 16:44:09
// Propósito  :
// Creado Por :
// Llamado por:
// Aplicación :
// Tabla      :

#INCLUDE "DPXBASE.CH"

PROCE MAIN()
  LOCAL i,aVars,cMemo:="",cVar

  aVars:=_VECTOR(STRTRAN(memoread(oDp:cPathExe+"DATATXT\CGICOLOR.TXT"),CRLF,""))
 
  AEVAL(aVars,{|a,i,cVar|cVar:=LEFT(a,AT(":",a)-1),PUBLICO(cVar,cVar),MACROEJE(a),aVars[i]:=cVar})

  oCgi:COLOR:="#"+SUBSTR(oCgi:COLOR,4,6)
  
  PUBLICO("CGI"+oCgi:OPCION,oCgi:COLOR)

  if oCgi:OPCION="Fondo General"
   MSGALERT("Fondo General")
   oCgi:OPCION:="CGIFONDOG"
  endif

  // Ahora debe ensamblar los Colores
  FOR I=1 TO LEN(aVars)
    cVar :=MACROEJE(aVars[I])
    cVar :=["]+cVar+["]
    cMemo:=cMemo+IIF(i=1,"",",")+aVars[I]+[:=]+cVar
  NEXT I
  MemoWrit(oDp:cPathExe+"DATATXT\CGICOLOR.TXT",cMemo)
  Ejecutar("CGIPUTCOLOR") // Pinta todos los HTML
  oCgi:SayHtml("<HTML><HEAD>")
  oCgi:SayHtml([<META http-equiv=REFRESH content="0 URL=\concolor.htm">]) 
  oCgi:SayHtml("</HEAD><BODY></BODY></HTML>")

RETURN
