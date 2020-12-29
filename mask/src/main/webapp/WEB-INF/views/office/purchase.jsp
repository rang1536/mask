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
                <!-- Page-body start -->
                <div class="page-body">
                    <!-- 구매내역 start -->
                    <div class="card">
                        <div class="card-header">
                            <h4>구매내역</h4>
                    		<div class="card-block">
	                            <div class="row">
                                    <div class="col-lg-4 col-xl-3 col-sm-6">
                                        <div class="badge-box">
                                           	결재완료 <b id="">${payedCnt}</b>건
                                        </div>
                                    </div>
                                    <div class="col-lg-4 col-xl-3 col-sm-6">
	                                    <div class="badge-box">
											배송완료 <b id="">${completedCnt}</b>건
	                                    </div>
	                                </div>
	                                <div class="col-lg-4 col-xl-3 col-sm-6">
	                                    <div class="badge-box">
                                           	배송중 <b id="">${ingCnt}</b>건
                                        </div>
	                                </div>
	                                <div class="col-lg-4 col-xl-3 col-sm-6">
	                                    <div class="badge-box">
                                           	배송준비중 <b id="">${readyCnt}</b>건
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
               		                    <form name="uploadForm" id="uploadForm" enctype="multipart/form-data" method="POST">
                           					<input type="file" id="uploadExcel" style="float:right;margin-right:22" name="uploadExcel" value="엑셀 업로드">
                            			</form>
                            		</div>
                            		
                            		<div class="col-sm-12">
                            			<button class="btn btn-warning btn-square" style="float:right;margin-left:15" id="btnExcelDown">Excel Download</button>
                            			<button class="btn btn-info btn-square" style="float:right;" id="btnExcelUp">Excel Upload</button>
                            				
                            		</div>
                            	</div>
	                        </div>
	                    </div>
                    </div>

                    <!-- 구매내역 end -->
                    <!-- 구매내역 리스트 start -->
                    <div class="card">
                        <div class="card-block table-border-style">
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
	
</script>
<c:import url="./frameSet/footer.jsp"></c:import>
</body>
</html>
