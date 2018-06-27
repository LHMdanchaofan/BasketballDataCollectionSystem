<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8"><link rel="icon" href="https://static.jianshukeji.com/highcharts/images/favicon.ico">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="../custom/uimaker/easyui.css">
<script type="text/javascript" src="../custom/jquery.min.js"></script>
<script type="text/javascript" src="../custom/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../custom/easyui-lang-zh_CN.js"></script>
<link rel="stylesheet" type="text/css" href="../custom/uimaker/icon.css">
<script src="https://img.hcharts.cn/highcharts/highcharts.js"></script>
<script src="https://img.hcharts.cn/highcharts/highcharts-more.js"></script>
<script src="https://img.hcharts.cn/highcharts/modules/exporting.js"></script>
<script src="https://img.hcharts.cn/highcharts-plugins/highcharts-zh_CN.js"></script>
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
var chart;
$(function(){
	$.post("../../dataContrast",function(result){
		chart = new Highcharts.Chart('container', {
	        chart: {
	            polar: true,
	            type: 'line'
	        },
	        title: {
	            text: '综合实力',
	            x: -60
	        },
	        pane: {
	            size: '80%'
	        },
	        credits: {
	        	enabled: false
	        },
	        xAxis: {
	            categories: ['灵活度', '力量', '爆发力', '耐久力',
	                         '得分能力'],
	            tickmarkPlacement: 'on',
	            lineWidth: 0
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
	            align: 'right',
	            verticalAlign: 'top',
	            y:70,
	            layout: 'vertical'
	        },
	        series: [{
	            name: '综合得分',
	            data: result.data,
	            pointPlacement: 'on'
	        }],
	    });
	},'json');
});
function add(index){
	if(chart.get($('#dg').datagrid('getRows')[index].stuId)==undefined){
		$.post("../../dataContrast",{
			stuId:$('#dg').datagrid('getRows')[index].stuId
		},function(result){
			chart.addSeries({
				id:$('#dg').datagrid('getRows')[index].stuId,
				name:$('#dg').datagrid('getRows')[index].stuname,
	            data: result.data
	        });
		},'json')
	}else{
		$.messager.show({
			title:'提示',
			msg:'该学员已在表中',
			timeout:1000,
			showType:'fade'
		});
	}
}
function doSearch(value,name){
	if(value==""){
		$.messager.show({
			title:'提示',
			msg:'输入栏不能为空',
			timeout:1000,
			showType:'fade'
		});
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
				{field:'stuname',title:'学员姓名',width:70,align:'center'},
				{field:'sex',title:'性别',width:70,align:'center'},
				{field:'province',title:'所在省份',width:70,align:'center'},
				{field:'coaname',title:'教练姓名',width:70,align:'center'},
				{field:'clubname',title:'所属训练中心',width:120,align:'center'},	
				{field:'formatter',title:'添加',width:70,formatter:formatOper,align:'center'},
		    ]]
		});
		$('#dg').datagrid('load',{
			value:value,
			name:name,
			})
	}
}
function formatOper(val,row,index){  
	return '<a href="javascript:add('+index+');">添加！</a>';
} 

</script>
<title>综合数据对比</title>
</head>
<body class="easyui-layout">
    <div data-options="region:'west',collapsible:false" style="width:45%;">
         <div id="container" style="position:relative;top:10%;min-width: 400px; max-width: 600px; height: 400px; margin: 0 auto"></div>
    </div>
    <div data-options="region:'center'" align="center" style="padding:5px;background:#eee;">
       <input class="easyui-searchbox" data-options="prompt:'姓名查询',menu:'#mm',searcher:doSearch" style="height:30px;width:200px"></input>
	           <div id="mm" style="width:120px">
		             <div id="student" data-options="name:'student'">学员</div>
	           </div> 
       <table id="dg">
        </table>
    </div>
</body>
</html>