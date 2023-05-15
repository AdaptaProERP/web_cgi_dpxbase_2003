// Programa   : CGICLAVE
// Fecha/Hora : 19/05/2003 17:14:09
// PropÑsito  : Bifurcar la Salida del CGIPRESENTA, Genera el Formulario Regªstrese
// Creado Por : Oscar Londoªo
// Llamado por: CGIPRESENTA
// AplicaciÑn : DPCGI para Control de Usuario
// Tabla      : CNFCLIENTES

#INCLUDE "DPXBASE.CH"
#INCLUDE "DPCGI.CH"

FUNCTION CGIMENU(oCgi)
local I,aOscar

aOscar:=aTable("SELECT PRO_CODIGO,PRO_NOMBRE FROM CNFPRODUCTOS")
MsgList(aOscar)

  IF !oCgi:IsDef("BTNPRES")
    oCgi:cPass:=""
    oCgi:cLogin:=""
    oCgi:BTNPRES="Registrese"
  ENDIF

  IF oCgi:BTNPRES="Configuracion" .and. oCgi:cPass="654321" .and. LOWER(oCgi:cLogin)="datapro"
   oCgi:SayHtml("<HTML><HEAD>")
   oCgi:SayHtml([<META http-equiv=REFRESH content="0 URL=\concolor.htm" TARGET=_self>]) 
   oCgi:SayHtml("</HEAD><BODY></BODY></HTML>")   
  ENDIF

  IF EMPTY(oCgi:cPass) .OR. EMPTY(oCgi:cLogin)
     Ejecutar("CGIMSGERR","Campos Requeridos","¦Debe Llenar los Campos Login y Clave!")
     RETURN .T.
  ENDIF

  IF oCgi:BTNPRES="Exclusivo"
    CGIEXCLUSIVO(oCgi)
  ENDIF

  IF oCgi:BTNPRES="Conformacion"
    CGICONFOR(oCgi)
  ENDIF

  IF oCgi:BTNPRES="Modificar"
   CGICLINEW(oCgi)
  ENDIF

  IF oCgi:BTNPRES="Evaluar"
    Ejecutar("CGIMSGERR","Formulario en Desarrollo","OpciÑn en Proceso")
    RETURN .T.
  ENDIF
   IF oCgi:BTNPRES="Configuracion" .and. (oCgi:cPass<>"654321" .OR. LOWER(oCgi:cLogin)<>"datapro")
    Ejecutar("CGIMSGERR","Clave Incorrecta","¦Nombre de Usuario  o Clave Incorrecta!")
    RETURN .T.
  ENDIF
RETURN NIL

FUNCTION CGICLINEW(oCgi)
  LOCAL oTable,CLI_PASS,lMessage:=.F.
  LOCAL cWhere:="",aLista

  IF !EMPTY(oCgi:cPass+oCgi:cLogin)
    cWhere:=[ WHERE CLI_PASS]+GetWhere("=",oCgi:cPass)+ [ AND ]+[ CLI_LOGIN]+GetWhere("=",oCgi:cLogin)
  ENDIF

                 // Asignamos Tabla y Preparamos Campos //

  oTable:=OpenTable("SELECT * FROM CNFCLIENTES "+cWhere,!EMPTY(cWhere))

  IF oTable:RecCount=0
     lMessage:=.T.
  ENDIF

  oCgi:SetTable(oTable,"CLI_RIF") // Crea las Variables Seg+n la tabla, para Incluir

  oCgi:CLI_RUBRO:=OemToAnsi(oCgi:CLI_RUBRO)


  IF !Empty(cWhere)
     oCgi:Public("CLI_CODIGO",oTable:CLI_CODIGO) // Este pasa Vacio porque no esta en INPUT
     oCgi:Public("CLI_PASS",oTable:CLI_PASS) // Este pasa Vacio porque no esta en INPUT
  ENDIF

  oCgi:IniForm("CGICLISAVE") // Luego graba los datos
  oCgi:SayHtml([<style type="text/css">])
  oCgi:SayHtml("a.link4       {color:#FFFFFF; font-family: verdana, arial, helvetica, sans-serif; font-size: 13px ; TEXT-DECORATION: none}")
  oCgi:SayHtml("a.link4:hover {color:#FFFFFF; TEXT-DECORATION: none}")
  oCgi:SayHtml("TD {font-family: verdana, arial, helvetica, sans-serif; font-size: 10px}")
  oCgi:SayHtml("p.titu {color: #FFFFFF; font-family: verdana, arial, helvetica, sans-serif; font-size: 10px}")
  oCgi:SayHtml("</style>")

  HTMCENTER
  IF lMessage
    oCgi:SayHtml("<B><FONT SIZE=4 COLOR=RED>Usted no se Encuentra Registrado Por Favor Registrese</FONT></B>")
  ENDIF
  oCgi:SayHtml("<TABLE border=0 width=90%>")
  oCgi:SayHtml("<TR BGCOLOR="+CGIBORDE+">")
  oCgi:SayHtml("<TD align=center>")

  oCgi:SayHtml("<TABLE border=0 width=100%>")
  oCgi:SayHtml("<TR BGCOLOR="+CGICABECERA+">")
  oCgi:SayHtml("<TD align=center>")
  oCgi:SayHtml("<B><FONT SIZE=4 COLOR="+CGITITULO+">Registro de Usuario </FONT></B>")
  oCgi:SayHtml("</TD></TR></TABLE>")


  oCgi:SayHtml("<TABLE width=100% height=8%>")
  oCgi:SayHtml("<TR BGCOLOR="+CGIFONDOINPAR+">")
  oCgi:SayHtml("<TD>")
  oCgi:TABLEINI("","BORDER=0")
  oCgi:TABLEINI("","BORDER=0")
  ocgi:TABLECOL("RIF o C+dula")
  ocgi:TABLEEND()
  oCgi:SayHtml("</TD>")
  oCgi:SayHtml("<TD>")
  oCgi:TABLEINI("","BORDER=0")
  oCgi:Get("CLI_RIF",oCgi:CLI_RIF)
  ocgi:TABLEEND()
  oCgi:SayHtml("</TD>")
  oCgi:SayHtml("</TR>")

  oCgi:SayHtml("<TR BGCOLOR="+CGIFONDOPAR+">")
  oCgi:SayHtml("<TD>")
  oCgi:TABLEINI("","BORDER=0")
  ocgi:TABLECOL("NIT")
  ocgi:TABLEEND()
  oCgi:SayHtml("</TD>")
  oCgi:SayHtml("<TD>")
  oCgi:TABLEINI("","BORDER=0")
  oCgi:Get("CLI_NIT",oCgi:CLI_NIT)
  oCgi:TableEnd()
  oCgi:SayHtml("</TD>")
  oCgi:SayHtml("</TR>")

  oCgi:SayHtml("<TR BGCOLOR="+CGIFONDOINPAR+">")
  oCgi:SayHtml("<TD>")
  oCgi:TABLEINI("","BORDER=0")
  ocgi:TABLECOL("Titular de la Licencia")
  ocgi:TABLEEND()
  oCgi:SayHtml("</TD>")
  oCgi:SayHtml("<TD>")
  oCgi:TABLEINI("","BORDER=0")
  oCgi:Get("CLI_NOMBRE",oCgi:CLI_NOMBRE)
  oCgi:TableEnd()
  oCgi:SayHtml("</TD>")
  oCgi:SayHtml("</TR>")

  oCgi:SayHtml("<TR BGCOLOR="+CGIFONDOPAR+">")
  oCgi:SayHtml("<TD>")
  oCgi:TABLEINI("","BORDER=0")
  oCgi:TABLECOL("Estado de UbicaciÑn")
  oCgi:TableEnd()
  oCgi:SayHtml("</TD>")
  oCgi:SayHtml("<TD>")
  oCgi:TABLEINI("","BORDER=0")
  aLista:=ejecutar("aDataTxt","estados.txt")
  oCgi:ListBox(aLista,"CLI_ESTADO",oCgi:CLI_ESTADO)
  oCgi:TABLEEND()
  oCgi:SayHtml("</TD>")
  oCgi:SayHtml("</TR>")

  oCgi:SayHtml("<TR BGCOLOR="+CGIFONDOINPAR+">")
  oCgi:SayHtml("<TD>")
  oCgi:TABLEINI("","BORDER=0")
  oCgi:TABLECOL("Telefono")
  oCgi:TableEnd()
  oCgi:SayHtml("</TD>")
  oCgi:SayHtml("<TD>")
  oCgi:TABLEINI("","BORDER=0")
  oCgi:Get("CLI_CODAR1",oCgi:CLI_CODAR1)
  oCgi:TABLECOL("-")
  oCgi:Get("CLI_TEL1",oCgi:CLI_TEL1)
  oCgi:TableEnd()
  oCgi:SayHtml("</TD>")
  oCgi:SayHtml("</TR>")

  oCgi:SayHtml("<TR BGCOLOR="+CGIFONDOPAR+">")
  oCgi:SayHtml("<TD>")
  oCgi:TABLEINI("","BORDER=0")
  oCgi:TABLECOL("Celular")
  oCgi:TableEnd()
  oCgi:SayHtml("</TD>")
  oCgi:SayHtml("<TD>")
  oCgi:TABLEINI("","BORDER=0")
  oCgi:Get("CLI_CODAR2",oCgi:CLI_CODAR2)
  oCgi:TABLECOL("-")
  oCgi:Get("CLI_TEL2",oCgi:CLI_TEL2)
  oCgi:TableEnd()
  oCgi:SayHtml("</TD>")
  oCgi:SayHtml("</TR>")

  oCgi:SayHtml("<TR BGCOLOR="+CGIFONDOINPAR+">")
  oCgi:SayHtml("<TD>")
  oCgi:TABLEINI("","BORDER=0")
  oCgi:TABLECOL("Fax")
  oCgi:TableEnd()
  oCgi:SayHtml("</TD>")
  oCgi:SayHtml("<TD>")
  oCgi:TABLEINI("","BORDER=0")
  oCgi:Get("CLI_CODAR3",oCgi:CLI_CODAR3)
  oCgi:TABLECOL("-")
  oCgi:Get("CLI_TEL3",oCgi:CLI_TEL3)
  oCgi:TableEnd()
  oCgi:SayHtml("</TD>")
  oCgi:SayHtml("</TR>")

  oCgi:SayHtml("<TR BGCOLOR="+CGIFONDOPAR+">")
  oCgi:SayHtml("<TD>")
  oCgi:TableIni("","BORDER=0")
  oCgi:TABLECOL("Direccion")
  oCgi:TableEnd()
  oCgi:SayHtml("</TD>")
  oCgi:SayHtml("<TD>")
  oCgi:TABLEINI("","BORDER=0")
  oCgi:GetMemo("CLI_DIRE",oCgi:CLI_DIRE,6,40)
  oCgi:TableEnd()
  oCgi:SayHtml("</TD>")
  oCgi:SayHtml("</TR>")

  oCgi:SayHtml("<TR BGCOLOR="+CGIFONDOINPAR+">")
  oCgi:SayHtml("<TD>")
  oCgi:TABLEINI("","BORDER=0")
  oCgi:TABLECOL("Nombre del Representante")
  oCgi:TableEnd()
  oCgi:SayHtml("</TD>")
  oCgi:SayHtml("<TD>")
  oCgi:TABLEINI("","BORDER=0")
  oCgi:Get("CLI_REPREN",oCgi:CLI_REPREN)
  oCgi:TableEnd
  oCgi:SayHtml("</TD>")
  oCgi:SayHtml("</TR>")

  oCgi:SayHtml("<TR BGCOLOR="+CGIFONDOPAR+">")
  oCgi:SayHtml("<TD>")
  oCgi:TABLEINI("","BORDER=0")
  oCgi:TABLECOL("Apellido del Representante")
  oCgi:TableEnd
  oCgi:SayHtml("</TD>")
  oCgi:SayHtml("<TD>")
  oCgi:TABLEINI("","BORDER=0")
  oCgi:Get("CLI_REPREA",oCgi:CLI_REPREA)
  oCgi:TableEnd
  oCgi:SayHtml("</TD>")
  oCgi:SayHtml("</TR>")

  oCgi:SayHtml("<TR BGCOLOR="+CGIFONDOINPAR+">")
  oCgi:SayHtml("<TD>")
  oCgi:TABLEINI("","BORDER=0")
  oCgi:TABLECOL("Login de Usuario")
  oCgi:TableEnd
  oCgi:SayHtml("</TD>")
  oCgi:SayHtml("<TD>")
  oCgi:TABLEINI("","BORDER=0")
  oCgi:Get("CLI_LOGIN",oCgi:CLI_LOGIN)
  oCgi:TableEnd
  oCgi:SayHtml("</TD>")
  oCgi:SayHtml("</TR>")

  oCgi:SayHtml("<TR BGCOLOR="+CGIFONDOPAR+">")
  oCgi:SayHtml("<TD>")
  oCgi:TABLEINI("","BORDER=0")
  oCgi:TABLECOL("Correo Electronico")
  oCgi:TableEnd
  oCgi:SayHtml("</TD>")
  oCgi:SayHtml("<TD>")
  oCgi:TABLEINI("","BORDER=0")
  oCgi:Get("CLI_EMAIL",oCgi:CLI_EMAIL)
  oCgi:TableEnd
  oCgi:SayHtml("</TD>")
  oCgi:SayHtml("</TR>")

  oCgi:SayHtml("<TR BGCOLOR="+CGIFONDOINPAR+">")
  oCgi:SayHtml("<TD>")
  oCgi:TABLEINI("","BORDER=0")
  oCgi:TableCol([CIP&nbsp;<FONT COLOR="WHITE" SIZE="1">(Si es Contador Publico)</FONT>])
  oCgi:TableEnd
  oCgi:SayHtml("</TD>")
  oCgi:SayHtml("<TD>")
  oCgi:TABLEINI("","BORDER=0")
  oCgi:Get("CLI_CIP",oCgi:CLI_CIP)
  oCgi:TableEnd
  oCgi:SayHtml("</TD>")
  oCgi:SayHtml("</TR>")

  oCgi:SayHtml("<TR BGCOLOR="+CGIFONDOPAR+">")
  oCgi:SayHtml("<TD>")
  oCgi:TABLEINI("","BORDER=0")
  oCgi:TABLECOL("Rubro")
  oCgi:TableEnd
  oCgi:SayHtml("</TD>")
  oCgi:SayHtml("<TD>")
  oCgi:TABLEINI("","BORDER=0")
  aLista:=ejecutar("aDataTxt","Rubro.txt",.t.)
  oCgi:ListBox(aLista,"CLI_RUBRO",oCgi:CLI_RUBRO)
  oCgi:TableEnd
  oCgi:SayHtml("</TD>")
  oCgi:SayHtml("</TR>")

  oCgi:SayHtml("<TR BGCOLOR="+CGIFONDOINPAR+">")
  oCgi:SayHtml("<TD>")
  oCgi:TABLEINI("","BORDER=0")
  oCgi:TABLECOL("Numero de Sucursales")
  oCgi:TableEnd
  oCgi:SayHtml("</TD>")
  oCgi:SayHtml("<TD>")
  oCgi:TABLEINI("","BORDER=0")
  oCgi:Get("CLI_NUMSUC",oCgi:CLI_NUMSUC)
  oCgi:TABLEEND()
  oCgi:SayHtml("</TD>")
  oCgi:SayHtml("</TR>")
  oCgi:SayHtml("<TR>")
  oCgi:SayHtml("<TD COLSPAN=2 ALIGN=CENTER BGCOLOR="+CGICABECERA+">")
  oCgi:SayHtml("<B><FONT SIZE=4 COLOR="+CGITITULO+">Actividad Economica</FONT></B>")
  oCgi:SayHtml("</TD>")
  oCgi:SayHtml("</TR>")
  oCgi:SayHtml("<TR>")
  oCgi:SayHtml("<TD COLSPAN=2 BGCOLOR="+CGIFONDOPAR+">")

  oCgi:SayHtml("<TABLE BORDER=0 HEIGHT=100% WIDTH=100% BGCOLOR="+CGIBORDE+">")
  oCgi:SayHtml("<TR BGCOLOR="+CGIFONDOPAR+">")
  oCgi:SayHtml("<TD><a class=link4><b>")
  oCgi:Radio("Mayorista","CLI_MAYOR","CHECKBOX")
  oCgi:SayHtml("</a></b></TD>")
  oCgi:SayHtml("<TD><a class=link4><b>")
  oCgi:Radio("Detallista","CLI_DETAL","CHECKBOX")
  oCgi:SayHtml("</a></b></TD>")
  oCgi:SayHtml("<TD><a class=link4><b>")
  oCgi:Radio("Importador","CLI_IMPOR","CHECKBOX")
  oCgi:SayHtml("</a></b></TD>")
  oCgi:SayHtml("</TR>")

  oCgi:SayHtml("<TR BGCOLOR="+CGIFONDOINPAR+">")
  oCgi:SayHtml("<TD><a class=link4><b>")
  oCgi:Radio("Exportador","CLI_EXPOR","CHECKBOX")
  oCgi:SayHtml("</a></b></TD>")
  oCgi:SayHtml("<TD><a class=link4><b>")
  oCgi:Radio("Fabricante","CLI_FABRI","CHECKBOX")
  oCgi:SayHtml("</a></b></TD>")
  oCgi:SayHtml("<TD><a class=link4><b>")
  oCgi:Radio("Servicios","CLI_SERVI","CHECKBOX")
  oCgi:SayHtml("</a></b></TD>")
  oCgi:SayHtml("</TR>")

  oCgi:SayHtml("<TR BGCOLOR="+CGIFONDOPAR+">")
  oCgi:SayHtml("<TD><a class=link4><b>")
  oCgi:Radio("Franquiciante","CLI_FRANTE","CHECKBOX")
  oCgi:SayHtml("</a></b></TD>")
  oCgi:SayHtml("<TD><a class=link4><b>")
  oCgi:Radio("Franquiciado","CLI_FRANDO","CHECKBOX")
  oCgi:SayHtml("</a></b></TD>")
  oCgi:SayHtml("<TD><a class=link4><b>")
  oCgi:Radio("Educativo","CLI_EDUCA","CHECKBOX")
  oCgi:SayHtml("</a></b></TD>")
  oCgi:SayHtml("</TR>")

  oCgi:SayHtml("<TR BGCOLOR="+CGIFONDOINPAR+">")
  oCgi:SayHtml("<TD><a class=link4><b>")
  oCgi:Radio("Banca","CLI_BANCA","CHECKBOX")
  oCgi:SayHtml("</a></b></TD>")
  oCgi:SayHtml("<TD><a class=link4><b>")
  oCgi:Radio("Sector Publico","CLI_PUBLIC","CHECKBOX")
  oCgi:SayHtml("</a></b></TD>")
  oCgi:SayHtml("<TD><a class=link4><b>")
  oCgi:Radio("Otros","CLI_OTROS","CHECKBOX")
  oCgi:SayHtml("</a></b></TD>")
  oCgi:SayHtml("</TR>")
  oCgi:SayHtml("</TABLE>")

  oCgi:SayHtml("</TD>")
  oCgi:SayHtml("</TR>")
  oCgi:SayHtml("<TR>")
  oCgi:SayHtml("<TD COLSPAN=2 BGCOLOR="+CGICABECERA+" ALIGN=CENTER>")

  oCgi:SayHtml("<B><FONT SIZE=4 COLOR="+CGITITULO+">Servicios de Comunicacion</FONT></B>")

  oCgi:SayHtml("</TD>")
  oCgi:SayHtml("</TR>")
  oCgi:SayHtml("<TR>")
  oCgi:SayHtml("<TD COLSPAN=2 BGCOLOR="+CGIFONDOPAR+">")

  oCgi:SayHtml("<TABLE width=100% BGCOLOR="+CGIBORDE+">")
  oCgi:SayHtml("<TR BGCOLOR="+CGIFONDOPAR+">")
  oCgi:SayHtml("<TD><a class=link4><b>")
  oCgi:Radio("Servidor&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","CLI_SER","CHECKBOX")
  oCgi:SayHtml("</B></A></TD>")
  oCgi:SayHtml("<TD><a class=link4><b>")
  oCgi:Radio("Banda Ancha","CLI_BANDAA","CHECKBOX")
  oCgi:SayHtml("</B></A></TD>")
  oCgi:SayHtml("<TD><a class=link4><b>")
  oCgi:Radio("Red Local&nbsp;&nbsp;","CLI_RED","CHECKBOX")
  oCgi:SayHtml("</B></A></TD>")
  oCgi:SayHtml("</TR>")
  oCgi:SayHtml("</TABLE>")

  oCgi:TableEnd()


  oCgi:SayHtml("</TD>")
  oCgi:SayHtml("</TR>")
  oCgi:SayHtml("</TABLE>")

  HTMCENTER

  oCgi:NewLine()

  oCgi:Button("Registrar", "BTNPRES" ,"SUBMIT")

  oCgi:Button("Restaurar", "BTNPRES" ,"RESET")

  oCgi:NewLine(3)

RETURN NIL

FUNCTION CGICONFOR(oCgi)
  LOCAL oTable,cWhere:="",aLista,lCanal,aProduc

  cWhere:=[ WHERE CNL_PASS]+GetWhere("=",oCgi:cPass)+ [ AND ]+[ CNL_LOGIN]+GetWhere("=",oCgi:cLogin)
  oTable:=OpenTable("SELECT CNL_CODIGO FROM CNFCANALES "+cWhere,.T.)
  
  IF oTable:RecCount()=0
    cWhere:=[ WHERE CLI_PASS]+GetWhere("=",oCgi:cPass)+ [ AND ]+[ CLI_LOGIN]+GetWhere("=",oCgi:cLogin)
    oTable:=OpenTable("SELECT CLI_CODIGO FROM CNFCLIENTES "+cWhere,.T.)
    oCgi:Public("USU_CODIGO",oTable:CLI_CODIGO)
    lCanal=.F.
  ELSE
    oCgi:Public("USU_CODIGO",oTable:CNL_CODIGO)    
    lCanal=.T.
  ENDIF
  IF oTable:RecCount()=0
    Ejecutar("CGIMSGERR","Clave Incorrecta","¦Nombre de Usuario o Clave Incorrecta!")
    oTable:End()
    RETURN .T.   ENDIF
  oTable:End()
  oCgi:Iniform("CGICONFORMA")

  IF lCanal
   oCgi:SayHtml("<BR><BR><BR><BR><TABLE WIDTH=85% HEIGHT=25% BGCOLOR="+CGIBORDE+" ALIGN=CENTER>")
  ELSE
   oCgi:SayHtml("<BR><BR><BR><BR><TABLE WIDTH=60% HEIGHT=25% BGCOLOR="+CGIBORDE+" ALIGN=CENTER>")
  ENDIF
  oCgi:SayHtml("<TR  BGCOLOR="+CGICABECERA+[><TD>])
  oCgi:SayHtml([<TABLE WIDTH=100% HEIGHT=100% BGCOLOR=]+CGICABECERA+[ ALIGN=CENTER>])
  oCgi:SayHtml("<TR><TH ALIGN=CENTER COLSPAN=2>")
  oCgi:SayHtml("<FONT NAME=VERDANA COLOR="+CGITITULO+" SIZE=3><B>Ingrese los Datos de la Licencia</B></FONT>")
  oCgi:SayHtml("</TH></TR></TABLE></TD></TR>")
  oCgi:SayHtml("<TR BGCOLOR="+CGIFONDOINPAR+" ALIGN=CENTER><TD><BR>")

  oCgi:tableIni("","WIDTH=90% HEIGHT=30% ALIGN=CENTER")
  oCgi:TableCol("<FONT NAME=VERDANA COLOR="+CGITEXTO+" SIZE=3><B>&nbsp;&nbsp;&nbsp;&nbsp;Numero</B></FONT>","ALIGN=CENTER")
  oCgi:TableCol("<FONT NAME=VERDANA COLOR="+CGITEXTO+" SIZE=3><B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Serial</B></FONT>")
  oCgi:TableCol("<FONT NAME=VERDANA COLOR="+CGITEXTO+" SIZE=3><B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Producto</B></FONT>")
  IF lCanal
   oCgi:TableCol("<FONT NAME=VERDANA COLOR="+CGITEXTO+" SIZE=3><B>Rif del Titular</B></FONT>")
  ENDIF
  oCgi:TableLine
  oCgi:Get("cNumero","",10)
  oCgi:Get("cSerial","",8)
  oCgi:SayHtml([<TD><SELECT NAME=cProducto>])
  aProduc:=aTable("SELECT PRO_NOMBRE FROM CNFPRODUCTOS ORDER BY PRO_NOMBRE")
  FOR I=1 TO LEN(aProduc)
   oCgi:SayHtml([<OPTION>]+aProduc[I])
  NEXT I
  oCgi:SayHtml([</SELECT></TD>])
  IF lCanal
   oCgi:Get("cRif","",10)
  ENDIF
  oCgi:TableEnd()
  oCgi:NewLine()
  oCgi:SayHtml([<INPUT TYPE="SUBMIT" VALUE="Conformar" align="center" STYLE="width:90px; color=]+CGIBOTONCOLOR+[">])
  oCgi:SayHtml([<INPUT TYPE="RESET" VALUE="Limpiar" align="center" STYLE="width:90px; color=]+CGIBOTONCOLOR+[">])
  oCgi:NewLine(2)
  oCgi:SayHtml("</TD></TR></TABLE>")
RETURN NIL

FUNCTION CGIEXCLUSIVO(oCgi)
  LOCAL oTable,cWhere:=""

  cWhere:=[ WHERE CNL_PASS]+GetWhere("=",oCgi:cPass)+ [ AND ]+[CNL_LOGIN]+GetWhere("=",oCgi:cLogin)
  oTable:=OpenTable("SELECT CNL_CODIGO,CNL_NOMBRE FROM CNFCANALES"+cWhere,.T.)

  if oTable:RecCount()>0
    oCgi:IniForm("CGIEXCLUSIVO")
    oCgi:Public("BTNPRES",oCgi:BTNPRES)
    oCgi:Public("CNL_CODIGO",oTable:CNL_CODIGO)
    oCgi:Public("cLogin",oCgi:cLogin)
    oCgi:Public("cPass",oCgi:cPass)
  
    oTable:End()
    oCgi:SayHtml([<center><TABLE border=0 width=100% height=100%><TR BGCOLOR=]+CGIBORDE+[><TD align=center>])
    oCgi:SayHtml([<TABLE border=0 BGCOLOR=]+CGICABECERA+[ width=100%><TR><TD align=center>])
    oCgi:SayHtml([<center><FONT SIZE=5 COLOR=]+CGITITULO+[><p><b>Exclusivo Canales</b></p></FONT></CENTER>])
    oCgi:SayHtml("</TD></TR></TABLE>")
    oCgi:SayHtml("<TABLE border=0 width=100% height=90%><TR BGCOLOR=]+CGIFONDOINPAR+[><TD align=left><br><center>")
    oCgi:SayHtml([<FONT SIZE=4 COLOR=]+CGITEXTO+[>Bienvenido Canal ]+oTable:CNL_NOMBRE+[</FONT><br>])
    oCgi:Newline(7)
    oCgi:SayHtml([<INPUT TYPE="SUBMIT" VALUE="Cambio de Clave" NAME="BOTONPRES"  align="center" STYLE="color=CGIBOTONCOLOR">])
    oCgi:SayHtml([<INPUT TYPE="SUBMIT" VALUE="Conformar Licencias" NAME="BOTONPRES"  align="center" STYLE="color=CGIBOTONCOLOR">])
    oCgi:SayHtml([<INPUT TYPE="SUBMIT" VALUE="Listado de Licencias" NAME="BOTONPRES"  align="center" STYLE="color=CGIBOTONCOLOR">])
    oCgi:Newline(2)
//  oCgi:SayHtml([<INPUT TYPE="SUBMIT" VALUE="Activar Licencias" NAME="BOTONPRES"  align="center" STYLE="color=CGIBOTONCOLOR">])
    oCgi:SayHtml([<INPUT TYPE="SUBMIT" VALUE="Activar/Desactivar Licencias" NAME="BOTONPRES"  align="center" STYLE="color=CGIBOTONCOLOR">])
    oCgi:SayHtml([</center></TD></TR></TABLE></TD></TR></TABLE></center></body><html>])
  else
     Ejecutar("CGIMSGERR","Clave Incorrecta","¦Nombre de Usuario o Clave Incorrecta!")
    oTable:End()
    RETURN .T.   endif 
RETURN
