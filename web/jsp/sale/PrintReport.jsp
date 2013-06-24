<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="writefile" scope="page" class="ConnDatabase.WriteToExcelBean"/>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="../class/mad.css" >
<title>打印报表</title>

</head>

<%
String para=request.getParameter("para");
String type=request.getParameter("type");
String out1=China.getParameter(request,"out1") ;

String out2=request.getParameter("out2");
int sumprice=0;
int countnum=0;
String px="";
if (!out1.equals("")){
   px=request.getParameter("px");
    
   px=" order by "+out1+" "+px;

}   

   String conStr=request.getParameter("tablename");
   String sql="";
   String  [] FildsName=request.getParameterValues("out4");
   int arrylen=FildsName.length;
   String strFiledE[]=new String[arrylen];
   String strFiledC[]=new String[arrylen];
   for (int i=0;i<arrylen;i++){
       FildsName[i]=new String(FildsName[i].getBytes("ISO8859_1"),"GBK");
	   strFiledC[i]=FildsName[i].substring(FildsName[i].indexOf("-")+1);
	   strFiledE[i]=FildsName[i].substring(0,FildsName[i].indexOf("-"));
   }
  
   sql="";
   String titlename="";
   for (int j=0;j<arrylen;j++){
	 sql=sql+strFiledE[j]+",";
	 titlename=titlename+strFiledC[j]+",";
   }
   sql=sql.substring(0,sql.lastIndexOf(","));
   titlename=titlename.substring(0,titlename.lastIndexOf(","));

   if (out2!=null){
      if (!px.equals("")){px=" order by "+out2+","+px.substring(px.indexOf("by")+2);}
	  else{px=" order by  "+out2;}
   }

  //String groupbyStr="select "+out2+" from "+conStr +" group by "+out2;


   //  sql="select "+sql+" from "+conStr+px;
   sql="select Dept,Item,Standard,DateC from ChangeCode";
   out2= "Dept,Item,Standard,DateC";
   out.print("<table border=1  width='120%' cellspacing='0'  cellpadding='0' class='tablefill'><tr align=center>");
   for (int j=0;j<arrylen;j++){
     out.print("<td>");
	 out.print(""+strFiledC[j]+"");
	 out.print("</td>");
   }
   out.print("</tr>");
  
  String createfile="/test.csv";
  String file=writefile.WriteToExcel(ViewBean,titlename,sql,createfile); 
  out.print("系统已自动生成了EXCEL文件<a href='d:/test.csv'>d:/test.csv</a>");

  StringTokenizer st22 = new StringTokenizer(out2,",") ;
  int count22 = st22.countTokens() ;
//if (out2.indexOf(",")<0){count22=0;}

  String[] sellers22 = new String[count22] ;
  int j22 = 0 ;
  
   
   String sqlcount="select count(*) as num from "+conStr;
   ResultSet rs3=ViewBean.executeQuery(sqlcount);
   int ResultCount=0;
   if (rs3.next()){ResultCount=rs3.getInt("num");}
   rs3.close();
   ResultSetMetaData rsmd=null;
   int numCols=0;
 	try{
     ResultSet rs2=ViewBean.executeQuery(sql);

	 rsmd=rs2.getMetaData();
	 numCols=rsmd.getColumnCount();
   	// String strResult[]=new String[numCols*ResultCount];//计算总的元素个数(一维数组)
	 String strResult[][]=new String[ResultCount][numCols];//设定二维数组大小。保存记录　
	 String strSameCol[][]=new String[ResultCount][numCols];//设定二维数组大小。保存每数据项相同的的数目。
	 int i=0;
     String namecheck="";
	 String StrValue="";
	 int row=0;
	 int FieldNum=0;
   FieldNum=0;
   String aa="";
	 while (rs2.next()){
	//save value to arry
		
		for (int ii=0;ii<numCols;ii++){
		  StrValue=rs2.getString(strFiledE[ii]);
	      strResult[row][ii]=StrValue;
		  }
		  row+=1;
		} 
     String samestr="";
	 String builstr="";
	 String samestr1="";
	 int FieldNum1=0;


	for (int ii=0;ii<count22;ii++){//count22
	   FieldNum=0;
	   FieldNum1=0;
	   aa="";
	   builstr="";
	  
	   for (int jj=0;jj<ResultCount;jj++ )	{
		    if (!(strResult[jj][0].equals(aa))){
  	             
				 if (!aa.equals("")){samestr=samestr+aa+"-"+String.valueOf(FieldNum)+"-";}
				 FieldNum=1;
				 aa=strResult[jj][0]; 
		   }else{FieldNum+=1;}
		   if (count22>1){
		   if (!(strResult[jj][1].equals(builstr))){
        	
		     if (!builstr.equals("")){samestr1=samestr1+strResult[jj-1][0]+builstr+"-"+String.valueOf(FieldNum1)+"-";}
               
				 FieldNum1=1;
				 builstr=strResult[jj][1]; 
		   }else{FieldNum1+=1;}
		
		  }
		} 
		
		samestr=samestr+aa+"-"+String.valueOf(FieldNum)+"-";
		samestr1=samestr1+builstr+"-"+String.valueOf(FieldNum1)+"-";
		//out.println(samestr1);
	}
	
	/*for (int ii=0;ii<count22;ii++){
	   for (int jj=0;jj<ResultCount;jj++ )	{
		out.println(strResult[jj][0]+strResult[jj][1]);
		}
}*/
	aa="";
	String rowspan="";
	String same="";
	String same1="";
	String aa1="";
	StringTokenizer st23;
	int count23=0;
	int count24=0;
	
	for (int j=0;j<ResultCount;j++){
	    out.print("<tr>");
		for (int ii=0;ii<numCols;ii++){
			 if (ii<count22){
			  if (!strResult[j][0].equals(aa)){
			     aa=strResult[j][0];
				  st22 = new StringTokenizer(samestr,"-") ;
                  count24 = st22.countTokens() ;
				  while (st22.hasMoreElements()) {
				     same = (String)st22.nextElement() ;
					 if (same.equals(strResult[j][0])){rowspan=(String)st22.nextElement();}
				}
		        out.print("<td rowspan="+rowspan+">");
           	    out.print(strResult[j][0]);
       		    out.print("</td>");
			  }
			  
			  if (count22>1){
			  if (!strResult[j][1].equals(aa1)){
			      aa1=strResult[j][1];
				  st23 = new StringTokenizer(samestr1,"-") ;
                  count23 = st23.countTokens() ;
				  while (st23.hasMoreElements()) {
				     same1 = (String)st23.nextElement() ;
					 if (same1.equals(strResult[j][0]+strResult[j][1])){rowspan=(String)st23.nextElement();}
				  }
		         out.print("<td rowspan="+rowspan+">");
           	     out.print(strResult[j][1]);
       		     out.print("</td>");
			 }
			 }
		    }else{
		      out.print("<td>");
           	  out.print(strResult[j][ii]);
       		  out.print("</td>");
	
		 } 
         }
        out.print("</tr>");
        }
 
  out.print("</table>");
}catch(Exception s){out.print(s.getMessage());out.println(sql);}
 java.text.DecimalFormat df2 = new java.text.DecimalFormat("###,###,###"); 
%>
	
	
<body >


</body>       
</html>       
