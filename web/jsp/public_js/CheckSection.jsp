 
 
<% 
String SectionS = (String)session.getAttribute("SectionList");//setpopedom.getSectionlist(); //��Ȩʹ��¥�̱���  
String s_sec1=(String)session.getAttribute("secno");
 
if (s_sec1.indexOf(",")<0)s_sec1="'"+s_sec1+"'";

String defaultNo="";
String SecNo="";
try{
    defaultNo=(String)session.getAttribute("defaultNo");
}catch(Exception s){
}
if ( defaultNo == null ) {
    defaultNo="";//����û�δ����Ĭ��¥�̣�����ʾ�û�ѡ�л�����¥�̵�¥��
}
if (!defaultNo.equals(""))
{
    SectionS=defaultNo;
    SecNo=defaultNo;
}
 
String FindWhere="";
if ( !SecNo.equals("") ) { 
     FindWhere=" where SerialNo='"+SecNo+"'";
}else{
    FindWhere=" where SerialNo in("+SectionS+")";
}

 
%>
