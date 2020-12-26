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
                <form id="memberForm" onSubmit="return false;">
                <div class="page-body">
                    <!-- 필수항목 start -->
                    <div class="card">
                        <div class="card-header">
                            <h4>재구매</h4>
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
														<input type="radio" name="goods" id="goods${status.index }" value="${list.rePrice }" onclick="chgGoods('${list.rePrice }')">
														<label for="goods">${list.goodsName} (<fmt:formatNumber value="${list.rePrice }" pattern="#,###" />)</label>
													</div>
											</c:forEach>
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
												<input type="hidden" id="point" name="point" value="${point }"/>
												<p>사용가능포인트 : <code><fmt:formatNumber value="${point }" pattern="#,###" /></code></p>
												<p>결재포인트 : <code><span id="buyPoint"></span></code></p>
												<p>-----------------------------------------</p>
												<p>잔여포인트 : <code><span id="resultPoint"></span></code></p>
                                           </div>
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
	                                    <input type="text" class="form-control" placeholder="받는분 : " id="addr22" name="deliveryAddr2">
	                                </div>
	                                <div class="col-sm-5">
	                                    <input type="text" class="form-control" placeholder="연락처 : " id="addr22" name="deliveryAddr2">
	                                </div>
	                            </div>
								<div class="form-group row">
		                            <div class="col-sm-10" style="text-align:center;">
		                            	<button class="btn btn-primary btn-square" id="joinBtn">구매</button>
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
	}
	
	function chgGoods(n){
		$("#buyPoint").text(displayComma(n));
		var point = "${point}";
		var resultPoint = point-n;
		$("#resultPoint").text(displayComma(resultPoint));
	
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

</script>
<c:import url="./frameSet/footer.jsp"></c:import>
</body>
</html>