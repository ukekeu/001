<%
//ȡ��ҳ��
 String Strpageno=request.getParameter("pageno");
 //��1ҳ
 int pageno=1;
 if(Strpageno!=null && Strpageno.length()>0){
      pageno=Integer.parseInt(Strpageno);
 }
 
//ȡ��һҳ��ʾ������
String StrpageSize=request.getParameter("pagesize");
int pageSize=22;	
if(StrpageSize!=null && StrpageSize.length()>0){
  pageSize=Integer.parseInt(StrpageSize);
}   
//��һҳ
int previous=pageno-1;
//��һҳ
int next=pageno+1;
//��ʼ��¼��
int startnum=pageno*pageSize;
//
int prenum=previous*pageSize;
//ȡ��������sql;
String sqlcount="select 0";
int pagecount=0;
%>