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
                <form id="purchaseForm" onSubmit="return false;">
                <div class="page-body">
                    <!-- 필수항목 start -->
                    <div class="card">
                        <div class="card-header">
                            <h4>소비자구매</h4>
                    		<div class="card-block">
	                        	<div class="form-group row">
									<div class="col-xl-5">
                                       <!-- Line Tooltip card start -->
                                       <div class="card">
                                           <div class="card-header">
                                               <h5>상품선택</h5>
                                               <div class="card-header-right">                                                             
                                                   <i class="icofont icofont-spinner-alt-5"></i>                                                        
                                               </div>
                                           </div>
                                           <div class="card-block">
                                           	<c:forEach var="list" items="${list }" varStatus="status">
											   		<div class="col-sm-10">
														<input type="radio" name="goods" id="goods${status.index }" value="${list.customerPrice }" onclick="chgGoods('${list.customerPrice }','${status.index }')">
														<label for="goods${status.index }">${list.goodsName} (<fmt:formatNumber value="${list.customerPrice }" pattern="#,###" />)</label>
														<input type="hidden" id="goodsCode${status.index }" value="${list.goodsCode }">
														<input type="hidden" id="goodsName${status.index }" value="${list.goodsName }">
													</div>
											</c:forEach>
											<input type="hidden" id="goodsCode" name="goodsCode"/>
											<input type="hidden" id="goodsName" name="goodsName"/>
                                           </div>
                                       </div>
                                       <!-- Line Tooltip card end -->
                                    </div>
									<div class="col-xl-5">
                                       <!-- Line Tooltip card start -->
                                       <div class="card">
                                           <div class="card-header">
                                               <h5>결재포인트</h5>
                                               <div class="card-header-right">                                                             
                                                   <i class="icofont icofont-spinner-alt-5"></i>                                                        
                                               </div>
                                           </div>
                                           <div class="card-block">
												<p>사용가능포인트 : <code><fmt:formatNumber value="${point }" pattern="#,###" /></code></p>
												<p>결재포인트 : <code><span id="buyPoint"></span></code></p>
												<p>-----------------------------------------</p>
												<p>잔여포인트 : <code><span id="resultPoint"></span></code></p>
                                           </div>
                                           <input type="hidden" name="point" id="point">
                                           <input type="hidden" name="type" value="06">
                                       </div>
                                       <!-- Line Tooltip card end -->
                                    </div>
	                            </div>
	                            <h5>배송지정보</h5>
	                            <div class="form-group row">
	                            	<div class="col-sm-6">
		                            	<button type="button" class="btn btn-success" id="primary-popover-content" onclick="searchAddr(2)">우편번호검색</button>
		                            </div>
	                            </div>
	                            <div class="form-group row">
	                                <div class="col-sm-6">
	                                    <input type="text" class="form-control" placeholder="우편번호" id="zipcode2" readonly="readonly" name="deliveryZipcode">
	                                </div>
	                            </div>
	                            <div class="form-group row">
	                                <div class="col-sm-10">
	                                    <input type="text" class="form-control" placeholder="우편번호상주소" id="addr21" readonly="readonly" name="deliveryAddr1">
	                                </div>
	                            </div>
	                            <div class="form-group row">
	                                <div class="col-sm-10">
	                                    <input type="text" class="form-control" placeholder="주소세부내용" id="addr22" name="deliveryAddr2">
	                                </div>
	                            </div>
	                            <div class="form-group row">
	                                <div class="col-sm-5">
	                                    <input type="text" class="form-control" placeholder="받는분 : " id="receiveName" name="receiveName">
	                                </div>
	                                <div class="col-sm-5">
	                                    <input type="text" class="form-control" placeholder="연락처 : " id="receivePhone" name="receivePhone">
	                                </div>
	                            </div>
								<div class="form-group row">
		                            <div class="col-sm-10" style="text-align:center;">
		                            	<button class="btn btn-primary btn-square" id="btnOk">구매</button>
		                            	<button class="btn btn-primary btn-square" id="cancelBtn">취소</button>
	                            	</div>
	                            </div>
	                        </div>
	                    </div>
                    </div>
                    <!-- 필수항목 end -->
                </div>
                </form>
            </div>
        </div>
        <!-- Main-body end -->
<script>

	window.onload = function(){
		$("#goods0").prop("checked", true);
		$("#buyPoint").text(displayComma($("#goods0").val()));
		var point = "${point}";
		var resultPoint = point-$("#buyPoint").text().replace(/,/gi, "");
		$("#resultPoint").text(displayComma(resultPoint));
		$("#goodsCode").val($("#goodsCode0").val());
		$("#goodsName").val($("#goodsName0").val());
		$("#point").val($("#goods0").val());

	}
	
	function chgGoods(n, idx){
		$("#buyPoint").text(displayComma(n));
		var point = "${point}";
		var resultPoint = point-n;
		$("#resultPoint").text(displayComma(resultPoint));
		$("#goodsCode").val($("#goodsCode"+idx).val());
		$("#goodsName").val($("#goodsName"+idx).val());
		$("#point").val(n);

	}

	function searchAddr(n){
		new daum.Postcode({
			oncomplete: function(data){
				if(n == 1){
					$("#zipcode").val(data.zonecode);
					$("#addr1").val(data.jibunAddress);
				}else{
					$("#zipcode2").val(data.zonecode);
					$("#addr21").val(data.jibunAddress);
				}
			}
		}).open();
	}
	
	$("#btnOk").click(function(){
		if($("#resultPoint").text().replace(/,/gi, "") < 0){
			alert("보유하신 포인트가 구매하시려는 상품보다 적습니다.\n충전 후 이용해 주십시요.");
			return;			
		}
		
		if($("#zipcode2").val() == ""){
			alert("배송지정보를 입력 해주세요.");
			$("#zipcode2").focus();
			return;
		}
		if($("#addr21").val() == ""){
			alert("배송지정보를 입력 해주세요.");
			$("#addr21").focus();
			return;
		}
		if($("#addr22").val() == ""){
			alert("배송지 상세주소를 입력 해주세요.");
			$("#addr22").focus();
			return;
		}
		
		if($("#receiveName").val() == ""){
			alert("받는 분 성함을 입력 해주세요.");
			$("#receiveName").focus();
			return;
		}
		if($("#receivePhone").val() == ""){
			alert("받는 분 전화번호를 입력 해주세요.");
			$("#receivePhone").focus();
			return;
		}
		
		var params = $('#purchaseForm').serialize(); //폼값세팅.
		$.ajax({
			url : 'registerPurchase',
			data : params,
			dataType : 'json',
			type : 'post',
			success:function(data){
				alert(data.message);
				if(data.result == 'success'){
					window.location.reload(true);
				}
			}
		})
		
	});
</script>
<c:import url="./frameSet/footer.jsp"></c:import>
</body>
</html>
