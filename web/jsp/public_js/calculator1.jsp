<%@ page contentType="text/html;charset=GBK" %>

<%@ include file="../public_js/yonghuhuodong.jsp" %>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/> 

<%
setYongHuHuoDong( setYongHuHuoDongBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "ѡ���Ƽ�-->���Ҽ���" , 
                  "���"
                ) ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!-- saved from url=(0045)http://www.gzcentaline.com.cn/count/index.htm -->
<HTML><HEAD><TITLE>��</TITLE>
<SCRIPT>
self.resizeTo(screen.availWidth,screen.availHeight)
self.moveTo(0,0)
self.focus()
function openWin(name){
window.open('',name,'menubar=yes,scrollbars=yes,resizable=yes,top=0,left=0')
}
</SCRIPT>

<SCRIPT>

ll0=new Array(4.425, 4.425, 4.425, 4.425, 4.425, 4.65);
ll1=new Array(3.450, 3.450, 3.450, 3.450, 3.450, 3.825);

function sz(obj){if(!(obj.value=parseFloat(0+obj.value)))obj.value=""}

function js(obj,fl){
	if(fl&&((i_zs=obj.in_zs.value)=="")){
		alert("\n\n���������¥���ܽ�\n\n")
		obj.in_zs.focus()
		return false
	}
	if(!fl&&((i_yg=obj.in_yg.value)=="")){
		alert("\n\n����������¹����\n\n")
		obj.in_yg.focus()
		return false
	}

	i_cs=0.1*obj.in_cs.options[obj.in_cs.selectedIndex].value
	
	if((i_m=obj.in_m.value)=="")i_m=12*obj.in_year.options[obj.in_year.selectedIndex].value
	
	if((i_ll=obj.in_ll.value)==""){
		llcn=Math.round(i_m/12)-1
		if(obj.in_zl.options[obj.in_zl.selectedIndex].value=="0"){
			if(llcn>=ll0.length)llcn=ll0.length-1
			i_ll=ll0[llcn]
		}else{
			if(llcn>=ll1.length)llcn=ll1.length-1
			i_ll=ll1[llcn]
		}
	}

	if(fl){
		if((i_dk=obj.in_dk.value)=="")i_dk=i_zs*i_cs
	}else{
		i_dk=i_yg*(Math.pow(1+i_ll/1000,i_m)-1)/(i_ll/1000*Math.pow(1+i_ll/1000,i_m))
	}
	i_dk=Math.floor(i_dk/5000)*5000
	
	if(!fl)i_zs=i_dk/i_cs
	
	i_yg=(i_dk*i_ll/1000*Math.pow(1+i_ll/1000,i_m))/(Math.pow(1+i_ll/1000,i_m)-1)
	i_hk=i_yg*i_m
	i_lx=i_hk-i_dk
	
	obj.out_zs.value=Math.round(i_zs*1000)/1000
	obj.out_sq.value=Math.round((i_zs-i_dk)*100)/1000
	obj.out_dk.value=i_dk
	obj.out_ll.value=i_ll
	obj.out_qs.value=i_m
	obj.out_yg.value=Math.round(i_yg*1000)/1000
	obj.out_hk.value=Math.round(i_hk*1000)/1000
	obj.out_lx.value=Math.round(i_lx*1000)/1000
	if((obj.out_mj.value=obj.in_mj.value)!="")obj.out_dj.value=Math.round(i_zs/obj.out_mj.value*100)/100
	var reate3=obj.reate3.value;
	var reate2=obj.reate2.value;
	var reate1=obj.reate1.value;
	var charge1=obj.charge1.value;
	var charge2=obj.charge2.value;
	//if(obj.lw[1].checked){
		obj.out_s1.value=Math.round(i_zs*parseFloat(reate1))/1000
		obj.out_s2.value=Math.round(i_zs*parseFloat(reate2))/1000
		obj.out_s3.value=Math.round(i_zs*parseFloat(reate3))/1000
		obj.out_s4.value=Math.round(i_zs*parseFloat(reate1)+parseFloat(reate2)+parseFloat(reate3))/1000+(parseFloat(charge1)+parseFloat(charge2));
		obj.charge12.value=charge2;
		obj.charge11.value=charge1;
	//}else{
	//	obj.out_s1.value=Math.round(i_zs*1.5)/100
	//	obj.out_s2.value=Math.round(i_zs*0.25)/100
		//obj.out_s3.value=Math.round(i_zs*0.03)/100
		//obj.out_s4.value=Math.round(i_zs*1.78)/100+105
	//}

}
function choose(obj){
  	if(obj.lw[1].checked){
      obj.reate1.value=1.3;
	  obj.reate2.value=0.03;
  	  obj.reate3.value=0.04;
	}
	else{
	   obj.reate1.value=1.5;
	  obj.reate2.value=0.25;
  	  obj.reate3.value=0.03;
	
	}  
}
function find(obj){
	if(obj.out_dj.value!=""){
		window.open("/building1/area.asp?jj="+obj.out_dj.value,"")
	}else{
		alert("\n\n����ѯ����ÿƽ���׵ļ۸�Ϊ��ѯ�����ģ�\n\n����������ÿƽ�׼۸���ٲ�ѯ��\n\n")
	}
}
</SCRIPT>

<META http-equiv=Content-Type content="text/html; charset=GBK"><LINK 
href="count.files/c1.css" type=text/css rel=stylesheet>
<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY link=#666666 bgColor=#ffffff leftMargin=0 topMargin=0>
<%
  String SQL="SELECT area,sumprice FROM ROOM WHERE seccode='"+request.getParameter("secno")+"'";
      SQL+=" and loft='"+request.getParameter("loft")+"' and room_code='"+request.getParameter("roomno")+"'";
  String area="";
  String price="";
	  ResultSet rs=InsertBean.executeQuery(SQL);
	  if (rs.next()){
	    area=rs.getString("area");
		price=rs.getString("sumprice");
	  }
      rs.close();


 %>
<TABLE cellSpacing=0 cellPadding=0 width=693 align=center border=0>
  <TBODY>
  <TR>
    <TD vAlign=top align=middle width="700" height=9>
      <TABLE borderColor=#f0f4f8 width=657 border=0>
        <TBODY>
        <TR>
          <TD vAlign=top align=middle height=14 width="100%">
            <FORM action="" method=post>
            <TABLE cellSpacing=0 cellPadding=0 width=690 border=0>   
              <TBODY>   
              <TR align=middle>   
                <TD height=23 width="688">   
                 
			<p align=left>  <B class=p2>&nbsp;&nbsp;&nbsp;&nbsp;<%=request.getParameter("secname") %>&nbsp;&nbsp;<%=request.getParameter("loft") %>&nbsp;&nbsp;&nbsp;&nbsp;<%=request.getParameter("build") %>&nbsp;&nbsp;<%=request.getParameter("roomno") %>��&nbsp;&nbsp;
			</FONT></B></p> 
                </TD></TR></TBODY></TABLE>   
            <TABLE class=p1 cellSpacing=0 borderColorDark=#ffffff cellPadding=5    
            width=649 bgColor=#fffbe8 borderColorLight=#ffcc00 border=1>   
              <CENTER>   
              <TBODY>   
              <TR>   
                <TD class=td align=middle width=16    
                  rowSpan=2>��<BR>ҵ<BR>��<BR>��<BR>��<BR>�� </TD>   
                <TD noWrap width=154 rowSpan=2>���ҳ���: <SELECT class=input    
                  size=1 name=in_cs> <OPTION value=9>9��</OPTION> <OPTION    
                    value=8>8��</OPTION> <OPTION value=7 selected>7��</OPTION>    
                    <OPTION value=6>6��</OPTION> <OPTION value=5>5��</OPTION>    
                    <OPTION value=4>4��</OPTION> <OPTION value=3>3��</OPTION>    
                    <OPTION value=2>2��</OPTION> <OPTION    
                  value=10>10��</OPTION></SELECT> <BR>��������: <SELECT class=input    
                  onchange="this.form.in_m.value=''" size=1 name=in_year>    
                    <OPTION value=1>1��(12��)</OPTION> <OPTION    
                    value=2>2��(24��)</OPTION> <OPTION value=3>3��(36��)</OPTION>    
                    <OPTION value=4>4��(48��)</OPTION> <OPTION    
                    value=5>5��(60��)</OPTION> <OPTION value=6>6��(72��)</OPTION>    
                    <OPTION value=7>7��(84��)</OPTION> <OPTION    
                    value=8>8��(96��)</OPTION> <OPTION value=9>9��(108��)</OPTION>    
                    <OPTION value=10>10��(120��)</OPTION> <OPTION    
                    value=11>11��(132��)</OPTION> <OPTION    
                    value=12>12��(144��)</OPTION> <OPTION    
                    value=13>13��(156��)</OPTION> <OPTION    
                    value=14>14��(168��)</OPTION> <OPTION value=15    
                    selected>15��(180��)</OPTION> <OPTION    
                    value=16>16��(192��)</OPTION> <OPTION    
                    value=17>17��(204��)</OPTION> <OPTION    
                    value=18>18��(216��)</OPTION> <OPTION    
                    value=19>19��(228��)</OPTION> <OPTION    
                    value=20>20��(240��)</OPTION> <OPTION    
                    value=21>21��(252��)</OPTION> <OPTION    
                    value=22>22��(264��)</OPTION> <OPTION    
                    value=23>23��(276��)</OPTION> <OPTION    
                    value=24>24��(288��)</OPTION> <OPTION    
                    value=25>25��(300��)</OPTION> <OPTION    
                    value=26>26��(312��)</OPTION> <OPTION    
                    value=27>27��(324��)</OPTION> <OPTION    
                    value=28>28��(336��)</OPTION> <OPTION    
                    value=29>29��(348��)</OPTION> <OPTION    
                    value=30>30��(360��)</OPTION></SELECT> <BR>��������: <SELECT    
                  class=input onchange="this.form.in_ll.value=''" size=1    
                  name=in_zl> <OPTION value=0 selected>ס����ҵ����</OPTION>  
                    <OPTION>���������</OPTION></SELECT> <BR><INPUT type=radio onclick="choose(this.form)" value=1  
                  name=lw> ���� <INPUT type=radio onclick="choose(this.form)" CHECKED value=1 name=lw> ��������Ʒ��    
                </TD>   
                <TD class=td width=12 rowSpan=2>��<BR>��<BR>��<BR>��<BR>�� </TD>   
                <TD noWrap width=133 rowSpan=2>��&nbsp;&nbsp;��: <INPUT    
                  class=text onblur=sz(this) onfocus=select() size=8 name=in_ll>    
                  ��<BR>��&nbsp;&nbsp;��: <INPUT class=text onblur=sz(this)    
                  onfocus=select() size=8 name=in_m> ��<BR>�ܴ���: <INPUT class=text    
                  onblur=sz(this) onfocus=select() size=8 name=in_dk> Ԫ<BR>�����:    
                  <INPUT class=text id=125 value="<%=area%>" onblur=sz(this) onfocus=select()    
                  size=8 value=80 name=in_mj> M2</TD>   
                <TD class=td width=13 rowSpan=2>��<BR>��<BR>��<BR>ʽ </TD>   
                <TD noWrap width=247><FONT    
                  color=#0000ff>��¥���ܽ����㣺</FONT><BR><FONT color=#0000ff>¥���ܶ�:    
                  </FONT><INPUT class=text id=123 value="<%=price%>" onblur=sz(this)    
                  onfocus=select() size=10 value=500000 name=in_zs> <FONT    
                  color=#0000ff>Ԫ</FONT> <INPUT class=td onclick=js(this.form,1) type=button value=" �� �� " name=button>    
                </TD></TR></CENTER>   
              <CENTER>   
              <TR>   
                <TD noWrap width=247><FONT    
                  color=#0000ff>������¹����������㣺</FONT><BR><FONT color=#0000ff>�¹�����:    
                  </FONT><INPUT class=text id=124 onblur=sz(this)    
                  onfocus=select() size=10  name=in_yg> <FONT    
                  color=#0000ff>Ԫ</FONT> <INPUT class=td onclick=js(this.form,0) type=button value=" �� �� " name=button>    
                </TD></TR>   
              <TR>   
                <TD class=td colSpan=6><FONT    
                  style="FONT-SIZE: 1pt">&nbsp;</FONT></TD></TR>   
				   <TR>   
                <TD class=td align=middle width=16>˰<BR>��</TD>   
                <Td colSpan=5 align=left class=td>
                 ��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    
                  ˰: <INPUT class=text onfocus=this.form.reate1.select() size=10    
                  name=reate1 value=1.3> ��&nbsp;����������: <INPUT class=text    
                  onfocus=this.form.reate2.select() size=10 name=reate2 value=0.03>    
                  ��&nbsp;��ͬӡ��˰: <INPUT class=text    
                  onfocus=this.form.reate3.select() size=10 name=reate3 value=0.04>    
                  ��<BR>��&nbsp; ��&nbsp; ��: <INPUT class=text    
                  onfocus=this.form.charge1.select() size=10 name=charge1 value=100>Ԫ/��(���ݽ��׹������)&nbsp;Ȩ֤ӡ��˰:    
                  <INPUT class=text    
                  onfocus=this.form.charge2.select() size=10 name=charge2 value=5>Ԫ/��(���ݽ��׹������)
				  </TH></TR>   
              <TR>   
                <TD class=td align=middle width=16    
                rowSpan=3>��<BR>��<BR>��<BR>��</TD>   
                <TD width=154>¥���ܶ�: <INPUT class=text    
                  onfocus=this.form.in_zs.select() size=10 name=out_zs>    
                  Ԫ<BR>�¹����: <INPUT class=text onfocus=this.form.in_yg.select()    
                  size=10 name=out_yg> Ԫ</TD>   
                <TD colSpan=2>���ڸ���: <INPUT class=text    
                  onfocus=this.form.in_zs.select() size=10 name=out_sq>    
                  Ԫ<BR>��������: <INPUT class=text onfocus=this.form.in_zs.select()    
                  size=10 name=out_qs> ��</TD>   
                <TD class=td width=13    
                  rowSpan=3>��<BR>��<BR>��<BR>Ʒ<BR>��<BR>Ӧ<BR>��<BR>˰<BR>��</TD>   
                <TD noWrap width=247 rowSpan=3>��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    
                  ˰: <INPUT class=text onfocus=this.form.in_zs.select() size=10    
                  name=out_s1> Ԫ(��˰����)<BR>����������: <INPUT class=text    
                  onfocus=this.form.in_zs.select() size=10 name=out_s2>    
                  Ԫ(���׹������)<BR>��ͬӡ��˰: <INPUT class=text    
                  onfocus=this.form.in_zs.select() size=10 name=out_s3>    
                  Ԫ(˰���)<BR>��&nbsp; ��&nbsp; ��: <INPUT class=text    
                  onfocus=this.form.charge11.select() size=4 name=charge11 >Ԫ/��(���ݽ��׹������)<BR>Ȩ֤ӡ��˰:    
                  <INPUT class=text    
                  onfocus=this.form.charge12.select() size=4 name=charge12 v>Ԫ/��(���ݽ��׹������)<BR>���������: <INPUT class=text    
                  onfocus=this.form.in_zs.select() size=10 name=out_s4>    
              Ԫ<BR></TD></TR>   
              <TR>   
                <TD width=154>�����ܶ�: <INPUT class=text    
                  onfocus=this.form.in_zs.select() size=10 name=out_dk>    
                  Ԫ<BR>��������: <INPUT class=text onfocus=this.form.in_zs.select()    
                  size=10 name=out_ll> ��</TD>   
                <TD colSpan=2>�����ܶ�: <INPUT class=text    
                  onfocus=this.form.in_zs.select() size=10 name=out_hk>    
                  Ԫ<BR>֧��Ϣ��: <INPUT class=text onfocus=this.form.in_zs.select()    
                  size=10 name=out_lx> Ԫ</TD></TR>   
              <TR>   
                <TD width=154>��ҵ���: <INPUT class=text    
                  onfocus=this.form.in_zs.select() size=10 name=out_mj> m2</TD>   
                <TD colSpan=2>ÿƽ����: <INPUT class=text    
                  onfocus=this.form.in_zs.select() size=10 name=out_dj> Ԫ</TD></TR>   
              <TR>   
                <TD class=td align=middle width=16>��<BR>�� </TD>   
                <TH colSpan=5><INPUT class=td onclick="window.close()" type=button value=�رռ����� name=button>    
<INPUT class=td type=reset value=����������� name=reset> </TH></TR>   
              <TR>   
                <TD colSpan=6>������ʹ��˵����<BR>1��������ҵ����������ѡ�����������ҵ�ĸ���Ҫ��<BR>2��Ȼ����<FONT    
                  color=#0000ff>¥���ܶ���</FONT>���������¥��۰������������<FONT    
                  color=#0000ff>�¹�������</FONT>�������Լ����¹�����������<BR>3����Ҳ�������Զ�������������һЩ����������Ȼ���ټ��㡣    
                </TD></TR></CENTER></TBODY></TABLE></FORM><BR></TD></TR></TBODY></TABLE></TD></TR>   
  <TR align=middle>   
    <TD  width="700">   
     </font></SPAN></DIV><!-- #EndLibraryItem --></DIV></TD></TR></TBODY></TABLE></BODY></HTML>  
