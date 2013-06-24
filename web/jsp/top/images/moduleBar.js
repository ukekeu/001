var isIE6 = 0;
var isGecko = 0;

if ( document.all  &&  document.fireEvent  &&  document.createComment ) isIE6 = 1;
if ( document.getElementById && !document.all) isGecko = 1;

function init()	// To take care of browser differences.
{
	if ( isGecko ) {
	// Centers the Module Selector menu in NS6, NS7 & Mozilla 1.5        
	var temp = document.getElementById("sdMenusDiv");
	temp.style.border = "3px solid background;";

	// Centers the iframe for the module menus in NS6, NS7 & Mozilla 1.5
	var temp = document.getElementById("menuIframe");
	temp.style.border = "1px solid transparent";
	}
}

var menuFlag = 0;     // 0 = closed; 1 = openned
var hideTimer;
var showTimer;
var speed = 20;
var i = -500;

function toggleModule()    // Toggles menu open & close (show & hide moduleBar)
{
	if ( menuFlag == 0 ) {
		showModule();
		menuFlag = 1;
	} else {
		hideModule();
		menuFlag = 0;
	}
}

function showModule() { 
	clearInterval(hideTimer);
	showTimer = setInterval("show()",10);
	document.getElementById("moduleButton").src = "/enkisoft/images/Up.gif";
}

function hideModule() {
	clearInterval(showTimer);
	hideTimer = setInterval("hide()",10);
	document.getElementById("moduleButton").src = "/enkisoft/images/Down.gif";
}

function show() {
	if (i < 40 ) {		
		i = i + speed;
		// Push down Module Selector menu
		document.getElementById("sdMenusDiv").style.top = i + "px";
		document.getElementById("extraDivBox1").style.height = (i + 540) + "px";
		if(i>=40) document.getElementById("extraDivBox1").style.height="100%";
	}
}

function hide() {
	if (i > -500)        // How far to retract menu
	{
		i = i - speed;
		// Pull up Module Selector menu
		document.getElementById("sdMenusDiv").style.top = i + "px";
		document.getElementById("extraDivBox1").style.height = (i + 540) + "px";
	}
}
      
function doModuleCommand(warningStr) {
	var handle = document.getElementById("moduleSelBox");
	if (handle.selectedIndex == 0) {
		return;
	} else if (handle.selectedIndex == handle.length-1) {
		logoutWarning(handle.options[handle.selectedIndex].value, warningStr);
	} else {
		moduleWarning(handle.options[handle.selectedIndex].value, warningStr);
	}
}

function setBgColor(cell, color) {
    cell.style.backgroundColor = color;
    cell.oldBgColor = cell.style.backgroundColor;
}

// set the backgrouColor temporarily
function setTempBgColor(cell, color) {
    cell.oldBgColor = cell.style.backgroundColor;
    cell.style.backgroundColor = color;
}

function resetBgColor(cell) {
    if (cell.oldBgColor != null) {
	    cell.style.backgroundColor = cell.oldBgColor;
	}
}

var currentCell = null;
function selectCell(cell) {
    if (currentCell == null) {
    	currentCell = document.all["SELECTED_CELL"];
    }
	if (currentCell != null) {
		setBgColor(currentCell, "#eaeaf9");
	}
	setBgColor(cell, "#EBF4FF");
	currentCell = cell;
}

function popupAbout(contextPath){
     if (document.all){               
         var ornaments = "dialogHeight:400px;dialogWidth:500px;";
         ornaments += "edge:raised;help:no;resizable:no;status:no;unadorned:no";
         window.showModalDialog(contextPath+"/jsp/about.jsp","", ornaments);
     
     }else{
        alert("about");
     }
   
}

 function getAbsoluteLeft( object ){
             if(!object){return null;}
             var currentObject = object;
             var left = currentObject.offsetLeft;
             while( currentObject != null && currentObject.offsetParent != null 
                    && currentObject.offsetParent.tagName != "BODY" ){
                   left += currentObject.offsetParent.offsetLeft;
                   currentObject = currentObject.offsetParent;
             }
             return left;
        }

function showNameDiv(moduleTabName,moduleName){
     var handle = document.getElementById(moduleTabName);
     var left = getAbsoluteLeft(handle);
     handle = document.getElementById("clickInTable");
     handle.style.visibility = "visible" ;
     handle.style.left = 400;
     handle = document.getElementById("showingLbl");
   
     handle.firstChild.data = moduleName;
   
}

function hideNameDiv(){
     var handle = document.getElementById("clickInTable");
     handle.style.visibility="hidden";
}