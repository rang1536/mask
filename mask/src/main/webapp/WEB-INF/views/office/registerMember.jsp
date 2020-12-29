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
	                        <h5>회원등록</h5>
	                    </div>
	                </div>
	            </div>
                <!-- Page-body start -->
                <form id="memberForm" onSubmit="return false;">
                <div class="page-body">
                    <!-- 필수항목 start -->
                    <div class="card">
                        <div class="card-header">
                            <h4>필수항목</h4>
                    		<div class="card-block">
	                            <div class="form-group row">
	                                <div class="col-sm-5">
	                                    <input type="text" class="form-control form-control-success" placeholder="사용자 ID : " id="id" name="id">
	                                </div>
	                                <div class="col-sm-4">
	                                	<button class="btn btn-warning btn-outline-warning" id="dupCheckBtn"><i class="icofont icofont-warning-alt"></i>중복확인</button>
	                                </div>
	                            </div>
								<div class="form-group row">
	                                <div class="col-sm-10">
	                                    <input type="password" class="form-control" placeholder="비밀번호" id="newPass" name="pass">
	                                </div>
	                            </div>
	                            <div class="form-group has-danger row" id="conPassDiv">
	                                <div class="col-sm-10">
	                                    <input type="password" class="form-control" placeholder="비밀번호확인" id="conPass">
	                                    <div class="col-form-label" id="conMsg"></div>
	                                </div>
	                            </div>
	                            <div class="form-group row">
	                                <div class="col-sm-5">
	                                    <input type="text" class="form-control form-control-success" placeholder="가입센터 : " id="agent" readonly="readonly">
	                                    <input type="hidden" id="agentCode" name="agent">
	                                </div>
	                                <div class="col-sm-4">
		                                <button class="btn btn-primary btn-outline-primary" id="searchAgent"><i class="icofont icofont-user-alt-3"></i>SEARCH</button>
		                            </div>
	                            </div>
	                            <div class="form-group row">
	                                <div class="col-sm-5">
	                                    <input type="text" class="form-control form-control-success" placeholder="추천인ID : " id="recommender" readonly="readonly" name="recommender">
	                                </div>
	                                <div class="col-sm-4">
		                                <button class="btn btn-primary btn-outline-primary" id="searchRecommender"><i class="icofont icofont-user-alt-3"></i>SEARCH</button>
		                            </div>
		                            <div class="col-sm-10">
	                                	<div class="text-danger" style="v-align:top;">가입이후에는 변경할 수 없습니다.</div>
	                                </div>
	                            </div>
	                            <div class="form-group row">
	                                <div class="col-sm-5">
	                                    <input type="text" class="form-control form-control-success" placeholder="후원인ID : " id="sponsor" readonly="readonly" name="sponsor">
	                                </div>
	                                <div class="col-sm-5">
		                                <button class="btn btn-primary btn-outline-primary" id="searchSponsor"><i class="icofont icofont-user-alt-3"></i>SEARCH</button>
		                            </div>
		                            <div class="col-sm-10">
	                                	<div class="text-danger" style="v-align:top;">가입이후에는 변경할 수 없습니다.</div>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
                    </div>
                    <!-- 필수항목 end -->

                    <!-- 선택항목 start -->
                    <div class="card">
                        <div class="card-header">
                            <h4>선택항목</h4>
                    		<div class="card-block">
	                            <div class="form-group row">
	                                <div class="col-sm-5">
	                                    <input type="text" class="form-control form-control-success" placeholder="이름 : " id="name" name="name">
	                                </div>
	                            </div>
	                            <div class="form-group row">
	                                <div class="col-sm-5">
	                                    <input type="text" class="form-control form-control-success" placeholder="연락처 : ex) 010-XXXX-XXXX" id="phone" name="phone">
	                                </div>
	                            </div>
	                            <div class="form-group row">
	                            	<div class="col-sm-6">
		                            	<button type="button" class="btn btn-success" id="primary-popover-content" onclick="searchAddr(1)">우편번호검색</button>
		                            </div>
	                            </div>
	                            <div class="form-group row">
	                                <div class="col-sm-6">
	                                    <input type="text" class="form-control" placeholder="우편번호" id="zipcode" readonly="readonly"  name="zipcode">
	                                </div>
	                            </div>
	                            <div class="form-group row">
	                                <div class="col-sm-10">
	                                    <input type="text" class="form-control" placeholder="우편번호상주소" id="addr1" readonly="readonly" name="addr1">
	                                </div>
	                            </div>
	                            <div class="form-group row">
	                                <div class="col-sm-10">
	                                    <input type="text" class="form-control" placeholder="주소세부내용" id="addr2" name="addr2">
	                                </div>
	                            </div>
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
														<input type="radio" id="goods${status.index }" name="goods" value="${list.newPrice }" onclick="chgGoods('${list.newPrice }','${status.index }')"> <label for="goods${status.index }">${list.goodsName}</label>
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
												<input type="hidden" id="point" name="point" value="${point }"/>
												<p>사용가능포인트 : <code><fmt:formatNumber value="${point }" pattern="#,###" /></code></p>
												<p>결재포인트 : <code><span id="buyPoint"></span></code></p>
												<p>-----------------------------------------</p>
												<p>잔여포인트 : <code><span id="resultPoint"></span></code></p>
												<input type="hidden" name="buyPoint" id="hBuyPoint">
                                           </div>
                                       </div>
                                       <!-- Line Tooltip card end -->
                                    </div>
	                            </div>
	                            <div class="form-group row">
	                            	<h3>*배송지정보</h3>
	                            </div>
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
		                            <div class="col-sm-10" style="text-align:center;">
		                            	<button class="btn btn-primary btn-square" id="joinBtn">회원가입</button>
		                            	<button class="btn btn-primary btn-square" id="cancelBtn">CANCEL</button>
	                            	</div>
	                            </div>
	                        </div>
	                    </div>
                    </div>
                    <!-- 선택항목 end -->
                </div>
                </form>
            </div>
        </div>
        <!-- Main-body end -->
<script>
	
	$(document).ready(function(){

	});
	
	window.onload = function(){
		$("#goods0").prop("checked", true);
		$("#buyPoint").text(displayComma($("#goods0").val()));
		var point = "${point}";
		var resultPoint = point-$("#buyPoint").text().replace(/,/gi, "");
		$("#resultPoint").text(displayComma(resultPoint));
		$("#hBuyPoint").val($("#buyPoint").text().replace(/,/gi, ""));
		$("#goodsCode").val($("#goodsCode0").val());
		$("#goodsName").val($("#goodsName0").val());

	}
	
	function chgGoods(n,idx){
		$("#buyPoint").text(displayComma(n));
		var point = "${point}";
		var resultPoint = point-n;
		$("#resultPoint").text(displayComma(resultPoint));
		$("#hBuyPoint").val($("#buyPoint").text().replace(/,/gi, ""));
		$("#goodsCode").val($("#goodsCode"+idx).val());
		$("#goodsName").val($("#goodsName"+idx).val());
	
	}
	
	var dupCheck = false;
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


	
	
	$("#cancelBtn").click(function(){
		history.back(-1);
	});
	
	$("#joinBtn").click(function(){
		
		if($("#resultPoint").text().replace(/,/gi, "") < 0){
			alert("보유하신 포인트가 구매하시려는 상품보다 적습니다.\n충전 후 이용해 주십시요.");
			return;			
		}
		if($("#id").val() == ""){
			alert("아이디를 입력 해주세요.");
			$("#id").focus();
			return;
		}
		if(!dupCheck){
			alert("아이디 중복체크를 해주세요.");
			$("#id").focus();
			return;
		}
		if($("#newPass").val() == ""){
			alert("비밀번호를 입력 해주세요.");
			$("#newPass").focus();
			return;
		}
		if($("#newPass").val() != $("#conPass").val()){
			alert("비밀번호를 확인 해주세요.");
			$("#conPass").focus();
			return;
		}
		if($("#agent").val() == ""){
			alert("가입센터를 입력 해주세요.");
			$("#agent").focus();
			return;
		}
		if($("#recommender").val() == ""){
			alert("추천인을 입력 해주세요.");
			$("#recommender").focus();
			return;
		}
		if($("#sponsor").val() == ""){
			alert("후원인을 입력 해주세요.");
			$("#sponsor").focus();
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
		

		var params = $('#memberForm').serialize(); //폼값세팅.
		$.ajax({
			url : 'register',
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
	
	$("#dupCheckBtn").click(function(){
		if($("#id").val() == ""){
			alert("아이디를 입력 해주세요.");
			$("#id").focus();
			return;
		}
		$.ajax({
			url : 'dupIdCheck',
			data : {'id' : $("#id").val()},
			dataType : 'json',
			type : 'post',
			success:function(data){
				alert(data.message);
				if(data.result == "success"){
					dupCheck = true;
				}else {
					dupCheck = false;
				}
			}
		})
	});
	
	//이벤트 업로드 팝업이벤트
	$("#searchRecommender").click(function(){
		$('#recommenderPop').modal();
	});
	
	$("#searchSponsor").click(function(){
		$('#sponsorPop').modal();
	});
	
	$("#searchAgent").click(function(){
		$('#agentPop').modal();
	});
	
	
	
	$("#btnSearch").click(function(){

		if($("#searchId").val() == ""){
			alert("검색 아이디(이름)을 입력 해주세요.");
			$("#searchId").focus();
			return false;
		}
		
		//console.log('id : '+$("#searchId").val());
		var params = {'id' : $("#searchId").val()}
		$.ajax({
			url : 'searchMem',
			data : params,
			dataType : 'json',
			type : 'post',
			success:function(data){			
				if(data.result == 'succ'){
					alert(id+' 님 정보가 조회되었습니다.');
					
					var user = data.user;
					
					//pass 초기화
					$("#oriPass").val("");
					$("#newPass").val("");
					$("#conPass").val("");
					
					//기본 필드값 변경.
					$('#id').val('사용자 ID : '+user.id);
					$('#regDate').val('가입일 : '+user.regdate);
					$('#recommender').val('추천인  : '+user.recommender);
					$('#sponsor').val('후원인 : '+user.sponsor);
					$('#agentNm').val('가입센터 : '+user.agentNm)
					
				}
			}
		})
	});
</script>
<c:import url="./frameSet/footer.jsp"></c:import>
<c:import url="./popup/recommender.jsp"></c:import>
<c:import url="./popup/sponsor.jsp"></c:import>
<c:import url="./popup/agent.jsp"></c:import>
</body>
</html>
