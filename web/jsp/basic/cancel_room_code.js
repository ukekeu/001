function clearRoomNo(para1,para2,para3,para4,para5){
    if (confirm("确认取消此号吗？取消后将不能恢复")){
	 openwin1("deleteRoomNo.jsp?seccode="+para1+"&loft="+para2+"&building="+para5+"&Room_code="+para3,"",10,10,10,10);
	
	}else{
	para4.checked=true;
	}
     return false;
  }
  function LokeRoomNo(para1,para2,para3,para4,para5){
    if (confirm("确认禁用此号吗？禁用后将不能恢复")){
	 openwin1("LokeRoomNo.jsp?seccode="+para1+"&loft="+para2+"&building="+para5+"&RoomNo="+para3,"",10,10,10,10);
	
	}else{
	para4.checked=true;}
     return false;
  }