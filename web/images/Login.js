//***************************************************************************
//
// THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF
// ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO
// THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
// PARTICULAR PURPOSE.
//
// Copyright (C) 2004 Z-SoftNet LLC, All Rights Reserved.
//***************************************************************************



/*
*	Encrypts the specified parts of user data using the specified
*	crypto Provider.
*/
function Login_Encrypt(pwdControl,logNameControl,encryptionMode,cryptoProvider)
{			
	if ( pwdControl.value.length > 1 && logNameControl.value.length > 1 &&  encryptionMode != "None")
	{			
		switch(cryptoProvider)
		{
			case ('MD5'):
				Encrypt_MD5(pwdControl,logNameControl,encryptionMode);				
				break;
			case ('SHA1'):
				Encrypt_SHA1(pwdControl,logNameControl,encryptionMode);					
				break;
			case ('MD4'):
				Encrypt_MD4(pwdControl,logNameControl,encryptionMode);		
				break;
			default:
				break;
		}
		return true;	
	} else {
		return false;	
	}
}


/*
*	Encrypts the specified parts of user data using the SHA1
*	Crypto Provider.
*/
function Encrypt_SHA1(pwdCtl,logNameCtl,encrMode)
{	
	var logNameText;
	var passText;
		
	switch(encrMode)
	{
			case ('Password'):
				passText = hex_sha1(pwdCtl.value);
				pwdCtl.value = passText.toUpperCase();				
				break;
			case ('Login'):
				logNameText = hex_sha1(logNameCtl.value);
				logNameCtl.value = logNameText.toUpperCase();	
				break;
			case ('Both'):
				passText = hex_sha1(pwdCtl.value);
				pwdCtl.value = passText.toUpperCase();	
				logNameText = hex_sha1(logNameCtl.value);
				logNameCtl.value = logNameText.toUpperCase();	
				break;
			default:
				break;
	}			
}

/*
*	Encrypts the specified parts of user data using the MD5
*	Crypto Provider.
*/
function Encrypt_MD5(pwdCtl,logNameCtl,encrMode)
{	
	var logNameText;
	var passText;
		
	switch(encrMode)
	{
			case ('Password'):
				passText = hex_md5(pwdCtl.value);
				pwdCtl.value = passText.toUpperCase();				
				break;
			case ('Login'):
				logNameText = hex_md5(logNameCtl.value);
				logNameCtl.value = logNameText.toUpperCase();	
				break;
			case ('Both'):
				passText = hex_md5(pwdCtl.value);
				pwdCtl.value = passText.toUpperCase();	
				logNameText = hex_md5(logNameCtl.value);
				logNameCtl.value = logNameText.toUpperCase();	
				break;
			default:
				break;
	}			
}


/*
*	Encrypts the specified parts of user data using the MD5
*	Crypto Provider.
*/
function Encrypt_MD4(pwdCtl,logNameCtl,encrMode)
{	
	var logNameText;
	var passText;
		
	switch(encrMode)
	{
			case ('Password'):
				passText = hex_md4(pwdCtl.value);
				pwdCtl.value = passText.toUpperCase();				
				break;
			case ('Login'):
				logNameText = hex_md4(logNameCtl.value);
				logNameCtl.value = logNameText.toUpperCase();	
				break;
			case ('Both'):
				passText = hex_md4(pwdCtl.value);
				pwdCtl.value = passText.toUpperCase();	
				logNameText = hex_md4(logNameCtl.value);
				logNameCtl.value = logNameText.toUpperCase();	
				break;
			default:
				break;
	}			
}

