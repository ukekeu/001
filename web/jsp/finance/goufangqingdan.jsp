<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,common.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/line.css" >
<STYLE type=text/css>BODY {
	FONT-SIZE: 15pt; LINE-HEIGHT: 30pt; FONT-FAMILY: 宋体
}
tr{
	FONT-SIZE: 10pt; HEIGHT: 22pt; FONT-FAMILY: 宋体
}
</STYLE>
<title>购房清单</title>
</head>

<body>
 <DIV align=center id="printdiv">
 <!--<input class="buttoninput" type="button" value="打印预览" onclick="window.printdiv.style.display='none';factory.printing.Preview();"> -->
 <br><input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
 </div>
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
 <div align=left id=report1 style="background-color:#F7F7F7;height:100%;overflow:auto;width:100%;z-index:2" contentEditable >
 <p align=center>
  <b><font size="3" color="#000080">购房清单</font></b>
 </p>
<table width="95%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
 <%
   double yshou_price=0;
   double sshou_price=0;
   int floors=0;
   String SQL="SELECT o.floors,o.code,c.cus_name,c.ID_Card,c.phone+c.sj phone,o.ContractNo,";
          SQL+="o.sectionname+o.loft+o.room_no room,o.salerprice,o.rmbprice,";
		  SQL+="o.gaizhang_area,o.gaizhang_unitprice,o.gaizhang_unitprice*o.gaizhang_area gs";
          SQL+=",o.lu_tai_area,o.lu_tai_area_price,o.lu_tai_area_price*o.lu_tai_area lutai_price";
		  SQL+=",o.Y_lu_tai_area,o.lu_tai_area_price,o.lu_tai_area_price*o.Y_lu_tai_area yls";
		 
		  SQL+=",o.jzarea,o.area, o.tnunitprice, o.unitprice,o.gaizhang_area*o.gaizhang_unitprice g_sumprice from order_contract o,customer c ";
          SQL+=" where o.customer=c.serialno and o.code="+request.getParameter("code");
		  ResultSet rs=ViewBean.executeQuery(SQL);
          String cusname="",cusid="",roomno="",ContractNo="",g_sumprice="";
		  String phone="",jzarea="",tnarea="",m_jzarea="",m_tnarea="";
		  String counttype="",jzunitprice="",tnunitprice="",lutai_price="";
		  String sumprice="",mapp_sumprice="",code="",y_jzarea="",y_usedarea="";
		  if (rs.next()){
		      floors=rs.getInt("floors");
		      code=getbyte(rs.getString("code"));
		      cusname=getbyte(rs.getString("cus_name"));
		      cusid=getbyte(rs.getString("ID_Card"));
			  phone=getbyte(rs.getString("phone"));
		      ContractNo=getbyte(rs.getString("ContractNo"));
			  roomno=getbyte(rs.getString("room"));
			//  if (floors<0)roomno="地下"+(-floors)+"层"+roomno;
			  lutai_price=FormatD.getFloat1(rs.getFloat("lutai_price"),2);
		      jzarea=FormatD.getFloat(rs.getFloat("jzarea"),2);
			 
			  tnarea=FormatD.getFloat(rs.getFloat("area"),2);
			  tnunitprice=FormatD.getFloat(rs.getFloat("tnunitprice"),2);
			  sumprice=getbyte(rs.getString("salerprice"));
			  mapp_sumprice=getbyte(rs.getString("rmbprice"));
			  g_sumprice=getbyte(rs.getString("g_sumprice"));
			  
			  
		  }
		  rs.close();
		  %>
  <tr>
    <td width="20%">购房客户</td>
    <td width="20%">&nbsp;<%=cusname %></td>
    <td width="20%">地点房号</td>
    <td width="40%" colspan="2">&nbsp;<%=roomno %></td>
  </tr>
  <tr>
    <td width="20%">签订面积(M)<sup>2</sup></td>
    <td width="20%">&nbsp;<%=tnarea %></td>
    <td width="20%">身份证号码</td>
    <td width="40%" colspan="2">&nbsp;<%=cusid %></td>
  </tr>
  <tr>
    <td width="20%">单价(元)</td>
    <td width="20%">&nbsp;<%=tnunitprice %></td>
    <td width="20%">合同号</td>
    <td width="40%" colspan="2">&nbsp;<%=ContractNo %></td>
  </tr>
  <tr>
    <td width="20%">签订总房款</td>
    <td width="20%">&nbsp;<%=sumprice %></td>
    <td width="20%">电话</td>
    <td width="40%" colspan="2">&nbsp;<%=phone %></td>
  </tr>
  <tr>
    <td width="40%" colspan="2">应收项目</td>
    <td width="20%">应交金额(元)</td>
    <td width="20%">已交金额(元)</td>
    <td width="20%">结欠金额（元）</td>
  </tr>
  <% String factmoney=""; 
     String money=""; 
		  SQL="SELECT sum(f.factmoney*f.currrate) fact ";
          SQL+="  from factGatheringRecord f ";
          SQL+=" where  f.Period<5 and f.ContractNo="+code;
		  rs=ViewBean.executeQuery(SQL);
		   if (rs.next()){
		     double sshou=rs.getDouble("fact");
			 factmoney=String.valueOf(sshou);
		     sshou_price +=sshou;
		   
		   }
		   rs.close();
		  SQL="SELECT sum(f.FactMonye) money ";
          SQL+="  from FactAjCharges f ";
          SQL+=" where  f.contractno="+code;
		  int facgaj=0;
		  rs=ViewBean.executeQuery(SQL);
		   if (rs.next()){
		     facgaj=rs.getInt("money");
			 money=String.valueOf(facgaj);
		   sshou_price +=facgaj;
		   }
		   rs.close();
	yshou_price+=Double.parseDouble(sumprice);
	
	
  %>
  <tr>
    <td width="40%" colspan="2">房款</td>
    <td width="20%">&nbsp;<%=sumprice %></td>
    <td width="20%">&nbsp;<%=java.lang.Double.parseDouble(factmoney)+facgaj %></td>
    <td width="20%">&nbsp;<%=FormatD.getFloat3(java.lang.Double.parseDouble(sumprice)-java.lang.Double.parseDouble(factmoney)-facgaj,2) %></td>
  </tr>
  <%  
          SQL="SELECT sum(f.money) fact ";
          SQL+="  from FactGatheringTaxRecord f ";
          SQL+=" where taxname like '%契税%' and  f.contractno="+code;
		  rs=ViewBean.executeQuery(SQL);
		  float s_qtax=0;
		   if (rs.next()){
		 
		      float sshou=rs.getFloat("fact");
			  s_qtax=sshou;
			  factmoney=String.valueOf(sshou);
		      sshou_price +=sshou;
		   }
		   rs.close();
		  SQL="SELECT sum(f.TaxMoney) money ";
          SQL+="  from GatheringTaxRecord f ";
          SQL+=" where taxname like '%契税%' and  f.ContactNo="+code;
		  rs=ViewBean.executeQuery(SQL);
		    float y_qtax=0;
		   if (rs.next()){
		     
		     float yshou=rs.getFloat("money");
			 y_qtax=yshou;
			 money=String.valueOf(yshou);
		     yshou_price +=yshou;
		   }
		   rs.close();
		   
	
  %>
<!--
  <tr>
    <td width="40%" colspan="2">契税费</td>
    <td width="20%">&nbsp;<%=money %></td>
    <td width="20%">&nbsp;<%=factmoney %></td>
    <td width="20%">&nbsp;<%=FormatD.getFloat(java.lang.Float.parseFloat(money)-java.lang.Float.parseFloat(factmoney),2) %></td>
  </tr>-->
  <%
            SQL="SELECT count(*) num ";
          SQL+="  from   GatheringTaxRecord f ";
          SQL+=" where  cancel=0 and not taxname like '%契税%' and taxname_type=1 and  f.ContactNo="+code;
		 
		  rs=ViewBean.executeQuery(SQL);
		   int  num=0;
		   if (rs.next()){
		     num=rs.getInt("num");
		   
		   }
		   rs.close();
		  
		  /*
		  SQL="SELECT sum(f.money) fact ";
          SQL+="  from FactGatheringTaxRecord f ";
          SQL+=" where taxname_type=1 and  f.contractno="+code;
		  rs=ViewBean.executeQuery(SQL);
		   if (rs.next()){
		    
			 float sshou=rs.getFloat("fact");
			 factmoney=String.valueOf(sshou);
		     sshou_price +=sshou;
		   
		   }
		   rs.close();
		   */
		  SQL="SELECT taxname,sum(TaxMoney) money1,sum(factmoney) money ";
          SQL+="  from GatheringTaxRecord f ";
          SQL+=" where cancel=0 and not taxname like '%契税%' and  f.taxname_type=1 and  f.ContactNo="+code +" group by taxname order by taxname";
		  rs=ViewBean.executeQuery(SQL);
		 
		  String g_name="";
		  int aaa=0;
		  double taxsum=0;
		  double taxsum1=0;
		   while (rs.next()){
		    if (aaa==0){
		  %>

  <tr>
    <td width="20%" rowspan="<%=num+3 %>" align="center">代<br>收<br>其<br>他<br>它<br>税<br>费<br>等</td>
	<%}else{out.print("</tr><tr>");}
	       g_name=getbyte(rs.getString("taxname"));
		 	 double yshou=rs.getDouble("money1");
			 taxsum+=yshou;
			//String money1=String.valueOf(yshou);
		     yshou_price +=yshou;    
	 	    double sshou=rs.getDouble("money");
			taxsum1+=sshou;
			  money=String.valueOf(sshou);
		     sshou_price +=sshou;
		
	 %>
    <td width="20%">&nbsp;<%=g_name %></td>
	 <td width="20%">&nbsp;<%=yshou %></td>
	  <td width="20%">&nbsp;<%=sshou %></td>
	  <td width="20%">&nbsp;<%=FormatD.getFloat2(yshou-sshou,2) %></td>
   <%aaa++;} %>
    <tr>
    <td width="20%">&nbsp;<b>小计:</b></td>
	 <td width="20%">&nbsp;<%=FormatD.getFloat2(taxsum,2) %></td>
	 <td width="20%">&nbsp;<%=FormatD.getFloat2(taxsum1,2) %></td>
	
	  <td width="20%">&nbsp;<%=FormatD.getFloat2(taxsum-taxsum1,2) %></td>
   
   </tr>
    <tr>
    <td width="20%">&nbsp;契税</td>
	 <td width="20%">&nbsp;<%=FormatD.getFloat2(y_qtax,2) %></td>
	 <td width="20%">&nbsp;<%=FormatD.getFloat2(s_qtax,2) %></td>
	
	  <td width="20%">&nbsp;<%=FormatD.getFloat2(y_qtax-s_qtax,2) %></td>
   
   </tr>
    <tr>
    <td width="20%">&nbsp;<b>合计:</b></td>
	 <td width="20%">&nbsp;<%=FormatD.getFloat2(taxsum+y_qtax,2) %></td>
	 <td width="20%">&nbsp;<%=FormatD.getFloat2(taxsum1+s_qtax,2) %></td>
	
	  <td width="20%">&nbsp;<%=FormatD.getFloat2((taxsum+y_qtax)-(taxsum1+s_qtax),2) %></td>
   
   </tr>
   
     <%
            SQL="SELECT count(*) num ";
          SQL+="  from   GatheringTaxRecord f ";
          SQL+=" where cancel=0 and  taxname_type=0 and  f.contactno="+code;
		  rs=ViewBean.executeQuery(SQL);
		    num=0;
		   if (rs.next()){
		     num=rs.getInt("num");
		   
		   }
		   rs.close();
		  
		    taxsum=0;
		    taxsum1=0;
		  SQL="SELECT taxname,sum(TaxMoney) money1,sum(factmoney) money ";
          SQL+="  from GatheringTaxRecord f ";
          SQL+=" where  cancel=0 and f.taxname_type=0 and  f.ContactNo="+code +" group by taxname order by taxname";
		  rs=ViewBean.executeQuery(SQL);
		    g_name="";
		    aaa=0;
			
		 
		   while (rs.next()){
		    if (aaa==0){
		  %>

  <tr>
    <td width="20%" rowspan="<%=num+1 %>" align="center">水<br>电<br>等<br>代<br>收<br>款</td>
	<%}else{out.print("</tr><tr>");}
	    g_name=getbyte(rs.getString("taxname"));
		 double yshou=rs.getDouble("money1");
			 taxsum+=yshou;
			//String money1=String.valueOf(yshou);
		     yshou_price +=yshou;    
	 	    double sshou=rs.getDouble("money");
			taxsum1+=sshou;
			  money=String.valueOf(sshou);
		     sshou_price +=sshou;
	 %>
    <td width="20%">&nbsp;<%=g_name %></td>
	 <td width="20%">&nbsp;<%=yshou %></td>
	  <td width="20%">&nbsp;<%=sshou %></td>
	  <td width="20%">&nbsp;<%=FormatD.getFloat2(yshou-sshou,2) %></td>
   <%aaa++;} %>
  
    <tr>
    <td width="20%">&nbsp;<b>小计:</b></td>
	 
	 <td width="20%">&nbsp;<%=FormatD.getFloat2(taxsum,2) %></td>
	 <td width="20%">&nbsp;<%=FormatD.getFloat2(taxsum1,2) %></td>
	
	  <td width="20%">&nbsp;<%=FormatD.getFloat2(taxsum-taxsum1,2) %></td>
  
   </tr>

 

   <%
          SQL="SELECT sum(factmoney*CurrRate) money ";
          SQL+="  from FactGatheringRecord  ";
          SQL+=" where  Period=6 and contractno="+code;
		  rs=ViewBean.executeQuery(SQL);
		  if (rs.next()){
		     float sshou=rs.getFloat("money");
			 money=FormatD.getFloat1(sshou,2);
		     sshou_price +=sshou;}
		  rs.close();
      
	 	     float gyshou=java.lang.Float.parseFloat(g_sumprice);
		 
		     yshou_price +=gyshou;
    %>
    
  <tr>
    <td width="20%" rowspan="2">补充协议</td>
   
    <td width="20%">改装款　</td>
   <td width="20%">&nbsp;<%=FormatD.getFloat2(gyshou,2) %></td>
    <td width="20%">&nbsp;<%=money %></td>
	<td width="20%">&nbsp;<%=FormatD.getFloat(gyshou-java.lang.Float.parseFloat(money),2)  %></td>
  </tr>
  
  <%
          SQL="SELECT sum(factmoney*CurrRate) money ";
          SQL+="  from FactGatheringRecord  ";
          SQL+=" where  Period=5 and contractno="+code;
		  rs=ViewBean.executeQuery(SQL);
		  if (rs.next()){
		     float sshou=rs.getFloat("money");
			 money=String.valueOf(sshou);
		     sshou_price +=sshou;
		 }
		  rs.close();
		    SQL="SELECT sum(shouldMoney*rate) money ";
          SQL+="  from GatheringRecord  ";
          SQL+=" where  shouldQS=5 and contactno="+code;
		  rs=ViewBean.executeQuery(SQL);
		  if (rs.next()){
		     float yshou=rs.getFloat("money");
			 money=FormatD.getFloat1(yshou,2);
		      yshou_price +=yshou;
		 }
		  rs.close();
         
		 
		   
   %>  
  <tr>
    <td width="20%">花园/露台款</td>
    <td width="20%">&nbsp;<%=lutai_price %></td>
    <td width="20%">&nbsp;<%=money %></td>
	<td width="20%">&nbsp;<%=FormatD.getFloat1(java.lang.Float.parseFloat(lutai_price)-java.lang.Float.parseFloat(money),2)  %></td>
   
  </tr>
  <tr>
    <td width="20%">其他</td>
    <td width="20%">　</td>
    <td width="20%">　</td>
    <td width="20%">　</td>
    <td width="20%">　</td>
  </tr>
  <tr>
    <td width="20%">　</td>
    <td width="20%">　</td>
    <td width="20%">　</td>
    <td width="20%">　</td>
    <td width="20%">　</td>
  </tr>
  <tr>
    <td width="20%">　</td>
    <td width="20%">　</td>
    <td width="20%">　</td>
    <td width="20%">　</td>
    <td width="20%">　</td>
  </tr>
  <tr>
    <td width="20%">　</td>
    <td width="20%">　</td>
    <td width="20%">　</td>
    <td width="20%">　</td>
    <td width="20%">　</td>
  </tr>

   <tr>
    <td width="40%" colspan="2">合计</td>
    <td width="20%">&nbsp;<%=FormatD.getFloat2(yshou_price,2) %></td>
    <td width="20%">&nbsp;<%=FormatD.getFloat2(sshou_price,2) %></td>
    <td width="20%">&nbsp;<%=FormatD.getFloat2(yshou_price-sshou_price,2)  %></td>
 
  </tr>
</table>
</div>
</body>

</html>
