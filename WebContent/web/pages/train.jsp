<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en"> 
<head> 
    <meta charset="utf-8"> 
    <meta name="viewport" content="width=device-width, initial-scale=1"> 
    <title>篮球大数据青少年数据采集与展示系统</title> 
<link href="css/base.css" rel="stylesheet">
<link rel="stylesheet" href="../custom/uimaker/easyui.css">
<script type="text/javascript" src="../custom/jquery.min.js"></script>
<script type="text/javascript" src="../custom/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../custom/easyui-lang-zh_CN.js"></script>
<link rel="stylesheet" href="css/providers1.css">
<link rel="stylesheet" type="text/css" href="../custom/uimaker/icon.css">
<script type="text/javascript" src="js/main.js"></script>
<script type="text/javascript">    
function formatOper(val,row,index){  
	if(val==0){
	    return '<a class="easyui-linkbutton" href="javascript:openDoubtdlg('+index+');"><font color="Fuchsia">疑问？</font></a>';  
	}else if(val==1){
		return '<font color="Lime">正在处理!</font>';
	}else{
		return '<font color="red">处理完毕!</font>';
	}
}  
function openDoubtdlg(index){  
	$("#Id").val($('#dg').datagrid('getRows')[index].Id);
	 $('#dlg').dialog('open');
		    //alert(index);		
} 
function closeDialog(){
	$('#dlg').dialog('close');
	$("#doubtdetail").val("");
}
function save(){
	$.post('../../addDoubt',{
		Id:document.getElementById("Id").value,
		detail:document.getElementById("doubtdetail").value
	},function(result){
		//console.info(result);
		if(result.result>0){
			closeDialog()
			$('#dg').datagrid('reload');
			 $.messager.show({
 				title:'提示',
 				msg:'提交成功',
 				timeout:1000,
 				showType:'fade'
 			});
		}else{
			 $.messager.show({
 				title:'提示',
 				msg:'提交失败',
 				timeout:1000,
 				showType:'fade'
 			});
		}		
	},'json')
}
$(".more").click(function(){
    $(this).closest(".conditions").siblings().toggleClass("hide");
});
function searchTrain(){	
	$('#dg').datagrid('load',{
		begintime:$('#begintime').datebox("getValue"),
		endtime:$('#endtime').datebox("getValue"),
		beginshuttlerun:document.getElementById("beginshuttlerun").value,
		endshuttlerun:document.getElementById("endshuttlerun").value,
		beginbenchpress:document.getElementById("beginbenchpress").value,
		endbenchpress:document.getElementById("endbenchpress").value,
		begin50meters:document.getElementById("begin50meters").value,
		end50meters:document.getElementById("end50meters").value,
		begin1000meters:document.getElementById("begin1000meters").value,
		end1000meters:document.getElementById("end1000meters").value,
		beginsetshot:document.getElementById("beginsetshot").value,
		endsetshot:document.getElementById("endsetshot").value,
	})
}
function reset(){
	$('#beginshuttlerun').textbox('setValue','');
	$('#endshuttlerun').textbox('setValue','');
	$('#beginbenchpress').textbox('setValue','');
	$('#endbenchpress').textbox('setValue','');
	$('#begin50meters').textbox('setValue','');
	$('#end50meters').textbox('setValue','');
	$('#begin1000meters').textbox('setValue','');
	$('#end1000meters').textbox('setValue','');
	$('#beginsetshot').textbox('setValue','');
	$('#endsetshot').textbox('setValue','');
	$('#begintime').datebox('setValue','');
	$('#endtime').datebox('setValue','');
	$('#dg').datagrid('load',{
		begintime:null,
		endtime:null,
		beginshuttlerun:null,
		endshuttlerun:null,
		beginbenchpress:null,
		endbenchpress:null,
		begin50meters:null,
		end50meters:null,
		begin1000meters:null,
		end1000meters:null,
		beginsetshot:null,
		endsetshot:null,
	});
}
</script>
</head> 
<body>
     <div class="container">
       <table id="dg" class="easyui-datagrid" url="../../trainList" style="width:100%" title="训练信息汇总" data-options="
                rownumbers:true,
                singleSelect:false,
                autoRowHeight:false,
                pagination:true,
                fitColumns:true,
                striped:true,
                checkOnSelect:false,
                selectOnCheck:false,
                toolbar:'#tb',
                pageSize:10">
            <thead>
                <tr>
                    <th field="Id" width="100" hidden="true"></th>
                    <th field="shuttlerun" width="100">折返跑/s</th>
                    <th field="benchpress" width="100">卧推/kg</th>
                    <th field="50meters" width="100">50米跑/s</th>
                    <th field="1000meters" width="100">1000米跑/s</th>
                    <th field="setshot" width="100">定点投篮/个</th>
                    <th field="addtime" width="100">训练时间</th>
                    <th field="doubt" width="100" formatter="formatOper">复议</th>
                    <th field="doubtcontent" width="100" hidden="true">详细信息</th>
                </tr>
            </thead>
        </table>
        <div id="tb" style="padding:0 30px;">
        <div class="conditions">
            <span class="con-span">起始时间: </span><input id="begintime" class="easyui-datebox" type="text" name="begintime" editable="false" style="width:166px;height:35px;line-height:35px;"></input>
            <span class="con-span">截至时间: </span><input id="endtime" class="easyui-datebox" type="text" name="endtime" editable="false" style="width:166px;height:35px;line-height:35px;"></input>
            <a id="search" href="javascript:searchTrain()" class="easyui-linkbutton" iconCls="icon-search" data-options="toggle:true,group:'g1'">查询</a>
            <a id="reset" href="javascript:reset()" class="easyui-linkbutton" iconCls="icon-reload" data-options="toggle:true,group:'g1'">重置</a>
            <a id="more" href="#" class="easyui-linkbutton more" iconCls="icon-more" data-options="toggle:true,group:'g1'">更多</a>
        </div>
        <div class="conditions hide">
            <span class="con-span">折返跑：     </span><input class="easyui-textbox" id="beginshuttlerun" name="beginshuttlerun" type="text" style="width:166px;height:35px;line-height:35px;"></input>
            <span class="con-span">————>  </span><input class="easyui-textbox" id="endshuttlerun" name="endshuttlerun" type="text" style="height:35px;width:166px;"></input>
            <span class="con-span">卧推：         </span><input class="easyui-textbox" id="beginbenchpress" name="beginbenchpress" type="text"  style="width:166px;height:35px;line-height:35px;"></input>
            <span class="con-span">————>  </span><input class="easyui-textbox" id="endbenchpress" name="endbenchpress" type="text" style="width:166px;height:35px;line-height:35px;"></input>
        </div>
        <div class="conditions hide">
            <span class="con-span">50米跑：   </span><input class="easyui-textbox" id="begin50meters" name="begin50meters" type="text"  style="width:166px;height:35px;line-height:35px;"></input>
            <span class="con-span">————>  </span><input class="easyui-textbox" id="end50meters" name="end50meters" type="text" style="width:166px;height:35px;line-height:35px;"></input>
            <span class="con-span">100米跑：</span><input class="easyui-textbox" id="begin1000meters" name="begin100meters" style="width:166px;height:35px;line-height:35px;">
            <span class="con-span">————>  </span><input class="easyui-textbox" id="end1000meters" name="end100meters" type="text" style="width:166px;height:35px;line-height:35px;"></input>
        </div>
        <div class="conditions hide">
            <span class="con-span">定点投篮： </span><input class="easyui-textbox" id="beginsetshot" name="beginsetshot" type="text"  style="width:166px;height:35px;line-height:35px;"></input>
            <span class="con-span">————>  </span><input class="easyui-textbox" id="endsetshot" name="endsetshot" type="text"  style="width:166px;height:35px;line-height:35px;"></input>
        </div>
      </div>
 </div>
  <div id="dlg" class="easyui-dialog"  align="center" buttons="#dlg-buttons" data-options="
                title: '提交疑问信息',
	            width:300,
	            height:200,
	            closable:false,
	            closed:true,
	            modal:true,
				iconCls: 'icon-add'">
		   <form id="fm" method="post" action="">
			<table  style="position:relative;top:30px;font-size:18px;">
               <textarea id="doubtdetail"style="resize:none;width:95%;height:90px;position:relative;top:5px;">
               </textarea> 
          </table>
          <input id="Id" name="Id" type="text" hidden="true"> 
       </form>
</div>
<div id="dlg-buttons">
   <a href="javascript:save()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
   <a href="javascript:closeDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>
 <script type="text/javascript">    
$(".more").click(function(){
    $(this).closest(".conditions").siblings().toggleClass("hide");
});
</script>
</body> 
</html>