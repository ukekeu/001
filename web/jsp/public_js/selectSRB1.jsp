<tr > 
        <td width="40%"  align="left" height="23"  class=roomleft>&nbsp;Â¥&nbsp;&nbsp;&nbsp;&nbsp;ÅÌ</td>
        <td width="53%"  align="left" height="23"  class=roomright> 
          &nbsp;<select name="Section" style="border-style: solid; border-width: 1" OnChange="FindArry();">
           <option></option>
		    <%
     String SectionS=(String)session.getAttribute("Section");	
     String defaultNo=(String)session.getAttribute("defaultNo");	
	 if (defaultNo==null)defaultNo="";
	 if (!defaultNo.equals(""))SectionS="'"+defaultNo+"'";	
  	 String na="";
	 String no="";
     String  sql="select SerialNo,Name from Section where SerialNo in("+SectionS+")";
     ResultSet rs=ViewBean.executeQuery(sql);
     while (rs.next()){
		no=rs.getString("SerialNo");
		na=getbyte(rs.getString("Name"));
	    %> 
            <option value=<%=no+"*"+na %>><%=na %></option>
            <%}%>
			

          </select>
		  
        </td>
      </tr>
	<%rs.close();
     sql="select  SectionNo,Region,Building from roomno group by SectionNo,Region,Building";
     ResultSet Rs=ViewBean.executeQuery(sql);
     out.print("<script>");
     out.print("var SecionCus=new Array();");
     out.print("var Loft=new Array();");
	  out.print("var Build=new Array();");
      i=0;
     while (Rs.next()){
	  out.print("SecionCus["+String.valueOf(i)+"]="+"\""+getbyte(Rs.getString("SectionNo"))+"\""+";");
      out.print("Loft["+String.valueOf(i)+"]="+"\""+getbyte(Rs.getString("Region"))+"\""+";");
	  out.print("Build["+String.valueOf(i)+"]="+"\""+getbyte(Rs.getString("Building"))+"\""+";");
	 i=i+1;
    }	 
 %> 
 function FindArry(){
 var i=1;
 var loft="";
    cleasele();
    document.cus.Loft.options[i]=new Option("","");
    for (var j=0;j<SecionCus.length;j++){
	 var secno=document.cus.Section.options[document.cus.Section.selectedIndex].value;
	 secno=secno.substring(0,secno.indexOf("*"));
	 if (secno==SecionCus[j]){
	    document.cus.sel.value=secno;
		//alert(document.cus.Loft.options[0]);
		if (loft!=Loft[j]){
		document.cus.Loft.options[i]=new Option(Loft[j],Loft[j]);
	    loft=Loft[j];
		i++;
		}
	} 
	
	}
   }
   function FindArry1(){
   var i=1;
    var secno=document.cus.sel.value;
	var loft=document.cus.Loft.options[document.cus.Loft.selectedIndex].value;
	for (var j=0;j<SecionCus.length;j++){
	 if (secno==SecionCus[j]&&Loft[j]==loft){
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
	   <tr align="left" > 
	   <input type=hidden name=sel>
        <td width="40%" align="left"  height="14"  class=roomleft>&nbsp;Çø&nbsp;&nbsp;&nbsp;&nbsp;ºÅ</td>
        <td width="53%" align="left"  height="14"  class=roomright> 
        &nbsp;<select name="Loft" OnChange="FindArry1();">
		
          </select>
         <!-- <input type="text" name="Loft" size="20" style="border-style: solid; border-width: 1"  Onblur="toUpper(document.cus.Building);">-->
        </td>
      </tr>
      <tr align="left" > 
        <td width="40%" align="left"  height="14"  class=roomleft>&nbsp;¶°&nbsp;&nbsp;&nbsp;&nbsp;ºÅ</td>
        <td width="53%" align="left"  height="14"  class=roomright> 
          &nbsp;<select name="Building">
          </select>
		  <!--<input type="text" name="Building" size="20" style="border-style: solid; border-width: 1"  Onblur="toUpper(document.cus.Building);">-->
        </td>
      </tr>	