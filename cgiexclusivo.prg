// Programa   : CGICAMCLAVE
// Fecha/Hora : 16/06/2003 15:01:04
// Propósito  : BIFURCAR SEGUN LA OPCION SELECCIONADA POR EL CANAL
// Creado Por : OSCAR LONDOÑO
// Llamado por: CGICLAVE
// Aplicación : CGI
// Tabla      : CNFCANAL
#INCLUDE "DPXBASE.CH"
#INCLUDE "DPCGI.CH"

PROCE MAIN()

IF oCgi:BOTONPRES="Cambio de Clave"
 CAMBIO(oCgi)
ENDIF

IF oCgi:BOTONPRES="Activar/Desactivar Licencias"
  ACTIVAR(oCgi)
ENDIF

IF oCgi:BOTONPRES="Listado de Licencias"
  LISTADO(oCgi)
ENDIF

IF oCgi:BOTONPRES="Conformar Licencias"
 CONFORMACION(oCgi)
ENDIF

RETURN

FUNCTION CAMBIO(oCgi)
  LOCAL cPass,cPass2

   oCgi:IniForm("CGIVALIDA")
   oCgi:Public("CNL_CODIGO",oCgi:CNL_CODIGO)
   oCgi:Public("cLogin",oCgi:cLogin)
   oCgi:Public("BTNPRES",oCgi:BTNPRES)
   oCgi:NewLine(4)
   oCgi:SayHtml("<TABLE WIDTH=55% HEIGHT=25% BGCOLOR="+CGIBORDE+" ALIGN=CENTER>")
   oCgi:SayHtml("<TR  BGCOLOR="+CGICABECERA+[><TD>])
   oCgi:SayHtml([<TABLE BORDE=1 WIDTH=100% HEIGHT=100% BGCOLOR=]+CGICABECERA+[ ALIGN=CENTER>])
   oCgi:SayHtml("<TR><TH COLSPAN=2 ALIGN=CENTER>")
   oCgi:SayHtml("<FONT NAME=VERDANA COLOR="+CGITITULO+" SIZE=3><B>Cambio de Clave de Usuario</B></FONT>")
   oCgi:SayHtml("</TH></TR></TABLE></TD></TR>")
   oCgi:SayHtml("<TR BGCOLOR="+CGIFONDOINPAR+" ALIGN=CENTER><TD>")
   oCgi:NewLine()
   oCgi:tableIni("","WIDTH=90% HEIGHT=30% ALIGN=CENTER")
   oCgi:TableCol("<FONT NAME=VERDANA COLOR="+CGITEXTO+" SIZE=3><B>Nueva Clave de Usuario:</B></FONT>")
   oCgi:Get("cPass",cPass,10,.T.)
   oCgi:TableLine
   oCgi:TableCol("<FONT NAME=VERDANA COLOR="+CGITEXTO+" SIZE=3><B>Retipee su Clave de Usuario:</B></FONT>")
   oCgi:Get("cPass2",cPass2,10,.T.)  
   oCgi:TableEnd()
   oCgi:TableIni("","BOPRDE=0")
   oCgi:Button("Validar", "Boton","SUBMIT")
   oCgi:Button("Limpiar", "Boton","RESET")
   oCgi:TableEnd
   oCgi:NewLine()
   oCgi:SayHtml("</TD></TR></TABLE>")

RETURN

FUNCTION ACTIVAR(oCgi)
LOCAL aProduc,I
  oCgi:Iniform("CGIDESAC")
  oCgi:Public("cLogin",oCgi:cLogin)
  oCgi:Public("cPass",oCgi:cPass)
  oCgi:Public("BTNPRES",oCgi:BTNPRES)
  oCgi:Public("CNL_CODIGO",oCgi:CNL_CODIGO)

  oCgi:SayHtml("<BR><BR><TABLE WIDTH=85% HEIGHT=25% BGCOLOR="+CGIBORDE+" ALIGN=CENTER>")
  oCgi:SayHtml("<TR  BGCOLOR="+CGICABECERA+[><TD>])
  oCgi:SayHtml([<TABLE WIDTH=100% HEIGHT=100% BGCOLOR=]+CGICABECERA+[ ALIGN=CENTER>])
  oCgi:SayHtml("<TR><TH ALIGN=CENTER COLSPAN=2>")
  oCgi:SayHtml("<FONT NAME=VERDANA COLOR="+CGITITULO+" SIZE=3><B>Ingrese los Datos de la Licencia</B></FONT>")
  oCgi:SayHtml("</TH></TR></TABLE></TD></TR>")
  oCgi:SayHtml("<TR BGCOLOR="+CGIFONDOINPAR+" ALIGN=CENTER><TD><BR>")

  oCgi:tableIni("","WIDTH=50% HEIGHT=20% ALIGN=CENTER")
  oCgi:TableCol("<FONT NAME=VERDANA COLOR="+CGITEXTO+" SIZE=3><B>&nbsp;Numero</B></FONT>","ALIGN=CENTER")
  oCgi:TableCol("<FONT NAME=VERDANA COLOR="+CGITEXTO+" SIZE=3><B>&nbsp;&nbsp;Nombre del Producto</B></FONT>")
  oCgi:TableCol("<FONT NAME=VERDANA COLOR="+CGITEXTO+" SIZE=3><B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Accion</B></FONT>")
  oCgi:TableLine
  oCgi:Get("cNumero","",10)
  oCgi:SayHtml([<TD><SELECT NAME=cProducto>])
  aProduc:=aTable("SELECT PRO_NOMBRE FROM CNFPRODUCTOS ORDER BY PRO_NOMBRE")
  FOR I=1 TO LEN(aProduc)
   oCgi:SayHtml([<OPTION>]+aProduc[I])
  NEXT I
  oCgi:SayHtml([</SELECT></TD>])
  oCgi:SayHtml([<TD><SELECT NAME=cOpcion>])
  oCgi:SayHtml([<OPTION>---Seleccionar---])
  oCgi:SayHtml([<OPTION>Activar])
  oCgi:SayHtml([<OPTION>Desactivar])
  oCgi:SayHtml([</SELECT></TD>])
  oCgi:TableEnd()

  oCgi:tableIni("","WIDTH=50% HEIGHT=20% ALIGN=CENTER")
  oCgi:TableCol("<FONT NAME=VERDANA COLOR="+CGITEXTO+" SIZE=3><B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Motivo de la Desactivacion</B></FONT>")
  oCgi:TableLine
  oCgi:GetMemo("cMotivos","",3,45)
  oCgi:TableEnd()
  oCgi:NewLine()
  oCgi:SayHtml([<INPUT TYPE="SUBMIT" VALUE="Procesar" align="center" STYLE="width:90px; color=]+CGIBOTONCOLOR+[">])
  oCgi:SayHtml([<INPUT TYPE="RESET" VALUE="Limpiar" align="center" STYLE="width:90px; color=]+CGIBOTONCOLOR+[">])
  oCgi:NewLine(2)
  oCgi:SayHtml("</TD></TR></TABLE>")

RETURN

FUNCTION LISTADO(oCgi)
  LOCAL oTable,cWhere,I,oTable2,cFechaVe
  SET DATE FREN
  cWhere:=[ WHERE LIC_CODCAN]+GetWhere("=",oCgi:CNL_CODIGO)
  oTable:=OpenTable("SELECT * FROM CNFLICENCIA "+cWhere+" ORDER BY LIC_FECHVE",.T.)

IF oTable:RecCount()>0

  oCgi:Iniform("CGIDETALLE")

  oCgi:SayHtml([<style type="text/css">])
  oCgi:SayHtml([a.link4       {color:#FFFFFF; font-family: verdana, arial, helvetica, sans-serif; font-size: 14px; TEXT-DECORATION: none}])
  oCgi:SayHtml([a.link4:hover {color:]+CGITEXTO+[; TEXT-DECORATION: none}])
  oCgi:SayHtml([TD {font-family: verdana, arial, helvetica, sans-serif; font-size: 12px}])
  oCgi:SayHtml([a.titu {color:#FFFFFF; font-family: verdana, arial, helvetica, sans-serif; font-size: 12px; TEXT-DECORATION: none}])
  oCgi:SayHtml([</style>])

  oCgi:SayHtml([<TABLE width=100% BGCOLOR=]+CGIBORDE+[><TR BGCOLOR=]+CGICABECERA+[>])
  oCgi:SayHtml([<TH COLSPAN=6><FONT NAME=VERDANA SIZE=4 COLOR=]+CGITITULO+[><B>Listado de Licencias</B></TH></TR><TR BGCOLOR=]+CGIFONDOINPAR+[>])
  oCgi:SayHtml([<TH><TABLE CELLSPACING=0 CELLPADDING=0><TR><TD><a class=link4><b>Numero<b><a></TD></TR></TABLE></TH>]) 
  oCgi:SayHtml([<TH><TABLE CELLSPACING=0 CELLPADDING=0><TR><TD><a class=link4><b>Fecha de Venta<b><a></TD></TR></TABLE></TH>])
  oCgi:SayHtml([<TH><TABLE CELLSPACING=0 CELLPADDING=0><TR><TD><a class=link4><b>Estado<b><a></TD></TR></TABLE></TH>])  
  oCgi:SayHtml([<TH><TABLE CELLSPACING=0 CELLPADDING=0><TR><TD><a class=link4><b>Producto<b><a></TD></TR></TABLE></TH>]) 
  oCgi:SayHtml([<TH><TABLE CELLSPACING=0 CELLPADDING=0><TR><TD><a class=link4><b>Cliente<b><a></TD></TR></TABLE></TH>])
  oCgi:SayHtml([<TH><TABLE CELLSPACING=0 CELLPADDING=0><TR><TD><a class=link4><b>Detalle<b><a></TD></TR></TABLE></TH>])  
 FOR I:=1 TO oTable:RecCount()
  IIF (MOD(I,2)<>0,oCgi:SayHtml([</TR><TR BGCOLOR=]+CGIFONDOPAR+[>]),oCgi:SayHtml([</TR><TR BGCOLOR=]+CGIFONDOINPAR+[>]))
  oCgi:SayHtml([<TD><TABLE><TR><TD><a class=titu>]+oTable:LIC_NUMERO+[</A></TD></TR></TABLE></TD>]) 
  cFechaVe:=IIF (ValType(oTable:LIC_FECHVE)="C",Substr(oTable:LIC_FECHVE,9,2)+"/"+Substr(oTable:LIC_FECHVE,6,2)+"/"+Substr(oTable:LIC_FECHVE,1,4),DTOC(oTable:LIC_FECHVE))
  oCgi:SayHtml([<TD ALIGN=CENTER><TABLE><TR><TD><a class=titu>]+cFechaVe+[</A></FONT></TD></TR></TABLE></TD>])
  oCgi:SayHtml([<TD ALIGN=CENTER><TABLE><TR><TD><a class=titu>]+oTable:LIC_ESTADO+[</A></TR></TABLE></TD>])  
  oTable2:=OpenTable("SELECT PRO_NOMBRE FROM CNFPRODUCTOS WHERE PRO_CODIGO"+GetWhere("=",oTable:LIC_CODPRO),.T.)
  oCgi:SayHtml([<TD><TABLE><TR><TD><a class=titu>]+LEFT(oTable2:PRO_NOMBRE,16)+[</A></TD></TR></TABLE></TD>]) 
  oTable2:End
  oTable2:=OpenTable("SELECT CLI_NOMBRE FROM CNFCLIENTES WHERE CLI_CODIGO"+GetWhere("=",oTable:LIC_CODCLI),.T.)
  oCgi:SayHtml([<TD><TABLE><TR><TD><a class=titu>]+LEFT(oTable2:CLI_NOMBRE,20)+[</A></TD></TR></TABLE></TD>]) 
  oTable2:End()
  oCgi:SayHtml([<TD ALIGN=CENTER><TABLE><TR><TD><a class=link4><INPUT TYPE=SUBMIT VALUE=]+oTable:LIC_NUMERO+[ NAME=BOTON style="width:23px;height:23px;color:#F0F0EB;"></A></TD></TR></TABLE></TD>])
  oTable:DbSkip()
 ENDFOR
 oTable:End
 oCgi:SayHtml([</TR></TABLE>]) 
 oCgi:SayHtml([<BR><CENTER><INPUT TYPE="BUTTON" VALUE="Aceptar" onclick="javascript:history.back();"></center>])
ELSE
  Ejecutar("CGIMSGERR","Listado de Licencias","¡No Tiene Licencias Asignadas!")
  RETURN .T.
ENDIF
RETURN

FUNCTION CONFORMACION(oCgi)
  oCgi:SayHtml([<HTML>])
  oCgi:SayHtml([<BODY onLoad="javascript:document.Form1.submit();">])
  oCgi:IniForm("CGICLAVE")
  oCgi:Public("cLogin",oCgi:cLogin)
  oCgi:Public("cPass",oCgi:cPass)
  oCgi:Public("BTNPRES","Conformacion")
RETUR
