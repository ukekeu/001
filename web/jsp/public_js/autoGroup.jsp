<%
   String   strFiledN[]=new String[4];
   strFiledN[0]="Dept";
   strFiledN[1]="Item";
   strFiledN[2]="Standard";
   strFiledN[3]="DateC";

  StringTokenizer st22 = new StringTokenizer("Dept,Item,Standard,DateC",",") ;

  int count22 = st22.countTokens() ;
  String[] sellers22 = new String[count22] ;
  int j22 = 0 ;
   String sqlcount="select count(*) as num from ChangeCode";
   String sql="select Dept,Item,Standard,DateC from ChangeCode group by Dept,Item,Standard,DateC";
   ResultSet rs3=null;
  try{
    rs3=ViewBean.executeQuery(sqlcount);
   }
   catch(SQLException s){out.println("请检查你的条件是否正确");return;}
   int ResultCount=0;
   if (rs3.next()){ResultCount=rs3.getInt("num");}
   rs3.close();
   ResultSetMetaData rsmd=null;
  // DatabaseMetaData datatype=null;
   int numCols=count22;//与前arrylen一样都是保存字段数量
  
 	try{
     ResultSet rs2=ViewBean.executeQuery(sql);
	 rsmd=rs2.getMetaData();
	 String strResult[][]=new String[ResultCount][numCols];//设定二维数组大小。保存记录　
	 String strSameCol[][]=new String[ResultCount][numCols];//设定二维数组大小。保存每数据项相同的的数目。
	 String FieldType[]=new String[numCols];//设定一维数组，保存输出数据项的字段类型.
	 float TotalValues[]=new float[numCols];//设定一维数组，保存数字字段值的累计.
	 int Ftype=0;
	 //取字段类型
	 
	  for (int a=0;a<numCols;a++){
	   FieldType[a]=rsmd.getColumnTypeName(a+1);
	  }
	 
	
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
		  StrValue=rs2.getString(strFiledN[ii]);
	      strResult[row][ii]=getbyte(StrValue);
		  }
		  row+=1;
		} 
    String samestr="";
	 String builstr="";
	 String samestr1="";
	 int FieldNum1=0;

    HashMap hmap = new HashMap() ;
	String tempmap = "" ;
	for (int ii = 0; ii < count22; ii ++ ){  //count22 分组的个数
	   
	   FieldNum=0;
	   FieldNum1=0;
	   aa="";
	   builstr="";
	   tempmap = "" ;
	   
	   aa = (String) hmap.get("temp" + ii) ; // temp variable for ii coloumn
	   if (aa == null) {
	   		hmap.put("temp" + ii,"") ;
	   }
	   aa = (String) hmap.get("str" + ii) ;  //temp str for ii column
	   if (aa == null) {
	   		hmap.put("str" + ii,"") ;
	   }
	   aa = (String) hmap.get("count" + ii) ; //temp count for ii column 
	   if (aa == null) {
	   		hmap.put("count" + ii,"0") ;
	   }		
	   
	   for (int jj = 0;jj < ResultCount; jj ++ )	{
			String tempVar = (String) hmap.get("temp" + ii) ;
			String tempStr = "" ;
			String tempCount = "" ;
			String allBefore = "" ;
			int pp = 0 ;
			for (; pp < ii ; pp ++) {
				allBefore += strResult[jj][pp] ;
					
			}
			allBefore += "-" + strResult[jj][pp] ;
			if (!(allBefore.equals(tempVar))) {
  	              if (!tempVar.equals("")) {   //
				  		tempStr = (String) hmap.get("str" + ii) ; 
						tempCount = (String) hmap.get("count" + ii) ;
						String tempVar2 = tempVar.substring(tempVar.indexOf("-") + 1) ;
						tempStr += tempVar2 + "-" + tempCount + "-" ;
						hmap.put("str" + ii,tempStr) ;
				  }
				  hmap.put("count" + ii,"1") ;
				  hmap.put("temp" + ii,allBefore) ;
				  
		    } else { 
				String temp33 = (String) hmap.get("count" + ii) ;
				int temp44 = Integer.parseInt(temp33) + 1 ;
				hmap.put("count" + ii,String.valueOf(temp44)) ;
				
			}
			
			if (jj == (ResultCount - 1)) {
				String temp88 = (String) hmap.get("temp" + ii) ;
				String temp882 = temp88.substring(temp88.indexOf("-") + 1) ;
				String temp89 = (String) hmap.get("count" + ii) ;
				String temp90 = (String) hmap.get("str" + ii) ;
				hmap.put("str" + ii,temp90 + temp882 + "-" + temp89 + "-") ;
			}
	
		} // for 
		
	}
	
	for (int ii8=0; ii8 < count22; ii8++) {
		
		String temp110 = (String)hmap.get("str" + ii8) ;
		temp110 += "over" ;
		hmap.put("str" + ii8,temp110) ;

	}
	
	aa="";
	String rowspan="";
	String same="";
	String same1="";
	String aa1="";
	StringTokenizer st23;
	int count23=0;
	int count24=0;
	
	HashMap hmap2 = new HashMap() ;
	for (int gg = 0; gg < count22 ; gg ++) {
			hmap2.put("temp" + gg,"") ;
	}
	
	for (int j = 0; j < ResultCount; j ++) {
	    out.print("<tr align=center>");
		
		
		
		for (int gg = 0; gg < count22 ; gg ++) {
				String allBefore = "" ;
				int pp = 0 ;
				for (; pp < gg ; pp ++) {
					allBefore += strResult[j][pp] ;
					
				}
				allBefore += "-" + strResult[j][pp] ;
				
				String temp888 = (String) hmap2.get("temp" + gg) ;
				
				String caption = "" ;
				String temp999 = "" ;
				String count999 = "" ;
				if (!allBefore.equals(temp888)) {
				
					hmap2.put("temp" + gg, allBefore) ;
					
					temp999 = (String)hmap.get("str" + gg) ; 
			
					
					try {
						temp999 = temp999.substring(temp999.indexOf("-") + 1) ; // tempstr
					} catch(Exception e) {
						out.print(e.getMessage() + "11exception") ;
					}	
					try {
						count999 = temp999.substring(0,temp999.indexOf("-")) ;   //temp count
					} catch(Exception e) {
						out.print(e.getMessage() + "22exception") ;
					}	
					try {
						temp999 = temp999.substring(temp999.indexOf("-") + 1) ;
					} catch(Exception e) {
						out.print(e.getMessage() + "33exception") ;
					}	
					
					
					hmap.put("str" + gg,temp999) ;
					rowspan = count999 ;
					out.print("<td rowspan="+rowspan+">");
           	   		out.print(strResult[j][gg]);
       		   	    out.print("</td>");
				}
		}
		for (int ii = count22; ii < numCols; ii ++){
			  out.print("<td>");
           	  
			  if (FieldType[ii-count22].equals("numeric")||FieldType[ii-count22].equals("float")||FieldType[ii-count22].equals("int")||FieldType[ii-count22].equals("money"))
			    {TotalValues[ii-count22]+=Float.parseFloat(strResult[j][ii]);
       		    out.print(FormatD.getFloat(Float.parseFloat(strResult[j][ii]),2));
			   }else{
			   out.print(strResult[j][ii]);
			   }
			    out.print("</td>");
		}
        	out.print("</tr>");
        } // for
		 out.print("<tr><td colspan="+String.valueOf(count22)+">合计:</td>");
		 for (int ii = count22+1; ii < numCols; ii ++){
		   out.print("<td>");
		   if (TotalValues[ii-count22]>0)
		    out.print(FormatD.getFloat(TotalValues[ii-count22],2));
			else
			out.print("&nbsp;");
		   out.print("</td>");
		 }
		 out.print("</tr>");
  out.print("</table>");
}catch(Exception s){out.print(s.getMessage());out.println("error");}
 java.text.DecimalFormat df2 = new java.text.DecimalFormat("###,###,###"); 
%>
	
