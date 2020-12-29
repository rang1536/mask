<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
                    <!-- 문의하기 start -->
                    <form id="inquiryForm" onSubmit="return false">
                    <div class="card">
                        <div class="card-header">
                            <h5>포인트현황</h5>
							<div class="card-header-right">                                                             
								<i class="icofont icofont-spinner-alt-5"></i>                                                        
							</div>
                            <div class="form-group row">
								<div class="col-sm-12">
	                                <textarea rows="5" cols="5" class="form-control" placeholder="문의내용을 적어주세요" name="contents"></textarea>
	                            </div>
                            </div>

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
                    </form>
                    <!-- 문의하기  end -->
                    
                    <!-- 문의목록 start -->
                    <div class="card">
						<div class="card-block accordion-block">
	                        <div id="accordion" role="tablist" aria-multiselectable="true">
	                            <div class="accordion-panel">
	                            	<c:forEach var="list" items="${list }" varStatus="status">
		                                <div class="accordion-heading" role="tab" id="heading${status.index }">
		                                    <h3 class="card-title accordion-title">
		                                        <a class="accordion-msg scale_active collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapse${status.index }" aria-expanded="false" aria-controls="collapse${status.index }">
		                                        	[${list.regdate }][${list.status }]${fn:substring(list.contents,0,15) }<c:if test="${fn:length(list.contents)>15 }">...</c:if>
			                                    </a>
			                                </h3>
		                            	</div>
		                                <div id="collapse${status.index }" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="heading${status.index }">
			                                <div class="accordion-content accordion-desc">
			                                    <p>${list.contents }</p>
			                                    <c:choose>
			                                    	<c:when test="${list.answer == null }">
			                                    		<c:if test="${isAdmin }">
	                                    					<div class="col-sm-12">
								                                <textarea rows="5" cols="5" class="form-control" placeholder="답변내용을 적어주세요" id="answer${status.index }"></textarea>
								                                <button type="button" class="btn btn-primary btn-mini" id="primary-popover-content" onclick="registerAnser('${list.seq}','${status.index }')">답변등록</button>
								                            </div>
			                                    			
			                                    		</c:if>
			                                    	</c:when>
			                                    	<c:otherwise>
			                                    		<p><br/></p>
			                                    		<p class="text-success">답변</p>
														<p>${list.answer }</p>
			                                    	</c:otherwise>
			                                    </c:choose>
			                                </div>
		                           		</div>
		                           	</c:forEach>
                        		</div>
                            </div>
                        </div>
                    </div>
                    <!-- 문의목록 end -->
                </div>
            </div>
        </div>
        <!-- Main-body end -->
<script>
	$("#btnOk").click(function(){
		var msg = "문의사항을 등록 하시겠습니까?";
		if(confirm(msg)){
			var params = $('#inquiryForm').serialize();
			$.ajax({
				url : 'registerInquiry',
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
	});

	function registerAnser(seq, idx){
		var msg = "답변을 등록 하시겠습니까?";
		if(confirm(msg)){
			var params = {seq : seq , answer : $("#answer"+idx).val()};
			$.ajax({
				url : 'registerAnser',
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
