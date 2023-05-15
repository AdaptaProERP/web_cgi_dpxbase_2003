// Programa   :CGIPUBLICEXPO
// Fecha/Hora : 06/08/2003 18:17:12
// Prop—sito  :PUBLICAR LA EXPOSICION Y RETORNAR LAS POCIBLES RESPUESTAS 
// Creado Por :FRANCISCO CASTRO
// Llamado por:CGIFORMEXPO
// Aplicaci—n :BDC
// Tabla      :

#INCLUDE "DPXBASE.CH"
#INCLUDE "DPCGI.CH"

PROCE MAIN()

    LOCAL aTemas:={} //Almacena los temas para las exposiciones
    LOCAL aVersion:={} //Almacena las versiones de los productos
    LOCAL aTopico:={} //Almacena los topicos para las exposiciones
    LOCAL oTabla,cSQL:="",I:=0, cIdTem:="",cIdVer:="", cIdTem:="", nCodExpo:=0 ,cCeros:=""
    LOCAL cCodigoVer:="", cCodigoTop:=""

if ALLTRIM(oCgi:ACTUTOPICO) = "True"  //Refrsca la pagina con los topicos nuevos

    oCgi:Head()
    oCgi:Title("Base de datos de conocimientos de DATAPRO / Publicar exposici—n...")
//Incluir los scripts para las validaciones u otras funciones
    oCgi:Scripts("FunMenu.js")
    oCgi:Scripts("FunctGen.js")
    oCgi:Scripts("FunExpo.js")
    oCgi:Head()
//Se genera el cuerpo del formulario y el dise™o de la pag
Ejecutar("CGIINIFRAME","CGIPUBLIEXPO",oCgi)

//Cuerpo de la pagina de formulario de exposiciones
    //Tabla principal
    oCgi:Abretabla("",[border=0 width=80% align="center" BGCOLOR =]+ CGIBORDE,"")
       oCgi:TrIni("") //Primera fila
       //Tabla del encabezado
       oCgi:TdIni("COLSPAN = 100%")
       oCgi:TableIni("",[border=0 width=100% align="center" bgcolor=]+ CGIBORDE,"")
          oCgi:TableCol([<font color=#000000>]+[Exposiciones]+[</font>],[align="Center" COLSPAN=100%],)
          oCgi:TableLine()
          oCgi:TableCol([<font color=#000000>]+[USUARIO: ] + ALLTRIM(oCgi:USU_NOMBRE) + [</font>],[align="Left" COLSPAN=100%],)
       oCgi:TableEnd()
       oCgi:TrEnd() //Cierro la primera fila
//Tema
       oCgi:TrIni([bgcolor=]+ CGIFONDOINPAR) //Segunda fila
          //Label Tema
       oCgi:TdIni("") //selda 1
       oCgi:TableIni("",[border=0 width=100% align="Left" Valign="MIDDLE"],"")
          oCgi:TableCol([<FONT COLOR=]+ CGITEXTO +[>Producto</FONT>],"","")
       oCgi:TableEnd()
       oCgi:TdEnd() //selda 1
          //Colocar el tema
       oCgi:TdIni( [bgcolor=]+ CGIFONDOINPAR) //selda 2 
       oCgi:TableIni("",[border=0 width=100% align="Left"],"")
          oCgi:TableCol([<FONT COLOR=]+ CGITEXTO +[>]+ oCgi:USU_TEMA +[</FONT>],"","")
       oCgi:TableEnd()
       oCgi:TrEnd()

//Versiones segun el tema seleccionado
       oCgi:TrIni([bgcolor=]+ CGIFONDOPAR) //Segunda fila
          //Label Version
       oCgi:TdIni("") //selda 1
       oCgi:TableIni("",[border=0 width=100% align="Left"],"")
          oCgi:TableCol("Versi—n","","")
       oCgi:TableEnd()
       oCgi:TdEnd() //selda 1

       //Llenar las Versiones
       cSQL:=[SELECT DISTINCT BDCVERSION.VER_CODIGO, BDCVERSION.VER_DESCRI ]+;
             [FROM BDCTEMVERTOP INNER JOIN BDCVERSION ON ]+;
             [BDCVERSION.VER_CODIGO = BDCTEMVERTOP.VER_CODIGO ]+;
             [WHERE BDCTEMVERTOP.TEM_CODIGO =']+ ALLTRIM(oCgi:USU_TEMCODIGO) +[']
       oTabla:=OpenTable(cSQL,.T.)
       for I := 1 to oTabla:Reccount()
         //Capturar el codigo de la version seleccionada
         if ALLTRIM(oTabla:VER_DESCRI) = ALLTRIM(oCgi:CmbVersion)
            cIdVer := oTabla:VER_CODIGO
         endif
         AADD(aVersion,oTabla:VER_DESCRI)
         oTabla:DbSkip()
       next I

       oTabla:End()
       //Colocar las versiones y dejar seleccionada la qu e es
       oCgi:TdIni( [bgcolor=]+ CGIFONDOPAR) //selda 2
       oCgi:TableIni("",[border=0 width=100% align="Left"],"")
             oCgi:Listbox(aVersion,[CmbVersion onchange="CambiaTopico()"],ALLTRIM(oCgi:CmbVersion),1)
       oCgi:TableEnd()
       oCgi:TrEnd()

/* Quitar de comentario si se pide la version en el formloguin
//Version
       oCgi:TrIni([bgcolor=]+ CGIFONDOPAR) //Segunda fila
          //Label Version
       oCgi:TdIni("") //selda 1
       oCgi:TableIni("",[border=0 width=100% align="Left"],"")
          oCgi:TableCol("Versi—n","","")
       oCgi:TableEnd()
       oCgi:TdEnd() //selda 1
          //Colocar la version
       oCgi:TdIni( [bgcolor=]+ CGIFONDOPAR) //selda 2 
       oCgi:TableIni("",[border=0 width=100% align="Left"],"")
          oCgi:TableCol([<FONT COLOR=]+ CGITEXTO +[>]+ oCgi:USU_VERS +[</FONT>],"","")
       oCgi:TableEnd()
       oCgi:TrEnd()
*/


//Topico de la exposicion  Segun el producto y la version
       oCgi:TrIni([bgcolor=]+ CGIFONDOINPAR) //Segunda fila
          //Label Topico
       oCgi:TdIni("") //selda 1
       oCgi:TableIni("",[border=0 width=100% align="Left"],"")
          oCgi:TableCol("T—pico","","")
       oCgi:TableEnd()
       oCgi:TdEnd() //selda 1
          //Cmb Topico
       oCgi:TdIni("") //selda 2       
       oCgi:TableIni("",[border=0 width=100% align="Left"],"")


/*
//Obtener el codigo de la version segun el nombre de la misma
       cSQL:=[SELECT BDCVERSION.VER_CODIGO ]+;
             [FROM BDCVERSION ]+;
             [WHERE BDCVERSION.VER_DESCRI = ']+ ALLTRIM(oCgi:USU_VERS)+[']
       oTabla:=OpenTable(cSQL,.T.)
       cIdVer:=oTabla:VER_CODIGO
*/


//SACAR LOS TOPICOS PARA EXPONER
       cSQL:=[SELECT DISTINCT BDCTOPICO.TOP_DESCRI ]+;
             [FROM BDCTEMVERTOP INNER JOIN BDCTOPICO ON BDCTOPICO.TOP_CODIGO = BDCTEMVERTOP.TOP_CODIGO ]+;
             [WHERE BDCTEMVERTOP.TEM_CODIGO = ']+ ALLTRIM(oCgi:USU_TEMCODIGO) +[' AND ]+;
             [BDCTEMVERTOP.VER_CODIGO = ']+ ALLTRIM(cIdVer) +[']

       oTabla:=OpenTable(cSQL,.T.)
       for I := 1 to oTabla:Reccount()
          AADD(aTopico,oTabla:TOP_DESCRI)
          oTabla:DbSkip()
       next I
       oCgi:Listbox(aTopico,[CmbTopico])
       oCgi:TableEnd()
       oCgi:TrEnd()

//Exposicion
       oCgi:TrIni([bgcolor=]+ CGIFONDOPAR) //Segunda fila
          //Label Exposicion
       oCgi:TdIni("") //selda 1
       oCgi:TableIni("",[border=0 width=100% align="Left"],"")
          oCgi:TableCol("Exposici—n","","")
       oCgi:TableEnd()
       oCgi:TdEnd() //selda 1
          //TextArea Exposici—n
       oCgi:TdIni("") //selda 2 
       oCgi:TableIni("",[border=0 width=100% align="Left"],"")
          oCgi:GetMemo("cMemExpo",ALLTRIM(oCgi:cMemExpo),8,60)
       oCgi:TableEnd()
       oCgi:TrEnd()
    oCgi:CloseTable()
//Para los botones
    oCgi:NewLine()

    oCgi:AbreTabla("",[border=0 width=80% align="center"],"")
    oCgi:TrIni("")
    oCgi:TdIni([Align="Center"])
    oCgi:ButTon("Enviar","BtnEnviar","Button",,,,,[onClick="Validar();"])
    oCgi:ButTon("Limpiar","BtnLimpiar","Reset",,,,,"")
    oCgi:CloseTable()

oCgi:CloseTable()

oCgi:Public("ACTUTOPICO","False")


ELSE   ///***************************************************/Publicar la exposicion

oCgi:SayHtml("Exposicion publicada")
//Obtener el codigo que se le asignara a la exposicion
//Buscar el ultimo para generar el proximo
   cSQL := [SELECT MAX(EXP_CODIGO) AS Valor ]+;
           [FROM BDCEXPOSICION]
   oTabla:=OpenTable(cSQL,.T.)
   IF empty(oTabla:Valor)
      nCodExpo := 0
   ELSE
      nCodExpo := val(oTabla:Valor)
   ENDIF
   oTabla:END()

nCodExpo := nCodExpo + 1
//Rellenar con ceros a la izquierda el codigo
for I:= 1 to 6 - len(alltrim(str(nCodExpo)))
   cCeros:=cCeros + "0"
next I
cCeros := cCeros + alltrim(str(nCodExpo))
//El codigo del tema ya se tiene
//Buscar el codigo de la version 
   cSQL:=[SELECT BDCVERSION.VER_CODIGO ]+;
         [FROM BDCVERSION ]+;
         [WHERE BDCVERSION.VER_DESCRI =']+ ALLTRIM(oCgi:CmbVersion) +[']
   oTabla:=OpenTable(cSQL,.T.)
   cCodigoVer:= ALLTRIM(oTabla:VER_CODIGO)
   oTabla:END()
//Buscar el codigo del topico
   cSQL:=[SELECT BDCTOPICO.TOP_CODIGO ]+;
         [FROM BDCTOPICO ]+;
         [WHERE BDCTOPICO.TOP_DESCRI =']+ ALLTRIM(oCgi:CmbTopico) +[']
   oTabla:=OpenTable(cSQL,.T.)
   cCodigoTop:= ALLTRIM(oTabla:TOP_CODIGO)
   oTabla:END()
//Registrar la publicaci—n
      cSQL := [SELECT * FROM BDCEXPOSICION]
      oTabla:=OpenTable(cSQL,.T.)
      oTabla:AppendBlank()
      oTabla:Replace("EXP_CODIGO", ALLTRIM(cCeros))
      oTabla:Replace("TEM_CODIGO", ALLTRIM(oCgi:USU_TEMCODIGO))
      oTabla:Replace("VER_CODIGO", ALLTRIM(cCodigoVer))
      oTabla:Replace("TOP_CODIGO", ALLTRIM(cCodigoTop))
      oTabla:Replace("EXP_EXPO", ALLTRIM(oCgi:cMemExpo))
      oTabla:Replace("EXP_CODREL", "")
      oTabla:Replace("EXP_TIPO", "P")
      oTabla:Replace("EXP_CODUSU", ALLTRIM(oCgi:USU_CODIGO))
      oTabla:Replace("EXP_FCHREG", DATE())
      //Grabar en la BDD
      oTabla:Commit("")
/*
      Csql:= [EXP_CODIGO: ] + ALLTRIM(cCeros) +;
      [ TEM_CODIGO: ] + ALLTRIM(oCgi:USU_TEMCODIGO) +;
      [ VER_CODIGO: ] + ALLTRIM(cCodigoVer) +;
      [ TOP_CODIGO: ] + ALLTRIM(cCodigoTop) +;
      [ EXP_EXPO: ] + ALLTRIM(oCgi:cMemExpo) +;
      [ EXP_CODREL: ] + [DOGIGO EXP REL] +;
      [ EXP_TIPO: P] +;
      [ EXP_CODUSU: ] + ALLTRIM(oCgi:USU_CODIGO) +;
      [ EXP_FCHREG: ] + DTOC(DATE())
oCgi:SayHtml(cSQL)
*/
//Examinar la exposicion 
//Buscar pocibles respuestas
//Enviar las respuestas al usuario
//Guardar la exposicion

ENDIF

