// Programa   :CGIREGUSRBDC
// Fecha/Hora : 14/07/2003 15:42:43
// Propósito  :Registrar un nuevo usuario en la bdd de conocimiento
// Creado Por :Francisco Castro IUT RC.
// Llamado por:CGIFORMREGBDC
// Aplicación :
// Tabla      :

#INCLUDE "DPXBASE.CH"
#INCLUDE "DPCGI.CH"
PROCE MAIN()
  Local oTable,cSQL,cPassword,nIndex,nValPass,cDirFile,cDirFileCopy,aValues
  //Validar que el usuario no exista
  //Buscar el usuario
  cSQL = [SELECT USU_ID FROM BDCUSUARIO WHERE USU_ID=']+ALLTRIM(oCgi:USU_ID)+[']
  oTable:=OpenTable(cSQL,.T.)
  //Si el usuario no existe
  IF oTable:RecCount()=0
    //Validar que el titular de la licencia exista
    //Buscar el titular
    oTable:End()
    cSQL := [SELECT CLI_RIF FROM CNFCLIENTES WHERE CLI_RIF=']+ALLTRIM(oCgi:USU_CI_RIF)+[']
    oTable:=OpenTable(cSQL,.T.)
    //Si el titular existe
    IF oTable:RecCount()>0
      //Registrar el usuario
      oTable:End()
      cSQL := [SELECT * FROM BDCUSUARIO]
      oTable:=OpenTable(cSQL,.T.)
      oTable:AppendBlank()
      oTable:Replace("USU_ID",ALLTRIM(oCgi:USU_ID))
      oTable:Replace("USU_NOMBRE",ALLTRIM(oCgi:USU_NOMBRE))
      oTable:Replace("USU_APELLI",ALLTRIM(oCgi:USU_APELLI))
      oTable:Replace("USU_LOGIN",ALLTRIM(oCgi:USU_LOGIN))
      oTable:Replace("USU_CI_RIF",ALLTRIM(oCgi:USU_CI_RIF))
      oTable:Replace("USU_TIPO","P")
      oTable:Replace("USU_ESTADO","A")
      oTable:Replace("USU_FCHINI",DATE())
      //Obtener el password
      nValPass = 0
      //Utilizando la Cedula o el rif
      FOR nIndex = 1 TO LEN(ALLTRIM(oCgi:USU_ID))
        nValPass := nValPass + ASC(SUBS(ALLTRIM(oCgi:USU_ID),nIndex,1))
      NEXT nIndex
      //Utilizando el login (Correo electronico) 
      FOR nIndex = 1 TO LEN(ALLTRIM(oCgi:USU_LOGIN))
        nValPass := nValPass + ASC(SUBS(ALLTRIM(oCgi:USU_LOGIN),nIndex,1))
      NEXT nIndex
      cPassword:= SUBS(ALLTRIM(oCgi:USU_ID),1,1) + alltrim(STR(nValPass)) + SUBS(ALLTRIM(oCgi:USU_LOGIN),1,1)
      //Asigna el password
      oTable:Replace("USU_PASS",ALLTRIM(cPassword))
      //Grabar en la BDD
      oTable:Commit("")
      //Enviar email con la informacion del password
      
//      cSQL:= ALLTRIM(oCgi:USU_NOMBRE)+[ ]+ALLTRIM(oCgi:USU_APELLI)
//      AADD(aValues,{"CGIUSUAR",})
//      AADD(aValues,{"CGILOGIN" ,ALLTRIM(oCgi:USU_LOGIN)})
//      AADD(aValues,{"CGICLAVE"  ,ALLTRIM(cPassword)})
//      cDirFile:="C:\WebSite\htdocs\bienvenida.htm"
//      oCgi:HTMPUTVALUE("C:\WebSite\htdocs\bienvebdc.htm",aValues,cDirFile)
//      cDirFileCopy:=LEFT(cDirFile,at(".",cDirFile)-1)+"2.htm"
//      __COPYFILE(cDirFile,cDirFileCopy,0)
//      __RUN([BLAT.EXE -INSTALL mail.cantv.net datapro@telcel.net.ve],0)
//      __RUN([BLAT.EXE ]+cDirFileCopy+[ -to "]+ALLTRIM(oCgi:USU_LOGIN)+[" -S "Datapro le da las Gracias por Registrarse"]+;
//        [ -html >BLAT.LOG],0)
//      ferase(cDirFileCopy)
//      ferase(cDirFile)

      //Notificar al usuario su registro
      oCgi:HTMPUTVALUE("C:\WebSite\htdocs\bienvein.htm")
    ELSE
      //Mensaje el titular de la licencia no existe
      Ejecutar("CGIMSGERR","Titular no existe","El titular de la licencia no se encuentra registrado")
    ENDIF
  ELSE
    //Mensaje al usuario ya existe    
    Ejecutar("CGIMSGERR","Cliente Duplicado","Ya se ha registrado")
  ENDIF
  oTable:End()
RETU
