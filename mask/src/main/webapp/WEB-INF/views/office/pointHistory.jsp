<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="false" %>
<html>
<head>
	<title>SE01</title>
</head>
<body>
<c:import url="./frameSet/header.jsp"></c:import>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<div class="pcoded-content">
    <div class="pcoded-inner-content">

        <!-- Main-body start -->
        <div class="main-body">
            <div class="page-wrapper">
	            <div class="page-body breadcrumb-page">
	                <!-- Simple Breadcrumb card start -->
	                <div class="card">
	                    <div class="card-block">
	                        <h5>포인트내역</h5>
	                    </div>
	                </div>
	            </div>
                <!-- Page-body start -->
                <div class="page-body">
                    <!-- 포인트 start -->
                    <div class="card">
                        <div class="card-header">
                            <h4>포인트현황</h4>
                    		<div class="card-block">
	                            <div class="form-group row">
	                                <div class="col-sm-5">
	                                    <input type="text" class="form-control" id="hasPoint" value="- 보유포인트 : <fmt:formatNumber value='${user.point }' pattern='#,###' />">
	                                </div>
	                                <div class="col-sm-5">
	                                    <input type="text" class="form-control" id="usablePoint" value="- 사용가능포인트 : <fmt:formatNumber value='${user.point }' pattern='#,###' />">
	                                </div>
	                            </div>
	                        </div>
	                    </div>
                    </div>
                    <!-- 포인트 end -->
                    <!-- 포인트리스트 start -->
                    <div class="card">
                        <div class="card-header">
                            <h4>사용내역</h4>
                            <div class="card-header-right">
                                <ul class="list-unstyled card-option">
                                    <li><i class="icofont icofont-minus minimize-card"></i></li>
                                </ul>
                            </div>
                        </div>
               			<form id="searchForm" onSubmit="return false;">
							<div class="form-group row">
								<div class="col-sm-10">
									<div class="dropdown-info dropdown open" style="margin-left:15">
										<button class="btn btn-info dropdown-toggle waves-effect waves-light " type="button" id="dropdown-4" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">기간</button>
										<div class="dropdown-menu" aria-labelledby="dropdown-4" data-dropdown-in="fadeIn" data-dropdown-out="fadeOut" x-placement="bottom-start" style="position: absolute; transform: translate3d(0px, 40px, 0px); top: 0px; left: 0px; will-change: transform;">
											<a class="dropdown-item waves-light waves-effect" href="#" onClick="chgDate(1)">당일</a>
											<a class="dropdown-item waves-light waves-effect" href="#" onClick="chgDate(7)">7일</a>
											<a class="dropdown-item waves-light waves-effect" href="#" onClick="chgDate(15)">15일</a>
											<a class="dropdown-item waves-light waves-effect" href="#" onClick="chgDate(30)">30일</a>
										</div>
									</div>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-sm-10">
	                                <div class="col-sm-10">
	                                    <input type="text" id="sDate"> - <input type="text" id="eDate"><button type="button" class="btn btn-primary btn-mini" id="primary-popover-content" onclick="searchList()" style="vertical-align:top; margin-left:10">SEARCH</button>
	                                    <input type="hidden" id="beginIdx"/>
	                                    <input type="hidden" id="searchRows" value="1000"/>
	                                </div>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-sm-10">
	                                <div class="col-sm-10" style="text-align:center;">
	                                    
	                                </div>
								</div>
							</div>
               			</form>
                        <div class="card-block table-border-style">
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th style="text-align:center;">날짜</th>
                                            <th style="text-align:center;">구분</th>
                                            <th style="text-align:center;">보내는사람</th>
                                            <th style="text-align:center;">받는사람</th>
                                            <th style="text-align:center;">적용p</th>
                                        </tr>
                                    </thead>
                                    <tbody id="pointList">
                                    	<c:forEach var="list" items="${list }">
	                                        <tr>
	                                            <td style="text-align:center;">${list.regdate }</td>
	                                            <td style="text-align:center;">${list.message }</td>
	                                            <td style="text-align:center;">${list.fromId }</td>
	                                            <td style="text-align:center;">${list.toId }</td>
	                                            <td style="text-align:center;"><fmt:formatNumber value='${list.point }' pattern='#,###' />p</td>
	                                        </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!-- 포인트리스트 end -->
                </div>
            </div>
        </div>
        <!-- Main-body end -->
<script>
	$(document).ready(function(){
		var date = new Date();
		$("#sDate").val(getFormatDate(date,"-"));
		$("#eDate").val(getFormatDate(date,"-"));
		$("#beginIdx").val("0");
	});
	
	function chgDate(n){
		var sDate = new Date();
		sDate.setDate(sDate.getDate() -n+1);
		$("#sDate").val(getFormatDate(sDate,"-"));
		$("#eDate").val(getFormatDate(new Date(),"-"));
	}
	
	function searchList(){
		console.log($("#sDate").val());
		console.log($("#sDate").val().replace(/-/gi, ''));
		
		var params = {
				'searchFromDate' : $("#sDate").val().replace(/-/gi, ""),
				'searchToDate' : $("#eDate").val().replace(/-/gi, ""),
				'beginIdx' : $("#beginIdx").val(),
				'searchRows' : $("#searchRows").val()
		};

		$.ajax({
			url : 'selectHistory',
			data : params,
			dataType : 'json',
			type : 'post',
			success:function(data){
				console.log(data);
				$("#pointList").empty();
				var dataList = data.list;
				if(data.list != null && data.list.length > 0){
					var html = '';
					for(var i=0; i<data.list.length; i++){
						var pointList = data.list[i];
						html += '<tr>';
						html += '<td style="text-align:center;">'+pointList.regdate+'</td>';
						html += '<td style="text-align:center;">'+pointList.message+'</td>';
						html += '<td style="text-align:center;">'+pointList.fromId+'</td>';
						html += '<td style="text-align:center;">'+pointList.toId+'</td>';
						html += '<td style="text-align:center;">'+displayComma(pointList.point)+'p</td>';
						html += '</tr>';
					}
					$("#pointList").html(html);
				}
			}
		})
	}
	
	$(function() {
	    $("#sDate").datepicker({
	         changeMonth: true,
	         changeYear: true,
	         dateFormat: 'yy-mm-dd',
	         dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
	         dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], 
	         monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
	         monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
	    });
	    $("#eDate").datepicker({
	         changeMonth: true,
	         changeYear: true,
	         dateFormat: 'yy-mm-dd',
	         dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
	         dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], 
	         monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
	         monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
	    });
	});
	
</script>
<c:import url="./frameSet/footer.jsp"></c:import>
</body>
</html>
