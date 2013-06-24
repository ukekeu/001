
//####################### 쿠키를 얻어온다 #########################
function getCookie (name){
    var nameOfCookie = name + "=";
    var x = 0;
    while ( x <= document.cookie.length )
    {
        var y = (x+nameOfCookie.length);
        if ( document.cookie.substring( x, y ) == nameOfCookie ) {
            if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 )
				endOfCookie = document.cookie.length;
            return unescape( document.cookie.substring( y, endOfCookie ) );
        }
        x = document.cookie.indexOf( " ", x ) + 1;
        if ( x == 0 )
             break;
    }
    return "";
}


//####################### 쿠키를 저장한다 #########################
function setCookie( name, value, expiredays ) 
{ 
    var todayDate = new Date(); 
    todayDate.setDate( todayDate.getDate() + expiredays ); 
    document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";" 
} 



//####################### 쿠키 적용 후 윈도우 닫기 #########################
// 체크박스 컨트롤 : control
// 쿠키에 저장될 키 : key
function AcceptCookieNCloseWindow(control, key) 
{ 
        if (control.checked) 
			setCookie(key, "done" , 1);  // 오른쪽 숫자는 쿠키를 유지할 기간을 설정합니다
        opener.focus();
        window.close(); 
} 