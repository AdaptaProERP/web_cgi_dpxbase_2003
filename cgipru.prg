// Programa   :
// Fecha/Hora : 04/07/2003 14:26:45
// Propósito  :
// Creado Por :
// Llamado por:
// Aplicación :
// Tabla      :

#INCLUDE "DPXBASE.CH"
#INCLUDE "DPCGI.CH"

PROCE MAIN()    
    oCgi:Header([Título de la pagina])
    oCgi:IniForm("CGIPRUE2") //Para indicarle al formulario a que script llamara cuando se presiona el boton submit    
    if oCgi:IsDef("BTNPRES") //Pregunta si la caracteristica "BTNPRES" se encuentra definida en el objeto oCgi
         oCgi:Say("SI ES BTNPRES "+ oCgi:BTNPRES,[Verdana]) //Envia codigo al brownser
    end if

    oCgi:BUTTON([cPronpt],[cName],[submit])
RETURN
