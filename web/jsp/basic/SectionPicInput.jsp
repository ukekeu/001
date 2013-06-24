<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>楼盘图</title>
</head>
<%@ page language="java" import="java.sql.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>


<body >
<form method="POST" name="cus" action="SectionPicInsert.jsp"  ENCTYPE="multipart/form-data">
  <p align="center"><b><font size="3" color="#000080">楼盘图片上载</font></b></p>
  <table width="58%" align=center border="0" cellspacing="0" bgcolor="#ffffff"  cellpadding="0" bordercolor="#dbdbdb" class="tablefill">
          <INPUT TYPE=HIDDEN  name="SerialNo" >
      <tr > 
        <td width="16%"   align="center"   class=roomleft >&nbsp;&nbsp;图片名称</td>
        <td width="57%" class=roomright   align="center"  > 
          <input type="file" size=25 name="PosMap" style="border-style: solid; border-width: 1">
        </td>
      </tr>
      <tr align="center" > 
        <td width="16%" align="center"   height="3" class=roomleft >&nbsp;&nbsp;电子地图</td>
        <td width="57%" class=roomright align="center"   height="3"> 
          <p align="center"> 
            <input type="file" size=25 name="CyberMap" style="border-style: solid; border-width: 1">
          </p>
        </td>
      </tr>
      <tr align="center" > 
        <td width="16%" align="center"     class=roomleft >&nbsp;&nbsp;规&nbsp;划&nbsp;图</td>
        <td width="57%" class=roomright align="center"    > 
          <input type="file" size=25 name="MackMap" style="border-style: solid; border-width: 1">
        </td>
      </tr>
      <tr> 
        <td width="16%"   align="center"   class=roomleft >&nbsp;&nbsp;外&nbsp;观&nbsp;图</td>
        <td width="57%" class=roomright   align="center"  > 
          <input type="file" size=25 name="FaceMap" style="border-style: solid; border-width: 1">
        </td>
      </tr>
      <tr> 
        <td width="16%"   align="center"   class=roomleft >&nbsp;&nbsp;平&nbsp;面&nbsp;图</td>
        <td width="57%" class=roomright   align="center"  > 
          <input type="file" size=25 name="PlaneMap" style="border-style: solid; border-width: 1">
        </td>
      </tr>
      <tr style="border-style: solid; border-width: 1"> 
        <td width="16%"   align="center"   class=roomleft >&nbsp;&nbsp;装&nbsp;修&nbsp;图</td>
        <td width="57%" class=roomright   align="center"  > 
          <input type="file" size=25 name="FitmentMap" style="border-style: solid; border-width: 1">
        </td>
      </tr>
      <tr style="border-style: solid; border-width: 1"> 
        <td width="16%"   align="center"   class=roomleft >&nbsp;&nbsp;景&nbsp;观&nbsp;图</td>
        <td width="57%" class=roomright   align="left"  > 
         <input type="file" size=25 name="SightMap" style="border-style: solid; border-width: 1">
        </td>
      </tr>
       </table>     
          <p align="center"> 
            <input type="submit" value="提　交" name="submit">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
		    <input type="button" value="退  出" name="reset" onclick="window.close();">

          </p>
      
   
    
</form> 
</body>       
</html>       
