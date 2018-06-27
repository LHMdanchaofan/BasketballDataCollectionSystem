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
function noticemanage(){
	 $("div").find("li#notice").addClass("active"); 
	 $("div").find("[id!='notice']").removeClass("active");
	 
	// $('#tt').tabs('add',{
	//		title: 'Tab'+index,
	//		content: '<div style="padding:10px"><iframe class="page-iframe" src="workbench.html" border="no" height="100%" width="100%" scrolling="auto"></iframe></div>',
	//		closable: true
	//	});
	 if($("#tt").tabs('exists',"公告管理")){
				$("#tt").tabs('select',"公告管理");
			}else{
				var content="<iframe frameborder='0' scrolling='auto' style='width:100%;height:100%' src='noticemanage.jsp'></iframe>";
				$("#tt").tabs('add',{
					title:'公告管理',
					closable:true,
					content:content
				});
		}
}
function newsmanage(){
	 $("div").find("li#news").addClass("active"); 
	 $("div").find("[id!='news']").removeClass("active");
	 
	// $('#tt').tabs('add',{
	//		title: 'Tab'+index,
	//		content: '<div style="padding:10px"><iframe class="page-iframe" src="workbench.html" border="no" height="100%" width="100%" scrolling="auto"></iframe></div>',
	//		closable: true
	//	});
	 if($("#tt").tabs('exists',"新闻管理")){
				$("#tt").tabs('select',"新闻管理");
			}else{
				var content="<iframe frameborder='0' scrolling='auto' style='width:100%;height:100%' src='newsmanage.jsp'></iframe>";
				$("#tt").tabs('add',{
					title:'新闻管理',
					closable:true,
					content:content
				});
		}
}
function forummanage(){
	 $("div").find("li#forum").addClass("active"); 
	 $("div").find("[id!='forum']").removeClass("active");
	 
	// $('#tt').tabs('add',{
	//		title: 'Tab'+index,
	//		content: '<div style="padding:10px"><iframe class="page-iframe" src="workbench.html" border="no" height="100%" width="100%" scrolling="auto"></iframe></div>',
	//		closable: true
	//	});
	 if($("#tt").tabs('exists',"论坛管理")){
				$("#tt").tabs('select',"论坛管理");
			}else{
				var content="<iframe frameborder='0' scrolling='auto' style='width:100%;height:100%' src='forummanage.jsp'></iframe>";
				$("#tt").tabs('add',{
					title:'论坛管理',
					closable:true,
					content:content
				});
		}
}
function displaymanage(){
	$("div").find("li#display").addClass("active"); 
	 $("div").find("[id!='display']").removeClass("active");
	 
	// $('#tt').tabs('add',{
	//		title: 'Tab'+index,
	//		content: '<div style="padding:10px"><iframe class="page-iframe" src="workbench.html" border="no" height="100%" width="100%" scrolling="auto"></iframe></div>',
	//		closable: true
	//	});
	 if($("#tt").tabs('exists',"推荐管理")){
				$("#tt").tabs('select',"推荐管理");
			}else{
				var content="<iframe frameborder='0' scrolling='auto' style='width:100%;height:100%' src='displaymanage.jsp'></iframe>";
				$("#tt").tabs('add',{
					title:'推荐管理',
					closable:true,
					content:content
				});
		}
}
function student(){
	$("div").find("li#student").addClass("active"); 
	 $("div").find("[id!='student']").removeClass("active");
	 
	 if($("#tt").tabs('exists',"学员管理")){
				$("#tt").tabs('select',"学员管理");
			}else{
				var content="<iframe frameborder='0' scrolling='auto' style='width:100%;height:100%' src='studentmanage.jsp'></iframe>";
				$("#tt").tabs('add',{
					title:'推荐管理',
					closable:true,
					content:content
				});
		}
}
function coach(){
	$("div").find("li#coach").addClass("active"); 
	 $("div").find("[id!='coach']").removeClass("active");
	 
	 if($("#tt").tabs('exists',"教练管理")){
				$("#tt").tabs('select',"教练管理");
			}else{
				var content="<iframe frameborder='0' scrolling='auto' style='width:100%;height:100%' src='coachmanage.jsp'></iframe>";
				$("#tt").tabs('add',{
					title:'教练管理',
					closable:true,
					content:content
				});
		}
}
function club(){
	$("div").find("li#club").addClass("active"); 
	 $("div").find("[id!='club']").removeClass("active");
	 
	 if($("#tt").tabs('exists',"训练中心管理")){
				$("#tt").tabs('select',"训练中心管理");
			}else{
				var content="<iframe frameborder='0' scrolling='auto' style='width:100%;height:100%' src='clubmanage.jsp'></iframe>";
				$("#tt").tabs('add',{
					title:'训练中心管理',
					closable:true,
					content:content
				});
		}
}
function train(){
	$("div").find("li#train").addClass("active"); 
	 $("div").find("[id!='train']").removeClass("active");
	 
	 if($("#tt").tabs('exists',"训练数据管理")){
				$("#tt").tabs('select',"训练数据管理");
			}else{
				var content="<iframe frameborder='0' scrolling='auto' style='width:100%;height:100%' src='trainmanage.jsp'></iframe>";
				$("#tt").tabs('add',{
					title:'训练数据管理',
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
                    <img id="head" style="width:100%;height:100%" src="" alt="">
                </div>
                <h4 id="username" class="pf-user-name ellipsis"></h4>
                <i class="iconfont xiala">&#xe607;</i>

                <div class="pf-user-panel">
                    <ul class="pf-user-opt">
                        <li>
                            <a href="../h5/person_info.html">
                                <i class="iconfont">&#xe60d;</i>
                                <span class="pf-opt-name">上传头像</span>
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
                            <span class="sider-nav-title">首页管理</span>
                            <i class="iconfont">&#xe642;</i>
                        </a>
                        <ul class="sider-nav-s">
                           <li id="notice"><a href="javascript:noticemanage()">公告管理</a></li>
                           <li id="news"><a href="javascript:newsmanage()">新闻管理</a></li>
                           <li id="display"><a href="javascript:displaymanage()">推荐管理</a></li>
                           <li id="forum"><a href="javascript:forummanage()">论坛管理</a></li>
                        </ul>
                     </li>
                     <li>
                        <a href="javascript:;">
                            <span class="iconfont sider-nav-icon">&#xe633;</span>
                            <span class="sider-nav-title">用户管理</span>
                            <i class="iconfont">&#xe642;</i>
                        </a>
                        <ul class="sider-nav-s">
                           <li id="student"><a href="javascript:student()">学员管理</a></li>
                           <li id="coach"><a href="javascript:coach()">教练管理</a></li>
                           <li id="club"><a href="javascript:club()">训练中心管理</a></li>
                        </ul>
                     </li>
                     <li>
                        <a href="javascript:;">
                            <span class="iconfont sider-nav-icon">&#xe62f;</span>
                            <span class="sider-nav-title">训练管理</span>
                            <i class="iconfont">&#xe642;</i>
                        </a>
                        <ul class="sider-nav-s">
                           <li id="train"><a href="javascript:train()">训练数据管理</a></li>
                        </ul>
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
    </script>
</body> 
</html>