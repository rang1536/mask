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
<div class="modal fade" id="agentPop" role="dialog">
<div class="modal-dialog modal-lg">

<!-- Modal content-->
	<div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">&times;</button>
		</div>
		<div class="modal-body">
            <div class="form-group row">
                <div class="col-sm-5">
                    <input type="text" class="form-control form-control-success" id="searchWord3" name="searchWord3">
                </div>
                <div class="col-sm-4">
                	<button class="btn btn-success" id="searchAgentPop"><i class="icofont icofont-check-circled"></i></button>
                </div>
            </div>

			<div class="card-block table-border-style">
				<div class="table-responsive">
					<table class="table">
						<thead>
							<tr>
								<th style="width:33%;">대리점코드</th>
								<th style="width:33%;">대리점</th>
								<th style="width:33%;">등록일</th>
							</tr>
						</thead>
						<tbody id="agentList">
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
	$("#searchAgentPop").click(function(){
		if($("#searchWord3").val() == ""){
			alert("대리점 코드 또는 명을 입력해 주세요.");
			$("#searchWord3").focus();
			return;
		}
		
		$.ajax({
			url : 'searchAgent',
			data : {'searchWord' : $("#searchWord3").val()},
			dataType : 'json',
			type : 'post',
			success:function(data){
				console.log(data);
				var html = "";
				$.each(data.list, function(i, value){
					html += "<tr>";
					html += "	<td><a href='#' onclick='choose3(\""+value.code+"\""+",\""+value.name+"\")'>"+value.code+"</a></td>";
					html += "	<td>"+value.name+"</td>";
					html += "	<td>"+value.regdate+"</td>";
					html += "</tr>";
				});
				
				$("#agentList").html(html);
			}
		});
	});
	
	function choose3(code, name){
		$("#agent").val(name);
		$("#agentCode").val(code);
		$("#agentPop").modal("hide");
	}

</script>
</body>
</html>