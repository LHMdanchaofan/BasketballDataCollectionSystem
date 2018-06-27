<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script type="text/javascript" src="../custom/jquery.min.js"></script>
<script src="http://code.highcharts.com/highcharts.js"></script>
<link rel="stylesheet" href="css/workbench.css">
</head>
<body>
<div id="chart1"></div>
<script>
$(function () {
    $('#chart3').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false
        },
        title: {
            text: '2014 某网站上各个浏览器的访问量占比'
        },
        tooltip: {
            headerFormat: '{series.name}<br>',
            pointFormat: '{point.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: false
                },
                showInLegend: true
            }
        },
        series: [{
            type: 'pie',
            name: '浏览器访问量占比',
            data: [
                ['Firefox',   45.0],
                ['IE',       26.8],
                {
                    name: 'Chrome',
                    y: 12.8,
                    sliced: true,
                    selected: true
                },
                ['Safari',    8.5],
                ['Opera',     6.2],
                ['其他',   0.7]
            ]
        }]
    });
});

</script>
</body>
<div class="container">
        <div id="hd">
            
        </div>

        <div id="bd">
            <div class="bd-content">
                <div class="right-zone">
                    <div id="news" class="inform item-box">
                        <div class="inform-hd">
                            <label>篮球新闻</label>
                            <a href="news.jsp">更多<span>&gt;</span></a>
                        </div>
                        <ul>
                            <li>
                                <span></span>
                                <a id="news0" href="javascript:;" class="ellipsis"><i></i></a>
                                <label id="news0"></label>
                            </li>
                            <li>
                                <span></span>
                                <a id="news1" href="javascript:;" class="ellipsis"><i></i></a>
                                <label id="news1"></label>
                            </li>
                            <li>
                                <span></span>
                                <a id="news2" href="javascript:;" class="ellipsis"></a>
                                <label id="news2"></label>
                            </li>
                            <li>
                                <span></span>
                                <a id="news3" href="javascript:;" class="ellipsis"></a>
                                <label id="news3"></label>
                            </li>
                            <li>
                                <span></span>
                                <a id="news4" href="javascript:;" class="ellipsis"></a>
                                <label id="news4"></label>
                            </li>
                            <li>
                                <span></span>
                                <a id="news5" href="javascript:;" class="ellipsis"></a>
                                <label id="news5"></label>
                            </li>
                        </ul>
                    </div>
                    <div id="display" class="attached item-box">
                        <div class="inform-hd">
                            <label>本周推荐</label>
                        </div>
                        <div class="attached-tab">
                            <a href="javascript:;" class="current item-left" attached="public-attached">推荐俱乐部</a>
                            <a href="javascript:;" class="item-right" attached="inner-attached">推荐教练</a>
                        </div>
                        <ul class="public-attached">
                            <li>
                                <span></span>
                                <a id="clubdisplay0" href="" class="ellipsis"></a>
                            </li>
                           <li>
                              <span></span>
                                 <a id="clubdisplay1" href="" class="ellipsis"></a>
                             </li>
                            <li>
                              <span></span>
                                 <a id="clubdisplay2" href="" class="ellipsis"></a>
                             </li>
                            <li>
                              <span></span>
                                 <a id="clubdisplay3" href="" class="ellipsis"></a>
                             </li>
                             <li>
                              <span></span>
                                 <a id="clubdisplay4" href="" class="ellipsis"></a>
                             </li>
                           <li>
                              <span></span>
                                 <a id="clubdisplay5" href="" class="ellipsis"></a>
                             </li>
                        </ul>
                        <ul class="inner-attached hide">
                           <li>
                                <span></span>
                                <a id="coachdisplay0" href="" class="ellipsis"></a>
                            </li>
                            <li>
                                <span></span>
                                <a id="coachdisplay1" href="" class="ellipsis"></a>
                            </li>
                            <li>
                                <span></span>
                                <a id="coachdisplay2" href="" class="ellipsis"></a>
                            </li>
                            <li>
                                <span></span>
                                <a id="coachdisplay3" href="" class="ellipsis"></a>
                            </li>
                            <li>
                                <span></span>
                                <a id="coachdisplay4" href="" class="ellipsis"></a>
                            </li>
                            <li>
                                <span></span>
                                <a id="coachdisplay5" href="" class="ellipsis"></a>
                            </li>
                        </ul>
                    </div>
                    <div style="height:13px"></div>
                    <div id="friendforum" class="price item-box">
                        <div class="inform-hd">
                            <label>友情论坛</label>
                            <a href="moreforum.jsp">更多<span>&gt;</span></a>
                        </div>
                        <ul>
                            <li>
                                <span></span>
                                <a id="friendforum0" href="" class="ellipsis" target="_Blank"></a>
                            </li>
                            <li>
                                <span></span>
                                <a id="friendforum1" href="" class="ellipsis" target="_Blank"></a>
                            </li>
                            <li>
                                <span></span>
                                <a id="friendforum2" href="" class="ellipsis" target="_Blank"></a>
                            </li>
                            <li> 
                                <span></span>
                                <a id="friendforum3" href="" class="ellipsis" target="_Blank"></a>
                            </li>
                            <li>
                                <span></span>
                                <a id="friendforum4" href="" class="ellipsis" target="_Blank"></a>
                            </li>
                            <li>
                                <span></span>
                                <a id="friendforum5" href="" class="ellipsis" target="_Blank"></a>
                            </li>
                        </ul>
                    </div>
                    
                </div>
                <div class="center-part">
                    <div class="center-items todo">
                        <div class="calendar-part">
                             <div class="easyui-calendar" disabled="true" style="width:205px;height:231px;" data-options="
			             validator: function(date){
			             var myDate = new Date();
			            if (date.getYear() == myDate.getYear() ){
			                if(date.getMonth()==myDate.getMonth()){
			                   if(parseInt(date.getDate()/7)==parseInt(myDate.getDate()/7)){
			                     if(date.getDay()==myDate.getDay()){
			                      return true;
			                      }else{
			                      return false;
			                      }
			                     }else{
			                     return false;
			                     }
			                }else{
			                  return false;
			                }
				      	 
				        } else {
					     return false;
				           }}">
                     </div>
                        </div>                             
                            <iframe width="100%" height="100%" src="notice_detail.html">
                            </iframe>
                        
                 </div> 
                    <div class="center-items chart0 clearfix">
                        <div class="chart0-item">
                            <div class="item-inner">
                                <div class="item-content">
                                    <div class="content-hd">全国学员分布</div>
                                    <div class="chart-chart" id="chart1"></div>
                                </div>
                            </div>
                        </div>
                        <div class="chart0-item">
                            <div class="item-inner">
                                <div class="item-content">
                                    <div class="content-hd">PC端与手机端数据提交对比</div>
                                    <div class="chart-chart" id="chart3"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="center-items chart1">
                        <div class="chart1-inner">
                             <div class="item-hd">半年度全国训练数据统计</div>
                             <div class="chart1-chart" id="chart2"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>          
    </div>
</html>