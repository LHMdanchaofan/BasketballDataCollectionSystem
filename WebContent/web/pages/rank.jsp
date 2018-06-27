<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en"> 
<head> 
    <meta charset="utf-8"> 
    <meta name="viewport" content="width=device-width, initial-scale=1"> 
    <title>篮球大数据青少年数据采集与展示系统</title> 
<link href="css/base.css" rel="stylesheet">
<link rel="stylesheet" href="../custom/uimaker/easyui.css">
<script type="text/javascript" src="../custom/jquery.min.js"></script>
<script type="text/javascript" src="../custom/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../custom/easyui-lang-zh_CN.js"></script>
<link rel="stylesheet" href="css/providers1.css">
<link rel="stylesheet" type="text/css" href="../custom/uimaker/icon.css">
<script type="text/javascript" src="js/main.js"></script>
<script type="text/javascript">    
function formatRank(val,row,index){
	return index+1;
}

$(function(){
	$('#pp').tooltip({
		position: 'bottom',
		content: '<div style="padding:5px;background:#eee;color:#000">数据来自年龄与你相差一岁以内，性别与你相同的学员的训练数据.</div>',
		onShow: function(){
			$(this).tooltip('tip').css({
				backgroundColor: '#fff000',
				borderColor: '#ff0000',
				boxShadow: '1px 1px 3px #292929'
			});
		},
		onPosition: function(){
			$(this).tooltip('tip').css('left', $(this).offset().left);
			$(this).tooltip('arrow').css('left', 20);
		}
	});
});
$(function(){
	$('#datarang').combobox({
	    onChange: function(newValue,oldValue){
	    	$('#dg').datagrid('load',{
	    		datarang:newValue,
	    		datatype:$('#datatype').combobox("getValue"),
	    		datatime:$('#datatime').combobox("getValue"),
	    	});
	}
});
})
$(function(){
	$('#datatype').combobox({
	    onChange: function(newValue,oldValue){
	    	$('#dg').datagrid('load',{
	    		datarang:$('#datarang').combobox("getValue"),
	    		datatype:newValue,
	    		datatime:$('#datatime').combobox("getValue")
	    	});
	}
});
})
$(function(){
	$('#datatime').combobox({
	    onChange: function(newValue,oldValue){
	    	$('#dg').datagrid('load',{
	    		datarang:$('#datarang').combobox("getValue"),
	    		datatype:$('#datatype').combobox("getValue"),
	    		datatime:newValue
	    	});
	}
});
})
</script>
</head>
<body>
    <div class="container">
       <table id="dg" class="easyui-datagrid" url="../../rankList" style="width:100%" title="排名" data-options="
                singleSelect:false,
                autoRowHeight:false,
                pagination:true,
                fitColumns:true,
                striped:true,
                checkOnSelect:false,
                selectOnCheck:false,
                toolbar:'#tb',
                collapsible:true,
                pageSize:10">
            <thead>
                <tr>
                    <th field="rank" width="100" align="center" formatter="formatRank">排名</th>
                    <th field="stuId" align="center" width="100">学号</th>
                    <th field="stuname" align="center" width="100">学员姓名</th>
                    <th field="coaname" align="center" width="100">教练姓名</th>
                    <th field="clubname" align="center" width="150">所属训练中心</th>
                    <th field="province" align="center" width="100">省份</th>
                    <th field="shuttlerun" align="center" width="100" sortable="true" order="asc">折返跑/s</th>
                    <th field="benchpress" align="center" width="100" sortable="true" order="desc">卧推/kg</th>
                    <th field="50meters" align="center" width="100" sortable="true" order="asc">50米跑/s</th>
                    <th field="1000meters" align="center" width="100" sortable="true" order="asc">1000米跑/s</th>
                    <th field="setshot" align="center" width="100" sortable="true" order="desc">定点投篮</th>
                </tr>
            </thead>
        </table>
        <div id="tb" style="padding:0 30px;">
         <div class="conditions">
           <div class="easyui-layout" style="height:60px;">
		      <div data-options="region:'west',collapsible:'false'" align="center" style="width:100px;">
		           <div id="pp"  class="easyui=panel">
                       <div><font size="3">提示</font></div>
		           </div>
	             </div>
		      <div data-options="region:'center'" align="center">
		       <div style="position:relative;top:1px;">
		          <font size="3">范围：</font>
		          <input class="easyui-combobox" id="datarang" name="datarang" style="width:150px" value="1" data-options="panelHeight:'auto',editable:false,valueField:'rangId',textField:'rangtext',url:'../../getRangComboList'"/>
		          <font size="3">类型：</font>
		          <select class="easyui-combobox" id="datatype" name="datatype" editable="false" value="1" panelHeight="auto" style="width:100px">
		           <option value="1">最好成绩</option>
		           <option value="2">平均成绩</option>
		          </select>
		          <font size="3">时间：</font>
		          <select class="easyui-combobox" id="datatime" name="datatime" editable="false" value="1" panelHeight="auto" style="width:100px">
		           <option value="1">全部</option>
		           <option value="2">本月</option>
		           <option value="3">本周</option>
		          </select>
		       </div>
		      </div>
          </div>
      </div>
  </div>
 </div>
</body>
</html>