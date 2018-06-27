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
function formatOper(val,rows,index){
	return '<a href="javascript:open('+index+')">查看</a>'
}
function open(index){
	//alert(index);
	$('#delete').linkbutton('unselect');
	$("#dg").datagrid("hideColumn","ck");
	$("#dg").datagrid("uncheckAll");
	$("#fm").attr({hidden:false});
	$("input#newsname").attr({value:$("#dg").datagrid('getRows')[index].name});
	$('#addtime').datebox('setValue',$("#dg").datagrid('getRows')[index].addtime);
	$("textarea#newscontent").text($("#dg").datagrid('getRows')[index].content);
	$("#newsId").attr({value:$("#dg").datagrid('getRows')[index].Id});
}
$(function(){
	$('#dg').datagrid({
		onBeforeLoad: function(){
			$("#fm").attr({hidden:true});
		}
	});
})
function submitForm(){
	$('#fm').form('submit', {
		 onSubmit: function(){
				// do some check
				var newscontent=document.getElementById("newscontent").value;
				var addtime=$('#addtime').datebox('getValue');
				var newsname=document.getElementById("newsname").value;
				if(newscontent==""||newscontent==""||addtime==""){
					$.messager.show({
						title:'提示',
						msg:'新闻标题、时间或内容不能为空',
						timeout:1000,
						showType:'fade'
					});
					 return false;
				}else{
					return true;
				}
		 },
	    success:function(result){
			if(JSON.parse(result).result==1){
				$.messager.show({
					title:'提示',
					msg:'保存成功',
					timeout:1000,
					showType:'fade'
				});
				$("#fm").attr({hidden:true});
				$('#dg').datagrid('reload');
			}else{
				$.messager.show({
					title:'提示',
					msg:'保存失败',
					timeout:1000,
					showType:'fade'
				});
			}
	    }
	});
}
function addnews(){
	$('#delete').linkbutton('unselect');
	$("#fm").attr({hidden:false});
	$("input#newsname").attr({value:""});
	$('#addtime').datebox('setValue',"");
	$("textarea#newscontent").text("");
	$("#newsId").attr({value:""});
	$("#dg").datagrid("hideColumn","ck");
	$("#dg").datagrid("uncheckAll");
}
function removenews(){
	if($("#dg").datagrid("options").columns[0][0].hidden){
		$("#dg").datagrid("uncheckAll");
		$("#fm").attr({hidden:true});
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
				$.post("../../deleteNews",{delIds:ids},function(result){
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
<title>新闻管理</title>
</head>
<body class="easyui-layout">
    <div data-options="region:'west',title:'新闻列表',collapsible:false" style="width:665px;">
      <table id="dg" class="easyui-datagrid" data-options="url:'../../newsList',pagination:true,fitColumns:true,toolbar:'#tb'">
      <thead>
        <tr>
          <th id="cb" field="ck" checkbox="true" hidden="true"></th>
          <th field="Id" width="100" align="center" hidden="hidden">Id</th>
          <th field="name" align="center" width="150">新闻标题</th>
          <th field="addtime" align="center" width="45">新闻时间</th>
          <th field="content" align="center" width="100">简要</th>
          <th field="编辑" align="center" width="25" formatter="formatOper">操作</th>
         </tr>
         </thead>
      </table>
    </div>
    <div data-options="region:'center',title:'详情'" style="background:#eee;">
        <form id="fm" method="post" action="../../modifyNews">
         <table  border="1" style="font-size:22px;">
          <tr>
            <td>新闻标题</td>
          </tr> 
          <tr>
            <td><input id="newsname" name="newsname" type="text" style="width:420px;" required="true"></td>
          </tr>
          <tr>
            <td>新闻时间</td>
          </tr> 
          <tr>
            <td><input class="easyui-datebox" id="addtime" name="addtime" type="text" editable="false" required="true"></td>
          </tr>    
          <tr>
            <td>新闻内容</td>
          </tr>
          <tr>
            <td><textarea id="newscontent" name="newscontent" cols="40" rows="6" style="resize:none;width:520px" required="true"></textarea></td>            
          </tr> 
       </table>
       <a style="width:100px;position:relative;top:10px;left:230px" href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">保存</a>  
       <input id="newsId" name="newsId" hidden="true">     
    </form>
    </div>
    <div id="tb" style="height:40px">
       <a class="easyui-linkbutton" href="javascript:addnews()" iconCls="icon-add" style="position:relative;top:-10px;">添加新闻</a>
       <a id="delete" class="easyui-linkbutton" href="javascript:removenews()" iconCls="icon-add" style="position:relative;top:-10px;" toggle="true" >删除新闻</a>
    </div>
</body>
</html>