// Programa   : CGIDESAC
// Fecha/Hora : 20/06/2003 16:22:24
// Propósito  : Activar o Desactivar una Licencia
// Creado Por : Oscar Londoño
// Llamado por: CGIEXCLUSIVO
// Aplicación : CGI
// Tabla      : CNFLICENCIA
#INCLUDE "DPXBASE.CH"

PROCE MAIN()
 LOCAL oTable,cWhere,cCodPro

   IF Empty(oCgi:cNumero) .or. (oCgi:cOpcion="---Seleccionar---") .or. (oCgi:cProducto="---Seleccionar---") .or. Empty(oCgi:cMotivos)
     Ejecutar("CGIMSGERR","Activacion/Desactivacion de Licencias","¡Debe llenar los Campos Numero de Licencia, Nombre del Producto, Motivo de la Desactivación y Accion!")
     RETURN .T.
   ENDIF

  oTable:=OpenTable([SELECT PRO_CODIGO,PRO_WIN FROM CNFPRODUCTOS WHERE PRO_NOMBRE]+GetWhere("=",ALLTRIM(oEmToAnsi(oCgi:cProducto))),.T.)
  cCodPro=oTable:PRO_CODIGO
  oTable:End()

   oCgi:cNumero:=STRZERO(VAL(oCgi:cNumero),10,0)
   cWhere:=[ WHERE LIC_NUMERO]+GetWhere("=",oCgi:cNumero)+[ AND LIC_CODCAN]+GetWhere("=",oCgi:CNL_CODIGO)+[ AND LIC_CODPRO]+GetWhere("=",cCodPro)
   oTable:=OpenTable([SELECT LIC_ESTADO,LIC_MOTIVO FROM CNFLICENCIA ]+cWhere,.T.)
   IF oTable:RecCount()>0
     IIF (oCgi:cOpcion="Activar",oTable:Replace("LIC_ESTADO","Activa"),oTable:Replace("LIC_ESTADO","Suspendida"))
     oTable:Replace("LIC_MOTIVO",oCgi:cMotivos)
     oTable:Commit(cWhere) 
     oTable:End()
     oCgi:IniForm("CGICLAVE")
     oCgi:Public("cLogin",oCgi:cLogin)
     oCgi:Public("cPass",oCgi:cPass)
     oCgi:Public("BTNPRES",oCgi:BTNPRES)
     oCgi:Public("CNL_CODIGO",oCgi:CNL_CODIGO)
     oCgi:NewLine(4)
     oCgi:SayHtml("<TABLE WIDTH=50% HEIGHT=25% BGCOLOR="+CGIBORDE+" ALIGN=CENTER>")
     oCgi:SayHtml([<TR  BGCOLOR=]+CGICABECERA+[><TD>])
     oCgi:SayHtml([<TABLE WIDTH=100% HEIGHT=100% BGCOLOR=]+CGICABECERA+[ ALIGN=CENTER>])
     oCgi:SayHtml("<TR><TH ALIGN=CENTER COLSPAN=2>")
     oCgi:SayHtml("<FONT NAME=VERDANA COLOR="+CGITITULO+" SIZE=3><B>Activacion/Desactivacion de Licencias</B></FONT>")
     oCgi:SayHtml("</TH></TR></TABLE></TD></TR>")
     oCgi:SayHtml("<TR BGCOLOR="+CGIFONDOINPAR+" ALIGN=CENTER><TD>")
     oCgi:NewLine()
     oCgi:tableIni("","WIDTH=90% HEIGHT=30% ALIGN=CENTER")
     oCgi:SayHtml([<TD ALIGN=CENTER><FONT NAME=VERDANA COLOR=]+CGITEXTO+[ SIZE=3><B>La Licencia Numero ]+oCgi:cNumero+[</B></FONT></TD>])
     oCgi:TableLine()
     oCgi:SayHtml([<TD ALIGN=CENTER><FONT NAME=VERDANA COLOR=]+CGITEXTO+[ SIZE=3><B>Ha sido ]+IIF(oCgi:cOpcion="Activar",[Activada],[Suspendida])+[</B></FONT></TD><TD></TD>])
     oCgi:TableLine
     oCgi:SayHtml([<TD COLSPAN=2 ALIGN=CENTER><INPUT TYPE=SUBMIT VALUE="Aceptar" NAME="Boton" STYLE="COLOR=]+CGIBOTONCOLOR+[" ALIGN=CENTER></TD>])
     oCgi:TableEnd()
     oCgi:NewLine
     oCgi:SayHtml("</TD></TR></TABLE>")
   ELSE
      oTable:End()
      Ejecutar("CGIMSGERR","Activacion/Desactivacion de Licencias","¡Numero de Licencia o Producto Incorrecto!")
      RETURN .T.
   ENDIF
RETURN
