<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="fBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>

<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "����ӿ�" , 
                  "����ƾ֤"
                ) ;
%>

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>�տ���ϸ��</title>
</head> 
<script language="javascript" src="../public_js/basal.js">
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>

<script language="javascript" src="../public_js/public.js">
</script>
<script language=javascript src="../sale/js/mad.js"> </script>
 
<body>

<%
String SecNo=request.getParameter("SecNo");
String Date1=request.getParameter("Date1");
String Date2=request.getParameter("Date2");
String rate=request.getParameter("rate");
String sel=(String)request.getParameter("sel"); 
String vos[]=request.getParameterValues("vo");
String vono="";
for (int i=0;i<vos.length;i++){
  if (vono.equals(""))vono=vos[i];
  else vono+=","+vos[i];
}
  
   if(sel==null) sel="1";				
 
String SQL1="SELECT * FROM Voucher_Code";
List VOUCHER_CODE=new LinkedList();//��ſ�Ŀ
List VOUCHER_name=new LinkedList();//��ſ�Ŀ����
ResultSet rs1 = ViewBean.executeQuery(SQL1) ;
int j=0;
while (rs1.next()){
  VOUCHER_CODE.add(rs1.getString("vo_code"));
  VOUCHER_name.add(getbyte(rs1.getString("vo_name")));
  j++;
}
 rs1.close();
 String vo="";//ƾ֤���
 rs1 = ViewBean.executeQuery("select max(vono) vono from KVoucher") ;
 if (rs1.next())vo=rs1.getString("vono");
 if (vo==null)vo="1";
 
 rs1.close();
  
String SQL="SELECT sectionname,loft,room_no, signatory,loft+room_no room ,factmoney,CurrName,CurrRate,Gather_Date1,PayType,Receiver,Bill_Num FROM View_FactMoney WHERE  id in ("+vono+") order by GATHER_DATE desc, customer";
ResultSet rs = ViewBean.executeQuery(SQL) ;
double factmoney=0; 
double factmoney1=0; 
 //д��������
while (rs.next()){

  String sectionname=getbyte(rs.getString("sectionname")) ;
  String loft=getbyte(rs.getString("loft")) ; 
  String room_no=getbyte(rs.getString("room_no")) ; 
  String signatory=getbyte(rs.getString("signatory")) ;
  String room=getbyte(rs.getString("room")) ;
    factmoney= rs.getDouble("factmoney");
	factmoney1+=factmoney;
  
  String FactCurry=getbyte(rs.getString("CurrName"));
  String curryDX="";
  if (FactCurry.equals("��"))curryDX="�����";
  else if (FactCurry.equals("HKD"))curryDX="�۱�";
  else if (FactCurry.equals("USD"))curryDX="��Ԫ"; 
  String CurrRate= getbyte(rs.getString("CurrRate")) ;
  String Gather_Date1= rs.getString("Gather_Date1")  ;
  String PayType= getbyte(rs.getString("PayType")) ;
  String Receiver=getbyte(rs.getString("Receiver"))  ;
  String Bill_Num=getbyte(rs.getString("Bill_Num"));
  String code="";
  String name="";
   String insertVo="";
  if (VOUCHER_name.contains(curryDX)){
        int index=VOUCHER_name.indexOf(curryDX);
		code=(String)VOUCHER_CODE.get(index);
		name=(String)VOUCHER_name.get(index);
  }    
  if (sectionname.equals(loft))code+=".00"+room_no;
  else code+=".0"+loft+room_no;
  insertVo="insert into KVoucher(vono,ժҪ,��Ŀ����,��Ŀ����,�ұ�,ԭ�ҽ��";
  insertVo+=",�跽,����,���㷽ʽ,������) values("+vo+",'Ԥ��"+signatory+"("+room+")����'";
  insertVo+=",'"+code+"','Ԥ��"+name+"¥��','"+curryDX+"',"+String.valueOf(factmoney)+",0,"+String.valueOf(factmoney)+"*"+CurrRate+",'"+PayType+"','"+Receiver+"')";
fBean.executeUpdate(insertVo) ;
 
 
}
 rs.close();

 //д�跽����
 SQL="SELECT sum(factmoney)*1.0*(1*1.0-"+rate+"*1.0/1000) as factmoney, sum(factmoney)*"+rate+"/1000 as sxf,PayType,CurrName,CurrRate FROM View_FactMoney WHERE  id in ("+vono+") and (PayType='ˢ��' or paytype='POS��') GROUP BY PayType, CurrName, CurrRate";
 
 rs = ViewBean.executeQuery(SQL) ;

String sxf="";
while (rs.next()){
    factmoney= rs.getDouble("factmoney");
	factmoney1+=factmoney;
  sxf=getbyte(rs.getString("sxf")) ;
  String PayType= getbyte(rs.getString("PayType")) ;
    String FactCurry=getbyte(rs.getString("CurrName"));
	  String CurrRate= getbyte(rs.getString("CurrRate")) ;
  String curryDX="";
  String zy="";
  if (FactCurry.equals("��"))curryDX="�����";
  else if (FactCurry.equals("HKD"))curryDX="�۱�";
  else if (FactCurry.equals("USD"))curryDX="��Ԫ";
  if (!PayType.equals("�ֽ�"))zy="���д��";
  else zy="�ֽ�";
  String code="";
  String name="";
   String insertVo="";
  if (VOUCHER_name.contains(PayType)){
        int index=VOUCHER_name.indexOf(curryDX);
		code=(String)VOUCHER_CODE.get(index);
		name=(String)VOUCHER_name.get(index);
  }    
  insertVo="insert into KVoucher(vono,ժҪ,��Ŀ����,��Ŀ����,�ұ�,ԭ�ҽ��";
  insertVo+=",�跽,���㷽ʽ) values("+vo+",'"+zy+"'";
  insertVo+=",'"+code+"','"+name+"','"+curryDX+"',"+String.valueOf(factmoney)+","+String.valueOf(factmoney)+"*"+CurrRate+",'"+PayType+"')";

 fBean.executeUpdate(insertVo) ;

 insertVo="insert into KVoucher(vono,ժҪ,��Ŀ����,��Ŀ����,�ұ�,ԭ�ҽ��";
  insertVo+=",�跽,���㷽ʽ) values("+vo+",'������'";
  insertVo+=",'"+code+"','"+name+"','"+curryDX+"',"+sxf+","+sxf+"*"+CurrRate+",'"+PayType+"')";
  
 fBean.executeUpdate(insertVo) ;
 
}
rs.close();
//д�跽����
 SQL="SELECT  sum(factmoney) factmoney,PayType,CurrName,CurrRate FROM View_FactMoney WHERE  id in ("+vono+") and ltrim(rtrim(PayType))='�ֽ�' GROUP BY PayType,CurrName, CurrRate";

 rs = ViewBean.executeQuery(SQL) ;
out.print(SQL);
while (rs.next()){
    factmoney= rs.getDouble("factmoney");
	factmoney1+=factmoney;
  
  String PayType= getbyte(rs.getString("PayType")) ;
  String FactCurry=getbyte(rs.getString("CurrName"));
  String CurrRate= getbyte(rs.getString("CurrRate")) ;
  String curryDX="";
  String zy="";
  if (FactCurry.equals("��"))curryDX="�����";
  else if (FactCurry.equals("HKD"))curryDX="�۱�";
  else if (FactCurry.equals("USD"))curryDX="��Ԫ";
   zy="�ֽ�";
  String code="";
  String name="";
   String insertVo="";
  if (VOUCHER_name.contains(curryDX)){
        int index=VOUCHER_name.indexOf(curryDX);
		code=(String)VOUCHER_CODE.get(index);
		name=(String)VOUCHER_name.get(index);
  }    
  insertVo="insert into KVoucher(vono,ժҪ,��Ŀ����,��Ŀ����,�ұ�,ԭ�ҽ��";
  insertVo+=",�跽,���㷽ʽ) values("+vo+",'"+zy+"'";
  insertVo+=",'"+code+"','"+name+"','"+curryDX+"',"+String.valueOf(factmoney)+","+String.valueOf(factmoney)+"*"+CurrRate+",'"+PayType+"')";
 
 fBean.executeUpdate(insertVo) ;
 
}
rs.close();

//д�跽����
 SQL="SELECT  sum(factmoney) as factmoney,PayType,CurrName,CurrRate FROM View_FactMoney WHERE  id in ("+vono+") and (PayType='ת��' or paytype='֧Ʊ') GROUP BY PayType, CurrName, CurrRate";
 rs = ViewBean.executeQuery(SQL) ;

while (rs.next()){
    factmoney= rs.getDouble("factmoney");
	factmoney1+=factmoney;
  
  String PayType= getbyte(rs.getString("PayType")) ;
    String FactCurry=getbyte(rs.getString("CurrName"));
	  String CurrRate= getbyte(rs.getString("CurrRate")) ;
  String curryDX="";
  String zy="";
  if (FactCurry.equals("��"))curryDX="�����";
  else if (FactCurry.equals("HKD"))curryDX="�۱�";
  else if (FactCurry.equals("USD"))curryDX="��Ԫ";
   zy="���д��";
 
  String code="";
  String name="";
   String insertVo="";
  if (VOUCHER_name.contains(curryDX)){
        int index=VOUCHER_name.indexOf(curryDX);
		code=(String)VOUCHER_CODE.get(index);
		name=(String)VOUCHER_name.get(index);
  }    
  insertVo="insert into KVoucher(vono,ժҪ,��Ŀ����,��Ŀ����,�ұ�,ԭ�ҽ��";
  insertVo+=",�跽,���㷽ʽ) values("+vo+",'"+zy+"'";
  insertVo+=",'"+code+"','"+name+"','"+curryDX+"',"+String.valueOf(factmoney)+","+String.valueOf(factmoney)+"*"+CurrRate+",'"+PayType+"')";
 
fBean.executeUpdate(insertVo) ;
 
}
 %> 
</body>
</html>