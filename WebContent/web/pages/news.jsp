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
<link rel="stylesheet" href="css/workbench.css">
<script type="text/javascript">
  var loc = location.href;
  var n1 = loc.length;//地址的总长度
  var n2 = loc.indexOf("=");//取得=号的位置
  var id = decodeURI(loc.substr(n2+1, n1-n2));//从=号后面的内容
  //alert(id);
$(function(){
	if(isNaN(id)){
		$('#pp').attr({hidden:false});
		$('#panel').attr({hidden:false});
		$('#newsdetail').attr({hidden:true});
		$('#newsname').attr({hidden:true});	
		$('#addtime').attr({hidden:true});	
		$("#news").hide();
		$.post("../../getNews",function(result){
			$('#pp').pagination('refresh',{total:result.total});
		},'json');
		$.post("../../newsList",{
			page:1,
			rows:10,
		},function(result){
			//console.info(result);
			for(var i=1;i<=result.rows.length;i++){
				//alert(result.news[i-1].name);
				$("li#li"+i).attr({style:"margin-bottom:20px"});
				$("a#a"+i).text(result.rows[i-1].name);
				$("a#a"+i).attr({href:"javascript:newsdetail("+result.rows[i-1].Id+")"});
				$("label#label"+i).text(result.rows[i-1].addtime);
			}
		},'json')
	}else{
		$('#pp').attr({hidden:true});
		$('#panel').attr({hidden:true});
		$('#newsdetail').attr({hidden:false});	
		$('#newsname').attr({hidden:false});	
		$('#addtime').attr({hidden:false});
		$.post("../../getNews",{Id:id},function(result){
			var str=result.news[0].content;
			$('#newsname').text(result.news[0].name);
			$('#addtime').text(result.news[0].addtime);
			$('#newsdetail').html(str);
		},'json')
	}
	$('#pp').pagination({
		onSelectPage:function(pageNumber, pageSize){
			$.post("../../newsList",{
				page:pageNumber,
				rows:pageSize
			},function(result){
				//console.info(result);
				for(var i=1;i<=10;i++){
					if(i<=result.rows.length){
					   $("li#li"+i).attr({style:"margin-bottom:20px"});
					   $("a#a"+i).text(result.rows[i-1].name);
					   $("a#a"+i).attr({href:"javascript:newsdetail("+result.rows[i-1].Id+")"});
					   $("label#label"+i).text(result.rows[i-1].addtime);
					}else{
						$("li#li"+i).attr({style:"display:none;"});
						   $("a#a"+i).text("");
						   $("label#label"+i).text("");
					}
				}
			},'json')
		}
	});
})
function newsdetail(id){
	$('#pp').attr({hidden:true});
	$('#panel').attr({hidden:true});
	$('#newsdetail').attr({hidden:false});	
	$('#newsname').attr({hidden:false});	
	$('#addtime').attr({hidden:false});
	$("#news").show();
	$.post("../../getNews",{Id:id},function(result){
		var str=result.news[0].content;
		$('#newsname').text(result.news[0].name);
		$('#addtime').text(result.news[0].addtime);
		$('#newsdetail').html(str);
	},'json')
}
</script>
<title>新闻</title>
</head>
<body style="overflow-x:hidden ">
   <div>
      <a href="workbench.html" style="text-decoration:none;"><font color="Lime"><-首页</font></a>
      <a id="news" href="news.jsp" style="text-decoration:none;"><font color="Lime"><-新闻</font></a>
   </div>
   <h2 id="newsname" align="center" style="position:relative;top:-15px;right:150px;"></h2>
   <h6 id="addtime" align="right" style="position:relative;top:-45px;right:250px;"></h6>
   <textarea id="newsdetail" readonly="readonly" style="resize:none;width:95%;height:450px;position:relative;top:-65px;"></textarea>
   <div id="panel" class="easyui-panel" align="left" style="width:1000px;height:429px">
         <ul style="height:400px">
           <li id="li1" style="display:none;">
               <span></span>
                <font size="3"><a id="a1" href="javascript:;" class="ellipsis"></a></font>
                <label id="label1"></label>
            </li>
            <li id="li2" style="display:none;height:20%;">
               <span></span>
                <font size="3"><a id="a2" href="javascript:;" class="ellipsis"></a></font>
                <label id="label2"></label>
             </li>
             <li id="li3" style="display:none;">
                  <span></span>
                 <font size="3"><a id="a3" href="javascript:;" class="ellipsis"></a></font>
                   <label id="label3"></label>
              </li>
              <li id="li4" style="display:none;">
              <span></span>
                <font size="3"><a id="a4" href="javascript:;" class="ellipsis"></a></font>
                <label id="label4"></label>
            </li>
            <li id="li5" style="display:none;">
               <span></span>
                <font size="3"><a id="a5" href="javascript:;" class="ellipsis"></a></font>
                <label id="label5"></label>
             </li>
             <li id="li6" style="display:none;">
                  <span></span>
                  <font size="3"><a id="a6" href="javascript:;" class="ellipsis"></a></font>
                   <label id="label6"></label>
              </li>
              <li id="li7" style="display:none;">
              <span></span>
                <font size="3"><a id="a7" href="javascript:;" class="ellipsis"></a></font>
                <label id="label7"></label>
            </li>
            <li id="li8" style="display:none;">
               <span></span>
                <font size="3"><a id="a8" href="javascript:;" class="ellipsis"></a></font>
                <label id="label8"></label>
             </li>
             <li id="li9" style="display:none;">
                  <span></span>
                  <font size="3"><a id="a9"  href="javascript:;" class="ellipsis"></a></font>
                   <label id="label9"></label>
              </li>
              <li id="li10" style="display:none;">
                  <span></span>
                  <font size="3"><a id="a10" href="javascript:;" class="ellipsis"></a></font>
                   <label id="label10"></label>
              </li>
            </ul>    
   </div>
<div id="pp" class="easyui-pagination" style="width:998px;border:1px solid #ccc;"
    data-options="
    layout:['first','prev','links','next','last'],
    showPageList: false,
	showRefresh: false">
</div>
</body>
</html>