<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,common.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="vemBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<STYLE type=text/css>BODY {
	FONT-SIZE: 15pt; LINE-HEIGHT: 10pt; FONT-FAMILY: 宋体
}
tr {
	FONT-SIZE: 10pt; HEIGHT: 30pt; FONT-FAMILY: 宋体
} 
</STYLE>
<title>客户交房结清单</title>
</head>

<body>
 <DIV align=center id="printdiv">
 <!--<input class="buttoninput" type="button" value="打印预览" onclick="window.printdiv.style.display='none';factory.printing.Preview();"> -->
 <br><input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
 </div>
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
   <div align=left id=report1 style="background-color:#F7F7F7;height:100%;overflow:auto;width:100%;z-index:2" contentEditable >
  
  <br> <p align="center"><font size=3>结算清单</font></P>
 <table width="98%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
 <%
 //更新结算备注
  String SQL="";
         SQL="UPDATE order_contract SET Jq_BAK='"+request.getParameter("bak")+"',jq_date='"+request.getParameter("jq_date")+"'";
		 SQL+=" WHERE code="+request.getParameter("code");

         ViewBean.executeUpdate(SQL);
		
          SQL="SELECT o.ajbk,o.ajyear,o.ajmoney,o.payment1,o.q_tax_c,o.floors,o.jqfk_date,o.maap_state,o.ytz_jq_date,o.section,o.loft,o.room_no,o.section+o.loft+o.room_no r,o.Jq_BAK,o.jq_date,o.code,c.cus_name,c.ID_Card,c.phone+case when c.sj='null' then '' else  c.sj end phone,o.ContractNo,";
          SQL+="o.sectionname+o.loft+o.room_no room,o.salerprice,o.rmbprice qdprice,o.mapp_sumprice,";
		  SQL+="o.gaizhang_area,o.gaizhang_unitprice,o.gaizhang_unitprice*o.y_gaizhang_area gs";
          SQL+=",o.y_gaizhang_area,o.gaizhang_unitprice*o.y_gaizhang_area y_gs";
          SQL+=",o.gaizhang_unitprice*o.y_gaizhang_area-o.gaizhang_unitprice*o.gaizhang_area gs_c";
		  SQL+=",o.lu_tai_area,o.lu_tai_area_price,o.lu_tai_area_price*o.lu_tai_area ls";
		  SQL+=",o.Y_lu_tai_area,o.lu_tai_area_price*o.Y_lu_tai_area y_ls,o.lu_tai_area_price*o.Y_lu_tai_area-o.lu_tai_area_price*o.lu_tai_area lutai_c ";
		  SQL+=",o.yang_tai_zhao_sarea,o.yang_tai_zhao_sarea*o.yang_tai_zhao_price ytzsprice ";
		  SQL+=",o.yang_tai_zhao_yarea,o.yang_tai_zhao_yarea*o.yang_tai_zhao_price ytzyprice ";
		  SQL+=",o.yang_tai_zhao_price  ";
		   SQL+=",o.ty_area,c_ty_area, ty_area_price,o.ty_area*o.ty_area_price qd_price,o.c_ty_area*o.ty_area_price  hsty_price";
		 
		  SQL+=",o.jzarea,o.y_jzarea,o.area,o.y_area,tnunitprice,o.unitprice,o.cj_f+o.rmbprice hsprice,o.gz_c+o.cj_l+o.cj_t xyc,yxz_jq_date from order_contract o,customer c ";
          SQL+=" where o.customer=c.serialno and o.code="+request.getParameter("code");
	
		  ResultSet rs=ViewBean.executeQuery(SQL);
		  String ajy="0",money="0",payment1="",ajbk="";
		  
		  String ty_area="",c_ty_area="",qd_price="",hsty_price="",ty_area_price="";
		  String Jq_BAK="",jqdate="",r="",maap_state="",yxz_jq_date="";
		  float yang_tai_zhao_yarea=0,yang_tai_zhao_sarea=0;
		  float yang_tai_zhao_price=0,ytzsprice=0,ytzyprice=0;
	      float gaizhang_unitprice=0,gaizhang_area=0,gs=0,Y_gaizhang_area=0;
		  float gzc=0,lutaic=0,ylutaiprice=0,ygzprice=0,xyc=0;
		  float lu_tai_area=0,lutaiPrice=0,lutaisprice=0,Y_lu_tai_area=0;
          String cusname="",cusid="",roomno="",ContractNo="";
		  String phone="",jzarea="",tnarea="",m_jzarea="",m_tnarea="";
		  String counttype="",jzunitprice="",tnunitprice="",q_tax_c="";
		  String mapp_sumprice="",code="",y_jzarea="",y_usedarea="";
		  double  sumprice=0,hpr=0;
		  int ajmoney=0,floors=0;  
		  double h_g_area=0,h_ty_area=0,h_lutai_area=0,g_price=0,lutai_price=0,ty_price=0;;
		  float hsjzarea=0,bxgxr=0;
		  String jqfk_date="";
		  double b1=0,b2=0,b3=0;
		  String qdprice="",section="",loft="",room_no="",jq_date="";
		  String h_Area="",h_UsedArea="";
		  if (rs.next()){
		      ajbk= getbyte(rs.getString("ajbk"));
		      ajy= getbyte(rs.getString("ajyear"));
			  money=getbyte(rs.getString("ajmoney"));
			  payment1=getbyte(rs.getString("payment1"));
		      q_tax_c =getbyte(rs.getString("q_tax_c"));
		       floors=rs.getInt("floors");
		      jqfk_date=getbyte(rs.getString("jqfk_date"));
			  if (!jqfk_date.equals(""))jqfk_date=jqfk_date.substring(0,10);
		      maap_state=getbyte(rs.getString("maap_state"));
		      jq_date=getbyte(rs.getString("ytz_jq_date"));
			  if (!jq_date.equals(""))jq_date=jq_date.substring(0,10);
		      section=getbyte(rs.getString("section"));
			  loft=getbyte(rs.getString("loft"));
			  room_no=getbyte(rs.getString("room_no"));
     		  r=getbyte(rs.getString("r"));
		      Jq_BAK=getbyte(rs.getString("Jq_BAK"));
			  jqdate=getbyte(rs.getDate("jq_date").toString());
		      code=getbyte(rs.getString("code"));
		      cusname=getbyte(rs.getString("cus_name"));
		      cusid=getbyte(rs.getString("ID_Card"));
			  phone=getbyte(rs.getString("phone"));
		      ContractNo=getbyte(rs.getString("ContractNo"));
			  roomno=getbyte(rs.getString("room"));
			   if (floors<0)roomno="地下"+(-floors)+"层"+roomno;
			  yang_tai_zhao_yarea=rs.getFloat("yang_tai_zhao_yarea");
			  ytzsprice=rs.getFloat("ytzsprice");
			  yang_tai_zhao_yarea=rs.getFloat("yang_tai_zhao_yarea");
			  ytzyprice=rs.getFloat("ytzyprice");
			  ytzyprice=rs.getFloat("ytzyprice");
			  yang_tai_zhao_price=rs.getFloat("yang_tai_zhao_price");
		      jzarea=FormatD.getFloat(rs.getFloat("jzarea"),2);
			  y_jzarea=FormatD.getFloat(rs.getFloat("y_jzarea"),2);
			  tnarea=FormatD.getFloat(rs.getFloat("area"),2);
			  y_usedarea=FormatD.getFloat(rs.getFloat("y_area"),2);
			  jzunitprice=FormatD.getFloat(rs.getFloat("unitprice"),2);
			    tnunitprice=FormatD.getFloat1(rs.getFloat("tnunitprice"),2);
			  sumprice=rs.getDouble("salerprice");
			  qdprice=FormatD.getFloat3(rs.getDouble("salerprice"),2);
			  mapp_sumprice=getbyte(rs.getString("mapp_sumprice"));
			  Y_gaizhang_area=rs.getFloat("Y_gaizhang_area");
			  gaizhang_area=rs.getFloat("gaizhang_area");
			  gaizhang_unitprice=rs.getFloat("gaizhang_unitprice");
			  if (gaizhang_unitprice==0)gaizhang_area=0;
			  gs=rs.getFloat("gs");
			  ygzprice=rs.getFloat("y_gs");
			  gzc=rs.getFloat("gs_c");
			  lutaic=rs.getFloat("lutai_c");
			  ylutaiprice=rs.getFloat("y_ls");
			  lu_tai_area=rs.getFloat("lu_tai_area");
			  lutaiPrice=rs.getFloat("lu_tai_area_price");
			  lutaisprice=rs.getFloat("ls");
			  Y_lu_tai_area=rs.getFloat("Y_lu_tai_area");
			  hpr=rs.getDouble("hsprice");
			  ty_area=rs.getString("ty_area");
			  c_ty_area=rs.getString("c_ty_area");
			  
			  ty_area_price=rs.getString("ty_area_price");
			  qd_price=rs.getString("qd_price");
			  hsty_price=rs.getString("hsty_price");
			  hsjzarea=rs.getFloat("y_jzArea");
			 h_Area=FormatD.getFloat(rs.getFloat("y_jzArea"),2);
		     h_UsedArea=FormatD.getFloat(rs.getFloat("y_Area"),2);
			 xyc=rs.getFloat("xyc");
			 yxz_jq_date=getbyte(rs.getString("yxz_jq_date"));
			 if (!yxz_jq_date.equals(""))yxz_jq_date=yxz_jq_date.substring(0,10);
		  }
		  rs.close();
		//String roomSQL="SELECT Area,UsedArea,UsedArea*"+tnunitprice +" hpr,lu_tai_area,lu_tai_area*"+lutaiPrice+" hslutaiPrice from room where seccode='"+section+"' and loft='"+loft+"' and room_code='"+room_no+"'";
		
		float hslutaiPrice=0;
		float hslu_tai_area=0;
	//	rs = ViewBean.executeQuery( roomSQL ) ;
		//if (rs.next()){
		  //h_Area=FormatD.getFloat(rs.getFloat("Area"),2);
		 // h_UsedArea=FormatD.getFloat(rs.getFloat("UsedArea"),2);
		  // hpr=FormatD.getFloat(rs.getFloat("hpr"),2);
		   //hslu_tai_area=rs.getFloat("lu_tai_area");
		  // hslutaiPrice=rs.getFloat("hslutaiPrice");
	//	}
		//rs.close();
		String Fsql="select sum(factmonye) as factmonye from FactAjCharges where contractno="+code; 
	 	rs = ViewBean.executeQuery( Fsql ) ;
		if (rs.next())   ajmoney=rs.getInt("factmonye");
		rs.close();
		   
		  double factmoney=0; 
		  SQL="SELECT sum(f.factmoney*f.currrate) fact ";
          SQL+="  from factGatheringRecord f ";
          SQL+=" where Period in(0,1,2,3,4,8)  and  f.ContractNo="+code;
		  rs=ViewBean.executeQuery(SQL);
	 
		   if (rs.next()){
		     factmoney=rs.getDouble("fact");
		   
		   }
		 
		   rs.close();
		
 %>
  <tr>
    <td width="12%">购房户</td>
    <td width="36%" colspan="3">&nbsp;<%=cusname %></td>
    <td width="13%">身份证号码</td>
    <td width="39%" colspan="3">&nbsp;<%=cusid %></td>
  </tr>
  <tr>
    <td width="12%">地点房号</td>
    <td width="36%" colspan="3">&nbsp;<%=roomno %></td>
    <td width="13%">合同号</td>
    <td width="39%" colspan="3">&nbsp;<%=ContractNo %></td>
  </tr>
  <tr>
    <td width="12%">联系电话</td>
    <td width="88%" colspan="7">&nbsp;<%=phone %></td>
  </tr>
  <tr>
    <td width="12%" rowspan="2">签订面积</td>
    <td width="12%">建筑面积</td>
    <td width="12%">套内面积</td>
    <td width="12%" rowspan="3">套内单价</td>
    <td width="13%" rowspan="3">&nbsp;<%=tnunitprice %></td>
    <td width="13%">签订房款</td>
    <td width="26%" colspan="2">&nbsp;<%=qdprice %></td>
  </tr>
  <tr>
     <td width="12%">&nbsp;<%=jzarea %></td>
    <td width="12%">&nbsp;<%=tnarea %></td>
    <td width="13%" rowspan="2">核实房款</td>
    <td width="26%" colspan="2" rowspan="2">&nbsp;<%if (maap_state.equals("1")){out.print(hpr);} %></td>
  </tr>
  <tr>
    <td width="12%">国土核实</td>
    
	
	   <td width="12%">&nbsp;<%if (maap_state.equals("1")){out.print(h_Area);} %></td>
    <td width="12%">&nbsp;<%if (maap_state.equals("1")){out.print(h_UsedArea);} %></td>
  </tr>
  <tr>
    <td width="12%">已交房款</td>
    <td width="88%" colspan="7">&nbsp;<%=FormatD.getFloat3(factmoney+ajmoney,2)  %></td>
  </tr>
 
  <tr>
    <td width="12%">房款尚欠</td>
    <td width="49%" colspan="4">&nbsp;<%if (hpr>0)out.print(FormatD.getFloat2(hpr-factmoney-ajmoney,2));else out.print(FormatD.getFloat2(sumprice-factmoney-ajmoney,2));  %>　</td>
    <td width="13%">房款付清日期</td>
    <td width="26%" colspan="2"><%=jqfk_date %></td>
  </tr>
  <tr>
    <td width="100%" colspan="8" align="center">代收各种税费</td>
  </tr>
  
  <%String taxdate="";
   SQL="SELECT sum(f.money) money,date ";
      SQL+="  from FactGatheringTaxRecord f ";
      SQL+=" where not f.taxname like '%契%' and  f.taxname_type=1 and f.ContractNo="+code+" group by date";
	  
      rs=ViewBean.executeQuery(SQL);
	   double sumtax=0;
	    while (rs.next()){
        sumtax+=rs.getDouble("money");
		taxdate=getbyte(rs.getString("date"));
		if (!taxdate.equals(""))taxdate=taxdate.substring(0,10);
        }
		rs.close();
  
      SQL="SELECT f.taxname,f.TaxMoney ";
      SQL+="  from GatheringTaxRecord f ";
      SQL+=" where  not f.taxname like '%契%' and f.cancel=0 and f.taxname_type=1 and f.ContactNo="+code;
	 
      rs=ViewBean.executeQuery(SQL);
	  int i=0; 
	 
 
	  double dstaxsum=0;
      while (rs.next()){
	    
	    if (i==0){out.print("<tr>");}
	    out.print("<td width='12%'>");
		out.print(getbyte(rs.getString("taxname")));
		out.print("</td>");
		out.print("<td width='12%'>");
		double tax=rs.getDouble("TaxMoney");
		dstaxsum+=tax;
		out.print(FormatD.getFloat2(tax,2));
		out.print("</td>");
		 
        i++;
		if (i>3){i=0;out.print("</tr>");}
      }
      rs.close();
     if (i==1){out.print("<td width='12%'>&nbsp;</td><td width='12%'>&nbsp;</td><td width='12%'>&nbsp;</td><td width='12%'><br>&nbsp;</td><td width='12%'>&nbsp;</td><td width='12%'><br>&nbsp;</td>");}
       else if (i==2){out.print("<td width='12%'>&nbsp;</td><td width='12%'>&nbsp;</td><td width='12%'>&nbsp;</td><td width='12%'><br>&nbsp;</td>");}
       else if (i==3){out.print("<td width='12%'>&nbsp;&nbsp;</td><td width='12%'>&nbsp;&nbsp;</td>");}
    
   %>
  <tr><td>小计:</td><td><%= FormatD.getFloat2(dstaxsum,2)%></td><td>&nbsp;</td><td>&nbsp;</td><td width='12%'>&nbsp;交款时间:&nbsp;</td><td><%=taxdate %></td><td width='12%'>&nbsp;交款金额:</td><td>&nbsp;<%=FormatD.getFloat2(sumtax,2) %></td></tr>
   <%
    SQL="SELECT f.taxname,sum(f.TaxMoney) TaxMoney ";
      SQL+="  from GatheringTaxRecord f ";
      SQL+=" where  f.cancel=0 and  f.taxname like '%契%' and f.taxname_type=1 and f.ContactNo="+code +" group by f.taxname";
	 
      rs=ViewBean.executeQuery(SQL);
	  double q_tax=0;
	  if (rs.next())q_tax=rs.getDouble("TaxMoney");
	  rs.close();
	  
	 SQL="SELECT f.money ,date ";
      SQL+="  from FactGatheringTaxRecord f ";
      SQL+=" where  f.taxname like '%契%' and  f.taxname_type=1 and f.ContractNo="+code+"";
	  
      rs=ViewBean.executeQuery(SQL); 
	  double fq_tax=0;
	   String q_tax_date="";
	  while (rs.next()){
	    fq_tax+=rs.getDouble("money");
	    q_tax_date=getbyte(rs.getString("date"));
	    if (!q_tax_date.equals(""))q_tax_date=q_tax_date.substring(0,10);
	  }
	  rs.close();
    %>
  <tr><td>应收契税费</td><td><%=q_tax %></td><td>&nbsp;交款时间</td><td><%=q_tax_date %></td>
  <td>&nbsp;交款金额</td><td><%=fq_tax %><td>&nbsp;契税欠款</td><td>&nbsp;<%=FormatD.getFloat3(q_tax-fq_tax,2) %></td></td>
  </tr>
  <tr>
    <td width="100%" colspan="8" align="center">代收各种配套费</td>
  </tr>
 
  <% 
   SQL="SELECT sum(f.money) money,date ";
      SQL+="  from FactGatheringTaxRecord f ";
      SQL+=" where not f.taxname like '%罩%' and not f.taxname like '%安全%' and  f.taxname_type=0 and f.ContractNo="+code +" group by date";
	  
      rs=ViewBean.executeQuery(SQL);
	     sumtax=0;
	    while (rs.next()){
        sumtax+=rs.getDouble("money");
		taxdate=getbyte(rs.getString("date"));
	    if (!taxdate.equals(""))taxdate=taxdate.substring(0,10);
		 
        }
		rs.close();
  
      SQL="SELECT f.taxname,f.TaxMoney ";
      SQL+="  from GatheringTaxRecord f ";
      SQL+=" where  f.cancel=0 and  not f.taxname like '%罩%' and not f.taxname like '%安全%' and   f.cancel=0 and f.taxname_type=0 and f.ContactNo="+code;
	 
      rs=ViewBean.executeQuery(SQL);
	    i=0; 
	 
	     
	    dstaxsum=0;
      while (rs.next()){
	    
	    if (i==0){out.print("<tr>");}
	    out.print("<td width='12%'>");
		out.print(getbyte(rs.getString("taxname")));
		out.print("</td>");
		out.print("<td width='12%'>");
		double tax=rs.getDouble("TaxMoney");
		dstaxsum+=tax;
		out.print(FormatD.getFloat2(tax,2));
		out.print("</td>");
		 
        i++;
		if (i>3){i=0;out.print("</tr>");}
      }
      rs.close();
     if (i==1){out.print("<td width='12%'>&nbsp;</td><td width='12%'>&nbsp;</td><td width='12%'>&nbsp;</td><td width='12%'><br>&nbsp;</td><td width='12%'>&nbsp;</td><td width='12%'><br>&nbsp;</td>");}
       else if (i==2){out.print("<td width='12%'>&nbsp;</td><td width='12%'>&nbsp;</td><td width='12%'>&nbsp;</td><td width='12%'><br>&nbsp;</td>");}
       else if (i==3){out.print("<td width='12%'>&nbsp;&nbsp;</td><td width='12%'>&nbsp;&nbsp;</td>");}
   
   %>
  <tr><td>小计:</td><td><%= FormatD.getFloat2(dstaxsum,2)%></td><td>&nbsp;</td><td>&nbsp;</td><td width='12%'>&nbsp;交款时间:&nbsp;</td><td><%=taxdate %></td><td width='12%'>&nbsp;交款金额:</td><td>&nbsp;<%=FormatD.getFloat2(sumtax,2) %></td></tr>
   <%
	 float  kkk=0;
	 String jk_date="";
	String bxgSQL="SELECT sum(money) money,date FROM FactGatheringTaxRecord WHERE TaxName like '%罩%' and  contractno="+code +" group by date";
	 rs = vemBean.executeQuery( bxgSQL ) ;
	  while (rs.next()){  kkk+=rs.getFloat("money");jk_date=rs.getDate("date").toString();}
	  rs.close();
   %>
 

  <tr>
    <td width="12%" >预收不锈钢<br>罩款</td>
    <td width="12%">&nbsp;<%=FormatD.getFloat(kkk,2) %></td>
    <td width="12%">交款日期</td>
    <td width="12%">&nbsp;<%=jk_date %></td>
    <td width="13%">&nbsp; </td>
    <td width="13%">&nbsp;　</td>
    <td width="13%">&nbsp;　</td>
     <td width="13%">&nbsp;　</td>
  </tr>
  <%
     bxgSQL="SELECT yang_tai_zhao_sarea,yang_tai_zhao_price,dt_area,dt_area_price,yang_tai_zhao_sarea*yang_tai_zhao_price+dt_area*dt_area_price price,c_lt_price,c_ty_price,yxz_area,yxz_area_price FROM room WHERE seccode+loft+room_code='"+r+"'";
	 
	 
	 rs = vemBean.executeQuery( bxgSQL ) ;
	 float bxga=0,bxgj=0,dta=0,dtj=0,c_ty_price=0,c_lt_price=0;
	  float yxz_area=0,yxz_area_price=0;
	 if (rs.next()){
	   bxga=rs.getFloat("yang_tai_zhao_sarea");
	   bxgj=rs.getFloat("yang_tai_zhao_price");
	   dta=rs.getFloat("dt_area");
	   dtj=rs.getFloat("dt_area_price");
	   c_lt_price=rs.getFloat("c_lt_price");
	   c_ty_price=rs.getFloat("c_ty_price");
	     yxz_area=rs.getFloat("yxz_area");
	   yxz_area_price=rs.getFloat("yxz_area_price");
	  // jq_date=rs.getString("jq_date");
	  
	  // if (!jq_date.equals(""))jq_date=jq_date.substring(0,10);
	 
	 }
	 rs.close();
	float bxgc=(bxgj*bxga+dta*dtj)-kkk;
	if (bxga==0&&dta==0)b1=kkk;
   %>
  <tr>  
    <td width="12%">不锈钢罩<br>核实面积</td>
    <td width="12%">&nbsp;<%=bxga %></td>
    <td width="12%" rowspan="2" align="center">单价</td>
    <td width="12%">&nbsp;<%=bxgj %></td>
    <td width="13%" rowspan="2">不锈钢罩差额</td>
    <td width="13%" rowspan="2">&nbsp;<%if (bxga>0){out.print(FormatD.getFloat((bxgj*bxga+dta*dtj)-kkk,2));} %></td>
	 <%if (bxga>0) bxgxr=(bxgj*bxga+dta*dtj)-kkk; %>
    <td width="13%" rowspan="2">结清日期</td>
    <td width="13%" rowspan="2">&nbsp;<%=jq_date %></td>
  </tr>
  <tr>
    <td width="12%">锻铁核实面积</td>
    <td width="12%">&nbsp;<%=dta %></td>
    <td width="12%">&nbsp;<%=dtj %></td>
  </tr>
   <%
	   kkk=0;
	  jk_date="";
	 bxgSQL="SELECT sum(money) money,date FROM FactGatheringTaxRecord WHERE TaxName like '%安全网%' and  contractno="+code +" group by date";
	 rs = vemBean.executeQuery( bxgSQL ) ;
	  while (rs.next()){  kkk+=rs.getFloat("money");jk_date=rs.getDate("date").toString();}
	  rs.close();
	  if (yxz_area==0)b2=kkk;
   %>
 
 
  <tr>
    <td width="12%" >预收防盗安全网款</td>
    <td width="12%">&nbsp;<%=kkk %></td>
    <td width="12%">交款日期</td>
    <td width="12%">&nbsp;<%=jk_date %></td>
    <td width="13%">&nbsp; </td>
    <td width="13%">&nbsp;　</td>
    <td width="13%">&nbsp;　</td>
     <td width="13%">&nbsp;　</td>
  </tr>
  <%float aqc=yxz_area_price*yxz_area-kkk; %>
  <tr>
    <td width="12%">防盗安全网<br>核实面积</td>
    <td width="12%">&nbsp;<%=yxz_area %></td>
    <td width="12%" align="center">单价</td>
    <td width="12%">&nbsp;<%=yxz_area_price %></td>
    <td width="13%" >防盗安全网差额</td>
    <td width="13%" >&nbsp;<%if (yxz_area>0)out.print(yxz_area_price*yxz_area-kkk); %></td>
    <td width="13%" >结清日期</td>
    <td width="13%">&nbsp;<%=yxz_jq_date %></td>
  </tr>
 
  <tr>
    <td width="100%" colspan="8" align="center">补充协议</td>
  </tr>
  <tr align="center">
    <td width="12%">协议内容</td>
    <td width="12%">改装款</td>
    <td width="12%" align="center">露台<br><hr size=0.1>花园使用费</td>
    <td width="12%">小计</td>
    <td width="12%">协议内容</td>
    <td width="12%">改装款</td>
    <td width="12%" align="center">露台<br><hr size=0.1>花园使用费</td>
    <td width="12%">小计</td>
  </tr>
  <tr align="center">
    <td width="12%">签订面积</td>
   <td width="13%"></td>
    <td width="13%" align="center"><%if (lu_tai_area>0)out.print(FormatD.getFloat(lu_tai_area,2));%>
	<br><hr size=0.1>
	<%if (Float.parseFloat(ty_area)>0)out.print(ty_area);%></td>
    <td width="13%"><%out.print(FormatD.getFloat(gaizhang_area+hslu_tai_area+Float.parseFloat(ty_area),2)); %></td>
    <td width="13%">核实面积</td>
    <td width="12%"><%if (Y_gaizhang_area>0&&gaizhang_unitprice>0)out.print(Y_gaizhang_area); %></td>
    <td width="12%" align="center"><%if (Y_lu_tai_area>0)out.print(Y_lu_tai_area); %>
	<br><hr size=0.1>
	<%if (Float.parseFloat(c_ty_area)>0)out.print(c_ty_area); %></td>
    <td width="12%"><%if (Y_gaizhang_area>0&&gaizhang_unitprice>0) out.print(Y_gaizhang_area+Y_lu_tai_area+Float.parseFloat(c_ty_area));else out.print(Y_lu_tai_area+Float.parseFloat(c_ty_area)); %></td>

  </tr>
  <tr align="center">
    <td width="12%">单价</td>
    <td width="12%"><%if (gaizhang_unitprice>0)out.print(gaizhang_unitprice); %></td>
    <td width="12%"><%if (lutaiPrice>0){out.print(lutaiPrice);} %>	<br><hr size=0.1><%if (Float.parseFloat(ty_area_price)>0)out.print(ty_area_price); %></td>
    <td width="12%">　</td>
    <td width="13%">单价</td>
    <td width="13%"><%if (Y_gaizhang_area>0&&gaizhang_unitprice>0){out.print(gaizhang_unitprice);} %></td>
    <td width="13%"><%if (c_lt_price>0){out.print(c_lt_price);} %><br><hr size=0.1><%if (c_ty_price>0){out.print(c_ty_price);} %>	</td>
    <td width="13%">　</td>
  </tr>
  <tr align="center">
    <td width="12%">签订金额</td>
    <td width="12%"><%=FormatD.getFloat3(gaizhang_area*gaizhang_unitprice,2) %></td>
    <td width="12%"><%=lutaisprice %>
	<br><hr size=0.1>
	<%if (Float.parseFloat(qd_price)>0){out.print(qd_price);} %>
	</td>
    <td width="12%"><%=FormatD.getFloat3(gaizhang_area*gaizhang_unitprice+lutaisprice,2) %></td>
    <td width="13%">核实金额</td>
    <td width="13%"><%if (maap_state.equals("1")){out.print(gs);} %></td>
    <td width="13%"><%if (ylutaiprice>0){out.print(FormatD.getFloat(ylutaiprice,2));} %>
	<br><hr size=0.1>
	<%if (Float.parseFloat(hsty_price)>0){out.print(hsty_price);} %></td>
    <td width="13%"><%if (gs+hslutaiPrice+Float.parseFloat(hsty_price)>0){out.print(FormatD.getFloat(gs+ylutaiprice+Float.parseFloat(hsty_price),2));}  %></td>
  </tr>
  <%String xySQL="SELECT sum(f.factmoney*f.currrate) fact ";
           xySQL+="  from factGatheringRecord f ";
           xySQL+=" where(Period=5 OR Period=6 or Period=9 or Period=10) AND f.ContractNo="+code;
		   rs=ViewBean.executeQuery(xySQL);
    float xyk=0;
		 
	if (rs.next())xyk=rs.getFloat("fact");		   
    rs.close(); 
	 xySQL="SELECT sum(f.shouldMoney*f.rate) fact ";
           xySQL+="  from GatheringRecord f ";
           xySQL+=" where(shouldQS=5 OR shouldQS=6 or shouldQS=9 or shouldQS=10 ) AND f.ContactNo="+code;
		   rs=ViewBean.executeQuery(xySQL);
    float yxyk=0;
	
	if (rs.next()){yxyk=rs.getFloat("fact");}		   
    rs.close(); 
		   %>
  <tr>
    <td width="12%">协议差额款</td>
    <td width="12%"><%=xyc %></td>
    <td width="12%">已交协议款</td>
    <td width="12%"><%=xyk %></td>
    <td width="13%">协议尚欠</td>
    <td width="13%"><%=yxyk-xyk %></td>
    <td width="13%">　</td>
    <td width="13%">　</td>
  </tr>
   <% 
   //实收
   xySQL="SELECT sum(f.factmoney*f.currrate) fact ";
           xySQL+="  from factGatheringRecord f ";
           xySQL+=" where f.ContractNo="+code;
		   rs=ViewBean.executeQuery(xySQL);
    double k1=0;
	if (rs.next())k1=rs.getDouble("fact");		   
	 rs.close(); 	
	  xySQL="SELECT sum(f.money) fact ";
           xySQL+="  from FactGatheringTaxRecord f ";
           xySQL+=" where f.contractno="+code;
		   rs=ViewBean.executeQuery(xySQL);
    double k2=0;
	if (rs.next())k2=rs.getDouble("fact");		   
	 rs.close(); 	
	//应收
	 double k3=0;
	   xySQL="SELECT sum(f.TaxMoney) fact ";
           xySQL+="  from GatheringTaxRecord f ";
           xySQL+=" where f.ContactNo="+code;
		   rs=ViewBean.executeQuery(xySQL);
 
	if (rs.next())k3=rs.getDouble("fact");		   
	 rs.close(); 	
	 
	 
	    if (hpr==0)hpr=sumprice;
		   %>
		   
  <tr>
    <td width="12%">应收款总额</td>
    <td width="12%"><%= FormatD.getFloat2(b2+b1+gaizhang_area*gaizhang_unitprice+hpr+xyc+k3+bxgc+aqc-bxgxr,2) %></td>
    <td width="12%">已交总额</td>
    <td width="12%"><%= FormatD.getFloat2(k1+k2+ajmoney,2) %></td>
    <td width="13%">尚欠总额</td>
    <td width="13%" colspan="3"><%= FormatD.getFloat2(b2+b1+gaizhang_area*gaizhang_unitprice+hpr+xyc+k3+bxgc+aqc -k1-k2-ajmoney,2) %></td>
  </tr>
  <tr>
    <td width="100%" colspan="8">同意以上结算，结算单据已领。
      <p>购房户签名：　　　　　　　　　　　　　　　　　　　　　　　　日期：　　　　　　年　　　　月　　　日</td>
  </tr>
  <tr>
    <td width="100%" colspan="8">说明：面积结算单位：平方米，金额结算单位：元</td>
  </tr>
  <tr>
    <td width="100%" colspan="8">备注:<%if (payment1.indexOf("按揭")>=0)out.print("按揭款:"+money+",年限"+ajy+",按揭银行:"+ajbk);else out.print(payment1); %></td>
  </tr>
</table>
<%java.text.SimpleDateFormat date =null;
date=new java.text.SimpleDateFormat("yyyy-MM-dd");
String TodayDate=date.format(new java.util.Date()).toString();
int curyear=Integer.parseInt(TodayDate.substring(0,4));
int curmonth=Integer.parseInt(TodayDate.substring(5,7));
int curday=Integer.parseInt(TodayDate.substring(8,10)); %>
 <table width="80%" > <tr><td>打印日期:<%=curyear %>-<%=curmonth %>-<%=curday %></td><td align="right" >经办人:<%=(String)session.getAttribute("loginname") %></td></tr></table>
</div>
</body>

</html>
