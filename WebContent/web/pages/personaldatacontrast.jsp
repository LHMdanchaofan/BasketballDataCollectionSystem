<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人数据对比</title>
<link rel="stylesheet" href="../custom/uimaker/easyui.css">
<script type="text/javascript" src="../custom/jquery.min.js"></script>
<script type="text/javascript" src="../custom/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../custom/easyui-lang-zh_CN.js"></script>
<script src="http://code.highcharts.com/highcharts.js"></script>
<script src="http://cdn.hcharts.cn/highcharts/modules/exporting.js"></script>
<script src="http://cdn.hcharts.cn/highcharts/modules/offline-exporting.js"></script>
<script>
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
$(function (){
	$('#lb1').linkbutton('disable');
	$('#lb2').linkbutton('disable');
	$('#lb3').linkbutton('disable');
	$('#lb4').linkbutton('disable');
})
$(function () {
	 var p = $('#begintime').datebox('panel'), //日期选择对象
	                tds = false, //日期选择对象中月份
	                yearIpt = p.find('input.calendar-menu-year'),//年份输入框
	                span = p.find('span.calendar-text'); //显示月份层的触发控件
        function padding(v) { if (v < 10) return '0' + v;return v;}//格式化类，小于10前面增加0
            $('#begintime').datebox({
                onShowPanel: function () {//显示日趋选择对象后再触发弹出月份层的事件，初始化时没有生成月份层
                    span.trigger('click'); //触发click事件弹出月份层
                    if (!tds) setTimeout(function () {//延时触发获取月份对象，因为上面的事件触发和对象生成有时间间隔
                        tds = p.find('div.calendar-menu-month-inner td');
                        tds.click(function (e) {
                            e.stopPropagation(); //禁止冒泡执行easyui给月份绑定的事件
                            var year = /\d{4}/.exec(span.html())[0]//得到年份
                            , month = parseInt($(this).attr('abbr'), 10); //月份，这里不需要+1
                            $('#begintime').datebox('hidePanel')//隐藏日期对象
                            .datebox('setValue', year + '-' + month); //设置日期的值
                        });
                    }, 0);
                    yearIpt.unbind();//解绑年份输入框中任何事件
                },
                parser: function (s) {
                    if (!s) return new Date();
                    var arr = s.split('-');
                    return new Date(parseInt(arr[0], 10), parseInt(arr[1], 10) - 1, 1);
                },
                //不需要xxxx-xx格式的去掉padding函数
                formatter: function (d) { return d.getFullYear() + '-' + padding(d.getMonth() + 1);/*getMonth返回的是0开始的，忘记了。。已修正*/ }
            });
           
        });
$(function () {
	 var p = $('#endtime').datebox('panel'), //日期选择对象
	                tds = false, //日期选择对象中月份
	                yearIpt = p.find('input.calendar-menu-year'),//年份输入框
	                span = p.find('span.calendar-text'); //显示月份层的触发控件
        function padding(v) { if (v < 10) return '0' + v;return v;}//格式化类，小于10前面增加0
            $('#endtime').datebox({
                onShowPanel: function () {//显示日趋选择对象后再触发弹出月份层的事件，初始化时没有生成月份层
                    span.trigger('click'); //触发click事件弹出月份层
                    if (!tds) setTimeout(function () {//延时触发获取月份对象，因为上面的事件触发和对象生成有时间间隔
                        tds = p.find('div.calendar-menu-month-inner td');
                        tds.click(function (e) {
                            e.stopPropagation(); //禁止冒泡执行easyui给月份绑定的事件
                            var year = /\d{4}/.exec(span.html())[0]//得到年份
                            , month = parseInt($(this).attr('abbr'), 10); //月份，这里不需要+1
                            $('#endtime').datebox('hidePanel')//隐藏日期对象
                            .datebox('setValue', year + '-' + month); //设置日期的值
                        });
                    }, 0);
                    yearIpt.unbind();//解绑年份输入框中任何事件
                },
                parser: function (s) {
                    if (!s) return new Date();
                    var arr = s.split('-');
                    return new Date(parseInt(arr[0], 10), parseInt(arr[1], 10) - 1, 1);
                },
                //不需要xxxx-xx格式的去掉padding函数
                formatter: function (d) { return d.getFullYear() + '-' + padding(d.getMonth() + 1);/*getMonth返回的是0开始的，忘记了。。已修正*/ }
            });
           
        });
function createchart(){
	$('#lb1').linkbutton('enable');
	$('#lb2').linkbutton('enable');
	$('#lb3').linkbutton('enable');
	$('#lb4').linkbutton('enable');
	$('#lb1').linkbutton('unselect');
	$('#lb2').linkbutton('unselect');
	$('#lb3').linkbutton('unselect');
	$('#lb4').linkbutton('unselect');
	var project=$('#project').combobox('getValue');
	$.post("../../personalDataChart",{
		begintime:$('#begintime').datebox("getValue"),
		endtime:$('#endtime').datebox("getValue"),
		project:project
	},function(result){
		var chart = new Highcharts.Chart('container', {
			    title: {
			        text: '训练成绩',
			    },
			    subtitle: {
			        text: '青少年篮球数据采集与展示系统',
			    },
			    xAxis: {
			       categories: result.xAxis,
			   },
			   plotOptions: {
		           series: {
		             connectNulls: true
		           }
		       },
			    yAxis: {
			        title: {
			            text: result.project+result.measure
			        },
			        plotLines: [{
			          value: 0,
			           width: 1,
			          color: '#808080'
			        }]
			  },
			    tooltip: {
			       valueSuffix: result.measure
			    },
			    legend: {
			        layout: 'vertical',
			        align: 'right',
			       verticalAlign: 'middle',
			        borderWidth: 0
			    },
			    series: [{
			        name: result.project,
			        data: result.data
			    }
			 ]
			});
		$('#lb1').bind('click', function(){
			if($("#lb1").linkbutton("options").selected==true){
				$.post("../../addData",{
					begintime:$('#begintime').datebox("getValue"),
					endtime:$('#endtime').datebox("getValue"),
					project:project,
					option:1
				},function(result){
					chart.addSeries({
						name: '全国最好成绩',
			            data: result.data
			        });
				},"json");
			}else{
				for(var i=0;i<chart.series.length;i++){
				  if(chart.series[i].name=="全国最好成绩"){
					  chart.series[i].remove();
					  break;
				  }
				}
			}
		    });
		    $('#lb2').bind('click', function(){
				if($("#lb2").linkbutton("options").selected==true){
					$.post("../../addData",{
						begintime:$('#begintime').datebox("getValue"),
						endtime:$('#endtime').datebox("getValue"),
						project:project,
						option:2
					},function(result){
						chart.addSeries({
							name: '全国平均成绩',
				            data: result.data
				        });
					},"json")
				}else{
					for(var i=0;i<chart.series.length;i++){
					  if(chart.series[i].name=="全国平均成绩"){
						  chart.series[i].remove();
						  break;
					  }
					}
				}
			    });
			    $('#lb3').bind('click', function(){
					if($("#lb3").linkbutton("options").selected==true){
						$.post("../../addData",{
							begintime:$('#begintime').datebox("getValue"),
							endtime:$('#endtime').datebox("getValue"),
							project:project,
							option:3
						},function(result){
							chart.addSeries({
								name: '个人最好成绩',
					            data: result.data
					        });
						},"json")
					}else{
						for(var i=0;i<chart.series.length;i++){
						  if(chart.series[i].name=="个人最好成绩"){
							  chart.series[i].remove();
							  break;
						  }
						}
					}
				    });
				    $('#lb4').bind('click', function(){
						if($("#lb4").linkbutton("options").selected==true){
							$.post("../../addData",{
								begintime:$('#begintime').datebox("getValue"),
								endtime:$('#endtime').datebox("getValue"),
								project:project,
								option:4
							},function(result){
								chart.addSeries({
									name: '全程平均成绩',
						            data: result.data
						        });
							},"json")
						}else{
							for(var i=0;i<chart.series.length;i++){
							  if(chart.series[i].name=="全程平均成绩"){
								  chart.series[i].remove();
								  break;
							  }
							}
						}
					    });
	},"json")
}
function abc(){
	location.reload();
}
</script>
</head>
<body id="lo" class="easyui-layout">
    <div data-options="region:'north',collapsible:'false'" align="center" style="height:100px;">
          <div style="position:relative;top:25px;" align="center">
                                           起始月份：
              <input class="easyui-datebox" id="begintime">
                                            截至月份：
              <input class="easyui-datebox" id="endtime">
                                            训练项目：
              <select id="project" class="easyui-combobox" panelHeight="auto" style="width:100px">
                <option value="1">折返跑</option>
                <option value="2">卧推</option>
                <option value="3">50米跑</option>
                <option value="4">1000米跑</option>
                <option value="5">定点投篮</option>
              </select>
          </div>
          <div style="position:relative;top:35px;" align="center">
             <a href="javascript:createchart()" class="easyui-linkbutton">生成训练数据图</a>
             <a href="javascript:abc()" class="easyui-linkbutton">重置</a>
          </div>
    </div>
	<div data-options="region:'west',title:'选项'" align="center" style="width:200px;">
	    <div style="position:relative;top:50px;">
	       <font size="3">选择添加数据：</font><p>
	       <a class="easyui-linkbutton" id="lb1" toggle="true">全国最好成绩</a><p>
	       <a class="easyui-linkbutton" id="lb2" toggle="true">全国平均成绩</a><p>
	       <a class="easyui-linkbutton" id="lb3" toggle="true">个人最好成绩</a><p>
	       <a class="easyui-linkbutton" id="lb4" toggle="true">全程平均成绩</a><p>
	    </div>
	</div>	
	<div data-options="region:'center'" align="center">
	        <div id="container" style="min-width:400px;height:400px">
	        </div>
	</div>	
</body>
</html>