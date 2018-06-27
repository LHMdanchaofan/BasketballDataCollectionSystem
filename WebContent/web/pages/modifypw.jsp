<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en"> 
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
<title>密码修改</title>
<%
	// 权限验证
	if(session.getAttribute("currentUser")==null){
		response.sendRedirect("login.jsp");
		return;
	}
%>
<link rel="stylesheet" href="../h5/fonts/iconfont.css"/>
<link rel="stylesheet" href="../h5/css/font.css"/>
<link rel="stylesheet" href="../h5/css/weui.min.css"/>
<link rel="stylesheet" href="../h5/css/jquery-weui.min.css"/>
<link rel="stylesheet" href="../h5/css/mui.css"/>
<link rel="stylesheet" href="../h5/css/animate.css"/>
<link rel="stylesheet" href="../h5/css/pages/modify.css"/>
<link rel="stylesheet" href="../custom/uimaker/easyui.css">
<script type="text/javascript" src="../custom/jquery.min.js"></script>
<script type="text/javascript" src="../custom/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../custom/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
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
        function back(){
        	window.history.back(-1); 
        }
        
function   modifyPW(){
	if(document.getElementById("oldpw").value == "" || document.getElementById("oldpw").value == undefined || document.getElementById("oldpw").value == null){
		$.messager.alert('警告','当前密码栏为空！');
	}else if(document.getElementById("newpw").value == "" || document.getElementById("newpw").value == undefined || document.getElementById("newpw").value == null){
		$.messager.alert('警告','新密码为栏空！');
	}else if(document.getElementById("renewpw").value == "" || document.getElementById("renewpw").value == undefined || document.getElementById("renewpw").value == null){
		$.messager.alert('警告','新密码确认栏为空！');
	}else{
	   if(document.getElementById("newpw").value!=document.getElementById("renewpw").value){
		   $.messager.alert('警告','密码不一致');
	   }else{
	      $.post("../../modifyPW",{
		      oldpw:document.getElementById("oldpw").value,
		      newpw:document.getElementById("newpw").value,
	      },function(result){
	    	  console.info(result.information);
	    	  if(result.information=="密码错误"){
	    		  $.messager.show('警告','密码错误');	
	    	  }else if(result.information=="修改失败"){
	    		  $.messager.show('警告','修改失败');
	    	  }else{
	    		  $.messager.alert('提示','修改成功','info',function(r){
	    			  self.location='login.jsp';
	    		  });	    		  
	    	  }
	      },"json");
	   }
	  }
}
</script>
</head>
    <body>
        <header>
            <div class="titlebar reverse">
                <a href="javascript:back()">
                    <i class="iconfont">&#xe640;</i>
                </a>
                <h1>密码修改</h1>
            </div>
        </header>
        <article style="bottom: 54px;">
            <div class="weui_cells animated fadeInRight">
                    <div class="weui_cell tip">
                        <div class="weui_cell_bd weui_cell_primary">
                            <p>当前密码</p>
                        </div>
                    </div>
            </div>
            <div class="weui_cell password">
                <div class="weui_cell_bd weui_cell_primary password">
                    <input id="oldpw" name="oldpw" class="weui_input" type="password" placeholder="请输入当前密码">
                </div>
            </div>
            <div class="weui_cells animated fadeInRight">
                    <div class="weui_cell tip">
                        <div class="weui_cell_bd weui_cell_primary">
                            <p>新密码</p>
                        </div>
                    </div>
            </div>
            <div class="weui_cell password">
                <div class="weui_cell_bd weui_cell_primary password">
                    <input id="newpw" name="newpw" class="weui_input" type="password" placeholder="请输入新密码">
                </div>
            </div>
            <div class="weui_cells animated fadeInRight">
                    <div class="weui_cell tip">
                        <div class="weui_cell_bd weui_cell_primary">
                            <p>新密码确认</p>
                        </div>
                    </div>
            </div>
            <div class="weui_cell password">
                <div class="weui_cell_bd weui_cell_primary password">
                    <input id="renewpw" name="renewpw" class="weui_input" type="password" placeholder="请再次输入新密码">
                </div>
            </div>
            <div class="button">
                <div class="bd">
                    <a href="javascript:modifyPW();" class="weui_btn weui_btn_primary">确认变更</a>
                </div>
            </div>
           
        </article>
</body>
</html>