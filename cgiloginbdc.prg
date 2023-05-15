// Programa   :CGILOGINBDC
// Fecha/Hora : 05/08/2003 18:12:09
// Prop—sito  :Validar y dar acceso al usuario
// Creado Por :Francisco Castro IUT. RC
// Llamado por:CGIFORMLOGINBDC
// Aplicaci—n :BDC
// Tabla      :

#INCLUDE "DPXBASE.CH"
#INCLUDE "DPCGI.CH"

PROCE MAIN()
  Local oTable,cSQL:="",cPassword,nIndex,nValPass,cDirFile:="",cDirFile2:="",aValues:={}
LOCAL oTabla, cSQL:="",I
LOCAL aTemas:={}
LOCAL aVersion:={}
LOCAL cCodTema:=""

IF oCgi:ACTUVERSION = "False"

  //Validar que el usuario exista
  //Buscar el usuario
  cSQL = [SELECT BDCUSUARIO.USU_ID,BDCUSUARIO.USU_NOMBRE,BDCUSUARIO.USU_APELLI,BDCUSUARIO.USU_TIPO,BDCUSUARIO.USU_ESTADO,CNFCLIENTES.CLI_NOMBRE ]+;
  [FROM BDCUSUARIO INNER JOIN CNFCLIENTES ON (CNFCLIENTES.CLI_RIF = BDCUSUARIO.USU_CI_RIF) ]+;
  [WHERE (BDCUSUARIO.USU_LOGIN=']+ALLTRIM(oCgi:USU_LOGIN)+[') ]+;
  [AND (BDCUSUARIO.USU_PASS=']+ALLTRIM(oCgi:USU_PASS)+[')]
  oTable:=OpenTable(cSQL,.T.)
  //Si el usuario existe
  IF oTable:RecCount()>0
    IF !(oTable:USU_ESTADO = "S" .OR. oTable:USU_ESTADO = "I") //Si tiene el acceso permitido
      //Dar acceso enviar sus caracteristicas y formatear su pagina
      oCgi:Public("USU_CODIGO",ALLTRIM(oTable:USU_ID))
      oCgi:Public("USU_NOMBRE",ALLTRIM(oTable:USU_NOMBRE)+[ ]+ALLTRIM(oTable:USU_APELLI))
      oCgi:Public("USU_LIC_BAJ",ALLTRIM(oTable:CLI_NOMBRE))
      oCgi:Public("USU_TIPO",ALLTRIM(oTable:USU_TIPO))
      oCgi:Public("USU_TEMA",ALLTRIM(oCgi:CmbTema))
//Buscar el ID del tema
      cSQL:=[SELECT TEM_CODIGO ]+;
            [FROM BDCTEMA ]+;
            [WHERE BDCTEMA.TEM_DESCRI =']+ ALLTRIM(oCgi:CmbTema) +[']
      oTabla:=OpenTable(cSQL,.T.)
      oCgi:Public("USU_TEMCODIGO",ALLTRIM(oTabla:TEM_CODIGO))

//      oCgi:Public("USU_VERS",ALLTRIM(oCgi:CmbVersion))
      //Generar la pagina de bienvenida
//      oCgi:IniForm("CGIMENUPRINBDC")
//      oCgi:SayHtml("Bienvenido a la base de datos de conocimientos de datapro")
//      oCgi:ButTon("Men+ principal","BtnEntrar","Submit",,,,,)
//      Ejecutar("CGISETVALUSUBDC",oCgi)
      Ejecutar("CGIFORMEXPO",0)
    ELSE  ///No tiene acceso
      //Mensaje al usuario esta suspendido
      Ejecutar("CGIMSGERR","Usuario suspendido","Usted se encuantra temporalmente suspendido")
    ENDIF
  ELSE
    //Mensaje al usuario no existe
    Ejecutar("CGIMSGERR","Usuario no encontrado","Favor verifique sus datos")
  ENDIF
  oTable:End()

ELSE //SE ESTA CAMBIANDO EL PRODUCTO //**/**/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/

//Generar nuevamente el formulario con los valores que contenia
//al ser enviado, y anexar los que requiere
    oCgi:Head()
    oCgi:Title("Acceso a la base de datos de conocimientos de DATAPRO")
//Incluir los scripts para las validaciones u otras funciones
    oCgi:Scripts("FunctGen.js")
    oCgi:Scripts("FunValidLogIn.js")
    oCgi:Head()
//Generar el cuerpo del formulario

   oCgi:IniForm("CGILOGINBDC")   
   oCgi:NewLine(4)
   oCgi:SayHtml("<TABLE WIDTH=55% HEIGHT=10% BGCOLOR="+CGIBORDE+" ALIGN=CENTER>")
   oCgi:SayHtml("<TR  BGCOLOR="+CGICABECERA+[><TD>])

   oCgi:SayHtml([<TABLE WIDTH=100% HEIGHT=100% BGCOLOR=]+CGICABECERA+[ ALIGN=CENTER>])
   oCgi:SayHtml("<TR><TH ALIGN=CENTER COLSPAN=2>")
   oCgi:SayHtml("<FONT NAME=VERDANA COLOR="+CGITITULO+" SIZE=3><B>Ingreso a la base de datos de conocimiento</B></FONT>")
   oCgi:SayHtml("</TH></TR></TABLE></TD></TR>")
   oCgi:SayHtml("<TR BGCOLOR="+CGIFONDOINPAR+" ALIGN=CENTER><TD>")
   oCgi:NewLine()

   oCgi:tableIni("","WIDTH=70% HEIGHT=15% ALIGN=CENTER")
   oCgi:TableCol("<FONT NAME=VERDANA COLOR="+CGITEXTO+" SIZE=3><B>Login:</B></FONT>")
   oCgi:Get("USU_LOGIN", ALLTRIM(oCgi:USU_LOGIN),50)
   oCgi:TableLine()
   oCgi:TableCol("<FONT NAME=VERDANA COLOR="+CGITEXTO+" SIZE=3><B>Clave:</B></FONT>")
   oCgi:Get("USU_PASS", "",10,.T.) 

//Tema por el cual desea realizar la exposicion
   oCgi:TableLine()
   oCgi:TableCol("<FONT NAME=VERDANA COLOR="+CGITEXTO+" SIZE=3><B>Producto:</B></FONT>")
   //Buscar los temas en la BDD y Llenar el combo Temas
   cSQL:=[SELECT TEM_CODIGO,TEM_DESCRI FROM BDCTEMA]
   oTabla:=OpenTable(cSQL,.T.)
   for I := 1 to oTabla:Reccount()
     IF  ALLTRIM(oTabla:TEM_DESCRI) = ALLTRIM(oCgi:CmbTema)
       cCodTema := oTabla:TEM_CODIGO
     ENDIF
     AADD(aTemas,oTabla:TEM_DESCRI)
     oTabla:DbSkip()
   next I
   oTabla:End()
   //Pasa el combo y deja selecionado el item que marco el usuario
   oCgi:Listbox(aTemas,[CmbTema onchange="CambiaVersion();"], ALLTRIM(oCgi:CmbTema) ,1)

//Versiones segun el tema
   oCgi:TableLine()
   oCgi:TableCol("<FONT NAME=VERDANA COLOR="+CGITEXTO+" SIZE=3><B>Versi—n:</B></FONT>")
   //Llenar las Versiones
   cSQL:=[SELECT DISTINCT BDCVERSION.VER_DESCRI ]+;
         [FROM BDCVERTEM INNER JOIN BDCVERSION ON ]+;
         [BDCVERSION.VER_CODIGO = BDCVERTEM.VER_CODIGO ]+;
         [WHERE BDCVERTEM.TEM_CODIGO =']+ ALLTRIM(cCodTema) +[']
   oTabla:=OpenTable(cSQL,.T.)
   for I := 1 to oTabla:Reccount()
     AADD(aVersion,oTabla:VER_DESCRI)
     oTabla:DbSkip()
   next I
   oTabla:End()
   oCgi:Listbox(aVersion,[CmbVersion],"" ,1)
   oCgi:TableEnd()

//   oCgi:NewLine()
//   oCgi:SayHtml([<A HREF="\cgi-win\dpcgi.exe?func=cgilost&" onMouseOver="window.status='Olvido su Clave de usuario';return true" onMouseOut="window.status=''"><B><FONT NAME=VERDANA COLOR=#FFFFFF SIZE=2>Olvido su Clave de Usuario</FONT></B></A><BR>])

   oCgi:TableIni("","BORDE=0")
   oCgi:ButTon("Entrar","BtnEntrar","Button",,,,,[onClick="Validar();"])
   oCgi:ButTon("Limpiar","BtnLimpiar","Reset",,,,,"")
   oCgi:TableEnd
   oCgi:SayHtml("</TD></TR></TABLE>")

oCgi:Public("ACTUVERSION","False")

ENDIF

