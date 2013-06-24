top.warningTag = false;
function setWarningTag(b) {
	top.warningTag = b;
}

function changeGroupWarning(url, warning) {
	if (top.warningTag) {
		if (!confirm(warning)) {
			top.location = url;
		}
	} else {
		top.location = url;
	}
}

function moduleWarning(url, warning) {
	if (top.warningTag) {
		if (!confirm(warning)) {
			parent.location = url;
		}
	} else {
		parent.location = url;
	}
}

function moduleWarning2(url, warning,tabNumber) {
	if (top.warningTag) {
		if (!confirm(warning)) {
		  if(top.EnvisionModuleHome == null){		    
		    top.location = url ;
		   }else{		   
			top.EnvisionModuleHome.location = url;
		  }
		  if(tabNumber!=null){
		    changeTab(tabNumber);
		  }
		}
	} else {
	  if(top.EnvisionModuleHome == null){
		    top.location = url ;
		   }else{
		top.EnvisionModuleHome.location = url;
		}
	   if(tabNumber!=null){
	     changeTab(tabNumber);
	   }
	}
}

function logoutWarning(url, warning) {
	if (top.warningTag) {
		if (!confirm(warning)) {
			parent.location = url;
		}
	} else {
		parent.location = url;
	}
}

function menuWarning(url, warning) {
	if (top.warningTag) {
		if (!confirm(warning)) {
			top.EnvisionModuleHome.EnvisionModuleNavigator.location = url;
		}
	} else {
		top.EnvisionModuleHome.EnvisionModuleNavigator.location = url;
	}
}

function treeWarning(url, warning) {
	if (top.warningTag) {
		if (!confirm(warning)) {
			parent.EnvisionDetails.location = url;
		}
	} else {
		parent.EnvisionDetails.location = url;
	}
}

function treeAddWarning(target, url, warning) {
	var handle = parent.TreeElementDetails;
	var needWarning = false;
	if (handle.document.editform != undefined || handle.document.addrefform != undefined) {
		needWarning = true;
	}

	if (handle.EnvisionEdoTree != undefined
		&& handle.EnvisionEdoTree.document.treeAddListForm != undefined) {
		needWarning = true;
	} else if (handle.TreeElementDetails != undefined 
		&& (handle.TreeElementDetails.document.editform != undefined 
		|| handle.TreeElementDetails.document.addrefform != undefined)) {
		needWarning = true;
	} 

	if (parent.name == target) {
		handle = parent;
	} else if (parent.frames[target] != undefined) {
		handle = parent.frames[target];
	}
	if (needWarning) {
		if (!confirm(warning)) {
			handle.location = url;
		}
	} else {
		handle.location = url;
	}	
}

function buttonWarning(warning) {
	if (top.warningTag) {
		if (!confirm(warning)) {
			return true;
		}
	} else {
		return true;
	}
	return false;
}