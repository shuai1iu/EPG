	<script>
	/*
	   函数说明：用于创建数据背景表格
	   参数说明：div_name 装载该背景表格的层
	   rows 背景表格的行数
	   cols 背景表格的列数
	   td_width 表格单元的宽
	   td_height 表格单元的高
	   image_path 表格单元里的图片路径
	   img_width 表格单元里的图片宽度
	   img_height 表格单元里的图片高度
	   border 表格边框(供调试用)
	*/
	function create_datatable(div_name,rows,cols,td_width,td_height,image_path,img_width,img_height,border)
	{
		var table = '<table width="'+ td_width*cols +'" height="'+ td_height*rows +'" cellpadding="0" cellspacing="0" border="'+ border +'">';
		
		for(var i = 0; i < rows; i++)
		{
		   table += '<tr>';

              for(var j = 0; j < cols; j++)
			  {
		   		table += '<td width="'+ td_width +'" height="'+ td_height +'" valign="middle">';
		   		table += '<img id="img' + String(i*cols + j) + '" src="'+ image_path +'" width="'+ img_width +'" height="'+ img_height +'"/></td>';
		   	  }
			  
		   table += '</tr>';
		}
		
		table += '</table>';
		
		document.getElementById(div_name).innerHTML = table;
	}
	
	/*
	   函数说明：用于创建数据表格
	   参数说明：div_name 装载该数据表格的层
	   rows 数据表格的行数
	   cols 数据表格的列数
	   td_width 表格单元的宽
	   td_height 表格单元的高
	   image_position 数据功能图标位置 取值为 left right none
	   img_width 表格单元里的图片宽度
	   img_height 表格单元里的图片高度
	   offset 功能图标位置偏移量 image_position为right时使用 用于调整功能图标和数据的距离
	   border 表格边框(供调试用)
	   curr_page 当前页或数据段当前页
	   list_name 数据列表或数据段列表
	   image_path 功能图标的图片路径
	*/
	function create_data(div_name,rows,cols,td_width,td_height,image_position,img_width,img_height,offset,border,curr_page,list_name,image_path)
	{
		var table = '<table width="'+ td_width*cols +'" height="'+ td_height*rows +'" cellpadding="0" cellspacing="0" border="'+ border +'">';
		
		for(var i = 0; i < rows; i++)
		{
		  table += '<tr>';

		  for(var j = 0; j < cols; j++)
		  {
		        var index = (i*cols + j) + (curr_page*(rows*cols));

                if(image_position == 'left')
				{
					if(list_name[index] != null)
					{
						table += '<td width="'+ td_width +'" height="'+ td_height +'" align="left"><img src="'+ image_path +'" width="'+ img_width +'" height="'+ img_height +'"/>&nbsp;' + list_name[index];
						table += '</td>';
					}
					else
					{
						table += '<td width="'+ td_width +'" height="'+ td_height +'">';
						table += '</td>';
					}					
				}
				else if(image_position == 'right')
				{
					if(list_name[index] != null)
					{
						table += '<td width="'+ (td_width - img_width - offset) +'" height="'+ td_height +'" align="left">' + list_name[index];
						table += '</td><td width="'+ (img_width + offset) +'"><img src="'+ image_path +'" width="'+ img_width +'" height="'+ img_height +'" /></td>';					
					}
					else
					{
						table += '<td width="'+ td_width +'" height="'+ td_height +'" colspan="2" align="center">';
						table += '</td>';						
					}
				}
				else if(image_position == 'none')
				{
					if(list_name[index] != null)
					{
						table += '<td width="'+ td_width +'" height="'+ td_height +'">' + list_name[index];
						table += '</td>';
					}
					else
					{
						table += '<td width="'+ td_width +'" height="'+ td_height +'">';
						table += '</td>';
					}					
				}
		  }
			  
		  table += '</tr>';
		}
		
		table += '</table>';
		
		document.getElementById(div_name).innerHTML = table;
	}
</script>