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
		queryParams: {
			identity:3
		}
	});
})
function formatOper(val,row,index){
	return '<a href="javascript:modifystu('+index+')">编辑</a>     <a href="javascript:deletestu('+index+')">删除</a>'
}
function modifystu(index){
	$('#dlg').dialog('open');
	$("#username").val($('#dg').datagrid('getRows')[index].username); 
	$("#password").val($('#dg').datagrid('getRows')[index].password);
	$("#Id").val($('#dg').datagrid('getRows')[index].Id);
	$("#oldpassword").val($('#dg').datagrid('getRows')[index].password);
}
function deletestu(index){
	$.messager.confirm('警告', '确认要删除该训练中心吗？(删除的训练中心账户下不能有教练账户)',function(r){
		if (r){
			$.post("../../deleteUser",{
				identity:3,
				Id:$('#dg').datagrid('getRows')[index].Id
			},function(result){
				if(result.result=="success"){
					$('#dg').datagrid('load');
				}else{
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
function search(){
	$('#dg').datagrid('load',{
		identity:3,
		searchname:document.getElementById("search").value,
	})
}
function closeDialog(){
	$('#dlg').dialog('close');
	$('#adddlg').dialog('close');
	$("#username").val(""); 
	$("#password").val("");
	$("#addusername").val(""); 
	$("#addpassword").val("");
}
function save(){
	$('#fm').form('submit', {
	    onSubmit: function(){
	    	if($('#fm').form('validate')){
	    		return true
	    	}else{
	    		return false;
	    	}
	    },
	     success:function(result){
	    	 if(JSON.parse(result).information=="修改成功"){
	    		 $.messager.show({
	    				title:'提示',
	    				msg:'修改成功',
	    				timeout:1000,
	    				showType:'fade'
	    			});
	    	 }else{
	    		 $.messager.show({
	    				title:'提示',
	    				msg:'修改失败',
	    				timeout:1000,
	    				showType:'fade'
	    		 });
	    	 }
	    	 $('#dg').datagrid('reload');
	    	closeDialog();
	    }
	});
}
function openadddialog(){
	$('#adddlg').dialog('open');
}
function add(){
	$('#fm1').form('submit', {
	    onSubmit: function(){
	    	if($('#fm1').form('validate')){
	    		return true
	    	}else{
	    		return false;
	    	}
	    },
	     success:function(result){
	    	 $.messager.show({
 				title:'提示',
 				msg:JSON.parse(result).result,
 				timeout:1000,
 				showType:'fade'
 		 });
	    	 $('#dg').datagrid('reload');
	    	closeDialog();
	    }
	});
}
</script>
<title>训练中心管理</title>
</head>
<body>
     <table id="dg" class="easyui-datagrid" data-options="url:'../../getUser',pagination:true,fitColumns:true,toolbar:'#tb'">
      <thead>
        <tr>
          <th field="Id" width="100" align="center">学号</th>
          <th field="username" align="center" width="150">账户</th>
          <th field="password" align="center" width="150">密码</th>
          <th field="formatter" align="center" width="150" formatter="formatOper">操作</th>
         </tr>
         </thead>
      </table>
      <div id="tb" style="height:38px">
          <font size="3" color="OrangeRed" style="position:relative;top:-7px;">用户名：</font><input id="search" type="text" style="position:relative;top:-9px;height:30px"> <a class="easyui-linkbutton" href="javascript:search()" iconCls="icon-search" style="position:relative;top:-10px;">搜索</a>
          <a class="easyui-linkbutton" href="javascript:openadddialog()" style="position:relative;top:-10px;" iconCls="icon-add">添加用户</a>
       </div>
       <div id="dlg" class="easyui-dialog"  align="center" buttons="#dlg-buttons" data-options="
                title: '编辑训练中心账户',
	            width:300,
	            height:200,
	            closable:false,
	            closed:true,
	            modal:true,
				iconCls: 'icon-add'">
		   <form id="fm" method="post" action="../../modifyPW">
			<table  style="position:relative;top:30px;font-size:18px;">
               <tr>
                  <td>账户：</td>
                  <td><input id="username" name="username" class="easyui-validatebox" readonly></td>
               </tr> 
                <tr>
                  <td>密码：</td>
                  <td><input id="password" name="password" class="easyui-validatebox" required="true" missingMessage="密码不能为空"></td>
               </tr>   
          </table>
          <input id="Id" name="Id" type="text" hidden="true"> 
          <input id="oldpassword" name="oldpassword" hidden="true">  
        </form>
     </div>
      <div id="adddlg" class="easyui-dialog"  align="center" buttons="#adddlg-buttons" data-options="
                title: '添加训练中心账户',
	            width:300,
	            height:200,
	            closable:false,
	            closed:true,
	            modal:true,
				iconCls: 'icon-add'">
		   <form id="fm1" method="post" action="../../addUser">
			<table  style="position:relative;top:30px;font-size:18px;">
               <tr>
                  <td>账户：</td>
                  <td><input id="addusername" name="addusername" class="easyui-validatebox" required="true" missingMessage="用户名不能为空"></td>
               </tr> 
                <tr>
                  <td>密码：</td>
                  <td><input id="addpassword" name="addpassword" class="easyui-validatebox" required="true" missingMessage="密码不能为空"></td>
               </tr>   
          </table>
          <input id="identity" name="identity" type="text" value="3" hidden="true">  
        </form>
     </div>
<div id="dlg-buttons">
   <a href="javascript:save()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
   <a href="javascript:closeDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>
<div id="adddlg-buttons">
   <a href="javascript:add()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
   <a href="javascript:closeDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>
</body>
</html>