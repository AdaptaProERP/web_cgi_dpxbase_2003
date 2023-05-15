// Programa  : CGIPRESENTA
// Fecha/Hora: 15/05/2003 23:32:04
// Propósito : Ejecución de Inicio Aplicacion Web
// Creado Por: Juan Navas
// Llamado por: DPCGI
// Aplicación : CGI
// Tabla      : 

FUNCTION DPXBASE(oCgi)
LOCAL cPass,cLogin

   oCgi:IniForm("CGIRECOVER")
   oCgi:NewLine(4)
   oCgi:SayHtml("<TABLE WIDTH=50% HEIGHT=25% BGCOLOR="+CGIBORDE+" ALIGN=CENTER>")
   oCgi:SayHtml("<TR  BGCOLOR="+CGICABECERA+[><TD>])

   oCgi:SayHtml([<TABLE WIDTH=100% HEIGHT=100% BGCOLOR=]+CGICABECERA+[ ALIGN=CENTER>])
   oCgi:SayHtml("<TR><TH ALIGN=CENTER COLSPAN=2>")
   oCgi:SayHtml("<FONT NAME=VERDANA COLOR="+CGITITULO+" SIZE=3><B>Recupere su Clave</B></FONT>")
   oCgi:SayHtml("</TH></TR></TABLE></TD></TR>")
   oCgi:SayHtml("<TR BGCOLOR="+CGIFONDOINPAR+" ALIGN=CENTER><TD>")
   oCgi:NewLine()
   oCgi:tableIni("","WIDTH=87% HEIGHT=30% ALIGN=CENTER")
   oCgi:TableCol("<FONT NAME=VERDANA COLOR="+CGITEXTO+" SIZE=3><B>Rif o Cedula:</B></FONT>")
   oCgi:Get("cCedula","",15)
   oCgi:TableLine
   oCgi:TableCol("<FONT NAME=VERDANA COLOR="+CGITEXTO+" SIZE=3><B>Correo Electronico:</B></FONT>")
   oCgi:SayHtml([<TD><INPUT TYPE=TEXT NAME="cCorreo" VALUE="" MAXLENGTH="50" SIZE="15"></TD>])
   oCgi:TableEnd()
   oCgi:TableIni("","BORDE=0")
   oCgi:Button("Validar", "Boton","SUBMIT")
   oCgi:Button("Limpiar", "Boton","RESET")
   oCgi:TableEnd
   oCgi:NewLine
   oCgi:SayHtml("</TD></TR></TABLE>")

RETURN NIL

