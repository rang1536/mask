<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
                <div class="page-body">
                    <!-- 필수항목 start -->
                    <div class="card">
                        <div class="card-header">
                            <h4>필수항목</h4>
                    		<div class="card-block">
	                            <div class="form-group row">
	                                <div class="col-sm-5">
	                                    <input type="text" class="form-control form-control-success" placeholder="사용자 ID : ">
	                                </div>
	                                <div class="col-sm-4">
	                                	<button class="btn btn-warning btn-outline-warning"><i class="icofont icofont-warning-alt"></i>중복확인</button>
	                                </div>
	                            </div>
								<div class="form-group row">
	                                <div class="col-sm-10">
	                                    <input type="password" class="form-control" placeholder="비밀번호" id="newPass">
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
	                                    <input type="text" class="form-control form-control-success" placeholder="가입센터 : ">
	                                </div>
	                                <div class="col-sm-4">
		                                <button class="btn btn-primary btn-outline-primary"><i class="icofont icofont-user-alt-3"></i>SEARCH</button>
		                            </div>
	                            </div>
	                            <div class="form-group row">
	                                <div class="col-sm-5">
	                                    <input type="text" class="form-control form-control-success" placeholder="추천인ID : ">
	                                </div>
	                                <div class="col-sm-4">
		                                <button class="btn btn-primary btn-outline-primary"><i class="icofont icofont-user-alt-3"></i>SEARCH</button>
		                            </div>
		                            <div class="col-sm-10">
	                                	<div class="text-danger" style="v-align:top;">가입이후에는 변경할 수 없습니다.</div>
	                                </div>
	                            </div>
	                            <div class="form-group row">
	                                <div class="col-sm-5">
	                                    <input type="text" class="form-control form-control-success" placeholder="후원인ID : ">
	                                </div>
	                                <div class="col-sm-5">
		                                <button class="btn btn-primary btn-outline-primary"><i class="icofont icofont-user-alt-3"></i>SEARCH</button>
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
	                                    <input type="text" class="form-control form-control-success" placeholder="이름 : ">
	                                </div>
	                            </div>
	                            <div class="form-group row">
	                                <div class="col-sm-5">
	                                    <input type="text" class="form-control form-control-success" placeholder="연락처 : ex) 010-XXXX-XXXX">
	                                </div>
	                            </div>
	                            <div class="form-group row">
	                            	<div class="col-sm-6">
		                            	<button type="button" class="btn btn-success" id="primary-popover-content" onclick="searchAddr(1)">우편번호검색</button>
		                            </div>
	                            </div>
	                            <div class="form-group row">
	                                <div class="col-sm-6">
	                                    <input type="text" class="form-control" placeholder="우편번호" id="zipcode" readonly="readonly">
	                                </div>
	                            </div>
	                            <div class="form-group row">
	                                <div class="col-sm-10">
	                                    <input type="text" class="form-control" placeholder="우편번호상주소" id="addr1" readonly="readonly">
	                                </div>
	                            </div>
	                            <div class="form-group row">
	                                <div class="col-sm-10">
	                                    <input type="text" class="form-control" placeholder="주소세부내용" id="addr2">
	                                </div>
	                            </div>
	                            <div class="form-group row">
									<div class="col-xl-4">
                                       <!-- Line Tooltip card start -->
                                       <div class="card">
                                           <div class="card-header">
                                               <h5>상품선택</h5>
                                               <div class="card-header-right">                                                             
                                                   <i class="icofont icofont-spinner-alt-5"></i>                                                        
                                               </div>
                                           </div>
                                           <div class="card-block">
                                               <input type="radio" id="goods" checked="checked"> <label for="goods">항균 마스크 20EA</label>
                                           </div>
                                       </div>
                                       <!-- Line Tooltip card end -->
                                    </div>
									<div class="col-xl-4">
                                       <!-- Line Tooltip card start -->
                                       <div class="card">
                                           <div class="card-header">
                                               <h5>결재포인트</h5>
                                               <div class="card-header-right">                                                             
                                                   <i class="icofont icofont-spinner-alt-5"></i>                                                        
                                               </div>
                                           </div>
                                           <div class="card-block">
                                               <p>사용가능포인트 : <code>100,000</code></p>
                                               <p>결재포인트 : <code>70,000</code></p>
                                               <p>----------------------------</p>
                                               <p>잔여포인트 : <code>30,000</code></p>
                                           </div>
                                       </div>
                                       <!-- Line Tooltip card end -->
                                    </div>
	                            </div>
	                            <div class="form-group row">
	                            	<div class="col-sm-6">
		                            	<button type="button" class="btn btn-success" id="primary-popover-content" onclick="searchAddr(2)">우편번호검색</button>
		                            </div>
	                            </div>
	                            <div class="form-group row">
	                                <div class="col-sm-6">
	                                    <input type="text" class="form-control" placeholder="우편번호" id="zipcode2" readonly="readonly">
	                                </div>
	                            </div>
	                            <div class="form-group row">
	                                <div class="col-sm-10">
	                                    <input type="text" class="form-control" placeholder="우편번호상주소" id="addr21" readonly="readonly">
	                                </div>
	                            </div>
	                            <div class="form-group row">
	                                <div class="col-sm-10">
	                                    <input type="text" class="form-control" placeholder="주소세부내용" id="addr22">
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
            </div>
        </div>
        <!-- Main-body end -->
<script>
	function searchAddr(n){
		new daum.Postcode({
			oncomplete: function(data){
				console.log(data);
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

	$("#cancelBtn").onclick(function(){
		history.back(-1);
	});
	
	$("#joinBtn").onclick(function(){
		
	});
	
</script>
<c:import url="./frameSet/footer.jsp"></c:import>
</body>
</html>
