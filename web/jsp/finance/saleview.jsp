<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>����ͳ�Ʊ�</title>
</head>
<body>
<%      String dates=China.getParameter(request,"Date1");
		String dates1=China.getParameter(request,"Date2");
		String SecNo1=China.getParameter(request,"SecNo");
		String name="";
		if (!SecNo1.equals("")){
		  name=SecNo1.substring(SecNo1.indexOf("-")+1);
		  SecNo1=SecNo1.substring(0,SecNo1.indexOf("-"));
		}
			String Loft=China.getParameter(request,"Loft");
		String roomno=China.getParameter(request,"room");%>
		<DIV align=center id="printdiv">
  <br><input type="button" name="Button" value="��ӡԤ��" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
 <input type="button" name="Button1" value="������EXCEL" onClick="bringToExcel();">
 </div>
 <!--window.open('yishoukuanviewExcel.jsp?Date1=<%=dates %>&Date2=<%=dates1 %>&SecNo=<%=China.getParameter(request,"SecNo") %>&Loft=<%=Loft %>');-->
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
   <div align=left id=report1 style="background-color:#F7F7F7;height:500px;overflow:auto;width:100%;z-index:2" contentEditable >

<p align="center"><font size=4>��������ͳ�Ʊ�</font></p><br>
�Ϲ�ʱ��:<%=dates %>---<%=dates1 %>
 <table width="99%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
<%  
            out.print("<tr align='center'><td>���</td><td>¥������</td><td>����</td><td>״̬</td><td>�ͻ�����</td><td>���</td><td>����</td><td>�ܼ�</td> <td>�ۼƽɿ���</td><td>Ƿ��</td><td>�ۿ�</td></tr>") ;
			 
	   	  int taxnum=0;
		try{   int countnum=0;
		
		  String SQL="SELECT ";
          SQL+="   o.state,o.code,o.section,o.sectionname,o.loft+o.room_no room,c.cus_name,o.jzarea,o.date,o.rmbprice,o.ewdisc,o.youhui from order_contract o,customer c ";
          SQL+=" where    o.state<>3 and c.serialno=o.customer "; 
		   if (!SecNo1.equals(""))
		  SQL+=" and o.section='"+SecNo1+"'";
		  if (!Loft.equals(""))
		  SQL+=" and o.Loft='"+Loft+"' " ;
		    SQL+=" and convert(char(10),o.Date,120)>='"+dates+"' and  convert(char(10),o.Date,120)<='"+dates1+"'";
		  SQL+="  order by o.sectionname,o.loft,o.floors,o.room,o.room_no asc";//group by o.sectionname+o.loft
		  
		  ResultSet rs=ViewBean.executeQuery(SQL);
	      String cusname="",cusid="",room="",ContractNo="";
		  String phone="",jzarea="",tnarea="",m_jzarea="",m_tnarea="";
		  String counttype="",jzunitprice="",tnunitprice="";
		  String factmoney=""  ,rgdate="",rmbprice="";
		  double zhongji=0;   
		  int sumajfk=0;
		  double hjarea=0;
		  double rmbpri=0;
		  int ii=0;
		  double ljqk=0;
		  double xiaoji=0;
		  String sumprice="",mapp_sumprice="",code="",y_jzarea="",y_usedarea="";
		  while (rs.next()){
		        code=rs.getString("code");
		       String sql="";
			   ResultSet rs1=null;
			    int state=rs.getInt("state");
		        ii++;
			
		       room=getbyte(rs.getString("room"));
			   SecNo1=getbyte(rs.getString("section"));
			   
			     sql="select sum(f.FactMonye) fact from FactAjCharges f";
				sql+=" where   f.contractno ="+code;
				sql+=" and  convert(char(10),f.FactDate,120)>='"+dates+"' and  convert(char(10),f.FactDate,120)<='"+dates1+"'";
				
				
				 rs1=ViewBean1.executeQuery(sql);//��ȡ�����ҿ�
				
				double ajk=0;
				 while (rs1.next())
			   ajk+=rs1.getDouble("fact");
			   
			   rs1.close();
			 //  sumajfk+=ajk;
			   
			    out.print("<tr  align='center' ><td>"+ii+"</td>");
				double jzarea1=rs.getDouble("jzarea");
				hjarea+=jzarea1;
				double pr=rs.getDouble("rmbprice");
				rmbpri+=pr;
				out.print("<td>"+getbyte(rs.getString("sectionname"))+"</td>");
				out.print("<td>"+getbyte(rs.getString("room"))+"</td>");
				if (state==1)
				  out.print("<td> �Ϲ� </td>");
				else 
				  out.print("<td>ǩԼ</td>");
				
				out.print("<td>"+getbyte(rs.getString("cus_name"))+"</td>");
				out.print("<td align='left'>&nbsp;"+FormatD.getFloat2(jzarea1,2)+"</td>");
				out.print("<td  align='left'>&nbsp;"+FormatD.getFloat2(pr/jzarea1,2)+"</td>");
				out.print("<td  align='left'>&nbsp;"+FormatD.getFloat2(pr,2)+"</td>");
				  //�ۼ��տ� 
				sql="select sum(f.factmoney*f.currrate) fact from factGatheringRecord f";
				sql+=" where f.Period in(0,1,2,3,4,8,12,13) and f.ContractNo ="+code;
				sql+=" and   convert(char(10),f.Gather_Date,120)<='"+dates1+"'";
				 double fk=0;
				 rs1=ViewBean1.executeQuery(sql);//��ȡ����
 			     while (rs1.next()){
				   fk=rs1.getDouble("fact");
				  xiaoji+=fk+ajk;
			      out.print("<td align='left'>&nbsp;"+getbyte(FormatD.getFloat2(fk+ajk,2))+"</td>");
			     }
				 rs1.close();
			    //Ƿ��
				   out.print("<td align='left'>&nbsp;"+FormatD.getFloat2(pr-fk-ajk,2)+"&nbsp;</td>");
				   ljqk+=pr-fk-ajk;
				 String yy="";
				String StrEwDisc=getbyte(rs.getString("ewdisc"));
		        if (StrEwDisc.equals("0"))StrEwDisc="";
				else yy+="�ۿ�:"+StrEwDisc;
				double youhui= rs.getDouble("youhui");
				  if (youhui>0)yy+="�Ż�:"+FormatD.getFloat2(youhui,2)+"Ԫ";
				 out.print("<td align='left'>&nbsp;"+yy+"</td>");
				  out.print("</tr>");
				 
			  }
		  rs.close();
		  %>
		  <tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;�ϼ�</td>
		  
		  <td>&nbsp;<%=FormatD.getFloat2(hjarea,2) %></td><td>&nbsp;</td><td>&nbsp;<%=FormatD.getFloat2(rmbpri,2) %></td> <td>&nbsp;<%=FormatD.getFloat2(xiaoji,2) %></td><td>&nbsp;<%=FormatD.getFloat2(ljqk,2) %></td>
		<td>&nbsp;</td>
		  </tr>
		  <%
		   
				  
		}catch(Exception s){out.print(s);}
 %>
</TABLE>
</div>

<script>
  function bringToExcel(){

   // get all the text
   var pasteText = document.all.report1.innerHTML;

   // copy all the text to clipboard
   window.clipboardData.setData ("Text", pasteText);

     // Start Excel and get Application object.     
     var oXL = new ActiveXObject("Excel.Application");     
     oXL.Visible = true;   
     // Get a new workbook.     
     var oWB = oXL.Workbooks.Add();     
     var oSheet = oWB.ActiveSheet;     
    var selectArea=document.body.createTextRange(); //�����ı����� 
        selectArea.moveToElementText(report1);//���ı�����۽���printData 
        selectArea.select();//ѡ��printData 
        selectArea.execCommand("Copy");//��printData���Ƶ����а��� 
         oSheet.Paste();//�����а��е����ݸ��Ƶ�Excel��       
     oXL.Visible = true;     
     oXL.UserControl = true;
  } 
 
 
</script>
</body>
</html>
