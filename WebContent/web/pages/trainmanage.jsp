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
<link rel="stylesheet" href="css/providers1.css">
<script type="text/javascript">
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
window.onload=function before(){
	   $("#dg").datagrid({
		   onDblClickRow :function(index,row){
			   if (editIndex != index){
					if (endEditing()){
						if($('#dg').datagrid('getRows')[editIndex]!=undefined){
						   $.post("../../modifyTrain",{
							   Id:$('#dg').datagrid('getRows')[editIndex].Id,
							   shuttlerun:$('#dg').datagrid('getRows')[editIndex].shuttlerun,
					   	       benchpress:$('#dg').datagrid('getRows')[editIndex].benchpress,
							   fmeters:$('#dg').datagrid('getRows')[editIndex]['50meters'],
							   ometers:$('#dg').datagrid('getRows')[editIndex]['1000meters'],
							   setshot:$('#dg').datagrid('getRows')[editIndex].setshot,
							   addtime:$('#dg').datagrid('getRows')[editIndex].addtime,
						      },'json')						      
						   }
						$('#dg').datagrid('selectRow', index)
								.datagrid('beginEdit', index);
						var ed = $('#dg').datagrid('getEditor', {index:index,field:row});
						if (ed){
							($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
						}
						editIndex = index;
						//alert(editIndex);
					} else {
						setTimeout(function(){
							$('#dg').datagrid('selectRow', editIndex);
						},0);
					}
			   }
		   }
	   });
}
function searchTrain(){
	//alert($('#begintime').datebox("getValue"));
	$('#dg').datagrid('load',{
		stuId:document.getElementById("stuId").value,
		stuname:document.getElementById("stuname").value,
		coaname:document.getElementById("coaname").value,
		clubname:document.getElementById("clubname").value,
		begintime:$('#begintime').datebox("getValue"),
	    endtime:$('#endtime').datebox("getValue"),
	});
}
function reset(){
	$('#stuId').textbox('setValue','');
	$('#stuname').textbox('setValue','');
	$('#coaname').textbox('setValue','');
	$('#clubname').textbox('setValue','');
	$('#begintime').datebox('setValue','');
	$('#endtime').datebox('setValue','');
	$('#dg').datagrid('load',{
		stuId:null,
		stuname:null,
		coaname:null,
		clubname:null,
		begintime:null,
		endtime:null,
	});
}
function save(){
	$('#dg').datagrid('endEdit', editIndex);
	if($('#dg').datagrid('getRows')[editIndex]!=undefined){
		   $.post("../../modifyTrain",{
			   Id:$('#dg').datagrid('getRows')[editIndex].Id,
			   shuttlerun:$('#dg').datagrid('getRows')[editIndex].shuttlerun,
	   	       benchpress:$('#dg').datagrid('getRows')[editIndex].benchpress,
			   fmeters:$('#dg').datagrid('getRows')[editIndex]['50meters'],
			   ometers:$('#dg').datagrid('getRows')[editIndex]['1000meters'],
			   setshot:$('#dg').datagrid('getRows')[editIndex].setshot,
			   addtime:$('#dg').datagrid('getRows')[editIndex].addtime,
		      },'json')						      
		   }	
	editIndex=undefined;
}
</script>
<title>学员管理</title>
</head>
<body>
     <table id="dg" class="easyui-datagrid" data-options="url:'../../allTrainList',pagination:true,fitColumns:true,toolbar:'#tb'">
      <thead>
        <tr>
          <th field="Id" width="100" align="center" hidden="true"></th>
          <th field="stuId" width="100" align="center">学号</th>
          <th field="stuname" align="center" width="150">姓名</th>
          <th field="coaname" align="center" width="150">教练</th>
          <th field="clubname" align="center" width="150">训练中心</th>
          <th field="shuttlerun" align="center" width="150" data-options="
						editor:{
							type:'numberbox',
							options:{								
								precision:2,
							}
						}">折返跑</th>
          <th field="benchpress" align="center" width="150" data-options="
						editor:{
							type:'numberbox',
							options:{								
								precision:2,
							}
						}">卧推</th>
          <th field="50meters" align="center" width="150" data-options="
						editor:{
							type:'numberbox',
							options:{								
								precision:2,
							}
						}">50米跑</th>
          <th field="1000meters" align="center" width="150" data-options="
						editor:{
							type:'numberbox',
							options:{								
								precision:2,
							}
						}">1000米跑</th>
          <th field="setshot" align="center" width="150" data-options="
						editor:{
							type:'numberbox',
							options:{								
								min:0,
								max:10,
								precision:0,
							}
						}">定点投篮</th>
          <th field="addtime" align="center" width="150" data-options="
						editor:{
							type:'datebox',
							options:{	
							     editable:false,							
								required:true,
							}
						}">训练日期</th>
         </tr>
         </thead>
      </table>
      <div id="tb" style="padding:0 30px;">
        <div class="conditions">
            <span class="con-span">学号：</span><input id="stuId" class="easyui-textbox" type="text" name="stuId"  style="width:166px;height:35px;line-height:35px;"></input>
            <span class="con-span">姓名： </span><input id="stuname" class="easyui-textbox" type="text" name="stuname"  style="width:166px;height:35px;line-height:35px;"></input>
            <a id="search" href="javascript:searchTrain()" class="easyui-linkbutton" iconCls="icon-search" data-options="toggle:true,group:'g1'">查询</a>
            <a id="reset" href="javascript:reset()" class="easyui-linkbutton" iconCls="icon-reload" data-options="toggle:true,group:'g1'">重置</a>
            <a id="more" href="#" class="easyui-linkbutton more" iconCls="icon-more" data-options="toggle:true,group:'g1'">更多</a>
            <a id="more" href="javascript:save()" class="easyui-linkbutton" iconCls="icon-save" data-options="toggle:true,group:'g1'">保存</a>
        </div>
        <div class="conditions hide">
            <span class="con-span">教练： </span><input class="easyui-textbox" id="coaname" name="coaname" type="text" style="width:166px;height:35px;line-height:35px;"></input>
            <span class="con-span">训练中心：</span><input class="easyui-textbox" id="clubname" name="clubname" type="text"  style="width:166px;height:35px;line-height:35px;"></input>
            <span class="con-span">起始日期：</span><input class="easyui-datebox" id="begintime" name="begintime" type="text"  editable="false" style="width:166px;height:35px;line-height:35px;"></input>
            <span class="con-span">截止日期：</span><input class="easyui-datebox" id="endtime" name="endtime" type="text"  editable="false" style="width:166px;height:35px;line-height:35px;"></input>
        </div>
      </div>
<script type="text/javascript">    
$(".more").click(function(){
    $(this).closest(".conditions").siblings().toggleClass("hide");
});
</script>
</body>
</html>