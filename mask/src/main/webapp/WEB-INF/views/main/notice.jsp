<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:import url="../module/mTop.jsp"></c:import> 
<!DOCTYPE html>
<head>
	<style>
	/* .thTag{color:#002266;} */
	</style>
</head>

<body>

	
<!-- Main -->
	
	<section id="main" >
		<div class="inner">
<!-- Table -->
			<section>
				<h3>공지사항</h3>
				<h4>전체공지</h4>
				<div class="table-wrapper">
					<input type="hidden" id="nowPageNum" name="nowPageNum" value="1"/>
					<table>
						<thead>
							<tr>
								<th class="thTag" style="width:10%;">No</th>
								<th class="thTag" style="text-align:center;width:70%;">글제목</th>
								<th class="thTag" style="width:20%;">작성자</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${list.size() eq 0 or list eq null}">
								<td colspan="3" style="font-size:14px;color:#ddd;">등록된 공지사항이 없습니다.</td>
							</c:if>
							<c:forEach var="list" items="${list }">
								<td>${list.seq }</td>
								<td onclick="getNoticeDetail(${list.seq})">${list.title }</td>
								<td>${list.regId }</td>
							</c:forEach>
							
						</tbody>
						<tfoot>
							<!-- <tr>
								<td colspan="2"></td>
								<td>100.00</td>
							</tr> -->
						</tfoot>
					</table>
					
					<c:if test="${totalCnt > 10 }"> 
						<div style="width:100%;text-align:center;height:40px;padding-top:10px;">
							<a href="#" onclick="getCommunityBoradList('pre')" style="padding:2px;font-weight:bold;"> ◀ 이전 </a>&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="#" onclick="getCommunityBoradList('next')" style="padding:2px;font-weight:bold;"> 다음 ▶ </a>
						</div>
					</c:if> 
					
					<c:if test="${list.size() eq 0 or list eq null}">
						<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
					</c:if> 
				</div>	
			</section>
		</div>
	</section>

<c:import url="../module/mFoot.jsp"></c:import>

<script>
	$(document).ready(function(){
		var nowPageNum = '${nowPageNum}';
		if(nowPageNum != null && nowPageNum != ''){
			$('#nowPageNum').val(nowPageNum);
		}
		
	})
	
	
	function getCommunityBoradList(type){
		var totalCnt = '${totalCnt}';
		var lastPage = 0;
		
		if(totalCnt > 10){
			if(totalCnt%10 == 0){
				lastPage = totalCnt/10;
			}else if(totalCnt%10 > 0){
				lastPage = Math.floor(totalCnt/10)+1
			}
		}else{
			lastPage = 1;
		}
		
		//console.log('lastPage'+lastPage);
				
		var nowPageNum = $('#nowPageNum').val();
		//console.log('nowPageNum : '+nowPageNum);
		
		if(type == 'pre'){
			if(nowPageNum == 1){
				alert('첫 페이지 입니다.');
				return;
			}else if(nowPageNum > 1){
				nowPageNum = nowPageNum - 1;
			}		
		}else if(type == 'next'){
			if(lastPage == nowPageNum){
				alert('마지막 페이지 입니다.');
				return;
			}else if(lastPage > nowPageNum){
				nowPageNum = parseInt(nowPageNum) + 1;
			}
			//console.log('nowPageNum'+nowPageNum);
		}
		
		location.href = 'notice?nowPageNum='+nowPageNum;
	}
</script>
</body>
</html>