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
<link rel="stylesheet" href="../custom/uimaker/easyui.css">
<script type="text/javascript" src="../custom/jquery.min.js"></script>
<script type="text/javascript" src="../custom/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../custom/easyui-lang-zh_CN.js"></script>
<link rel="stylesheet" type="text/css" href="../custom/uimaker/icon.css">
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
 function clubinformation(){
	 $("div").find("li#club").addClass("active"); 
	 $("div").find("[id!='club']").removeClass("active");
	 if($("#tt").tabs('exists',"基本信息")){
			$("#tt").tabs('select',"基本信息");
		}else{
			var content="<iframe frameborder='0' scrolling='auto' style='width:100%;height:100%' src='clubinformation.jsp'></iframe>";
			$("#tt").tabs('add',{
				title:'基本信息',
				closable:true,
				content:content
			});
	}
 }
 function coachmanage(){
	 $("div").find("li#coachmanage").addClass("active"); 
	 $("div").find("[id!='coachmanage']").removeClass("active");
	 if($("#tt").tabs('exists',"教练管理")){
			$("#tt").tabs('select',"教练管理");
		}else{
			var content="<iframe frameborder='0' scrolling='auto' style='width:100%;height:100%' src='clubcoachmanage.jsp'></iframe>";
			$("#tt").tabs('add',{
				title:'基本信息',
				closable:true,
				content:content
			});
	}
 }
 function applystudent(){
	 $("div").find("li#applystudent").addClass("active"); 
	 $("div").find("[id!='applystudent']").removeClass("active");
	 if($("#tt").tabs('exists',"申请学员管理")){
			$("#tt").tabs('select',"申请学员管理");
		}else{
			var content="<iframe frameborder='0' scrolling='auto' style='width:100%;height:100%' src='studentapply.jsp'></iframe>";
			$("#tt").tabs('add',{
				title:'申请学员管理',
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
                <h4 id="username"class="pf-user-name ellipsis"></h4>
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
                            <span class="sider-nav-title">训练中心信息</span>
                            <i class="iconfont">&#xe642;</i>
                        </a>
                        <ul class="sider-nav-s">
                           <li id="club"><a href="javascript:clubinformation()">基本信息</a></li>
                           <li id="website"><a href="javascript:openDialog()">官方网站</a></li>
                        </ul>
                     </li>
                     <li>
                        <a href="javascript:;">
                            <span class="iconfont sider-nav-icon">&#xe633;</span>
                            <span class="sider-nav-title">用户管理</span>
                            <i class="iconfont">&#xe642;</i>
                        </a>
                        <ul class="sider-nav-s">
                            <li id="coachmanage"><a href="javascript:coachmanage()">教练管理</a></li>
                           <li id="applystudent"><a href="javascript:applystudent()">申请学员名单</a></li>
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
    <div id="dlg" class="easyui-dialog"  align="center" buttons="#dlg-buttons" data-options="
                title: '修改官方网站',
	            width:500,
	            height:290,
	            closable:false,
	            closed:true,
	            modal:true,
				iconCls: 'icon-edit'">
		   <form id="fm" method="post" action="../../modifyPersonalinformation">
			<table  style="position:relative;top:30px;font-size:18px;">
               <tr>
                  <td>原官方网站：</td>
                  <td width="350px"><input id="oldwebsite" name="oldwebsite" class="easyui-validatebox" style="width:350px" readonly></td>
               </tr> 
                <tr>
                  <td>新官方网站：</td>
                  <td width="350px"><input id="newwebsite" name="newwebsite" class="easyui-validatebox" style="width:350px" validType="url" missingMessage="官网地址不能为空" invalidMessage="请输入正确的网站地址" required="true"></td>
               </tr>   
          </table> 
        </form>
     </div>
     <div id="dlg-buttons">
   <a href="javascript:save()" class="easyui-linkbutton">保存</a>
   <a href="javascript:closeDialog()" class="easyui-linkbutton">关闭</a>
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
var website;
$(function(){
	$.post("../../getWebsite",function(result){
		$("div#pf-bd").find("a#website").attr({href:result.website[0].website})
		website=result.website[0].website;
		},"json")
})
function openDialog(){
	 $('#dlg').dialog('open');
	 $("#oldwebsite").val(website); 
 }
function  closeDialog(){
    	$('#dlg').dialog('close'); 	
    	$("#newwebsite").val(""); 
}
function save(){
	var web=document.getElementById("newwebsite").value;
	$('#fm').form('submit', {
	    onSubmit: function(){
	    	if($('#fm').form('validate')){
	    		return true
	    	}else{
	    		return false;
	    	} 
	    	},success:function(result){
	    		console.info(result);
	    		if(JSON.parse(result).result=="success"){
	    			 $.messager.show({
		    				title:'提示',
		    				msg:'修改成功',
		    				timeout:1000,
		    				showType:'fade'
		    			});
	    			website=web;	
	    			closeDialog()
	    		}else{
	    			 $.messager.show({
		    				title:'提示',
		    				msg:'修改失败',
		    				timeout:1000,
		    				showType:'fade'
		    			});
	    			 closeDialog()
	    		}
	    },
	});
} 
</script>
</body> 
</html>