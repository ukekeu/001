<%@ page contentType="text/html;charset=GBK" %> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>U�����</title>
<style type="text/css">
#tab_4{font-family:Arial;border-left-width:1px;border-left-style:solid;border-left-color:#000;border-right-width:1px;border-right-style:solid;border-right-color:#000; border-bottom-width:0px;}
#tab_4 td{font-size:12px;}
#tab_4 .tit1{background:url(images/bg_1.gif);border-width:1px 1px 1px 0;border-style:solid;border-color:#000;line-height:20px;height:20px;color:#fff; padding-right:5px; text-align:right}
#tab_4 .box1{padding:5px;color:#808080;	background-color:#FFFFFF;}
#tab_4 .inp1,#tab_4 .inp2{font-family:Arial; font-size:12px;overflow:auto;color:#808080;border:1px solid #808080;margin-bottom:5px;width:200px; }
#tab_4 .ioc1{margin-left:5px;}
body {
	margin:0px;
}
</style>
<script type="text/javascript">
String.prototype.Trim  = function(){return this.replace(/^\s+|\s+$/g,"");}
function baidu_query(){
	var obj = {
		param:{},
		construct:function(){
			var name, value, index;		
			var query = location.search.substr(1);
			var pairs = query.split("&");
			for(var i=0;i < pairs.length; i++){
				index = pairs[i].indexOf("=");
				if(index){
					name    = pairs[i].substr(0,index);
					value   = pairs[i].substr(index+1);
					this.param[name] = value;
				}
			}
			return this;
		},
		getParam: function(name, def){
			return this.param[name]==undefined?def:this.param[name];
		}
	};
	return obj.construct();
}
function valid_message()
{
	objMess = document.lea_mess.message;
	objContact = document.lea_mess.contact;
	
	objMess.value = objMess.value.Trim();
	objContact.value = objContact.value.Trim();
	
	strMess = objMess.value;
	strContact = objContact.value;
	
	if (strMess.length > 200)
	{
		alert('�������Թ������������200���ڣ�лл��');
		return false;
	}
	if (strContact.length > 50)
	{
		alert('������ϵ��ʽ�������������50���ڣ�лл��');
		return false;
	}
	if ((strMess.length < 1 || strMess==objMess.defaultValue) && strContact.length>0)
	{
		alert('����û����д�������ݣ������������ݿ�����д���ύ��лл��');
		return false;
	}
	if ((strContact.length < 1 || strContact==objContact.defaultValue) && strMess.length>0)
	{
		alert('����û����д��ϵ��ʽ��������ϵ��ʽ������д���ύ��лл��');
		return false;
	}
	if ((strContact.length < 1 && strMess.length<1) ||  (strMess==objMess.defaultValue && strContact==objContact.defaultValue))
	{
		alert('���ã����Բ���Ϊ�գ�лл��');
		return false;
	}
	if(!confirm('��ȷ������������?')) 
	{
		return false;
	}
	document.lea_mess.userid.value = userid;
	document.lea_mess.submit();
	msee_init();
	return false;
}
function msee_init () {
	document.lea_mess.message.value = document.lea_mess.message.defaultValue;
	document.lea_mess.contact.value = document.lea_mess.contact.defaultValue;
}
var query = baidu_query();
var userid = query.getParam('userid');
unction ldo()
{  
    window.location="popup.jsp";
    window.setTimeout(ldo,30000);
}
 
</script>
</head>
<body onload="ldo();">
<form name ='lea_mess' action ='add_books.asp' method ='post' onsubmit='return valid_message();' target="baidu_mess_iframe">
<input type="hidden" name="userid" value="" >
<table width="216"  border="0" cellpadding="0" cellspacing="0" class="" id="tab_4">
    <tr>
      <td class="box1"><textarea name="message" rows="4" class="inp1" onFocus="if (this.value == this.defaultValue) this.value='';" onBlur="this.value=this.value.Trim(); if (this.value=='') this.value=this.defaultValue;">���ã���л��עU�ͷ��������
����������ǵĲ�Ʒ����Ȥ�������˴����ԣ�лл��</textarea>
          <textarea name="contact" rows="1" class="inp2" onFocus="if (this.value == this.defaultValue) this.value='';" onBlur="this.value=this.value.Trim(); if (this.value=='') this.value=this.defaultValue;">���������ǹ�˾����</textarea>
 <textarea name="contact" rows="1" class="inp2" onFocus="if (this.value == this.defaultValue) this.value='';" onBlur="this.value=this.value.Trim(); if (this.value=='') this.value=this.defaultValue;">������������ϵ��ʽ</textarea>
          <table  border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td><input name="imageField" type="image" src="../images/button.gif" border="0"></td>
              <td   >&nbsp;&nbsp;����绰:15814891599</td>
            </tr>
        </table>      </td>
    </tr>
</table>
<iframe src="" name="baidu_mess_iframe" style="display:none" />

</form>
</body>
</html>
