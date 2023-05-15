// Programa   :CGIFORMLOGINBDC
// Fecha/Hora :05/08/2003 17:51:55
// Prop—sito  :Solicitar al usuario el login y passwod
// Creado Por :Francisco Castro IUT. RC.
// Llamado por:CGIBIFURCA
// Aplicaci—n :
// Tabla      :

#INCLUDE "DPXBASE.CH"

PROCE MAIN()

LOCAL oTabla, cSQL:="",I
LOCAL aTemas:={}
LOCAL aVersion:={}

LOCAL cCodTema:=""

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
   oCgi:Get("USU_LOGIN","",50)
   oCgi:TableLine()
   oCgi:TableCol("<FONT NAME=VERDANA COLOR="+CGITEXTO+" SIZE=3><B>Clave:</B></FONT>")
   oCgi:Get("USU_PASS","",10,.T.) 


//Tema por el cual desea realizar la exposicion
   oCgi:TableLine()
   oCgi:TableCol("<FONT NAME=VERDANA COLOR="+CGITEXTO+" SIZE=3><B>Producto:</B></FONT>")
   //Buscar los temas en la BDD y Llenar el combo Temas
   cSQL:=[SELECT TEM_CODIGO,TEM_DESCRI FROM BDCTEMA]
   oTabla:=OpenTable(cSQL,.T.)
   for I := 1 to oTabla:Reccount()
     IF I = 1
       cCodTema := oTabla:TEM_CODIGO
     ENDIF
     AADD(aTemas,oTabla:TEM_DESCRI)
     oTabla:DbSkip()
   next I
   oTabla:End()
   oCgi:Listbox(aTemas,[CmbTema], ALLTRIM(aTemas[1]) ,1)
//   oCgi:Listbox(aTemas,[CmbTema onchange="CambiaVersion();"], ALLTRIM(aTemas[1]) ,1)

/*
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
*/
//   oCgi:NewLine()
//   oCgi:SayHtml([<A HREF="\cgi-win\dpcgi.exe?func=cgilost&" onMouseOver="window.status='Olvido su Clave de usuario';return true" onMouseOut="window.status=''"><B><FONT NAME=VERDANA COLOR=#FFFFFF SIZE=2>Olvido su Clave de Usuario</FONT></B></A><BR>])

   oCgi:TableIni("","BORDE=0")
   oCgi:ButTon("Entrar","BtnEntrar","Button",,,,,[onClick="Validar();"])
   oCgi:ButTon("Limpiar","BtnLimpiar","Reset",,,,,"")
   oCgi:TableEnd
   oCgi:SayHtml("</TD></TR></TABLE>")
oCgi:Public("ACTUVERSION","False")
