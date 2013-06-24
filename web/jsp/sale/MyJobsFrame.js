	var isSearchJobFrame = false;
	var isSearchResult = false;
	var isMyFav = false;
	var isMyApp = false;
	var isInterview = false;
	var isRefresh = false;
	var isJobFolderRefresh = false;
	function window_load(){
		switch(searchType){
			case '22':
				cjolBoard(1);
				break;		
			case '31':
				//disableTD(document.all.tblSearchResult);
				cjolBoard(3);
				break;	
			case '32':
				//disableTD(document.all.tblSearchResult);
				cjolBoard(4);
				break;					
			case '33':
				//disableTD(document.all.tblSearchResult);
				cjolBoard(2);
				break;
			case '23':			
			default:
				cjolBoard(0);							
		}
	}
	function cjolBoard(n) 
	{ 
		for(i=0;i<cjolTable.cells.length;i++) {
		    cjolTable.cells[i].className="cjol1"; 
		  //  linecolor.cells[i].className="cjol4";
			}
		     cjolTable.cells[n].className="cjol2"; 
		    // linecolor.cells[n].className="cjol5";	
	}

//----------搜索职位---------
   function SaveSearch(){
   
   		if (!window.searchJobFrame.tabJobAlert_Validation()){
			return;
		}
		isRefresh = true;
		cjolBoard(1);
		window.searchJobFrame.validSearch();
		window.searchJobFrame.document.all.searchFrm.target="searchResultFrame";
		window.searchJobFrame.document.all.searchFrm.submit();
		
	}
//----------清空搜索条件---------------	
	function resetSearch(){
		window.searchJobFrame.resetAll();
	}
//---------添加到收藏夹----------------
	function addtoMyFav(){
		isMyFav = false;
		isJobFolderRefresh = true;
		window.searchResultFrame.addMyFav();
	}
//-------从收藏夹中删除---------------
	function delFromMyFav(){
		if (!window.confirm((LANGUAGE == "EN")?"Are you sure that you want to delete it?":"确认删除吗？"))
			return false;	
		isJobFolderRefresh = true;
		window.MyFavFrame.delMyFav();
	}	
//-------从申请过的工作中删除---------------
	function delFromMyApp(){
		if (!window.confirm((LANGUAGE == "EN")?"Are you sure that you want to delete it?":"确认删除吗？"))
			return false;
		isJobFolderRefresh = true;		
		window.MyAppFrame.delMyApp();
	}	
//-------从面试列表中删除---------------
	function delFromMyInt(){
		if (!window.confirm((LANGUAGE == "EN")?"Are you sure that you want to delete it?":"确认删除吗？"))
			return false;
		isJobFolderRefresh = true;		
		window.MyInterFrame.delMyInt();
	}			
	function SaveJobs(){
   		if (!window.searchJobFrame.tabJobAlert_Validation()){
			return;
		}
		isRefresh = true;
		window.searchJobFrame.validSearch();
		window.searchJobFrame.document.all.searchFrm.action="searchJobFrame.asp";
		window.searchJobFrame.document.all.searchFrm.submit();

	}
	
//------------修改搜索条件---------------
function btnModifyJobAlert_click(){
	cjolBoard(0);
}
	
//---------搜索工作显示-----------
function displaySearch(){
	
	/*document.all.btnSearchJob.style.display = "block";
	document.all.btnSearchResult.style.display = "none";
	document.all.btnMyFav.style.display = "none";
	document.all.btnMyApp.style.display = "none";
	document.all.btnInterview.style.display = "none";
	*/
	document.all.searchJobFrame.style.display = "block";
	document.all.searchResultFrame.style.display = "none";
	document.all.MyFavFrame.style.display = "none";
	document.all.MyAppFrame.style.display = "none";
	document.all.MyInterFrame.style.display = "none";	
	
	if (!isSearchJobFrame){
		window.searchJobFrame.location.href = "SearchJobFrame.asp";
		isSearchJobFrame = true;
	}
}

//---------搜索结果显示-----------
function displayResult(){
	
	/*document.all.btnSearchJob.style.display = "none";
	document.all.btnSearchResult.style.display = "block";
	document.all.btnMyFav.style.display = "none";
	document.all.btnMyApp.style.display = "none";
	document.all.btnInterview.style.display = "none";
	*/
	document.all.searchJobFrame.style.display = "none";
	document.all.searchResultFrame.style.display = "block";
	document.all.MyFavFrame.style.display = "none";
	document.all.MyAppFrame.style.display = "none";
	document.all.MyInterFrame.style.display = "none";
  	if (!isSearchResult){
		// window.searchResultFrame.location.href =  "ContractJz.jsp";
		isSearchResult = true;
	}		
}

//---------收藏夹显示-----------
function displayMyFav(){
	
	/*document.all.btnSearchJob.style.display = "none";
	document.all.btnSearchResult.style.display = "none";
	document.all.btnMyFav.style.display = "block";
	document.all.btnMyApp.style.display = "none";
	document.all.btnInterview.style.display = "none";
	*/
	document.all.searchJobFrame.style.display = "none";
	document.all.searchResultFrame.style.display = "none";
	document.all.MyFavFrame.style.display = "block";
	document.all.MyAppFrame.style.display = "none";
	document.all.MyInterFrame.style.display = "none";
	
	if (!isMyFav){
		window.MyFavFrame.location.href = "MyFavorite.asp";
		isMyFav = true;
	}		
}

//---------申请过的工作显示-----------
function displayMyApp(){
	
	/*document.all.btnSearchJob.style.display = "none";
	document.all.btnSearchResult.style.display = "none";
	document.all.btnMyFav.style.display = "none";
	document.all.btnMyApp.style.display = "block";
	document.all.btnInterview.style.display = "none";
	*/
	document.all.searchJobFrame.style.display = "none";
	document.all.searchResultFrame.style.display = "none";
	document.all.MyFavFrame.style.display = "none";
	document.all.MyAppFrame.style.display = "block";
	document.all.MyInterFrame.style.display = "none";	
	
	if (!isMyApp){
		window.MyAppFrame.location.href = "ApplicationList.asp";
		isMyApp = true;
	}	
}

//---------面试通知显示-----------
function displayInterview(){
	
	/*document.all.btnSearchJob.style.display = "none";
	document.all.btnSearchResult.style.display = "none";
	document.all.btnMyFav.style.display = "none";
	document.all.btnMyApp.style.display = "none";
	document.all.btnInterview.style.display = "block";
	*/
	document.all.searchJobFrame.style.display = "none";
	document.all.searchResultFrame.style.display = "none";
	document.all.MyFavFrame.style.display = "none";
	document.all.MyAppFrame.style.display = "none";
	document.all.MyInterFrame.style.display = "block";	
	
	if (!isInterview){
		window.MyInterFrame.location.href = "InterviewNotificationList.asp";
		isInterview = true;
	}	
}

//打开招聘信息页面
function openJobDetail(sThroughURL,sApplyThroughURL,sJobPostID,sCompanyID,sFromFlag)
{ 
	var strLanguage=(LANGUAGE=="CN")?"":"EN/";	
	if (sThroughURL=='2')
	   var InfoWindow = top.window.open(sApplyThroughURL);
    else	   
	   var InfoWindow = top.window.open('/Main/JobSeeker/'+strLanguage+'JobDetail.asp?FromFlag='+sFromFlag+'&JobPostID='+sJobPostID+'&CompanyID='+sCompanyID,'Win_JobDetail','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=670px,height=550px');
	
	try
	{
		checkPopWin(InfoWindow);
	}
	catch(e){;}//忽略没有包含SystemCheck.js时发生的错误
}

//打开公司招聘信息页面
function openJobDetail_Company(sThroughURL,sHomePage,sCompanyID)
{
	var	strLanguage=(LANGUAGE=="CN")?"":"EN/";
	if (sThroughURL=='2')
	   var ComInfoWindow = top.window.open(sHomePage);
    else	   
	   var ComInfoWindow = top.window.open('/Main/JobSeeker/'+strLanguage+'JobDetail_Company.asp?CompanyID='+sCompanyID,'Win_JobDetail','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=670px,height=550px');

	
	try
	{
		checkPopWin(ComInfoWindow);
	}
	catch(e){;}//忽略没有包含SystemCheck.js时发生的错误
}
//刷新首页数据
function refreshData(){	
	if (isRefresh||isJobFolderRefresh){
		window.opener.Get_JobChanceAndCount();		
	}
}

//刷新本页数据 
function refreshJobfolder(){
	isJobFolderRefresh = true;
	isMyFav = false;
	isMyApp = false;
	isInterview = false;	
	document.all.refreshFrame.src = '/JobSeeker/Include/JobSeeking/refreshMyJobChance.asp?Language='+LANGUAGE;
}