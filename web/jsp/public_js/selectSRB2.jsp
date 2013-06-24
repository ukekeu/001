<tr>
             
			    <td width="557" valign="top" bgcolor="#96C7D1">&nbsp;Â¥ÅÌ&nbsp;&nbsp;&nbsp;<select name="SecNo" OnChange="FindArry();">
                    <option value=""></option>
					<%
			    String SectionS=(String)session.getAttribute("Section");		
               String  Sql="select SerialNo,Name from Section where SerialNo in("+SectionS+")";
               ResultSet Rs1=ViewBean.executeQuery(Sql);
               while (Rs1.next()){
			       String sno=Rs1.getString("SerialNo");
			       String sna=getbyte(Rs1.getString("Name"));
	               %>
                   <option value=<%=sno+"*"+sna %>><%=sna %></option>
              <%}Rs1.close();%>
               </select>
			   <%
			      Sql="select  SectionNo,Region,Building from roomno group by SectionNo,Region,Building";
                 ResultSet Rs=ViewBean.executeQuery(Sql);
                 out.print("<script>");
                 out.print("var SecionCus=new Array();");
                 out.print("var Lost=new Array();");
                 out.print("var Build=new Array();");
                 int i=0;
                 while (Rs.next()){
                 out.print("SecionCus["+String.valueOf(i)+"]="+"\""+getbyte(Rs.getString("SectionNo"))+"\""+";");
                 out.print("Lost["+String.valueOf(i)+"]="+"\""+getbyte(Rs.getString("Region"))+"\""+";");
                 out.print("Build["+String.valueOf(i)+"]="+"\""+getbyte(Rs.getString("Building"))+"\""+";");
            	 i=i+1;
                }	 
            %> 
 function FindArry(){
 var i=1;
 var lost="";
    cleasele();
    document.cus.Loft.options[i]=new Option("","");
    for (var j=0;j<SecionCus.length;j++){
	 var secno=document.cus.SecNo.options[document.cus.SecNo.selectedIndex].value;
	 secno=secno.substring(0,secno.indexOf("*"));
	 if (secno==SecionCus[j]){
	    document.cus.sel.value=secno;
		//alert(document.cus.Loft.options[0]);
		if (lost!=Lost[j]){
		document.cus.Loft.options[i]=new Option(Lost[j],Lost[j]);
	    lost=Lost[j];
		i++;
		}
	} 
	
	}
   }
   function FindArry1(){
   var i=1;
    for (var j=0;j<SecionCus.length;j++){
	 secno=document.cus.sel.value;
	 if (secno==SecionCus[j]){
	    document.cus.Building.options[i]=new Option(Build[j],Build[j]);
		i++;
	} 
	}
   }
   function cleasele(){
    document.cus.Loft.length=0;
    document.cus.Building.length=0;
   }	
   </script>
		&nbsp;ÇøºÅ<select name="Loft" OnChange="FindArry1();">  </select>&nbsp;¶°ºÅ<select name="Building"></select>