 <%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
 <%@ page import="java.sql.*,java.util.*" %>
 <jsp:useBean id="userBean" scope="page" class="ConnDatabase.SDatabase" />
 <jsp:useBean id="smenu" scope="page" class="ConnDatabase.menu" />
  <%@ include file="../public_js/getByteOut.jsp"%>
  
<HTML><HEAD>
<title>���˵�</title>
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
   OB_Top=0;                        //�˵����붥��������ֵ(0)
   OB_Left=0;                       //�˵�������������ֵ(0)
   OB_Margin=10;                    //top and bottom margins between icons and borders(10)
   OB_Width=96; 
                       //�˵����(96)
   OB_Height=hei;                   //�˵��߶�(400)
   OB_SlideSpeed=100;               //�˵��˶��ٶ�(1.5)
   OB_BackgroundColor="#8FB0DF";    //�ڱ���ɫ("BACKGROUND")
   OB_ItemsSpacing=25;              //2��ͼ���ľ���(25)
   OB_BorderWidth=3;                //border���(3)
   OB_BorderStyle="ridge";          //border���("ridge")
   OB_BorderColor="#F39D00";        //border��ɫ("#dddddd")#8FB0DF
   OB_IconsWidth=32;                //ͼ����(32)
   OB_IconsHeight=32;               //ͼ��߶�()32
   OB_ButtonFontFamily="arial";     //��ť�����������("arial")
   OB_ButtonFontSize=9;             //��ť�������С(9)
   OB_ButtonFontColor="black";      //��ť��������ɫ("black")
   OB_ButtonHeight=25;              //��ť�ĸ߶�(25)
   OB_LabelFontFamily="arial";      //LOGO�����������("arial")
   OB_LabelFontSize=9;              //LOGO����������С(9)
   OB_LabelFontColor="white";       //LOGO�µ�������ɫ("white")
   OB_LabelMargin=3;                //margin between labels and icons(3)
   OB_UpArrow="../images/wtop.gif";        //���Ϲ�����logo��ͷ("arrowup.gif")
   OB_DownArrow="../images/scrolldown.gif";    //���¹�����logo��ͷ("arrowdown.gif")
   OB_ArrowWidth=15;                //��ͷ�Ŀ��(15)
   OB_ArrowHeight=15;               //��ͷ�ĸ߶�(15)
   OB_ArrowSlideSpeed=10;           //��Ŀ�б�������ٶ�(10)
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
  List list1=new LinkedList();//��ű��� 
 String same = "";
try{
 while (st22.hasMoreElements()) {
     list1.add((String)st22.nextElement());
 }
 }catch(Exception s){}
 if (list1.contains("DESKTOP")){
   String showtxt=smenu.doleftmenuOutLookStart("DESKTOP",String.valueOf(iii),"�ҵ�����",Strhttp,"../manager/myplan.jsp?dd=1",userid);
 
    out.print(showtxt);
	session.setAttribute( "m_menu" , "DESKTOP" );
  if (!showtxt.equals("")) iii++;
 }
 
 
 if (list1.contains("P")){
 out.print(smenu.doleftmenuOutLookStart("P",String.valueOf(iii),"ѡ���Ƽ�",Strhttp,"../cortrolcenter/searcher.jsp?dd=1",userid));
   session.setAttribute( "m_menu" , "P" );
 iii++;
 }
 if (list1.contains("R")){
 out.print(smenu.doleftmenuOutLookStart("R",String.valueOf(iii),"��������",Strhttp,"../TodayRemark/QYCustomer.jsp?dd=1",userid));
   session.setAttribute( "m_menu" , "R" );
 iii++;
 }
 if (list1.contains("B")){
 out.print(smenu.doleftmenuOutLookStart("B",String.valueOf(iii),"��������",Strhttp,"../basic/crm_Project_list.jsp?dd=1",userid));
  iii++;
  session.setAttribute( "m_menu" , "B" );
 }
 if (list1.contains("C")){
 out.print(smenu.doleftmenuOutLookStart("C",String.valueOf(iii),"�ͻ�����",Strhttp,"../customter/visitcusview.jsp?dd=1",userid));
   iii++;
 } 
 
 if (list1.contains("QT")){
   out.print(smenu.doleftmenuOutLookStart("QT",String.valueOf(iii),"���׹���",Strhttp,"../sale/manRoomCodeShowS.jsp?dd=1",userid));  
   session.setAttribute( "m_menu" , "QT" );
   iii++;
 }
 if (list1.contains("S")){
   out.print(smenu.doleftmenuOutLookStart("S",String.valueOf(iii),"�ۺ����",Strhttp,"../sale/RoomCodeShowS.jsp?dd=1",userid));  
   session.setAttribute( "m_menu" , "S" );
   iii++;
 }
 if (list1.contains("F")){
   out.print(smenu.doleftmenuOutLookStart("F",String.valueOf(iii),"�������",Strhttp,"../finance/alert.jsp?dd=1",userid)); 
   session.setAttribute( "m_menu" , "F" );
    iii++;
 }
 if (list1.contains("JC")){
   out.print(smenu.doleftmenuOutLookStart("JC",String.valueOf(iii),"���߹���",Strhttp,"../sale/indexTree9.jsp?dd=1",userid));  
   session.setAttribute( "m_menu" , "JC" );
   iii++;
 }
 if (list1.contains("K")){
   out.print(smenu.doleftmenuOutLookStart("K",String.valueOf(iii),"��Ϣ����",Strhttp,"../knowledge/knowledge_view.jsp?dd=1",userid)); 
    iii++;
 }

 if (list1.contains("M")){
 out.print(smenu.doleftmenuOutLookStart("M",String.valueOf(iii),"ϵͳ����",Strhttp,"../sys/user_list.jsp?dd=1",userid));
     iii++;
 }
  
 %>  
      
    document.write('<script src="../public_js/outbar.js"><\/script>')
    }
	
	 
  </SCRIPT>
  
 
  </CENTER><BR></BODY></HTML>