<%@ page contentType="text/html;charset=GBK" %>
 <%@ page import="java.sql.*,java.util.*" %>
 <%@ include file="../public_js/checktime.jsp"%>
 <jsp:useBean id="userBean" scope="page" class="ConnDatabase.SDatabase" />
 <jsp:useBean id="smenu" scope="page" class="ConnDatabase.menu" />
  <%@ include file="../public_js/getByteOut.jsp"%>
  
<HTML><HEAD>
<title>主菜单</title>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<LINK href="../class/news.css" rel=stylesheet>
<title>楼栋树</title>
</head>
<SCRIPT language="JavaScript1.2" type="text/javascript"><!--
//-->
</SCRIPT>
<script language="JavaScript" src='../public_js/menu.js'></script>
<script language="javascript" src="../public_js/public.js"></script>
<body  topmargin="0" leftmargin="0"  oncontextmenu="return false" >
 
 <script>function open_close(tmp) {
			 	var divs = document.all.tags("DIV") ;
				for ( i = 0 ; i < divs.length ; i ++ ) {
				 		if (divs[i].id) {
						var tt = divs[i].id ;
						if (tt.indexOf("detail") > -1) {
						 
							if (tt == "detail" + tmp) 
								document.all.tags("DIV")[i].style.display = (document.all.tags("div")[i].style.display == "block")?"none":"block" ;
							else 
								document.all.tags("DIV")[i].style.display = "none" ;
						}
					}			
				}
				
			}	
 function open_close1(tmp,para) {
				 
				var divs = document.all.tags("td") ;
				 
				for ( i = 0 ; i < divs.length ; i ++ ) { 
			 
						var tt = divs[i].id ;
						 
						if (tt.indexOf("upto") > -1) {
						 
							if (tt == "upto" + tmp) 
								  divs[i].background='../images/new/Open.jpg';
							else 
								 divs[i].background="../images/new/Over.jpg";
								 
				 
					}			
				}
				
			}	
 </script>


<form action="" method="post" name="submitform" >
 
<TABLE cellSpacing=0 height="100%" cellPadding=0 width="100%" border=0> 
  <TR   width="100%">
  <td width="100%" background="../images/new/E_r14_c11.jpg" valign="top" align="center">
  <%String userid=(String)session.getAttribute("loginid"); 
String ip=(String)session.getAttribute("ip");
out.print(smenu.newLeftMenu(userid,ip)); %>
 </td>
 </tr>
 </table>
</form>

 <script language="JavaScript">
 
function OverArrow(arrow)
{
	if(this.sliding)
		return;		
	arrow.style.border="1 outset #ffffff";
}

function OutArrow(arrow)
{
	if(this.sliding)
		return;		
	arrow.style.border="0 none black";
}

function windowstate(values){

window.status="当前操作模块："+values;
}	
  function changesrc(s){
     thissrc=s.src;
	 thissrc=thissrc.substring(thissrc.length-9,thissrc.length);
	
	 if(thissrc=="plus4.gif"){
	    s.src="../images/minus.gif";
	 }else{
	   s.src="../images/plus4.gif";
	 }
   }
   </script>
  

<script language="JavaScript">
function para(uptown_id,building_id){
   model_name=document.all.model_name.value;
   document.all.uptownid.value=uptown_id;
   document.all.buildingid.value=building_id;
   other=document.all.other.value;
  
}
		  function  changeclassname(src,clrOver,clrIn){ 
             var td = document.all.tags("TD") ;
			 var tmp=src.id.substring(0,4);
			 if(tmp=="upto"){tmp2="buil";}else{tmp2="upto";}
			 for ( i = 0 ; i < td.length ; i ++ ) {
			 if (td[i].id) {
	     	      var tt = td[i].id ;
			      if (tt.indexOf(tmp) > -1) {
				    if(tt==src.id){
					   document.all.tags("TD")[i].className=clrOver;
					}else{
					   document.all.tags("TD")[i].className=clrIn;
					}
			     }
				 if(tt.indexOf(tmp2)>-1){
				   document.all.tags("TD")[i].className=clrIn;
				 }
			   }
		     }
		  }	
  </script>
</form>
</body>