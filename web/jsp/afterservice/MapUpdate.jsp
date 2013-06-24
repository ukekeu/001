<%@ page contentType="text/html;charset=GBK" %>

  <%@ page import="java.sql.*, common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="bBean" scope="page" class="ConnDatabase.SDatabase" />
  <%@ include file="../public_js/logrecord.jsp" %><HTML>
<%@ include file="../public_js/checktime.jsp"%>
<head>
<title>更新实测面积</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

</head>

<form name=frm>
<input type=hidden name=SecNo>
<input type=hidden name=Loft>
<input type=hidden name=SecName>
<input type=hidden name=Build>
<input type=hidden name=choose>


 </form>

<body bgcolor="#FFFFFF" text="#000000">
<%
	
	String mapUnit = China.getParameter(request, "mappingunit") ;
	String mapDate = China.getParameter(request, "mappingdate") ;
	String retrievalPercent = China.getParameter(request, "percent") ;
	String percent1= China.getParameter(request, "percent1") ;
	String state= China.getParameter(request, "state") ;
	String maxRoomNo = China.getParameter(request, "MaxRoomNo") ;
	String operation = China.getParameter(request, "Operation") ;
	// out.print(operation) ;
	int maxNo = 0;
	String sExist="";
	try {
		maxNo = Integer.parseInt(maxRoomNo) ;
	} catch (Exception e) {
	}
	
	String sOper = "更改" ;
	String sGood = "1" ;
	String insertStr="";
	String updateStr ="";
	String section=China.getParameter(request, "SecNo");
	String loft=China.getParameter(request, "Loft");
	String building=China.getParameter(request, "Build");

			 
	try {
		//aBean.startTransaction();
		for (int i = 1; i <=maxNo; i++) {
	  ;
			String room = China.getParameter(request, "Room" + i) ;
			String MappingArea = China.getParameter(request, "c_Area" + i) ;
            String MappingUserArea = China.getParameter(request, "c_usedArea" + i) ;
	     	String MappinglArea = China.getParameter(request, "c_ltArea" + i) ;
			String MappingtArea = China.getParameter(request, "c_tyArea" + i) ;
			String MappingytArea = China.getParameter(request, "c_ytArea" + i) ;
			String MappingyArea = China.getParameter(request, "c_ytzArea" + i) ;
			String MappingdArea= China.getParameter(request, "c_dtArea" + i) ;
            String MappingywArea=China.getParameter(request, "c_yxzarea" + i) ;
			String ltp=China.getParameter(request, "ltp" + i) ;
			String typ=China.getParameter(request, "typ" + i) ;
			String bxgp=China.getParameter(request, "bxgp" + i) ;
			String dtp=China.getParameter(request, "dtp" + i) ;
            String yxzp=China.getParameter(request, "yxzp" + i) ;
			String area_rate=China.getParameter(request, "area_rate" + i) ;
			String area_rate1=China.getParameter(request, "area_rateA" + i) ;
 
			if (MappingArea.equals(""))continue;
 
      if (Float.parseFloat(MappingArea)>0&&Float.parseFloat(MappingUserArea)>0){
 setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "审核实测面积" , 
                  "审核"+section+loft+building+room
                ) ;	
      insertStr = "update  mapArea " ;
	   insertStr +=" set y_area="+MappingArea+", y_UserArea="+MappingUserArea;
	   insertStr +=",y_lutai_area="+MappinglArea+",lutai_price="+ltp+"," ;
	   insertStr +="y_yangtai_zhao_area="+MappingyArea+",y_yangtai_zao_price="+bxgp;
	   insertStr +=",y_yangtai_area="+MappingytArea+",dt_area="+MappingdArea;
	   insertStr +=",dt_price="+dtp+",y_ty_area="+MappingtArea;
	   insertStr +=",ty_price="+typ+",area_rate="+area_rate;
	   insertStr +=",area_rate1="+area_rate1+",yxz_area="+MappingywArea;
	   insertStr +=",yxz_price="+yxzp+" ,checked=1";
	   insertStr +=" where Section='"+ section + "' and Loft='" + loft;
	   insertStr +="' and Room='"+room+"'";
 
      aBean.executeUpdate(insertStr) ;
     updateStr= "";
	
	 updateStr+="update room set maap_state=1,";
	
	 updateStr+="Area="+MappingArea+",yang_tai_area="+MappingytArea;
	 updateStr+=",UsedArea="+MappingUserArea+",lu_tai_area="+MappinglArea;
	 updateStr+=",yang_tai_zhao_sarea="+MappingyArea;
	 updateStr+=",c_lt_price="+ltp;
	 updateStr+=",c_ty_price="+typ;
	 updateStr+=",Sumprice=Unitprice*"+MappingArea;
	 updateStr+=",Y_Sumprice=Unitprice*"+MappingArea;
	 updateStr+=",room_price=Unitprice*"+MappingArea;
	 
	 //updateStr+=",ftjd_area="+MappingyftjdArea+",ftyd_area="+MappingyftydArea;
	 updateStr+=",ty_area="+MappingtArea+",dt_area="+MappingdArea;
	 updateStr+=",yxz_area="+MappingywArea; 
	 updateStr+=",yxz_area_price="+yxzp; 
	 updateStr+=",dt_area_price="+dtp; 
	 updateStr+=",yang_tai_zhao_price="+bxgp; 
	 updateStr+=" where salestate<3 and  seccode = '"+ section;
     updateStr+="' and building = '" + building + "' and loft = '" ;
     updateStr+=loft + "' and Room_code = '" + room + "'" ;
	    
	 aBean.executeUpdate(updateStr) ;
	
	
	 updateStr="update Order_Contract set jzarea="+MappingArea;
	 updateStr+=",area="+MappingUserArea+",lu_tai_area="+MappinglArea;
	 updateStr+=",yang_tai_area="+MappingytArea+",yang_tai_zhao_sarea="+MappingyArea;
	 updateStr+=",rmbprice="+MappingUserArea+"*(tnunitprice),room_sumprice="+MappingUserArea+"*(tnunitprice),salerprice="+MappingUserArea+"*(tnunitprice)";
	 updateStr+=",dt_area="+MappingdArea;
	 updateStr+=",ty_area="+MappingtArea;
	 updateStr+="   where state=1 and section = '"+ section;
     updateStr+="' and building = '" + building + "' and loft = '" ;
     updateStr+=loft + "' and Room_no = '" + room + "'" ;
	 aBean.executeUpdate(updateStr) ;
	


     
	 updateStr="update Order_Contract set maap_state=1";
	 updateStr+=", cj_f=case when ("+MappingArea+"-jzarea)/jzarea*100<-"+area_rate+" or ("+MappingArea+"-jzarea)/jzarea*100>"+area_rate+" then CONVERT(numeric(9,0),("+MappingArea+"-jzarea)*unitprice) else 0 end";	
	 updateStr+=",gz_c=case when ("+MappingUserArea+"-area)/area*100<-"+area_rate+" or ("+MappingUserArea+"-area)/area*100>"+area_rate+" then "+MappingUserArea+"*gaizhang_unitprice-(gaizhang_unitprice*gaizhang_area*1.0) else 0 end";	
	 updateStr+=",cj_l=case when ("+MappinglArea+"-lu_tai_area)/lu_tai_area*100<-"+area_rate1+" or ("+MappinglArea+"-lu_tai_area)/lu_tai_area*100>"+area_rate1+" then  ("+MappinglArea+"-lu_tai_area)*"+ltp+" else 0 end";	
	 updateStr+=",cj_t=case when ("+MappingtArea+"-ty_area)/ty_area*100<-"+area_rate1+" or ("+MappingtArea+"-ty_area)/ty_area*100>"+area_rate1+" then  ("+MappingtArea+"-ty_area)*"+typ+" else 0 end";	
	 updateStr+=",y_gaizhang_area="+MappingUserArea;
	 updateStr+=",y_area="+MappingUserArea;
	 updateStr+=",y_jzarea="+MappingArea;
	 updateStr+=",y_lu_tai_area="+MappinglArea;
	 updateStr+=",c_ty_area="+MappingtArea;
	 
	 updateStr+="   where state=2 and section = '"+ section;
     updateStr+="' and building = '" + building + "' and loft = '" ;
     updateStr+=loft + "' and Room_no = '" + room + "'" ;
 
	    updateStr+=" and 	ty_area>0  ";//and >0
	 
		updateStr+=" and  lu_tai_area>0 " ;//and lu_tai_area_price>0
	 aBean.executeUpdate(updateStr) ;	
	 
	  updateStr="update Order_Contract set maap_state=1";
	 updateStr+=", cj_f=case when ("+MappingArea+"-jzarea)/jzarea*100<-"+area_rate+" or ("+MappingArea+"-jzarea)/jzarea*100>"+area_rate+" then CONVERT(numeric(9,0),("+MappingArea+"-jzarea)*unitprice) else 0 end";	
	 updateStr+=",gz_c=case when ("+MappingUserArea+"-area)/area*100<-"+area_rate+" or ("+MappingUserArea+"-area)/area*100>"+area_rate+" then "+MappingUserArea+"*gaizhang_unitprice-(gaizhang_unitprice*gaizhang_area*1.0) else 0 end";	
	 updateStr+=",cj_l="+MappinglArea+"*"+ltp+" ";	
	 updateStr+=",cj_t="+MappingtArea+"*"+typ+" ";	
	 updateStr+=",y_gaizhang_area="+MappingUserArea;
	 updateStr+=",y_area="+MappingUserArea;
	 updateStr+=",y_jzarea="+MappingArea;
	 updateStr+=",y_lu_tai_area="+MappinglArea;
	 updateStr+=",c_ty_area="+MappingtArea;
	  
	 updateStr+="   where state=2 and section = '"+ section;
     updateStr+="' and building = '" + building + "' and loft = '" ;
     updateStr+=loft + "' and Room_no = '" + room + "'" ;
 
	    updateStr+=" and 	ty_area=0 ";
 
		updateStr+=" and  lu_tai_area=0";
	 aBean.executeUpdate(updateStr) ;
	 updateStr="update Order_Contract set maap_state=1";
	 updateStr+=", cj_f=case when ("+MappingArea+"-jzarea)/jzarea*100<-"+area_rate+" or ("+MappingArea+"-jzarea)/jzarea*100>"+area_rate+" then CONVERT(numeric(9,0),("+MappingArea+"-jzarea)*unitprice) else 0 end";	
	 updateStr+=",gz_c=case when ("+MappingUserArea+"-area)/area*100<-"+area_rate+" or ("+MappingUserArea+"-area)/area*100>"+area_rate+" then "+MappingUserArea+"*gaizhang_unitprice-(gaizhang_unitprice*gaizhang_area*1.0) else 0 end";	
	 updateStr+=",cj_l="+MappinglArea+"*"+ltp+" ";	
	 updateStr+=",cj_t=case when ("+MappingtArea+"-ty_area)/ty_area*100<-"+area_rate1+" or ("+MappingtArea+"-ty_area)/ty_area*100>"+area_rate1+" then  ("+MappingtArea+"-ty_area)*"+typ+" else 0 end";	
	 updateStr+=",y_gaizhang_area="+MappingUserArea;
	 updateStr+=",y_area="+MappingUserArea;
	 updateStr+=",y_jzarea="+MappingArea;
	 updateStr+=",y_lu_tai_area="+MappinglArea;
	 updateStr+=",c_ty_area="+MappingtArea;
	 
	 updateStr+="   where state=2 and section = '"+ section;
     updateStr+="' and building = '" + building + "' and loft = '" ;
     updateStr+=loft + "' and Room_no = '" + room + "'" ;
 
	    updateStr+=" and 	ty_area>0 "; 
		updateStr+=" and  lu_tai_area=0";
	 aBean.executeUpdate(updateStr) ;
	
	 updateStr="update Order_Contract set maap_state=1";
	updateStr+=", cj_f=case when ("+MappingArea+"-jzarea)/jzarea*100<-"+area_rate+" or ("+MappingArea+"-jzarea)/jzarea*100>"+area_rate+" then CONVERT(numeric(9,0),("+MappingArea+"-jzarea)*unitprice) else 0 end";	
	 updateStr+=",gz_c=case when ("+MappingUserArea+"-area)/area*100<-"+area_rate+" or ("+MappingUserArea+"-area)/area*100>"+area_rate+" then "+MappingUserArea+"*gaizhang_unitprice-(gaizhang_unitprice*gaizhang_area*1.0) else 0 end";	
  	 updateStr+=",cj_l=case when ("+MappinglArea+"-lu_tai_area)/lu_tai_area*100<-"+area_rate1+" or ("+MappinglArea+"-lu_tai_area)/lu_tai_area*100>"+area_rate1+" then  ("+MappinglArea+"-lu_tai_area)*"+ltp+" else 0 end";	
	 updateStr+=",cj_t="+MappingtArea+"*"+typ+" ";	
	 updateStr+=",y_gaizhang_area="+MappingUserArea;
	 updateStr+=",y_area="+MappingUserArea;
	 updateStr+=",y_jzarea="+MappingArea;
	 updateStr+=",y_lu_tai_area="+MappinglArea;
	 updateStr+=",c_ty_area="+MappingtArea;
	  
	 updateStr+="   where state=2 and section = '"+ section;
     updateStr+="' and building = '" + building + "' and loft = '" ;
     updateStr+=loft + "' and Room_no = '" + room + "'" ;
 
	    updateStr+=" and 	ty_area=0 ";
 
		updateStr+=" and  lu_tai_area>0  ";
	 aBean.executeUpdate(updateStr) ;
	  String ch_count=China.getParameter(request, "ch");
	  if (ch_count.equals("1")){
	   String CSQL="SELECT currency,rate,jldate,customer,code,";
	   CSQL+="cj_f,gz_c,cj_l,cj_t,(y_area-area)*1.0/area*100 cj_fr,";
	   CSQL+="case when lu_tai_area>0 then (y_lu_tai_area-lu_tai_area)*1.0/lu_tai_area*100 else 0 end cj_lr, ";
	   CSQL+="case when ty_area>0 then (c_ty_area-ty_area)*1.0/ty_area*100 else 0 end  tyr FROM Order_Contract ";		
	   CSQL+="   where state=2 and section = '"+ section;
       CSQL+="' and building = '" + building + "' and loft = '" ;
       CSQL+=loft + "' and Room_no = '" + room + "'" ;
	   ResultSet rs=null;
	
	  rs= aBean.executeQuery(CSQL) ;	
	  double cj_f=0,gz_c=0,cj_l=0,cj_t=0;
	  double cj_fr=0,gz_cr=0,cj_lr=0,tyr=0;
	  String cusno="",ContactNo="",jl_date="",currency="￥",rate="1";
	  if (rs.next()){
	     currency=rs.getString("currency");
		 rate=rs.getString("rate");
	     jl_date=rs.getDate("jldate").toString();
	     cusno=rs.getString("customer");
	     ContactNo=rs.getString("code");		 
	     cj_f=rs.getDouble("cj_f");
		 gz_c=rs.getDouble("gz_c");
		 cj_l=rs.getDouble("cj_l");
		  cj_t=rs.getDouble("cj_t");
		 cj_fr=rs.getDouble("cj_fr");
		 cj_lr=rs.getDouble("cj_lr");
		 tyr=rs.getDouble("tyr");
	  
	  }
	  rs.close();

	  String SQL1="",SQL2="",SQL3="";
		  if (cj_f!=0)
	  {SQL1="insert into GatheringRecord select '"+cusno+"'";
	   SQL1+=",'"+ContactNo+"',8,'"+jl_date+"',"+String.valueOf(cj_f);
	   SQL1+=",0,0,0,0,1,'"+currency+"',"+rate;
	   aBean.executeUpdate(SQL1) ;	
 
	  }
	 
	 
	 if (gz_c!=0)
			 {SQL1="insert into GatheringRecord select '"+cusno+"'";
		      SQL1+=",'"+ContactNo+"',9,'"+jl_date+"',"+String.valueOf(gz_c);
		      SQL1+=",0,0,0,0,1,'"+currency+"',"+rate;
		      aBean.executeUpdate(SQL1) ;	
	 }
	 
	   if (cj_l!=0)
		
	  {SQL1="insert into GatheringRecord select '"+cusno+"'";
	   SQL1+=",'"+ContactNo+"',10,'"+jl_date+"',"+String.valueOf(cj_l);
	   SQL1+=",0,0,0,0,1,'"+currency+"',"+rate;
	   aBean.executeUpdate(SQL1) ;	
	   	
	  }
		
	
	   if (cj_t!=0)
		
	  {SQL1="insert into GatheringRecord select '"+cusno+"'";
	   SQL1+=",'"+ContactNo+"',10,'"+jl_date+"',"+String.valueOf(cj_t);
	   SQL1+=",0,0,0,0,1,'"+currency+"',"+rate;
	   aBean.executeUpdate(SQL1) ;	
	  
	  }
 
   String sql="select yxz_area_price*yxz_area yxzp,dt_area_price*dt_area+yang_tai_zhao_sarea*yang_tai_zhao_price ytzp from room where maap_state=1 and seccode+loft+room_code='"+section+loft+room+"'";//order by room_no desc";
    rs=aBean.executeQuery(sql);
    double yxzprice=0,ytzprice=0;
	if (rs.next()){
	   yxzprice=rs.getDouble("yxzp");
	   ytzprice=rs.getDouble("ytzp");
	}

	rs.close();
if (!ContactNo.equals("")){
   if (yxzprice>0) 
    {
	  String modiTaxstate="select "+yxzprice+"-TaxMoney c,taxname from   GatheringTaxRecord    where  taxname like '%安全网%' and  ContactNo="+ContactNo;
	rs=aBean.executeQuery(modiTaxstate);
	float yxzc=0;
	String yxzn="";
	 if (rs.next()){yxzc=rs.getFloat("c");yxzn=rs.getString("taxname");}
	 rs.close();
	 if (yxzc!=0)
	 {
	  modiTaxstate="insert into GatheringTaxRecord(ContactNo,TaxName,TaxMoney) values(";
	  modiTaxstate+=ContactNo+",'"+yxzn+"',"+yxzc+")";
	 aBean.executeUpdate(modiTaxstate);
	 }
	
	}
	
	 if (ytzprice>0) 
    {
	  String modiTaxstate="select "+ytzprice+"-TaxMoney c,taxname from   GatheringTaxRecord    where  taxname like '%罩%' and  ContactNo="+ContactNo;
	  rs=aBean.executeQuery(modiTaxstate);
	  float yxzc=0;
	  String yxzn="";
	  if (rs.next()){yxzc=rs.getFloat("c");yxzn=rs.getString("taxname");}
	  rs.close();
	  if (yxzc!=0)
	  {
	  modiTaxstate="insert into GatheringTaxRecord(ContactNo,TaxName,TaxMoney) values(";
	  modiTaxstate+=ContactNo+",'"+yxzn+"',"+yxzc+")";
	  aBean.executeUpdate(modiTaxstate);
 	  }
	 }
   } 
 }
	}	
	   }
		//aBean.commit();
		//aBean.endTransaction();
		
	} catch(Exception ee) {
		aBean.rollback();
		sGood = "0" ;
		out.print(ee.getMessage()+insertStr);
		 out.close();
		
	}
//}
 
	
%>

<form name="form33" method=post action="HistroyPriceList.jsp" >
	<input type=hidden name="SecNo" value="<%= section %>" >
	<input type=hidden name="Build" value="<%= building %>" >
	<input type=hidden name="Loft" value="<%= loft %>" >
	<input type=hidden name="sel" value="1" >
</form>
<script>

	if ("<%= sGood %>" == "1") {
	

		alert("已审核") ;

	} else {
		
		alert("资料<%= sOper %>失败") ;

	}
	document.form33.submit() ;
	 	
</script>
</body>
</html>
 
	
</script>
</body>
</html>
