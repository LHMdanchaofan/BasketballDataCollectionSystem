<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
<title>功能</title>
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
    </script>
    </head>
    <body>
        <header>
            <div class="titlebar reverse">
                
                <h1>首页</h1>
            </div>
        </header>
        <article style="padding-bottom: 54px;padding-top:44px;">
            <div class="list-wrap" align="center">
                <h4>功能列表</h4>
                <ul class="app-list">
                    <li>
                        <div class="app-wrap">
                            <a href="addstudent.jsp">
                                <i class="iconfont">&#xe64b;</i>
                                <span>添加学员</span>
                            </a>
                        </div>
                        
                    </li>
                    <li>
                        <div class="app-wrap">
                            <a href="begintrain.jsp">
                                <i class="iconfont">&#xe63a;</i>
                                <span>开始训练</span>
                            </a>
                        </div>
                        
                    </li>
                    <li>
                        <div class="app-wrap">
                            <a href="alltrain.jsp">
                                <i class="iconfont">&#xe620;</i>
                                <span>提交成绩</span>
                            </a>
                        </div>
                        
                    </li>                   
                </ul>
            </div>
        </article>
        <footer>
            <ul class="menubar animated fadeInUp delay3">
                <li class="tab active">
                <a>
                  <font color="orangered">
                    <i class="iconfont">&#xe63f;</i>
                    <label class="tab-label">功能</label>
                    </font>
                    </a>
                </li>
                <li class="tab">
                  <a href="login.html">
                  <font color="orangered">
                    <i class="iconfont">&#xe63e;</i>
                    <label class="tab-label">退出</label>
                    </font>
                  </a>
                </li>
            </ul>
        </footer>
    </body>
</html>