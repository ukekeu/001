	window.onresize = baiduResizeDiv;
	window.onerror = function(){}
	var divTop,divLeft,divWidth,divHeight,docHeight,docWidth,objTimer,i = 0;
	var px = document.doctype?"px":0;
	var scrollwidth = navigator.userAgent.indexOf("Firefox")>0?16:0;
	var iframeheight = navigator.userAgent.indexOf("MSIE")>0?170-2:209-2;
	String.prototype.Trim  = function(){return this.replace(/^\s+|\s+$/g,"");}
	function baidu_collapse(obj){
		ct = document.getElementById('tab_c_iframe');
		if(ct.style.display=="none"){
			ct.style.display="";
			obj.src=obj.src.replace("b.gif","a.gif");
		} else {
			ct.style.display="none";
			obj.src=obj.src.replace("a.gif","b.gif");
		}
		baiduResizeDiv();
	}

	function baiduMsg()
	{
		try{
			divTop = parseInt(document.getElementById("eMeng").style.top,10);
			divLeft = parseInt(document.getElementById("eMeng").style.left,10);
			divHeight = parseInt(document.getElementById("eMeng").offsetHeight,10);
			divWidth = parseInt(document.getElementById("eMeng").offsetWidth,10);

			var scrollPosTop,scrollPosLeft,docWidth,docHeight;
			if (typeof window.pageYOffset != 'undefined') { 
				scrollPosTop = window.pageYOffset; 
				scrollPosLeft = window.pageXOffset; 
				docWidth = window.innerWidth; 
				docHeight = window.innerHeight; 
			} else if (typeof document.compatMode != 'undefined' && document.compatMode != 'BackCompat') {
				scrollPosTop = document.documentElement.scrollTop;
				scrollPosLeft = document.documentElement.scrollLeft;
				docWidth = document.documentElement.clientWidth;
				docHeight = document.documentElement.clientHeight;
			} else if (typeof document.body != 'undefined') { 
				scrollPosTop = document.body.scrollTop;
				scrollPosLeft = document.body.scrollLeft;
				docWidth = document.body.clientWidth;
				docHeight = document.body.clientHeight;
			}

			document.getElementById("eMeng").style.top = parseInt(scrollPosTop,10) + docHeight + 10 + px;// divHeight
			document.getElementById("eMeng").style.left = parseInt(scrollPosLeft,10) + docWidth - divWidth - scrollwidth + px;
			document.getElementById("eMeng").style.visibility="visible";
			objTimer = window.setInterval("baidu_move_div()",10);
		}catch(e){}
	}

	function baiduResizeDiv()
	{
		i+=1;
		try{
			divHeight = parseInt(document.getElementById("eMeng").offsetHeight,10);
			divWidth = parseInt(document.getElementById("eMeng").offsetWidth,10);

			var scrollPosTop,scrollPosLeft,docWidth,docHeight; 
			if (typeof window.pageYOffset != 'undefined') { 
				scrollPosTop = window.pageYOffset; 
				scrollPosLeft = window.pageXOffset; 
				docWidth = window.innerWidth; 
				docHeight = window.innerHeight; 
			} else if (typeof document.compatMode != 'undefined' && document.compatMode != 'BackCompat') {
				scrollPosTop = document.documentElement.scrollTop;
				scrollPosLeft = document.documentElement.scrollLeft;
				docWidth = document.documentElement.clientWidth;
				docHeight = document.documentElement.clientHeight;
			} else if (typeof document.body != 'undefined') { 
				scrollPosTop = document.body.scrollTop;
				scrollPosLeft = document.body.scrollLeft;
				docWidth = document.body.clientWidth;
				docHeight = document.body.clientHeight;
			}

			document.getElementById("eMeng").style.top = docHeight - divHeight + parseInt(scrollPosTop,10) + px;
			document.getElementById("eMeng").style.left = docWidth - divWidth + parseInt(scrollPosLeft,10) - scrollwidth + px;
		}catch(e){}
	}

	function baidu_move_div()
	{

		var scrollPosTop,scrollPosLeft,docWidth,docHeight; 
		if (typeof window.pageYOffset != 'undefined') { 
			scrollPosTop = window.pageYOffset; 
			scrollPosLeft = window.pageXOffset; 
			docWidth = window.innerWidth; 
			docHeight = window.innerHeight; 
		} else if (typeof document.compatMode != 'undefined' && document.compatMode != 'BackCompat') {
			scrollPosTop = document.documentElement.scrollTop;
			scrollPosLeft = document.documentElement.scrollLeft;
			docWidth = document.documentElement.clientWidth;
			docHeight = document.documentElement.clientHeight;
		} else if (typeof document.body != 'undefined') { 
			scrollPosTop = document.body.scrollTop;
			scrollPosLeft = document.body.scrollLeft;
			docWidth = document.body.clientWidth;
			docHeight = document.body.clientHeight;
		}

		try{
			if(parseInt(document.getElementById("eMeng").style.top,10) <= (docHeight - divHeight + parseInt(scrollPosTop,10)))
			{
				window.clearInterval(objTimer);objTimer = window.setInterval("baiduResizeDiv()",1);
			}
			divTop = parseInt(document.getElementById("eMeng").style.top,10);
			document.getElementById("eMeng").style.top = divTop - 1 + px;
		}catch(e){}
	}
	function baiduMessbox(shape,color,userid){
		var styles='position:absolute;top:0px;left:0px;z-index:99999;visibility:hidden;';
		var copic='<img src="../images/ico_'+color+'a.gif" align="absmiddle" class="ioc'+color+'" onClick="baidu_collapse(this)">';
		if(shape>1) window.onload = baiduMsg;
		else {styles='';copic=''}
		var s;
		if(shape==2) {
			s='<div id=eMeng style="Z-INDEX:99999;LEFT:0px;POSITION:absolute;TOP:0px;VISIBILITY:hidden;">'
				+ '<table width="216" border="0" cellpadding="0" cellspacing="0" class="" id="tab_'+(color+3)+'" style="border:0px;">'
				+'<tr>'
				+'<td align="right"></td>'
				+'</tr>'
				+'  <tr>'
				+'    <td><table width="100%"  border="0" cellspacing="0" cellpadding="0">'
				+'        <tr>'
				+'          <td width="32" rowspan="2" valign="bottom"><img src="../images/ico'+(color+1)+'.gif"></td>'
				+'          <td>&nbsp;</td>'
				+'        </tr>'
				+'        <tr>'
				+'          <td align=right style="font-size:12px; background:url(../images/bg_'+color+'.gif);line-height:21px;height:21px;border-top:1px solid #808080;border-right:1px solid #808080;padding-right:6px;color:#FFFFFF;" onDblClick="baidu_collapse(this.firstChild.nextSibling)"><a href="http://www.QiguangNet.com" target="_blank" style="text-decoration:none"><font color="#FFFFFF">U客软件---客户服务 </font></a> <img src="../images/ico_'+color+'a.gif" align="absmiddle" class="ioc'+color+'" onClick="baidu_collapse(this)">'
				+'		  </td>'
				+'        </tr>'
				+'      </table>'
				+'	  </td>'
				+'    </tr>'
				+''
				+''
				+''
				+''
				+''
				+ '</table>'
				+ '<iframe src="../public_js/popup.jsp?userid=' +userid+ '" width="216" height="' + iframeheight + '" frameborder="0" id="tab_c_iframe"></iframe>'
				//+'<table width="216" border="0" cellspacing="0" cellpadding="3" height="69" style="border-left-width:1px;border-left-style:solid;border-left-color:#000;border-right-width:1px;border-right-style:solid;border-right-color:#000;border-top-width:0;border-bottom-width:1px; border-bottom-style:solid; border-bottom-color:#000000;"><tr><td bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF"><tr><td style="height:3px;"></td></tr></table><table width="100%" border="0" cellpadding="0" cellspacing="0" style="background:#E70010;"><tr><td width="31%" align="center" valign="middle"><img src="../images/kefu.jpg" width="50" height="55" /></td><td><table width="100%" border="0" cellspacing="0" cellpadding="0"  style="font-size:12px;color:#FFFFFF;"><tr><td width="38%" height="22" valign="bottom">QQ客服</td><td width="62%" valign="bottom">MSN客服</td></tr><tr><td height="22" colspan="2"><a href="#" title="请加入QQ：3974640"><img src="../images/qq1.gif" border="0"/></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#"><img alt="请加入我的MSN，方便及时沟通" src="../images/msn.gif" border="0"/></a></td></tr><tr><td height="22" colspan="2" valign="top">24小时电话:13991312581</td></tr></table></td></tr></table><table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF"><tr><td style="height:3px;"></td></tr></table><table width="100%" border="0" cellpadding="0" cellspacing="0" style="background:#E70010;"></table></td></tr></table>'
				+'</div>';
		} else if(shape==3) {
			s='<div id=eMeng style="width:100%;background:#FFFFFF;'+styles+'">'
				+'  <table width="100%"  border="0" cellpadding="0" cellspacing="0" style="border:1px solid #808080;" id="tab_'+color+'">'
				+'    <tr>'
				+'      <td colspan="3" align=right style="font-size:12px; background:url(../images/bg_'+color+'.gif);line-height:19px;height:19px;padding-right:6px;color:#FFFFFF;" onDblClick="baidu_collapse(this.firstChild.nextSibling)">留言板'+copic
				+'</tr>'
				+'    </tr>'
				+ '</table>'
				+ '<iframe src="bottom.html?userid=' +userid+ '" width="100%" height="85" frameborder="0" id="tab_c_iframe"></iframe>'
				+'</div>';
		}
		document.writeln(s);
	}
	baiduMessbox(2,1, 849620);
