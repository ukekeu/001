<%@ page contentType="text/html;charset=GBK" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML><HEAD><TITLE>　</TITLE>
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
		alert("\n\n请输入你的楼款总金额！\n\n")
		obj.in_zs.focus()
		return false
	}
	if(!fl&&((i_yg=obj.in_yg.value)=="")){
		alert("\n\n请输入你的月供款金额！\n\n")
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
	
	obj.out_zs.value=Math.round(i_zs*100)/100
	obj.out_sq.value=Math.round((i_zs-i_dk)*100)/100
	obj.out_dk.value=i_dk
	obj.out_ll.value=i_ll
	obj.out_qs.value=i_m
	obj.out_yg.value=Math.round(i_yg*100)/100
	obj.out_hk.value=Math.round(i_hk*100)/100
	obj.out_lx.value=Math.round(i_lx*100)/100
	if((obj.out_mj.value=obj.in_mj.value)!="")obj.out_dj.value=Math.round(i_zs/obj.out_mj.value*100)/100
	if(obj.lw[1].checked){
		obj.out_s1.value=Math.round(i_zs*1.5)/100
		obj.out_s2.value=Math.round(i_zs*0.04)/100
		obj.out_s3.value=Math.round(i_zs*0.03)/100
		obj.out_s4.value=Math.round(i_zs*1.57)/100+105
	}else{
		obj.out_s1.value=Math.round(i_zs*1.5)/100
		obj.out_s2.value=Math.round(i_zs*0.25)/100
		obj.out_s3.value=Math.round(i_zs*0.03)/100
		obj.out_s4.value=Math.round(i_zs*1.78)/100+105
	}

}

function find(obj){
	if(obj.out_dj.value!=""){
		window.open("/building1/area.asp?jj="+obj.out_dj.value,"")
	}else{
		alert("\n\n本查询是用每平方米的价格为查询条件的，\n\n所以请计算出每平米价格后再查询！\n\n")
	}
}
</SCRIPT>

<META http-equiv=Content-Type content="text/html; charset=GBK"><LINK 
href="count.files/c1.css" type=text/css rel=stylesheet>
<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY link=#666666 bgColor=#ffffff leftMargin=0 topMargin=0>
<TABLE class=p1 cellSpacing=0 cellPadding=0 width=777 align=center border=1><!-- fwtable fwsrc="首页2.png" fwbase="title.gif" fwstyle="Dreamweaver" fwdocid = "742308039" fwnested="0" -->
  <TBODY>
  <TR>
    <TD><IMG height=1 src="count.files/spacer.gif" width=151 border=0></TD>
    <TD><IMG height=1 src="count.files/spacer.gif" width=626 border=0></TD>
    <TD><IMG height=1 src="count.files/spacer.gif" width=1 border=0></TD></TR>
  <TR>
    <TD rowSpan=2><img border="0" src="../picture/banner_3.gif" width="100%" height="79"></TD>
    <TD align=middle height=2>
      <TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR>
          <TD align=right width="78%" height=2></TD>
          <TD align=right width="22%" height=2>
          </TD></TR></TBODY></TABLE></TD>
    <TD height=2><IMG height=67 src="count.files/spacer.gif" width=1 
    border=0></TD></TR>
  <TR>
    <TD height=2></TD>
    <TD height=2><IMG height=20 src="count.files/spacer.gif" width=1 
    border=0></TD></TR>
  <TR>
    <TD colSpan=2 height=2><IMG height=9 src="count.files/title_r3_c1.gif" 
      width=777 border=0 name=title_r3_c1></TD>
    <TD height=2><IMG height=9 src="count.files/spacer.gif" width=1 
    border=0></TD></TR></TBODY></TABLE>
<TABLE cellSpacing=0 cellPadding=0 width=777 align=center border=0>
  <TBODY>
  <TR>
    <TD align=middle width="82%" bgColor=#ffcc33 height=2>
      　</TD></TR>
  <TR>
    <TD vAlign=top align=middle width="82%" height=9>
      <TABLE borderColor=#f0f4f8 width=777 border=0>
        <TBODY>
        <TR>
          <TD vAlign=top align=middle height=14>
            <FORM action="" method=post>
            <TABLE cellPadding=0 width="99%" border=0>
              <TBODY>
              <TR align=right>
                <TD align=left height=4><SPAN class=p1><FONT 
                  color=#666666>当前位置： </FONT></SPAN><SPAN class=p1a><A  
                  href="http://www.gzcentaline.com.cn/zhiye/index.asp">嘉码</A><A 
                  href="http://www.gzcentaline.com.cn/zhiye/index.asp">置业</A></SPAN><SPAN 
                  class=p1><FONT color=#666666> &gt;&gt; </FONT></SPAN><SPAN   
                  class=p1a><A   
                  href="http://www.gzcentaline.com.cn/count/index.asp"></A></SPAN><SPAN   
                  class=p1><FONT   
            color=#666666>买楼计算器</FONT></SPAN></TD></TR></TBODY></TABLE>  
            <TABLE cellSpacing=0 cellPadding=0 width=690 border=0>  
              <TBODY>  
              <TR align=middle>  
                <TD height=23 width="688">  
                  <p align="center"><B class=p2><font color="#009900">嘉码J3售楼系统计算器<FONT color=#ffffff>  
                  买 楼 计 算   
            器</FONT></font></B></p>  
                </TD></TR></TBODY></TABLE>  
            <TABLE class=p1 cellSpacing=0 borderColorDark=#ffffff cellPadding=5   
            width=649 bgColor=#fffbe8 borderColorLight=#ffcc00 border=1>  
              <CENTER>  
              <TBODY>  
              <TR>  
                <TD class=td align=middle width=16   
                  rowSpan=2>物<BR>业<BR>基<BR>本<BR>资<BR>料 </TD>  
                <TD noWrap width=154 rowSpan=2>按揭成数: <SELECT class=input   
                  size=1 name=in_cs> <OPTION value=9>9成</OPTION> <OPTION   
                    value=8>8成</OPTION> <OPTION value=7 selected>7成</OPTION>   
                    <OPTION value=6>6成</OPTION> <OPTION value=5>5成</OPTION>   
                    <OPTION value=4>4成</OPTION> <OPTION value=3>3成</OPTION>   
                    <OPTION value=2>2成</OPTION> <OPTION   
                  value=10>10成</OPTION></SELECT> <BR>按揭年数: <SELECT class=input   
                  onchange="this.form.in_m.value=''" size=1 name=in_year>   
                    <OPTION value=1>1年(12期)</OPTION> <OPTION   
                    value=2>2年(24期)</OPTION> <OPTION value=3>3年(36期)</OPTION>   
                    <OPTION value=4>4年(48期)</OPTION> <OPTION   
                    value=5>5年(60期)</OPTION> <OPTION value=6>6年(72期)</OPTION>   
                    <OPTION value=7>7年(84期)</OPTION> <OPTION   
                    value=8>8年(96期)</OPTION> <OPTION value=9>9年(108期)</OPTION>   
                    <OPTION value=10>10年(120期)</OPTION> <OPTION   
                    value=11>11年(132期)</OPTION> <OPTION   
                    value=12>12年(144期)</OPTION> <OPTION   
                    value=13>13年(156期)</OPTION> <OPTION   
                    value=14>14年(168期)</OPTION> <OPTION value=15   
                    selected>15年(180期)</OPTION> <OPTION   
                    value=16>16年(192期)</OPTION> <OPTION   
                    value=17>17年(204期)</OPTION> <OPTION   
                    value=18>18年(216期)</OPTION> <OPTION   
                    value=19>19年(228期)</OPTION> <OPTION   
                    value=20>20年(240期)</OPTION> <OPTION   
                    value=21>21年(252期)</OPTION> <OPTION   
                    value=22>22年(264期)</OPTION> <OPTION   
                    value=23>23年(276期)</OPTION> <OPTION   
                    value=24>24年(288期)</OPTION> <OPTION   
                    value=25>25年(300期)</OPTION> <OPTION   
                    value=26>26年(312期)</OPTION> <OPTION   
                    value=27>27年(324期)</OPTION> <OPTION   
                    value=28>28年(336期)</OPTION> <OPTION   
                    value=29>29年(348期)</OPTION> <OPTION   
                    value=30>30年(360期)</OPTION></SELECT> <BR>贷款种类: <SELECT   
                  class=input onchange="this.form.in_ll.value=''" size=1   
                  name=in_zl> <OPTION value=0 selected>住房商业贷款</OPTION> 
                    <OPTION>公积金货款</OPTION></SELECT> <BR><INPUT type=radio value=1 
                  name=lw> 外销 <INPUT type=radio CHECKED value=1 name=lw> 内销：商品房   
                </TD>  
                <TD class=td width=12 rowSpan=2>自<BR>定<BR>义<BR>条<BR>件 </TD>  
                <TD noWrap width=133 rowSpan=2>利&nbsp;&nbsp;率: <INPUT   
                  class=text onblur=sz(this) onfocus=select() size=8 name=in_ll>   
                  ‰<BR>期&nbsp;&nbsp;数: <INPUT class=text onblur=sz(this)   
                  onfocus=select() size=8 name=in_m> 月<BR>总贷款: <INPUT class=text   
                  onblur=sz(this) onfocus=select() size=8 name=in_dk> 元<BR>总面积:   
                  <INPUT class=text id=125 onblur=sz(this) onfocus=select()   
                  size=8 value=80 name=in_mj> ㎡ </TD>  
                <TD class=td width=13 rowSpan=2>计<BR>算<BR>方<BR>式 </TD>  
                <TD noWrap width=247><FONT   
                  color=#0000ff>按楼款总金额计算：</FONT><BR><FONT color=#0000ff>楼款总额:   
                  </FONT><INPUT class=text id=123 onblur=sz(this)   
                  onfocus=select() size=10 value=500000 name=in_zs> <FONT   
                  color=#0000ff>元</FONT> <INPUT class=td onclick=js(this.form,1) type=button value=" 计 算 " name=button>   
                </TD></TR></CENTER>  
              <CENTER>  
              <TR>  
                <TD noWrap width=247><FONT   
                  color=#0000ff>按你的月供款能力主算：</FONT><BR><FONT color=#0000ff>月供能力:   
                  </FONT><INPUT class=text id=124 onblur=sz(this)   
                  onfocus=select() size=10 value=3000 name=in_yg> <FONT   
                  color=#0000ff>元</FONT> <INPUT class=td onclick=js(this.form,0) type=button value=" 计 算 " name=button>   
                </TD></TR>  
              <TR>  
                <TD class=td colSpan=6><FONT   
                  style="FONT-SIZE: 1pt">&nbsp;</FONT></TD></TR>  
              <TR>  
                <TD class=td align=middle width=16   
                rowSpan=3>计<BR>算<BR>结<BR>果</TD>  
                <TD width=154>楼款总额: <INPUT class=text   
                  onfocus=this.form.in_zs.select() size=10 name=out_zs>   
                  元<BR>月供金额: <INPUT class=text onfocus=this.form.in_yg.select()   
                  size=10 name=out_yg> 元</TD>  
                <TD colSpan=2>首期付款: <INPUT class=text   
                  onfocus=this.form.in_zs.select() size=10 name=out_sq>   
                  元<BR>贷款期数: <INPUT class=text onfocus=this.form.in_zs.select()   
                  size=10 name=out_qs> 月</TD>  
                <TD class=td width=13   
                  rowSpan=3>购<BR>买<BR>商<BR>品<BR>房<BR>应<BR>缴<BR>税<BR>费</TD>  
                <TD noWrap width=247 rowSpan=3>契&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   
                  税: <INPUT class=text onfocus=this.form.in_zs.select() size=10   
                  name=out_s1> 元(财税部门)<BR>交易手续费: <INPUT class=text   
                  onfocus=this.form.in_zs.select() size=10 name=out_s2>   
                  元(交易管理机构)<BR>合同印花税: <INPUT class=text   
                  onfocus=this.form.in_zs.select() size=10 name=out_s3>   
                  元(税务局)<BR>登&nbsp; 记&nbsp; 费: 100元/件(房屋交易管理机构)<BR>权证印花税:   
                  5元/本(房屋交易管理机构)<BR>共所需费用: <INPUT class=text   
                  onfocus=this.form.in_zs.select() size=10 name=out_s4>   
              元<BR></TD></TR>  
              <TR>  
                <TD width=154>贷款总额: <INPUT class=text   
                  onfocus=this.form.in_zs.select() size=10 name=out_dk>   
                  元<BR>贷款利率: <INPUT class=text onfocus=this.form.in_zs.select()   
                  size=10 name=out_ll> ‰</TD>  
                <TD colSpan=2>还款总额: <INPUT class=text   
                  onfocus=this.form.in_zs.select() size=10 name=out_hk>   
                  元<BR>支付息款: <INPUT class=text onfocus=this.form.in_zs.select()   
                  size=10 name=out_lx> 元</TD></TR>  
              <TR>  
                <TD width=154>物业面积: <INPUT class=text   
                  onfocus=this.form.in_zs.select() size=10 name=out_mj> ㎡</TD>  
                <TD colSpan=2>每平方米: <INPUT class=text   
                  onfocus=this.form.in_zs.select() size=10 name=out_dj> 元</TD></TR>  
              <TR>  
                <TD class=td align=middle width=16>操<BR>作 </TD>  
                <TH colSpan=5><INPUT class=td onclick=find(this.form) type=button value=物业查询 name=button>   
<INPUT class=td type=reset value=清除所有内容 name=reset> </TH></TR>  
              <TR>  
                <TD colSpan=6>计算器使用说明：<BR>1、先在物业基本资料里选择好你所需物业的付款要求。<BR>2、然后在<FONT   
                  color=#0000ff>楼款总额栏</FONT>里填入你的楼款价按计算键；或在<FONT   
                  color=#0000ff>月供能力栏</FONT>里填上自己的月供款金额按计算键。<BR>3、你也可以在自定义的条件里加入一些其它的资料然后再计算。   
                </TD></TR></CENTER></TBODY></TABLE></FORM><BR></TD></TR></TBODY></TABLE></TD></TR>  
  <TR align=middle>  
    <TD height=115>  
      <DIV align=center>  
      <HR width="100%" color=#ff9900 noShade SIZE=1>  
<!-- #BeginLibraryItem "/Library/bottom.lbi" -->  
      <TABLE cellSpacing=0 cellPadding=0 align=center border=0>  
        <TBODY>  
        <TR>  
          <TD>  
            <SCRIPT language=JavaScript1.1   
            src="count.files/show_pagebanner.htm"></SCRIPT>  
          </TD></TR></TBODY></TABLE>  
      <DIV align=center><BR></DIV>  
      <DIV align=center><font color="#000000"><SPAN class=p1>深圳市嘉码网络信息技术有限公司 
        &copy;版权所有<BR><BR>E-mail:</SPAN></font><SPAN class=p1> <A href="mailto:gzcentaline@21cn.com"><font color="#000000">szoffice</font></A><A href="mailto:gzcentaline@21cn.com"><FONT  
      color=#000000><FONT color=#666666>@</FONT>jamait</FONT><FONT color=#666666><FONT  
      color=#000000>.com</FONT><BR></FONT></A><FONT color=#666666><FONT  
      color=#000000>联系电话：</FONT>(深圳)</FONT><FONT  
      color=#000000><FONT color=#666666>0</FONT>755<FONT color=#666666>-</FONT></FONT><font color="#666666">6946200</font><FONT  
      color=#000000> 　传真：0755-6946221 　邮编：518054</FONT></SPAN></DIV> 
      <DIV align=center><SPAN class=p1><font color="#000000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        (广州)020-38891898&nbsp;&nbsp; 传真：0755-6946221 　邮编：510620<BR></font></SPAN></DIV><!-- #EndLibraryItem --></DIV></TD></TR></TBODY></TABLE></BODY></HTML> 
