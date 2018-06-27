<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="../custom/uimaker/easyui.css">
<script type="text/javascript" src="../custom/jquery.min.js"></script>
<script type="text/javascript" src="../custom/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../custom/easyui-lang-zh_CN.js"></script>
<link rel="stylesheet" type="text/css" href="../custom/uimaker/icon.css">
<title>学员反馈</title>
<script type="text/javascript">
function formatOper(val,row,index){  
	    return '<a id="row'+index+'" href="javascript:openDoubtdlg('+index+');">详情</a>'; 
} 
function openDoubtdlg(index){  
	//$('#dd').dialog('refresh',$('#dg').datagrid('getData').rows[index].doubtcontent);
	   $('#dlg').dialog('open');
	   $('div#name').text("姓名："+$('#dg').datagrid('getData').rows[index].stuname);
	   $('div#doubtcontent').text($('#dg').datagrid('getData').rows[index].doubtcontent);
	   $('div#Id').text($('#dg').datagrid('getData').rows[index].Id);
	   //$('#dg').datagrid('getData').rows[index].doubtcontent
}  
function closeDialog(){
	$('#dlg').dialog('close');
}
function okDoubt(){
	$.post('../../okDoubt',{
		Id:$('div#Id').text()
	});
	$('#dlg').dialog('close');
	$('#dg').datagrid('load');
}
var editIndex;
function endEditing(){
	if (editIndex == undefined){return true}
	if ($('#dg').datagrid('validateRow', editIndex)){
		$('#dg').datagrid('endEdit', editIndex);
		//editIndex = undefined;
		return true;
	} else {
		return false;
	}
}
$(function(){
	//console.info(editIndex);
	//$('#dg').datagrid('beginEdit', 0);
	 $("#dg").datagrid({ 
		  onDblClickRow : function(index,row){ 
			  if (editIndex != index){
				   $("a#row"+index).text("完成");
				   $("a#row"+index).attr({href:"javascript:finish("+index+")"});
					if (endEditing()){
						//console.info($('#dg').datagrid('getRows')[editIndex]);
						if($('#dg').datagrid('getRows')[editIndex]!=undefined){
							   $.post("../../modifyTrain",{
								   Id:$('#dg').datagrid('getRows')[editIndex].Id,
								   shuttlerun:$('#dg').datagrid('getRows')[editIndex].shuttlerun,
						   	       benchpress:$('#dg').datagrid('getRows')[editIndex].benchpress,
								   fmeters:$('#dg').datagrid('getRows')[editIndex]['50meters'],
								   ometers:$('#dg').datagrid('getRows')[editIndex]['1000meters'],
								   setshot:$('#dg').datagrid('getRows')[editIndex].setshot,
					   		       addtime:$('#dg').datagrid('getRows')[editIndex].addtime,
							      },'json');
							   }
						$('#dg').datagrid('selectRow', index)
								.datagrid('beginEdit', index);
						var ed = $('#dg').datagrid('getEditor', {index:index,field:row});
						if (ed){
							($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
						}
						editIndex = index;
					} else {
						setTimeout(function(){
							$('#dg').datagrid('selectRow', editIndex);
						},0);
					}
				}
			  //alert(editIndex);
		   }
	   });
})
function finish(index){
	$('#dg').datagrid('endEdit', index);
	$.post("../../modifyTrain",{
		   Id:$('#dg').datagrid('getRows')[index].Id,
		   shuttlerun:$('#dg').datagrid('getRows')[index].shuttlerun,
	       benchpress:$('#dg').datagrid('getRows')[index].benchpress,
		   fmeters:$('#dg').datagrid('getRows')[index]['50meters'],
		   ometers:$('#dg').datagrid('getRows')[index]['1000meters'],
		   setshot:$('#dg').datagrid('getRows')[index].setshot,
	       addtime:$('#dg').datagrid('getRows')[index].addtime,
	      },'json');
	editIndex=undefined;
}
</script>
</head>
<body>
  <table id="dg" class="easyui-datagrid"  url="../../feedBack" pagination="true" data-options="singleSelect:true,
                autoRowHeight:false,
                pagination:true,
                fitColumns:true,
                striped:true,
                collapsible:false,
                pageSize:10">
    <thead>
		<tr>
		    <th data-options="field:'Id',width:100,align:'center',hidden:true"></th>
			<th data-options="field:'stuId',width:100,align:'center'">学号</th>
			<th data-options="field:'stuname',width:100,align:'center'">姓名</th>
			<th data-options="field:'shuttlerun',width:100,align:'center',editor:{type:'numberbox',options:{precision:2,}}">折返跑</th>
			<th data-options="field:'benchpress',width:100,align:'center',editor:{type:'numberbox',options:{precision:2,}}">卧推</th>
			<th data-options="field:'50meters',width:100,align:'center',editor:{type:'numberbox',options:{precision:2,}}">50米跑</th>
			<th data-options="field:'1000meters',width:100,align:'center',editor:{type:'numberbox',options:{precision:2,}}">1000米跑</th>
			<th data-options="field:'setshot',width:100,align:'center',editor:{type:'numberbox',options:{min:0,max:10,precision:0,}}">定点投篮</th>
			<th data-options="field:'addtime',width:100,align:'center',editor:{type:'datebox',options:{required:true,}}">训练时间</th>
			<th data-options="field:'doubt',width:100,align:'center'" formatter="formatOper">详情！</th>
			<th data-options="field:'doubtcontent',width:100,align:'center',hidden:true"></th>
		</tr>
    </thead>
</table>
<div id="dlg" class="easyui-dialog" title="详情" closed="true" align="center" buttons="#dlg-buttons" style="width:400px;height:200px;"
data-options="iconCls:'icon-help',resizable:true,modal:true">
    <div id="name" style="position:relative;top:5px;">
    </div>
    <div id="doubtcontent" style="position:relative;top:22px;">
    </div>
    <div id="Id" hidden="true">
    </div>
</div>
<div id="dlg-buttons">
   <a href="javascript:okDoubt()" class="easyui-linkbutton" iconCls="icon-ok">完成</a>
   <a href="javascript:closeDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>
</body>
</html>