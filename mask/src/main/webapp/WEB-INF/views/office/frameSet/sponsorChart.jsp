<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewPort" content="width=device-width, inital-scale=1.0,mininum-scale=0.3,maximum-scale=2.0, user-scalable=yes">

<style>
	.boxbox{
		border:1px solid #050099;
		/* width: 80px; */
	}
</style>
<style>
      *{margin: 0;padding: 0;list-style-type: none;}
      .clearfix{*zoom: 1;}
      .clearfix:after{content: '';display: block;clear: both;}
      div{position: relative;width: 1000px;height: 200px;margin: 0 auto;overflow: hidden;}
      ul{position: absolute;left: 0;top: 0;width: 3000px;}
      ul li{width: 1000px;height: 200px;float: left;}
      .box1{background-color: #b3c4f8;}
      .box2{background-color: #f8bfb4;}
      .box3{background-color: #b4f8b6;}
 </style>
 
<link rel="stylesheet" type="text/css" href="resources/mask2/css/style.css">

<!-- Required Jquery -->
<script type="text/javascript" src="resources/mask2/js/jquery/jquery.min.js"></script>
 <script>
$(function(){
            var d = false;
            $("html, body").on('mousewheel DOMMouseScroll', function(e) {
                var E = e.originalEvent;
                delta = 0;
                if (E.detail) {
                    delta = E.detail * -40;
                }else{
                    delta = E.wheelDelta;
                };
 
                var a = parseInt($("ul").css("left"));
                var b = $("li").width();
                var c = $('li').length;
                
                if(delta < 0 && a > (c-1)*-b && !d){
                    // 마우스 휠을 아래로 내렸을 경우
                    d = true;
                    $('ul').stop().animate({
                        "left": a += -b
                    },400,function(){
                        d = false;
                    });
                };
                if(delta > 0 && a < 0 && !d){
                    // 마우스 휠을 위로 올렸을 경우
                    d = true;
                    $('ul').stop().animate({
                        "left": a += b
                    },400,function(){
                        d = false;
                    });
                };
            });
        });
</script>
</head>
<body>
<!-- <div>
    <ul class="clearfix">
        <li class="box1"></li>
        <li class="box2"></li>
        <li class="box3"></li>
    </ul>
</div> -->

<table class="table">
	<thead>
	
	</thead>
	<tbody>
		<tr>
			<td class="boxbox">
				${sponList.id } <br/>
				${sponList.name } <br/>
				${sponList.regdate.substring(0, 10) } <br/>
				${sponList.agentNm } <br/>
			</td>                    
		</tr>
		<tr>
           	<td style="height:10px;"></td>
    	</tr>
 
		<c:if test="${sponList.userList.size() > 0 }">
			<tr>
				<c:forEach items="${sponList.userList }" var="list">
					<td class="boxbox">
						${list.id } <br/>
						${list.name } <br/>
						${list.regdate.substring(0, 10) } <br/>
						${list.agentNm } <br/>
					</td>

					<c:if test="${list.userList.size() > 0 }">
						</tr>						
						<tr>
						<c:forEach items="${list.userList }" var="list2">
							<td class="boxbox">
								${list2.id } <br/>
								${list2.name } <br/>
								${list2.regdate.substring(0, 10) } <br/>
								${list2.agentNm } <br/>
							</td>
						</c:forEach>
					</c:if>
				</c:forEach>
			</tr>
		</c:if>
		
	</tbody>
</table>
	  

	<%-- <c:if test="${sponList.userList.size > 0 }">
		<c:forEach items="${sponList.userList }" var="i">
		
		</c:forEach>
	</c:if> --%>
	

<script>
	$(document).ready(function(){
		$.ajax({
			url : 'getSponsorTree',
			data : {'id':'test01', 'maxLoop':0},
			dataType : 'json',
			type : 'post',
			success:function(data){	
				var i = 0;
				var list = data.userList;
				
				html = '<tr>';
				html += '	<td>';
				html += 		data.id+'<br/>';
				html += 		data.name+'<br/>';
				html += 		'대리점<br/>';
				html += 		data.regdate.substring(0, 10)+'<br/>';
				html += 		data.agentNm+'<br/>';
				html += '	</td>';
				html += '</tr>';
				
				
				do{
					i++;
					
					html += setTreeDataFirst(list);
					console.log(i);
				}while ();
			}
			
		})
	})
	
	function setTreeDataUnderLoop(list){
		var html = '';
		
		html += '<tr>';
		
		for( var i=0; i < list.length; i++){
			if(list[i].userList.length == 0){
				html += '<td></td>';
			}else{
				html += setTreeDataUnderLoop(list[i].userList);
			}
		}
		html += '</tr>';
		
		for( var i=0; i < list.length; i++){
			html += '<td>';
			html += list.id+'<br/>';
			html += list.name+'<br/>';
			html += '대리점<br/>';
			html += list.regdate.substring(0, 10)+'<br/>';
			html += list.agentNm+'<br/>';
			html += '</td>';
		}
		
		return html;
		
	}
	
	function test(){
		
		
	}
	
	function setTreeDataFirst(list){
		var html = '';
		html += '<tr>';
		
		for( var i=0; i < list.length; i++){
			html += '<td>';
			html += list.id+'<br/>';
			html += list.name+'<br/>';
			html += '대리점<br/>';
			html += list.regdate.substring(0, 10)+'<br/>';
			html += list.agentNm+'<br/>';
			html += '</td>';
		}
		html += '</tr>';
		
		html += '<tr>';
		for( var i=0; i < list.length; i++){
			html += setTreeDataUnderLoop(list[i].userList);		
		}
		html += '</tr>';
		
		
		return html;
		
	}
	
	
	
	
</script>

</body>
</html>