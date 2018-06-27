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
<script type="text/javascript">
var loc = location.href;
var n1 = loc.length;//地址的总长度
var n2 = loc.indexOf("=");//取得=号的位置
var result = decodeURI(loc.substr(n2+1, n1-n2));//从=号后面的内容
$(function(){
	$.post("../../getNotice",function(result){
		//console.info(result);
		$("input#oldname").attr({value:result.notice[0].name});
		$("textarea#oldcontent").text(result.notice[0].content);
	},'json')
	//console.info(result);
	if(result=="error"){
		$.messager.show({
			title:'提示',
			msg:'修改失败',
			timeout:1000,
			showType:'fade'
		});
	}else if(result=="success"){
		$.messager.show({
			title:'提示',
			msg:'修改成功',
			timeout:1000,
			showType:'fade'
		});
	}
})
</script>
<title>公告管理</title>
</head>
<body>
    <form id="fm" method="post" action="../../modifyNotice">
       <table border="1" style="font-size:22px;">
          <tr>
            <td>新标题</td>
            <td>原标题</td>
          </tr> 
          <tr>
            <td><input id="newname" name="newname"" type="text" style="font-size:22px;" required="true"></td>
            <td><input id="oldname" type="text" style="font-size:22px;" readonly="readonly"></td>
          </tr>   
          <tr>
            <td>新内容</td>
            <td>原内容</td>
          </tr>
          <tr>
            <td><textarea id="newcontent" name="newcontent" cols="40" rows="3" style="resize:none;font-size:22px;" required="true"></textarea></td>
            <td><textarea id="oldcontent" cols="40" rows="3" style="resize:none;font-size:22px;" readonly="readonly"></textarea></td>
          </tr> 
       </table>
       <input style="position:relative;top:10px;left:210px" class="easyui-linkbutton" type="submit" value="修改" />
    </form>
</body>
</html>