// Programa   : CGIDETALLE
// Fecha/Hora : 18/06/2003 15:12:55
// Propósito  : Muestra el Detalle de Cada Licencia
// Creado Por : Oscar Londoño
// Llamado por: CGIEXCLUSIVO
// Aplicación : CGI
// Tabla      : CFNFCONFORMACION

#INCLUDE "DPXBASE.CH"

PROCE MAIN()
LOCAL oTable,I,cFecha

   oCgi:IniForm("CGICLAVE")

   oCgi:SayHtml([<SCRIPT language=JavaScript>])
   oCgi:SayHtml([var ventana,t,l;])
   oCgi:SayHtml([function nuevaVentana()])
   oCgi:SayHtml([{t=(screen.height-300)/2])
   oCgi:SayHtml([l=(screen.width-400)/2])
   oCgi:SayHtml([ventana=window.open('','NuevaVentana','scrollbars=yes,width=400,height=300,top='+t+',left='+l);]) 
   oCgi:SayHtml([ventana.opener=self;]) 
   oCgi:SayHtml([ventana.document.write("<HTML>");]) 
   oCgi:SayHtml([ventana.document.write("<HEAD><TITLE>Detalle de la Licencia&nbsp;]+oCgi:BOTON+[</TITLE></HEAD>");]) 
   oCgi:SayHtml([ventana.document.write("<BODY BGCOLOR=]+CGIFONDOG+[><CENTER>");]) 
   oCgi:SayHtml([ventana.document.write("<FONT FACE='helvetica'>");])
   oTable:=OpenTable("SELECT CON_ORIGEN,CON_CLAVE,CON_FECHA,CON_IP FROM CNFCONFORMACION WHERE CON_LICNUM"+GetWhere("=",oCgi:BOTON)+" ORDER BY CON_FECHA",.T.)
     
  IF oTable:RecCount()>0 
   oCgi:SayHtml([ventana.document.write("<TABLE WIDTH=100% BGCOLOR=]+CGIBORDE+[><TR BGCOLOR=]+CGICABECERA+[>");])
   oCgi:SayHtml([ventana.document.write("<TH COLSPAN=4><FONT NAME=VERDANA SIZE=3 COLOR=]+CGITITULO+[><B>Conformaciones Relizadas</B></TH></TR><TR BGCOLOR=]+CGIFONDOINPAR+[>");])
   oCgi:SayHtml([ventana.document.write("<TH><TABLE CELLSPACING=0 CELLPADDING=0><TR><TD><FONT NAME=VERDANA SIZE=2 COLOR=]+CGITEXTO+[><B>Clave</B></FONT></TD></TR></TABLE></TH>");]) 
   oCgi:SayHtml([ventana.document.write("<TH><TABLE CELLSPACING=0 CELLPADDING=0><TR><TD><FONT NAME=VERDANA SIZE=2 COLOR=]+CGITEXTO+[><B>Fecha</B></FONT></TD></TR></TABLE></TH>");]) 
   oCgi:SayHtml([ventana.document.write("<TH><TABLE CELLSPACING=0 CELLPADDING=0><TR><TD><FONT NAME=VERDANA SIZE=2 COLOR=]+CGITEXTO+[><B>Conformante</B></FONT></TD></TR></TABLE></TH>");]) 
   oCgi:SayHtml([ventana.document.write("<TH><TABLE CELLSPACING=0 CELLPADDING=0><TR><TD><FONT NAME=VERDANA SIZE=2 COLOR=]+CGITEXTO+[><B>Direccion IP</B></FONT></TD></TR></TABLE></TH>");]) 
 FOR I:=1 TO oTable:RecCount()
    IIF (MOD(I,2)<>0,oCgi:SayHtml([ventana.document.write("</TR><TR BGCOLOR=]+CGIFONDOPAR+[>");]),oCgi:SayHtml([ventana.document.write("</TR><TR BGCOLOR=]+CGIFONDOINPAR+[>");]))
     oCgi:SayHtml([ventana.document.write("<TD ALIGN=CENTER><TABLE><TR><TD><FONT NAME=VERDANA COLOR=]+CGITEXTO+[ SIZE=2>]+alltrim(oTable:CON_CLAVE)+[</FONT></TD></TR></TABLE></TD>");])
     cFecha=IIF (ValType(oTable:CON_FECHA)="C",Substr(oTable:CON_FECHA,9,2)+"/"+Substr(oTable:CON_FECHA,6,2)+"/"+Substr(oTable:CON_FECHA,1,4),DTOC(oTable:CON_FECHA))
     oCgi:SayHtml([ventana.document.write("<TD ALIGN=CENTER><TABLE><TR><TD><FONT NAME=VERDANA COLOR=]+CGITEXTO+[ SIZE=2>]+cFecha+[</FONT></FONT></TD></TR></TABLE></TD>");])
     oCgi:SayHtml([ventana.document.write("<TD ALIGN=CENTER><TABLE><TR><TD><FONT NAME=VERDANA COLOR=]+CGITEXTO+[ SIZE=2>]+IIF(oTable:CON_ORIGEN=[1],[Usuario],IIF(oTable:CON_ORIGEN=[2],[Canal],[Sede Principal]))+[</FONT></FONT></TD></TR></TABLE></TD>");])
     oCgi:SayHtml([ventana.document.write("<TD ALIGN=CENTER><TABLE><TR><TD><FONT NAME=VERDANA COLOR=]+CGITEXTO+[ SIZE=2>]+alltrim(oTable:CON_IP)+[</FONT></TR></TABLE></TD>");])
     oTable:DbSkip()
 ENDFOR
   oTable:End
   oCgi:SayHtml([ventana.document.write("</TR></TABLE>");])
   oCgi:SayHtml([ventana.document.write("</TR></TABLE>");])
   oCgi:SayHtml([ventana.document.write("<BR><INPUT TYPE='button' VALUE='Aceptar' onClick='self.close()'>");]) 
 ELSE
   oCgi:SayHtml([ventana.document.write("<BR><BR><BR><TABLE WIDTH=100% HEIGHT=25% BGCOLOR=]+CGIBORDE+[ ALIGN=CENTER>");])
   oCgi:SayHtml([ventana.document.write("<TR  BGCOLOR=]+CGICABECERA+[><TD>");])
   oCgi:SayHtml([ventana.document.write("<TABLE WIDTH=100% HEIGHT=100% BGCOLOR=]+CGICABECERA+[ ALIGN=CENTER>");])
   oCgi:SayHtml([ventana.document.write("<TR><TH ALIGN=CENTER COLSPAN=2>");])
   oCgi:SayHtml([ventana.document.write("<FONT NAME=VERDANA COLOR=]+CGITITULO+[ SIZE=3><B>Listado de Licencias</B></FONT>");])
   oCgi:SayHtml([ventana.document.write("</TH></TR></TABLE></TD></TR>");])
   oCgi:SayHtml([ventana.document.write("<TR BGCOLOR=]+CGIFONDOINPAR+[ ALIGN=CENTER><TD><BR>");])
   oCgi:SayHtml([ventana.document.write("<FONT NAME=VERDANA COLOR=]+CGITEXTO+[ SIZE=3><B>Esta Licencia no Ha Sido Conformada</B></FONT>");])
   oCgi:SayHtml([ventana.document.write("<BR><BR><INPUT TYPE='button' VALUE='Aceptar' onClick='self.close()'><BR><BR>");]) 
   oCgi:SayHtml([ventana.document.write("</TD></TR></TABLE>");])
 ENDIF
   oCgi:SayHtml([ventana.document.write("</FONT></CENTER></FORM></BODY>");]) 
   oCgi:SayHtml([ventana.document.write("</HTML>");]) 
   oCgi:SayHtml([ventana.document.close();]) 
   oCgi:SayHtml([}]) 
   oCgi:SayHtml([nuevaVentana();])
   oCgi:SayHtml([javascript:history.back();])
   oCgi:SayHtml([</SCRIPT>])
   
RETURN
