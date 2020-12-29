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

<div class="pcoded-content">
    <div class="pcoded-inner-content">

        <!-- Main-body start -->
        <div class="main-body">
            <div class="page-wrapper">
                <!-- Page-body start -->
                <div class="page-body">
                    <!-- 공지사항 start -->
                    <div class="card">
                        <div class="card-header">
                            <h4>공지사항</h4>
                            <div class="card-header-right">
                                <ul class="list-unstyled card-option">
                                <!-- 
                                    <li><i class="icofont icofont-simple-left "></i></li>
                                    <li><i class="icofont icofont-maximize full-card"></i></li>
                                    <li><i class="icofont icofont-refresh reload-card"></i></li>
                                    <li><i class="icofont icofont-error close-card"></i></li>
                                 -->
                                    <li><i class="icofont icofont-minus minimize-card"></i></li>
                                </ul>
                            </div>
                        </div>
                        <div class="card-block table-border-style">
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th style="text-align:center;">제목</th>
                                            <th style="text-align:center;">일자</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<c:forEach var="list" items="${noticeList }">
                                        <tr>
                                            <td scope="row">${list.title }</td>
                                            <td style="text-align:center;">${list.regDate }</td>
                                        </tr>
                                       	</c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!-- 공지사항 end -->

                    <!-- 대리점 유효기간 start -->
                    <div class="card">
                        <div class="card-header">
                            <h4>대리점 유효기간</h4>
                    		<div class="card-block">
	                            <div class="form-group row">
	                                <div class="col-sm-10">
	                                    <input type="text" class="form-control" readonly="readonly" value="${user.expiredate }">
	                                </div>
	                            </div>
	                        </div>
	                    </div>
                    </div>
                    <!-- 대리점 유효기간 end -->

                    <!-- 포인트 현황 start -->
                    <div class="card">
                        <div class="card-header">
                            <h4>포인트 현황</h4>
                    		<div class="card-block">
	                            <div class="form-group row">
	                                <div class="col-sm-10">
	                                	<div class="form-group row">
                                            <div class="col-sm-6">
                                                <input type="text" class="form-control" id="hasPoint" value="- 보유포인트 : <fmt:formatNumber value="${user.point}" pattern="#,###" />p" readonly="readonly">
                                            </div>
                                            <div class="col-sm-6">
                                                <input type="text" class="form-control" id="usePoint" value="- 사용가능 포인트 : <fmt:formatNumber value="${user.point}" pattern="#,###" />p" readonly="readonly">
                                            </div>
                                        </div>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
                    </div>
                    <!-- 포인트 현황 end -->

                    <!-- 영업 현황 start -->
                    <div class="card">
                        <div class="card-header">
                            <h4>영업 현황</h4>
                            <div class="card-header-right">
                                <ul class="list-unstyled card-option">
                                <!-- 
                                    <li><i class="icofont icofont-simple-left "></i></li>
                                    <li><i class="icofont icofont-maximize full-card"></i></li>
                                    <li><i class="icofont icofont-refresh reload-card"></i></li>
                                    <li><i class="icofont icofont-error close-card"></i></li>
                                 -->
                                    <li><i class="icofont icofont-minus minimize-card"></i></li>
                                </ul>
                            </div>
                        </div>
                        <div class="card-block table-border-style">
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                        	<th></th>
                                            <th style="text-align:center;">구분</th>
                                            <th style="text-align:center;">A</th>
                                            <th style="text-align:center;">B</th>
                                            <th style="text-align:center;">구분</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                        	<th style="text-align:center;" rowspan="2">신<br/>규</th>
                                            <th style="text-align:center;" scope="row">기준ID</th>
                                            <td style="text-align:center;">${aSpon }</td>
                                            <td style="text-align:center;">${bSpon }</td>
                                            <td style="text-align:center;"></td>
                                        </tr>
                                        <tr>
                                            <th style="text-align:center;" scope="row">대리점</th>
                                            <td style="text-align:center;">3</td>
                                            <td style="text-align:center;">5</td>
                                            <td style="text-align:center;">50,000p</td>
                                        </tr>
                                        <tr>
                                        	<th style="text-align:center;" rowspan="2">재<br/>구<br/>매</th>
                                            <th style="text-align:center;" scope="row">후원</th>
                                            <td style="text-align:center;">24</td>
                                            <td style="text-align:center;">35</td>
                                            <td style="text-align:center;">5,900p</td>
                                        </tr>
                                        <tr>
                                            <th style="text-align:center;" scope="row">추천</th>
                                            <td style="text-align:center;">22</td>
                                            <td style="text-align:center;">25</td>
                                            <td style="text-align:center;">24,600pp</td>
                                        </tr>
                                        <tr>
                                        	<td></td>
                                        	<th style="text-align:center;">소비자판매</th>
                                        	<td style="text-align:center;" colspan="2">1</td>
                                        	<td style="text-align:center;">6,000p</td>
                                        </tr>
                                        <tr>
                                        	<th style="text-align:right;" colspan="4">지급예상 포인트</th>
                                        	<td style="text-align:center;">85,900p</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!-- 영업 현황 end -->

                    <!-- 문의/답변 start -->
                    <!-- 
                    <div class="card">
                        <div class="card-header">
                            <h4>문의/답변</h4>
                        </div>
                        <div class="form-group row">
                            <div class="col-sm-10">
                                <textarea rows="5" cols="5" class="form-control"
                                placeholder=""></textarea>
                            </div>
                       	</div>
                    </div>
                     -->
                    <!-- 문의/답변 end -->
                </div>
            </div>
        </div>
        <!-- Main-body end -->



<c:import url="./frameSet/footer.jsp"></c:import>
</body>
</html>
