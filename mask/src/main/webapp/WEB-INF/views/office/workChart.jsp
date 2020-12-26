<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>SE01</title>
	<style>
		.chartBox{
			width:100%;border:1px solid #ddd;height:500px;
		}
	</style>
	
</head>
<body>
<c:import url="./frameSet/header.jsp"></c:import>

<div id="pcoded" class="pcoded">
<div class="pcoded-overlay-box"></div>
<div class="pcoded-container navbar-wrapper">
<div class="pcoded-main-container">
<div class="pcoded-wrapper">
<div class="pcoded-content">
<div class="pcoded-inner-content">

<!-- Main-body start -->
<div class="main-body">
<div class="page-wrapper">
<!-- Page-header start -->
<div class="row">
<div class="col-sm-12">
	<!-- Tab variant tab card start -->
	<div class="card">
		<div class="card-header">
			<h5>조직도</h5>
			<div class="card-header-right"> 
				<!-- 상단 히든메뉴 -->   
				<ul class="list-unstyled card-option">        
					<li><i class="icofont icofont-simple-left "></i></li>        
					<li><i class="icofont icofont-maximize full-card"></i></li>        
					<li><i class="icofont icofont-minus minimize-card"></i></li>        
					<li><i class="icofont icofont-refresh reload-card"></i></li>        
					<li><i class="icofont icofont-error close-card"></i></li>    
				</ul>
			</div>
		</div>
		
		<div class="card-block tab-icon">
			<!-- Row start -->
			<div class="row">
				<div class="col-lg-12 col-xl-6">
				<!-- <h6 class="sub-title">Tab With Icon</h6>  -->
					<!-- <div class="sub-title">Tab With Icon</div> -->
					<!-- Nav tabs -->
					<ul class="nav nav-tabs md-tabs " role="tablist">
						<li class="nav-item">
							<a class="nav-link active" data-toggle="tab" href="#home7" role="tab"><i class="icofont icofont-home"></i>후원조직도</a>
							<div class="slide"></div>
						</li>
						<li class="nav-item">
							<a class="nav-link" data-toggle="tab" href="#profile7" role="tab"><i class="icofont icofont-ui-user "></i>추천조직도</a>
							<div class="slide"></div>
						</li>
					</ul>
					
					<!-- Tab panes -->
					<div class="tab-content card-block">
						<div class="tab-pane active" id="home7" role="tabpanel">
							<p class="m-0">
								<input type="number" id="sponsorMaxLoop" name="sponsorMaxLoop" min="0" placeholder="검색레벨"/>
								<input type="email" id="baseIdSponsor" name="baseIdSponsor" placeholder="기준 ID" value=""/>
								<button type="button" id="sponsorSearchBtn">조회</button>
							</p>
							<br/>
							
							<!-- 1.후원조직도 -->
							<div class="chartBox">
								<iframe src="zoomTest"></iframe> 
								
							</div>
						</div>
						<div class="tab-pane" id="profile7" role="tabpanel">
							<p class="m-0">
								<input type="number" id="recommenderMaxLoop" name="sponsorMaxLoop" min="0" placeholder="검색레벨"/>
								<input type="email" id="baseIdRecommender" name="baseIdSponsor" placeholder="기준 ID" value=""/>
								<button type="button" id="recommenderSearchBtn">조회</button>
							</p>
							<br/>
							
							<!-- 2. 추천조직도 -->
							<div class="chartBox">
							
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
</div>
</div>
</div>
</div>
</div>
</div>
</div>


<script>

	// 후원조직도 조회
	$('#sponsorSearchBtn').click(function(){
		var maxLoop = $('#sponsorMaxLoop').val();
		var id = $('#baseIdSponsor').val();
		
		if(maxLoop == null || maxLoop == ''){
			maxLoop = 0;
		}
		
		if(id == null || id == ''){
			alert('기준 ID를 입력하세요');
			$('#baseIdSponsor').focus();
			return;
		}
		
		$.ajax({
			url : 'getSponsorTree',
			data : {'id':id, 'maxLoop':maxLoop},
			dataType : 'json',
			type : 'post',
			success : function(data){
				var html = '';
				
			}
		
		})
	})
	
	// 후원조직도 조회
	$('#recommenderSearchBtn').click(function(){
		
	})
</script>
                                        

</body>
<c:import url="./frameSet/sponsorChart.jsp"></c:import>
<c:import url="./frameSet/footer.jsp"></c:import>
</html>