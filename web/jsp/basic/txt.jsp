<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<LINK href="../class/news.css" rel=stylesheet>
<script src="js/mad.js"> </script>
</head>

<script>

  function submitForm(){
    
  
  }
  

</script>
<form name=cus>
<input type=hidden name=SecNo>
<input type=hidden name=Loft>
<input type=hidden name=SecName>
<input type=hidden name=Build>
<input type=hidden name=choose>
<input type=hidden name="Search">
<input type=hidden name="Find">

<table width="99%">
<tr><td>生成房源操作步骤:</td></tr>
<tr><td>&nbsp;&nbsp;1.点击左边"楼栋名称"；</td></tr>
<tr><td>&nbsp;&nbsp;2.在右窗口中填写定义规则(如：楼层范围、房号范围、单元范围等)；</td></tr>
<tr><td>&nbsp;&nbsp;3.点击"预览"，可以修改定义的编码名称及取消不需要的编码，点击"提交"保存定义的房源编码；</td></tr>
 
<tr><td>&nbsp;&nbsp;4.点击编码后，在弹出窗口中填写房间资料(可以选择楼层范围、房间范围、单元范围进行批量生成资料)；</td></tr>
<tr><td>说明：</td></tr>
<tr><td>&nbsp;&nbsp;1.由于每一套房的价格可能存在差异，建议定义好编码后，通过EXCEL导入房间资料，可以快速完成房间资料的生成；</td></tr>
<tr><td>&nbsp;&nbsp;2.也可以通过系统价格管理功能(决策管理－＞价格管理)来实现定价或调价快速完成价格生成；</td></tr>
</table>
 </form>
 
</center>

</body>
</html>
