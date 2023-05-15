// Programa   : CGISENDEMAIL
// Fecha/Hora : 01/08/2003
// Prop—sito  : Enviar EMAIL
// Creado Por : Francisco Castro IUT RC
// Llamado por: Cualquier CGI
// Aplicaci—n : DPCGI
// Tabla      :

#INCLUDE "DPXBASE.CH"
#INCLUDE "DPCGI.CH"

FUNCTION DPXBASE(cInstruc)

   __RUN([BLAT -INSTALL mail.cantv.net datapro@telcel.net.ve],0)
   __RUN(cInstruc,0)

RETURN
