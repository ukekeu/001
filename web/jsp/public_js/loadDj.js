//装入单据  
function LoadVoucher(id)
{
	if (id!=0)
		{
			userData=menu.oForm.oInput
			SaveUserData("Temp","VoucherID",id+"")
			window.open("pz.htm","topic")
		}
}

function LoadSendOut(id)
{
	if (id!=0)
		{
		  
		  userData=menu.oForm.oInput
			SaveUserData("Temp","SendOutID",id+"")
			window.open("sendout.htm","topic")

		}

}

function LoadPayIn(id)
{
	if (id!=0)
		{
		  
		  userData=menu.oForm.oInput
			SaveUserData("Temp","PayInID",id+"")
			window.open("PayIn.htm","topic")

		}

}
function LoadReceive(id)
{
	if (id!=0)
		{
		  
		  userData=menu.oForm.oInput
			SaveUserData("Temp","ReceiveID",id+"")
			window.open("receive.htm","topic")

		}

}

function LoadPayOut(id)
{
	if (id!=0)
		{
		  
		  userData=menu.oForm.oInput
			SaveUserData("Temp","PayOutID",id+"")
			window.open("PayOut.htm","topic")

		}

}
