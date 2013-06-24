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
<title>房屋销售情况统计表</title>
</head>
<body>
<%      String dates=China.getParameter(request,"Date1");
		String dates1=China.getParameter(request,"Date2");
		String SecNo1=China.getParameter(request,"SecNo");
		 
			String Loft=China.getParameter(request,"Loft");
		 %>
		<DIV align=center id="printdiv">
  <br><input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
 <input type="button" name="Button1" value="导出到EXCEL" onClick="bringToExcel();">
 </div>
 
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
   <div align=left id=report1 style="background-color:#F7F7F7;height:500px;overflow:auto;width:100%;z-index:2" contentEditable >

<p align="center"><font size=4>房屋销售情况统计表</font></p><br>
 
 时段:<%=dates %>到<%=dates1 %>
 <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="99%" id="AutoNumber1" height="47">
<tr  align="center">
    <td width="10%">项目</td>
    <td width="10%">总套数</td>
    <td width="10%">总面积</td>
    <td width="10%">已推出套数</td>
    <td width="10%">推出面积</td>
    <td width="10%">已售套数</td>
    <td width="10%">已售面积</td>
    <td width="10%">未售套数</td>
    <td width="10%">未售面积</td>
    <td width="10%">备注</td>
  </tr>

  
 
<%       int a1=0,a2=0,a3=0,a4=0;
         double b1=0,b2=0,b3=0,b4=0;
	     String whereSQL="";
		try{    
		 
	     String SQL="SELECT a.name,a.SerialNo from CRM_Project  a";
         if (!SecNo1.equals(""))
		  SQL+=" where  a.SerialNo='"+SecNo1+"'";
		 
		  
		  ResultSet rs=ViewBean.executeQuery(SQL);
		 
	      
		   
		  while (rs.next()){
		      String   name=rs.getString("SerialNo");
			    String   name1=rs.getString("name");
			   ResultSet rs1=null;
			   String sql="";
			    int z_ts=0;
				int ys_ts=0;
			    double z_area=0;
				double ys_area=0;
				double ssajk=0;
				int tcts=0;
				double tcarea=0;
		        sql="select sum(a.area) area,count(*) num from room a,CRM_Project b ";
				sql+=" where  a.seccode=b.SerialNo and  ";
				sql+="     b.name ='"+name1+"' ";
				 rs1=ViewBean1.executeQuery(sql);// 总的情况
				 if (rs1.next()){z_area=rs1.getDouble("area");z_ts=rs1.getInt("num");}
				 rs1.close();
				  a1+=z_ts;
				  b1+=z_area;
				  sql="select sum(area) area,count(*) num from  room  ";
				sql+=" where     ";
				sql+="    fp=1 and  seccode='"+name+"' ";
				 
				
				 rs1=ViewBean1.executeQuery(sql);// 已售情况
				 if (rs1.next()){tcarea=rs1.getDouble("area");tcts=rs1.getInt("num");}
				 rs1.close();
				  a2+=tcts;
				  b2+=tcarea;
				 
				  
				sql="select sum(jzarea) area,count(*) num from  order_contract  ";
				sql+=" where     ";
				sql+="    state<>3 and  sectionname='"+name1+"' ";
				sql+=" and   convert(char(10),date,120)<='"+dates1+"'  and  convert(char(10),date,120)>='"+dates+"' ";
				
				 rs1=ViewBean1.executeQuery(sql);// 已售情况
				 if (rs1.next()){ys_area=rs1.getDouble("area");ys_ts=rs1.getInt("num");}
				 rs1.close();
				  
				  a3+=ys_ts;
				  b3+=ys_area;
				  
				  
				  %>
  <tr  align="center">
    <td width="10%"><%=name1 %></td>
 
    <td width="10%"><%=z_ts %></td>
	   <td width="10%"><%=FormatD.getFloat2(z_area,2) %></td>
      <td width="10%"><%=tcts %></td>
	<td width="10%"><%=FormatD.getFloat2(tcarea,2) %></td>
  
	 <td width="10%"><%=ys_ts %></td>
   <td width="10%"><%=FormatD.getFloat2(ys_area,2) %></td>
    <td width="10%"><%=z_ts-ys_ts %></td>
    <td width="10%"><%=FormatD.getFloat2(z_area-ys_area,2) %></td>
   
    <td width="10%">　</td>
  </tr>


				  <% 
		     }rs.close();
				  
		}catch(Exception s){out.print(s);}
 %>
  <tr  align="center">
					 
    <td width="10%">合计</td>
   
    <td width="10%"><%=a1 %></td>
	   <td width="10%"><%=FormatD.getFloat2(b1,2) %></td>
      <td width="10%"><%=a2 %></td>
	<td width="10%"><%=FormatD.getFloat2(b2,2) %></td>
  
	 <td width="10%"><%=a3 %></td>
   <td width="10%"><%=FormatD.getFloat2(b3,2) %></td>
    <td width="10%"><%=a1-a3 %></td>
    <td width="10%"><%=FormatD.getFloat2(b1-b3,2) %></td>
   
    <td width="10%">　</td>
  </tr>

</table>
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
    var selectArea=document.body.createTextRange(); //创建文本区域 
        selectArea.moveToElementText(report1);//将文本区域聚焦到printData 
        selectArea.select();//选中printData 
        selectArea.execCommand("Copy");//将printData复制到剪切板中 
         oSheet.Paste();//将剪切板中的数据复制到Excel中       
     oXL.Visible = true;     
     oXL.UserControl = true;
  } 
 
 
</script>
</body>
</html>
