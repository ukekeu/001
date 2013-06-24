
//####################### ��Ű�� ���´� #########################
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


//####################### ��Ű�� �����Ѵ� #########################
function setCookie( name, value, expiredays ) 
{ 
    var todayDate = new Date(); 
    todayDate.setDate( todayDate.getDate() + expiredays ); 
    document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";" 
} 



//####################### ��Ű ���� �� ������ �ݱ� #########################
// üũ�ڽ� ��Ʈ�� : control
// ��Ű�� ����� Ű : key
function AcceptCookieNCloseWindow(control, key) 
{ 
        if (control.checked) 
			setCookie(key, "done" , 1);  // ������ ���ڴ� ��Ű�� ������ �Ⱓ�� �����մϴ�
        opener.focus();
        window.close(); 
} 