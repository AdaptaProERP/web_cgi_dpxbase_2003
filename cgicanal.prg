// Programa   : CGICANAL
// Fecha/Hora : 15/05/2003 23:32:04
// Propósito  : Ejecución de Inicio Aplicacion Web
// Creado Por : Juan Navas
// Llamado por: 
// Aplicación : DPCGI CONFORMACION
// Tabla      : CNFCANALES

#INCLUDE "DPXBASE.CH"
#INCLUDE "DPCGI.CH"

FUNCTION CANALES(oCgi)
   LOCAL cNombre:=PADC("",30)
   LOCAL cMemo  :=PADR("",100)
   LOCAL oTable
   oCgi:SayHtml([<body bgcolor= BEIGE>])
   oCgi:IniForm("CGIPRESENTA")

   IF oCgi:IsDef("BTNPRES").AND. "Nuevo"$oCgi:BTNPRES
      oCgi:Say("SI ES BTNPRES "+oCgi:BTNPRES)
   ENDIF

   ? oCgi:CCLI_RIF
   
RETURN NIL
