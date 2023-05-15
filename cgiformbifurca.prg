// Programa   :CGIFORMBIFURCA
// Fecha/Hora : 05/08/2003 14:34:10
// Prop—sito  :FORMULARIO PARA REDIRECIONAR AL USUARIO A LA PAG DE INICIO O A LA DE REGISTRO
// De la BDD de conocimiento
// Creado Por :FRANCISCO CASTRO IUT. RC
// Llamado por:MENU PRINCIPAL
// Aplicaci—n :
// Tabla      :

#INCLUDE "DPXBASE.CH"

PROCE MAIN()
      oCgi:Head()
    oCgi:Title("Ingreso de los usuarios de la base de datos de conocimientos de DATAPRO")
//Incluir los scripts para las validaciones u otras funciones
    oCgi:Scripts("Funbif.js")
    oCgi:Head()
//Generar el cuerpo del formulario
    oCgi:Iniform("CGIBIFURCA","")
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
          oCgi:TableCol([<font color=#000000>]+[Base De Datos de conocimiento]+[</font>],[align="Center" COLSPAN=100%],)
       oCgi:TableEnd()
      oCgi:TrEnd() //Cierro la primera fila
//Entrar
       //Abrir la linea
      oCgi:TrIni([bgcolor=]+ CGIFONDOINPAR) //Segunda fila
       //Boton entrar
       oCgi:TdIni( [Width="50%" align=Right bgcolor=]+ CGIFONDOINPAR) //selda 1 
       oCgi:AbreTabla("",[border=0 width=100% align=Right],"")        
            oCgi:TdIni([align=Center])
            oCgi:ButTon("Entrar","BtnOpc","Button",,,,,[onClick="llama(1);"]) //[onClick="llama("Entrar");"]
            oCgi:TdEnd()
       oCgi:CloseTable()
       oCgi:TdEnd()
       //Boton Registro
       oCgi:TdIni([Width="50%" align=Right bgcolor=]+ CGIFONDOINPAR) //selda 2
       oCgi:AbreTabla("",[border=0 width=100% align=Right],"")    
            oCgi:TdIni([align=Center])
            oCgi:ButTon("Registrese","BtnOpc","Button",,,,,[onClick="llama(2);"])
            oCgi:TdEnd()
       oCgi:CloseTable()
       oCgi:TrEnd()
    oCgi:CloseTable(
