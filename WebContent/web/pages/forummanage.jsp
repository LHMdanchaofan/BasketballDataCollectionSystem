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
<script type="text/javascript">
$(function(){
	$('#dg').datagrid({
		onLoadSuccess:function(data){
			for(var i=0;i<data.rows.length;i++){
			  $('#display'+i).switchbutton({
		            checked: true,
		            onText:"显示",
		            offText:"隐藏",
		            onChange: function(checked){
		            	$.post("../../modifyForumDisplay",{
		            		Id:$('#dg').datagrid('getRows')[$(this).attr('id').substring(7,8)].Id,
		            		checked:checked
		            	},function(result){
		            		if(result.result=="success"){
		            			$.messager.show({
		            				title:'提示',
		            				msg:'修改成功',
		            				timeout:1000,
		            				showType:'fade'
		            			});
		            		}else{
		            			$('#dg').datagrid('reload');
		            			$.messager.show({
		            				title:'提示',
		            				msg:result.errorMsg,
		            				timeout:1000,
		            				showType:'fade'
		            			});
		            			//console.info(chk);		            			
		            		}
		            	},'json')		 
		            }
			  });
			}
			for(var i=0;i<data.rows.length;i++){
			  $('#undisplay'+i).switchbutton({
				  checked: false,
		            onText:"显示",
		            offText:"隐藏",
		            onChange: function(checked){
		            	$.post("../../modifyForumDisplay",{
		            		Id:$('#dg').datagrid('getRows')[$(this).attr('id').substring(9,10)].Id,
		            		checked:checked
		            	},function(result){
		            		if(result.result=="success"){
		            			$.messager.show({
		            				title:'提示',
		            				msg:'修改成功',
		            				timeout:1000,
		            				showType:'fade'
		            			});
		            		}else{
		            			$('#dg').datagrid('reload');
		            			$.messager.show({
		            				title:'提示',
		            				msg:result.errorMsg,
		            				timeout:1000,
		            				showType:'fade'
		            			});
		            		}
		            	},'json')		 
		            }
			  });
			}
		}});
})
function formatOper(val,row,index){
	if(val==1){
		return  '<a id="display'+index+'"></a>'
	}else{
		return '<a id="undisplay'+index+'"></a>'
	}
}
function openadddialog(){
	$('#dlg').dialog('open');
	$('#name').val("");
	$('#url').val("");
}
function closeDialog(){
	$('#dlg').dialog('close');
}
//function change(){
//	console.info($('#dg').datagrid("getSelected"))
//}
function addTrain(){
	$('#fm').form('submit', {
	    onSubmit: function(){
	    	if($('#fm').form('validate')){
	    		return true
	    	}else{
	    		return false;
	    	}
	    },
	     success:function(result){
	    	 if(JSON.parse(result).result=="success"){
	    		 $.messager.show({
	    				title:'提示',
	    				msg:'添加成功',
	    				timeout:1000,
	    				showType:'fade'
	    			});
	    		 $('dg').datagrid('reload');
	    		 closeDialog();
	    	 }
	    	 else{
	    		 $.messager.show({
	    				title:'提示',
	    				msg:'添加失败',
	    				timeout:1000,
	    				showType:'fade'
	    			});
	    	 }
	    }
	});
}
function deleteforum(){
	if($("#dg").datagrid("options").columns[0][0].hidden){
		$("#dg").datagrid("uncheckAll");
		$("#dg").datagrid("showColumn","ck");
		$.messager.show({
			title:'提示',
			msg:'请选择要删除的新闻',
			timeout:1000,
			showType:'fade'
		});
	}else if($("#dg").datagrid("getChecked").length){
		var checkedRows=$("#dg").datagrid("getChecked");
		var delIds=[];
		for(var i=0;i<checkedRows.length;i++){
			delIds.push(checkedRows[i].Id);
		}
		var ids=delIds.join(",");
		$.messager.confirm("系统提示","您确认要删掉这<font color=red>"+checkedRows.length+"</font>条数据吗？",function(r){
			if(r){
				$("#dg").datagrid("hideColumn","ck");
				$("#dg").datagrid("uncheckAll");
				$('#dg').datagrid({singleSelect:(this.value==0)})
				$.post("../../deleteFriendForum",{delIds:ids},function(result){
					if(result.success){
						$.messager.alert("系统提示","您已成功删除<font color=red>"+result.delnums+"</font>条数据！");
						$("#dg").datagrid("reload");
					}else{
						$.messager.alert('系统提示',result.errorMsg);
					}
				},"json");
			}
		});
	}else{
		$("#dg").datagrid("hideColumn","ck");
		$("#dg").datagrid("uncheckAll");
	}
}
</script>
<title>论坛管理</title>
</head>
<body>
    <table id="dg" class="easyui-datagrid" data-options="url:'../../forumList',toolbar:'#tb',fitColumns:true">
            <thead>
                <tr>
                    <th id="cb" field="ck" checkbox="true" hidden="true"></th>
                    <th field="Id" align="center" width="100" hidden="true"></th>
                    <th field="forumname" align="center" width="100">论坛名称</th>
                    <th field="forumurl" align="center" width="100">论坛地址</th>
                    <th field="display" align="center" width="100" formatter="formatOper">显示</th>
                </tr>
            </thead>
        </table>
        <div id="tb" style="height:37px">
          <a href="javascript:openadddialog()" class="easyui-linkbutton" iconCls="icon-add" style="position:relative;top:-10px">添加</a>
          <a href="javascript:deleteforum()" class="easyui-linkbutton" toggle="true" iconCls="icon-remove" style="position:relative;top:-10px">删除</a>
        </div>
        <div id="dlg" class="easyui-dialog"  align="center" buttons="#dlg-buttons" data-options="
                title: '添加论坛信息',
	            width:300,
	            height:200,
	            closable:false,
	            closed:true,
	            modal:true,
				iconCls: 'icon-add'">
		   <form id="fm" method="post" action="../../addFriendForum">
			<table  style="position:relative;top:30px;font-size:18px;">
               <tr>
                  <td>论坛名称：</td>
                  <td><input id="name" name="name" class="easyui-validatebox" missingMessage="论坛名称不能为空" required="required"></td>
               </tr> 
                <tr>
                  <td>论坛地址：</td>
                  <td><input id="url" name="url" class="easyui-validatebox" missingMessage="论坛地址不能为空" invalidMessage="请输入有效的地址！例：http://www.baidu.com" data-options="required:true,validType:'url'"></td>
               </tr>      
          </table>
          </form>
</div>
<div id="dlg-buttons">
   <a href="javascript:addTrain()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
   <a href="javascript:closeDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>
</body>
</html>