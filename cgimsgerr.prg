// Programa   : CGIMSGERR
// Fecha/Hora : 27/05/2003 23:22:35
// Propósito  : Monstrar Mensaje de Validación
// Creado Por : Oscar Londoño
// Llamado por: Cualquier CGI
// Aplicación : DPCGI
// Tabla      : Todas

#INCLUDE "DPXBASE.CH"
#INCLUDE "DPCGI.CH"

FUNCTION DPXBASE(cTitulo,cMensaje)
  
   oCgi:IniForm("CGIPRESENTA")
   oCgi:SetCenter()
   oCgi:NewLine(4)
   oCgi:TableIni("","BORDER=0 TABLE WIDTH=70% TABLE HEIGHT=40% BGCOLOR="+CGIBORDE)
   oCgi:SayHtml([</TR><TR WIDTH=100% BGCOLOR=]+CGICABECERA+[><TD ALIGN=LEFT VALIGN=MIDDLE SIZE=4><B><FONT COLOR=]+CGITITULO+[>]+cTitulo+[</FONT></B></TD></TR>])
   oCgi:SayHtml([<TR BGCOLOR=]+CGIFONDOINPAR+[><TD ALIGN="center" VALIGN="middle"><BR><BR>])
   oCgi:SayHtml([<FONT COLOR=]+CGITEXTO+[ SIZE=3><b>]+cMensaje+[</b></FONT>])
   oCgi:NewLine(2)
   oCgi:SayHtml([<CENTER><INPUT TYPE="BUTTON" VALUE="Aceptar" onclick="javascript:history.back();"></center>])
   oCgi:NewLine()
   oCgi:SayHtml([</TD></TR>])
   oCgi:SayHtml([</TABLE>])


RETURN .T.
