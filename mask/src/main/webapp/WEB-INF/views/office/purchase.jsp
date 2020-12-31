<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="false" %>
<html>
<head>
	<title>SE01</title>
	<style>
		select {
		    width: 120px; /* 원하는 너비설정 */
		    padding: .4em .4em; /* 여백으로 높이 설정 */
		    font-family: inherit;  /* 폰트 상속 */
/*		    background: url('이미지 경로') no-repeat 95% 50%;*/ /* 네이티브 화살표를 커스텀 화살표로 대체 */ 
		    border: 1px solid #999;
		    border-radius: 0px; /* iOS 둥근모서리 제거 */
		    -webkit-appearance: none; /* 네이티브 외형 감추기 */
		    -moz-appearance: none;
		    appearance: none;
		}
	</style>
</head>
<body>
<c:import url="./frameSet/header.jsp"></c:import>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<div class="pcoded-content">
    <div class="pcoded-inner-content">

        <!-- Main-body start -->
        <div class="main-body">
            <div class="page-wrapper">
                <!-- Page-body start -->
                <div class="page-body">
                    <!-- 구매내역 start -->
                    <div class="card">
                        <div class="card-header">
                            <h4>구매내역</h4>
                    		<div class="card-block">
	                            <div class="row">
                                    <div class="col-lg-4 col-xl-3 col-sm-6">
                                        <div class="badge-box" onclick="fn_search('00')">
                                           	결재완료 <b id="payedCnt">${payedCnt}</b>건
                                        </div>
                                    </div>
                                    <div class="col-lg-4 col-xl-3 col-sm-6">
	                                    <div class="badge-box" onclick="fn_search('03')">
											배송완료 <b id="completedCnt">${completedCnt}</b>건
	                                    </div>
	                                </div>
	                                <div class="col-lg-4 col-xl-3 col-sm-6">
	                                    <div class="badge-box" onclick="fn_search('02')">
                                           	배송중 <b id="ingCnt">${ingCnt}</b>건
                                        </div>
	                                </div>
	                                <div class="col-lg-4 col-xl-3 col-sm-6">
	                                    <div class="badge-box" onclick="fn_search('01')">
                                           	배송준비중 <b id="readyCnt">${readyCnt}</b>건
                                        </div>
	                                </div>
	                            </div>
	                            <div class="text-danger">
	                            	결재완료건은 배송완료건과 동일해야 하며
	                            </div>
	                            <div class="text-danger">
	                            	오차는 배송준비중 혹은 배송중에 있어야 합니다.
	                            </div>
	                            <div class="form-group row">
	                            	<div class="col-sm-12">
	                            		<input type="text" id="sDate"> - <input type="text" id="eDate">
	                            	</div>
	                            </div>
	                            <div class="form-group row" style="margin-left:0;display:none;" id="searchDiv">
	                                <div class="col-sm-2.5">
	                                	<select id="searchType" name="searchType">
	                                		<option value="id">아이디</option>
	                                		<option value="code">주문번호</option>
	                                	</select>
	                                </div>
	                                <div class="col-sm-5">
	                                	<input type="text" class="form-control form-control-success" id="searchValue" name="searchValue">
	                                </div>
	                                <div class="col-sm-4">
	                                	<button class="btn btn-warning btn-outline-warning" id="btnSearch"><i class="icofont icofont-warning-alt"></i>SEARCH</button>
	                                </div>
	                            </div>
	                            <div class="form-group row">
                                	<div class="col-sm-12">
               		                    <form name="uploadForm" id="uploadForm" enctype="multipart/form-data" onSubmit="return false;">
                           					<button class="btn btn-info btn-square" style="float:right;" id="btnExcelUp">Excel Upload</button>
                           					<input type="file" id="uploadExcel" style="float:right;border:1px;" name="uploadExcel" value="엑셀 업로드">
                            			</form>
                            		</div>
                            		<!-- 
                            		<div class="col-sm-12">
                            			<button class="btn btn-warning btn-square" style="float:right;margin-left:15" id="btnExcelDown">Excel Download</button>
                            			<button class="btn btn-info btn-square" style="float:right;" id="btnExcelUp">Excel Upload</button>
                            		 -->
                            		</div>
                            	</div>
	                        </div>
	                    </div>
                    </div>

                    <!-- 구매내역 end -->
                    <!-- 구매내역 리스트 start -->
                    <div class="card">
                        <div class="card-block table-border-style" id ="tblList">
                        	<c:forEach var="list" items="${list }" varStatus="status">
	                            <div class="table-responsive">
	                            	<div class="text-danger" style="font-size:20px">주문번호 : ${list.code }</div>
	                                <table class="table">
	                                    <thead>
	                                        <tr class="table-success">
	                                            <th style="text-align:center;">구분</th>
	                                            <th style="text-align:center;">주문일</th>
	                                            <th style="text-align:center;">상품명</th>
	                                            <th style="text-align:center;">결재p</th>
	                                            <th style="text-align:center;">주문상태</th>
	                                        </tr>
	                                    </thead>
	                                    <tbody>
	                                        <tr>
	                                            <td style="text-align:center;">${list.type }</td>
	                                            <td style="text-align:center;">${list.regdate }</td>
	                                            <td style="text-align:center;">${list.goodsName }</td>
	                                            <td style="text-align:center;"><fmt:formatNumber value="${list.point}" pattern="#,###" />p</td>
	                                            <td style="text-align:center;">${list.status }</td>
	                                        </tr>
	                                        <tr>
	                                        	<td colspan="5" class="table-active">배송지정보</td>
	                                        </tr>
	                                        <tr>
	                                        	<td colspan="5">주소 : (${list.deliveryZipcode }) ${list.deliveryAddr1 } ${list.deliveryAddr2 }</td>
	                                        </tr>
	                                        <tr>
	                                        	<td colspan="2">받는분 : ${list.receiveName }</td>
	                                        	<td colspan="3">연락처 : ${list.receivePhone }</td>
	                                        </tr>
	                                        <tr>
	                                        	<td colspan="2">배송사 : ${list.deliveryCompany }</td>
	                                        	<td colspan="3">송장번호 : ${list.deliveryCode }</td>
	                                        </tr>
	                                    </tbody>
	                                </table>
	                            </div>
	                            <div><p><br/></p></div>
							</c:forEach>
                        </div>
                    </div>
                    <!-- 구매내역 리스트 end -->
                </div>
            </div>
        </div>
        <!-- Main-body end -->
<script>

	$(document).ready(function(){
		var date = new Date();
		$("#sDate").val(getFormatDate(date,"-"));
		$("#eDate").val(getFormatDate(date,"-"));
		var adminYn = localStorage.getItem("adminYn");
		if(adminYn == 'Y'){
			$("#searchDiv").show();	
		}

	});
	
	function searchAddr(){
		new daum.Postcode({
			oncomplete: function(data){
				console.log(data);
				$("#zipcode").val(data.zonecode);
				$("#addr1").val(data.jibunAddress);
			}
		}).open();
	}
	
	$("#conPass").keyup(function(){
		if($("#newPass").val() != $("#conPass").val()){
			$("#conPassDiv").removeClass();
			$("#conPassDiv").addClass("form-group has-danger row");
			$("#conPass").removeClass();
			$("#conPass").addClass("form-control form-control-danger");
			$("#conMsg").text("비밀번호가 맞지 않습니다. 확인해주세요.");
		}else {
			$("#conPassDiv").removeClass();
			$("#conPassDiv").addClass("form-group has-success row");
			$("#conPass").removeClass();
			$("#conPass").addClass("form-control form-control-success");
			$("#conMsg").text("");
		}
	});

	$("#btnExcelDown").click(function(){
		
	});
	
	$("#btnExcelUp").click(function(){
		var formData = new FormData($("#uploadForm")[0]);
		
		$.ajax({
			url: 'uploadPurchase',
			data: formData,
			dataType : 'json',
			type : 'POST',
			enctype:"multipart/form-data",
			processData: false,
			contentType: false,
			success: function(data){
				alert(data.message);
			}
	
		});
	});
	
	function fn_search(status){
		var data = {
				'status' : status ? status : "00",
				'searchType' : $("#searchType").val(),
				'searchValue' : $("#searchValue").val(),
				'searchFromDate' : $("#sDate").val().replace(/-/gi, ''),
				'searchToDate' : $("#eDate").val().replace(/-/gi, '')
		};
		$.ajax({
			url: 'searchPurchase',
			data: data,
			dataType : 'json',
			type : 'POST',
			success: function(data){
				console.log(data);
				$("#payedCnt").text(data.payedCnt);
				$("#readyCnt").text(data.readyCnt);
				$("#completedCnt").text(data.completedCnt);
				$("#ingCnt").text(data.ingCnt);
				var html = '';
				
				for(var i=0; i<data.list.length; i++){
					var cData = data.list[i];
					
					html += '<div class="table-responsive">';
					html += '	<div class="text-danger" style="font-size:20px">주문번호 : '+cData.code+'</div>';
					html += '		<table class="table">';
					html += '			<thead>';
					html += '				<tr class="table-success">';
					html += '					<th style="text-align:center;">구분</th>';
					html += '					<th style="text-align:center;">주문일</th>';
					html += '					<th style="text-align:center;">상품명</th>';
					html += '					<th style="text-align:center;">결재p</th>';
					html += '					<th style="text-align:center;">주문상태</th>';
					html += '				</tr>';
					html += '			</thead>';
					html += '			<tbody>';
					html += '				<tr>';
					html += '					<td style="text-align:center;">'+cData.type+'</td>';
					html += '					<td style="text-align:center;">'+cData.regdate+'</td>';
					html += '					<td style="text-align:center;">'+cData.goodsName+'</td>';
					html += '					<td style="text-align:center;">'+cData.point+'p</td>';
					html += '					<td style="text-align:center;">'+cData.status+'</td>';
					html += '				</tr>';
					html += '				<tr>';
					html += '					<td colspan="5" class="table-active">배송지정보</td>';
					html += '				</tr>';
					html += '				<tr>';
					html += '					<td colspan="5">주소 : '+(cData.deliveryZipcode)+' '+cData.deliveryAddr1+' '+cData.deliveryAddr2+'</td>';
					html += '				</tr>';
					html += '				<tr>';
					html += '					<td colspan="2">받는분 : '+cData.receiveName+'</td>';
					html += '					<td colspan="3">연락처 : '+cData.receivePhone+'</td>';
					html += '				</tr>';
					html += '				<tr>';
					html += '					<td colspan="2">배송사 : '+cData.deliveryCompany+'</td>';
					html += '					<td colspan="3">송장번호 : '+cData.deliveryCode+'</td>';
					html += '				</tr>';
					html += '			</tbody>';
					html += '		</table>';
					html += '	</div>';
					html += '<div><p><br/></p></div></div>';
				}
				$("#tblList").html(html);
			}
	
		});
	}
	
	$("#btnSearch").click(function(){
		fn_search();
	});
	
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
