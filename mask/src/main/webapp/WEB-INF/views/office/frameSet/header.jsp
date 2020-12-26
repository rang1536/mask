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
    <!-- Pre-loader start -->
    <div class="theme-loader">
        <div class="ball-scale">
            <div class='contain'>
                <div class="ring">
                    <div class="frame"></div>
                </div>
                <div class="ring">
                    <div class="frame"></div>
                </div>
                <div class="ring">

                    <div class="frame"></div>
                </div>
                <div class="ring">
                    <div class="frame"></div>
                </div>
                <div class="ring">
                    <div class="frame"></div>
                </div>
                <div class="ring">
                    <div class="frame"></div>
                </div>
                <div class="ring">
                    <div class="frame"></div>
                </div>
                <div class="ring">
                    <div class="frame"></div>
                </div>
                <div class="ring">
                    <div class="frame"></div>
                </div>
                <div class="ring">
                    <div class="frame"></div>
                </div>
            </div>
        </div>
    </div>
    <!-- Pre-loader end -->
    <div id="pcoded" class="pcoded">
        <div class="pcoded-overlay-box"></div>
        <div class="pcoded-container navbar-wrapper">

            <nav class="navbar header-navbar pcoded-header">
                <div class="navbar-wrapper">

                    <div class="navbar-logo">
                        <a class="mobile-menu" id="mobile-collapse" href="#!">
                            <i class="ti-menu"></i>
                        </a>
                        <a class="mobile-search morphsearch-search" href="#">
                            <i class="ti-search"></i>
                        </a>
                        <a href="index.html">
                            <img class="img-fluid" src="resources/mask2/images/logo.png" alt="Theme-Logo" />
                        </a>
                        <a class="mobile-options">
                            <i class="ti-more"></i>
                        </a>
                    </div>

                    <div class="navbar-container container-fluid">
                        <ul class="nav-left">
                            <li>
                                <div class="sidebar_toggle"><a href="javascript:void(0)"><i class="ti-menu"></i></a></div>
                            </li>

                            <li>
                                <a href="#!" onclick="javascript:toggleFullScreen()">
                                    <i class="ti-fullscreen"></i>
                                </a>
                            </li>
                        </ul>
                        <ul class="nav-right">
                            <li class="header-notification">
                            <!-- 
                                <a href="#!">
                                    <i class="ti-bell"></i>
                                    <span class="badge bg-c-pink"></span>
                                </a>
                                <ul class="show-notification">
                                    <li>
                                        <h6>Notifications</h6>
                                        <label class="label label-danger">New</label>
                                    </li>
                                    <li>
                                        <div class="media">
                                            <img class="d-flex align-self-center img-radius" src="resources/mask2/images/avatar-4.jpg" alt="Generic placeholder image">
                                            <div class="media-body">
                                                <h5 class="notification-user">John Doe</h5>
                                                <p class="notification-msg">Lorem ipsum dolor sit amet, consectetuer elit.</p>
                                                <span class="notification-time">30 minutes ago</span>
                                            </div>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="media">
                                            <img class="d-flex align-self-center img-radius" src="resources/mask2/images/avatar-3.jpg" alt="Generic placeholder image">
                                            <div class="media-body">
                                                <h5 class="notification-user">Joseph William</h5>
                                                <p class="notification-msg">Lorem ipsum dolor sit amet, consectetuer elit.</p>
                                                <span class="notification-time">30 minutes ago</span>
                                            </div>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="media">
                                            <img class="d-flex align-self-center img-radius" src="resources/mask2/images/avatar-4.jpg" alt="Generic placeholder image">
                                            <div class="media-body">
                                                <h5 class="notification-user">Sara Soudein</h5>
                                                <p class="notification-msg">Lorem ipsum dolor sit amet, consectetuer elit.</p>
                                                <span class="notification-time">30 minutes ago</span>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </li>
 -->
                            <li class="user-profile header-notification">
                                <a href="#!">
                                    <!-- <img src="resources/mask2/images/avatar-4.jpg" class="img-radius" alt="User-Profile-Image"> -->
                                    <span id="userId"></span>
                                    <i class="ti-angle-down"></i>
                                </a>
                                <ul class="show-notification profile-notification">
<!--                                     <li>
                                        <a href="#!">
                                            <i class="ti-settings"></i> Settings
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <i class="ti-user"></i> Profile
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <i class="ti-email"></i> My Messages
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <i class="ti-lock"></i> Lock Screen
                                        </a>
                                    </li> -->
                                    <li>
                                        <a href="auth-normal-sign-in.html">
                                            <i class="ti-layout-sidebar-left"></i> Logout
                                        </a>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>

            <div class="pcoded-main-container">
                <div class="pcoded-wrapper">
                    <nav class="pcoded-navbar">
                        <div class="sidebar_toggle"><a href="#"><i class="icon-close icons"></i></a></div>
                        <div class="pcoded-inner-navbar main-menu">
                            <div class="">
                                <div class="main-menu-header">
                                    <div class="user-details" id="userName"></div>님 환영합니다.
                                    
                                </div>
<!-- 
                                <div class="main-menu-content">
                                    <ul>
                                        <li class="more-details">
                                            <a href="#"><i class="ti-user"></i>View Profile</a>
                                            <a href="#!"><i class="ti-settings"></i>Settings</a>
                                            <a href="auth-normal-sign-in.html"><i class="ti-layout-sidebar-left"></i>Logout</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div class="pcoded-search">
                                <span class="searchbar-toggle">  </span>
                                <div class="pcoded-search-box ">
                                    <input type="text" placeholder="Search">
                                    <span class="search-icon"><i class="ti-search" aria-hidden="true"></i></span>
                                </div>
                            </div>
 -->
                            <ul class="pcoded-item pcoded-left-item">
                                <li class="active" id="menu1">
                                    <a href="#" onClick="selectMenu(1)">
                                        <span class="pcoded-micon"><i class="ti-home"></i></span>
                                        <span class="pcoded-mtext" data-i18n="nav.dash.main">마이비즈니스</span>
                                        <span class="pcoded-mcaret"></span>
                                    </a>
                                </li>
                                <li class=" " id="menu2">
                                    <a href="#" onClick="selectMenu(2)">
                                        <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                        <span class="pcoded-mtext"  data-i18n="nav.basic-components.main">회원정보</span>
                                        <span class="pcoded-mcaret"></span>
                                    </a>

                                <li class=" " id="menu3">
                                    <a href="#" onClick="selectMenu(3)">
                                        <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                        <span class="pcoded-mtext" data-i18n="nav.basic-components.alert">구매내역</span>
                                        <span class="pcoded-mcaret"></span>
                                    </a>
                                </li>
                                <li class=" " id="menu4">
                                    <a href="#" onClick="selectMenu(4)">
                                        <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                        <span class="pcoded-mtext" data-i18n="nav.basic-components.alert">회원등록</span>
                                        <span class="pcoded-mcaret"></span>
                                    </a>
                                </li>
                                <li class=" " id="menu5">
                                    <a href="#" onClick="selectMenu(5)">
                                        <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                        <span class="pcoded-mtext" data-i18n="nav.basic-components.breadcrumbs">재구매</span>
                                        <span class="pcoded-mcaret"></span>
                                    </a>
                                </li>
                                <li class=" " id="menu6">
                                    <a href="#" onClick="selectMenu(6)">
                                        <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                        <span class="pcoded-mtext" data-i18n="nav.basic-components.alert">소비자구매</span>
                                        <span class="pcoded-mcaret"></span>
                                    </a>
                                </li>
                                <li class=" " id="menu7">
                                    <a href="#" onClick="selectMenu(7)">
                                        <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                        <span class="pcoded-mtext" data-i18n="nav.basic-components.breadcrumbs">조직도</span>
                                        <span class="pcoded-mcaret"></span>
                                    </a>
                                </li>
                                <li class=" " id="menu8">
                                    <a href="#" onClick="selectMenu(8)">
                                        <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                        <span class="pcoded-mtext" data-i18n="nav.basic-components.alert">포인트내역</span>
                                        <span class="pcoded-mcaret"></span>
                                    </a>
                                </li>
                                <li class=" " id="menu9">
                                    <a href="#" onClick="selectMenu(9)">
                                        <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                        <span class="pcoded-mtext" data-i18n="nav.basic-components.breadcrumbs">포인트출금</span>
                                        <span class="pcoded-mcaret"></span>
                                    </a>
                                </li>
                                <li class=" " id="menu10">
                                    <a href="#" onClick="selectMenu(10)">
                                        <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                        <span class="pcoded-mtext" data-i18n="nav.basic-components.alert">포인트충전</span>
                                        <span class="pcoded-mcaret"></span>
                                    </a>
                                </li>
                                <li class=" " id="menu11">
                                    <a href="#" onClick="selectMenu(11)">
                                        <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                        <span class="pcoded-mtext" data-i18n="nav.basic-components.breadcrumbs">문의하기</span>
                                        <span class="pcoded-mcaret"></span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </nav>
	<script>
		$(document).ready(function(){
			for(var i=1; i<12; i++){
				$("#menu"+i).removeClass();
			}
			var path = $(location).attr("pathname");

			if(path.indexOf("business") != -1){
				$("#menu1").addClass("active");
			}else if(path.indexOf("infoMem") != -1){
				$("#menu2").addClass("active");
			}else if(path.indexOf("purchase") != -1){
				$("#menu3").addClass("active");
			}else if(path.indexOf("regiMem") != -1){
				$("#menu4").addClass("active");
			}else if(path.indexOf("rePurchase") != -1){
				$("#menu5").addClass("active");
			}
			
			$("#userId").text(localStorage.getItem('loginId'));
			$("#userName").text(localStorage.getItem('loginId'));
			
		});
		
		function selectMenu(menu){
			if(menu == 1){
				location.href = "business";
			}else if(menu == 2){
				location.href = "infoMem";
			}else if(menu == 3){
				location.href = "purchase";
			}else if(menu == 4){
				location.href = "regiMem";
			}else if(menu == 5){
				location.href = "rePurchase";
			}else if(menu == 6){
				
			}else if(menu == 7){
				location.href = 'workChart';
			}else if(menu == 8){
				
			}else if(menu == 9){
				
			}else if(menu == 10){
				
			}else if(menu == 11){
							
			}
		}
	</script>

	<script>
	var $window = $(window);
	var nav = $('.fixed-button');
	    $window.scroll(function(){
	        if ($window.scrollTop() >= 200) {
	         nav.addClass('active');
	     }
	     else {
	         nav.removeClass('active');
	     }
	 });
	    
	    
	</script>
</body>
</html>
