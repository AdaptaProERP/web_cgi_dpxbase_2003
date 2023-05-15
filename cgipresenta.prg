// Programa  : CGIPRESENTA
// Fecha/Hora: 15/05/2003 23:32:04
// Prop—sito : Ejecuci—n de Inicio Aplicacion Web
// Creado Por: Juan Navas
// Llamado por: DPCGI
// Aplicaci—n : CGI
// Tabla      : 

FUNCTION DPXBASE(oCgi)
LOCAL cPass,cLogin

   oCgi:IniForm("CGICLAVE")
   oCgi:Public("BTNPRES",oCgi:BTNPRES)
   oCgi:NewLine(4)
   oCgi:SayHtml("<TABLE WIDTH=55% HEIGHT=10% BGCOLOR="+CGIBORDE+" ALIGN=CENTER>")
   oCgi:SayHtml("<TR  BGCOLOR="+CGICABECERA+[><TD>])

   oCgi:SayHtml([<TABLE WIDTH=100% HEIGHT=100% BGCOLOR=]+CGICABECERA+[ ALIGN=CENTER>])
   oCgi:SayHtml("<TR><TH ALIGN=CENTER COLSPAN=2>")
   oCgi:SayHtml("<FONT NAME=VERDANA COLOR="+CGITITULO+" SIZE=3><B>Ingrese su Clave</B></FONT>")
   oCgi:SayHtml("</TH></TR></TABLE></TD></TR>")
   oCgi:SayHtml("<TR BGCOLOR="+CGIFONDOINPAR+" ALIGN=CENTER><TD>")
   oCgi:NewLine()
   oCgi:tableIni("","WIDTH=70% HEIGHT=15% ALIGN=CENTER")
   oCgi:TableCol("<FONT NAME=VERDANA COLOR="+CGITEXTO+" SIZE=3><B>Login de Usuario:</B></FONT>")
   oCgi:Get("cLogin",cLogin,10)
   oCgi:TableLine
   oCgi:TableCol("<FONT NAME=VERDANA COLOR="+CGITEXTO+" SIZE=3><B>Clave de Usuario:</B></FONT>")
   oCgi:Get("cPass",cPass,10,.T.) 
   oCgi:TableEnd()
   oCgi:SayHtml([<A HREF="\cgi-win\dpcgi.exe?func=cgilost&" onMouseOver="window.status='Olvido su Clave de usuario';return true" onMouseOut="window.status=''"><B><FONT NAME=VERDANA COLOR=#FFFFFF SIZE=2>Olvido su Clave de Usuario</FONT></B></A><BR>])
   oCgi:TableIni("","BORDE=0")
   oCgi:Button("Validar", "Boton","SUBMIT")
   oCgi:Button("Limpiar", "Boton","RESET")
   oCgi:TableEnd
   oCgi:NewLine()
   oCgi:SayHtml("</TD></TR></TABLE>")

RETUR
