<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원찾기</title>
<style>
	tr{margin-top:2px;margin-bottom:2px;}
	th{text-align:center;}
	td{text-align:center;}
</style>
</head>
<body>
<!--본문시작  -->
<div class="modal fade" id="recommenderPop" role="dialog">
<div class="modal-dialog modal-lg">

<!-- Modal content-->
	<div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">&times;</button>
		</div>
		<div class="modal-body">
            <div class="form-group row">
                <div class="col-sm-5">
                    <input type="text" class="form-control form-control-success" id="searchWord" name="searchWord">
                </div>
                <div class="col-sm-4">
                	<button class="btn btn-success" id="searchUser"><i class="icofont icofont-check-circled"></i></button>
                </div>
            </div>

			<div class="card-block table-border-style">
				<div class="table-responsive">
					<table class="table">
						<thead>
							<tr>
								<th style="width:33%;">아이디</th>
								<th style="width:33%;">이름</th>
								<th style="width:33%;">가입일</th>
							</tr>
						</thead>
						<tbody id="userList">
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="modal-footer">
			<button type="submit" class="btn btn-default btn-default pull-left" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> Cancel</button>
		</div>
	</div>
</div>
</div>
<script>
	$("#searchUser").click(function(){
		if($("#searchWord").val() == ""){
			alert("아이디 또는 이름을 입력해 주세요.");
			$("#searchWord").focus();
			return;
		}
		
		$.ajax({
			url : 'searchMem',
			data : {'id' : $("#searchWord").val()},
			dataType : 'json',
			type : 'post',
			success:function(data){

				var html = "";
				
				if(data.list.length > 0){
					$.each(data.list, function(i, value){

						html += "<tr>";
						//html += "	<td><a href='#' onclick='choose(\""+value.id+"\"")'>"+value.id+"</a></td>";
						html += "	<td><a href='#' onclick='choose(\""+value.id+"\""+",\""+value.name+"\")'>"+value.id+"</a></td>";
						html += "	<td>"+value.name+"</td>";
						html += "	<td>"+value.regdate+"</td>";
						html += "</tr>";
					});
				}else{
					html += "<tr>";
					html += "	<td colspan='3' style='color:red;'>조회된 목록이 없습니다.</td>";
					html += "</tr>";
				}
				
				$("#userList").empty();
				$("#userList").html(html);
			}
		});
	});
	
	function choose(id, name){
		$("#recommender").val(id);
		$("#recommenderPop").modal("hide");
	}

</script>
</body>
</html>