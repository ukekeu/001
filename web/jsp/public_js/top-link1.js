function mOvr(src,clrOver) { if (!src.contains(event.fromElement)) { src.style.cursor = 'hand'; src.bgColor = clrOver; }}function mOut(src,clrIn) { if (!src.contains(event.toElement)) { src.style.cursor = 'default'; src.bgColor = clrIn; }} function mClk(src) { if(event.srcElement.tagName=='TD'){src.children.tags('A')[0].click();} }
document.write("<table width='720' cellspacing cellpadding>    <tr>      <td width='720' height='72' colspan='9'><img border='0' src='../images/banner.gif' width='720' height='72'></td>    </tr>      </table>  </center></div><div align='center'>  <center>  <table width='720' cellspacing cellpadding height='10'>    <tr>      <td onclick=mClk(this); onmouseout='mOut(this,'#FFC000');' onmouseover='mOvr(this,'#FFE084');' width='80'  align='center' bgcolor='#FFC000' class='L2'><a href='jibenziliao.htm'><font color='#000000'>������Ϣ</font></a></td>      <td onclick=mClk(this); onmouseout='mOut(this,'#FFC000');' onmouseover='mOvr(this,'#FFE084');' width='80'  align='center' bgcolor='#FFC000' class='L2'><a href='/info/'><font color='#000000'>�߻�����</font></a></td>      <td onclick=mClk(this); onmouseout='mOut(this,'#FFC000');' onmouseover='mOvr(this,'#FFE084');' width='80'  align='center' bgcolor='#FFC000' class='L2'><a href='/info/'><font color='#000000'>�ͻ�����</font></a></td>      <td onclick=mClk(this); onmouseout='mOut(this,'#FFC000');' onmouseover='mOvr(this,'#FFE084');' width='80'  align='center' bgcolor='#FFC000' class='L2'><a href='/info/'><font color='#000000'>ѡ���Ƽ�</font></a></td>      <td onclick=mClk(this); onmouseout='mOut(this,'#FFC000');' onmouseover='mOvr(this,'#FFE084');' width='80'  align='center' bgcolor='#FFC000' class='L2'><a href='/info/'><font color='#000000'>���۹���</font></a></td>      <td onclick=mClk(this); onmouseout='mOut(this,'#FFC000');' onmouseover='mOvr(this,'#FFE084');' width='80'  align='center' bgcolor='#FFC000' class='L2'><a href='/info/'><font color='#000000'>�������</font></a></td>      <td onclick=mClk(this); onmouseout='mOut(this,'#FFC000');' onmouseover='mOvr(this,'#FFE084');' width='80'  align='center' bgcolor='#FFC000' class='L2'><a href='/info/'><font color='#000000'>�ۺ����</font></a></td>      <td onclick=mClk(this); onmouseout='mOut(this,'#FFC000');' onmouseover='mOvr(this,'#FFE084');' width='80'  align='center' bgcolor='#FFC000' class='L2'><a href='/info/'><font color='#000000'>ʵʱ��ѯ</font></a></td>      <td onclick=mClk(this); onmouseout='mOut(this,'#FFC000');' onmouseover='mOvr(this,'#FFE084');' width='80'  align='center' bgcolor='#FFC000' class='L2'><a href='/info/'><font color='#000000'>��̨����</font></a></td>    </tr>  </table>")