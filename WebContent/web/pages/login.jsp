<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en"> 
<head> 
<meta charset="utf-8"> 
<meta name="viewport" content="width=device-width, initial-scale=1"> 
<title>青少年篮球大数据处理平台</title> 
<link href="css/base.css" rel="stylesheet">
<link href="css/login/login.css" rel="stylesheet">
<link rel="stylesheet" href="../custom/uimaker/easyui.css">
<script type="text/javascript" src="../custom/jquery.min.js"></script>
<script type="text/javascript" src="../custom/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../custom/easyui-lang-zh_CN.js"></script>
<link rel="stylesheet" type="text/css" href="../custom/uimaker/icon.css">
<script type="text/javascript">
var loc = location.href;
var n1 = loc.length;//地址的总长度
var n2 = loc.indexOf("=");//取得=号的位置
var rst = decodeURI(loc.substr(n2+1, n1-n2));//从=号后面的内容
   $(function(){
	   if(rst==1){
		   $.messager.show({
				title:'提示',
				msg:"用户名或密码不能为空",
				timeout:1000,
				showType:'fade'
			});
	   }else if(rst==2){
		   $.messager.show({
				title:'提示',
				msg:"请选择身份",
				timeout:1000,
				showType:'fade'
			});
	   }else if(rst==3){
		   $.messager.show({
				title:'提示',
				msg:"用户名或密码错误",
				timeout:1000,
				showType:'fade'
			});
	   }else if(rst==4){
		   $.messager.show({
				title:'提示',
				msg:"正在审核中！",
				timeout:1000,
				showType:'fade'
			});
	   }
	   $('#username').bind('input propertychange', function() {  
		   if($('#username').val().length==0){
			   $('#tip').text("请输入账号"); 
			  }else{
				  if($('#password').val().length==0){
		           $('#tip').text("请输入密码");
	             }else{
	            	 if($('#cb').combobox('getValue')==0){
	            		 $('#tip').text("请选择身份");
	            	 }else{
	            		 $('#tip').text("请登陆");
	            	 }
	             } 
			  }
		   
		   });  
		   $('#password').bind('input propertychange', function() {  
			   if($('#username').val().length==0){
				   $('#tip').text("请输入账号"); 
				  }else{
					  if($('#password').val().length==0){
			           $('#tip').text("请输入密码");
		             }else{
		            	 if($('#cb').combobox('getValue')==0){
		            		 $('#tip').text("请选择身份");
		            	 }else{
		            		 $('#tip').text("请登陆");
		            	 }
		             } 
				  }
			   
			   });  
			   $('#cb').combobox({
				   onSelect:function(newVal,oldVal){
					   if($('#username').val().length==0){
						   $('#tip').text("请输入账号"); 
						  }else{
							  if($('#password').val().length==0){
					           $('#tip').text("请输入密码");
				             }else{
				            	 if($('#cb').combobox('getValue')==0){
				            		 $('#tip').text("请选择身份");
				            	 }else{
				            		 $('#tip').text("请登陆");
				            	 }
				             } 
						  }
				  }
			   });
			   $('#fmprovince').combobox({
				     onSelect: function(rec){
				    	 $('#clubname').combobox('setValue', "请选择省份");
				    	 $('#coaname').combobox('setValue', "请选择训练中心");
				    	 $("#coaId").val(""); 
				    	 //$("#coaId").attr({value:""});
				    	 if(rec.province!="请选择..."){
				    	   var url = '../../getClubCoa?province='+rec.province;
				    	   $('#clubname').combobox('reload', url);
				    	 }

					}
				});
			   $('#clubname').combobox({
				     onSelect: function(rec){
				    	 $('#coaname').combobox('setValue', "请选择训练中心");
				    	 $("#coaId").val(""); 
				    	 //$("#coaId").attr({value:""});
				    	// if(rec.province!="请选择..."){
				    	  var url = '../../getClubCoa?clubId='+rec.clubId;
				    	  $('#coaname').combobox('reload', url);
				    	// }

					}
				});
			   $('#coaname').combobox({
				     onSelect: function(rec){
				    	// alert(rec.coaId);
				    	 $("#coaId").val(rec.coaId);  
				    	// $("#coaId").attr({value:rec.coaId});
				    	// if(rec.province!="请选择..."){
				    	  var url = '../../getClubCoa?clubId='+rec.clubId;
				    	  $('#coaname').combobox('reload', url);
				    	// }

					}
				});
   })  
   function login(){
	    document.getElementById("fm").submit();
	}
   function apply(){
	   $('#applydlg').dialog('open');
   }
   function add(){
	   //alert($('#clubname').combobox('getValue'));;
	   $('#fm1').form('submit',{
		    onSubmit: function(){
		    	//alert("123");
		    	if($('#fm1').form('validate')){
		    		if($('#fmprovince').combobox('getValue')!="请选择..."&&$('#clubname').combobox('getValue')!="请选择省份"&&$('#coaname').combobox('getValue')!="请选择训练中心"){
		    			//alert(123);
		    			return true;
		    		}else{
		    			//alert(456);
		    			return false;
		    		}
		    	}else{
		    		//alert(123);
		    		return false;
		    	} 
		    },
		    success:function(result){
		    	closeDialog();
		    	 $.messager.show({
	    				title:'提示',
	    				msg:JSON.parse(result).result,
	    				timeout:1000,
	    				showType:'fade'
	    			});
		    }
		});
   }
   function closeDialog(){
	   $('#applydlg').dialog('close');
	   $("#addusername").val(""); 
	   $("#addpassword").val(""); 
	   $("#name").val(""); 
	   $('#fmprovince').combobox('setValue', '请选择...');
	   $('#clubname').combobox('setValue', "请选择省份");
  	   $('#coaname').combobox('setValue', "请选择训练中心");
  	   $("#coaId").val(""); 
   }
</script>

</head> 
<body>
	<div class="login-hd">
		<div class="left-bg"></div>
		<div class="right-bg"></div>
		<div class="hd-inner">
			<span class="logo"></span>
			<span class="split"></span>
			<span class="sys-name">篮球青少年大数据平台</span>
		</div>
	</div>
	<div class="login-bd">
		<div class="bd-inner">
			<div class="inner-wrap">
				<div class="lg-zone">
					<div class="lg-box">
						<div class="lg-label"><h4>用户登录</h4></div>
						<div class="alert alert-error">
			              <i class="iconfont">&#xe62e;</i>
			              <span id="tip">请输入账号</span>
			            </div>
						<form id="fm" action="../../login" method="post">
							<div class="lg-username input-item clearfix">
								<i class="iconfont">&#xe60d;</i>
								<input id="username" name="username" type="text" placeholder="账号账号"/>
							</div>
							<div class="lg-password input-item clearfix">
								<i class="iconfont">&#xe634;</i>
								<input id="password" name="password" type="password" placeholder="请输入密码"/>
							</div>
							<div class="lg-check clearfix">
								<div  style="position:absolute;left:16px;bottom:100px;">
									<i class="">&#xe633;</i>
									<span class="con-span"></span>
									<select class="easyui-combobox" id="cb" name="identity" style="height:35px;width:128px;" data-options="panelHeight:'auto'">
								    <option value="0">请选择身份</option>
								    <option value="1">学员</option>
								    <option value="2">教练</option>
								    <option value="3">训练中心</option>
								    <option value="4">管理员</option>
								    </select>
								 </div>
							</div>	
							<div class="tips clearfix">
							</div>
							<div class="enter">
								<a href="javascript:document:fm.submit();" class="purchaser">登陆</a>
								<a href="javascript:apply()" class="supplier">注册</a>
							</div>
						</form>
					</div>
				</div>
				<div class="lg-poster"></div>
			</div>
		</div>
	</div>
	<div class="login-ft">
		<div class="ft-inner">
			<div class="about-us">
				<a href="javascript:;">关于我们</a>
				<a href="javascript:;">法律声明</a>
				<a href="javascript:;">服务条款</a>
				<a href="javascript:;">联系方式</a>
			</div>
			<div class="address">地址：北京市北三环东路十五号北京化工大学&nbsp;邮编：10000&nbsp;&nbsp;计科1305-李浩铭&nbsp;版权所有</div>
			<div class="other-info">建议使用IE8及以上版本浏览器&nbsp;&nbsp;E-mail：652750037@qq.com</div>
		</div>
	</div>
	<div id="applydlg" class="easyui-dialog"  align="center" buttons="#applydlg-buttons" data-options="
                title: '注册',
	            width:300,
	            height:300,
	            closed:true,
	            closable:false,
	            modal:true,
				iconCls: 'icon-add'">
		   <form id="fm1" method="post" action="../../addUser">
			<table  style="position:relative;top:30px;font-size:18px;">
               <tr>
                  <td>账户：</td>
                  <td><input id="addusername" name="addusername" class="easyui-validatebox" required="true" missingMessage="用户名不能为空"></td>
               </tr> 
                <tr>
                  <td>密码：</td>
                  <td><input id="addpassword" name="addpassword" class="easyui-validatebox" required="true" missingMessage="密码不能为空"></td>
               </tr>
               <tr>
                  <td>姓名：</td>
                  <td><input id="name" name="name" class="easyui-validatebox" required="true" missingMessage="姓名不能为空"></td>
               </tr>      
               <tr>
                 <td>省份：</td>
                 <td><select id="fmprovince" name="fmprovince" class="easyui-combobox" valueField="province" textField="province" style="width:150px;" data-options="required:true,editable:false,panelHeight:'auto'">
                 <option value ="空">请选择...</option>
                 <option value ="北京">北京</option>
                 <option value ="天津">天津</option>
                 <option value ="上海">上海</option>
                 <option value ="重庆">重庆</option>
                 <option value ="河北">河北</option>
                 <option value ="山西">山西</option>
                 <option value ="辽宁">辽宁</option>
                 <option value ="吉林">吉林</option>
                 <option value ="黑龙江">黑龙江</option>
                 <option value ="江苏">江苏</option>
                 <option value ="浙江">浙江</option>
                 <option value ="安徽">安徽</option>
                 <option value ="福建">福建</option>
                 <option value ="江西">江西</option>
                 <option value ="山东">山东</option>
                 <option value ="河南">河南</option>
                 <option value ="湖北">湖北</option>
                 <option value ="湖南">湖南</option>
                 <option value ="广东">广东</option>
                 <option value ="海南">海南</option>
                 <option value ="四川">四川</option>
                 <option value ="贵州">贵州省 </option>
                 <option value ="云南">云南省 </option>
                 <option value ="陕西">陕西省 </option>
                 <option value ="甘肃">甘肃省 </option>
                 <option value ="青海">青海省 </option>
                 <option value ="台湾">台湾省 </option>
                 <option value ="广西">广西</option>
                 <option value ="内蒙古">内蒙古</option>
                 <option value ="西藏">西藏</option>
                 <option value ="宁夏">宁夏 </option>
                 <option value ="新疆">新疆</option>
                 <option value ="香港">香港</option>
                 <option value ="澳门">澳门</option>
               </select></td>
               </tr>
               <tr>
                  <td>训练中心：</td>
                  <td><input id="clubname" name="clubname" value="请选择省份" class="easyui-combobox" data-options="valueField:'clubId',textField:'clubname',required:true,editable:false,panelHeight:'auto'"></td>
               </tr>
               <tr>
                  <td>教练：</td>
                  <td><input id="coaname" name="coaname" value="请选择训练中心" class="easyui-combobox" data-options="valueField:'coaId',textField:'coaname',required:true,editable:false,panelHeight:'auto'"></td>
               </tr>
          </table>  
          <input name="identity" type="text" value="1" hidden="true">
          <input id="coaId" name="coaId" type="text" hidden="true">
        </form>
     </div>
     <div id="applydlg-buttons">
      <a href="javascript:add()" class="easyui-linkbutton" iconCls="icon-ok">注册</a>
      <a href="javascript:closeDialog()" class="easyui-linkbutton" iconCls="icon-cancel">返回</a>
     </div>
</body> 
</html>