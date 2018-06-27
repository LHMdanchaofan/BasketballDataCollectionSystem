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
function formatRank(val,row,index){
	return index+1;
}
function search(){
	document.getElementById("search").value
	$('#dg').datagrid('load',{
		stuname:document.getElementById("search").value
	});
}
</script>
<title>排名</title>
</head>
<body>
   <table id="dg" class="easyui-datagrid" url="../../rankList" style="width:100%" title="排名" data-options="
                singleSelect:false,
                autoRowHeight:false,
                pagination:true,
                fitColumns:true,
                checkOnSelect:false,
                selectOnCheck:false,
                toolbar:'#tb',
                pageSize:10">
            <thead>
                <tr>
                    <th field="rank" width="100" align="center" formatter="formatRank">排名</th>
                    <th field="stuId" align="center" width="100">学号</th>
                    <th field="stuname" align="center" width="100">学员姓名</th>
                    <th field="coaname" align="center" width="100">教练姓名</th>
                    <th field="clubname" align="center" width="150">所属训练中心</th>
                    <th field="province" align="center" width="100">省份</th>
                    <th field="shuttlerun" align="center" width="100">折返跑/s</th>
                    <th field="benchpress" align="center" width="100">卧推/kg</th>
                    <th field="50meters" align="center" width="100">50米跑/s</th>
                    <th field="1000meters" align="center" width="100">1000米跑/s</th>
                    <th field="setshot" align="center" width="100">定点投篮</th>
                </tr>
            </thead>
        </table>
        <div id="tb" align="center">
        <input id="search" class="easyui-textbox" type="text" style="width:166px;height:35px;line-height:35px;">
        <a class="easyui-linkbutton" href="javascript:search()">查询</a>
        </div>
</body>
</html>