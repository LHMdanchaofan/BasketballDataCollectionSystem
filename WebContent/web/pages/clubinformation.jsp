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
		 //console.info(result.result[0]);
		 rst=result;
		 $('td#name').text(result.result[0].clubname);
		 $('td#province').text(result.result[0].province); 
		 $('td#idcardnumber').text(result.result[0].idcardnumber);
		 $('td#birthday').text(result.result[0].birthday);
		 $('td#phonenumber').text(result.result[0].phonenumber);
		 $('td#email').text(result.result[0].email);
		 $('td#address').text(result.result[0].address);
		 $('input#fmname').val(result.result[0].clubname);
		 $('#fmprovince').combobox('select', result.result[0].province);  
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
<title>基本信息</title>
</head>
<body>
<div id="dlg" class="easyui-dialog"  align="center" buttons="#dlg-buttons" data-options="
                title: '修改基本信息',
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
            <td>名称：</td>
            <td><input  id="fmname" name="fmname" class="easyui-validatebox" type="text" style="width:150px;" required="true"></td>
            <td>所在省份：</td>
            <td><select id="fmprovince" name="fmprovince" class="easyui-combobox" valueField="province" textField="province" style="width:160px;" data-options="required:true,editable:false,panelHeight:'auto'">
                 <option value ="北京市">北京</option>
                 <option value ="天津市">天津</option>
                 <option value ="上海市">上海</option>
                 <option value ="重庆市">重庆</option>
                 <option value ="河北省">河北</option>
                 <option value ="山西省">山西</option>
                 <option value ="辽宁省">辽宁</option>
                 <option value ="吉林省">吉林</option>
                 <option value ="黑龙江省">黑龙江</option>
                 <option value ="江苏省">江苏</option>
                 <option value ="浙江省">浙江</option>
                 <option value ="安徽省">安徽</option>
                 <option value ="福建省">福建</option>
                 <option value ="江西省">江西</option>
                 <option value ="山东省">山东</option>
                 <option value ="河南省">河南</option>
                 <option value ="湖北省">湖北</option>
                 <option value ="湖南省">湖南</option>
                 <option value ="广东省">广东</option>
                 <option value ="海南省">海南</option>
                 <option value ="四川省">四川</option>
                 <option value ="贵州省">贵州省 </option>
                 <option value ="云南省">云南省 </option>
                 <option value ="陕西省">陕西省 </option>
                 <option value ="甘肃省">甘肃省 </option>
                 <option value ="青海省">青海省 </option>
                 <option value ="台湾省">台湾省 </option>
                 <option value ="广西壮族自治区">广西</option>
                 <option value ="内蒙古自治区">内蒙古</option>
                 <option value ="西藏自治区">西藏</option>
                 <option value ="宁夏回族自治区">宁夏 </option>
                 <option value ="新疆维吾尔自治区">新疆</option>
                 <option value ="香港特别行政区">香港</option>
                 <option value ="澳门特别行政区">澳门</option>
               </select>
            </td>
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
		      	<div class="column" ><span class="current">基本信息</span></div>
		      	<table class="kv-table">
					<tbody>
						<tr>
							<td class="kv-label">名称</td>
							<td class="kv-content" id="name"></td>
							<td class="kv-label">联系方式</td>
							<td class="kv-content" id="phonenumber"></td>
						</tr>
						<tr>
							<td class="kv-label">邮箱</td>
							<td class="kv-content" id="email"></td>
							<td class="kv-label">所在省份</td>
							<td class="kv-content" id="province"></td>
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