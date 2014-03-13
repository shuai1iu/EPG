
<%!
	private static final String[] strArr =
	{ 		"Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", 
			"A", "S", "D", "F", "G", "H", "J", "K", "L", 
			"Z", "X", "C", "V", "B", "N", "M",
			
			"q", "w", "e", "r", "t", "y", "u", "i", "o", "p",
			"a", "s", "d", "f","g", "h", "j", "k", "l", 
			"z", "x", "c", "v", "b", "n", "m", 
			
			"`", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-", "=", "~",
			"!", "@", "#", "$", "%", "^", "&;", "*", "(", ")", "_", "+", "&",
			"[", "]", ";", "'", ".", "/", "\\", "{", "}", ":", "\"", "<", ">",
			"?", "|", "~", "！", "·", "#", "￥", "%", "……", "—", "（", "）", "——",
			" ", "。" };
	
	// 对应的单字宽度 字体Aerial 大小18PX
	private static final double[] widthArr =
	{ 		10, 11, 10, 10, 8, 10, 12, 5, 10, 9,
			9, 9, 10, 9, 10, 10, 7, 9, 7,
			9, 9, 9, 9, 9, 10, 12,
			
			/*7, 10, 7, 6, 6, 7, 7, 5, 7, 7, 
			8, 7, 7, 5, 7, 7, 5, 7, 5, 
			7, 7, 7, 7, 9, 7, 11,*/
			
			8, 11, 8, 7, 7, 8, 8, 6, 8, 8, 
			9, 8, 9, 6, 8, 8, 6, 8, 6, 
			8, 8, 8, 8, 10, 8, 12,
			
			7, 10, 10, 10, 10, 10, 10, 10, 10,
			10, 10, 6, 11, 11, 6, 22, 11, 10, 20, 10, 16, 10, 7, 7, 11, 11, 11,
			6, 6, 6, 5, 6, 7, 4, 7, 7, 6, 4, 11, 11, 10, 6, 11, 10, 17, 11, 19,
			17, 36, 19, 19, 19, 19, 6, 10 };
	
	private static int x = 0;
	
	public static String str = "";
	
	private static int strLength(String sourceStr, int len)
	{
		if(sourceStr==null||sourceStr.equals(" "))
		{
				return 0;
		}
		int width = 0;
		String tempStr = "";
		boolean flag = false;
		boolean subflag = false;
		int i;
		for (i = 0; i < sourceStr.length(); i++)
		{
			tempStr = sourceStr.substring(i, i + 1);
			for (int j = 0; j < strArr.length; j++)
			{
				if (strArr[j].equals(tempStr))
				{
					width += widthArr[j];
					flag = true;
					break;
				}

				else
				{
					flag = false;
				}
			}
			if (flag == false)
			{
				width += 15;
			}
			if (width > len && !subflag)
			{
				x = i;
				subflag = true;
			}
		}
		return width;
	}
	
	private static String subStringOneRow(String onestr, int len)
	{
		String temp = "";
		if (strLength(onestr, len) > len)
		{
			temp = onestr.substring(0, x - 1) + "";//temp = onestr.substring(0, x - 1) + "...";
		} 
		else
		{
			temp = onestr;
		}
		return temp;
	}
	
	private static String subStringManyRow(String onestr, int len)
	{
		String temp = "";
		if (strLength(onestr, len) > len)
		{
			temp = onestr.substring(0, x) + "<br>";
			str = onestr.substring(x, onestr.length());
		}
		else
		{

			if(x-1<=0)
			{
				return temp;
			}
		}
		
		return temp;
		
	}
	
	public  static String subStringFunction(String substing, int row, int len)
	{
		
		if(substing==null||substing.equals(" "))
		{
				return "";
		}
		str = substing;
		String temp = "";
		if (row == 1)
		{
			temp = subStringOneRow(substing, len);
		} 
		else
		{
			int residue = strLength(substing, len) % len;
			int therow = strLength(substing, len) / len;
			if(len<20)
			{
				return substing;
			}
			if (therow == row)
			{
				if (residue > 0)
				{
					for (int i = 0; i < row - 1; i++)
					{
						temp += subStringManyRow(str, len);
					}
					temp += subStringOneRow(str, len);
				}
				else
				{
					for (int i = 0; i < row - 1; i++)
					{
						temp += subStringManyRow(str, len);
					}
				}
			} 
			else if (therow > row)
			{
				for (int i = 0; i < row - 1; i++)
				{
					temp += subStringManyRow(str, len);
				}
				temp += subStringOneRow(str, len);
			} 
			else if (therow < row)
			{
				if (residue > 0)
				{
					if(residue<30)
					{
						for (int i = 0; i < therow; i++)
						{
							temp += subStringManyRow(str, len);
						}
						
						temp += subStringOneRow(str, len);
					}
					else
					{
						for (int i = 0; i < therow; i++)
						{
							temp += subStringManyRow(str, len);
						}
						temp += subStringOneRow(str, len);
					}
					
				} 
				else
				{
					if(residue<30)
					{
						for (int i = 0; i < row - 1; i++)
						{
							temp += subStringManyRow(str, len);
						}
					}
					else
					{
						for (int i = 0; i < row-1; i++)
						{
							temp += subStringManyRow(str, len);
						}
						temp += subStringOneRow(str, len);
					}
				}
				
			}
		}
		return temp;
	}


public int stringLength(String sourceStr)
{
	int width=0; 
	//单字字符数组
	String[] strArr={"Q","W","E","R","T","Y","U","I","O","P","A","S","D","F","G","H","J","K","L","Z","X","C","V","B","N","M",
		"q","w","e","r","t","y","u","i","o","p","a","s","d","f","g","h","j","k","l","z","x","c","v","b","n","m",
		"`","1","2","3","4","5","6","7","8","9","0","-","=",
		"~","!","@","#","$","%","^","&;","*","(",")","_","+","&",
		"[", "]" ,";" ,"'",".","/","\\",
		"{",  "}"  ,":"  ,"\""  ,"<"  ,">"  ,"?"  ,"|",
		"~", "！" ,"·" ,"#" ,"￥" ,"%" ,"……" ,"—" ,"（" ,"）" ,"——" ," ","。"};
	//对应的单字宽度 字体Aerial 大小18PX			
	double[] widthArr={10,11,10,10,8,10,12,5,10,9,9,9,10,9,10,10,7,9,7,9,9,9,9,9,10,10,
		7,10,7,6,6,7,7,5,7,7,8,7,7,5,7,7,5,7,5,7,7,7,7,7,7,11,
		7,10,10,10,10,10,10,10,10,10,10,6,11,
		11,6,22,11,10,20,10,16,10,7,7,11,11,11,
		6,6,6,5,6,7,4,
		7,7,6,4,11,11,10,6,
		11,10,17,11,19,17,36,19,19,19,19,6,10};		
	
	String tempStr = null;
	boolean flag = false;
	for(int i=0;i<sourceStr.length();i++)
	{
		tempStr = sourceStr.substring(i, i+1);
		for(int j=0;j<strArr.length;j++)
		{
			if(strArr[j].equals(tempStr))
			{
				width += widthArr[j];
				flag = true;
				break;
			}	
			else
			{
				flag = false;
			}
		}
		if(flag == false)
		{
			width += 18;
		}
	}			
	return width;		
}
%>