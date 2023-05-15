// Programa   :CGISETVALUSUBDC
// Fecha/Hora : 06/08/2003 19:32:47
// Prop—sito  :Colocar los valores generales y de control de los usuarios
// Creado Por :Francisco Castro IUT. RC
// Llamado por:CGIS que navegan por los modulos de la aplicacion BDC
// Aplicaci—n :BDC
// Tabla      :

#INCLUDE "DPXBASE.CH"
#INCLUDE "DPCGI.CH"

FUNCTION DPXBASE(oCgi)
    //Id de usuario
    oCgi:Public("USU_CODIGO",ALLTRIM(oCgi:USU_CODIGO))
    //Nombre y apelido
    oCgi:Public("USU_NOMBRE",ALLTRIM(oCgi:USU_NOMBRE))
    //Nombre del cliente bajo el cual esta registrado
    oCgi:Public("USU_LIC_BAJ",ALLTRIM(oCgi:USU_LIC_BAJ))
    //Tipo de usuario (si pregunta o responde)
    oCgi:Public("USU_TIPO",ALLTRIM(oCgi:USU_TIPO))
    //Tema por el cual el usuario realiza la exposicion
    oCgi:Public("USU_TEMA",ALLTRIM(oCgi:USU_TEMA))
    //Codigo del tema
    oCgi:Public("USU_TEMCODIGO",ALLTRIM(oCgi:USU_TEMCODIGO))
    //Version por la cual desea preguntar
    oCgi:Public("USU_VERS",ALLTRIM(oCgi:CmbVersion))

RETURN NIL
// EOF

