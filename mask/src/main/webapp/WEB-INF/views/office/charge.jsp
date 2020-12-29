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
				<!-- Line Tooltip card start -->
				<div class="card">
					<div class="card-header">
	           			<div class="card-block">
	                        <h4>▶ 포인트 충전신청</h4>
	                    </div>
						<div class="card-block">
							<h5>충전요청안내</h5>
						</div>
					</div>
					<div class="card-block">
						<div class="col-sm-12">
							<p>■ 충전요청시간 : 영업일 10시 ~ 23시</p>
							<p>■ 입금자는 충전할 아이디를 적어주시면 업무에 효율성이 생깁니다.</p>
							<p>■ 충전된 포인트는 환불 불가입니다.</p>
							<p>■ 문의사항은 문의하기를 이용해주세요.</p>
						</div>
					</div>
				</div>
				<!-- Line Tooltip card end -->

                <!-- Page-body start -->
                <div class="page-body">
                    <!-- 포인트충전신청 start -->
                    <div class="card">
                        <div class="card-header">
							<div class="card-header-right">                                                             
								<i class="icofont icofont-spinner-alt-5"></i>                                                        
							</div>
                            <div class="form-group row">
                                <div class="col-sm-5">
                                    <input type="text" class="form-control form-control-primary" placeHolder="충전 요청 포인트 " id="chargePoint" name="chargePoint">
                                </div>
                                <div class="col-sm-5" style="vertical-align:bottom;">
                                    <p class="text-danger">*30,000p 부터 출금 가능</p>
                                </div>
                            </div>

                            <div class="form-group row">
                                <div class="col-sm-5">
                                    <input type="text" class="form-control form-control-primary" placeHolder="입금자 " id="chargeId" name="chargeId">
                                </div>
                                <div class="col-sm-5">
                                    <p class="text-danger">ID를 적어주세요</p>
                                </div>
                            </div>

                            <div class="form-group row">
                                <div class="col-sm-5">
                                    <input type="text" class="form-control form-control-primary" placeHolder="연락처" id="phone" name="phone">
                                </div>
                                <div class="col-sm-5">
                                    <p class="text-danger">충전 후 문자 발송해 드립니다.</p>
                                </div>
                            </div>

							<div class="form-group row">
                                <div class="col-sm-10">
                                   	<button class="btn btn-warning waves-effect" style="margin-bottom:5" data-type="warning" data-from="top" data-align="right">입금계좌정보</button>
                                </div>
                                <div class="col-sm-10">
                                	<div class="form-group">
                                    <input type="text" class="form-control form-control-primary" value="기업은행 304-097515-01-010 예금주 : (주)에스이제로원" readonly = "readonly">
                                    </div>
                                </div>
                                <div class="col-sm-10">
                                    <p class="text-danger">입금자는 충전할 아이디를 적어 주시면 업무에 효율성이 생깁니다.</p>
                                </div>
                            </div>
                        </div>
						<div class="card-block">
			                <div class="row">
			                    <div class="col-lg-5 col-md-10">
			                        <div class="form-group">
			                            <button class="btn btn-primary btn-block" id="chargeOkBtn">OK</button>
			                        </div>
			                    </div>
			                    <div class="col-lg-5 col-md-10">
			                    	<div class="form-group">
										<button class="btn btn-primary btn-outline-primary btn-block" id="chargeCancelBtn"><i class="icofont icofont-user-alt-3"></i>CANCEL</button>
									</div>
			                    </div>
			                </div>
			            </div>
                    </div>
                    <!-- 포인트충전신청 end -->

                    <!-- 포인트송금 start -->
                    <div class="card">
                        <div class="card-header">
                   			<div class="card-block">
		                        <h4>▶ 포인트 송금하기</h4>
		                    </div>
							<div class="card-header-right">                                                             
								<i class="icofont icofont-spinner-alt-5"></i>                                                        
							</div>
                            <div class="form-group row">
                                <div class="col-sm-10">
                                    <input type="text" class="form-control form-control-primary" placeHolder="송금 요청 포인트 " id="transPoint" name="transPoint">
                                </div>
                            </div>

                            <div class="form-group row">
                                <div class="col-sm-10">
                                    <input type="text" class="form-control form-control-primary" placeHolder="받는 분 ID " id="toId" name="toId">
                                </div>
                            </div>

                            <div class="form-group row">
                                <div class="col-sm-10">
                                    <input type="text" class="form-control form-control-primary" placeHolder="비밀번호" id="pass" name="pass">
                                </div>
                            </div>

							<div class="form-group row">
                                <div class="col-sm-10">
                                	<div class="form-group">
	                                    <input type="checkbox" id="chk1"><label for="chk1" style="margin-left:5" class="text-danger"> 위 같이 받는분에게 송금을 요청합니다.</label><br/>
                                    	<input type="checkbox" id="chk2"><label for="chk2" style="margin-left:5" class="text-danger"> 송금된 포인트는 환불이 불가합니다.</label>
                                    </div>
                                </div>
                            </div>
                        </div>
						<div class="card-block">
			                <div class="row">
			                    <div class="col-lg-5 col-md-10">
			                        <div class="form-group">
			                            <button class="btn btn-primary btn-block" id="transOkBtn">OK</button>
			                        </div>
			                    </div>
			                    <div class="col-lg-5 col-md-10">
			                    	<div class="form-group">
										<button class="btn btn-primary btn-outline-primary btn-block" id="transCancelBtn"><i class="icofont icofont-user-alt-3"></i>CANCEL</button>
									</div>
			                    </div>
			                </div>
			            </div>
                    </div>
                    <!-- 포인트송금 end -->
                </div>
            </div>
        </div>
        <!-- Main-body end -->
<script>
	
	$(document).ready(function(){
		$("#chargePoint").on("keyup", function() {
			$(this).val($(this).val().replace(/[^0-9]/g,""));
		});
		
		$("#chargePoint").on("focusout", function() {
			var thisValue = $(this).val().replace(/[^0-9]/g,"");
			$(this).val(displayComma(thisValue));
		});
		
		$("#transPoint").on("keyup", function() {
			$(this).val($(this).val().replace(/[^0-9]/g,""));
		});
		
		$("#transPoint").on("focusout", function() {
			var thisValue = $(this).val().replace(/[^0-9]/g,"");
			$(this).val(displayComma(thisValue));
		});
	});
	
	window.onload = function(){
	}

	$("#chargeOkBtn").click(function(){

		if($("#chargePoint").val() == ""){
			alert("충전하실 포인트를 입력 해주세요.");
			$("#chargePoint").focus();
			return;
		}

		var params = {
				'id' : $("#chargeId").val(),
				'point' : $("#chargePoint").val(),
				'phone' : $("#phone").val(),
				'status' : "01"
		}
		
		$.ajax({
			url : 'charge',
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

	$("#transOkBtn").click(function(){

		if($("#transPoint").val() == ""){
			alert("송금하실 포인트를 입력 해주세요.");
			$("#transPoint").focus();
			return;
		}
		
		if($("#toId").val() == ""){
			alert("송금하실 ID를 입력 해주세요.");
			$("#toId").focus();
			return;
		}
		
		if($("#pass").val() == ""){
			alert("비밀번호를 입력 해주세요.");
			$("#pass").focus();
			return;
		}
		
		if(!$("#chk1").is(":checked")){
			alert("처음 약관에 동의해주세요.");
			return;
		}
		if(!$("#chk2").is(":checked")){
			alert("마지막 약관에 동의해주세요.");
			return;
		}

		var params = {
				'toId' : $("#toId").val(),
				'point' : $("#transPoint").val(),
		}
		
		$.ajax({
			url : 'trans',
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
