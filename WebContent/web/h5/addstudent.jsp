<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
<title>添加学员</title>
<%
	// 权限验证
	if(session.getAttribute("currentUser")==null){
		response.sendRedirect("login.html");
		return;
	}
%>
<link rel="stylesheet" href="fonts/iconfont.css"/>
<link rel="stylesheet" href="css/font.css"/>
<link rel="stylesheet" href="css/weui.min.css"/>
<link rel="stylesheet" href="css/jquery-weui.min.css"/>
<link rel="stylesheet" href="css/mui.css"/>
<link rel="stylesheet" href="css/animate.css"/>
<link rel="stylesheet" href="css/pages/app.css"/>
<link rel="stylesheet" href="../custom/uimaker/easyui.css">
</head>
<body>
<script type="text/javascript" src="../custom/jquery.min.js"></script>
<script type="text/javascript" src="../custom/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../custom/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="pageSize.js"></script>
<script>
(function (doc, win) {
       var docEl = doc.documentElement,
       resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
       recalc = function () {
       var clientWidth = docEl.clientWidth;
       if (!clientWidth) return;
           docEl.style.fontSize = 20 * (clientWidth / 320) + 'px';
       };
       if (!doc.addEventListener) return;
           win.addEventListener(resizeEvt, recalc, false);
           doc.addEventListener('DOMContentLoaded', recalc, false);
       })(document, window);
$(function(){
       var pager = $('#dg').datagrid('getPager');    // get the pager of datagrid
       pager.pagination({
       pageSize: 5,
       showPageList:false,
       });
})
function add(){
	for(var i=0;i<$('#dg').datagrid('getChecked').length;i++){
		$.post('../../phoneAddStudent',{
			stuId:$('#dg').datagrid('getChecked')[i].stuId
		})
	}
	parent.location.href="app.jsp"; 
}
    </script>
        <header>
            <div class="titlebar reverse">
                
                <h1>学员列表</h1>
            </div>
        </header>
        <table id="dg" class="easyui-datagrid" url="../../phoneCoaStuList" style="width:100%" title="我的学员" data-options="              
                idField:'stuId',
                autoRowHeight:false,
                pagination:true,
                fitColumns:true,
                checkOnSelect:true,
                selectOnCheck:true,
                collapsible:false">
            <thead>
                <tr>
                    <th field="ck" checkbox="true"></th>
                    <th field="stuId" width="100" align="center">学号</th>
                    <th field="stuname" align="center" width="100">姓名</th>
                    <th field="sex" align="center" width="100">性别</th>
                </tr>
            </thead>
        </table>
        <div>
        </div>
         <footer>
            <ul class="menubar animated fadeInUp delay3">
                <li class="tab">
                <a href="javascript:add()">
                    <font color="orangered">
                    <i class="iconfont">&#xe63a;</i>
                    <label class="tab-label">确认</label>
                    </font>
                 </a>
                </li>
                  <li class="tab">
                  <a href="app.jsp">
                    <font color="orangered">
                    <i class="iconfont">&#xe640;</i>
                    <label class="tab-label">返回</label>
                    </font>
                  </a>
                  </li>
            </ul>
        </footer>
    </body>
</html>