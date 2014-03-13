function TurnPage()
{
	this._firstPage = "";//首页地址
	this._list = [];//页面url的堆栈
	this._isNeedSaveUrl = 1;

	this.setFirstPage = function (url)
	{
		this._firstPage = url;
	}

	this.setNeedSaveUrl = function (flag)
	{
		this._isNeedSaveUrl = flag;
	}

	this.goTo = function (url, doc)
	{
		doc.location.href = url;
	}
	
	//添加
	this.addUrl = function (url, isneed)
	{
		if(undefined != isneed) this._isNeedSaveUrl = isneed;
		if(this._isNeedSaveUrl == 1)
		{
			this._list.push(url);
		}
		this._isNeedSaveUrl = 1;
	}
	
	//返回到上一页面
	this.goBack = function (doc)
	{

		var returnUrl = this._firstPage;
		this._isNeedSaveUrl = 0;

		if (this._list.length > 0)
		{
			returnUrl = this._list.pop();
		}


		this.goTo(returnUrl, doc);
	}

	this.reset = function ()
	{
		this._list = [];
	}

	this.switchPageToCategory = function (innerFlag)
	{
		this._go(this._firstPage);
		this.reset();
	}
}
var TurnPage = new TurnPage();