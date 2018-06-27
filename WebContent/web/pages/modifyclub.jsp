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
<script>
$(function(){
	$.post('../../personalInformation',function(result){
		$('input#oldprovince').val(result.result[0].province);
		$('input#oldclub').val(result.result[0].clubname);
		$('input#oldcoach').val(result.result[0].coaname);
		$('input#oldcoaId').val(result.result[0].coaId);
		// console.info(result.result[0].province);
	 },'json')
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
 
function modifyclub(){
	$('#fm').form('submit',{
	    onSubmit: function(){
	        if($('#fmprovince').combobox('getValue')!="请选择..."&&$('#clubname').combobox('getValue')!="请选择省份"&&$('#coaname').combobox('getValue')!="请选择训练中心"){
	    			return true;
	    		}else{
	    			return false;
	    		}
	    },
	    success:function(result){
	    	if(JSON.parse(result).result=="更换失败，请重试！"){
	    		$.messager.show({
	    			title:JSON.parse(result).result,
	    			msg:JSON.parse(result).result,
	    			timeout:1000,
	    			showType:'fade'
	    		});
	    	}else if(JSON.parse(result).result=="不能选择相同的教练！"){
	    		$.messager.show({
	    			title:JSON.parse(result).result,
	    			msg:JSON.parse(result).result,
	    			timeout:1000,
	    			showType:'fade'
	    		});
	    	}else{
	    		parent.location.href="login.jsp"; 
	    	}
	    }
	});
}
</script>
<title>更换训练中心</title>
</head>
<body>
     <form id="fm" method="post" action="../../modifyClub">
       <table border="1" style="font-size:22px;">
          <tr>
            <td>省份</td>
            <td>原省份</td>
          </tr> 
          <tr>
            <td> <select id="fmprovince" name="fmprovince" class="easyui-combobox" valueField="province" textField="province" style="height:30px;width:150px;" data-options="required:true,editable:false,panelHeight:'auto'">
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
            <td><input id="oldprovince" type="text" style="font-size:22px;" readonly="readonly"></td>
          </tr>  
          <tr>
            <td>训练中心</td>
            <td>原训练中心</td>
          </tr>
          <tr>
            <td><input id="clubname" name="clubname" value="请选择省份" class="easyui-combobox" style="height:30px;width:200px;" data-options="valueField:'clubId',textField:'clubname',required:true,editable:false,panelHeight:'auto'"></td>
            <td><input id="oldclub" type="text" style="font-size:22px;" readonly="readonly"></td>
          </tr>  
          <tr>
            <td>教练</td>
            <td>原教练</td>
          </tr>
          <tr>
            <td><input id="coaname" name="coaname" value="请选择训练中心" class="easyui-combobox" style="height:30px;width:150px;" data-options="valueField:'coaId',textField:'coaname',required:true,editable:false,panelHeight:'auto'"></td>
            <td><input id="oldcoach" type="text" style="font-size:22px;" readonly="readonly"></td>
          </tr> 
       </table>
       <input id="coaId" name="coaId" type="text" hidden="true">
       <a style="position:relative;top:10px;left:180px" href="javascript:modifyclub()" class="easyui-linkbutton">申请！</a>
    </form>
</body>
</html>