 
 
<% 
String SectionS = (String)session.getAttribute("SectionList");//setpopedom.getSectionlist(); //有权使用楼盘编码  
String s_sec1=(String)session.getAttribute("secno");
 
if (s_sec1.indexOf(",")<0)s_sec1="'"+s_sec1+"'";

String defaultNo="";
String SecNo="";
try{
    defaultNo=(String)session.getAttribute("defaultNo");
}catch(Exception s){
}
if ( defaultNo == null ) {
    defaultNo="";//如何用户未设置默认楼盘，则显示用户选中或所有楼盘的楼栋
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
