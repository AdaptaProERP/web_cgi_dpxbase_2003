// Programa   :CGIINIFRAME
// Fecha/Hora : 07/08/2003 11:12:47
// Prop—sito  :Crea una tabla para que funcione como frame
// Creado Por :Francisco Castro IUT. RC.
// Llamado por:CGIS de BDC
// Aplicaci—n :BDC
// Tabla      :

#INCLUDE "DPXBASE.CH"
#INCLUDE "DPCGI.CH"

PROCE MAIN(CgiScript,oCgi,nSetval)

   DEFAULT nSetval:=1

//Generar el cuerpo del formulario
  oCgi:Iniform(ALLTRIM(CgiScript),"")
//Colocar los parametros del usuario

IF nSetval != 0
  Ejecutar("CGISETVALUSUBDC",oCgi)
ENDIF

//Colocar el estilo
  oCgi:FileStile("C:\website\css\SGen.Sty")

    //Tabla principal
    oCgi:ABRETABLA("",[border=1 width=95% align="center" BGCOLOR =]+ CGIFONDOPAR ,"")
       oCgi:TrIni([]) //Primera fila para el top
         //Encabezado
         oCgi:TdIni([ width="100%" colspan="3"]) //selda 1
           //Insrtar imagen de cabecera
           oCgi:IMG([cabezera.gif])
         oCgi:TrEnd()
         //Menu
       oCgi:TrIni([VALIGN=TOP]) //Segunda fila

         oCgi:TdIni([width="20%" VALIGN=TOP]) //selda 1
/*
           //Insert menu
       if  .t.   //(ALLTRIM(oCgi:USU_TIPO)="P") //Es pregunton
          //Cargar el menu del pregunton
          oCgi:TdIni([width=10 ]) //selda 1
          oCgi:InsertHtml([C:\WebSite\htdocs\menupre.fjc])
       else//Es respondon
          //Cargar el menu del respondon
         oCgi:TdIni([width=200]) //selda 1
         oCgi:InsertHtml([C:\WebSite\htdocs\menuresp.fjc])
       endif
         oCgi:TdEnd()
         oCgi:TdIni([]) //selda 1
           //Insert cuerpo
*/

//Cerrar el la tabla
//       oCgi:CloseTable()
RET
