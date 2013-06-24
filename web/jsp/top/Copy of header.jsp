 <%@ page contentType="text/html;charset=GBK" %>
 <%@ page import="java.sql.*,java.util.*" %>
 <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase" />
 <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
 <%@ include file="../public_js/getByteOut.jsp"%>
 <%@ include file="../public_js/qx_checke.jsp"%>
<HTML><HEAD>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<STYLE type=text/css>
@import url( /jsp/css/common.css );
@import url( /jsp/css/header.css );
td {
	font-size: 12px;
}
.style2 {color: #A9CDCD}
.style3 {color: #BAD6D6}
.style4 {color: #B1D1CF}
</STYLE>

<SCRIPT language=JavaScript src="images/warning.js"></SCRIPT>

<SCRIPT language=JavaScript src="images/moduleBar.js"></SCRIPT>

<SCRIPT>
var currentModuleId = 0;
function changeTab(moduleId){
      if(moduleId != currentModuleId){
      var handle = document.getElementById("tabMiddle"+currentModuleId);
      handle.style.background = "url('/images/themes/sky/header/gray_middle.gif')";
      handle = document.getElementById("tabMix"+(parseInt(currentModuleId)-1));
      if(handle == undefined){
         handle = document.getElementById("tabFirst"+currentModuleId);
         handle.style.background =  "url('/images/themes/sky/header/gray_left.gif')";
      }else{
          handle.style.background =  "url('/images/themes/sky/header/gray_cover.gif')";
      }
      handle = document.getElementById("tabMix"+currentModuleId);
       if(handle == undefined){
           handle = document.getElementById("tabLast"+currentModuleId);
         handle.style.background =  "url('/images/themes/sky/header/gray_right.gif')";
      }else{
          handle.style.background =  "url('/images/themes/sky/header/gray_cover.gif')";
      }
      
      
      var handle = document.getElementById("tabMiddle"+moduleId);
      handle.style.background = "url('/images/themes/sky/header/light_middle.gif')";
      handle = document.getElementById("tabMix"+(parseInt(moduleId)-1));
      if(handle == undefined){
         handle = document.getElementById("tabFirst"+moduleId);
         handle.style.background =  "url('/images/themes/sky/header/light_left.gif')";
      }else{
          handle.style.background =  "url('/images/themes/sky/header/light_right_cover.gif')";
      }
      handle = document.getElementById("tabMix"+moduleId);
       if(handle == undefined){
           handle = document.getElementById("tabLast"+moduleId);
         handle.style.background =  "url('/images/themes/sky/header/light_right.gif')";
      }else{
          handle.style.background =  "url('/images/themes/sky/header/light_left_cover.gif')";
      }

           currentModuleId =   moduleId ;
         
   }
}

function openwin1(url,wh,hg,lf,tp) {
  var newwin=window.open(url,"newwin1","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width="+wh+",height="+hg+",left="+lf+",top="+tp);
  newwin.focus();
  return false;
}
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
    
function out(){
     if (confirm("确认退出系统吗？"))
	 window.parent.location='../outSys.jsp'
   }
   
</SCRIPT>
<META content="MSHTML 6.00.2800.1106" name=GENERATOR><title></title></HEAD>
<BODY leftMargin=0 topMargin=0 rightMargin=0>
<%String reg="select datediff(d,getdate(),end_date) as day,state,userregno  from user_reg";
 ResultSet rs=null;
 rs = ViewBean.executeQuery(reg);
 int day=0;
 int fg=0;
 int state =1;
 String userregno="";
 if (rs.next()){
   day=rs.getInt("day");
   state=rs.getInt("state");
   userregno=getbyte(rs.getString("userregno"));
   fg=1;
 }
 rs.close();
 if (fg==0){out.println("<font color=red>系统未注册，不能正常使用！联系电话:0755-86105570 13798375094</font>");out.close();}
 

 %>
 
<table width="100%"  border="0" cellpadding="0" cellspacing="0" title="<%if (state==0){out.print("软件提供商：U客软件　          　正式注册编码：hcrm-"+userregno);} %>">
  <tr >
    <td width="18"><img src="images/tab_bg_left.gif" width="18" height="125"></td>
    <td width="284" background="images/tab_bg_left2.gif" valign="top" align="right"></td>
    <td valign="top"><table width="100%"  border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td height="60" background="images/tab_bg_left3bg.gif"><table width="100%"  border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="20"><img src="images/tab_bg_left3.gif" width="20" height="60"></td>
            <td align="right"><% if (state==1){if (day>0){out.print("<font color=red>可用"+String.valueOf(day)+"天</font>");};}else{out.print("<font color=red>正版</font>");} %><img src="images/user.gif" width="15" height="15" hspace="8" align="absmiddle"><span class="style4" onclick="openwin1('../sys/chane_reg.jsp',300,200,100,100);" onMouseOver='OverArrow(this)'  onMouseOut='OutArrow(this)' style="cursor:hand;" title="修改登录用户">用户管理</span><img src="images/set.gif" width="15" height="15" hspace="8" align="absmiddle"><span class="style4" onMouseOver='OverArrow(this)'  onMouseOut='OutArrow(this)' style="cursor:hand;" onclick="window.parent.contents.location='../manager/menu.jsp?MModuleNo=M';window.parent.main.location='../manager/log.jsp';" title="进入系统管理模块">系统设置</span><img src="../images/phone.gif" width="23" height="16" hspace="8" align="absmiddle">
            <span class="style4"  onMouseOver='OverArrow(this)'  onMouseOut='OutArrow(this)' style="cursor:hand;"  title="技术支持：QQ:357657132">QQ客服</span><img src="images/home.gif" width="15" height="15" hspace="5" align="absmiddle"><span class="style2" onMouseOver='OverArrow(this)' title="访问U密软件主页" onclick="window.open('http://www.uk.com.cn/');return false;" onMouseOut='OutArrow(this)' style="cursor:hand;"      target=rightp>主页<!-- --></span><img src="../images/icon_edit_topic.gif" width="15" height="15" hspace="8" align="absmiddle" ><span class="style3" onclick="openwin1('../sys/ChangePassword.jsp',300,200,100,100);" onMouseOver='OverArrow(this)'  onMouseOut='OutArrow(this)' style="cursor:hand;" >修改密码</span><img src="images/exit.gif" width="15" height="15" hspace="5" align="absmiddle"><span class="style2" onMouseOver='OverArrow(this)'  onMouseOut='OutArrow(this)' style="cursor:hand;"  onClick="out();return false;"   title="退出系统"  target=rightp>退出</span><img src="../images/help.gif" width="15" height="15" hspace="5" align="absmiddle"><span class="style2" onMouseOver='OverArrow(this)'  onMouseOut='OutArrow(this)' style="cursor:hand;"  onClick=""   title="系统流程图"  target=rightp>帮助</span></td>
            <td width="160" align="right"><MARQUEE id="PLACARD" direction="left"  width="100%"  scrollDelay="30" trueSpeed="true" scrollAmount="1" ><font color="#FFFFFF">尊敬的客户，您好！欢迎您选择U客售楼管理信息系统!如果你有建议或问题请致电技术支持部</font></MARQUEE> </td>
        
         
		  </tr>
        </table>
          </td>
      </tr>
      <tr>
        <td height="65" background="images/tab_bg_left3bg2.gif">
		<table width="100%" height="65"  border="0" cellpadding="0" cellspacing="0">
          <tr align="center" valign="top">
		  <%
		  
		    String userid=(String)session.getAttribute("loginid"); 
		    String SqlStr="select disc from CortrolMan where SerialNo='"+userid+"'";//and nexus='C' ManModuleCortrol
	        
		    
			 rs = ViewBean.executeQuery(SqlStr);
			  if (rs.next()){
			  session.setAttribute("disc",rs.getString("disc"));
			 
			  }
			   rs.close();
			SqlStr="select Url,MModuleNo,CModuleNo,MModuleName,picpath,nexus,title  from ModuleCortrol where (MModuleNo<>'M' ) and nexus='P' and  MModuleNo in(select manModule from  ManModuleCortrol where SellerId='"+userid+"') ORDER BY orderby  ";//and nexus='C' ManModuleCortrol
	         try{
			 rs = ViewBean.executeQuery(SqlStr);
			 while (rs.next()){
			  String Url=getbyte(rs.getString("Url"));
			  String MModuleNo=getbyte(rs.getString("MModuleNo"));
			  String CModuleNo=getbyte(rs.getString("CModuleNo"));
			  String MModuleName=getbyte(rs.getString("MModuleName")).trim();
		      String picpath=getbyte(rs.getString("picpath"));
			  String nexus=getbyte(rs.getString("nexus"));
			  String title=getbyte(rs.getString("title"));
			  String mm="";
			 
			  if (MModuleNo.equals("MY"))mm="http://"+request.getServerName()+":809/crm/homepage.asp";
	          else mm="../"+Url;
			  
			   %>
		  <td ><img title="<%=title %>" onclick="window.parent.contents.location='../manager/menu.jsp?MModuleNo=<%=MModuleNo %>';window.parent.main.location='<%=mm %>';" onMouseOver='OverArrow(this)'  onMouseOut='OutArrow(this)' style="cursor:hand;"  src="<%=picpath %>" width="32" height="32"  border=0 ><br><%=MModuleName %></td>
        	<%}
			rs.close();
			}catch(Exception s){out.print(s.getMessage());}	
			 %>
			 <td></td>
          </tr>
          
		 
        </table></td>
      </tr>
    </table></td>
  <td width="17" valign="top"><img src="images/tab_bg_right.gif" width="17" height="125"></td>
  </tr>
</table>
</BODY></HTML>
