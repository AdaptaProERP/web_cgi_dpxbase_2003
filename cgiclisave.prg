// Programa   : CGICLISAVE
// Fecha/Hora : 19/05/2003 17:14:09
// Propósito  : Graba los Datos del Cliente
// Creado Por : Juan Navas
// Llamado por: CGICLAVE
// Aplicación : DPCGI Conformaciones
// Tabla      : CNFCLIENTES

#INCLUDE "DPXBASE.CH"
#INCLUDE "DPCGI.CH"

FUNCTION CGICLISAVE(oCgi)
   LOCAL cWhere:="",cExcluye:="",cMemo:="",cTempo,nContar
   LOCAL aCampos:={},aLista:={},I,aValues

   IF !oCgi:TableSeek("CNFCLIENTES","CLI_RIF") .AND. !oCgi:lAppend
     Ejecutar("CGIMSGERR","Cliente Duplicado","El Cliente ya ha Sido Registrado")
     RETURN .F.
   ENDIF

   AADD(aCampos,{"CLI_RIF"   ,"Rif o Cedula"})
   AADD(aCampos,{"CLI_NOMBRE","Titular de la Licencia"})
   AADD(aCampos,{"CLI_ESTADO","Estado de Ubicacion"})
   AADD(aCampos,{"CLI_TEL1","Telefono"})
   AADD(aCampos,{"CLI_DIRE","Direccion de la Empresa"})
   AADD(aCampos,{"CLI_REPREN","Nombre del Representante"})
   AADD(aCampos,{"CLI_REPREA","Apellido del Representante"})
   AADD(aCampos,{"CLI_LOGIN","Login de Usuario"})
   AADD(aCampos,{"CLI_EMAIL","Correo Electronico"})
   AADD(aCampos,{"CLI_Rubro","Rubro"})

   FOR I:=1 TO LEN(aCampos)
      IF oCgi:IsDef(aCampos[I,1]) .AND. EMPTY(oCgi:Read(aCampos[I,1]))
         AADD(aLista,aCampos[I,2])
         cMemo:=cMemo+IIF(EMPTY(cMemo),"",",")+aCampos[I,2]
      ENDIF
   NEXT I
 
   IF !EMPTY(cMemo)
     Ejecutar("CGIMSGERR","Debe llenar los Siguientes Campos",cMemo)
     RETURN .T.
   ENDIF

   oCgi:CLI_EMAIL:=ALLTRIM(oCgi:CLI_EMAIL)
   IF !"."$oCgi:CLI_EMAIL .OR. !"@" $oCgi:CLI_EMAIL .OR. " "$oCgi:CLI_EMAIL
       Ejecutar("CGIMSGERR","Cuenta de Correo","NO VALIDA")
       RETURN .T.
  ENDIF

   IF oCgi:lAppend
      oCgi:CLI_CODIGO:=Incremental("CNFCLIENTES","CLI_CODIGO",.T.)
   ELSE
      cExcluye:="CLI_CODIGO,BURRADA" // Lista de Campos que no tienen porque incluir
   ENDIF

   oCgi:CLI_DIRE:=LEFT(oCgi:CLI_DIRE,160)

   oCgi:Save("CNFCLIENTES",cWhere,NIL,cExcluye) // Graba en la Tabla, cWhere= Vacio Agrega

   IF oCgi:lAppend

    AADD(aValues,{"CGIUSUAR",oCgi:CLI_REPREN})
    AADD(aValues,{"CGILOGIN" ,oCgi:CLI_LOGIN})
    AADD(aValues,{"CGICLAVE"  ,oCgi:CLI_PASS})

   cTempo:="C:\WebSite\htdocs\bienvenida.htm"

   oCgi:HTMPUTVALUE("C:\WebSite\htdocs\bienve.htm",aValues,cTempo)

   __COPYFILE(cTempo,LEFT(cTempo,at(".",cTempo)-1)+"2.htm",0)

   __RUN([BLAT.EXE -INSTALL mail.cantv.net datapro@telcel.net.ve],0)

   __RUN([BLAT.EXE ]+LEFT(cTempo,at(".",cTempo)-1)+"2.htm"+[ -to "]+oCgi:CLI_EMAIL+[" -S "Datapro le da las Gracias por Registrarse"]+;
        [ -html >BLAT.LOG],0)

   ferase(LEFT(cTempo,at(".",cTempo)-1)+"2.htm")

   ferase(cTempo)

   oCgi:Del(oCgi:CLI_PASS)

   oCgi:Del(oCgi:CLI_LOGIN)

   ENDIF
 
   oCgi:SayHtml("<HTML><HEAD>")
  IF oCgi:lAppend
   oCgi:SayHtml([<META http-equiv=REFRESH content="0 URL=\bienvein.htm">]) 
  ELSE
   oCgi:SayHtml([<META http-equiv=REFRESH content="0 URL=\bienvemo.htm">]) 
  ENDIF
   oCgi:SayHtml("</HEAD><BODY></BODY></HTML>")

RETURN NIL
