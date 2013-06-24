<input type=hidden name=sel>
<%
			      Sql="select  SectionNo,Region,Building from roomno group by SectionNo,Region,Building";
                 ResultSet Rs=ViewBean.executeQuery(Sql);
                 out.print("<script>");
                 out.print("var SecionCus=new Array();");
                 out.print("var Lost=new Array();");
                 out.print("var Build=new Array();");
                 int i1=0;
                 while (Rs.next()){
                 out.print("SecionCus["+String.valueOf(i1)+"]="+"\""+Rs.getString("SectionNo")+"\""+";");
                 out.print("Lost["+String.valueOf(i1)+"]="+"\""+getbyte(Rs.getString("Region"))+"\""+";");
                 out.print("Build["+String.valueOf(i1)+"]="+"\""+getbyte(Rs.getString("Building"))+"\""+";");
            	 i1++;
                }	 
            %> 
 function FindArry(){
 var i=1;
 var lost="";
    cleasele();
    document.cus.Loft.options[i]=new Option("","");
    for (var j=0;j<SecionCus.length;j++){
	 var secno=document.cus.SecNo.options[document.cus.SecNo.selectedIndex].value;
	 if (secno.indexOf("*")>=0)
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
	    document.cus.build.options[i]=new Option(Build[j],Build[j]);
		i++;
	} 
	}
   }
   function cleasele(){
    document.cus.Loft.length=0;
    document.cus.build.length=0;
   }	
   </script><br>
Ñ¡ÔñÆÚºÅ: <select name="Loft" OnChange="FindArry1();" style="width:100"></select><br>
Ñ¡Ôñ¶°ºÅ: <select name="build" style="width:100;" ></select>
		