<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
<title>定点投篮</title>
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
<link rel="stylesheet" href="css/timer.css"/>
<link rel="stylesheet" href="css/pages/app.css"/>
<link rel="stylesheet" href="../custom/uimaker/easyui.css">
    </head>
    <body>
    <script type="text/javascript" src="../custom/jquery.min.js"></script>
<script type="text/javascript" src="../custom/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../custom/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="pageSize.js"></script>
<script>
var train=new Array();
var stuId=undefined;
var score=undefined;
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
    	 $('#result').dialog({
	    		onClose:function(){
	    			stuId=undefined;
	    			score=undefined;
				}
	    	 });
    	 $('#head').dialog({
	    		onClose:function(){
	    			location.reload();
				}
	    	 });
    	 $('#dg').datagrid({
    			queryParams: {
    				type:5,
    			}
    		});
    	 $.post('../../phoneGetTemporaryStudent',function(result){
    		 for(var i=0;i<result.rows.length;i++){
    			 console.info(result.rows[i].stuId);
    			 $('#head').append('<a id="'+result.rows[i].stuId+'" href="javascript:addtrain('+result.rows[i].stuId+')"><img id="'+result.rows[i].stuId+'" src="../../head portrait/'+result.rows[i].stuId+'-head portrait.jpg" style="width:48px;height:48px"><h4 id="'+result.rows[i].stuId+'">'+result.rows[i].stuname+'<h4></a>');	 
    		 }
    	 },'json');
    	 var pager = $('#dg').datagrid('getPager');    // get the pager of datagrid
         pager.pagination({
         pageSize: 5,
         showPageList:false,
         });
     })  
     function opendlg(){
    	 $('#head').dialog('open');
     }
     function addtrain(id){
    	 stuId=id;
    	 //alert(stuId);
    	 $('#result').dialog('open');
     }
     function savetrain(){
    	var temporary = new Object();
     	temporary.Id=stuId;
     	temporary.score=score;
     	//console.info(temporary);
     	train.push(temporary);
     	$.post('../../phoneSaveTrain',{
    		type:5,
    		score: JSON.stringify(train)
    	},function(result){
    		if(result.result>0){
    			$.messager.show({
	   				title:'提示',
	   				msg:"提交成功",
	   				timeout:1000,
	   				showType:'fade'
	   			});
    			  $('#result').dialog('close');
    		}else{
    			$.messager.show({
	   				title:'提示',
	   				msg:"提交失败",
	   				timeout:1000,
	   				showType:'fade'
	   			});
    		}
    		//console.info(result);
    		//if(result.result>0){
    		//	  location.reload();
    		//}else{
    		//	$.messager.show({
	   			//	title:'提示',
	   		//		msg:"提交失败",
	   		//		timeout:1000,
	   		//		showType:'fade'
	   		//	});
    		//}
    	},'json');
     	//console.info(train)
		//$('#a3').linkbutton('unselect');
    	// alert(stuId);
    	 //alert(score);
     }
     function addscore(sc){
    	// alert(score);
    	 score=sc;
    	// alert(score);
     }
</script>
        <header>
            <div class="titlebar reverse">               
                <h1>定点投篮</h1>
            </div>
        </header>
        <article style="padding-top:55px;">
            <div class="list-wrap" align="center">
                <ul class="app-list">
                    <li>
                        <div class="app-wrap">
                            <a href="javascript:opendlg()">
                                <i class="iconfont">&#xe63a;</i>
                                <span>开始训练</span>
                            </a>
                        </div>                       
                    </li>             
                </ul>
            </div>
        </article>
         <table id="dg" class="easyui-datagrid" url="../../phoneTrainList" title="成绩汇总" style="width:100%" data-options="              
                idField:'stuId',
                autoRowHeight:false,
                pagination:true,
                fitColumns:true,
                checkOnSelect:true,
                selectOnCheck:true,
                collapsible:false">
            <thead>
                <tr>
                    <th field="stuId" width="100" align="center">学号</th>
                    <th field="stuname" align="center" width="100">姓名</th>
                    <th field="sex" align="center" width="100">性别</th>
                    <th field="setshot" align="center" width="100">定点投篮成绩</th>
                </tr>
            </thead>
        </table>
        <footer>
            <ul class="menubar animated fadeInUp delay3">
                <li class="tab">
                   <a href="begintrain.jsp">
                   <font color="orangered">
                    <i class="iconfont">&#xe631;</i>
                    <label class="tab-label">返回</label>
                    </font>
                    </a>
                </li>
            </ul>
        </footer>
         <div id="head" class="easyui-dialog" title="学员"  closed="true" align="center" style="width:80%;height:70%;"
          data-options="resizable:true,modal:true">
          <ul id="head">
          </ul>
        </div>
         <div id="result" class="easyui-dialog" title="成绩"  closed="true" align="center" style="width:80%;height:70%;"
          data-options="resizable:true,modal:true">
          <ul>
          <li>
             <a id="a1" href="javascript:addscore(1)" class=easyui-linkbutton toggle="true" group="g1" style="width:40%;height:110%">1</a><a id="a2" href="javascript:addscore(2)" class=easyui-linkbutton toggle="true" group="g1" style="width:40%;height:100%">2</a>
           </li>
           <li>
             <a id="a3" href="javascript:addscore(3)" class=easyui-linkbutton toggle="true" group="g1" style="width:40%;height:110%">3</a><a id="a4" href="javascript:addscore(4)" class=easyui-linkbutton toggle="true" group="g1" style="width:40%;height:100%">4</a>
           </li>
           <li>
             <a id="a5" href="javascript:addscore(5)" class=easyui-linkbutton toggle="true" group="g1" style="width:40%;height:110%">5</a><a id="a6" href="javascript:addscore(6)" class=easyui-linkbutton toggle="true" group="g1" style="width:40%;height:100%">6</a>
           </li>
           <li>
             <a id="a7" href="javascript:addscore(7)" class=easyui-linkbutton toggle="true" group="g1" style="width:40%;height:110%">7</a><a id="a8" href="javascript:addscore(8)" class=easyui-linkbutton toggle="true" group="g1" style="width:40%;height:100%">8</a>
           </li>
           <li>
             <a id="a9" href="javascript:addscore(8)" class=easyui-linkbutton toggle="true" group="g1" style="width:40%;height:110%">9</a><a id="a10" href="javascript:addscore(10)" class=easyui-linkbutton toggle="true" group="g1" style="width:40%;height:100%">10</a>
           </li>
          </ul>
          <a href="javascript:savetrain()" class=easyui-linkbutton>提交</a>
        </div>
    </body>
</html>