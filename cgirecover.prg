// Programa   : CGIRECOVER
// Fecha/Hora : 04/07/2003 01:47:57
// Propósito  : Valida al Usuario y recupera su Clave
// Creado Por : Oscar Londoño
// Llamado por: CGILOST
// Aplicación : CGI
// Tabla      : CNFCLIENTES

#INCLUDE "DPXBASE.CH"

PROCE MAIN()
   Local oTable,cTempo,aValues:={},cCopia

   IF Empty(oCgi:cCedula) .OR. Empty(oCgi:cCorreo)
      Ejecutar("CGIMSGERR","Recupere su Clave","¡Debe llenar los Campos Rif y Correo Electronico!")
      RETURN .T.
   ENDIF

   oTable:=OpenTable([SELECT CLI_CODIGO,CLI_REPREN,CLI_PASS,CLI_LOGIN FROM CNFCLIENTES WHERE CLI_RIF]+GetWhere("=",oCgi:cCedula)+[ AND CLI_EMAIL]+GetWhere("=",oCgi:cCorreo),.T.)

   IF oTable:RecCount()>0

    AADD(aValues,{"CGIUSUAR",oTable:CLI_REPREN})
    AADD(aValues,{"CGILOGIN",oTable:CLI_LOGIN})
    AADD(aValues,{"CGICLAVE",oTable:CLI_PASS})

    cCopia:=GetMailCanal(oTable:CLI_CODIGO)

    oTable:End()

    cCopia:=IIF(EMPTY(cCopia),[],[-cc "])+cCopia+IIF(EMPTY(cCopia),[],[" ])
    
    cTempo:="C:\WebSite\htdocs\bienvenida.htm"
 
    oCgi:HTMPUTVALUE("C:\WebSite\htdocs\bienve.htm",aValues,cTempo)

    __COPYFILE(cTempo,LEFT(cTempo,at(".",cTempo)-1)+"2.htm",0)

    __RUN([BLAT.EXE -INSTALL mail.cantv.net datapro@telcel.net.ve],0)

    __RUN([BLAT.EXE ]+LEFT(cTempo,at(".",cTempo)-1)+"2.htm"+[ -to "]+LOWER(oCgi:cCorreo)+[" ]+cCopia+;
        [-S "Datapro le da las Gracias por Registrarse" ]+;
        [-html >BLAT.LOG],0)

   ferase(LEFT(cTempo,at(".",cTempo)-1)+"2.htm")
   ferase(cTempo)
   oCgi:IniForm("CGIPRESENTA")
   oCgi:Public("BTNPRES","Conformacion")
   oCgi:NewLine(4)
   oCgi:SayHtml([<CENTER><TABLE WIDTH=70% HEIGHT=40%><TR BGCOLOR=]+CGIBORDE+[><TD ALIGN=CENTER>])
   oCgi:SayHtml([<TABLE WIDTH=100% BGCOLOR=]+CGICABECERA+[ WIDTH=100%><TR><TD ALIGN=CENTER>])
   oCgi:SayHtml([<CENTER><FONT SIZE=4 NAME=VERDANA COLOR=]+CGITITULO+[><P><B>Recupere su Clave</B></P></FONT></CENTER>])
   oCgi:SayHtml("</TD></TR></TABLE>")
   oCgi:SayHtml("<TABLE WIDTH=100% HEIGHT=80%><TR BGCOLOR=]+CGIFONDOINPAR+[><TD ALIGN=LEFT><BR>")
   oCgi:SayHtml([<CENTER><FONT SIZE=3 NAME=VERDANA COLOR=]+CGITEXTO+[><B>La Informacion Solicitada ha sido Enviada</B></FONT><BR>]) 
   oCgi:SayHtml([<CENTER><FONT SIZE=3 NAME=VERDANA COLOR=]+CGITEXTO+[><B>a su Cuenta de Correo Electrónico,</B></FONT><BR>])
   oCgi:SayHtml([<CENTER><FONT SIZE=3 NAME=VERDANA COLOR=]+CGITEXTO+[><B>Llegara en Breves Instantes</B></FONT><BR><BR>])
   oCgi:Button("Aceptar", "h" ,"SUBMIT")
   oCgi:SayHtml([<BR><BR></CENTER></TD></TR></TABLE></TD></TR></TABLE>])
   ELSE
      oTable:End()
      Ejecutar("CGIMSGERR","Recupere su Clave","¡Rif, Cedula o Correo Electronico Incorrecto!")
      RETURN .T
   ENDIF

RETURN NIL

/*
// Determina los e-mail de los canales que esten relacionado con licencias del cliente
*/
FUNCTION GetMailCanal(cCodCli)
  LOCAL cSql,aTable,oTable,cCopia:=""

  cSql:=[SELECT CNL_EMAIL FROM CNFLICENCIA;
  INNER JOIN CNFCLIENTES ON LIC_CODCLI=CLI_CODIGO;
  INNER JOIN CNFCANALES  ON LIC_CODCAN=CNL_CODIGO;
  WHERE LIC_CODCLI=']+cCodCli+[';
  GROUP BY CNL_EMAIL]

  aTable:=aTable(cSql)
  Aeval(aTable,{|cEmail|cCopia:=cCopia+iif(empty(cCopia),"",",")+alltrim(cEmail)})

RETURN cCopia
