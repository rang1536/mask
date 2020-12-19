<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>SE01</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />

	<!-- Favicon icon -->
	<link rel="icon" href="resources/mask2/images/favicon.ico" type="image/x-icon">
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

	<!-- Required Jquery -->
	<script type="text/javascript" src="resources/mask2/js/jquery/jquery.min.js"></script>
	
	<script type="text/javascript" src="resources/mask2/js/jquery-ui/jquery-ui.min.js"></script>
	<script type="text/javascript" src="resources/mask2/js/popper.js/popper.min.js"></script>
	<script type="text/javascript" src="resources/mask2/js/bootstrap/js/bootstrap.min.js"></script>
	<!-- jquery slimscroll js -->
	<script type="text/javascript" src="resources/mask2/js/jquery-slimscroll/jquery.slimscroll.js"></script>
	<!-- modernizr js -->
	<script type="text/javascript" src="resources/mask2/js/modernizr/modernizr.js"></script>
	<!-- am chart -->
	<script src="resources/mask2/pages/widget/amchart/amcharts.min.js"></script>
	<script src="resources/mask2/pages/widget/amchart/serial.min.js"></script>
	<!-- Todo js -->
	<script type="text/javascript " src="resources/mask2/pages/todo/todo.js "></script>
	<!-- Custom js -->
	<script type="text/javascript" src="resources/mask2/pages/dashboard/custom-dashboard.js"></script>
	<script type="text/javascript" src="resources/mask2/js/script.js"></script>
	<script type="text/javascript " src="resources/mask2/js/SmoothScroll.js"></script>
	<script src="resources/mask2/js/pcoded.min.js"></script>
	<script src="resources/mask2/js/demo-12.js"></script>
	<script src="resources/mask2/js/jquery.mCustomScrollbar.concat.min.js"></script>
</head>
<body>
<%-- <c:import url="../office/frameSet/header.jsp"></c:import> --%>

<!-- Pre-loader end -->

    <section class="login p-fixed d-flex text-center bg-primary common-img-bg">
        <!-- Container-fluid starts -->
        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                    <!-- Authentication card start -->
                    <div class="login-card card-block auth-body mr-auto ml-auto">
                        <form class="md-float-material">
                            <div class="text-center">
                                <img src="resources/mask2/images/auth/logo-dark.png" alt="logo.png">
                            </div>
                            <div class="auth-box">
                                <div class="row m-b-20">
                                    <div class="col-md-12">
                                        <h3 class="text-left txt-primary">로그인</h3>
                                    </div>
                                </div>
                                <hr/>
                                <div class="input-group">
                                    <input type="text" id="id" class="form-control" placeholder="아이디">
                                    <span class="md-line"></span>
                                </div>
                                <div class="input-group">
                                    <input type="password" id="pass" class="form-control" placeholder="패스워드">
                                    <span class="md-line"></span>
                                </div>
                                <div class="row m-t-25 text-left">
                                    <div class="col-sm-7 col-xs-12">
                                        <div class="checkbox-fade fade-in-primary">
                                            <label>
                                                <input type="checkbox" id="authSaveChk" value="">
                                                <span class="cr"><i class="cr-icon icofont icofont-ui-check txt-primary"></i></span>
                                                <span class="text-inverse">ID/PASSWORD 저장하기</span>
                                            </label>
                                        </div>
                                    </div>
                                    <!-- <div class="col-sm-5 col-xs-12 forgot-phone text-right">
                                        <a href="#" class="text-right f-w-600 text-inverse"> 비밀번호찾기</a>
                                    </div> -->
                                </div>
                                <div class="row m-t-30">
                                    <div class="col-md-12">
                                        <button type="button" onclick="login()" class="btn btn-primary btn-md btn-block waves-effect text-center m-b-20">로그인</button>
                                    </div>
                                </div>
                                <hr/>
                                <div class="row">
                                    <div class="col-md-10">
                                        <p class="text-inverse text-left m-b-0">마이오피스 메뉴는 로그인 후 사용가능합니다</p>
                                        <p class="text-inverse text-left"><b>SE01</b></p>
                                    </div>
                                    <div class="col-md-2">
                                        <img src="resources/mask2/images/auth/Logo-small-bottom.png" alt="small-logo.png">
                                    </div>
                                </div>

                            </div>
                        </form>
                        <!-- end of form -->
                    </div>
                    <!-- Authentication card end -->
                </div>
                <!-- end of col-sm-12 -->
            </div>
            <!-- end of row -->
        </div>
        <!-- end of container-fluid -->
    </section>
<c:import url="../office/frameSet/footer.jsp"></c:import>

<!-- event -->
<script>
	var loginId = localStorage.getItem('loginId');
	var loginPass = localStorage.getItem('loginPass');
	
	$(document).ready(function(){
		/* 저장된 로그인 아이디 패스워드 체크  */
		if(loginId != null && loginId != ''){
			$('#id').val(loginId);
		}
		
		if(loginPass != null && loginPass != ''){
			$('#pass').val(loginPass);
		}	
		
	})
	
	/* 로그인 */
	function login(){
		var id = $('#id').val();
		var pass = $('#pass').val();
		
		if(id == null || id == ''){
			alert('아이디를 입력하세요');
			$('#id').focus();
			return;
		}
		
		if(pass == null || pass == ''){
			alert('비밀번호를 입력하세요');
			$('#pass').focus();
			return;
		}
		
		
		
		$.ajax({
			url : 'login',
			data : {'id':id, 'pass':pass},
			dataType : 'json',
			type : 'post',
			success : function(result){
				if(result == 'succ'){
					alert(id+' 님 반갑습니다.');
					
					if($('#authSaveChk').is(':Checked'){
						localStorage.setItem('loginId',id);
						localStorage.setItem('loginPass',pass);
					}
					
					location.href = 'bussiness';
				}else{
					alert('로그인에 실패하였습니다. 아이디와 비밀번호를 다시 확인해주세요');
					return;
				}
			}
		})
		
		
	}
</script>
</body>
	
</html>