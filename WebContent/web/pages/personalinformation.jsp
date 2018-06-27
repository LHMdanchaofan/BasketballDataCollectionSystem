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
<script src="../custom/validate.js" type="text/javascript"></script>
<link href="css/basic_info.css" rel="stylesheet">
<link href="css/base.css" rel="stylesheet">
<script type="text/javascript">
var rst;
$(function(){
	$.post("../../personalInformation",function(result){
		 console.info(result.result[0]);
		 rst=result;
		 $('td#name').text(result.result[0].stuname);
		 $('td#name').text(result.result[0].coaname);
		 $('td#sex').text(result.result[0].sex); 
		 $('td#idcardnumber').text(result.result[0].idcardnumber);
		 $('td#birthday').text(result.result[0].birthday);
		 $('td#phonenumber').text(result.result[0].phonenumber);
		 $('td#email').text(result.result[0].email);
		 $('td#address').text(result.result[0].address);
		 if(result.result[0].stuname!=undefined){
			 $('input#fmname').val(result.result[0].stuname);
		 }else if(result.result[0].coaname!=undefined){
			 $('input#fmname').val(result.result[0].coaname); 
		 }
		 $('#fmsex').combobox('select', result.result[0].sex);  
		 $('input#fmidcardnumber').val(result.result[0].idcardnumber);
		 $('#fmbirthday').datebox('setValue',result.result[0].birthday);	
		 $('input#fmphonenumber').val(result.result[0].phonenumber);
		 $('input#fmemail').val(result.result[0].email);
		 $('input#fmaddress').val(result.result[0].address);
         //closed:true,
	},'json')
})
function modify(){
	$('#dlg').dialog('open');
}
function closeDialog(){
	 $('input#fmname').val(rst.result[0].stuname);
	 $('input#fmname').val(rst.result[0].coaname);
	 $('#fmsex').combobox('select', rst.result[0].sex);  
	 $('input#fmidcardnumber').val(rst.result[0].idcardnumber);
	 $('#fmbirthday').datebox('setValue',rst.result[0].birthday);	
	 $('input#fmphonenumber').val(rst.result[0].phonenumber);
	 $('input#fmemail').val(rst.result[0].email);
	 $('input#fmaddress').val(rst.result[0].address);
	$('#dlg').dialog('close');
}
function save(){
	$('#fm').form('submit', {
	    onSubmit: function(){
	    	if($('#fm').form('validate')){
	    		return true
	    	}else{
	    		return false;
	    	} 
	    	},success:function(result){
	    			location.reload(); 
	    },
	});
}
</script>
<title>个人信息</title>
</head>
<body>
<div id="dlg" class="easyui-dialog"  align="center" buttons="#dlg-buttons" data-options="
                title: '修改个人信息',
	            width:600,
	            height:250,
	            closable:false,
	            closed:true,
	            modal:true,
				iconCls: 'icon-edit'">
   <form id="fm" method="post" action="../../modifyPersonalinformation">
       <table style="font-size:22px;">
       <tr style="height:20px">
       </tr>
          <tr>
            <td>姓名：</td>
            <td><input  id="fmname" name="fmname" class="easyui-validatebox" type="text" style="width:100px;" required="true"></td>
            <td>性别：</td>
            <td><select id="fmsex" name="fmsex" class="easyui-combobox" valueField="sex" textField="sex" style="width:60px;" data-options="required:true,editable:false,panelHeight:'auto'">
                 <option value="1">男</option>
                 <option value="2">女</option>
               </select>
            </td>
          </tr> 
          <tr style="height:10px">
          </tr>
          <tr>
            <td>出生日期：</td>
            <td><input  id="fmbirthday" name="fmbirthday" class="easyui-datebox" type="text" style="width:120px;" editable="false" required="true"></td>
            <td>身份证号：</td>
            <td><input  id="fmidcardnumber" name="fmidcardnumber" class="easyui-validatebox" type="text" data-options="validType:'idCard'" style="width:150px;"></td>
          </tr> 
          <tr style="height:10px">
          </tr>
          <tr>
            <td>联系方式：</td>
            <td><input id="fmphonenumber" name="fmphonenumber" class="easyui-validatebox" type="text" data-options="validType:'Mobile'" style="width:150px;"></td>
            <td>邮箱：</td>
            <td><input id="fmemail" name="fmemail" class="easyui-validatebox" type="text" data-options="invalidMessage:'请输入正确的邮箱地址',validType:'email'" style="width:150px;"></td>
          </tr>
          <tr style="height:10px">
          </tr>      
       </table>
       <table style="font-size:22px;">
       <tr>
            <td>联系地址：</td>
            <td ><input id="fmaddress" name="fmaddress" class="easyui-validatebox" type="text" data-options="invalidMessage:'请输入正确的联系地址',validType:''" style="width:413px;"></td>      
       </tr>
         </table> 
      </form>
</div>
<div id="dlg-buttons">
   <a href="javascript:save()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
   <a href="javascript:closeDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>
  <div class="container">
      <div class="content" style="position:relative;left:-180px">
			<div class="easyui-tabs1" style="width:100%;">
		      <div title="基本信息" data-options="closable:false" class="basic-info">
		      	<div class="column" ><span class="current">个人信息</span></div>
		      	<table class="kv-table">
					<tbody>
						<tr>
							<td class="kv-label">姓名</td>
							<td class="kv-content" id="name"></td>
							<td class="kv-label">性别</td>
							<td class="kv-content" id="sex"></td>
						</tr>
						<tr>
							<td class="kv-label">出生日期</td>
							<td class="kv-content" id="birthday"></td>
							<td class="kv-label">身份证号</td>
							<td class="kv-content" id="idcardnumber"></td>
						</tr>
						<tr>
							<td class="kv-label">联系方式</td>
							<td class="kv-content" id="phonenumber"></td>
							<td class="kv-label">邮箱</td>
							<td class="kv-content" colspan="3" id="email"></td>
						</tr>
						<tr>
							<td class="kv-label">联系地址</td>
							<td class="kv-content" colspan="5" id="address"></td>
						</tr>
					</tbody>
				</table>
		<a href="javascript:modify()" class="easyui-linkbutton"  style="width:100px;position: absolute;left:45%;">修改</a>
	</div>
</div>
</div>
</div>
</body>
</html>