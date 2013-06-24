<%@ page contentType="text/html;charset=GBK" %>

 
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
 
<title>销售明细表</title>
 
</head>
 <%@ page language="java" import="java.sql.*,java.util.Date,common.*,java.util.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>

 <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
 <%@ include file="../public_js/getByteOut.jsp"%>
 <%@ include file="../public_js/checktime.jsp"%>
 
<% 
 
 
 
  String stdate = China.getParameter(request,"Date1") ;
  String endate = China.getParameter(request,"Date2") ;
  String SectionName=China.getParameter(request,"SecNo") ; 
  String Region = China.getParameter(request,"Region") ; 
   String room=getbyte1(request.getParameter("room"));
  String Loft=getbyte1(request.getParameter("Loft"));
  String yong_tu=getbyte1(request.getParameter("yong_tu"));
  ResultSet rs=null;
	ResultSet rs1=null;	
   String sql=""; 
   String sectionname="";
   sql="select name from crm_project where serialno='"+SectionName+"'";
   rs=ViewBean.executeQuery(sql);
	if (rs.next())sectionname=rs.getString("name");
	rs.close();
   sql="select    loft,yong_tu from room where  seccode='"+SectionName+"' ";
    if (!Loft.equals(""))
	  sql+=" and loft='"+Loft+"' ";
	  
  sql+=" group by loft,yong_tu order by loft";
   int nn=0;
   double a1=0;
   double a2=0;
   int a3=0;
  double b1=0;
   double b2=0;
   int b3=0;
   
   double c1=0;
   double c2=0;
   int c3=0;
 %>


  
<body>
<form action="rgsview.jsp" method="post" name="frm">
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
<div align=left id=report1 style="background-color:#F7F7F7;height:100%px;overflow:auto;width:100%;z-index:2" contentEditable >
 <font size=3><div id=tit align="center"><%=sectionname %>-未售情况明细表(截止日期：<%=stdate %>)  </div></font>
 
 <p>&nbsp;</p>
 <table width="99%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>

 <tr  > 
<td  align="right">序号</td>
 
<td  align="center">栋号</td>
<td  align="center">用途</td>
<td align="center">未售套数</td>
<td w align="center">未售面积</td>
<td w align="center">未售金额</td>
<td align="center">预留套数</td>
<td w align="center">预留面积</td>
<td w align="center">预留金额</td>
<td align="center">已售套数</td>
<td w align="center">已售面积</td>
<td w align="center">已售金额</td>
 
 
 
	<%
	
	int i=0;
	 try{
		 
	rs=ViewBean.executeQuery(sql);
	 
	 

 
   while (rs.next()){
	 i++;
	   room=getbyte(rs.getString("loft"));
	     yong_tu=getbyte(rs.getString("yong_tu"));
	   sql="select   sum(jzarea) jzarea,sum(rmbprice) rmbprice,count(*) num from order_contract where yong_tu='"+yong_tu+"' and loft='"+room+"' and state<>3  and  section='"+SectionName+"' and convert(char(10),date,120)<='"+stdate+"'";
       double y_jzarea=0;
	   double y_sumprice=0;
	    int y_num=0;
	   rs1=ViewBean1.executeQuery(sql);
      if (rs1.next()){
       y_jzarea=rs1.getDouble("jzarea");
	 
	   y_sumprice= rs1.getDouble("rmbprice") ;
	   y_num=rs1.getInt("num");
	   }
	   a1+=y_jzarea;
	   a2+=y_sumprice;
	   a3+=y_num;
	   rs1.close();
	     sql="select   sum(area) jzarea,sum(sumprice) rmbprice,count(*) num from room where yong_tu='"+yong_tu+"' and loft='"+room+"'    and  seccode='"+SectionName+"' and not seccode+loft+room_code in (select  section+loft+room_no from order_contract where yong_tu='"+yong_tu+"' and loft='"+room+"' and state<>3  and  section='"+SectionName+"' and convert(char(10),date,120)<='"+stdate+"') ";
      double w_jzarea=0;
	   double w_sumprice=0;
	    int w_num=0;
	   rs1=ViewBean1.executeQuery(sql);
      if (rs1.next()){
       w_jzarea=  rs1.getDouble("jzarea") ;
	 
	   w_sumprice=rs1.getDouble("rmbprice");
	   w_num=rs1.getInt("num");
	   }
	   rs1.close();
	   b1+=w_jzarea;
	   b2+=w_sumprice;
	   b3+=w_num;
	      sql="select   sum(area) jzarea,sum(sumprice) rmbprice,count(*) num from room where yong_tu='"+yong_tu+"' and loft='"+room+"' and   salestate =4  and  seccode='"+SectionName+"' ";
       double yl_jzarea=0;
	   double yl_sumprice=0;
	    int yl_num=0;
	   rs1=ViewBean1.executeQuery(sql);
      if (rs1.next()){
       yl_jzarea=  rs1.getDouble("jzarea") ;
	 
	   yl_sumprice=rs1.getDouble("rmbprice");
	   yl_num=rs1.getInt("num");
	   }
	   rs1.close();
	   c1+=yl_jzarea;
	   c2+=yl_sumprice;
	   c3+=yl_num;
  %>
 <tr   align="center">
<td   align="center"><%=i %></td>
 
<td   align="left">&nbsp;<%=room%>　</td>
 <td   align="left">&nbsp;<%=yong_tu%>　</td>
 <td   align="center"><%=w_num%>　</td>
 
<td    align="right"><%=FormtD.getFloat2(w_jzarea ,2)%>　</td>
<td  align="right"><%=FormtD.getFloat2(w_sumprice,2) %></td>
<td   align="center"><%=yl_num%>　</td>
 
<td    align="right"><%=FormtD.getFloat2(yl_jzarea,2) %>　</td>
<td  align="right"><%=FormtD.getFloat2(yl_sumprice,2) %></td>

<td   align="center"><%=y_num%>　</td>
 
<td    align="right"><%=FormtD.getFloat2(y_jzarea,2) %>　</td>
<td  align="right"><%=FormtD.getFloat2(y_sumprice,2) %></td>

 

 
 
</tr> 
 <%
 }
rs.close();  
 }catch(Exception s){out.print(s.getMessage() );out.close();}%>
   <tr   align="center">
<td   align="center">&nbsp;</td>
 
<td   align="left">&nbsp;合计</td>
 <td   align="left">&nbsp;</td>
 
<td   align="center"><%=b3%>　</td>
 
<td    align="right"><%=FormtD.getFloat2(b1,2) %>　</td>
<td  align="right"><%=FormtD.getFloat2(b2,2) %></td>
 <td   align="center"><%=c3%>　</td>
 
<td    align="right"><%=FormtD.getFloat2(c1,2)%>　</td>
<td  align="right"><%=FormtD.getFloat2(c2,2) %></td>
 
<td   align="center"><%=a3%>　</td>
 
<td    align="right"><%=FormtD.getFloat2(a1,2)%>　</td>
<td  align="right"><%=FormtD.getFloat2(a2,2) %></td>
 

 
</tr> 
 </table>
 
 
 <table width="99%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>

 <tr  > 
<td  align="right">序号</td>
<td  align="right"></td>
<td  align="center">用途</td>
<td align="center">未售套数</td>
<td w align="center">未售面积</td>
<td w align="center">未售金额</td>
<td align="center">预留套数</td>
<td w align="center">预留面积</td>
<td w align="center">预留金额</td>
<td align="center">已售套数</td>
<td w align="center">已售面积</td>
<td w align="center">已售金额</td>
</tr>
<%
  sql="select    yong_tu from room where  seccode='"+SectionName+"' ";
    if (!Loft.equals(""))
	  sql+=" and loft='"+Loft+"' ";
	  
     sql+=" group by yong_tu ";
  rs=ViewBean.executeQuery(sql);
  i=0;
   while (rs.next()){
	 i++;
	 
	     yong_tu=getbyte(rs.getString("yong_tu"));
     sql="select   sum(jzarea) jzarea,sum(rmbprice) rmbprice,count(*) num from order_contract where  yong_tu='"+yong_tu+"' and  state<>3  and  section='"+SectionName+"'  and convert(char(10),date,120)<='"+stdate+"'";
     if (!Loft.equals(""))
	   sql+=" and loft='"+Loft+"' ";
	  
       double y_jzarea=0;
	   double y_sumprice=0;
	   int y_num=0;
	   rs1=ViewBean1.executeQuery(sql);
       if (rs1.next()){
        y_jzarea=rs1.getDouble("jzarea");
	 
	    y_sumprice= rs1.getDouble("rmbprice") ;
	    y_num=rs1.getInt("num");
	   }
	   rs1.close();
	   sql="select   sum(area) jzarea,sum(sumprice) rmbprice,count(*) num from room where yong_tu='"+yong_tu+"'  and    seccode='"+SectionName+"' and  seccode+loft+building+room_code not in (select section+loft+building+room_no  from order_contract where  yong_tu='"+yong_tu+"' and  state<>3  and  section='"+SectionName+"'  and convert(char(10),date,120)<='"+stdate+"')";
        if (!Loft.equals(""))
	     sql+=" and loft='"+Loft+"' ";
	   double w_jzarea=0;
	   double w_sumprice=0;
	   int w_num=0;
	   rs1=ViewBean1.executeQuery(sql);
      if (rs1.next()){
       w_jzarea=  rs1.getDouble("jzarea") ;
	 
	   w_sumprice=rs1.getDouble("rmbprice");
	   w_num=rs1.getInt("num");
	   }
	   rs1.close();
	   
	      sql="select   sum(area) jzarea,sum(sumprice) rmbprice,count(*) num from room where yong_tu='"+yong_tu+"'  and   salestate =4  and  seccode='"+SectionName+"' ";
      if (!Loft.equals(""))
	     sql+=" and loft='"+Loft+"' ";
	   double yl_jzarea=0;
	   double yl_sumprice=0;
	    int yl_num=0;
	   rs1=ViewBean1.executeQuery(sql);
      if (rs1.next()){
       yl_jzarea=  rs1.getDouble("jzarea") ;
	 
	   yl_sumprice=rs1.getDouble("rmbprice");
	   yl_num=rs1.getInt("num");
	   }
	   rs1.close();
	  
	   %>
	   
 <tr   align="center">
<td   align="center"><%=i %></td>
 <td  align="right"></td>
 <td   align="center">&nbsp;<%=yong_tu%>　</td>
 <td   align="center"><%=w_num%>　</td>
 
<td    align="right"><%=FormtD.getFloat2(w_jzarea ,2)%>　</td>
<td  align="right"><%=FormtD.getFloat2(w_sumprice,2) %></td>
<td   align="center"><%=yl_num%>　</td>
 
<td    align="right"><%=FormtD.getFloat2(yl_jzarea,2) %>　</td>
<td  align="right"><%=FormtD.getFloat2(yl_sumprice,2) %></td>
<td   align="center"><%=y_num%>　</td>
 
<td    align="right"><%=FormtD.getFloat2(y_jzarea,2) %>　</td>
<td  align="right"><%=FormtD.getFloat2(y_sumprice,2) %></td>

 

 
 
</tr> 
	   <%
	   }
	   rs.close();
 %>
    <tr   align="center">
<td   align="center">&nbsp;</td>
 
<td   align="left">&nbsp;合计</td>
 
 <td  align="right"></td>
<td   align="center"><%=b3%>　</td>
 
<td    align="right"><%=FormtD.getFloat2(b1,2) %>　</td>
<td  align="right"><%=FormtD.getFloat2(b2,2) %></td>
 <td   align="center"><%=c3%>　</td>
 
<td    align="right"><%=FormtD.getFloat2(c1,2)%>　</td>
<td  align="right"><%=FormtD.getFloat2(c2,2) %></td>
<td   align="center"><%=a3%>　</td>
 
<td    align="right"><%=FormtD.getFloat2(a1,2)%>　</td>
<td  align="right"><%=FormtD.getFloat2(a2,2) %></td>
 

 
</tr> 
 </table>
 
 </div>
 <p align="left">说明：未售数中含预留，未售数＋已售数＝总的可售数</p>
 </form>
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
</script><DIV align=center id="printdiv">
<input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'"><input type="button" onclick="bringToExcel()" value="导出到Excel"><br>
导入前必须进行相应设置：<br>
　1.在IE工具栏中选择"internet选项"<br>
　2.选择"安全"->选择"本地intranet"后再点击"自定义级别"<br>
  3.把所有ActiveX启用都选中后点击确认退后。<br>
 
  
 </div>
 
 
</body>
 
</html>
