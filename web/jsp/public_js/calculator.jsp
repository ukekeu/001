<%@ page contentType="text/html;charset=GBK" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE></TITLE>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<META content="MSHTML 6.00.2462.0" name=GENERATOR>
<STYLE type=text/css>A:hover {
	FONT-SIZE: 10.5pt; COLOR: red; TEXT-DECORATION: underline
}
.a1 {
	FONT-SIZE: 9pt; LINE-HEIGHT: 14pt; FONT-FAMILY: "����"
}
.a3 {
	FONT-SIZE: 9pt; COLOR: #993300; LINE-HEIGHT: 12pt
}
.a2 {
	FONT-WEIGHT: bold; FONT-SIZE: 10.5pt; COLOR: #ff3300; FONT-FAMILY: "����"
}
A {
	FONT-SIZE: 10.5pt
}
</STYLE>
</HEAD>
<BODY bgColor=#e1f4e3 leftMargin=0 topMargin=0><SPAN class=tt3></SPAN><SPAN 
class=tt1></SPAN><BR>

                  <SCRIPT language=JavaScript>
function runjs(obj){

{if(obj.t12.value==""||!(bj=parseFloat(obj.t12.value)))
       bj=parseFloat(obj.T1.value)*parseInt(obj.D3.options[obj.D3.selectedIndex].value)*0.1
       else
       bj=parseFloat(obj.t12.value)}

{if(obj.t10.value==""||!(qs=parseInt(obj.t10.value)))

qs=parseInt(obj.D2.options[obj.D2.selectedIndex].value)*12;

if(obj.t9.value==""||!(lx=parseFloat(obj.t9.value)))

{if(qs<72)lx=parseFloat(obj.r1.value);

if(qs>72&&qs<720)lx=parseFloat(obj.r2.value);


}

yg=(bj*lx/1000*Math.pow(1+lx/1000,qs))/(Math.pow(1+lx/1000,qs)-1);

ze=yg*qs;

lxze=ze-bj;

obj.j1.value=bj
obj.j2.value=lx
obj.j3.value=qs
obj.j4.value=Math.round(yg*100,5)/100
obj.j5.value=Math.round(lxze*100,5)/100
}

}
function WriteTo(obj){
   var Year=obj.D2.options[obj.D2.selectedIndex].value;
   var monthmoney="";
   if (Year==10) monthmoney=obj.j4.value;
   if (Year==15) monthmoney=obj.j4.value;
   if (Year==20) monthmoney=obj.j4.value;
   if (Year==30) monthmoney=obj.j4.value;
   var aa=eval("opener.document.cus.MONTH"+Year);
   if (aa){
   aa.value=monthmoney;
   opener.document.cus.AJMONEY.value=obj.j1.value;
   }
}
</SCRIPT>

                  <FORM>
                  <DIV align=center>
                  <CENTER>
                  
                  <TABLE 
                  style="BORDER-RIGHT: rgb(192,192,192) dashed; BORDER-BOTTOM: rgb(128,128,128) dashed" 
                  cellSpacing=0 borderColorDark=#ffffff cellPadding=0 
                  bgColor=#ffffd7 borderColorLight=#808080 border=1>
                    <TBODY>
                    <TR>
                      <TD colSpan=2 height=40>
                       </TD></TR>
                    <TR align=middle>
                      <TD width=200>
                        <DIV align=center>
                        <CENTER>
                        <TABLE height=16 cellSpacing=0 cellPadding=0 width="85%" 
                        border=0>
                          <TBODY>
                          <TR>
                            <TD align=left width="32%" height=9><FONT 
                              face=����><SPAN 
                              style="FONT-SIZE: 9pt; FONT-FAMILY: ����">¥���ܶ</SPAN></FONT></TD>
                            <TD width="68%" height=9><FONT color=#800000 
                              size=2><INPUT class=font id=123 
                              style="FONT-SIZE: 10pt" size=9 value=<%=request.getParameter("money") %>
                              name=T1> </FONT><SPAN 
                              style="FONT-SIZE: 9pt; FONT-FAMILY: ����"><FONT 
                              size=2>Ԫ</FONT></SPAN></TD></TR>
                          <TR>
                            <TD align=left width="42%" height=4><FONT 
                              face=����><SPAN 
                              style="FONT-SIZE: 9pt; FONT-FAMILY: ����">���ҳ�����</SPAN></FONT></TD>
                            <TD width="58%" height=4><FONT color=#800000 
                              size=2><SELECT size=1 name=D3> <OPTION value=9 
                                selected>9��</OPTION> <OPTION value=8>8��</OPTION> 
                                <OPTION value=7>7��</OPTION> <OPTION 
                                value=6>6��</OPTION> <OPTION value=5>5��</OPTION> 
                                <OPTION value=4>4��</OPTION> <OPTION 
                                value=3>3��</OPTION> <OPTION value=2>2��</OPTION> 
                                <OPTION value=10>10��</OPTION></SELECT> 
                          </FONT></TD></TR>
                          <TR>
                            <TD align=left width="42%" height=3><FONT 
                              face=����><SPAN 
                              style="FONT-SIZE: 9pt; FONT-FAMILY: ����">���������� 
                              </SPAN></FONT></TD>
                            <TD width="58%" height=3><FONT color=#800000 
                              size=2><SELECT class=font id=213 
                              style="FONT-SIZE: 10pt" size=1 name=D2> <OPTION 
                                value=2 selected>2��(24��)</OPTION> <OPTION 
                                value=3>3��(36��)</OPTION> <OPTION 
                                value=4>4��(48��)</OPTION> <OPTION 
                                value=5>5��(60��)</OPTION> <OPTION 
                                value=6>6��(72��)</OPTION> <OPTION 
                                value=7>7��(84��)</OPTION> <OPTION 
                                value=8>8��(96��)</OPTION> <OPTION 
                                value=9>9��(108��)</OPTION> <OPTION 
                                value=10>10��(120��)</OPTION> <OPTION 
                                value=11>11��(132��)</OPTION> <OPTION 
                                value=12>12��(144��)</OPTION> <OPTION 
                                value=13>13��(156��)</OPTION> <OPTION 
                                value=14>14��(168��)</OPTION> <OPTION 
                                value=15>15��(180��)</OPTION> <OPTION 
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
                                value=30>30��(360��)</OPTION></SELECT> 
                          </FONT></TD></TR></TBODY></TABLE></CENTER></DIV></TD>
                      <TD width=222>
                        <DIV align=center>
                        <CENTER>
                        <TABLE cellSpacing=0 cellPadding=0 width="95%" 
                          border=0><TBODY>
                          <TR>
                            <TD width="100%" colSpan=2 height=25><SPAN 
                              style="FONT-SIZE: 9pt; FONT-FAMILY: ����"><B>&nbsp;��������</B>��&nbsp; 
                              </SPAN></TD></TR>
                          <TR>
                            <TD width="31%" height=30>
                              <DIV align=right>
                              <P><SPAN 
                              style="FONT-SIZE: 9pt; FONT-FAMILY: ����">2-5 
                              �꣺</SPAN></P></DIV></TD>
                            <TD width="69%" height=30><SPAN 
                              style="FONT-SIZE: 9pt; FONT-FAMILY: ����"><INPUT 
                              class=font style="FONT-SIZE: 10pt" size=10 
                              value=4.425 name=r1> </SPAN></TD></TR>
                          <TR>
                            <TD width="31%" height=30>
                              <DIV align=right>
                              <P><SPAN 
                              style="FONT-SIZE: 9pt; FONT-FAMILY: ����">6-30�꣺</SPAN></P></DIV></TD>
                            <TD width="69%" height=30><SPAN 
                              style="FONT-SIZE: 9pt; FONT-FAMILY: ����"><INPUT 
                              class=font style="FONT-SIZE: 10pt" size=10 
                              value=4.650 name=r2> 
                        </SPAN></TD></TR></TBODY></TABLE></CENTER></DIV></TD></TR>
                    <TR align=middle>
                      <TD vAlign=top width=229>�� 
                        <DIV align=center>
                        <CENTER>
                        <P><FONT size=2><SPAN 
                        style="FONT-SIZE: 9pt; FONT-FAMILY: ����"><B>�Զ�����㣺</B></SPAN></FONT></P></CENTER></DIV>
                        <DIV align=center>
                        <CENTER>
                        <TABLE cellSpacing=0 cellPadding=0 width="95%" 
                          border=0><TBODY>
                          <TR>
                            <TD width="42%"><FONT size=2><SPAN 
                              style="FONT-SIZE: 9pt; FONT-FAMILY: ����">�����ܶ</SPAN></FONT></TD>
                            <TD width="58%"><FONT size=2><SPAN 
                              style="FONT-SIZE: 9pt; FONT-FAMILY: ����"><INPUT 
                              class=font size=9 name=t12> Ԫ</SPAN></FONT></TD></TR>
                          <TR>
                            <TD width="42%"><FONT size=2><SPAN 
                              style="FONT-SIZE: 9pt; FONT-FAMILY: ����">��&nbsp;&nbsp;&nbsp; 
                              �ʣ�</SPAN></FONT></TD>
                            <TD width="58%"><FONT size=2><SPAN 
                              style="FONT-SIZE: 9pt; FONT-FAMILY: ����"><INPUT 
                              class=font size=9 name=t9> ��</SPAN></FONT></TD></TR>
                          <TR>
                            <TD width="42%"><FONT size=2><SPAN 
                              style="FONT-SIZE: 9pt; FONT-FAMILY: ����">��&nbsp;&nbsp;&nbsp; 
                              ����</SPAN></FONT></TD>
                            <TD width="58%"><FONT color=#800000 size=2><INPUT 
                              class=font size=9 name=t10> </FONT><FONT 
                              size=2><SPAN 
                              style="FONT-SIZE: 9pt; FONT-FAMILY: ����">��</SPAN></FONT></TD></TR></TBODY></TABLE></CENTER></DIV></TD>
                      <TD width=222>
                        <TABLE height=38 cellSpacing=0 cellPadding=0 width="95%" 
                        border=0>
                          <TBODY>
                          <TR>
                            <TD width="100%" height=38>
                              <DIV align=center>
                              <CENTER>
                              <P><FONT color=#800000 size=2><INPUT class=font style="FONT-SIZE: 9pt; FONT-FAMILY: ����" onclick=runjs(this.form) type=button value=����> 
                              &nbsp; <INPUT class=font style="FONT-SIZE: 10pt; FONT-FAMILY: ����" type=reset value=���> &nbsp; <INPUT class=font style="FONT-SIZE: 10pt; FONT-FAMILY: ����" type=button value=ȷ�� onclick="WriteTo(this.form);"> 
                              </FONT></P></CENTER></DIV></TD></TR></TBODY></TABLE>
                        <DIV align=center>
                        <CENTER>
                        <TABLE cellSpacing=0 cellPadding=0 width="95%" 
                          border=0><TBODY>
                          <TR>
                            <TD width="35%"><FONT size=2><SPAN 
                              style="FONT-SIZE: 9pt; FONT-FAMILY: ����">�����ܶ</SPAN></FONT></TD>
                            <TD align=middle width="69%"><FONT size=2><SPAN 
                              style="FONT-SIZE: 9pt; FONT-FAMILY: ����"><INPUT 
                              class=font size=13 name=j1> Ԫ</SPAN></FONT></TD></TR>
                          <TR>
                            <TD width="35%"><FONT size=2><SPAN 
                              style="FONT-SIZE: 9pt; FONT-FAMILY: ����">�������ʣ�</SPAN></FONT></TD>
                            <TD align=middle width="69%"><FONT size=2><SPAN 
                              style="FONT-SIZE: 9pt; FONT-FAMILY: ����"><INPUT 
                              class=font size=13 name=j2> ��</SPAN></FONT></TD></TR>
                          <TR>
                            <TD width="35%"><FONT size=2><SPAN 
                              style="FONT-SIZE: 9pt; FONT-FAMILY: ����">����������</SPAN></FONT></TD>
                            <TD align=middle width="69%"><FONT size=2><SPAN 
                              style="FONT-SIZE: 9pt; FONT-FAMILY: ����"><INPUT 
                              class=font size=13 name=j3> ��</SPAN></FONT></TD></TR>
                          <TR>
                            <TD width="35%"><FONT size=2><SPAN 
                              style="FONT-SIZE: 9pt; FONT-FAMILY: ����">�¹���</SPAN></FONT></TD>
                            <TD align=middle width="69%"><FONT size=2><SPAN 
                              style="FONT-SIZE: 9pt; FONT-FAMILY: ����"><INPUT 
                              class=font size=13 name=j4> Ԫ</SPAN></FONT></TD></TR>
                          <TR>
                            <TD width="35%"><FONT size=2><SPAN 
                              style="FONT-SIZE: 9pt; FONT-FAMILY: ����">֧��Ϣ�</SPAN></FONT></TD>
                            <TD align=middle width="69%"><FONT size=2><SPAN 
                              style="FONT-SIZE: 9pt; FONT-FAMILY: ����"><INPUT 
                              class=font size=13 name=j5> Ԫ</SPAN></FONT></TD></TR>
                          <TR>
                            <TD width="35%"><FONT color=#800000 size=2>&nbsp; 
                              </FONT></TD>
                            <TD 
                      width="69%"></TD></TR></TBODY></TABLE></CENTER></DIV></TD></TR></TBODY></TABLE></CENTER></DIV></FORM>
                  <DIV align=center>
                  <CENTER>
                  <SPAN 
class=a3></SPAN><SPAN class=a2></SPAN><BR></BODY></HTML>
