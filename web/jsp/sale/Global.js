var DEBUG;
var regEN = /\/EN\//i;
var isEn = regEN.test(window.location.pathname);
var LANGUAGE = isEn?"EN":"CN";
if(typeof(parent.dialogArguments)=="object"&&typeof(parent.dialogArguments.url)=="string")
{
	isEn = regEN.test(parent.dialogArguments.url);
	LANGUAGE = isEn?"EN":"CN";
}