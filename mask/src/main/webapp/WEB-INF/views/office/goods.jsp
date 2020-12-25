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
	                        <h5>상품관리</h5>
	                    </div>
	                </div>
	            </div>
                <!-- Page-body start -->
                <div class="page-body">
                    <!-- 상품관리 start -->
                    <div class="card">
                        <div class="card-header">
                            <h4>상품목록</h4>
                            <div class="card-header-right">
                                <ul class="list-unstyled card-option">
                                    <li><i class="icofont icofont-minus minimize-card"></i></li>
                                </ul>
                            </div>
                        </div>
                        <div class="card-block table-border-style">
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th style="text-align:center;">상품코드</th>
                                            <th style="text-align:center;">상품명</th>
                                            <th style="text-align:center;">신규가입가</th>
                                            <th style="text-align:center;">재구매가</th>
                                            <th style="text-align:center;">소비자구매가</th>
                                            <th style="text-align:center;">회원가입상품</th>
                                            <th style="text-align:center;">등록자</th>
                                            <th style="text-align:center;">등록일</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<c:forEach var="list" items="${list }">
	                                        <tr>
	                                            <td style="text-align:center;">${list.goodsCode }</td>
	                                            <td style="text-align:center;">${list.goodsName }</td>
	                                            <td style="text-align:center;"><fmt:formatNumber value="${list.newPrice }" pattern="#,###" /></td>
	                                            <td style="text-align:center;"><fmt:formatNumber value="${list.rePrice }" pattern="#,###" /></td>
	                                            <td style="text-align:center;"><fmt:formatNumber value="${list.customerPrice }" pattern="#,###" /></td>
	                                            <td style="text-align:center;">${list.newPriceYn }</td>
	                                            <td style="text-align:center;">${list.regid }</td>
	                                            <td style="text-align:center;">${list.regdate }</td>
	                                        </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!-- 상품관리 end -->

                    <!-- 상품등록 start -->
                    <div class="card">
                        <div class="card-header">
                            <h4>상품등록</h4>
                    		<div class="card-block">
                    			<form id="goodsForm" onSubmit="return false;">
		                            <div class="form-group row">
		                                <div class="col-sm-5">
		                                    <input type="text" class="form-control form-control-success" placeholder="상품코드 : " id="goodsCode" name="goodsCode">
		                                </div>
		                                <div class="col-sm-5">
		                                    <input type="text" class="form-control form-control-success" placeholder="상품명 : " id="goodsName" name="goodsName">
		                                </div>
		                            </div>
		                            <div class="form-group row">
		                                <div class="col-sm-5">
		                                    <input type="Number" class="form-control" placeholder="신규회원가" id="newPrice" name="newPrice">
		                                </div>
		                                <div class="col-sm-5">
		                                    <input type="checkbox" id="newPriceYnCheck">
		                                    <label for="newPriceYnCheck">신규회원가입 사용여부</label>
		                                    <input type="hidden" id="newPriceYn" name="newPriceYn">
		                                </div>
		                            </div>
		                            <div class="form-group row">
		                                <div class="col-sm-5">
		                                    <input type="Number" class="form-control" placeholder="재구매가" id="rePrice" name="rePrice">
		                                </div>
		                                <div class="col-sm-5">
		                                    <input type="Number" class="form-control" placeholder="소비자구매가" id="customerPrice" name="customerPrice">
		                                </div>
		                            </div>
		                            <div class="form-group row">
			                            <div class="col-sm-10" style="text-align:center;">
			                            	<button class="btn btn-primary btn-square" id="registerBtn">등록</button>
		                            	</div>
		                            </div>
	                            </form>
	                        </div>
	                    </div>
                    </div>
                    <!-- 상품등록 end -->
                </div>
            </div>
        </div>
        <!-- Main-body end -->
<script>
	$("#registerBtn").click(function(){
		if($("#goodsCode").val() == ""){
			alert("상품코드를 입력 해주세요.");
			$("#goodsCode").focus();
			return;
		}

		if($("#goodsName").val() == ""){
			alert("상품명을 입력 해주세요.");
			$("#goodsName").focus();
			return;
		}
		
		if($("#newPriceYnCheck").is(":checked")){
			$("#newPriceYn").val("Y");
		}else {
			$("#newPriceYn").val("N");
		}
		
		var params = $('#goodsForm').serialize(); //폼값세팅.
		$.ajax({
			url : 'registerGoods',
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
	
</script>
<c:import url="./frameSet/footer.jsp"></c:import>
<c:import url="./popup/recommender.jsp"></c:import>
<c:import url="./popup/sponsor.jsp"></c:import>
<c:import url="./popup/agent.jsp"></c:import>
</body>
</html>
