// Programa   :CGIFORMREGBDC
// Fecha/Hora :15/07/2003 10:05:58
// Propósito  :Generar el formulario para el registro de los usuarios de la base de datos de conocimientos
// Creado Por :Francisco Castro IUT RC.
// Llamado por:Menu principal de opciones
// Aplicación :
// Tabla      :

#INCLUDE "DPXBASE.CH"
#INCLUDE "DPCGI.CH"

PROCE MAIN()
    oCgi:Head()
    oCgi:Title("Registro de usuarios para la base de datos de conocimientos de DATAPRO")
//Incluir los scripts para las validaciones u otras funciones
    oCgi:Scripts("REL.js")
    oCgi:Scripts("Fun.js")
    oCgi:Head()
//Generar el cuerpo del formulario
    oCgi:Iniform("CGIREGUSRBDC","")

//Colocar el estilo
oCgi:SayHtml([<style type="text/css">])
oCgi:SayHtml([a.link4       {color:#FFFFFF; font-family: verdana, arial, helvetica, sans-serif; font-size: 13px ; TEXT-DECORATION: none}])
oCgi:SayHtml([a.link4:hover {color:#FFFFFF; TEXT-DECORATION: none}])
oCgi:SayHtml([TD {font-family: verdana, arial, helvetica, sans-serif; font-size: 10px}])
oCgi:SayHtml([p.titu {color: #FFFFFF; font-family: verdana, arial, helvetica, sans-serif; font-size: 10px}])
oCgi:SayHtml([</style>])
    //Tabla principal
    oCgi:ABRETABLA("",[border=0 width=80% align="center" BGCOLOR =]+ CGIBORDE,"")
       oCgi:TrIni("") //Primera fila
       //Tabla del encabezado
       oCgi:TdIni("COLSPAN = 100%")
       oCgi:TableIni("",[border=0 width=100% align="center" bgcolor=]+ CGIBORDE,"")
          oCgi:TableCol([<font color=#000000>]+[Registro de usuarios de la BDD de conocimiento]+[</font>],[align="Center" COLSPAN=100%],)
       oCgi:TableEnd()
       oCgi:TrEnd() //Cierro la primera fila
//Rif     
       oCgi:TrIni([bgcolor=]+ CGIFONDOINPAR) //Segunda fila
          //Label Rif
       oCgi:TdIni("") //selda 1
       oCgi:TableIni("",[border=0 width=100% align="Left" Valign="MIDDLE"],"")
          oCgi:TableCol([<FONT COLOR=]+ CGITEXTO + [>RIF o Cédula</FONT>],"","")
       oCgi:TableEnd()
       oCgi:TdEnd() //selda 1
          //Txt Rif
       oCgi:TdIni( [bgcolor=]+ CGIFONDOINPAR) //selda 2 
       oCgi:TableIni("",[border=0 width=100% align="Left"],"")
       oCgi:TdIni("Valing=MIDDLE")
          oCgi:Txt("USU_ID","",20)
       oCgi:TdEnd()
       oCgi:TableEnd()
       oCgi:TrEnd()
//Nombre
       oCgi:TrIni([bgcolor=]+ CGIFONDOPAR) //Segunda fila
          //Label Nombre usuario
       oCgi:TdIni("") //selda 1
       oCgi:TableIni("",[border=0 width=100% align="Left"],"")
          oCgi:TableCol("Nombre","","")
       oCgi:TableEnd()
       oCgi:TdEnd() //selda 1
          //Txt Nombre
       oCgi:TdIni("") //selda 2
       oCgi:TableIni("",[border=0 width=100% align="Left"],"")
       oCgi:TdIni("Valing=MIDDLE")
          oCgi:Txt("USU_NOMBRE","",20)
       oCgi:TdEnd()
       oCgi:TableEnd()
       oCgi:TrEnd()
//Apellido usuario
       oCgi:TrIni([bgcolor=]+ CGIFONDOINPAR) //Segunda fila
          //Label Apellido
       oCgi:TdIni("") //selda 1
       oCgi:TableIni("",[border=0 width=100% align="Left"],"")
          oCgi:TableCol("Apellido","","")
       oCgi:TableEnd()
       oCgi:TdEnd() //selda 1
       oCgi:TdIni("") //selda 2       
          //Txt Apellido
       oCgi:TableIni("",[border=0 width=100% align="Left"],"")
       oCgi:TdIni("Valing=MIDDLE")
          oCgi:Txt("USU_APELLI","",20)
       oCgi:TdEnd()
       oCgi:TableEnd()
       oCgi:TrEnd()
//E-Mail usuario
       oCgi:TrIni([bgcolor=]+ CGIFONDOPAR) //Segunda fila
          //Label E-Mail
       oCgi:TdIni("") //selda 1
       oCgi:TableIni("",[border=0 width=100% align="Left"],"")
          oCgi:TableCol("E-mail","","")
       oCgi:TableEnd()
       oCgi:TdEnd() //selda 1
          //Txt E-Mail
       oCgi:TdIni("") //selda 2 
       oCgi:TableIni("",[border=0 width=100% align="Left"],"")
       oCgi:TdIni("Valing=MIDDLE")
          oCgi:Txt("USU_LOGIN","",50)
       oCgi:TdEnd()
       oCgi:TableEnd()
       oCgi:TrEnd()
//Titular de la licencia
       oCgi:TrIni([bgcolor=]+ CGIFONDOINPAR) //Segunda fila
          //Label Licencia
       oCgi:TdIni("") //selda 1
       oCgi:TableIni("",[border=0 width=100% align="Left"],"")
          oCgi:TableCol("Titular de la licencia (RIF)","","")
       oCgi:TableEnd()
       oCgi:TdEnd() //selda 1
          //Txt Licencia
       oCgi:TdIni("") //selda 2
       oCgi:TableIni("",[border=0 width=100% align="Left"],"")
       oCgi:TdIni("Valing=MIDDLE")
          oCgi:Txt("USU_CI_RIF","",20)
       oCgi:TdEnd()
       oCgi:TableEnd()
       oCgi:TrEnd()
    oCgi:CloseTable()
//Para los botones
    oCgi:NewLine()
    oCgi:ABRETABLA("",[border=0 width=80% align="center"],"")
    oCgi:TrIni("")
    oCgi:TdIni([Align="Center"])
    oCgi:ButTon("Enviar","BtnEnviar","Button",,,,,[onClick="Validar();"])
    oCgi:ButTon("Limpiar","BtnLimpiar","Reset",,,,,"")
    oCgi:TdEnd()
    oCgi:TrEnd()
    oCgi:CloseTable()

RE
