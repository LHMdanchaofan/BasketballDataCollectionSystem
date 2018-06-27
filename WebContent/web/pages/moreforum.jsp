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
<link rel="stylesheet" href="css/workbench.css">
<script type="text/javascript">
$(function(){
	$.post("../../forumList",function(result){
		for(var i=0;i<result.rows.length;i++){
			$('ul#forum').append('<li><span></span<font size="3"><a href="'+result.rows[i].forumurl+'" class="ellipsis" target="_Blank">'+result.rows[i].forumname+'</a></font></li>')
		}
	},'json');
})
</script>
<title>友情论坛</title>
</head>
<body style="overflow-x:hidden ">
   <div>
      <a href="workbench.html" style="text-decoration:none;"><font color="Lime"><-首页</font></a>
   </div>
   <div id="panel" class="easyui-panel" align="left" style="width:1000px;height:429px">
         <ul id=forum>
           
        </ul>    
   </div>
</body>
</html>