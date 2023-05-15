// Programa   : CGIVALIDA
// Fecha/Hora : 16/06/2003 17:05:54
// Propósito  : Valida las Claves
// Creado Por : Oscar Londoño
// Llamado por: CGICAMCLAVE
// Aplicación : CGI
// Tabla      : CNFCANALES

#INCLUDE "DPXBASE.CH"
#INCLUDE "DPCGI.CH"

PROCE MAIN()
   LOCAL cPass,cPass2,cWhere,oTable

IF EMPTY(oCgi:cPass) .OR. EMPTY(oCgi:cPass2)
  Ejecutar("CGIMSGERR","Campos Requeridos","¡Debe Llenar los Campos Clave!")
  RETURN .T.
ENDIF

if oCgi:cPass!=oCgi:cPass2
  Ejecutar("CGIMSGERR","Claves Distintas","¡Los Campos Clave Deben ser Iguales!")
  RETURN .T.
else
  cWhere:=[ WHERE CNL_CODIGO]+GetWhere("=",oCgi:CNL_CODIGO)
  oTable:=OpenTable("SELECT CNL_PASS FROM CNFCANALES "+cWhere,.T.)
  oTable:Replace("CNL_PASS",oCgi:cPass)
  oTable:Commit(cWhere)
  oTable:End
  oCgi:IniForm("CGICLAVE")
  oCgi:Public("BTNPRES",oCgi:BTNPRES)
  oCgi:Public("cPass",oCgi:cPass)
  oCgi:Public("cLogin",oCgi:cLogin)
  oCgi:NewLine(4)
  oCgi:SayHtml([<CENTER><TABLE WIDTH=50% HEIGHT=40%><TR BGCOLOR=]+CGIBORDE+[><TD ALIGN=CENTER>])
  oCgi:SayHtml([<TABLE WIDTH=100% BGCOLOR=]+CGICABECERA+[ WIDTH=100%><TR><TD ALIGN=CENTER>])
  oCgi:SayHtml([<CENTER><FONT SIZE=4 NAME=VERDANA COLOR=]+CGITITULO+[><P><B>Cambio de Clave</B></P></FONT></CENTER>])
  oCgi:SayHtml("</TD></TR></TABLE>")
  oCgi:SayHtml("<TABLE WIDTH=100% HEIGHT=80%><TR BGCOLOR=]+CGIFONDOINPAR+[><TD ALIGN=LEFT><BR><BR>")
  oCgi:SayHtml([<CENTER><FONT SIZE=3 NAME=VERDANA COLOR=]+CGITEXTO+[><B>Su Clave ha Sido Cambiada con Exito</B></FONT><BR><BR>])
  oCgi:Button("Aceptar", "h" ,"SUBMIT")
  oCgi:SayHtml([<BR><BR></CENTER></TD></TR></TABLE></TD></TR></TABLE>])
endif

RETURN
