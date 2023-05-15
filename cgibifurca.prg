// Programa   :CGIBIFURCA
// Fecha/Hora : 05/08/2003 16:59:20
// Prop—sito  :RETORNAR AL USUARIO LA PAGINA DE REGISTRO O LA PAGINA DE ENTRADA
// Creado Por :Francisco Castro IUT. RC
// Llamado por:CGIFORMBIFURCA
// Aplicaci—n :
// Tabla      :
#INCLUDE "DPXBASE.CH"
PROCE MAIN()
   IF ALLTRIM(oCgi:BtnOpc) = "Entrar"
   // Envia la pagina para entrar
      Ejecutar("CGIFORMLOGINBDC")
   ELSE
   // Envia la pagina de registro
      Ejecutar("CGIFORMREGBDC")
   ENDIF
R
