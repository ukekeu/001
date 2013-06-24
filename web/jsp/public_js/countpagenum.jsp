<%
//取得页数
 String Strpageno=request.getParameter("pageno");
 //第1页
 int pageno=1;
 if(Strpageno!=null && Strpageno.length()>0){
      pageno=Integer.parseInt(Strpageno);
 }
 
//取得一页显示的行数
String StrpageSize=request.getParameter("pagesize");
int pageSize=22;	
if(StrpageSize!=null && StrpageSize.length()>0){
  pageSize=Integer.parseInt(StrpageSize);
}   
//上一页
int previous=pageno-1;
//下一页
int next=pageno+1;
//开始记录数
int startnum=pageno*pageSize;
//
int prenum=previous*pageSize;
//取得行数的sql;
String sqlcount="select 0";
int pagecount=0;
%>