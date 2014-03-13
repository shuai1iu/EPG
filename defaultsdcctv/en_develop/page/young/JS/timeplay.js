var s=setInterval(fiveseconds,1000);
var num=5;
function fiveseconds()
{
	num--;
	if(num>0)
	{
	document.getElementById("text").innerHTML=num+"秒后自动返回";
	}else
	{
		window.clearInterval(s);
		window.location.href="index.html";
	}
}
function keyEvent()
{
	var val = event.which ;
	return keyPress(val);
}
var KEY_RETURN=8;
var KEY_ENTER = 13;//0x000D;
var KEY_OK = 13;//0x000D;
document.onirkeypress = keyEvent ;
document.onkeypress = keyEvent ;
function keyPress(keyval)
{
	switch(keyval)
	{
		case KEY_ENTER:
		case KEY_OK:
		case KEY_RETURN:
                window.location.href="index.html";
		break;
	}
}
