<!-- 描  述：保存焦点-->
<!-- 修改人：ty -->
<!-- 修改时间：2011-09-14 11:27:40-->
<%!
//解析焦点码的方法
public static class FocSaveUtil{	
	public FocSaveUtil(){}
	
	//根据字符获取数字
	public int getNumByChar(String chr){
		int num = 0;
		if(chr!=null&&!Character.isDigit(chr.charAt(0))){
			if(chr.length()==1){
				num = chr.charAt(0);
			}else if(chr.length()>1){
				num = chr.charAt(0)+Integer.parseInt(chr.substring(1));
			}
		}	
		if(num>=65&&num<=90){
			num = num - 65;
		}else if(num>=97&&num<=122){
			num = num - 97 + 26;
		}else{
			num = num - 71;
		}	
		return num;
	}
	
	public static ArrayList getArrByCode(String code){
		int i = 0;
		int t = 0;
		ArrayList tmp_codeArr = new ArrayList();
	
		while(i<code.length()){
			if(!Character.isDigit(code.charAt(i))){
				tmp_codeArr.add(String.valueOf(code.charAt(i)));
				i++;
				t++;             
			}else{
				tmp_codeArr.set(t-1,String.valueOf(tmp_codeArr.get(t-1))+String.valueOf(code.charAt(i)));
				i++;
			}
		}
		return tmp_codeArr;
	}
}

%>
<script type="text/javascript">
//根据字符获取数字
function getNumByChar(chr){
	var num;
	if(chr!=undefined&&isNaN(chr)){
		if(chr.length==1){
			num = chr.charCodeAt(0);
		}else if(chr.length>1){
			num = chr.charCodeAt(0)+parseInt(chr.substring(1));
		}
	}	
	if(num>=65&&num<=90){
		num = num - 65;
	}else if(num>=97&&num<=122){
		num = num - 97 + 26;
	}else{
		num = num - 71;
	}	
	return num;
}

//将FocCode转化为数组(需改为服务端)
function getArrByCode(code){
	var i = 0;
	var t = 0;
	var tmp_codeArr = new Array();

	while(i<code.length){
		if(isNaN(code.substr(i,1))){
			tmp_codeArr[t] = code.substr(i,1);
			i++;
			t++;             
		}else{
			tmp_codeArr[t-1] += code.substr(i,1);
			i++;
		}
	}
	return tmp_codeArr;
}

//将字符串数组转化为整形数组
function getDArrBySArr(strArr){
	var newArr = new Array()
	for(var i = 0;i < strArr.length;i++){
		newArr[i] = parseInt(getNumByChar(strArr[i]));
	}
	return newArr;
}

//将当前焦点状态保存为Code形式
function creatFocCode(){
	var foccodestr = getCharByNum(pageobj.curareaid);
	for(var i =0;i<pageobj.areas.length;i++){
		var curarea = pageobj.areas[i];
		var curindexstr = getCharByNum(curarea.curindex);
		foccodestr+=curindexstr;
	}
	return foccodestr;
}

//根据数字获取字符
function getCharByNum(num){
	if(num!=undefined&&num>-1){
		if(num>=0&&num<=25){  //65-90
			return String.fromCharCode(65+num);
		}else if(num>=26&&num<=51){ //97-122
			return String.fromCharCode(97+num-26);
		}else if(num>51){
			return String.fromCharCode(122)+(num-51);
		}
	}
}

//生成returnurl
function replaceUrl(url){
	if(url == undefined){
		url = location.href;
	}
	if(url.indexOf("foccode")!=-1){  //如果已包含（此处应改为< %request.getParameter("foccode")!=null % >）
		url.replace("foccode="+foccode,"foccode="+creatFocCode());
	}else{
		if(url.indexOf("?")!=-1){    //如果已经有其他参数（此处应改为< %request.getParameter()!=null % >）
			url += "&foccode="+creatFocCode();
		}else{
			url += "?foccode="+creatFocCode();
		}
	}
	return url;
}
</script>