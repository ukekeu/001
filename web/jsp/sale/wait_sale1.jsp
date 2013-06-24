  <%@ page contentType="text/html;charset=GBK" %>
  <%@ page import = "java.sql.*,common.*" %>
  <jsp:useBean id = "ViewBean" scope = "page" class = "ConnDatabase.SDatabase" />
  <jsp:useBean id = "changeListBean" scope = "page" class = "ConnDatabase.SDatabase" />
   <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
  <%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>存量产品推盘计划</title>
	<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>

<body>

<div align=left id=report1 style="background-color:#F7F7F7;height:100%px;overflow:auto;width:100%;z-index:2" contentEditable >
<form name="frm">
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
<p align="center"><font size=4><b>存量产品推盘计划</b></font> </p>
<table border="0" cellpadding="0" cellspacing="0"  width="99%"  >
  <tr >
  <td align="left" width="49%"><div id=w1></div></td>  <td align="right" width="49%"><div id=w2></div></td>
  </tr>
  </table>

<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="99%" id="AutoNumber1">
  <tr>
    <td width="4%" rowspan="2" align="center">序号</td>
    <td width="24%" colspan="6" align="center">开发状况</td>
    <td width="20%" align="center" colspan="5">销售计划</td>
    <td width="8%" align="center">备注</td>
  </tr>
  <tr>
    <td width="4%" align="center">楼栋</td>
    <td width="4%" align="center">开发时间</td>
    <td width="4%" align="center">面积</td>
    <td width="4%" align="center">套数</td>
    <td width="4%" align="center">户型</td>
    <td width="4%" align="center">总款</td>
    <td width="4%" align="center">计划开盘</td>
    <td width="4%" align="center">开盘单价</td>
    <td width="4%" align="center">面积</td>
    <td width="4%" align="center">套数</td>
    <td width="4%" align="center">总价</td>
    <td width="8%" align="center">　</td>
  </tr>
  
 

  
  <%  String endate = China.getParameter(request,"Date1") ;
      String Loft=getbyte1(request.getParameter("Loft"));
      String SecNo=China.getParameter(request,"SecNo") ;
	  String SQL="";
	  
	  int ksts=0;
	  int wsts=0;
	  double ksarea=0;
	  double wsarea=0;
	  double ksk=0;
	  double wsk=0;
	  String sectionname="";
	  ResultSet changeRS = null;
	  ResultSet changeRS1 = null;
	        SQL="SELECT NAME FROM CRM_Project WHERE SerialNo='"+SecNo+"'";
	        changeRS1 = changeListBean.executeQuery(SQL);	
			 if (changeRS1.next()) {
			     sectionname=changeRS1.getString("NAME");
			}
			changeRS1.close();	 
	         SQL="SELECT Loft,convert(char(10),kp_date,120) kp_date,convert(char(10),kf_date,120) kf_date  FROM LoftBuildCode WHERE SecNo='"+SecNo+"'  ";
	          if (!Loft.equals("")) 
			  SQL+=" AND loft='"+Loft+"'";
			  SQL+=" GROUP BY Loft ,convert(char(10),kp_date,120),convert(char(10),kf_date,120) order by loft"; 
			   try{
	           changeRS1 = changeListBean.executeQuery(SQL);	
			   int i=0;
	
	          while (changeRS1.next()) {
			     i++;
			      Loft=changeRS1.getString("Loft");
	          SQL="SELECT a.loft  ,count(*) num,sum(area) area,sum(sumprice) sumprice FROM room a   where  a.seccode='"+SecNo+"'";
			  
			  SQL+=" AND a.loft='"+Loft+"' group by a.loft";
			     changeRS = ViewBean.executeQuery(SQL);	
				 
    %>
			 <tr>
			 <% 
			 double aa=0;
			  double bb=0;
			  int ii=0;
			 if (changeRS.next()) {
			   ii=changeRS.getInt("num");
			   ksts+=ii; 
			     aa=changeRS.getDouble("area"); 
			   ksarea+=aa; 
			     bb=changeRS.getDouble("sumprice"); 
			   ksk+=bb;
			   }changeRS.close();
			  %>
			    <td   align="center"><%=i %></td>
			    <td   align="center"><%=Loft %></td>
			    <td   align="center"><%= getbyte(changeRS1.getString("kf_date"))%></td>
			  
			    <td   align="center"><%=  FormtD.getFloat2(aa,2)%></td>
				  <td   align="center"><%= ii%></td>
				  <td><% SQL="SELECT a.roomtype,count(*) num FROM room a  where  a.seccode+a.loft+a.room_code not in  (select section+loft+room_no from order_contract where section='"+SecNo+"' and convert(char(10),date,120) <='"+endate+"') and a.seccode='"+SecNo+"'";
			 
			  SQL+=" AND a.loft='"+Loft+"' group by  a.roomtype";
			  
			      changeRS = ViewBean.executeQuery(SQL);	
				  
				
				   while (changeRS.next()) { 
				    out.print(changeRS.getString("roomtype")+changeRS.getString("num")+"套、");
				
				 }
				 changeRS.close(); 
				  
			    %></td>
			    <td   align="center"><%= FormtD.getFloat2(bb,0)%></td>
			<%
			 SQL="SELECT a.loft,count(*) num,sum(area) area,sum(sumprice) sumprice FROM room a  where  a.seccode+a.loft+a.room_code not in  (select section+loft+room_no from order_contract where section='"+SecNo+"' and convert(char(10),date,120) <='"+endate+"') and a.seccode='"+SecNo+"'";
			 
			  SQL+=" AND a.loft=(select loft from LoftBuildCode where SecNo='"+SecNo+"' and ysxkz='' and loft='"+Loft+"' group by loft) group by  a.loft";
			     changeRS = ViewBean.executeQuery(SQL);	
			  ii=0;
			 if (changeRS.next()) { 
			 ii=changeRS.getInt("num");
			 wsts+=ii;
			   aa=changeRS.getDouble("area"); 
			  wsarea+=aa;
			     bb=changeRS.getDouble("sumprice"); 
			  wsk+=bb;
			  }changeRS.close();
			 %>	
				
			    <td   align="center"><%=getbyte(changeRS1.getString("kp_date")) %></td>
			    <td   align="center"></td>
			    <td   align="center"><%= FormtD.getFloat2(aa,2)%></td>
			    <td   align="center"><%= ii%></td>
			    <td   align="center"><%= FormtD.getFloat2(aa,0)%></td>
			    <td   align="center">　</td>
			 
				 
            </tr> 

					   <% }
	 changeRS1.close();
	}catch(Exception e){out.print(e);} %>
					
					<tr align="center">
					<td>合计：</td>
					<td></td>
					<td></td>
					
					<td><%=FormtD.getFloat2(ksarea,2) %></td>
					<td><%=ksts %></td>
					<td></td>
					<td><%=FormtD.getFloat2(ksk,0) %></td>
			 
					
					<td> </td>
					<td></td>
					<td><%=FormtD.getFloat2(wsarea,2) %></td>
					<td><%=wsts %></td>
					<td> </td>
					</tr>
					</table>

</form>
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
<p align="center"> <div   id="divprint" align="center"><input type="button" name="Button" value="打印预览"  title="打印前请先收起左边楼栋树" onClick="window.divprint.style.display='none';javascript:document.frm.WebBrowser.ExecWB(7,1);window.divprint.style.display='block'"> <input type="button" onclick="bringToExcel()" value="导出到Excel"><br>
导入前必须进行相应设置：<br>
　1.在IE工具栏中选择"internet选项"<br>
　2.选择"安全"->选择"本地intranet"后再点击"自定义级别"<br>
  3.把所有ActiveX启用都选中后点击确认退后。<br>
 
<script>

w1.innerHTML="楼盘名称：<%=sectionname %>      ";

w2.innerHTML="截止日期：<%=endate %>    ";

</script>
</body>
</html>
