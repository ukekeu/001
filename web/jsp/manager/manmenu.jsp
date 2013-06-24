 <%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
 <%@ page import="java.sql.*,java.util.*" %>
 <jsp:useBean id="userBean" scope="page" class="ConnDatabase.SDatabase" />
 <jsp:useBean id="smenu" scope="page" class="ConnDatabase.menu" />
  <%@ include file="../public_js/getByteOut.jsp"%>
  
<HTML><HEAD>
<title>主菜单</title>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<%!  String userid="";int i=1;%>
<%userid=(String)session.getAttribute("loginid"); 
i=1;
String showtype= (String)  session.getAttribute("showtype");
if (showtype==null)showtype="0";
 
 %>
  
 
<BODY bgColor=#8fb0df scroll=no oncontextmenu="return false" >
 
<SCRIPT language=JAVASCRIPT>
    var wi=screen.width;
	var he=screen.height;
	var hei="";
	<%if (!showtype.equals("0")) {%>
	if (wi==1024&&he==768){hei=480;}
	else if (wi==1280&&he==768){hei=470;}
	else {hei=450}
	<%}else{ %>
	if (wi==1024&&he==768){hei=550;}
	else if (wi==1280&&he==768){hei=580;}
	else {hei=450}
	<%} %>
   OB_Top=0;                        //菜单距离顶部的象素值(0)
   OB_Left=0;                       //菜单距离左侧的象素值(0)
   OB_Margin=10;                    //top and bottom margins between icons and borders(10)
   OB_Width=96; 
                       //菜单宽度(96)
   OB_Height=hei;                   //菜单高度(400)
   OB_SlideSpeed=100;               //菜单运动速度(1.5)
   OB_BackgroundColor="#8FB0DF";    //内背景色("BACKGROUND")
   OB_ItemsSpacing=25;              //2个图标间的距离(25)
   OB_BorderWidth=3;                //border宽度(3)
   OB_BorderStyle="ridge";          //border风格("ridge")
   OB_BorderColor="#F39D00";        //border颜色("#dddddd")#8FB0DF
   OB_IconsWidth=32;                //图标宽度(32)
   OB_IconsHeight=32;               //图标高度()32
   OB_ButtonFontFamily="arial";     //按钮上字体的字型("arial")
   OB_ButtonFontSize=9;             //按钮上字体大小(9)
   OB_ButtonFontColor="black";      //按钮上字体颜色("black")
   OB_ButtonHeight=25;              //按钮的高度(25)
   OB_LabelFontFamily="arial";      //LOGO下字体的字型("arial")
   OB_LabelFontSize=9;              //LOGO下面的字体大小(9)
   OB_LabelFontColor="white";       //LOGO下的字体颜色("white")
   OB_LabelMargin=3;                //margin between labels and icons(3)
   OB_UpArrow="../images/wtop.gif";        //向上滚动的logo箭头("arrowup.gif")
   OB_DownArrow="../images/scrolldown.gif";    //向下滚动的logo箭头("arrowdown.gif")
   OB_ArrowWidth=15;                //箭头的宽度(15)
   OB_ArrowHeight=15;               //箭头的高度(15)
   OB_ArrowSlideSpeed=10;           //项目列表滚动的速度(10)
  </SCRIPT>

<SCRIPT language=JAVASCRIPT>
var username="<%=(String)session.getAttribute("loginname")      %>";
   if (document.all)
    {
    
<% 
 String Strhttp=request.getServerName();
 int iii=1;
 
String ip=(String)session.getAttribute("ip");
String popedomlist=smenu.doleftmenuPStart(userid,ip);

 

StringTokenizer st22 = new StringTokenizer(popedomlist,",") ;
 
int count2 = st22.countTokens() ;
  List list1=new LinkedList();//存放编码 
 String same = "";
try{
 while (st22.hasMoreElements()) {
     list1.add((String)st22.nextElement());
 }
 }catch(Exception s){}
 if (list1.contains("DESKTOP")){
   String showtxt=smenu.doleftmenuOutLookStart("DESKTOP",String.valueOf(iii),"我的桌面",Strhttp,"../manager/myplan.jsp?dd=1",userid);
 
    out.print(showtxt);
	session.setAttribute( "m_menu" , "DESKTOP" );
  if (!showtxt.equals("")) iii++;
 }
 
 
 if (list1.contains("P")){
 out.print(smenu.doleftmenuOutLookStart("P",String.valueOf(iii),"选房计价",Strhttp,"../cortrolcenter/searcher.jsp?dd=1",userid));
   session.setAttribute( "m_menu" , "P" );
 iii++;
 }
 if (list1.contains("R")){
 out.print(smenu.doleftmenuOutLookStart("R",String.valueOf(iii),"待办提醒",Strhttp,"../TodayRemark/QYCustomer.jsp?dd=1",userid));
   session.setAttribute( "m_menu" , "R" );
 iii++;
 }
 if (list1.contains("B")){
 out.print(smenu.doleftmenuOutLookStart("B",String.valueOf(iii),"基础数据",Strhttp,"../basic/crm_Project_list.jsp?dd=1",userid));
  iii++;
  session.setAttribute( "m_menu" , "B" );
 }
 if (list1.contains("C")){
 out.print(smenu.doleftmenuOutLookStart("C",String.valueOf(iii),"客户管理",Strhttp,"../customter/visitcusview.jsp?dd=1",userid));
   iii++;
 } 
 
 if (list1.contains("QT")){
   out.print(smenu.doleftmenuOutLookStart("QT",String.valueOf(iii),"交易管理",Strhttp,"../sale/manRoomCodeShowS.jsp?dd=1",userid));  
   session.setAttribute( "m_menu" , "QT" );
   iii++;
 }
 if (list1.contains("S")){
   out.print(smenu.doleftmenuOutLookStart("S",String.valueOf(iii),"售后服务",Strhttp,"../sale/RoomCodeShowS.jsp?dd=1",userid));  
   session.setAttribute( "m_menu" , "S" );
   iii++;
 }
 if (list1.contains("F")){
   out.print(smenu.doleftmenuOutLookStart("F",String.valueOf(iii),"财务管理",Strhttp,"../finance/alert.jsp?dd=1",userid)); 
   session.setAttribute( "m_menu" , "F" );
    iii++;
 }
 if (list1.contains("JC")){
   out.print(smenu.doleftmenuOutLookStart("JC",String.valueOf(iii),"决策管理",Strhttp,"../sale/indexTree9.jsp?dd=1",userid));  
   session.setAttribute( "m_menu" , "JC" );
   iii++;
 }
 if (list1.contains("K")){
   out.print(smenu.doleftmenuOutLookStart("K",String.valueOf(iii),"信息管理",Strhttp,"../knowledge/knowledge_view.jsp?dd=1",userid)); 
    iii++;
 }

 if (list1.contains("M")){
 out.print(smenu.doleftmenuOutLookStart("M",String.valueOf(iii),"系统管理",Strhttp,"../sys/user_list.jsp?dd=1",userid));
     iii++;
 }
  
 %>  
      
    document.write('<script src="../public_js/outbar.js"><\/script>')
    }
	
	 
  </SCRIPT>
  
 
  </CENTER><BR></BODY></HTML>