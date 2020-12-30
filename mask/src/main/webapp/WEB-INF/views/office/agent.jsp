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
                    <!-- 센터목록 start -->
                    <div class="card">
                        <div class="card-header">
                            <h4>센터목록</h4>
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
                                            <th style="text-align:center;">센터코드</th>
                                            <th style="text-align:center;">센터명</th>
                                            <th style="text-align:center;">소유자(대리점)</th>
                                            <th style="text-align:center;">등록자</th>
                                            <th style="text-align:center;">등록일</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<c:forEach var="agentList" items="${agentList }">
	                                        <tr>
	                                            <td style="text-align:center;">${agentList.code }</td>
	                                            <td style="text-align:center;">${agentList.name }</td>
	                                            <td style="text-align:center;">${agentList.owner }</td>
	                                            <td style="text-align:center;">${agentList.regid }</td>
	                                            <td style="text-align:center;">${agentList.regdate }</td>
	                                        </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!-- 센터목록 end -->

                    <!-- 센터대기목록 start -->
                    <div class="card">
                        <div class="card-header">
                            <h4>승인대기목록</h4>
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
                                            <th style="text-align:center; width:60%">대리점아이디</th>
                                            <th style="text-align:center; width:20%"">추천인수</th>
                                            <th style="text-align:center; width:20%"">선택</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<c:forEach var="standByList" items="${standByList }">
	                                        <tr>
	                                            <td style="text-align:center;">${standByList.owner }</td>
	                                            <td style="text-align:center;">${standByList.recomCnt }</td>
	                                            <td style="text-align:center;"><button type="button" class="btn btn-primary btn-mini" id="primary-popover-content" onclick="chooseAgent('${standByList.owner}')">OK</button></td>
	                                        </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!-- 센터대기목록 end -->

                    <!-- 센터등록 start -->
                    <div class="card">
                        <div class="card-header">
                            <h4>센터등록</h4>
                    		<div class="card-block">
                    			<form id="centerForm" onSubmit="return false;">
                    				<div class="form-group row">
		                                <div class="col-sm-12">
		                                    <input type="text" class="form-control" placeholder="대리점" id="owner" name="owner" readonly="readonly">
		                                </div>
		                            </div>
		                            <div class="form-group row">
		                                <div class="col-sm-6">
		                                    <input type="text" class="form-control form-control-success" placeholder="센터코드 : " id="code" name="code">
		                                </div>
		                                <div class="col-sm-6">
		                                    <input type="text" class="form-control form-control-success" placeholder="센터명 : " id="name" name="name">
		                                </div>
		                            </div>

									<div class="form-group row">
										<div class="col-sm-12">
			                            	<button class="btn btn-primary btn-block" id="btnOk">OK</button>
			                            </div>
			                        </div>
	                            </form>
	                        </div>
	                    </div>
                    </div>
                    <!-- 센터등록 end -->
                </div>
            </div>
        </div>
        <!-- Main-body end -->
<script>
	$("#btnOk").click(function(){
		if($("#owner").val() == ""){
			alert("대리점을 선택 해주세요.");
			return;
		}
		
		if($("#code").val() == ""){
			alert("상품코드를 입력 해주세요.");
			$("#code").focus();
			return;
		}

		if($("#name").val() == ""){
			alert("상품명을 입력 해주세요.");
			$("#name").focus();
			return;
		}
		
		var params = $('#centerForm').serialize(); //폼값세팅.
		$.ajax({
			url : 'registerAgent',
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
	
	function chooseAgent(owner){
		$("#owner").val(owner);
	}
	
</script>
<c:import url="./frameSet/footer.jsp"></c:import>
</body>
</html>
