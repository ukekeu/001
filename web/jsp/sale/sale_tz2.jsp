 <%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
  <%@ page import = "java.sql.*,common.*" %>
  <jsp:useBean id = "ViewBean" scope = "page" class = "ConnDatabase.SDatabase" />
  <jsp:useBean id = "changeListBean" scope = "page" class = "ConnDatabase.SDatabase" />
   <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
  <%@ include file="../public_js/getByteOut.jsp"%>


<html>
<head>
	<title>动态销售情况统计表</title>
	<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>

</head>

<body>
<div align=left id=report1 style="background-color:#F7F7F7;height:100%;overflow:auto;width:100%;z-index:2" contentEditable >
<form name="frm">
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
<p align="center"><font size=4><b>动态销售情况统计表</b></font> </p>
<table border="0" cellpadding="0" cellspacing="0"  width="99%"  >
  <tr >
  <td align="left" width="49%"><div id=w1></div></td>  <td align="right" width="49%"><div id=w2></div></td>
  </tr>
  </table>
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="120%" id="AutoNumber1"   >
  <tr>
    <td width="3%" rowspan="3" height="51" align="center">　</td>
    <td width="3%" rowspan="3" height="51" align="center">序号</td>
    <td width="21%" colspan="7" height="17" align="center">基本信息</td>
    <td width="9%" height="17" colspan="3" align="center">当日认购</td>
    <td width="9%" height="17" colspan="3" align="center">当日签约</td>
    <td width="39%" height="17" colspan="13" align="center">已售待回笼</td>
    <td width="10%" height="17" align="center" colspan="3">未售</td>
  </tr>
  <tr>
    <td width="6%" height="16" colspan="2" align="center">楼栋</td>
    <td width="15%" height="16" colspan="5" align="center">面积</td>
    <td width="3%" height="32" rowspan="2" align="center">面积</td>
    <td width="3%" height="32" rowspan="2" align="center">套数</td>
    <td width="3%" height="32" rowspan="2" align="center">合同金额</td>
    <td width="3%" height="32" rowspan="2" align="center">面积</td>
    <td width="3%" height="32" rowspan="2" align="center">套数</td>
    <td width="3%" height="32" rowspan="2" align="center">合同金额</td>
    <td width="9%" height="16" align="center" colspan="3">未签约</td>
    <td width="15%" height="16" align="center" colspan="5">已签约</td>
    <td width="15%" height="16" align="center" colspan="5">合计</td>
    <td width="3%" height="16" align="center"></td>
    <td width="3%" height="16" align="center"></td>
    <td width="4%" height="16" align="center"></td>
  </tr>
  <tr>
    <td width="3%" height="16" align="center">名称</td>
    <td width="3%" height="16" align="center">套数</td>
    <td width="3%" height="16" align="center">阁楼</td>
    <td width="3%" height="16" align="center">车库</td>
    <td width="3%" height="16" align="center">住宅</td>
    <td width="3%" height="16" align="center">套内面积</td>
    <td width="3%" height="16" align="center">建筑面积</td>
    <td width="3%" height="16" align="center">套数</td>
    <td width="3%" height="16" align="center">面积</td>
    <td width="3%" height="16" align="center">金额</td>
    <td width="3%" height="16" align="center">套数</td>
    <td width="3%" height="16" align="center">面积</td>
    <td width="3%" height="16" align="center">金额</td>
    <td width="3%" height="16" align="center">已收</td>
    <td width="3%" height="16" align="center">未收</td>
    <td width="3%" height="16" align="center">套数</td>
    <td width="3%" height="16" align="center">面积</td>
    <td width="3%" height="16" align="center">金额</td>
    <td width="3%" height="16" align="center">已收</td>
    <td width="3%" height="16" align="center">未收</td>
    <td width="3%" height="16" align="center">套数</td>
    <td width="3%" height="16" align="center">面积</td>
    <td width="4%" height="16" align="center">金额　</td>
  </tr>
  <% String  SecNo=China.getParameter(request,"SecNo");
    String  Date1=China.getParameter(request,"Date1");
	String  Loft=China.getParameter(request,"Loft");	
	String  Date2=China.getParameter(request,"Date2");
	String sql="",code="",sectionname="";
	int zjksts=0,drrgs=0,drqys=0,wqys=0,yqys=0;
	double zjgl=0,zjck=0,zjzz=0,zjarea1=0,zjarea2=0;
	double drrgarea=0,drqyarea=0,drrgj=0,drqyj=0;
	double wqyarea=0,yqyarea=0,wqyj=0,yqyj=0;
	double wsj=0;
	       sql="select b.name,a.loft,count(*) num from room a,crm_project b where b.serialno=a.seccode and b.serialno='"+SecNo+"'";
		  		if (!Loft.equals(""))
			 sql+=" and a.loft='"+Loft+"'";
			 sql+=" group by  b.name,a.loft order by b.name,a.loft";
			ResultSet changeRS = null;
			ResultSet changeRS1 = null;
 %>
 <%try{
			changeRS1 = changeListBean.executeQuery(sql);	
			 
			int i=0;
			int num=0;
			while (changeRS1.next()) {
			i++;
			sectionname=getbyte(changeRS1.getString("name"));
			Loft=getbyte(changeRS1.getString("loft"));
			num=changeRS1.getInt("num");
			zjksts+=num;
			String gl="",ck="",zz="",yong_tu="";
			double area1=0,area2=0;
			double sumarea1=0,sumarea2=0;
			
	        sql="select yong_tu ,sum(area) area,sum(usedarea) usedarea from room where seccode='"+SecNo+"' and loft='"+Loft+"' group by yong_tu";
	      
			changeRS = ViewBean.executeQuery(sql);	
			if (changeRS.next()){
			    yong_tu=getbyte(changeRS.getString("yong_tu"));
				area1=changeRS.getDouble("area");
				zjarea1+=area1;
				sumarea1+=area1;				
				area2=changeRS.getDouble("usedarea");
				sumarea2+=area2;
				zjarea2+=area2;
			   if (yong_tu.indexOf("阁楼")>=0){gl=FormtD.getFloat2(area1,2);zjgl+=area1;}
			   else if (yong_tu.indexOf("住宅")>=0){zz=FormtD.getFloat2(area1,2);zjzz+=area1;}
			   else if (yong_tu.indexOf("车库")>=0){ck=FormtD.getFloat2(area1,2);zjck+=area1;}
			   
			}
			changeRS.close();
			  sql="select count(*) num ,sum(jzarea) jzarea,sum(rmbprice) sumprice from order_contract where section+loft='";
			  sql+=SecNo+Loft+"' and state=1 and   convert(char(10),date,120)>='"+Date1+"' and convert(char(10),date,120)<='"+Date2+"'";
			if (!Loft.equals(""))
			 sql+=" and loft='"+Loft+"'";
			
	 %>
  <tr>
    <td width="3%" height="16" align="center"></td>
    <td width="3%" height="16" align="center"><%=i %></td>
    <td width="3%" height="16" align="center"><%=Loft %></td>
    <td width="3%" height="16" align="center"><%=num %></td>
    <td width="3%" height="16" align="center"><%=gl %></td>
    <td width="3%" height="16" align="center"><%=ck %></td>
    <td width="3%" height="16" align="center"><%=zz %></td>
    <td width="3%" height="16" align="center"><%=FormtD.getFloat2(sumarea2,2) %></td>
    <td width="3%" height="16" align="center"><%=FormtD.getFloat2(sumarea1,2) %></td>
	<% changeRS = ViewBean.executeQuery(sql);	
	   String rgn="0",rgarea="0",rgprice="";
			if (changeRS.next()){
	           rgn=changeRS.getString("num");
			   drrgs+=changeRS.getInt("num");
			   drrgarea+=changeRS.getDouble("jzarea");
			   rgprice=FormtD.getFloat2(changeRS.getDouble("sumprice"),0);
			   rgarea=FormtD.getFloat2(changeRS.getDouble("jzarea"),2);
			   drrgj+=changeRS.getDouble("sumprice");
			}
		changeRS.close();
		
		 sql="select count(*) num ,sum(jzarea) jzarea,sum(rmbprice) sumprice from order_contract where section+loft='";
			  sql+=SecNo+Loft+"' and   state=2 and  convert(char(10),visadate,120)>='"+Date1+"' and convert(char(10),visadate,120)<='"+Date2+"'";
			if (!Loft.equals(""))
			 sql+=" and loft='"+Loft+"'";
		String qyn="0",qyarea="0",qyprice="";	
		changeRS = ViewBean.executeQuery(sql);	 
		if (changeRS.next()){
	           qyn=changeRS.getString("num");
			   drqys+=changeRS.getInt("num");
			   drqyarea+=changeRS.getDouble("jzarea");
			   qyprice=FormtD.getFloat2(changeRS.getDouble("sumprice"),0);
			   qyarea=FormtD.getFloat2(changeRS.getDouble("jzarea"),2);
			   drqyj+=changeRS.getDouble("sumprice");
			}
		changeRS.close();	
		
		
		  sql="select count(*) num ,sum(jzarea) jzarea,sum(rmbprice) sumprice from order_contract where state=1 and  section+loft='";
		  sql+=SecNo+Loft+"'";
			 
			 changeRS = ViewBean.executeQuery(sql);	
	        rgn="0";rgarea="0";rgprice="";
			if (changeRS.next()){
	           rgn=changeRS.getString("num");
			   wqys+=changeRS.getInt("num");
			   rgprice=FormtD.getFloat2(changeRS.getDouble("sumprice"),0);
			   wqyj+=changeRS.getDouble("sumprice");
			   rgarea=FormtD.getFloat2(changeRS.getDouble("jzarea"),2);
			   wqyarea+=changeRS.getDouble("jzarea");
			   
			   
			}
		changeRS.close();
		
		
		 sql="select count(*) num ,sum(jzarea) jzarea,sum(rmbprice) sumprice from order_contract where state=2 and  section+loft='";
			  sql+=SecNo+Loft+"'";
		 
		  qyn="0";qyarea="0";qyprice="";	
		changeRS = ViewBean.executeQuery(sql);	 
		if (changeRS.next()){
	           qyn=changeRS.getString("num");
			   yqys+=changeRS.getInt("num");
			   qyprice=FormtD.getFloat2(changeRS.getDouble("sumprice"),0);
			   yqyj+=changeRS.getDouble("sumprice");
			   qyarea=FormtD.getFloat2(changeRS.getDouble("jzarea"),2);
			   yqyarea+=changeRS.getDouble("jzarea");
			   
			}
		changeRS.close();	
		 %>
		   <td width="3%" height="16" align="center"><%=rgarea %></td>
    <td width="3%" height="16" align="center"><%=rgn %></td>
  
    <td width="3%" height="16" align="center"><%=rgprice %></td>
	  <td width="3%" height="16" align="center"><%=qyarea %></td>
   <td width="3%" height="16" align="center"><%=qyn %></td>
  
    <td width="3%" height="16" align="center"><%=qyprice %></td>
     
    <td width="3%" height="16" align="center"><%=rgn %></td>
  <td width="3%" height="16" align="center"><%=rgarea %></td>
    <td width="3%" height="16" align="center"><%=rgprice %></td>
    
   <td width="3%" height="16" align="center"><%=qyn %></td>
   <td width="3%" height="16" align="center"><%=qyarea %></td>
    <td width="3%" height="16" align="center"><%=qyprice %></td>
	<%
	 double sqk=0,ajk=0,ljk=0,ajk1=0;
	 sql="select sum(factmoney*currrate) money from factGatheringRecord where ContractNo in (select code from order_contract where state=2 and section+loft='"+SecNo+Loft+"')";
	sql+=" and convert(char(10),Gather_Date,120)>='"+Date1+"' and  convert(char(10),Gather_Date,120)<='"+Date2+"' ";
	
	changeRS = ViewBean.executeQuery(sql);	
	    while  (changeRS.next()) {	
	      sqk=changeRS.getDouble("money"); 
	   }  
	    changeRS.close();
		
		sql="select sum(FactMonye) money from FactAjCharges where contractno in (select code from order_contract where state=2 and  section+loft='"+SecNo+Loft+"')";
	    sql+="and  convert(char(10),FactDate,120)>='"+Date1+"' and  convert(char(10),FactDate,120)<='"+Date2+"'";
	 
	changeRS = ViewBean.executeQuery(sql);	
	    while  (changeRS.next()) {	
	      sqk+=changeRS.getDouble("money"); 
	   }  
	    changeRS.close();
	 %>
    <td width="3%" height="16" align="center"><%=FormtD.getFloat2(sqk,2) %></td>
    <td width="3%" height="16" align="center"></td>
	<%
	 sql="select count(*) num ,sum(jzarea) jzarea,sum(rmbprice) sumprice from order_contract where state<>3  and  section+loft='";
			  sql+=SecNo+Loft+"'";
		 
		  qyn="0";qyarea="0";qyprice="";	
		changeRS = ViewBean.executeQuery(sql);	 
		if (changeRS.next()){
	           qyn=changeRS.getString("num");
			   qyprice=FormtD.getFloat2(changeRS.getDouble("sumprice"),0);
			   qyarea=FormtD.getFloat2(changeRS.getDouble("jzarea"),2);
			}
		changeRS.close();	
	
	
	sql="select count(*) num ,sum(area) jzarea,sum(sumprice) sumprice from room where salestate=1  and  seccode+loft='";
			  sql+=SecNo+Loft+"'";
		 
		  String wsn="0",wsarea="0",wsprice="0";	
		changeRS = ViewBean.executeQuery(sql);	 
		if (changeRS.next()){
	           wsn=changeRS.getString("num");
			   wsarea=FormtD.getFloat2(changeRS.getDouble("sumprice"),0);
			   wsj+=changeRS.getDouble("sumprice");
			   wsprice=FormtD.getFloat2(changeRS.getDouble("jzarea"),2);
			}
		changeRS.close();	
		
		
		
	sql="select sum(factmoney*currrate) money from factGatheringRecord where ContractNo in (select code from order_contract where  section+loft='"+SecNo+Loft+"')";
	   sqk=0 ;ajk=0;ljk=0;ajk1=0;
	 
	changeRS = ViewBean.executeQuery(sql);	
	    while  (changeRS.next()) {	
	      sqk=changeRS.getDouble("money"); 
	   }  
	    changeRS.close();
		
		sql="select sum(FactMonye) money from FactAjCharges where contractno in (select code from order_contract where    section+loft='"+SecNo+Loft+"')";
	   
	changeRS = ViewBean.executeQuery(sql);	
	    while  (changeRS.next()) {	
	      sqk+=changeRS.getDouble("money"); 
	   }  
	    changeRS.close();
	 %>
    
   <td width="3%" height="16" align="center"><%=qyn %></td>
   <td width="3%" height="16" align="center"><%=qyarea %></td>
    <td width="3%" height="16" align="center"><%=qyprice %></td>
      <td width="3%" height="16" align="center"><%=FormtD.getFloat2(sqk,2) %></td>
    <td width="4%" height="16" align="center"></td>
   <td width="3%" height="16" align="center"><%=wsn %></td>
    <td width="3%" height="16" align="center"><%=wsprice %></td>
   <td width="3%" height="16" align="center"><%=wsarea %></td>
   
  
  </tr>
   <%}
  
  changeRS1.close(); 
  }catch(Exception e){out.print(e);}
  %>
  <tr align="center">
  <td></td><td>合计</td><td></td><td><%=zjksts %></td><td><%=FormtD.getFloat2(zjgl,2) %></td>
  <td><%=FormtD.getFloat2(zjck,2) %></td><td><%=FormtD.getFloat2(zjzz,2) %></td><td><%=FormtD.getFloat2(zjarea2,2) %></td>
  <td><%=FormtD.getFloat2(zjarea1,2) %></td>  <td><%=FormtD.getFloat2(drrgarea,2) %></td><td><%=drrgs %></td>
  <td><%=FormtD.getFloat2(drrgj,0) %></td><td><%=FormtD.getFloat2(drqyarea,2) %></td><td><%=drqys %></td>
  <td><%=FormtD.getFloat2(drqyj,0) %></td>
   <td><%=wqys %></td><td><%=FormtD.getFloat2(wqyarea,2) %></td><td><%=FormtD.getFloat2(wqyj,0) %></td>
   <td><%=yqys %></td><td><%=FormtD.getFloat2(yqyarea,2) %></td><td><%=FormtD.getFloat2(yqyj,0) %></td>
  <td></td><td></td>
   <td><%= wqys+yqys%></td><td><%=FormtD.getFloat2(wqyarea+yqyarea,2) %></td><td><%=FormtD.getFloat2(wqyj+yqyj,0) %></td>
   <td></td> <td>  </td>
   <td><%=zjksts- wqys-yqys%></td><td><%=FormtD.getFloat2(zjarea1-wqyarea-yqyarea,2) %></td>
   <td><%=FormtD.getFloat2(wsj,0) %></td>
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
<p align="center"> <div   id="divprint" align="center"><input type="button" name="Button" value="打印预览"  title="打印前请先收起左边楼栋树" onClick="window.divprint.style.display='none';javascript:document.frm.WebBrowser.ExecWB(7,1);window.divprint.style.display='block'"> <input type="button" onclick="bringToExcel()" value="导出到Excel"><br>
导入前必须进行相应设置：<br>
　1.在IE工具栏中选择"internet选项"<br>
　2.选择"安全"->选择"本地intranet"后再点击"自定义级别"<br>
  3.把所有ActiveX启用都选中后点击确认退后。<br>
 
<script>

w1.innerHTML="楼盘名称：<%=sectionname %>      ";

w2.innerHTML="日期范围：<%=Date1 %>--<%=Date2 %>      ";

</script>
	

</body>
</html>
