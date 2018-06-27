<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en"> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>篮球大数据青少年数据采集与展示系统</title>
<link rel="stylesheet" href="../custom/uimaker/easyui.css">
<script type="text/javascript" src="../custom/jquery.min.js"></script>
<script type="text/javascript" src="../custom/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../custom/easyui-lang-zh_CN.js"></script>
<link rel="stylesheet" type="text/css" href="../custom/uimaker/icon.css">
<script type="text/javascript">
var abc;
var bcd;
var editIndex;
function endEditing(){
	if (editIndex == undefined){return true}
	if ($('#dg1').datagrid('validateRow', editIndex)){
		$('#dg1').datagrid('endEdit', editIndex);
		//editIndex = undefined;
		return true;
	} else {
		return false;
	}
}
window.onload=function before(){
	   $("#dg").datagrid({ 
		   onClickRow : function(index,row){ 
			   abc=row.stuId;
			   bcd=row.stuname;
			   $('#dg').datagrid({    
				       rowStyler:function(index,row){   
				           if (row.stuId==abc){    
				               return 'background-color:#F9990E;';    
				           }    
				       }    
				   });    
			      $('#dg1').datagrid('load',{
			           id:abc
			       });
		   }
	   });
	   $("#dg1").datagrid({
		   onDblClickRow :function(index,row){
			   if (editIndex != index){
					if (endEditing()){
						//alert(editIndex);
						//console.info($('#dg1').datagrid('getRows')[editIndex]);
						if($('#dg1').datagrid('getRows')[editIndex]!=undefined){
						   $.post("../../modifyTrain",{
							   Id:$('#dg1').datagrid('getRows')[editIndex].Id,
							   shuttlerun:$('#dg1').datagrid('getRows')[editIndex].shuttlerun,
					   	       benchpress:$('#dg1').datagrid('getRows')[editIndex].benchpress,
							   fmeters:$('#dg1').datagrid('getRows')[editIndex]['50meters'],
							   ometers:$('#dg1').datagrid('getRows')[editIndex]['1000meters'],
							   setshot:$('#dg1').datagrid('getRows')[editIndex].setshot,
							   addtime:$('#dg1').datagrid('getRows')[editIndex].addtime,
						      },'json')						      
						   }
						$('#dg1').datagrid('selectRow', index)
								.datagrid('beginEdit', index);
						var ed = $('#dg1').datagrid('getEditor', {index:index,field:row});
						if (ed){
							($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
						}
						editIndex = index;
						//alert(editIndex);
					} else {
						setTimeout(function(){
							$('#dg1').datagrid('selectRow', editIndex);
						},0);
					}
			   }
		   }
	   });
}

function doSearch(value,name){
	if(value==""){
		$.messager.show({
			title:'提示',
			msg:'输入栏不能为空',
			timeout:1000,
			showType:'fade'
		});
	}else if(name=="stuId"){
		  if(isNaN(value)){
			  $.messager.show({
					title:'提示',
					msg:'学号检索栏只能输入数字',
					timeout:1000,
					showType:'fade'
				});
		  }else{
			  $('#dg').datagrid('load',{
					value:value,
					name:name,
					});	
			  $('#dg1').datagrid('loadData',{total:0,rows:[]}); 
			  $('#dg').datagrid('clearSelections');
			  for(var i=0;i<10;i++){
				  $('#dg').datagrid({    
				       rowStyler:function(index,row){   
				           if (index==i){    
				               return 'background-color:#FFFFFF;';    
				           }    
				       }    
				   });   
				} 
		  }			
	}else if(name=="stuname"){
		$('#dg').datagrid('load',{
			value:value,
			name:name,
			});
			$('#dg1').datagrid('loadData',{total:0,rows:[]}); 
		  $('#dg').datagrid('clearSelections');
		  for(var i=0;i<10;i++){
			  $('#dg').datagrid({    
			       rowStyler:function(index,row){   
			           if (index==i){    
			               return 'background-color:#FFFFFF;';    
			           }    
			       }    
			   });   
			} 
	}
	abc=undefined;
}
function reset(){
	$('#ss').searchbox('setValue', '');
	$('#begintime').searchbox('setValue', '');
	$('#endtime').searchbox('setValue', '');
	$('#dg').datagrid('load',{
		value:null,
		name:null,		
});
	$('#dg1').datagrid('loadData',{total:0,rows:[]});
for(var i=0;i<10;i++){
		  $('#dg').datagrid({    
		       rowStyler:function(index,row){   
		           if (index==i){    
		               return 'background-color:#FFFFFF;';    
		           }    
		       }    
	});   
} 
 abc=undefined;
}
function searchTrain(){
	$('#dg1').datagrid('load',{
	    id:abc,
        begintime:$('#begintime').combobox('getValue'),
        endtime:$('#endtime').combobox('getValue')
    });
}
$(function(){
	var buttons = $.extend([], $.fn.datebox.defaults.buttons);
    buttons.splice(1, 0, {
	text: '清空',
	handler: function(target){
		$('#begintime').searchbox('setValue', '');
	}
});
$('#begintime').datebox({
	buttons: buttons
});
})
$(function(){
	var buttons = $.extend([], $.fn.datebox.defaults.buttons);
    buttons.splice(1, 0, {
	text: '清空',
	handler: function(target){
		$('#endtime').searchbox('setValue', '');
	}
});
$('#endtime').datebox({
	buttons: buttons
});
})
function openDialog(){
	if(abc==undefined){
		  $.messager.show({
				title:'提示',
				msg:'请选择要添加训练信息的学员',
				timeout:1000,
				showType:'fade'
			});
	}else{
	   var myDate = new Date();
	   $('#dlg').dialog('open');
	   $('div#dlg').find('p#stuname').text("学号："+abc+"                                                 姓名："+bcd);
	   $('#db').datebox('setValue',myDate.getFullYear+"/"+myDate.getMonth+"/"+myDate.getDate);
	}
	//$('#dd').dialog('refresh', 'new_content.php');
}
function closeDialog(){
	$('#dlg').dialog('close');
	$('#shuttlerun').numberbox('setValue','');
	$('#benchpress').numberbox('setValue','');
	$('#50meters').numberbox('setValue','');
	$('#1000meters').numberbox('setValue','');
	$('#setshot').numberbox('setValue','');
	$('#setshot').numberbox('setValue','');
}
function addTrain(){
	$.post("../../addTrain",{
		  stuId:abc,
	      shuttlerun:$('#shuttlerun').numberbox('getValue'),
	      benchpress:$('#benchpress').numberbox('getValue'),
	      fmeters:$('#50meters').numberbox('getValue'),
	      ometers:$('#1000meters').numberbox('getValue'),
	      setshot:$('#setshot').numberbox('getValue'),
	      addtime:$('#db').datebox('getValue'),
	   },function(r){
		   closeDialog();
		   if(r.result=="success"){
			   $.messager.show({
					title:'提示',
					msg:'训练信息录入成功',
					timeout:1000,
					showType:'fade'
				});
			   $('#dg1').datagrid('load',{
		           id:abc
		       });
		   }else{
			   $.messager.show({
					title:'提示',
					msg:'训练信息录入失败',
					timeout:1000,
					showType:'fade'
			   });
		   }
	   },"json");
}
function deleteTrain(){
	if(abc==undefined){
		$('#dltra').linkbutton('unselect');
		  $.messager.show({
				title:'提示',
				msg:'请选择要删除训练信息的学员',
				timeout:1000,
				showType:'fade'
			});
	}else if($("#dg1").datagrid("options").columns[0][0].hidden){
		$("#dg1").datagrid("showColumn","ck");
		$("#dg1").datagrid("uncheckAll");
		$('#dg1').datagrid({singleSelect:(this.value==1)})
	}else if($("#dg1").datagrid("getChecked").length){
		var checkedRows=$("#dg1").datagrid("getChecked");
		var delIds=[];
		for(var i=0;i<checkedRows.length;i++){
			delIds.push(checkedRows[i].Id);
		}
		var ids=delIds.join(",");
		$.messager.confirm("系统提示","您确认要删掉这<font color=red>"+checkedRows.length+"</font>条数据吗？",function(r){
			if(r){
				$("#dg1").datagrid("hideColumn","ck");
				$("#dg1").datagrid("uncheckAll");
				$('#dg1').datagrid({singleSelect:(this.value==0)})
				$.post("../../deleteTrain",{delIds:ids},function(result){
					if(result.success){
						$.messager.alert("系统提示","您已成功删除<font color=red>"+result.delnums+"</font>条数据！");
						$("#dg1").datagrid("reload");
					}else{
						$.messager.alert('系统提示',result.errorMsg);
					}
				},"json");
			}
		});
	}else{
		$("#dg1").datagrid("hideColumn","ck");
		$("#dg1").datagrid("uncheckAll");
		$('#dg1').datagrid({singleSelect:(this.value==0)})
	}
}
function saveTrain(){
	//alert(editIndex);
	//console.info($('#dg1').datagrid('getRows')[editIndex]);
	$('#dg1').datagrid('endEdit', editIndex);
	if($('#dg1').datagrid('getRows')[editIndex]!=undefined){
		   $.post("../../modifyTrain",{
			   Id:$('#dg1').datagrid('getRows')[editIndex].Id,
			   shuttlerun:$('#dg1').datagrid('getRows')[editIndex].shuttlerun,
	   	       benchpress:$('#dg1').datagrid('getRows')[editIndex].benchpress,
			   fmeters:$('#dg1').datagrid('getRows')[editIndex]['50meters'],
			   ometers:$('#dg1').datagrid('getRows')[editIndex]['1000meters'],
			   setshot:$('#dg1').datagrid('getRows')[editIndex].setshot,
			   addtime:$('#dg1').datagrid('getRows')[editIndex].addtime,
		      },'json')						      
		   }	
	editIndex=undefined;
}
function modifyTrain(){	
	 if (editIndex != $('#dg1').datagrid('getRowIndex',$('#dg1').datagrid('getSelected'))){
			if (endEditing()){
	             editIndex=$('#dg1').datagrid('getRowIndex',$('#dg1').datagrid('getSelected'));
	              $('#dg1').datagrid('beginEdit', editIndex);
			}
	 }
}
</script>
</head>
<body class="easyui-layout">
   <div data-options="region:'west'" collapsible="false"  style="width:40%;padding:5px;background:#eee;">
       <table id="dg" class="easyui-datagrid" url="../../coaStuList" style="width:100%" title="我的学员" data-options="
                singleSelect:true,
                autoRowHeight:false,
                pagination:true,
                fitColumns:true,
                striped:true,
                toolbar:'#tb',
                collapsible:false,
                pageSize:10">
            <thead>
                <tr>
                    <th field="stuId" width="100" align="center">学号</th>
                    <th field="stuname" align="center" width="100">姓名</th>
                    <th field="sex" align="center" width="100">性别</th>
                </tr>
            </thead>
        </table>
   </div>
   <div data-options="region:'center'" style="padding:5px;background:#eee;">
   <table id="dg1" class="easyui-datagrid" url="../../trainList" style="width:100%" title="训练信息" data-options="
                singleSelect:true,
                autoRowHeight:false,
                pagination:true,
                fitColumns:true,
                striped:true,
                toolbar:'#tb1',
                collapsible:false,
                pageSize:10">
            <thead>
                <tr>
                    <th id="cb" field="ck" checkbox="true" hidden="true"></th>
                    <th field="Id" width="100" hidden="true">Id</th>
                    <th field="shuttlerun" width="100" data-options="
						editor:{
							type:'numberbox',
							options:{								
								precision:2,
							}
						}">折返跑/s</th>
                    <th field="benchpress" width="100" data-options="
						editor:{
							type:'numberbox',
							options:{								
								precision:2,
							}
						}">卧推/kg</th>
                    <th field="50meters" width="100" data-options="
						editor:{
							type:'numberbox',
							options:{								
								precision:2,
							}
						}">50米跑/s</th>
                    <th field="1000meters" width="100" data-options="
						editor:{
							type:'numberbox',
							options:{								
								precision:2,
							}
						}">1000米跑/s</th>
                    <th field="setshot" width="100" data-options="
						editor:{
							type:'numberbox',
							options:{								
								min:0,
								max:10,
								precision:0,
							}
						}">定点投篮/个</th>
                    <th field="addtime" width="100" data-options="
						editor:{
							type:'datebox',
							options:{								
								required:true,
							}
						}">训练时间</th>
                </tr>
            </thead>
        </table>
   </div>
   <div id="tb" style="height:50px" align="center">
          <div style="position:relative;top:0px;">
            <input id="ss" class="easyui-searchbox" data-options="prompt:'学员检索',menu:'#mm',searcher:doSearch" style="width:200px"></input>
	           <div id="mm" style="width:120px">
		             <div id="stuId" data-options="name:'stuId'">学号</div>
		             <div id="stuname" data-options="name:'stuname'">姓名</div>
		       </div>
		       <a class="easyui-linkbutton" href="javascript:reset()" plain="true">重置</a>
         </div>
   </div>
   <div id="tb1" style="height:80px">
        <div style="position:relative;top:-60px;left:-40px;height:50px">
            <a href="javascript:openDialog()" class="easyui-linkbutton" iconCls="icon-add">添加</a>
            <a href="javascript:modifyTrain()" class="easyui-linkbutton" iconCls="icon-edit">编辑</a>
            <a href="javascript:saveTrain()" class="easyui-linkbutton" iconCls="icon-save">保存</a>
            <a id="dltra" href="javascript:deleteTrain()" class="easyui-linkbutton" iconCls="icon-remove" toggle="true">删除</a>
        </div>
        <div style="position:relative;top:-130px;left:-40px;height:50px;">
            训练时间 从: <input id="begintime" name="begintime" editable="false" class="easyui-datebox" style="width:120px">到: <input id="endtime" name="endtime" editable="false" class="easyui-datebox" style="width:120px">
            <a href="javascript:searchTrain()" class="easyui-linkbutton" iconCls="icon-search">搜索</a>
        </div>
    </div> 
<div id="dlg" class="easyui-dialog"  align="center" buttons="#dlg-buttons" data-options="
                title: '提交训练成绩',
	            width:510,
	            height:250,
	            closable:false,
	            closed:true,
	            cache:false,
	            modal:true,
				iconCls: 'icon-add'">
		    <p id="stuname" style="white-space:pre;position:relative;left:-52px;">姓名：</p>
			<table>
		      	<tr>
			      <td style="position:relative;left:12px;">折返跑：<input class="easyui-numberbox"  data-options="precision:2," class="easyui-validatebox" id="shuttlerun" type="text"></td>
                  <td style="position:relative;right:-24px;">卧推：<input class="easyui-numberbox"  data-options="precision:2," id="benchpress"type="text"></td>
                </tr>
                <tr>
                  <td style="position:relative;left:22px;">50米：<input class="easyui-numberbox"  data-options="precision:2," id="50meters" type="text"></td>
                  <td style="position:relative;right:-8px;">1000米：<input class="easyui-numberbox"  data-options="precision:2," id="1000meters" type="text"></td>
                </tr>
                <tr>
                  <td style="position:relative;left:0px;">定点投篮：<input class="easyui-numberbox"  data-options="min:0,max:10,precision:0," id="setshot" type="text"></td>
                  <td style="position:relative;right:0px;">训练时间：<input id="db" class="easyui-datebox"></td>
                </tr>
              </table>
</div>
<div id="dlg-buttons">
   <a href="javascript:addTrain()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
   <a href="javascript:closeDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>
</body>
</html>