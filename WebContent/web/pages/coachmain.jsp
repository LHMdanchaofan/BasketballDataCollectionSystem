<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en"> 
<head> 
    <meta charset="utf-8"> 
    <meta name="viewport" content="width=device-width, initial-scale=1"> 
    <title>篮球大数据青少年数据采集与展示系统</title> 
<%
	// 权限验证
	if(session.getAttribute("currentUser")==null){
		response.sendRedirect("login.jsp");
		return;
	}
%>
<link href="css/base.css" rel="stylesheet">
<link href="css/platform.css" rel="stylesheet">
<script type="text/javascript" src="../custom/jquery.min.js"></script>
<link rel="stylesheet" href="../custom/uimaker/easyui.css">
<script type="text/javascript" src="../custom/easyui-lang-zh_CN.js"></script>
 <script type="text/javascript">
 $(function(){
	 $.post('../../getMyUserInformation',function(result){
		 $('h4#username').text(result.username);
		 $.ajax({
			    url:'http://localhost:8080/teenagersbasketball/head%20portrait/'+result.Id+'-head%20portrait.jpg',
			    type:'HEAD',
			    error: function() {
				 $('img#head').attr({src:"../../head portrait/user.png"})
			    },
			    success: function() {
				 $('img#head').attr({src:"../../head portrait/"+result.Id+"-head portrait.jpg"})
			    }
			 });	 
	 },'json');
})
 function modifytraininformation(){
	 $("div").find("li#modifytrain").addClass("active"); 
	 $("div").find("[id!='modifytrain']").removeClass("active");
	 if($("#tt").tabs('exists',"训练数据")){
			$("#tt").tabs('select',"训练数据");
		}else{
			var content="<iframe frameborder='0' scrolling='auto' style='width:100%;height:100%' src='modifytraininformation.jsp'></iframe>";
			$("#tt").tabs('add',{
				title:'训练数据',
				closable:true,
				content:content
			});
	}
 }
 function modifystudentinformation(){
	 $("div").find("li#modifystu").addClass("active"); 
	 $("div").find("[id!='modifystu']").removeClass("active");
	 if($("#tt").tabs('exists',"学员信息")){
			$("#tt").tabs('select',"学员信息");
		}else{
			var content="<iframe frameborder='0' scrolling='auto' style='width:100%;height:100%' src='coamodifystu.jsp'></iframe>";
			$("#tt").tabs('add',{
				title:'学员信息',
				closable:true,
				content:content
			});
	}
 }
 function feedbacktraininformation(){
	 $("div").find("li#feedback").addClass("active"); 
	 $("div").find("[id!='feedback']").removeClass("active");
	 if($("#tt").tabs('exists',"学员反馈")){
			$("#tt").tabs('select',"学员反馈");
		}else{
			var content="<iframe frameborder='0' scrolling='auto' style='width:100%;height:100%' src='feedback.jsp'></iframe>";
			$("#tt").tabs('add',{
				title:'学员反馈',
				closable:true,
				content:content
			});
	}
 }
function searchrankinformation(){
	$("div").find("li#searchrank").addClass("active"); 
	 $("div").find("[id!='searchrank']").removeClass("active");
	 if($("#tt").tabs('exists',"学员排名")){
			$("#tt").tabs('select',"学员排名");
		}else{
			var content="<iframe frameborder='0' scrolling='auto' style='width:100%;height:100%' src='mystudentrank.jsp'></iframe>";
			$("#tt").tabs('add',{
				title:'学员排名',
				closable:true,
				content:content
			});
	}
}
function search(){
	$("div").find("li#search").addClass("active"); 
	 $("div").find("[id!='search']").removeClass("active");
	 if($("#tt").tabs('exists',"查询信息")){
			$("#tt").tabs('select',"查询信息");
		}else{
			var content="<iframe frameborder='0' scrolling='auto' style='width:100%;height:100%' src='search.jsp'></iframe>";
			$("#tt").tabs('add',{
				title:'查询信息',
				closable:true,
				content:content
			});
	}
}
function personal(){
	$("div").find("li#personal").addClass("active"); 
	 $("div").find("[id!='personal']").removeClass("active");
	 if($("#tt").tabs('exists',"基本信息")){
			$("#tt").tabs('select',"基本信息");
		}else{
			var content="<iframe frameborder='0' scrolling='auto' style='width:100%;height:100%' src='personalinformation.jsp'></iframe>";
			$("#tt").tabs('add',{
				title:'基本信息',
				closable:true,
				content:content
			});
	}
}
</script>
</head> 
<body>
    <div class="container">
        <div id="pf-hd">
            <div class="pf-logo">
                 <img src="images/logo.png" alt="logo">青少年篮球大数据处理平台
            </div>

            <div class="pf-user">
                <div class="pf-user-photo">
                    <img id="head" src="" alt="" style="width:100%;height:100%">
                </div>
                <h4 id="username" class="pf-user-name ellipsis"></h4>
                <i class="iconfont xiala">&#xe607;</i>

                <div class="pf-user-panel">
                    <ul class="pf-user-opt">
                        <li>
                            <a href="../h5/person_info.html">
                                <i class="iconfont">&#xe60d;</i>
                                <span class="pf-opt-name">用户信息</span>
                            </a>
                        </li>
                        <li class="pf-modify-pwd">
                            <a href="modifypw.jsp">
                                <i class="iconfont">&#xe634;</i>
                                <span class="pf-opt-name">修改密码</span>
                            </a>
                        </li>
                        <li class="pf-logout">
                            <a href="login.jsp">
                                <i class="iconfont">&#xe60e;</i>
                                <span class="pf-opt-name">退出</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>

        </div>

        <div id="pf-bd">
            <div id="pf-sider">
                <h2 class="pf-model-name">
                    <span class="iconfont">&#xe64a;</span>
                    <span class="pf-name">数据管理</span>
                    <span class="toggle-icon"></span>
                </h2>

                <ul class="sider-nav">
                     <li class="current">
                        <a href="javascript:;">
                            <span class="iconfont sider-nav-icon">&#xe611;</span>
                            <span class="sider-nav-title">个人信息</span>
                            <i class="iconfont">&#xe642;</i>
                        </a>
                        <ul class="sider-nav-s">
                           <li id="personal"><a href="javascript:personal()">基本信息</a></li>
                        </ul>
                     </li>
                     <li>
                        <a href="javascript:;">
                            <span class="iconfont sider-nav-icon">&#xe633;</span>
                            <span class="sider-nav-title">训练信息</span>
                            <i class="iconfont">&#xe642;</i>
                        </a>
                        <ul class="sider-nav-s">
                           <li id="modifytrain"><a href="javascript:modifytraininformation()">提交训练成绩</a></li>
                            <li id="feedback"><a href="javascript:feedbacktraininformation()">训练成绩反馈</a></li>
                        </ul>
                     </li>
                     <li>
                        <a href="javascript:;">
                            <span class="iconfont sider-nav-icon">&#xe633;</span>
                            <span class="sider-nav-title">综合信息管理</span>
                            <i class="iconfont">&#xe642;</i>
                        </a>
                        <ul class="sider-nav-s">
                           <li id="search"><a href="javascript:search()">查询信息</a></li>
                           <li id="searchrank"><a href="javascript:searchrankinformation()">学员排名表</a></li>
                        </ul>
                     </li>
                     <li>
                        <a id="website" target="_Blank">
                            <span class="iconfont sider-nav-icon">&#xe61e;</span>
                            <span class="sider-nav-title">训练中心官网</span>
                            <i class="iconfont">&#xe642;</i>
                        </a>
                      </li>                 
                 </ul> 
            </div>

            <div id="pf-page">
                <div id="tt" class="easyui-tabs1" style="width:100%;height:100%;">
                  <div title="首页" style="padding:10px 5px 5px 10px;">
                    <iframe class="page-iframe" src="workbench.html" frameborder="no"   border="no" height="100%" width="100%" scrolling="auto"></iframe>
                  </div>
                </div>
            </div>
        </div>

        <div id="pf-ft">
            <div class="system-name">
              <i class="iconfont">&#xe6fe;</i>
              <span>篮球大数据&nbsp;v1.0</span>
            </div>
            <div class="copyright-name">
              <span>李浩铭&nbsp;2017&nbsp;&nbsp;danchaofan.com&nbsp;版权所有</span>
              <i class="iconfont" >&#xe6ff;</i>
            </div>
        </div>
    </div>

    <script type="text/javascript" src="../custom/jquery.min.js"></script>
    <script type="text/javascript" src="../custom/jquery.easyui.min.js"></script>
    <!-- <script type="text/javascript" src="js/menu.js"></script> -->
    <script type="text/javascript" src="js/main.js"></script>
    <!--[if IE 7]>
      <script type="text/javascript">
        $(window).resize(function(){
          $('#pf-bd').height($(window).height()-76);
        }).resize();
        
      </script>
    <![endif]-->  

    
  <script type="text/javascript">
    $('.easyui-tabs1').tabs({
      tabHeight: 44,
      onSelect:function(title,index){
        var currentTab = $('.easyui-tabs1').tabs("getSelected");
        if(currentTab.find("iframe") && currentTab.find("iframe").size()){
            currentTab.find("iframe").attr("src",currentTab.find("iframe").attr("src"));
        }
      }
    })
    $(window).resize(function(){
          $('.tabs-panels').height($("#pf-page").height()-46);
          $('.panel-body').height($("#pf-page").height()-76)
    }).resize();

    var page = 0,
        pages = ($('.pf-nav').height() / 70) - 1;

    if(pages === 0){
      $('.pf-nav-prev,.pf-nav-next').hide();
    }
    $(document).on('click', '.pf-nav-prev,.pf-nav-next', function(){


      if($(this).hasClass('disabled')) return;
      if($(this).hasClass('pf-nav-next')){
        page++;
        $('.pf-nav').stop().animate({'margin-top': -70*page}, 200);
        if(page == pages){
          $(this).addClass('disabled');
          $('.pf-nav-prev').removeClass('disabled');
        }else{
          $('.pf-nav-prev').removeClass('disabled');
        }
        
      }else{
        page--;
        $('.pf-nav').stop().animate({'margin-top': -70*page}, 200);
        if(page == 0){
          $(this).addClass('disabled');
          $('.pf-nav-next').removeClass('disabled');
        }else{
          $('.pf-nav-next').removeClass('disabled');
        }
        
      }
    })
$(function(){
	$.post("../../getWebsite",function(result){
		$("div#pf-bd").find("a#website").attr({href:result.website[0].website})
		},"json")
})
    </script>
</body> 
</html>