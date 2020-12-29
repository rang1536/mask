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
	                        <h5>포인트 출금신청</h5>
	                    </div>
		            </div>
		        </div>
				<!-- Line Tooltip card start -->
				<div class="card">
					<div class="card-header">
						<h5>출금요청안내</h5>
						<div class="card-header-right">                                                             
							<i class="icofont icofont-spinner-alt-5"></i>                                                        
						</div>
					</div>
					<div class="card-block">
						<div class="col-sm-8">
							<p>■ 출금시간은 영업일 기준 매일 10시 , 18시 진행합니다.</p>
							<p>■ 출금이 완료된 후에는 마이비즈니스에 공지합니다.</p>
							<p>■ 문의사항은 문의하기 카테고리에 내용을 주시면 답변 드리겠습니다.</p>
						</div>
					</div>
				</div>
				<!-- Line Tooltip card end -->

                <!-- Page-body start -->
                <div class="page-body">
                    <!-- 포인트현황 start -->
                    <div class="card">
                        <div class="card-header">
                            <h5>포인트현황</h5>
							<div class="card-header-right">                                                             
								<i class="icofont icofont-spinner-alt-5"></i>                                                        
							</div>
                            <div class="form-group row">
                                <div class="col-sm-5">
                                    <input type="text" class="form-control form-control-primary" readonly="readonly" value="- 보유포인트 : <fmt:formatNumber value="${point}" pattern="#,###" />p">
                                </div>
                                <div class="col-sm-5">
                                    <input type="text" class="form-control form-control-primary" readonly="readonly" value="- 사용가능포인트 : <fmt:formatNumber value="${point}" pattern="#,###" />p">
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 포인트현황 end -->
                    
                    <form id="exchForm" onSubmit="return false;">
	                    <!-- 출금요청 start -->
	                    <div class="row">
		                    <div class="col-sm-6">
								<div class="card">
			                        <div class="card-block tooltip-icon button-list">
										<div class="col-sm-10">
											<p>출금요청 포인트 <input type="text" class="form-control" id="point" name="point"></p>
											<p>수수료(10%) <input type="text" class="form-control" id="tax" readonly="readonly"></p>
											<p>지급 포인트 <input type="text" class="form-control" id="receivePoint" readonly="readonly"></p>
										</div>
			                        </div>
			                    </div>
		                    </div>
		                    <div class="col-sm-6">
			                    <div class="card">
									<div class="card-block">
										<div class="col-sm-10">
											<p>계좌정보<input type="text" class="form-control" id="bank" placeholder="은행명 : " name="bank"></p>
											<p><input type="text" class="form-control" id="account" placeholder="계좌번호 : " name="account"></p>
											<p><input type="text" class="form-control" id="owner" placeholder="예금주 : " name="owner"></p>
											<p><input type="text" class="form-control" id="money" placeholder="입금예정액 : " readonly="readonly"></p>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- 출금요청 end -->
					</form>
					<div class="row">
					    <div class="col-sm-12">
					        <div class="card">
					            <div class="card-block">
					                <div class="row">
					                    <div class="col-lg-6 col-md-12">
					                        <div class="form-group">
					                            <button class="btn btn-primary btn-block" id="btnOk">OK</button>
					                        </div>
					                    </div>
										<div class="col-lg-6 col-md-12">
					                        <div class="form-group">
					                            <button class="btn btn-primary btn-outline-primary btn-block"><i class="icofont icofont-user-alt-3"></i>CANCEL</button>
					                        </div>
					                    </div>
					                </div>
					            </div>
					        </div>
					    </div>
					</div>



                </div>
            </div>
        </div>
        <!-- Main-body end -->
<script>
	
	$(document).ready(function(){
		$("#point").on("keyup", function() {
			$(this).val($(this).val().replace(/[^0-9]/g,""));
		});
		
		$("#point").on("focusout", function() {
			var thisValue = $(this).val().replace(/[^0-9]/g,"");
			var fee = thisValue*0.1;
			$("#tax").val(displayComma(fee));
			var receive = thisValue - fee;
			$("#receivePoint").val(displayComma(receive));
			$("#money").val(displayComma(receive));
			$(this).val(displayComma(thisValue));
			
		});
	});
	
	window.onload = function(){
	}

	$("#btnOk").click(function(){

		if($("#point").val() == ""){
			alert("출금하실 포인트를 입력 해주세요.");
			$("#point").focus();
			return;
		}
		if($("#bank").val() == ""){
			alert("은행을 입력 해주세요.");
			$("#bank").focus();
			return;
		}
		if($("#account").val() == ""){
			alert("계좌번호를 입력 해주세요.");
			$("#account").focus();
			return;
		}
		if($("#owner").val() == ""){
			alert("예금주를 입력 해주세요.");
			$("#owner").focus();
			return;
		}
		

		if(Number($("#point").val().replace(/[^0-9]/g,"")) > Number("${point}")){
			alert("출금하실 포인트가 보유하신 포인트보다 많습니다.\n보유하신 포인트를 확인 해주세요.");
			$("#point").focus();
			return;
		}

		var params = $('#exchForm').serialize(); //폼값세팅.
		$.ajax({
			url : 'exchange',
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
