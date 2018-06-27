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
<script type="text/javascript">
var loc = location.href;
var n1 = loc.length;//地址的总长度
var n2 = loc.indexOf("=");//取得=号的位置
var rs = decodeURI(loc.substr(n2+1, n1-n2));//从=号后面的内容
var clubnum;
var coachnum;
$(function(){
	if(rs=="success"){
		$.messager.show({
			title:'提示',
			msg:'修改成功',
			timeout:1000,
			showType:'fade'
		});
	}
	$.post("../../getDisplay",function(result){
		clubnum=result.club.length;
		coachnum=result.coach.length
		for(var i=0;i<result.club.length;i++){ 
			  $("div#contentclub"+i).text(result.club[i].clubname);	
		      $("input#club"+i).attr({value:result.club[i].clubId}); 
		      $("a#club"+i).text("删除"); 
		      $("a#club"+i).attr({href:"javascript:deleteclub("+result.club[i].clubId+")"}); 
			}  
		  for(var i=0;i<result.coach.length;i++){ 
			  $("div#contentcoach"+i).text(result.coach[i].coaname);
		      $("input#coach"+i).attr({value:result.coach[i].coaId});
		      //$("div#coach"+i).text(result.coach[i].coaId); 
		      $("a#coach"+i).text("删除"); 
		      $("a#coach"+i).attr({href:"javascript:deletecoach("+result.coach[i].coaId+")"});
			}  
	},'json');
	$('#cmb').combobox({
		onSelect: function(record){
			if(record.value==1){
				$('#dg1div').hide();
				$('#dgdiv').show();
				$('#dg').datagrid('load');
			}else if(record.value==2){
				$('#dgdiv').hide();
				$('#dg1div').show();
				$('#dg1').datagrid('load');
			}
		}
	});
	$('#cmb').combobox('select', 2);
})
function deleteclub(Id){
	for(var i=0;i<clubnum;i++){
		if($("input#club"+i).val()==Id)
		break;
	}
	if(i==(clubnum-1)){
		  $("div#contentclub"+i).text("");	
		  $("input#club"+i).attr({value:""});
	      $("a#club"+i).text(""); 
	      $("a#club"+i).attr({href:""});
	}else{
		for(var j=i;j<clubnum;j++){
			  var p=j+1;
			  $("div#contentclub"+j).text($("div#contentclub"+p).text());	
			  $("input#club"+i).attr({value:$("input#club"+p).val()});
		      //$("div#club"+j).text($("div#club"+p).text()); 
		      $("a#club"+j).text($("a#club"+p).text()); 
		      $("a#club"+j).attr({href:$("a#club"+p).attr("href")});
		}
		//$("td#club"+clubnum-1).html("<div id='club"+clubnum-1+"' hidden='true'></div><a id='club"+clubnum-1+"'></a>");	
	}
	clubnum=clubnum-1;
}
function deletecoach(Id){
	for(var i=0;i<coachnum;i++){
		if($("input#coach"+i).val()==Id)
		break;
	}
	if(i==(coachnum-1)){
		  $("div#contentcoach"+i).text("");	
		  $("input#coach"+i).attr({value:""});
	      $("a#coach"+i).text(""); 
	      $("a#coach"+i).attr({href:""});
	}else{
		for(var j=i;j<clubnum;j++){
			  var p=j+1;
			  $("div#contentcoach"+j).text($("div#contentcoach"+p).text());	
			  $("input#coach"+i).attr({value:$("input#coach"+p).val()});
		      $("a#coach"+j).text($("a#coach"+p).text()); 
		      $("a#coach"+j).attr({href:$("a#coach"+p).attr("href")});
		}
		//$("td#club"+clubnum-1).html("<div id='club"+clubnum-1+"' hidden='true'></div><a id='club"+clubnum-1+"'></a>");	
	}
	coachnum=coachnum-1;
}
function formatterclub(value,row,index){
	return '<a class="easyui-linkbutton" href="javascript:addclub('+row.clubId+');">添加</a>';
}
function formattercoach(value,row,index){
	return '<a class="easyui-linkbutton" href="javascript:addcoach('+row.coaId+');">添加</a>';
}
function addclub(Id,index){
	if(clubnum>=6){
		$.messager.show({
			title:'提示',
			msg:'推荐列表已满',
			timeout:1000,
			showType:'fade'
		});
		return;
	}else{
		for(var i=0;i<clubnum;i++){
			if($("input#club"+i).val()==Id){
				$.messager.show({
					title:'提示',
					msg:'该项已在推荐列表',
					timeout:1000,
					showType:'fade'
				});
				return;
				}
		    }	
		  $("div#contentclub"+i).text($('#dg').datagrid('getSelected').clubname);	
	      $("input#club"+i).attr({value:$('#dg').datagrid('getSelected').clubId}); 
	      $("a#club"+i).text("删除"); 
	      $("a#club"+i).attr({href:"javascript:deleteclub("+$('#dg').datagrid('getSelected').clubId+")"}); 
	      clubnum=clubnum+1;
	}
	
}
function addcoach(Id){
	if(coachnum>=6){
		$.messager.show({
			title:'提示',
			msg:'推荐列表已满',
			timeout:1000,
			showType:'fade'
		});
		return;
	}else{
		for(var i=0;i<coachnum;i++){
			if($("input#coach"+i).val()==Id){
				$.messager.show({
					title:'提示',
					msg:'该项已在推荐列表',
					timeout:1000,
					showType:'fade'
				});
				return;
				}
		    }	
		  $("div#contentcoach"+i).text($('#dg1').datagrid('getSelected').coaname);	
	      $("input#coach"+i).attr({value:$('#dg1').datagrid('getSelected').coaId}); 
	      $("a#coach"+i).text("删除"); 
	      $("a#coach"+i).attr({href:"javascript:deletecoach("+$('#dg1').datagrid('getSelected').coaId+")"}); 
	      coachnum=coachnum+1;
	}
}
</script>
<title>推荐管理</title>
</head>
<body class="easyui-layout">
    <div data-options="region:'center',title:'推荐列表'" style="padding:5px;background:#eee;">
    <select id="cmb" class="easyui-combobox" name="cmb" value="1" style="width:100px;" data-options="panelHeight:'auto'">
       <option value="1">训练中心</option>
       <option value="2">教练</option>
    </select>
    <div id="dgdiv">
     <table id="dg" class="easyui-datagrid" url="../../clubList" style="width:100%;"data-options="
                singleSelect:true,
                pagination:true,
                fitColumns:true,
                pageSize:10">
       <thead>
		<tr>
			<th hidden="true" data-options="field:'clubId',width:100,align:'center'">Id</th>
			<th data-options="field:'clubname',width:100,align:'center'">训练中心名称</th>
			<th data-options="field:'address',width:100,align:'center'">地址</th>
			<th data-options="field:'province',width:100,align:'center'">省份</th>
			<th field="add" width="100" align="center" formatter="formatterclub">添加</th>
		</tr>
    </thead>
    </table>
    </div>
    <div id="dg1div">
    <table id="dg1" class="easyui-datagrid" url="../../coachList" style="width:100%" data-options="
                singleSelect:true,
                pagination:true,
                fitColumns:true,
                pageSize:10">
       <thead>
		<tr>
			<th hidden="true" data-options="field:'coaId',width:100,align:'center'">Id</th>
			<th data-options="field:'coaname',width:100,align:'center'">姓名</th>
			<th data-options="field:'clubname',width:100,align:'center'">所属训练中心</th>
			<th data-options="field:'province',width:100,align:'center'">省份</th>
			<th field="add" width="100" align="center" formatter="formattercoach">添加</th>
		</tr>
    </thead>
    </table>
    </div>
    </div>
    <div data-options="region:'east',collapsible:false" style="width:430px;">
    <form id="fm" style="position:relative;top:20px;" method="post" action="../../modifyDisplay">
       <table  border="1" align="center" style="font-size:10px;">
          <tr>
            <td width="200px" align="center"><font size="5">训练中心推荐列表</font></td>
            <td width="200px" align="center"><font size="5">教练推荐列表</font></td>
          </tr> 
          <tr>
            <td id="club0" height="30px" align="center"><div id="contentclub0" style="float:left;"></div><input id="club0" name="club0" hidden="true"><a style="float:right;" id="club0"></a></td>
            <td id="coach0" align="center"><div id="contentcoach0" style="float:left;"></div><input id="coach0" name="coach0" hidden="true"><a style="float:right;" id="coach0" href=""></a></td>
          </tr>
          <tr>
            <td id="club1" height="30px" align="center"><div id="contentclub1" style="float:left;"></div><input id="club1" name="club1" hidden="true"><a style="float:right;" id="club1" href=""></a></td>
            <td id="coach1" align="center"><div id="contentcoach1" style="float:left;"></div><input id="coach1" name="coach1" hidden="true"><a style="float:right;" id="coach1" href=""></a></td>
          </tr> 
          <tr>
            <td id="club2" height="30px" align="center"><div id="contentclub2" style="float:left;"></div><input id="club2" name="club2" hidden="true"><a style="float:right;" id="club2" href=""></a></td>
            <td id="coach2" align="center"><div id="contentcoach2" style="float:left;"></div><input id="coach2" name="coach2" hidden="true"><a  style="float:right;" id="coach2" href=""></a></td>
          </tr>    
          <tr>
            <td id="club3" height="30px" align="center"><div id="contentclub3" style="float:left;"></div><input id="club3" name="club3" hidden="true"><a style="float:right;" id="club3" href=""></a></td>
            <td id="coach3" align="center"><div id="contentcoach3" style="float:left;"></div><input id="coach3" name="coach3" hidden="true"><a style="float:right;" id="coach3" href=""></a></td>
          </tr>
          <tr>
            <td id="club4" height="30px" align="center"><div id="contentclub4" style="float:left;"></div><input id="club4" name="club4" hidden="true"><a style="float:right;" id="club4" href=""></a></td>
            <td id="coach4" align="center"><div id="contentcoach4" style="float:left;"></div><input id="coach4" name="coach4" hidden="true"><a style="float:right;" id="coach4" href=""></a></td>
          </tr>
           <tr>
            <td id="club5" height="30px" align="center"><div id="contentclub5" style="float:left;"></div><input id="club5" name="club5" hidden="true"><a style="float:right;" id="club5" href=""></a></td>
            <td id="coach5" align="center"><div id="contentcoach5" style="float:left;"></div><input id="coach5" name="coach5" hidden="true"><a style="float:right;" id="coach5" href=""></a></td>
          </tr>
        </table>
        <input class="easyui-linkbutton" type="submit" style="position:relative;top:20px;left:180px" value="保存" />
       </form>
    </div>
</body>
</html>