var gcToggle = "#ffff00";
var gcBG = "#CCCCFF";

function IOFFICE_GetSelected(aCell)
{

  		window.returnValue = aCell.innerText;
		window.close();
  
}


function fPopUpCalendarDlg(ctrlobj)
{
	showx = event.screenX - event.offsetX - 4 - 210 ; // + deltaX;
	showy = event.screenY - event.offsetY + 18; // + deltaY;
	newWINwidth = 210 + 4 + 18;

	retval = window.showModalDialog("../public_js/calendarDlg.jsp", "", "dialogWidth:197px; dialogHeight:210px; dialogLeft:"+showx+"px; dialogTop:"+showy+"px; status:no; directories:yes;scrollbars:no;Resizable=no; "  );
	if( retval != null ){
		ctrlobj.value=retval;
	}else{
		//alert("canceled");
	}
}

