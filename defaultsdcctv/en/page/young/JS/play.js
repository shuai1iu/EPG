var col=2;
var row=2;
function buttonback()
{
	document.getElementById("ji_top").style.background="url('images/play_boxse.png')";
	document.getElementById("ji_down").style.background="url('images/play_boxse.png')";
	document.getElementById("book").style.background="url('images/play_boxse.png')";
	document.getElementById("play_again").style.background="url('images/play_boxse.png')";
	document.getElementById("play_end").style.background="url('images/play_boxse.png')";

}
function buttonchange(r){}
function getbuttonrowid()
{
	buttonback();
	switch(row)
	{
		case 1:
		document.getElementById("book").style.background="url('images/play_boxsel.png')";
		break;
		case 2:
		switch(col)
		{
		case 1:
		document.getElementById("ji_top").style.background="url('images/play_boxsel.png')";
		break;
		case 2:
		document.getElementById("play_end").style.background="url('images/play_boxsel.png')";
		break;
		case 3:
		document.getElementById("ji_down").style.background="url('images/play_boxsel.png')";
		break;
		}
		break;
		case 3:
		document.getElementById("play_again").style.background="url('images/play_boxsel.png')";
		break;
	}
}
function keyPress(keyval)
{
	
    //alert(keyval);
	switch(keyval)
	{
		case KEY_DOWN:
		case DOWN:
		if(row>=1&&row<=2)
		{
			row++;
			col=2;
			getbuttonrowid();
		}
		break;
		case KEY_UP:
		case UP:
		if(row>=2&&row<=3)
		{
			row--;
			col=2;
			getbuttonrowid();
		}
		break;
		case KEY_RIGHT:
		case RIGHT:
		if(row==2&&col>=1&&col<=2)
		{
			col++;
			getbuttonrowid();
		}
		break;
		case KEY_LEFT:
		case LEFT:
		if(row==2&&col>=2&&col<=3)
		{
			col--;
			getbuttonrowid();
		}
		break;
		case KEY_ENTER:
		case KEY_OK:
		case ENTER:
		gotowhat();
		break;
	}
}
function gotowhat()
{
	switch(row)
	{
		case 1:
		window.location.href="";
		break;
		case 2:
		switch(col)
		{
		case 1:
		window.location.href="";
		break;
		case 2:
		window.location.href="index.html";
		break;
		case 3:
		window.location.href="";
		break;
		}
		break;
		case 3:
		window.location.href="";
		break;
	}
}