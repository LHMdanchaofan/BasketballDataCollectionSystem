<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
<title>折返跑</title>
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
var time = new Array();
var score=new Array();
var resultid=undefined;
var total=0;
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
    	 $('#dg').datagrid({
    			queryParams: {
    				type:1,
    			}
    		});
    	 $.post('../../phoneGetTemporaryStudent',function(result){
    		 for(var i=0;i<result.rows.length;i++){
    			 console.info(result.rows[i].stuId);
    			 $('#head').append('<a id="'+result.rows[i].stuId+'" href="javascript:addtrain('+result.rows[i].stuId+')"><img id="'+result.rows[i].stuId+'" src="../../head portrait/'+result.rows[i].stuId+'-head portrait.jpg" style="width:48px;height:48px"><h4 id="'+result.rows[i].stuId+'">'+result.rows[i].stuname+'<h4></a>');	 
    		 }
    	 },'json');
				var min=0;
				var sec=0;
				var ms=0;
				var timer=null;
				var count=0;
		//点击第一个按钮
			$('.bnt button:eq(0)').click(function(){
				if($(this).html()=='记次'){
					if(!timer){
						$.messager.show({
			   				title:'提示',
			   				msg:"没有开启定时器",
			   				timeout:1000,
			   				showType:'fade'
			   			});
						return;
					}
						count++;
						var right1="<span class='right'>"+$('#showtime').text()+"</span>";
						 var insertStr = "<div><span class='left'>记次"+count+"</span>" +right1+"</div>";
						 
						$("#record").prepend($(insertStr));
						time[total]=$('#showtime span:eq(0)').html()+":"+$('#showtime span:eq(2)').html()+":"+$('#showtime span:eq(4)').html();
						total++;	
						//console.info(time);
				}else{
					min=0;
					sec=0;
					ms=0;
					count=0;
					$('#showtime span:eq(0)').html('00');
					$('#showtime span:eq(2)').html('00');
					$('#showtime span:eq(4)').html('00');
					$('#record').html('');					
					}
				
			});
		//点击第二个按钮
			$('.bnt button:eq(1)').click(function(){
				if($(this).html()=='启动'){
					$(this).html('提交');
					$('.bnt button:eq(0)').html('记次');
					clearInterval(timer);
					timer=setInterval(show,10)
				}else{
					//console.info(time);
					//console.info(time.length);					
					if(time.length>0){
						clearInterval(timer);
						$('#dd').dialog('close');
						$('#sb').dialog('open');
						for(var i=0;i<time.length;i++){
							//alert(time[i]);
							$('#result').append('<li><img id="imgresult'+i+'" src="../../head portrait/user.png" style="width:48px;height:48px"><a href="javascript:addstudent('+i+')">'+time[i]+'<h4 id="h4result'+i+'">学生姓名</h4></li>');
						}
					}else{
						$.messager.show({
			   				title:'提示',
			   				msg:"无可提交的数据",
			   				timeout:1000,
			   				showType:'fade'
			   			});
					}
					
				}
			});
		//生成时间
			function show(){
				ms++;
				if(sec==60){
					min++;sec=0;
				}
				if(ms==100){
					sec++;ms=0;
				}
				var msStr=ms;
				if(ms<10){
					msStr="0"+ms;
				}
				var secStr=sec;
				if(sec<10){
					secStr="0"+sec;
				}
				var minStr=min;
				if(min<10){
					minStr="0"+min;
				}
				$('#showtime span:eq(0)').html(minStr);
				$('#showtime span:eq(2)').html(secStr);
				$('#showtime span:eq(4)').html(msStr);
			}
			 $('#dd').dialog({
		    		onOpen:function(){
		    			min=0;
						sec=0;
						ms=0;
						count=0;
						$('#showtime span:eq(0)').html('00');
						$('#showtime span:eq(2)').html('00');
						$('#showtime span:eq(4)').html('00');
						$('#record').html('');
						$('.bnt button:eq(1)').html('启动');
						timer=null;
						time.splice(0,time.length);
						total=0;
					}
		    	 });
			 $('#sb').dialog({
		    		onClose:function(){
		    			location.reload();
					}
		    	 });
			 var pager = $('#dg').datagrid('getPager');    // get the pager of datagrid
	            pager.pagination({
	            pageSize: 5,
	            showPageList:false,
	            });
		})
		function opendlg(){
        	$('#dd').dialog('open');
        }
        function addstudent(i){
        	resultid=i;
        	//alert(reaultid);
        	//$('#result').html("123");
        	//$('#h4result').text("123");
        	$('#head').dialog('open');
        }
        function addtrain(stuId){
        	var temporary = new Object();
        	temporary.Id=stuId;
        	temporary.score=time[resultid];
        	//console.info(temporary);
        	score.push(temporary);
        	console.info(score);
        	$('#h4result'+resultid).text($('#'+stuId).text());
        	$('#imgresult'+resultid).attr({src:"../../head portrait/"+stuId+"-head portrait.jpg"});
        	$('a#'+stuId).attr({hidden:true});
        	$('#head').dialog('close');
        	//$('#'+stuId).text("123");
        }
        function save(){
        	//console.info(score);
        	$.post('../../phoneSaveTrain',{
        		type:1,
        		score: JSON.stringify(score)
        	},function(result){
        		//console.info(result);
        		if(result.result>0){
        			  location.reload();
        		}else{
        			$.messager.show({
		   				title:'提示',
		   				msg:"提交失败",
		   				timeout:1000,
		   				showType:'fade'
		   			});
        		}
        	},'json');
        }
</script>
        <header>
            <div class="titlebar reverse">               
                <h1>折返跑</h1>
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
                    <th field="shuttlerun" align="center" width="100">折返跑成绩</th>
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
        <div id="dd" class="easyui-dialog" title="秒表" closed="true" align="center" style="width:80%;height:70%;"
          data-options="resizable:true,modal:true">
             <div class="box" align="center">
			<div id="showtime" align="center">
				<span>00</span>
				<span>:</span>
				<span>00</span>
				<span>:</span>
				<span>00</span>
			</div>
			<div class="bnt">
				<button>记次</button>
				<button>启动</button>
			</div>
			<!--记录显示的次数-->
			<div id="record" align="center">
				<!--/*<div>
					<span class="left">第一次记录:</span>
					<span class="right">00:00:00</span>
				</div>*/-->
			</div>
		</div>
        </div>
        <div id="sb" class="easyui-dialog" title="成绩" closed="true" align="center" style="width:80%;height:70%;"
          data-options="resizable:true,modal:true">
          <ul id="result">
          </ul>
          <a href="javascript:save()" class="easyui-linkbutton">提交</a>
        </div>
        <div id="head" class="easyui-dialog" title="成绩"  closed="true" align="center" style="width:80%;height:70%;"
          data-options="resizable:true,modal:true">
          <ul id="head">
          </ul>
        </div>
    </body>
</html>