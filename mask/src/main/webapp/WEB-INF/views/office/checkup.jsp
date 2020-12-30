<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false" %>
<html>
<head>
	<title>SE01</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />

	<!-- Favicon icon -->
	<link rel="icon" href="resources/mask2/imagesfavicon.icog" type="image/x-icon">
	<!-- Google font-->
	<link href="https://fonts.googleapis.com/css?family=Open+Sans:400,600" rel="stylesheet">
	<!-- Required Fremwork -->
	<link rel="stylesheet" type="text/css" href="resources/mask2/css/bootstrap/css/bootstrap.min.css">
	<!-- themify-icons line icon -->
	<link rel="stylesheet" type="text/css" href="resources/mask2/icon/themify-icons/themify-icons.css">
	<!-- ico font -->
	<link rel="stylesheet" type="text/css" href="resources/mask2/icon/icofont/css/icofont.css">
	<!-- Style.css -->
	<link rel="stylesheet" type="text/css" href="resources/mask2/css/style.css">
	<link rel="stylesheet" type="text/css" href="resources/mask2/css/jquery.mCustomScrollbar.css">

	<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
	
	<script type="text/javascript" src="resources/mask2/js/jquery/jquery.min.js"></script>
	
	<script type="text/javascript" src="resources/mask2/js/jquery-ui/jquery-ui.min.js"></script>
	<script type="text/javascript" src="resources/mask2/js/popper.js/popper.min.js"></script>
	<script type="text/javascript" src="resources/mask2/js/bootstrap/js/bootstrap.min.js"></script>
	
</head>
<body>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <div id="pcoded" class="pcoded">
        <div class="pcoded-overlay-box"></div>
        <div class="pcoded-container navbar-wrapper">
			<div class="pcoded-content">
			    <div class="pcoded-inner-content">
			
			        <!-- Main-body start -->
			        <div class="main-body">
			            <div class="page-wrapper">
			                <!-- Page-body start -->
			                <div class="page-body">
								<div class="card">
									<div class="card-header">
					                    <div class="card-block">
					                        <div class="row">
					                            <div class="col-sm-12">
					                                <h2 class="title"><i class="ti-direction"> </i>점검중</h2>
					                                <p class="text-muted"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">
														매일 00:00 ~ 00:30 정기점검 시간으로 접속이 불가능 합니다.</font></font>
					                                </p>
					                                <p class="text-primary"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">
														급한 용무가 있으신 분은 본사로 전화 주시기 바랍니다.</font></font>
					                                </p>
					                                <p class="text-primary"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">
														감사합니다.</font></font>
					                                </p>
					                                <p>
					                                	<button class="btn btn-success btn-outline-success" id="btnHome"><i class="icofont icofont-check-circled"></i>Home</button>
					                                	<button class="btn btn-danger btn-outline-danger" id="btnReload"><i class="icofont icofont-eye-alt"></i>Reload</button>
					                                </p>
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
        <!-- Main-body end -->
<script>
	$("#btnHome").click(function(){
		location.href="/mask";
	});
	
	$("#btnReload").click(function(){
		window.location.reload(true);
	});
	
</script>
</body>
</html>
