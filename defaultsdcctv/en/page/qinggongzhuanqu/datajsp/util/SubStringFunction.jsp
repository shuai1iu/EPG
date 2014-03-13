<%@ page import="java.util.HashMap" %>
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
	{ 		16, 19, 13, 14, 12, 13, 14, 7, 16, 13,
			13, 13, 14, 12, 16, 14, 11, 13, 11,
			12, 13, 14, 13, 13, 14, 18,
			
			/*7, 10, 7, 6, 6, 7, 7, 5, 7, 7, 
			8, 7, 7, 5, 7, 7, 5, 7, 5, 
			7, 7, 7, 7, 9, 7, 11,*/
			
			11, 14, 11, 8, 7, 11, 11, 5, 11, 11, 
			11, 11, 11, 7, 11, 11, 5, 11, 5, 
			11, 11, 11, 11, 11, 11, 17,
			
			8, 11, 11, 11, 11, 11, 11, 11, 11,11, 11, 8, 12, 12,
			7, 20, 12, 11, 20, 10, 16, 10, 7, 7, 11, 11, 11,
			6, 6, 6, 5, 6, 7, 4, 7, 7, 6, 4, 11, 11, 10, 6, 11, 10, 17, 11, 19,
			17, 36, 19, 19, 19, 19, 6, 10 };
	
	private static HashMap getStringLen(String sourceStr, int len)
	{
		int strWidth = 0;
		HashMap retObj = new HashMap();
		retObj.put("isSub", false);
		retObj.put("index", 0);
		if(null == sourceStr || "".equals(sourceStr) || len<20)
		{
				return retObj;
		}
		for(int i=0; i<sourceStr.length(); i++)
		{
			String tempChar = String.valueOf(sourceStr.charAt(i));
			int j=0;
			for(; j<strArr.length; j++)
			{
				if(strArr[j].equals(tempChar))
				{
					strWidth += widthArr[j];
					break;
				}
			}
			if(j == strArr.length)strWidth += 20;
			if (strWidth > len)
			{
				retObj.put("isSub", true);
				retObj.put("index", new Integer(i));
				return retObj;
			}
		}
		return retObj;
	}
	
	private static String subStringFunction(String sourceStr, int row, int lenth)
	{
		String retStr = "";
		row = row <= 0?1:row;
		if(null == sourceStr || "".equals(sourceStr))
		{
				return "";
		}
		for(int i=0; i<row; i++)
		{
			HashMap strObj = getStringLen(sourceStr, lenth);
			if(((Boolean)strObj.get("isSub")).booleanValue())
			{
				if(i == row - 1)
				{
					retStr += sourceStr.substring(0, ((Integer)strObj.get("index")).intValue() - 1) + "...";
					break;
				}
				retStr += sourceStr.substring(0, ((Integer)strObj.get("index")).intValue()) + "</br>";
				sourceStr = sourceStr.substring(((Integer)strObj.get("index")).intValue(), sourceStr.length());	
			}
			else
			{
				retStr += sourceStr.substring(0, sourceStr.length());
				break;
			}
		}
		return retStr;
	}
%>