// Programa   :CGIFORMEXPO
// Fecha/Hora :21/07/2003 1:24:58
// Propósito  :Generar el formulario para las exposiciones
// Creado Por :Francisco Castro IUT RC.
// Llamado por:Confirmacion del acceso al usuario
// Aplicación :
// Tabla      :

#INCLUDE "DPXBASE.CH"
#INCLUDE "DPCGI.CH"

PROCE MAIN()
    LOCAL aTemas:={} //Almacena los temas para las exposiciones
    LOCAL aVersion:={} //Almacena las versiones de los productos
    LOCAL aTopico:={} //Almacena los topicos para las exposiciones
    oCgi:Head()
    oCgi:Title("Exposiciones")
//Incluir los scripts para las validaciones u otras funciones
//    oCgi:Scripts("REL.js")
    oCgi:Scripts("RegUsBddC.js")
    oCgi:Head()
//Generar el cuerpo del formulario
    oCgi:Iniform("CGIPUBLIEXPO","")
//Colocar el estilo
oCgi:SayHtml([<style type="text/css">])
oCgi:SayHtml([a.link4       {color:#FFFFFF; font-family: verdana, arial, helvetica, sans-serif; font-size: 13px ; TEXT-DECORATION: none}])
oCgi:SayHtml([a.link4:hover {color:#FFFFFF; TEXT-DECORATION: none}])
oCgi:SayHtml([TD {font-family: verdana, arial, helvetica, sans-serif; font-size: 10px}])
oCgi:SayHtml([p.titu {color: #FFFFFF; font-family: verdana, arial, helvetica, sans-serif; font-size: 10px}])
oCgi:SayHtml([</style>])
    //Tabla principal
    oCgi:OpenTable("",[border=0 width=80% align="center" BGCOLOR =]+ CGIBORDE,"")
       oCgi:TrIni("") //Primera fila
       //Tabla del encabezado
       oCgi:TdIni("COLSPAN = 100%")
       oCgi:TableIni("",[border=0 width=100% align="center" bgcolor=]+ CGIBORDE,"")
          oCgi:TableCol([<font color=#000000>]+[Exposiciones]+[</font>],[align="Center" COLSPAN=100%],)
       oCgi:TableEnd()
       oCgi:TrEnd() //Cierro la primera fila
//Tema
       oCgi:TrIni([bgcolor=]+ CGIFONDOINPAR) //Segunda fila
          //Label Tema
       oCgi:TdIni("") //selda 1
       oCgi:TableIni("",[border=0 width=100% align="Left" Valign="MIDDLE"],"")
          oCgi:TableCol([<FONT COLOR=]+ CGITEXTO + [>Tema</FONT>],"","")
       oCgi:TableEnd()
       oCgi:TdEnd() //selda 1
          //Combo Tema
       oCgi:TdIni( [bgcolor=]+ CGIFONDOINPAR) //selda 2 
       oCgi:TableIni("",[border=0 width=100% align="Left"],"")
        //Buscar los temas en la BDD y Llenar el combo Temas
          AADD(aTemas,[Uno])
          AADD(aTemas,[Dos])
          AADD(aTemas,[Tres])
          AADD(aTemas,[Cuatro])
          oCgi:Listbox(aTemas,[CmbTema],"",1)
       oCgi:TableEnd()
       oCgi:TrEnd()

//Version
       oCgi:TrIni([bgcolor=]+ CGIFONDOPAR) //Segunda fila
          //Label Version
       oCgi:TdIni("") //selda 1
       oCgi:TableIni("",[border=0 width=100% align="Left"],"")
          oCgi:TableCol("Versión","","")
       oCgi:TableEnd()
       oCgi:TdEnd() //selda 1
          //Cmb Version
       oCgi:TdIni("") //selda 2
       oCgi:TableIni("",[border=0 width=100% align="Left"],"")
          //Llenar las Versiones
          AADD(aVersion,[Uno])
          AADD(aVersion,[Dos])
          AADD(aVersion,[Tres])
          AADD(aVersion,[Cuatro])
          oCgi:Listbox(aVersion,[CmbVersion])
       oCgi:TableEnd()
       oCgi:TrEnd()
//Topico de la exposicion
       oCgi:TrIni([bgcolor=]+ CGIFONDOINPAR) //Segunda fila
          //Label Topico
       oCgi:TdIni("") //selda 1
       oCgi:TableIni("",[border=0 width=100% align="Left"],"")
          oCgi:TableCol("Tópico","","")
       oCgi:TableEnd()
       oCgi:TdEnd() //selda 1
       oCgi:TdIni("") //selda 2       
          //Cmb Topico
       oCgi:TableIni("",[border=0 width=100% align="Left"],"")
          AADD(aTopico,[Uno])
          AADD(aTopico,[Dos])
          AADD(aTopico,[Tres])
          AADD(aTopico,[Cuatro])
          oCgi:Listbox(aTopico,[CmbVersion])
       oCgi:TableEnd()
       oCgi:TrEnd()
//Exposicion
       oCgi:TrIni([bgcolor=]+ CGIFONDOPAR) //Segunda fila
          //Label Exposicion
       oCgi:TdIni("") //selda 1
       oCgi:TableIni("",[border=0 width=100% align="Left"],"")
          oCgi:TableCol("Exposición","","")
       oCgi:TableEnd()
       oCgi:TdEnd() //selda 1
          //TextArea Exposición
       oCgi:TdIni("") //selda 2 
       oCgi:TableIni("",[border=0 width=100% align="Left"],"")
          oCgi:GetMemo("cMemExpo","Escriba su exposición aqui",5,45)
       oCgi:TableEnd()
       oCgi:TrEnd()
    oCgi:CloseTable()
//Para los botones
    oCgi:NewLine()
    oCgi:OpenTable("",[border=0 width=80% align="center"],"")
    oCgi:TrIni("")
    oCgi:TdIni([Align="Center"])
    oCgi:ButTon("Enviar","BtnEnviar","Button",,,,,[onClick="Alarma();"])
    oCgi:ButTon("Limpiar","BtnLimpiar","Reset",,,,,"")
    oCgi:TdEnd()
    oCgi:TrEnd()
    oCgi:CloseTable()

RETURN
