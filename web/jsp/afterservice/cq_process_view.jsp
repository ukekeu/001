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
 
	<title>��Ȩ����״̬ͼ</title>
</head>

<body>
<%      
		String section=China.getParameter(request,"SecNo");
		 
			String Loft=China.getParameter(request,"Loft");
		 %>
		<DIV align=center id="printdiv">
  <br><input type="button" name="Button" value="��ӡԤ��" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
 <input type="button" name="Button1" value="������EXCEL" onClick=" bringToExcel();">
  </div>
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
  <div align=left id=report1 style="height:500px;overflow:auto;width:100%;z-index:2" contentEditable >

<p align="center"><font size=4>��Ȩ��֤���ȱ�</font></p><br>
  <table><tr><td bgcolor='#FF8040'>��ʾ�������ύ��</td></tr></table>
  <table width="99%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
<%       List list1=new LinkedList();//�������
	    List list2=new LinkedList();//���ʵ�ʵ�����
		List list3=new LinkedList();//ʵ��������Ӧ������
		List list4=new LinkedList();//ʵ��������Ӧ������
		List list5=new LinkedList();//ʵ��������Ӧ������
		List list6=new LinkedList();//ʵ��������Ӧ������
		List list7=new LinkedList();//ʵ��������Ӧ������
		List list8=new LinkedList();//ʵ��������Ӧ������
		String c_ba="select a.contractno  from appraisal a ,order_contract  s  where s.code*=a.contractno and s.state<>3 and s.cq=1 ";
		 ResultSet rsc_ba=ViewBean.executeQuery(c_ba);
		 while (rsc_ba.next()){
		    list4.add(rsc_ba.getString("contractno"));
		 }
		 rsc_ba.close();
		 c_ba="select a.contractno,a.state2,a.state1  from cq_bak a ,order_contract  s  where s.code*=a.contractno and s.state<>3  and s.cq=1";
		   rsc_ba=ViewBean.executeQuery(c_ba);
		 while (rsc_ba.next()){
		 
		    list5.add(rsc_ba.getString("contractno"));
			//list6.add(rsc_ba.getString("state4"));
			list7.add(rsc_ba.getString("state2"));
			
			list8.add(rsc_ba.getString("state1"));
		 }
		 rsc_ba.close();
		   int countnum=0;
		  int taxnum=0;
		    String sql="";
		 
		  String SQL="SELECT  ";
          SQL+="   c.cus_name ,c.phone+' '+c.sj phone,o.code, case when o.fkdate is null then 0 else o.ajmoney  end ajfk,o.ajmoney,o.rmbprice-o.ajmoney sqk,o.loft+o.room_no  room,convert(char(10),o.ajDate,120) ajDate,convert(char(10),o.song_jian_date,120) song_jian_date,convert(char(10),o.cq_lingquDate,120) cq_lingquDate,convert(char(10),o.cq_date,120) cq_date,o.bank_person,o.yhzj  from order_contract o,customer c";
          SQL+=" where o.state<>3 and c.serialno=o.customer and cq =1 and o.code in (select contractno from cq_y_tjdata where type=0 group by contractno) ";
		  
			  SQL+=" and o.section='"+section+"'";
		  if (!Loft.equals(""))
		  SQL+=" and o.Loft='"+Loft+"' " ;
		   ResultSet rs=ViewBean.executeQuery(SQL);
	 
          String cusname="",cusid="",room="",ContractNo="";
		  String phone="",jzarea="",tnarea="",m_jzarea="",m_tnarea="";
		  String counttype="",jzunitprice="",tnunitprice="";
		  String factmoney=""; 
		  double zhongji=0;   
		  String aaaa="";
		    int sumajfk=0;
		  String sumprice="",mapp_sumprice="",code="",y_jzarea="",y_usedarea="";
		  while (rs.next()){
		    list3.clear();
		   list2.clear();
			    ResultSet rs1=null;
			    double xiaoji=0;
		        if (room.equals("")){
			      room=rs.getString("room");
			    
		          out.print("<tr align='center'><td>ҵ������</td><td>��ϵ�绰</td><td>�����</td><td>���ڿ�</><td>���ҿ�</>") ;
			      sql="SELECT dataname,code FROM  cq_tj_data   WHERE  type=0   and  sectionno='"+section+"'";
	              taxnum=0;
				  rs1=ViewBean1.executeQuery(sql);
			      while (rs1.next()){
				    
				    String title=getbyte(rs1.getString("code"));
				    list1.add(title);
					
			        out.print("<td width='6%'>"+getbyte(rs1.getString("dataname"))+"&nbsp;</td>");
					taxnum++;
			      }
				  out.print("<td>�Ƿ���˰</td><td>�ͼ�����</td><td>��֤����</td><td>�Ƿ���ȡ</td><td>�Ƿ��Ѻ</td>");
			      out.print("</tr>");
			      rs1.close();
			     }else{
			    room=getbyte(rs.getString("room"));
				}
				  code=rs.getString("code");
				  String bgcolor="";
				 if (list5.contains(code)){
				    int index=list5.indexOf(code);
						  String ddd=(String)list8.get(index);
						 
						  if (ddd.equals("1"))bgcolor="bgcolor='#FF8040'";
				 }
			     out.print("<tr  align='center'   ><td  "+bgcolor+">"+getbyte(rs.getString("cus_name"))+"</td><td>"+getbyte(rs.getString("phone"))+"</td><td>"+getbyte(rs.getString("room"))+"</td><td>"+getbyte(rs.getString("sqk"))+"</td><td>"+getbyte(rs.getString("ajmoney"))+"</td>");
			     sql="SELECT a.dataname,b.cq_data_code FROM  cq_tj_data  a, cq_y_tjdata b WHERE a.type=0 and b.cq_data_code=a.code and  b.contractno="+code+" and sectionno='"+section+"' order by b.code";
	     		 rs1=ViewBean1.executeQuery(sql);//��ȡ�����ҿ�
				 
				 while (rs1.next()){
				     list2.add(getbyte(rs1.getString("dataname")));
				    list3.add(getbyte(rs1.getString("cq_data_code")));
					 
				  }
			     rs1.close();
				
				 for (int i=0;i<taxnum;i++){
	 		       String strtax=(String)list1.get(i);
				   
				   if (list3.contains(strtax))
				    {  int index=list3.indexOf(strtax);
					  
				       out.print("<td  >��</td>");
				   }else {
				       out.print("<td>&nbsp;</td>");  	 
				    }
				 }
			   
					 if (list5.contains(code)){
					    String ddd="";
						 
					      int index=list5.indexOf(code);
						    ddd=(String)list7.get(index);
						 
					      if (ddd.equals("1")){
					      out.print("<td>��</td>");
					       }else{
					 	  out.print("<td>&nbsp;</td>");
					      } 
						 
					} 	
					 out.print("<td>&nbsp;"+getbyte(rs.getString("song_jian_date"))+"</td>");
					  out.print("<td>&nbsp;"+getbyte(rs.getString("cq_date"))+"</td>");
					   out.print("<td>&nbsp;"+getbyte(rs.getString("cq_lingquDate"))+"</td>");
					  
		          if (getbyte(rs.getString("yhzj")).equals("1")){
					      out.print("<td  >��</td>");
					       }else{
					 	  out.print("<td>&nbsp;</td>");
					      } 
				  out.print("</tr>");
				 
			  }
		  rs.close();
	 
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
