<!-- 文件名：util_AdText.jsp -->
<!-- 描  述： -->
<!-- 修改人：xiachao -->
<!-- 修改时间：2011-02-14 -->
<%!
    public String getStrTrim(Object str){
		if(str != null && !"".equals(str)){
			return str.toString().trim();
		}
		else{
			return "";
		}
	}
%>
