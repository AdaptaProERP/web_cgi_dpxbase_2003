// Programa   : CGICONFORMA
// Fecha/Hora : 19/06/2003 00:58:21
// Propósito  : Crear el Formulario de Conformacion de Licencias 
// Creado Por : Oscar Londoño
// Llamado por: CGICLAVE
// Aplicación : CGI
// Tabla      : CNFLICENCIA

#INCLUDE "DPXBASE.CH"

PROCE MAIN()
  LOCAL oTable,cWhere,cCodigoC,cNumLic,cPass,cCodigo,cCodPro,cWindows,dFechaCul,cConformo,nDias
  LOCAL cCopia:="",cCorreoC,cNombreC,aValues:={},cTempo,dFchFin,cHtmOrg 

// Reviso que venga el Rif en Caso de Venir es un Canal en Caso Contrario es un Cliente

 IF oCgi:IsDef("cRif")

// Reviso que los campos no vengan Vacios

    IF Empty(oCgi:cRif) .or. Empty(oCgi:cNumero) .or. Empty(oCgi:cSerial) .or. (oCgi:cProducto="---Seleccionar---")
      Ejecutar("CGIMSGERR","Conformacion de Licencias","¡Debe llenar los Campos Rif, Serial, Numero y Producto!")
      RETURN .T.
    ENDIF

// Obtengo el Codigo del Cliente

   oTable:=OpenTable([SELECT CLI_CODIGO,CLI_EMAIL,CLI_NOMBRE FROM CNFCLIENTES WHERE CLI_RIF]+GetWhere("=",oCgi:cRif),.T.)
   IF oTable:RecCount()>0
     cCorreoC:=oTable:CLI_EMAIL
     cNombreC:=oTable:CLI_NOMBRE
     cCodigoC:=oTable:CLI_CODIGO 
     oTable:End()
   ELSE

// El Cliente no Existe

     oTable:End()
     Ejecutar("CGIMSGERR","Conformacion de Licencias","¡Rif o Cedula del Cliente Incorrecta!")
     RETURN .T.
   ENDIF
 ELSE
  cCodigoC:=oCgi:USU_CODIGO
 ENDIF
 

// Obtiene el Codigo del Producto Para la Determinacion del producto
// Validacion de LIC_NUMERO+LICCODPRO
 oTable:=OpenTable([SELECT PRO_CODIGO,PRO_WIN,PRO_MSGHTM FROM CNFPRODUCTOS WHERE PRO_NOMBRE]+GetWhere("=",ALLTRIM(oEmToAnsi(oCgi:cProducto))),.T.)
 cCodPro :=oTable:PRO_CODIGO
 cWindows:=oTable:PRO_WIN
 cHtmOrg :=oTable:PRO_MSGHTM // Htm, Que genera la clave de activación
 oTable:End()
 oCgi:cNumero:=STRZERO(VAL(oCgi:cNumero),10,0)

//Obtengo EL E-Mail del Cliente para su Confirmacion
 IF ValType(cCorreoC)="U" .OR. EMPTY(cCorreoC)
  oTable:=OpenTable([SELECT CLI_NOMBRE,CLI_EMAIL FROM CNFCLIENTES WHERE CLI_CODIGO]+GetWhere("=",oCgi:USU_CODIGO),.T.)
  cNombreC:=oTable:CLI_NOMBRE
  cCorreoC:=oTable:CLI_EMAIL  
  oTable:End()
 ENDIF

// Creo el Where para Hacer la Busqueda de la Licencia del Cliente o Canal Consultante 
IIF (oCgi:IsDef("cRif"),;
cWhere:=[ WHERE LIC_NUMERO]+GetWhere([=],oCgi:cNumero)+[ AND LIC_CODPRO]+GetWhere([=],cCodPro)+[ AND LIC_NUMSER]+GetWhere([=],oCgi:cSerial)+[ AND LIC_CODCAN]+GetWhere([=],oCgi:USU_CODIGO)+[ AND ]+[ LIC_CODCLI]+GetWhere([=],cCodigoC),;
cWhere:=[ WHERE LIC_NUMERO]+GetWhere([=],oCgi:cNumero)+[ AND LIC_CODPRO]+GetWhere([=],cCodPro)+[ AND LIC_NUMSER]+GetWhere([=],oCgi:cSerial)+[ AND LIC_CODCLI]+GetWhere([=],oCgi:USU_CODIGO))
 oTable:=OpenTable("SELECT LIC_TIPO,LIC_VALUPG,LIC_FECHCU,LIC_NUMERO,LIC_ESTADO FROM CNFLICENCIA "+cWhere,.T.)

// Reviso que no este Inaciva o Suspendida la Licencia 
IF oTable:LIC_ESTADO="Inactiva"
     oTable:End()
     Ejecutar("CGIMSGERR","Conformacion de Licencias","¡Licencia Inactiva Pongase en Contacto con su Vendedor!")
     RETURN .T.
ELSE  
 IF oTable:LIC_ESTADO="Suspendida"
     oTable:End()
     Ejecutar("CGIMSGERR","Conformacion de Licencias","¡Licencia Suspendida, Contacte con su Canal Datapro!")
     RETURN .T.
 ENDIF
ENDIF
 IF oTable:RecCount()>0 
  cNumLic=oTable:LIC_NUMERO

// Reviso que la Licencia no este Vencida
  dFchFin:=IIF (ValType(oTable:LIC_FECHCU)="C",Substr(oTable:LIC_FECHCU,9,2)+"/"+Substr(oTable:LIC_FECHCU,6,2)+"/"+Substr(oTable:LIC_FECHCU,1,4),DTOC(oTable:LIC_FECHCU))
  dFchFin:=CTOD(dFchFin)
  IF date()>dFchFin
     Ejecutar("CGIMSGERR","Conformacion de Licencias","¡Licencia Vencida Pongase en Contacto con su Vendedor!")
     RETURN .T.
  ENDIF

// Reviso que Posea Una Licencia Anterior del Mismo Producto en caso de que la Licencia a Conformar sea Actualizaion 
 IF oTable:LIC_VALUPG
  oTable:End()
  cWhere:=[WHERE LIC_CODCLI]+GetWhere([=],cCodigoC)+[ AND LIC_CODPRO]+GetWhere([=],cCodPro)
  oTable:=OpenTable("SELECT LIC_NUMERO FROM CNFLICENCIA "+cWhere,.T.)
  IF oTable:RecCount()>0 
     oTable:End()
     Ejecutar("CGIMSGERR","Conformacion de Licencias","¡Debe Tener una Licencia Full Antes de Poder Actualizar!")
     RETURN .T.
  ENDIF
 ENDIF
oTable:End()

// Reviso si ha sido Conformada la Licencia
  oTable:=OpenTable([SELECT CON_LICNUM FROM CNFCONFORMACION WHERE CON_LICNUM]+GetWhere([=],cNumLic),.T.)
  cConformo:=IIF (oTable:RecCount()>0,.t.,.f.) 
  oTable:End()
  cCodigo:=Incremental("CNFCONFORMACION","CON_CODIGO",.T.)

// Consigo la Clave de Conformacion segun su Version
  cPass:=IF (cWindows=.T.,ClaveWin(),ClaveDos())

  oTable:=OpenTable("CNFCONFORMACION",.F.)
  oTable:AppendBlank()
  oTable:Replace("CON_CODIGO",cCodigo)
  oTable:Replace("CON_FECHA",DATE())
  oTable:Replace("CON_LICNUM",cNumLic)
  oTable:Replace("CON_IP",oCgi:Remote_Address)
  oTable:Replace("CON_CLAVE",cPass)
  oTable:Replace("CON_CODPRO",cCodPro)
  IIF(oCgi:IsDef("cRif"),oTable:Replace("CON_ORIGEN","2"),oTable:Replace("CON_ORIGEN","1"))
  oTable:Commit()
  oTable:End()

// Llena los Campos fecha de Instalacion y
// Fecha de Culminacion si es Primnera Vez Que se Conforma

 IF !cConformo
  cWhere:=[ WHERE LIC_NUMERO]+GetWhere([=],cNumLic)+;
          [ AND LIC_CODPRO]+GetWhere([=],cCodPro)
  oTable:=OpenTable("SELECT * FROM CNFLICENCIA "+cWhere,.T.)
  IF oTable:RecCount()>0
    oTable:Replace("LIC_FECHIN",DATE()) // Ojo
    dFechaCul:=DATE()+oTable:LIC_TIEMPO*365
    nDias:=DAY(dFechaCul)-DAY(DATE())
    dFechaCul:=dFechaCul-nDias
    oTable:Replace("LIC_FECHCU",dFechaCul)
    oTable:Commit(cWhere)
  ENDIF
  oTable:End()
 ENDIF

// Envia el formulario con su Clave y numero de Licencia

 IF oCgi:IsDef("cRif") // Si es Canal, solo se le pide al canal
  oCgi:IniForm("CGICLAVE")
  oCgi:NewLine(5)
  oCgi:SayHtml("<TABLE WIDTH=50% HEIGHT=25% BGCOLOR="+CGIBORDE+" ALIGN=CENTER>")
  oCgi:SayHtml([<TR  BGCOLOR=]+CGICABECERA+[><TD>])
  oCgi:SayHtml([<TABLE WIDTH=100% HEIGHT=100% BGCOLOR=]+CGICABECERA+[ ALIGN=CENTER>])
  oCgi:SayHtml("<TR><TH ALIGN=CENTER COLSPAN=2>")
  oCgi:SayHtml("<FONT NAME=VERDANA COLOR="+CGITITULO+" SIZE=3><B>Conformacion de Licencias</B></FONT>")
  oCgi:SayHtml("</TH></TR></TABLE></TD></TR>")
  oCgi:SayHtml("<TR BGCOLOR="+CGIFONDOINPAR+" ALIGN=CENTER><TD>")
  oCgi:NewLine()
  oCgi:tableIni("","WIDTH=90% HEIGHT=30% ALIGN=CENTER")
  oCgi:TableCol([<FONT NAME=VERDANA COLOR=]+CGITEXTO+[ SIZE=3><B>Numero de Licencia:</B></FONT>])
  oCgi:TableCol([<FONT NAME=VERDANA COLOR=#FFFF00 SIZE=3><B>]+cNumLic+[</B></FONT>])
  oCgi:TableLine
  oCgi:TableCol([<FONT NAME=VERDANA COLOR=]+CGITEXTO+[ SIZE=3><B>Clave de Conformacion:</B></FONT><BR>])
  oCgi:TableCol([<FONT NAME=VERDANA COLOR=#FFFF00 SIZE=3><B>]+cPass+[</B></FONT>])
  oCgi:TableLine
  oCgi:TableEnd()
  oCgi:NewLine
  oCgi:SayHtml("</TD></TR></TABLE></FORM>")
 ELSE
   oCgi:IniForm("CGIPRESENTA")
   oCgi:Public("BTNPRES","Conformacion")
   oCgi:NewLine(4)
   oCgi:SayHtml([<CENTER><TABLE WIDTH=70% HEIGHT=40%><TR BGCOLOR=]+CGIBORDE+[><TD ALIGN=CENTER>])
   oCgi:SayHtml([<TABLE WIDTH=100% BGCOLOR=]+CGICABECERA+[ WIDTH=100%><TR><TD ALIGN=CENTER>])
   oCgi:SayHtml([<CENTER><FONT SIZE=4 NAME=VERDANA COLOR=]+CGITITULO+[><P><B>Linecia Conformada</B></P></FONT></CENTER>])
   oCgi:SayHtml("</TD></TR></TABLE>")
   oCgi:SayHtml("<TABLE WIDTH=100% HEIGHT=80%><TR BGCOLOR=]+CGIFONDOINPAR+[><TD ALIGN=LEFT><BR>")
   oCgi:SayHtml([<CENTER><FONT SIZE=3 NAME=VERDANA COLOR=]+CGITEXTO+[><B>La Informacion Solicitada ha sido Enviada</B></FONT><BR>]) 
   oCgi:SayHtml([<CENTER><FONT SIZE=3 NAME=VERDANA COLOR=]+CGITEXTO+[><B>a su Cuenta de Correo Electrónico,</B></FONT><BR>])
   oCgi:SayHtml([<CENTER><FONT SIZE=3 NAME=VERDANA COLOR=]+CGITEXTO+[><B>Llegara en Breves Instantes</B></FONT><BR><BR>])
   oCgi:Button("Aceptar", "h" ,"SUBMIT")
   oCgi:SayHtml([<BR><BR></CENTER></TD></TR></TABLE></TD></TR></TABLE>])
 ENDIF
   
    AADD(aValues,{"CGIUSUAR",cNombreC})
    AADD(aValues,{"CGILOGIN",cNumLiC})
    AADD(aValues,{"CGICLAVE",cPass})
    
    cCopia:=GetMailCanal(cCodigoC)

    cCopia:=IIF(EMPTY(cCopia),[],[-cc "])+cCopia+IIF(EMPTY(cCopia),[],[" ])

    // Indica el Archivo HTML Que genera la Clave
    cTempo:="\WebSite\htdocs\conforma2.htm" // Original, depende del producto

    cHtmOrg:=iif(empty(cHtmOrg),"C:\WebSite\htdocs\conforma.htm",cHtmOrg)
 
    oCgi:HTMPUTVALUE(cHtmOrg) // "C:\WebSite\htdocs\conforma.htm",aValues,cTempo)

    __COPYFILE(cTempo,LEFT(cTempo,at(".",cTempo)-2)+"3.htm",0)

    __RUN([BLAT.EXE -INSTALL mail.cantv.net datapro@telcel.net.ve],0)

    __RUN([BLAT.EXE ]+LEFT(cTempo,at(".",cTempo)-2)+"3.htm"+[ -to "]+LOWER(cCorreoC)+[" ]+cCopia+;
        [-S "Datapro le da las Gracias por Registrarse" ]+;
        [-html >BLAT.LOG],0)

   ferase(LEFT(cTempo,at(".",cTempo)-1)+"3.htm")

   ferase(cTempo)

 ELSE
  oTable:End()
  Ejecutar("CGIMSGERR","Conformacion de Licencias","¡Numero de Licencia, Serial o Producto Incorrecto!")
  RETURN .T.  ENDIF

RETURN NIL

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
