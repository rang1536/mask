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
                <div class="page-body">
                    <!-- 포인트충전신청목록 start -->
                    <div class="card">
                        <div class="card-header">
                            <h4>포인트충전신청목록</h4>
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
                                            <th style="text-align:center;">아이디</th>
                                            <th style="text-align:center;">포인트</th>
                                            <th style="text-align:center;">전화번호</th>
                                            <th style="text-align:center;">상태</th>
                                            <th style="text-align:center;">등록일</th>
                                            <th style="text-align:center;">승인</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<c:forEach var="list" items="${list }">
	                                        <tr>
	                                            <td style="text-align:center;">${list.id }</td>
	                                            <td style="text-align:center;"><fmt:formatNumber value="${list.point }" pattern="#,###" /></td>
	                                            <td style="text-align:center;">${list.phone }</td>
	                                            <td style="text-align:center;">${list.status }</td>
	                                            <td style="text-align:center;">${list.regdate }</td>
	                                            <td style="text-align:center;">
		                                            <c:if test = "${list.status == '대기'}">
	                                            		<button type="button" class="btn btn-primary btn-mini" id="primary-popover-content" onclick="approve('${list.seq}')">OK</button>
		                                            </c:if>
	                                            </td>
	                                        </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!-- 포인트충전신청목록 end -->
                </div>
            </div>
        </div>
        <!-- Main-body end -->
<script>
	function approve(seq){
		var msg = "해당 신청을 승인하시겠습니까?";
		console.log(seq);
		if(confirm(msg)){
			var params = {'seq' : seq};
			$.ajax({
				url : 'approveCharge',
				data : params,
				dataType : 'json',
				type : 'post',
				success:function(data){
					alert(data.message);
					if(data.result == 'success'){
						window.location.reload(true);
					}
				}
			});
		}
	}

</script>
<c:import url="./frameSet/footer.jsp"></c:import>
</body>
</html>
