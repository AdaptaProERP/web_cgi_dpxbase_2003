// Programa   : CGIPUTCOLOR
// Fecha/Hora : 04/06/2003 22:55:04
// Propósito  : Redibujar los Formularios con los Colores Definidos
// Creado Por : Oscar Londoño
// Llamado por: 
// Aplicación : CGI
// Tabla      :
#INCLUDE "DPXBASE.CH"

PROCE MAIN()
   Local cDirOrg:=oDp:cPathExe+"www\",cDirDest:="",aFiles
   Local aVars,cMemo
   LOCAL aFiles,cFileOrg,cFileDes,I,cPath,u,cFile,nHandler

   cDirDest:="c:\website\htdocs\"
   IF oDp:lCgi
      cDirOrg :=oDp:cPathExe+"www\"
   ENDIF

   aVars:=STRTRAN(MemoRead(oDp:cPathExe+"DATATXT\CGICOLOR.TXT"),CHR(10),"")

   aVars:=_VECTOR(aVars)

   AEVAL(aVars,{|a,i,cVar|cVar:=LEFT(a,AT(":",a)-1),PUBLICO(cVar,cVar),MACROEJE(a),aVars[i]:=cVar})

   aFiles:=ARRAY(ADIR(cDirOrg+"*.mod"))

   ADIR(cDirOrg+"*.mod",aFiles)
    FOR I=1 TO LEN(aFiles)
      cMemo:=MemoRead(cDirOrg+aFiles[I])
      cFile:=cDirDest+left(aFiles[i],at(".",aFiles[i]))+"htm"
      ferase(cFile)
      fcreate(cFile)
      nHandler:=fOpen(cFile,1)
      AEVAL(aVars,{|cVar,U|cMemo:=STRTRAN(cMemo,cVar,MacroEje(cVar))})
      fwrite(nHandler,cMemo)
      fclose(nHandler)
   NEXT I
  
RETUR
