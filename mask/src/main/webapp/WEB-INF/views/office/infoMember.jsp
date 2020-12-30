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
	                            <div class="form-group row" style="display:none" id="adminDiv">
	                                <div class="col-sm-5">
	                                    <input type="text" class="form-control form-control-success" placeholder="사용자 ID : " id="searchId" name="searchId">
	                                </div>
	                                <div class="col-sm-4">
	                                	<button class="btn btn-warning btn-outline-warning" id="btnSearch"><i class="icofont icofont-warning-alt"></i>SEARCH</button>
	                                </div>
	                            </div>
	                            <div class="form-group row">
	                                <div class="col-sm-6">
	                                    <input type="text" class="form-control" readonly id="id" value="사용자 ID : ${user.id }">
	                                </div>
	                                <div class="col-sm-6">
	                                    <input type="text" class="form-control" readonly id="regDate" value="가입일 : ${user.regdate }">
	                                </div>
	                            </div>
	                            <div class="form-group row">
	                                <div class="col-sm-6">
	                                    <input type="text" class="form-control" readonly id="recommender" value="추천인 ID : ${user.recommender }">
	                                </div>
	                                <div class="col-sm-6">
	                                    <input type="text" class="form-control" readonly id="sponsor" value="후원인 ID : ${user.sponsor }">
	                                </div>
	                           </div>
	                           <div class="form-group row">
	                                <div class="col-sm-6">
	                                    <input type="text" class="form-control" readonly id="agentNm" value="가입센터 : ${user.agentNm }">
	                                </div>
	                            </div>
	                        </div>
	                    </div>
                    </div>
                    <!-- 회원중요정보 end -->
					<form id="memberForm" onSubmit="return false;">
                    <!-- 회원기타정보 start -->
                    <div class="card">
                        <div class="card-header">
                            <h4>회원기타정보</h4>
                    		<div class="card-block">
	                            <div class="form-group row">
	                                <div class="col-sm-5">
	                                    <input type="text" class="form-control" id="name" name="name" value="${user.name}">
	                                </div>
	                                <div class="col-sm-5">
	                                    <input type="text" class="form-control" id="phone" name="phone" value="${user.phone}">
	                                </div>
	                            </div>
	                            <div class="form-group row">
	                            	<div class="col-sm-6">
		                            	<button type="button" class="btn btn-primary" id="primary-popover-content" onclick="searchAddr()">우편번호검색</button>
		                            </div>
	                            </div>
	                            <div class="form-group row">
	                                <div class="col-sm-6">
	                                    <input type="text" class="form-control" placeholder="우편번호" id="zipcode" readonly="readonly" name="zipcode" value="${user.zipcode}">
	                                </div>
	                            </div>
	                            <div class="form-group row">
	                                <div class="col-sm-10">
	                                    <input type="text" class="form-control" placeholder="우편번호상주소" id="addr1" readonly="readonly" name="addr1" value="${user.addr1}">
	                                </div>
	                            </div>
	                            <div class="form-group row">
	                                <div class="col-sm-10">
	                                    <input type="text" class="form-control" placeholder="주소세부내용" id="addr2" name="addr2" value="${user.addr2}">
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
	                                    <input type="password" class="form-control" placeholder="기존비밀번호" id="oriPass" name="oriPass">
	                                </div>
	                            </div>
	                            <div class="form-group row">
	                                <div class="col-sm-10">
	                                    <input type="password" class="form-control" placeholder="변경비밀번호" id="newPass" name="pass">
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
										<label for="confirmCheck"><font color="red">개인정보보관에 대한 책임은 본인에게 있습니다.</font></label>
	                                </div>
	                            </div>
	                            <div class="form-group row">
		                            <div class="col-sm-10" style="text-align:center;">
		                            	<button class="btn btn-primary btn-square" id="btnModify">수정</button>
		                            	<button class="btn btn-primary btn-square" id="btnCancel">취소</button>
	                            	</div>
	                            </div>
	                        </div>
	                    </div>
                    </div>
                    <!-- 비밀번호변경 end -->
                    </form>
                </div>
            </div>
        </div>
        <!-- Main-body end -->
<script>
	$(document).ready(function(){
		console.log(loginUserId);
		var loginUserId = localStorage.getItem('loginId');
		if(loginUserId == "se01admin") {
			$("#adminDiv").show();
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
	
	$("#btnModify").click(function(){

		if($("#oriPass").val() == ""){
			alert("비밀번호를 입력 해주세요.");
			$("#oriPass").focus();
			return false;
		}
		if($("#newPass").val() == ""){
			alert("변경할 비밀번호를 입력 해주세요.");
			$("#newPass").focus();
			return false;
		}
		if($("#newPass").val() != $("#conPass").val()){
			alert("비밀번호를 확인 해주세요.");
			$("#conPass").focus();
			return false;
		}

		if(!$("input:checkbox[id='confirmCheck']").is(":checked")){
			alert("개인정보보관약관에 동의해주세요.");
			return false;			
		}
		
		var params = $('#memberForm').serialize(); //폼값세팅.
		$.ajax({
			url : 'updMem',
			data : params,
			dataType : 'json',
			type : 'post',
			success:function(data){
				alert(data.message);
				if(data.result == 'success'){
					$("#oriPass").val("");
					$("#newPass").val("");
					$("#conPass").val("");
				}
			}
		})
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
					alert('정보가 조회되었습니다.');
					var user = data.list[0];
					console.log(user);
					//pass 초기화
					$("#oriPass").val("");
					$("#newPass").val("");
					$("#conPass").val("");
					
					//기본 필드값 변경.
					$('#id').val('사용자 ID : '+user.id);
					$('#regDate').val('가입일 : '+user.regdate);
					$('#recommender').val('추천인  : '+user.recommender);
					$('#sponsor').val('후원인 : '+user.sponsor);
					$('#agentNm').val('가입센터 : '+user.agent);
					
					if(user.name == ""){
						$("#name").val("");
						$("#name").attr("placeHolder","이름 : ");
					}else{
						$("#name").val(user.name);	
					}

					if(user.phone == ""){
						$("#phone").val("");
						$("#phone").attr("placeHolder","전화번호 : ");
					}else{
						$("#phone").val(user.phone);	
					}

					$("#zipcode").val(user.zipcode);
					$("#addr1").val(user.addr1);
					$("#addr2").val(user.addr2);
					
				}else {
					alert("정확한 아이디를 입력하셔야 합니다.\n다중검색불가");
				}
			}
		})
	});
	
</script>
<c:import url="./frameSet/footer.jsp"></c:import>
</body>
</html>
