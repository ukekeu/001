<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page import="java.sql.*" %>
<jsp:useBean id="modBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="nameBean" scope="page" class="ConnDatabase.SDatabase" />
<%@ include file="../public_js/getByteOut.jsp"%>
<%String uptown=getbyte2(request.getParameter("uptown"));
	   String zid=getbyte2(request.getParameter("zid"));
	   String zname=getbyte2(request.getParameter("zname")); 
%>
 
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/news.css" rel=stylesheet>
<title>�û�������>�û�Ȩ�޹���</title>
<SCRIPT language="JavaScript" type="text/javascript"><!--
function checkdata(para)
{   
    if((pm.uptown.selectedIndex==0))
    {
        alert("��ѡ��С����");
		return false;
    }    
	if(para=="1" && (pm.model_ename.selectedIndex==-1))
	{    
	     alert("���ģ���б���ѡ��һ�����");
		 return false;
	}
	
	else if(para=="1")
	  pm.action_flag.value="add";
    if(para=="2" && (pm.active.selectedIndex==-1))
    {
        alert("����ѱ���Ȩģ���б���ѡ��һ�����");
		return false;
    }
	else if(para=="2")
	  pm.action_flag.value="del";

	  pm.action="priv_user_action.jsp";
	pm.submit();
}
function dobuild()
{
  var path="sys/priv_user.jsp?";
  path+="uptown="+pm.uptown.value+"&build="+pm.build.value;
  pm.action=path;
  //alert(path);
  pm.method="post";
  pm.submit();
}
function douptown()
{
  var path="priv_user.jsp?";
  path+="uptown="+pm.uptown.value+"&zid=<%=zid %>&zname=<%=zname %>";
  pm.action=path;
  //alert(path);
  pm.method="post";
  pm.submit();
}
//-->
</SCRIPT>
</head>
<script language="javascript" src="../public_js/public.js"></script>
<body  oncontextmenu="return false" topmargin="0" leftmargin="0">
<div>
<center>
<form name="pm" method="post">
<input type="Hidden" name="zid" value="<%=zid %>">
<input type="Hidden" name="zname" value="<%=zname %>">
<input type="Hidden" name="action_flag" value="">
<table border="0" cellspacing="0" cellpadding="0" width="100%" >
 <tr>
   <td  align=center height=40 colspan="4">��/�û�Ȩ�����ã�</td>
 </tr>
</table>
<table border="0" width="100%"  cellspacing="1" cellpadding="0" class="L2">
  <tr class=firsttd>
    
	 <script language="JavaScript">
	//   setSelectMad(document.all.uptown,"<%=uptown%>");
	 </script>
	 
	 <td width="20%">&nbsp;&nbsp;��/�û����ƣ�</td>
  <td width="30%"><%=zname %></td>
  </tr>
  
</table>
<table border="0" width="100%"  cellspacing="1" cellpadding="0" class="L2">
  <tr>
    <td width="100%" align="center" colspan="2">
    
    <div align="center">
      <table border="0" width="100%" cellspacing="0" cellpadding="0">
        <tr>
          <td width="140" align="center">����Ȩģ���б�</td>
          <td width="94" align="center">����</td>
          <td width="140" align="center">ģ���б�</td>
        </tr>
        <tr>
          <td width="140" class="input" align="right">
		  <%String sqlPriv = "select   A.section ,A.manmodule,A.cortrol,B.MModuleName from ManModuleCortrol A,ModuleCortrol B where A.ManModule=B.MModuleNo  and A.sellerid='"+zid+"'  and b.nexus='P' ORDER BY B.orderby";
			  %>
		  <select size="20" name="active" style="width:160" multiple>
		<%
		   String MODEL_NO="";
		   String MODEL_CNAME="";
		   String cortrol="";		   
		 //  if(!uptown.equals(""))
		  // {//and A.section like '%"+uptown+"%'
		  					 
		  	ResultSet rsPriv;
 			rsPriv = modBean.executeQuery(sqlPriv);
			while(rsPriv.next()){
			uptown=getbyte(rsPriv.getString("section")).trim();
				MODEL_NO = getbyte(rsPriv.getString("manmodule")).trim();
				cortrol= getbyte(rsPriv.getString("cortrol")).trim();
				MODEL_CNAME = getbyte(rsPriv.getString("MModuleName")).trim();
				String ModuleNo="";
			String ModuleName="";
			String checked="";
			String sqlPri = "select distinct A.ModuleNo,A.checked,B.CModuleName from PopedomConrtrol A,ModuleCortrol B where A.ModuleNo=B.CModuleNo and A.sellerid='"+zid+"' and ManModuleNo='"+MODEL_NO+"' and b.nexus='c' order by A.ModuleNo";
	 	  %>
		  	<option value="<%=MODEL_NO%>"><b><%=MODEL_CNAME%></b></option>
		  <%
		    	ResultSet rsPri;
 			rsPri = nameBean.executeQuery(sqlPri);
			while(rsPri.next()){
				ModuleNo = getbyte(rsPri.getString("ModuleNo")).trim();
				checked= getbyte(rsPri.getString("checked")).trim();
				ModuleName = getbyte(rsPri.getString("CModuleName")).trim();
		  %>
		  	<option value="<%=MODEL_NO+"-"+ModuleNo%>"><%="&nbsp;&nbsp;"+ModuleName%>(<%=checked %>)</option>
		  <%
		  	}
		  	rsPri.close();
			}
		  	rsPriv.close();
			
		 //  }
		  %>
          </select>
		  <input type=hidden name=uptown value="<%=uptown %>">
		  </td>
          <td width="94">
            <p align="center">
			<input type="Checkbox" name="OnlyRead" value="F" checked>���(F)<br>
			<input type="Checkbox" name="OnlyWrite" value="A" checked>����(A)<br>
			<input type="Checkbox" name="OnlyDelete" value="D">ɾ��(D)<br>
			<input type="Checkbox" name="OnlyModify" value="E">�޸�(E)<br>
			<input type="Checkbox" name="OnlyYL"  title="Ԥ��" value="Y">Ԥ��(Y)<br>
			<input type="Checkbox" name="OnlyCheck"  title="���" value="C">���(C)<br>
			<input type="Checkbox" name="OnlyDisc"  title="�����ۿ�" value="K">�ۿ�(K)<br>
						<input type="Checkbox" name="OnlyF"  title="�����ۿ�" value="Q">������Ȩ(Q)
			<p align="center"><input class="button" type="button" value="��Ȩ" style="width: 78" onclick="checkdata('1')"><br>
            <input type="button" class="button" value="ȡ��" style="width: 78" onclick="checkdata('2');">
			<p align="center"><input class="button" type="button" value="�ر�" style="width: 78" onclick="javascript:window.close()"></td>
          <td width="140" class="input">

		  <%
		  	String sqlMod = null;
			String MModuleNo="";
			String CModuleNo="";
		  	//��ȡ��һ��ģ��
		  	sqlMod = "select   MModuleNo,MModuleName from ModuleCortrol  where   MModuleNo<>'' and MModuleName<>'' and nexus='P'  and  active=1 ORDER BY orderby";//
			ResultSet rsMod;
			ResultSet subMod;
 			rsMod = modBean.executeQuery(sqlMod);
			%>
		  <select size="20" name="model_ename" style="width:130" multiple>
		  <%while(rsMod.next())
			{
			MModuleNo=getbyte(rsMod.getString("MModuleNo"));
		  %>
		  	<option value="<%=MModuleNo %>"><b><%=getbyte(rsMod.getString("MModuleName")) %></b></option>
		  <%
		      //��ȡ�ڶ���ģ��
			  sqlMod="select CModuleNo,CModuleName from ModuleCortrol "+
			         "where MModuleNo='"+MModuleNo+"'   and nexus='C' and  active=1    order by CModuleNo";
			  subMod=nameBean.executeQuery(sqlMod);
			  
			  while(subMod.next())
			  {
			  CModuleNo=subMod.getString("CModuleNo");
		 %>
		   <option value="<%=MModuleNo+"-"+CModuleNo%>">
		   <%="&nbsp;&nbsp;"+getbyte(subMod.getString("CModuleName")) %></option>
		 <%
		      }
		  	}
			rsMod.close();
			 %>
            </select></td>
        </tr>
      </table>
      </center>
    </div>
    
    </td>
  </tr>
  <tr><td> </td></tr>
  <tr><td>ʹ�ð����� </td></tr>
  
  <tr><td>
1��ѡ��"ģ���б�"�е�ģ�����ƺ󣬵��"��Ȩ"Ϊ�û�����ɲ�����Ȩ��</td></tr>
  <tr><td>2��ѡ��"����Ȩģ���б�"�е�ģ�����ƺ󣬵��"ȡ��"�����û��Ĳ���Ȩ�ޡ� </td></tr>
</table>
</form>

</div>
</body>

</html>