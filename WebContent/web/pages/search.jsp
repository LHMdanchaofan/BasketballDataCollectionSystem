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
<link rel="stylesheet" type="text/css" href="../custom/uimaker/icon.css">
<link rel="stylesheet" href="css/providers1.css">
<script type="text/javascript" src="js/main.js"></script>
<script src="https://img.hcharts.cn/highcharts/highcharts.js"></script>
<script src="https://img.hcharts.cn/highcharts/highcharts-more.js"></script>
<script src="https://img.hcharts.cn/highcharts/modules/exporting.js"></script>
<script src="https://img.hcharts.cn/highcharts-plugins/highcharts-zh_CN.js"></script>
<link href="css/basic_info.css" rel="stylesheet">
<link href="css/base.css" rel="stylesheet">
<script type="text/javascript">
Highcharts.setOptions({
    lang:{
       contextButtonTitle:"图表导出菜单",
       decimalPoint:".",
       downloadJPEG:"下载JPEG图片",
       downloadPDF:"下载PDF文件",
       downloadPNG:"下载PNG文件",
       downloadSVG:"下载SVG文件",
       drillUpText:"返回 {series.name}",
       loading:"加载中",
       months:["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"],
       noData:"没有数据",
       numericSymbols: [ "千" , "兆" , "G" , "T" , "P" , "E"],
       printChart:"打印图表",
       resetZoom:"恢复缩放",
       resetZoomTitle:"恢复图表",
       shortMonths: [ "Jan" , "Feb" , "Mar" , "Apr" , "May" , "Jun" , "Jul" , "Aug" , "Sep" , "Oct" , "Nov" , "Dec"],
       thousandsSep:",",
       weekdays: ["星期一", "星期二", "星期三", "星期四", "星期五", "星期六","星期天"]
    }
}); 
$('#container').highcharts({
    exporting: {
        url: 'http://export.highcharts.com.cn' 
        // 注：该链接支持 https 协议
}
});
function doSearch(value,name){
	if(value==""){
		$.messager.show({
			title:'提示',
			msg:'输入栏不能为空',
			timeout:1000,
			showType:'fade'
		});
	}else if(name=="club"){
		$('#dg').datagrid({
			url:'../../searchInformation',
		    singleSelect:false,
            autoRowHeight:false,
            pagination:true,
            fitColumns:true,
            striped:true,
            checkOnSelect:false,
            selectOnCheck:false,
            collapsible:true,
            pageSize:10,
		    columns:[[
				{field:'clubname',title:'训练中心',width:100,align:'center'},
				{field:'phonenumber',title:'联系方式',width:100,align:'center'},
				{field:'email',title:'Email',width:100,align:'center'},
				{field:'province',title:'所在省份',width:100,align:'center'},
				{field:'address',title:'地址',width:100,align:'center'},		
				{field:'detail',title:'详细信息',width:100,align:'center',formatter:clubDetail},
		    ]]
		});
		$('#dg').datagrid('load',{
			value:value,
			name:name,
			})
	}else if(name=="coach"){
		$('#dg').datagrid({
			url:'../../searchInformation',
		    singleSelect:false,
            autoRowHeight:false,
            pagination:true,
            fitColumns:true,
            striped:true,
            checkOnSelect:false,
            selectOnCheck:false,
            collapsible:true,
            pageSize:10,
		    columns:[[
		    	{field:'coaId',title:'coaId',width:100,align:'center',hidden:true},
				{field:'coaname',title:'教练姓名',width:100,align:'center'},
				{field:'sex',title:'性别',width:100,align:'center'},
				{field:'province',title:'所在省份',width:100,align:'center'},
				{field:'email',title:'email',width:100,align:'center',hidden:true},
				{field:'birthday',title:'birthday',width:100,align:'center',hidden:true},
				{field:'phonenumber',title:'联系方式',width:100,align:'center'},
				{field:'clubname',title:'所属训练中心',width:100,align:'center'},
				{field:'detail',title:'详细信息',width:100,align:'center',formatter:coachDetail},
		    ]]
		});
		$('#dg').datagrid('load',{
			value:value,
			name:name,
			})
	}else if(name=="student"){
		$('#dg').datagrid({
			url:'../../searchInformation',
		    singleSelect:false,
            autoRowHeight:false,
            pagination:true,
            fitColumns:true,
            striped:true,
            checkOnSelect:false,
            selectOnCheck:false,
            collapsible:true,
            pageSize:10,
		    columns:[[
				{field:'stuname',title:'学员姓名',width:100,align:'center'},
				{field:'sex',title:'性别',width:100,align:'center'},
				{field:'birthday',title:'生日',width:100,align:'center',hidden:true},
				{field:'phonenumber',title:'联系方式',width:100,align:'center',hidden:true},
				{field:'email',title:'email',width:100,align:'center',hidden:true},
				{field:'province',title:'所在省份',width:100,align:'center'},
				{field:'coaname',title:'教练姓名',width:100,align:'center'},
				{field:'clubname',title:'所属训练中心',width:100,align:'center'},
				{field:'detail',title:'详细信息',width:100,align:'center',formatter:studentDetail},
		    ]]
		});
		$('#dg').datagrid('load',{
			value:value,
			name:name,
			})
	}
}
function clubDetail(val,row,index){
	return '<a href="javascript:openclubDealdlg('+index+');">更多！</a>';
}
function coachDetail(val,row,index){
	return '<a href="javascript:opencoachDealdlg('+index+');">更多！</a>';
}
function studentDetail(val,row,index){
	return '<a href="javascript:openstudentDealdlg('+index+');">更多！</a>';
}
function openclubDealdlg(index){  
	$('#clubdlg').dialog('open');	
    $('#clubname').text($('#dg').datagrid('getRows')[index].clubname);
    $('#clubaddress').text($('#dg').datagrid('getRows')[index].address);
    $('#clubphonenumber').text($('#dg').datagrid('getRows')[index].phonenumber);
    $('#clubemail').text($('#dg').datagrid('getRows')[index].email);
    $('#clubprovince').text($('#dg').datagrid('getRows')[index].province);
    $('#website').html("<a target='_blank' href="+$('#dg').datagrid('getRows')[index].website+">"+$('#dg').datagrid('getRows')[index].website+"</a>");
    $.post("../../coaStuNum",{
    	clubId:$('#dg').datagrid('getRows')[index].clubId,
    },function(result){
    	// console.info(result);
    	 $('#clubcoanum').text(result.coanum);
    	 $('#clubstunum').text(result.stunum);
    },'json');
}  
function opencoachDealdlg(index){  
	$('#coadlg').dialog('open');	
    $('#coaname').text($('#dg').datagrid('getRows')[index].coaname);
    $('#coabirthday').text($('#dg').datagrid('getRows')[index].birthday);
    $('#coaphonenumber').text($('#dg').datagrid('getRows')[index].phonenumber);
    $('#coaemail').text($('#dg').datagrid('getRows')[index].email);
    $('#coaclubname').text($('#dg').datagrid('getRows')[index].clubname);
   // alert($('#dg').datagrid('getRows')[index].coaId);
    $.post("../../coaStuNum",{
	  coaId:$('#dg').datagrid('getRows')[index].coaId,
    },function(result){
	 //console.info(result);
	 $('#coastunum').text(result.stunum);
  },'json');	
}  
function openstudentDealdlg(index){  
	$('#studentdlg').dialog('open');
	$('#stuname').text($('#dg').datagrid('getRows')[index].stuname);
	$('#birthday').text($('#dg').datagrid('getRows')[index].birthday);
	$('#phonenumber').text($('#dg').datagrid('getRows')[index].phonenumber);
	$('#email').text($('#dg').datagrid('getRows')[index].email);
	 $.ajax({
		    url:'http://localhost:8080/teenagersbasketball/head%20portrait/'+$('#dg').datagrid('getRows')[index].stuId+'-head%20portrait.jpg',
		    type:'HEAD',
		    error: function() {
			 $('img#head').attr({src:"../../head portrait/user.png"})
		    },
		    success: function() {
			 $('img#head').attr({src:"../../head portrait/"+$('#dg').datagrid('getRows')[index].stuId+"-head portrait.jpg"})
		    }
		 });	 
	$.post("../../dataContrast",{
		stuId:$('#dg').datagrid('getRows')[index].stuId
	},function(result){
		var chart = new Highcharts.Chart('container', {
	        chart: {
	            polar: true,
	            type: 'line'
	        },
	        title: {
	            text:null,
	        },
	        pane: {
	            size: '80%'
	        },
	        credits: {
	        	enabled: false
	        },
	        xAxis: {
	            categories: ['灵活度', '力量', '爆发力', '耐久力',
	                         '得分'],
	            tickmarkPlacement: 'on',
	            lineWidth: 0,
	        },
	        yAxis: {
	            gridLineInterpolation: 'polygon',
	            lineWidth: 0,
	            min: 0,
	            max:10
	        },
	        tooltip: {
	            shared: true,
	        },
	        legend: {
	            enabled: false
	        },
	        series: [{
	            name: '综合得分',
	            data: result.data,
	            pointPlacement: 'on'
	        }],
	        navigation: {
	            buttonOptions: {
	                enabled: false
	            }
	        }
	    });
	},'json');
	$.post("../../studentPersonalRank",{
		stuId:$('#dg').datagrid('getRows')[index].stuId
	},function(result){
		//console.info(result.rank[0]);
		$('font#shuttletrun').text(result.rank[0]);
		$('font#benchpress').text(result.rank[1])
		$('font#50meters').text(result.rank[2])
		$('font#1000meters').text(result.rank[3])
		$('font#setshot').text(result.rank[4])
	},'json');
}  
</script>
</head>
<body class="easyui-layout">
      <div data-options="region:'north',title:'查询',collapsible:false" align="center" style="height:100px;">
         <div style="position:relative;top:20px;">
            <input class="easyui-searchbox" data-options="prompt:'名称查询',menu:'#mm',searcher:doSearch" style="width:200px"></input>
	           <div id="mm" style="width:120px">
		             <div id="club" data-options="name:'club'">训练中心</div>
		             <div id="coach" data-options="name:'coach'">教练</div>
		             <div id="student" data-options="name:'student'">学员</div>
	           </div>
         </div>
      </div>
      <div data-options="region:'center',title:'显示'" style="padding:5px;background:#eee;">
        <table id="dg">
        </table>
      </div>
      <div id="studentdlg" class="easyui-dialog"  align="center" buttons="#dlg-buttons" data-options="
                title: '详细信息',
	            width:600,
	            height:450,
	            closed:true,
	            closable:true,
	            modal:true,
				iconCls: 'icon-edit'">
		  <div class="easyui-layout" style="width:100%;height:100%;">
		     <div data-options="region:'north',collapsible:false" style="height:100px;">
		       <table  style="position:relative;top:10px;font-size:18px;">
                 <tr>
                 <td width="50px">
                 </td>
                 <td>
                   <div style="width:48px;height:48px">
                     <img id="head" style="width:100%;height:100%" src="" alt="">
                   </div>
                 </td>
                 <td width="20px">
                 </td>
                 <td>姓名：</td>
                 <td><div id="stuname"></div></td>
                 <td width="20px">
                 </td>
                 <td>出生日期：</td>
                 <td><div id="birthday"></div></td>
               </tr>   
               <tr>
                  <td width="50px">
                  </td>
                  <td>
                  </td>
                  <td width="20px">
                  </td>
                  <td>联系方式：</td>
                  <td><div id="phonenumber"></div></td>
                  <td width="20px">
                  </td>
                  <td>email：</td>
                  <td><div id="email"></div></td>
               </tr> 
          </table>
		     </div>
             <div data-options="region:'west',collapsible:false" style="width:50%;">
               <div id="container" style="width: 90%; height: 100%; margin: 0 auto"></div>
             </div>
             <div data-options="region:'center'" align="center" style="padding:5px;">
             <table style="position:relative;top:10px;font-size:18px;">
                 <tr>
                   <td><font size="5" color="OrangeRed">个人全国排名</font></td>
                 </tr>
              </table>
              <table  style="position:relative;top:10px;font-size:18px;">
                 <tr height="40px"></tr>
                 <tr>
                   <td>折返跑</td>
                   <td width="80px"></td>
                   <td>第<font id="shuttletrun" size="4" color="red"></font>名</td>
                 </tr>
                 <tr height="10px"></tr>
                 <tr>
                   <td>卧    推</td>
                   <td></td>
                   <td>第<font id="benchpress" size="4" color="red"></font>名</td>
                 </tr>
                  <tr height="10px"></tr>
                 <tr>
                   <td>50米跑</td>
                   <td></td>
                   <td>第<font id="50meters" size="4" color="red"></font>名</td>
                 </tr>
                  <tr height="10px"></tr>
                 <tr>
                   <td>1000米跑</td>
                   <td></td>
                   <td>第<font id="1000meters" size="4" color="red"></font>名</td>
                 </tr>
                  <tr height="10px"></tr>
                 <tr>
                   <td>定点投篮</td>
                   <td></td>
                   <td>第<font id="setshot" size="4" color="red"></font>名</td>
                 </tr>
              </table>
             </div>
		  </div>
      </div>
       <div id="clubdlg" class="easyui-dialog" data-options="
                title: '详细信息',
	            width:750,
	            height:300,
	            closed:true,
	            closable:true,
	            modal:true,
				iconCls: 'icon-edit'">
	<div class="container">
      <div class="content" style="position:relative;left:-180px;width:750px">
		      <div title="基本信息" data-options="closable:false" class="basic-info">
		      	<div class="column" ><span class="current">基本信息</span></div>
		      	<table class="kv-table">
					<tbody>
						<tr>
							<td class="kv-label">训练中心</td>
							<td class="kv-content" id="clubname"></td>
							<td class="kv-label">联系方式</td>
							<td class="kv-content" id="clubphonenumber"></td>
						</tr>
						<tr>
							<td class="kv-label">email</td>
							<td class="kv-content" id="clubemail"></td>
							<td class="kv-label">省份</td>
							<td class="kv-content" id="clubprovince"></td>
						</tr>
						<tr>
							<td class="kv-label">地址</td>
							<td class="kv-content" id="clubaddress"></td>
							<td class="kv-label">官方网站</td>
							<td class="kv-content" id="website"></td>
						</tr>
						<tr>
							<td class="kv-label">教练人数`</td>
							<td class="kv-content" id="clubcoanum"></td>
							<td class="kv-label">学员人数</td>
							<td class="kv-content" id="clubstunum"></td>
						</tr>
					</tbody>
				</table>
	    </div>
      </div>
     </div>
    </div>
    <div id="coadlg" class="easyui-dialog" data-options="
                title: '详细信息',
	            width:750,
	            height:300,
	            closed:true,
	            closable:true,
	            modal:true,
				iconCls: 'icon-edit'">
	<div class="container">
      <div class="content" style="position:relative;left:-180px;width:750px">
		      <div title="基本信息" data-options="closable:false" class="basic-info">
		      	<div class="column" ><span class="current">基本信息</span></div>
		      	<table class="kv-table">
					<tbody>
						<tr>
							<td class="kv-label">教练姓名</td>
							<td class="kv-content" id="coaname"></td>
							<td class="kv-label">出生日期</td>
							<td class="kv-content" id="coabirthday"></td>
						</tr>
						<tr>
							<td class="kv-label">联系方式</td>
							<td class="kv-content" id="coaphonenumber"></td>
							<td class="kv-label">email</td>
							<td class="kv-content" id="coaemail"></td>
						</tr>
						<tr>
							<td class="kv-label">训练中心</td>
							<td class="kv-content" id="coaclubname"></td>
							<td class="kv-label">学员人数</td>
							<td class="kv-content" id="coastunum"></td>
						</tr>
					</tbody>
				</table>
	    </div>
      </div>
     </div>
    </div>
</body>
</html>