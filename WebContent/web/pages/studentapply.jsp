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
<link rel="stylesheet" href="css/providers1.css">
<link rel="stylesheet" type="text/css" href="../custom/uimaker/icon.css">
<script>
 function formatOper(value,row,index){
	 return '<a href="javascript:agree('+index+')">同意</a>  <a href="javascript:refuse('+index+')">拒绝</a>'
 }
 function agree(index){
	 $.post("../../apply",{
		 stuId:$('#dg').datagrid('getRows')[index].stuId
	 },function(result){
		 $.messager.show({
				title:'提示',
				msg:result.result,
				timeout:1000,
				showType:'fade'
			});
		 $('#dg').datagrid('reload');
	 },'json')
 }
 function refuse(index){
	 $.post("../../refuse",{
		 stuId:$('#dg').datagrid('getRows')[index].stuId
	 },function(result){
		 $.messager.show({
				title:'提示',
				msg:result.result,
				timeout:1000,
				showType:'fade'
			});
		 $('#dg').datagrid('reload');
	 },'json') 
 }
</script>
<title>申请学员名单</title>
</head>
<body>
       <table id="dg" class="easyui-datagrid" url="../../getApply" style="width:100%" title="申请学员名单" data-options="
                rownumbers:true,
                singleSelect:false,
                autoRowHeight:false,
                pagination:true,
                fitColumns:true,
                fit:true,
                pageSize:10">
            <thead>
                <tr>
                    <th field="stuId" width="10" align="center">学号</th>
                    <th field="username" width="10" align="center">用户名</th>
                    <th field="name" width="10" align="center">姓名</th>
                    <th field="coaname" width="10" align="center">教练姓名</th>
                    <th field="formatter" width="10" align="center" formatter="formatOper">操作</th>
                </tr>
            </thead>
        </table>
</body>
</html>