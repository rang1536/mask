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
                <!-- Page-body start -->
                <div class="page-body">
                    <!-- 회원중요정보 start -->
                    <div class="card">
                        <div class="card-header">
                            <h4>회원중요정보</h4><span style="text-align:right;color:red;padding-right:20px">변경불가 항목입니다.</span>
                    		<div class="card-block">
	                            <div class="form-group row">
	                                <div class="col-sm-6">
	                                    <input type="text" class="form-control form-control-success" placeholder="사용자 ID : " disabled="disabled">
	                                </div>
	                                <div class="col-sm-6">
	                                    <input type="text" class="form-control form-control-success" placeholder="가입일 : " disabled="disabled">
	                                </div>
	                            </div>
	                            <div class="form-group row">
	                                <div class="col-sm-6">
	                                    <input type="text" class="form-control form-control-success" placeholder="추천인 ID : " disabled="disabled">
	                                </div>
	                                <div class="col-sm-6">
	                                    <input type="text" class="form-control form-control-success" placeholder="가입센터 : " disabled="disabled">
	                                </div>
	                            </div>
	                        </div>
	                    </div>
                    </div>
                    <!-- 회원중요정보 end -->

                    <!-- 회원기타정보 start -->
                    <div class="card">
                        <div class="card-header">
                            <h4>회원기타정보</h4>
                    		<div class="card-block">
	                            <div class="form-group row">
		                            <button type="button" class="btn btn-primary" id="primary-popover-content" onclick="searchAddr()">우편번호검색</button>
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
	                        </div>
	                    </div>
                    </div>
                    <!-- 회원기타정보 end -->
                    
                    <!-- 비밀번호변경 start -->
                    <div class="card">
                        <div class="card-header">
                            <h4>비밀번호변경</h4>
                    		<div class="card-block">
	                            <div class="form-group row">
	                                <div class="col-sm-6">
	                                    <input type="password" class="form-control" placeholder="기존비밀번호" id="oriPass">
	                                </div>
	                            </div>
	                            <div class="form-group row">
	                                <div class="col-sm-10">
	                                    <input type="password" class="form-control" placeholder="변경비밀번호" id="newPass">
	                                </div>
	                            </div>
	                            <div class="form-group has-danger row" id="conPassDiv">
	                                <div class="col-sm-10">
	                                    <input type="password" class="form-control" placeholder="비밀번호확인" id="conPass">
	                                    <div class="col-form-label" id="conMsg"></div>
	                                </div>
	                            </div>
	                            <div class="form-group row">
	                                <div class="col-sm-10">
										<input type="checkbox" id="confirmCheck">
										<label id="confirmCheck"><font color="red">개인정보보관에 대한 책임은 본인에게 있습니다.</font></label>
	                                </div>
	                            </div>
	                            <div class="form-group row">
		                            <div class="col-sm-10" style="text-align:center;">
		                            	<button class="btn btn-primary btn-square">수정</button>
		                            	<button class="btn btn-primary btn-square">취소</button>
	                            	</div>
	                            </div>
	                        </div>
	                    </div>
                    </div>
                    <!-- 비밀번호변경 end -->
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

	
</script>
<c:import url="./frameSet/footer.jsp"></c:import>
</body>
</html>
