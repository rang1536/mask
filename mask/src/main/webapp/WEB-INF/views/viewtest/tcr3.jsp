<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<!doctype html>
<html>
<head>
	<meta http-equiv='X-UA-Compatible' content='IE=edge' />
	<meta http-equiv='Content-Type' content='text/html;charset=UTF-8'/>
	
	<style>
	
	html, body {height:100%;}

    .dennisseah-orgchart .node {
        cursor: pointer;
    }
    .dennisseah-orgchart .node circle {
        fill: #fff;
        stroke: steelblue;
        stroke-width: 1.5px;
    }
    .dennisseah-orgchart .node text {
        font: 13px sans-serif;
    }
    
    .dennisseah-orgchart .link {
        fill: none;
        stroke: #ccc;
        stroke-width: 1.5;
    }
    
    .dennisseah-orgchart {
        overflow: hidden;
    }
	</style>



	<script src="resources/mask1/js/d3.v3.min.js"></script> 
	<script id='sap-ui-bootstrap' type='text/javascript'
		src='https://sapui5.hana.ondemand.com/resources/sap-ui-core.js'
		data-sap-ui-theme='sap_bluecrystal'
		data-sap-ui-libs='sap.ui.commons'></script>

	<script src="resources/mask1/js/common.js"></script>


	<script type="text/javascript">
		var orgchart_color = d3.scale.category10();


		orgchart_color.range(["#888888","#3e6969","#5c5c00","#ff9900","#993300","#ff0000","#cc9900","#0066ff","#cc00ff","#17becf","#ffffff"]);
		function changeColor(changeItem,color){
			$(changeItem).css("fill",color);
			$(changeItem).css("background",color);
		}
		
		var svg;

		var wasDrag = false;
		var mousedown = false;


		$(document).ready(function() {	

			//박스선택 후 드래그시 클릭안되도록
			$("#content")
			.mousedown(function() {
				mousedown = true;
				wasDrag = false;
			})
			.mouseup(function() {
				mousedown = false;
			})
			.mousemove(function() {
				if (mousedown) wasDrag = true; 				
			});


			// TOP 직코드별 색상 넣기
			for(var k in orgchart_color.range()){				
				if(k <= 1){				
					$("#orgchart_color"+k).css("fill",orgchart_color.range()[k]);				
				}
			}


			var i = 0,
				duration = 0,
				rectW = 140,
				rectHWrap = 20,
				rectH = 25,
				subRectH = 20;
			
			//데이터 컬럼 추가시 보여주고 싶은 위치에 컬럼명 추가
			var rowname = ["d_no","d_uid","D_GRP_CD","D_JICCODEP_NAME","d_jicname","d_date","d_cename","name"];
			//D_JICCODEP_NAME 와 d_jicname 가 같은 라인이므로 -1을 해줌
			//var rowCnt = rowname.length-2;			
			var rowCnt = 6;			
			var builddata = function () {
				var source = [];
				var children = [];
				// build hierarchical source.
	//			for (i = 0; i < data.length; i++) {

			
				//rowname 를 추가하였으면 아래 부분에도 변수명과 데이터를 세팅
					var data = {"olevel":"1"
								,"id":"32601"
								,"d_no":"32601"
								,"name":"김갑용"
								,"parentid":"32597"
								,"d_date":"20/11/06"
								,"d_jicname":"대리점"
								,"d_cename":"1000K센타"
								,"d_jiccode":"20"							
								,"pv1":"0"	
								,"d_uid":"K8000"
								,"D_GRP_CD":"KR"
								,"D_JICCODEP_NAME":"M"
								,"left_result":"0"
								,"right_result":"0"
								};
				
					console.log(data);
					var item = data;
					var parentid = item["parentid"];

					var id = item["id"];


					if (children[parentid]) {
						var item2 = {parentid: parentid, item: item };

						for(var k in rowname){
							item2[rowname[k]] = item[rowname[k]];
						}

						if (!children[parentid].children) {
							children[parentid].children = [];
						}
						children[parentid].children[children[parentid].children.length] = item2;
						children[id] = item2;
					}
					else {
						children[id] = {parentid: parentid, item: item };
						for(var k in rowname){
							children[id][rowname[k]] = item[rowname[k]];

						}
						source[id] = children[id];
					}
					console.log(source);
				//rowname 를 추가하였으면 아래 부분에도 변수명과 데이터를 세팅
					var data = {"olevel":"2"
								,"id":"32603"
								,"d_no":"32603"
								,"name":"김정애"
								,"parentid":"32601"
								,"d_date":"20/11/06"
								,"d_jicname":"대리점"
								,"d_cename":"부산한마음센타"
								,"d_jiccode":"20"							
								,"pv1":"0"	
								,"d_uid":"K2780"
								,"D_GRP_CD":"KR"
								,"D_JICCODEP_NAME":"M"
								,"left_result":"0"
								,"right_result":"0"
								};
				
					console.log(data);
					var item = data;
					var parentid = item["parentid"];

					var id = item["id"];


					if (children[parentid]) {
						var item2 = {parentid: parentid, item: item };

						for(var k in rowname){
							item2[rowname[k]] = item[rowname[k]];
						}

						if (!children[parentid].children) {
							children[parentid].children = [];
						}
						children[parentid].children[children[parentid].children.length] = item2;
						children[id] = item2;
					}
					else {
						children[id] = {parentid: parentid, item: item };
						for(var k in rowname){
							children[id][rowname[k]] = item[rowname[k]];

						}
						source[id] = children[id];
					}
					console.log(source);
				//rowname 를 추가하였으면 아래 부분에도 변수명과 데이터를 세팅
					var data = {"olevel":"3"
								,"id":"32776"
								,"d_no":"32776"
								,"name":"김외순"
								,"parentid":"32603"
								,"d_date":"20/11/07"
								,"d_jicname":"대리점"
								,"d_cename":"부산한마음센타"
								,"d_jiccode":"20"							
								,"pv1":"0"	
								,"d_uid":"K9802"
								,"D_GRP_CD":"KR"
								,"D_JICCODEP_NAME":"M"
								,"left_result":"0"
								,"right_result":"0"
								};
				
					console.log(data);
					var item = data;
					var parentid = item["parentid"];

					var id = item["id"];


					if (children[parentid]) {
						var item2 = {parentid: parentid, item: item };

						for(var k in rowname){
							item2[rowname[k]] = item[rowname[k]];
						}

						if (!children[parentid].children) {
							children[parentid].children = [];
						}
						children[parentid].children[children[parentid].children.length] = item2;
						children[id] = item2;
					}
					else {
						children[id] = {parentid: parentid, item: item };
						for(var k in rowname){
							children[id][rowname[k]] = item[rowname[k]];

						}
						source[id] = children[id];
					}
					console.log(source);
				//rowname 를 추가하였으면 아래 부분에도 변수명과 데이터를 세팅
					var data = {"olevel":"4"
								,"id":"32779"
								,"d_no":"32779"
								,"name":"이금례"
								,"parentid":"32776"
								,"d_date":"20/11/07"
								,"d_jicname":"대리점"
								,"d_cename":"부산한마음센타"
								,"d_jiccode":"20"							
								,"pv1":"0"	
								,"d_uid":"L4699"
								,"D_GRP_CD":"KR"
								,"D_JICCODEP_NAME":"M"
								,"left_result":"0"
								,"right_result":"0"
								};
					var item = data;
					var parentid = item["parentid"];

					var id = item["id"];


					if (children[parentid]) {
						var item2 = {parentid: parentid, item: item };

						for(var k in rowname){
							item2[rowname[k]] = item[rowname[k]];
						}

						if (!children[parentid].children) {
							children[parentid].children = [];
						}
						children[parentid].children[children[parentid].children.length] = item2;
						children[id] = item2;
					}
					else {
						children[id] = {parentid: parentid, item: item };
						for(var k in rowname){
							children[id][rowname[k]] = item[rowname[k]];

						}
						source[id] = children[id];
					}
			
				//rowname 를 추가하였으면 아래 부분에도 변수명과 데이터를 세팅
					var data = {"olevel":"5"
								,"id":"34339"
								,"d_no":"34339"
								,"name":"김기욱"
								,"parentid":"32779"
								,"d_date":"20/11/13"
								,"d_jicname":"대리점"
								,"d_cename":"부산한마음센타"
								,"d_jiccode":"20"							
								,"pv1":"0"	
								,"d_uid":"K2135"
								,"D_GRP_CD":"KR"
								,"D_JICCODEP_NAME":"M"
								,"left_result":"0"
								,"right_result":"0"
								};
					var item = data;
					var parentid = item["parentid"];

					var id = item["id"];


					if (children[parentid]) {
						var item2 = {parentid: parentid, item: item };

						for(var k in rowname){
							item2[rowname[k]] = item[rowname[k]];
						}

						if (!children[parentid].children) {
							children[parentid].children = [];
						}
						children[parentid].children[children[parentid].children.length] = item2;
						children[id] = item2;
					}
					else {
						children[id] = {parentid: parentid, item: item };
						for(var k in rowname){
							children[id][rowname[k]] = item[rowname[k]];

						}
						source[id] = children[id];
					}
			
				//rowname 를 추가하였으면 아래 부분에도 변수명과 데이터를 세팅
					var data = {"olevel":"6"
								,"id":"34846"
								,"d_no":"34846"
								,"name":"한혜림"
								,"parentid":"34339"
								,"d_date":"20/11/14"
								,"d_jicname":"대리점"
								,"d_cename":"부산한마음센타"
								,"d_jiccode":"20"							
								,"pv1":"0"	
								,"d_uid":"H5759"
								,"D_GRP_CD":"KR"
								,"D_JICCODEP_NAME":"M"
								,"left_result":"0"
								,"right_result":"0"
								};
					var item = data;
					var parentid = item["parentid"];

					var id = item["id"];


					if (children[parentid]) {
						var item2 = {parentid: parentid, item: item };

						for(var k in rowname){
							item2[rowname[k]] = item[rowname[k]];
						}

						if (!children[parentid].children) {
							children[parentid].children = [];
						}
						children[parentid].children[children[parentid].children.length] = item2;
						children[id] = item2;
					}
					else {
						children[id] = {parentid: parentid, item: item };
						for(var k in rowname){
							children[id][rowname[k]] = item[rowname[k]];

						}
						source[id] = children[id];
					}
			
				//rowname 를 추가하였으면 아래 부분에도 변수명과 데이터를 세팅
					var data = {"olevel":"4"
								,"id":"32978"
								,"d_no":"32978"
								,"name":"최낙기"
								,"parentid":"32776"
								,"d_date":"20/11/08"
								,"d_jicname":"대리점"
								,"d_cename":"부산한마음센타"
								,"d_jiccode":"20"							
								,"pv1":"0"	
								,"d_uid":"C9802"
								,"D_GRP_CD":"KR"
								,"D_JICCODEP_NAME":"M"
								,"left_result":"0"
								,"right_result":"0"
								};
					var item = data;
					var parentid = item["parentid"];

					var id = item["id"];


					if (children[parentid]) {
						var item2 = {parentid: parentid, item: item };

						for(var k in rowname){
							item2[rowname[k]] = item[rowname[k]];
						}

						if (!children[parentid].children) {
							children[parentid].children = [];
						}
						children[parentid].children[children[parentid].children.length] = item2;
						children[id] = item2;
					}
					else {
						children[id] = {parentid: parentid, item: item };
						for(var k in rowname){
							children[id][rowname[k]] = item[rowname[k]];

						}
						source[id] = children[id];
					}
			
				//rowname 를 추가하였으면 아래 부분에도 변수명과 데이터를 세팅
					var data = {"olevel":"3"
								,"id":"40482"
								,"d_no":"40482"
								,"name":"김갑용"
								,"parentid":"32603"
								,"d_date":"20/11/28"
								,"d_jicname":"대리점"
								,"d_cename":"부산한마음센타"
								,"d_jiccode":"20"							
								,"pv1":"0"	
								,"d_uid":"K8000-2"
								,"D_GRP_CD":""
								,"D_JICCODEP_NAME":"M"
								,"left_result":"0"
								,"right_result":"0"
								};
					var item = data;
					var parentid = item["parentid"];

					var id = item["id"];


					if (children[parentid]) {
						var item2 = {parentid: parentid, item: item };

						for(var k in rowname){
							item2[rowname[k]] = item[rowname[k]];
						}

						if (!children[parentid].children) {
							children[parentid].children = [];
						}
						children[parentid].children[children[parentid].children.length] = item2;
						children[id] = item2;
					}
					else {
						children[id] = {parentid: parentid, item: item };
						for(var k in rowname){
							children[id][rowname[k]] = item[rowname[k]];

						}
						source[id] = children[id];
					}
			
				//rowname 를 추가하였으면 아래 부분에도 변수명과 데이터를 세팅
					var data = {"olevel":"2"
								,"id":"32625"
								,"d_no":"32625"
								,"name":"김갑용"
								,"parentid":"32601"
								,"d_date":"20/11/07"
								,"d_jicname":"대리점"
								,"d_cename":"1000K센타"
								,"d_jiccode":"20"							
								,"pv1":"0"	
								,"d_uid":"Kk8000"
								,"D_GRP_CD":"KR"
								,"D_JICCODEP_NAME":"M"
								,"left_result":"0"
								,"right_result":"0"
								};
					var item = data;
					var parentid = item["parentid"];

					var id = item["id"];


					if (children[parentid]) {
						var item2 = {parentid: parentid, item: item };

						for(var k in rowname){
							item2[rowname[k]] = item[rowname[k]];
						}

						if (!children[parentid].children) {
							children[parentid].children = [];
						}
						children[parentid].children[children[parentid].children.length] = item2;
						children[id] = item2;
					}
					else {
						children[id] = {parentid: parentid, item: item };
						for(var k in rowname){
							children[id][rowname[k]] = item[rowname[k]];

						}
						source[id] = children[id];
					}
			
				//rowname 를 추가하였으면 아래 부분에도 변수명과 데이터를 세팅
					var data = {"olevel":"3"
								,"id":"35689"
								,"d_no":"35689"
								,"name":"최행진"
								,"parentid":"32625"
								,"d_date":"20/11/17"
								,"d_jicname":"대리점"
								,"d_cename":"부산한마음센타"
								,"d_jiccode":"20"							
								,"pv1":"0"	
								,"d_uid":"C5024"
								,"D_GRP_CD":"KR"
								,"D_JICCODEP_NAME":"M"
								,"left_result":"0"
								,"right_result":"0"
								};
					var item = data;
					var parentid = item["parentid"];

					var id = item["id"];


					if (children[parentid]) {
						var item2 = {parentid: parentid, item: item };

						for(var k in rowname){
							item2[rowname[k]] = item[rowname[k]];
						}

						if (!children[parentid].children) {
							children[parentid].children = [];
						}
						children[parentid].children[children[parentid].children.length] = item2;
						children[id] = item2;
					}
					else {
						children[id] = {parentid: parentid, item: item };
						for(var k in rowname){
							children[id][rowname[k]] = item[rowname[k]];

						}
						source[id] = children[id];
					}
			
				//rowname 를 추가하였으면 아래 부분에도 변수명과 데이터를 세팅
					var data = {"olevel":"4"
								,"id":"35690"
								,"d_no":"35690"
								,"name":"이민호"
								,"parentid":"35689"
								,"d_date":"20/11/17"
								,"d_jicname":"대리점"
								,"d_cename":"부산한마음센타"
								,"d_jiccode":"20"							
								,"pv1":"0"	
								,"d_uid":"L5611"
								,"D_GRP_CD":"KR"
								,"D_JICCODEP_NAME":"M"
								,"left_result":"0"
								,"right_result":"0"
								};
					var item = data;
					var parentid = item["parentid"];

					var id = item["id"];


					if (children[parentid]) {
						var item2 = {parentid: parentid, item: item };

						for(var k in rowname){
							item2[rowname[k]] = item[rowname[k]];
						}

						if (!children[parentid].children) {
							children[parentid].children = [];
						}
						children[parentid].children[children[parentid].children.length] = item2;
						children[id] = item2;
					}
					else {
						children[id] = {parentid: parentid, item: item };
						for(var k in rowname){
							children[id][rowname[k]] = item[rowname[k]];

						}
						source[id] = children[id];
					}
			
				//rowname 를 추가하였으면 아래 부분에도 변수명과 데이터를 세팅
					var data = {"olevel":"5"
								,"id":"36847"
								,"d_no":"36847"
								,"name":"김갑용"
								,"parentid":"35690"
								,"d_date":"20/11/19"
								,"d_jicname":"대리점"
								,"d_cename":"경기평택쎈타"
								,"d_jiccode":"20"							
								,"pv1":"0"	
								,"d_uid":"K0017"
								,"D_GRP_CD":"KR"
								,"D_JICCODEP_NAME":"M"
								,"left_result":"0"
								,"right_result":"0"
								};
					var item = data;
					var parentid = item["parentid"];

					var id = item["id"];


					if (children[parentid]) {
						var item2 = {parentid: parentid, item: item };

						for(var k in rowname){
							item2[rowname[k]] = item[rowname[k]];
						}

						if (!children[parentid].children) {
							children[parentid].children = [];
						}
						children[parentid].children[children[parentid].children.length] = item2;
						children[id] = item2;
					}
					else {
						children[id] = {parentid: parentid, item: item };
						for(var k in rowname){
							children[id][rowname[k]] = item[rowname[k]];

						}
						source[id] = children[id];
					}
			
				//rowname 를 추가하였으면 아래 부분에도 변수명과 데이터를 세팅
					var data = {"olevel":"6"
								,"id":"36852"
								,"d_no":"36852"
								,"name":"김갑용"
								,"parentid":"36847"
								,"d_date":"20/11/19"
								,"d_jicname":"대리점"
								,"d_cename":"경기평택쎈타"
								,"d_jiccode":"20"							
								,"pv1":"0"	
								,"d_uid":"K0018"
								,"D_GRP_CD":"KR"
								,"D_JICCODEP_NAME":"M"
								,"left_result":"0"
								,"right_result":"0"
								};
					var item = data;
					var parentid = item["parentid"];

					var id = item["id"];


					if (children[parentid]) {
						var item2 = {parentid: parentid, item: item };

						for(var k in rowname){
							item2[rowname[k]] = item[rowname[k]];
						}

						if (!children[parentid].children) {
							children[parentid].children = [];
						}
						children[parentid].children[children[parentid].children.length] = item2;
						children[id] = item2;
					}
					else {
						children[id] = {parentid: parentid, item: item };
						for(var k in rowname){
							children[id][rowname[k]] = item[rowname[k]];

						}
						source[id] = children[id];
					}
			
				//rowname 를 추가하였으면 아래 부분에도 변수명과 데이터를 세팅
					var data = {"olevel":"6"
								,"id":"36853"
								,"d_no":"36853"
								,"name":"김갑용"
								,"parentid":"36847"
								,"d_date":"20/11/19"
								,"d_jicname":"대리점"
								,"d_cename":"경기평택쎈타"
								,"d_jiccode":"20"							
								,"pv1":"0"	
								,"d_uid":"K0019"
								,"D_GRP_CD":"KR"
								,"D_JICCODEP_NAME":"M"
								,"left_result":"0"
								,"right_result":"0"
								};
					var item = data;
					var parentid = item["parentid"];

					var id = item["id"];


					if (children[parentid]) {
						var item2 = {parentid: parentid, item: item };

						for(var k in rowname){
							item2[rowname[k]] = item[rowname[k]];
						}

						if (!children[parentid].children) {
							children[parentid].children = [];
						}
						children[parentid].children[children[parentid].children.length] = item2;
						children[id] = item2;
					}
					else {
						children[id] = {parentid: parentid, item: item };
						for(var k in rowname){
							children[id][rowname[k]] = item[rowname[k]];

						}
						source[id] = children[id];
					}
			
				//rowname 를 추가하였으면 아래 부분에도 변수명과 데이터를 세팅
					var data = {"olevel":"5"
								,"id":"40213"
								,"d_no":"40213"
								,"name":"이원미1"
								,"parentid":"35690"
								,"d_date":"20/11/27"
								,"d_jicname":"대리점"
								,"d_cename":"선릉센타"
								,"d_jiccode":"20"							
								,"pv1":"0"	
								,"d_uid":"K0055"
								,"D_GRP_CD":"KR"
								,"D_JICCODEP_NAME":"M"
								,"left_result":"0"
								,"right_result":"0"
								};
					var item = data;
					var parentid = item["parentid"];

					var id = item["id"];


					if (children[parentid]) {
						var item2 = {parentid: parentid, item: item };

						for(var k in rowname){
							item2[rowname[k]] = item[rowname[k]];
						}

						if (!children[parentid].children) {
							children[parentid].children = [];
						}
						children[parentid].children[children[parentid].children.length] = item2;
						children[id] = item2;
					}
					else {
						children[id] = {parentid: parentid, item: item };
						for(var k in rowname){
							children[id][rowname[k]] = item[rowname[k]];

						}
						source[id] = children[id];
					}
			
				//rowname 를 추가하였으면 아래 부분에도 변수명과 데이터를 세팅
					var data = {"olevel":"6"
								,"id":"40217"
								,"d_no":"40217"
								,"name":"이원미2"
								,"parentid":"40213"
								,"d_date":"20/11/27"
								,"d_jicname":"대리점"
								,"d_cename":"선릉센타"
								,"d_jiccode":"20"							
								,"pv1":"0"	
								,"d_uid":"K0056"
								,"D_GRP_CD":"KR"
								,"D_JICCODEP_NAME":"M"
								,"left_result":"0"
								,"right_result":"0"
								};
					var item = data;
					var parentid = item["parentid"];

					var id = item["id"];


					if (children[parentid]) {
						var item2 = {parentid: parentid, item: item };

						for(var k in rowname){
							item2[rowname[k]] = item[rowname[k]];
						}

						if (!children[parentid].children) {
							children[parentid].children = [];
						}
						children[parentid].children[children[parentid].children.length] = item2;
						children[id] = item2;
					}
					else {
						children[id] = {parentid: parentid, item: item };
						for(var k in rowname){
							children[id][rowname[k]] = item[rowname[k]];

						}
						source[id] = children[id];
					}
			
				//rowname 를 추가하였으면 아래 부분에도 변수명과 데이터를 세팅
					var data = {"olevel":"6"
								,"id":"40222"
								,"d_no":"40222"
								,"name":"이원미3"
								,"parentid":"40213"
								,"d_date":"20/11/27"
								,"d_jicname":"대리점"
								,"d_cename":"선릉센타"
								,"d_jiccode":"20"							
								,"pv1":"0"	
								,"d_uid":"K0057"
								,"D_GRP_CD":"KR"
								,"D_JICCODEP_NAME":"M"
								,"left_result":"0"
								,"right_result":"0"
								};
					var item = data;
					var parentid = item["parentid"];

					var id = item["id"];


					if (children[parentid]) {
						var item2 = {parentid: parentid, item: item };

						for(var k in rowname){
							item2[rowname[k]] = item[rowname[k]];
						}

						if (!children[parentid].children) {
							children[parentid].children = [];
						}
						children[parentid].children[children[parentid].children.length] = item2;
						children[id] = item2;
					}
					else {
						children[id] = {parentid: parentid, item: item };
						for(var k in rowname){
							children[id][rowname[k]] = item[rowname[k]];

						}
						source[id] = children[id];
					}
			
				//rowname 를 추가하였으면 아래 부분에도 변수명과 데이터를 세팅
					var data = {"olevel":"4"
								,"id":"35691"
								,"d_no":"35691"
								,"name":"백수민"
								,"parentid":"35689"
								,"d_date":"20/11/17"
								,"d_jicname":"대리점"
								,"d_cename":"부산한마음센타"
								,"d_jiccode":"20"							
								,"pv1":"0"	
								,"d_uid":"K9000"
								,"D_GRP_CD":"KR"
								,"D_JICCODEP_NAME":"M"
								,"left_result":"0"
								,"right_result":"0"
								};
					var item = data;
					var parentid = item["parentid"];

					var id = item["id"];


					if (children[parentid]) {
						var item2 = {parentid: parentid, item: item };

						for(var k in rowname){
							item2[rowname[k]] = item[rowname[k]];
						}

						if (!children[parentid].children) {
							children[parentid].children = [];
						}
						children[parentid].children[children[parentid].children.length] = item2;
						children[id] = item2;
					}
					else {
						children[id] = {parentid: parentid, item: item };
						for(var k in rowname){
							children[id][rowname[k]] = item[rowname[k]];

						}
						source[id] = children[id];
					}
			
				//rowname 를 추가하였으면 아래 부분에도 변수명과 데이터를 세팅
					var data = {"olevel":"5"
								,"id":"35693"
								,"d_no":"35693"
								,"name":"유세헌"
								,"parentid":"35691"
								,"d_date":"20/11/17"
								,"d_jicname":"대리점"
								,"d_cename":"부산한마음센타"
								,"d_jiccode":"20"							
								,"pv1":"0"	
								,"d_uid":"K9001"
								,"D_GRP_CD":"KR"
								,"D_JICCODEP_NAME":"M"
								,"left_result":"0"
								,"right_result":"0"
								};
					var item = data;
					var parentid = item["parentid"];

					var id = item["id"];


					if (children[parentid]) {
						var item2 = {parentid: parentid, item: item };

						for(var k in rowname){
							item2[rowname[k]] = item[rowname[k]];
						}

						if (!children[parentid].children) {
							children[parentid].children = [];
						}
						children[parentid].children[children[parentid].children.length] = item2;
						children[id] = item2;
					}
					else {
						children[id] = {parentid: parentid, item: item };
						for(var k in rowname){
							children[id][rowname[k]] = item[rowname[k]];

						}
						source[id] = children[id];
					}
			
				//rowname 를 추가하였으면 아래 부분에도 변수명과 데이터를 세팅
					var data = {"olevel":"6"
								,"id":"37082"
								,"d_no":"37082"
								,"name":"김갑용"
								,"parentid":"35693"
								,"d_date":"20/11/20"
								,"d_jicname":"대리점"
								,"d_cename":"경기평택쎈타"
								,"d_jiccode":"20"							
								,"pv1":"0"	
								,"d_uid":"K0025"
								,"D_GRP_CD":"KR"
								,"D_JICCODEP_NAME":"M"
								,"left_result":"0"
								,"right_result":"0"
								};
					var item = data;
					var parentid = item["parentid"];

					var id = item["id"];


					if (children[parentid]) {
						var item2 = {parentid: parentid, item: item };

						for(var k in rowname){
							item2[rowname[k]] = item[rowname[k]];
						}

						if (!children[parentid].children) {
							children[parentid].children = [];
						}
						children[parentid].children[children[parentid].children.length] = item2;
						children[id] = item2;
					}
					else {
						children[id] = {parentid: parentid, item: item };
						for(var k in rowname){
							children[id][rowname[k]] = item[rowname[k]];

						}
						source[id] = children[id];
					}
			
				//rowname 를 추가하였으면 아래 부분에도 변수명과 데이터를 세팅
					var data = {"olevel":"5"
								,"id":"35924"
								,"d_no":"35924"
								,"name":"고현연3"
								,"parentid":"35691"
								,"d_date":"20/11/17"
								,"d_jicname":"대리점"
								,"d_cename":"부산한마음센타"
								,"d_jiccode":"20"							
								,"pv1":"0"	
								,"d_uid":"KKK1004"
								,"D_GRP_CD":"KR"
								,"D_JICCODEP_NAME":"M"
								,"left_result":"0"
								,"right_result":"0"
								};
					var item = data;
					var parentid = item["parentid"];

					var id = item["id"];


					if (children[parentid]) {
						var item2 = {parentid: parentid, item: item };

						for(var k in rowname){
							item2[rowname[k]] = item[rowname[k]];
						}

						if (!children[parentid].children) {
							children[parentid].children = [];
						}
						children[parentid].children[children[parentid].children.length] = item2;
						children[id] = item2;
					}
					else {
						children[id] = {parentid: parentid, item: item };
						for(var k in rowname){
							children[id][rowname[k]] = item[rowname[k]];

						}
						source[id] = children[id];
					}
			
				//rowname 를 추가하였으면 아래 부분에도 변수명과 데이터를 세팅
					var data = {"olevel":"6"
								,"id":"36858"
								,"d_no":"36858"
								,"name":"김갑용"
								,"parentid":"35924"
								,"d_date":"20/11/19"
								,"d_jicname":"대리점"
								,"d_cename":"경기평택쎈타"
								,"d_jiccode":"20"							
								,"pv1":"0"	
								,"d_uid":"K0020"
								,"D_GRP_CD":"KR"
								,"D_JICCODEP_NAME":"M"
								,"left_result":"0"
								,"right_result":"0"
								};
					var item = data;
					var parentid = item["parentid"];

					var id = item["id"];


					if (children[parentid]) {
						var item2 = {parentid: parentid, item: item };

						for(var k in rowname){
							item2[rowname[k]] = item[rowname[k]];
						}

						if (!children[parentid].children) {
							children[parentid].children = [];
						}
						children[parentid].children[children[parentid].children.length] = item2;
						children[id] = item2;
					}
					else {
						children[id] = {parentid: parentid, item: item };
						for(var k in rowname){
							children[id][rowname[k]] = item[rowname[k]];

						}
						source[id] = children[id];
					}
			
				//rowname 를 추가하였으면 아래 부분에도 변수명과 데이터를 세팅
					var data = {"olevel":"3"
								,"id":"35911"
								,"d_no":"35911"
								,"name":"안현정1"
								,"parentid":"32625"
								,"d_date":"20/11/17"
								,"d_jicname":"대리점"
								,"d_cename":"부산한마음센타"
								,"d_jiccode":"20"							
								,"pv1":"0"	
								,"d_uid":"A3400"
								,"D_GRP_CD":"KR"
								,"D_JICCODEP_NAME":"M"
								,"left_result":"0"
								,"right_result":"0"
								};
					var item = data;
					var parentid = item["parentid"];

					var id = item["id"];


					if (children[parentid]) {
						var item2 = {parentid: parentid, item: item };

						for(var k in rowname){
							item2[rowname[k]] = item[rowname[k]];
						}

						if (!children[parentid].children) {
							children[parentid].children = [];
						}
						children[parentid].children[children[parentid].children.length] = item2;
						children[id] = item2;
					}
					else {
						children[id] = {parentid: parentid, item: item };
						for(var k in rowname){
							children[id][rowname[k]] = item[rowname[k]];

						}
						source[id] = children[id];
					}
			
				//rowname 를 추가하였으면 아래 부분에도 변수명과 데이터를 세팅
					var data = {"olevel":"4"
								,"id":"35912"
								,"d_no":"35912"
								,"name":"안현정2"
								,"parentid":"35911"
								,"d_date":"20/11/17"
								,"d_jicname":"대리점"
								,"d_cename":"부산한마음센타"
								,"d_jiccode":"20"							
								,"pv1":"0"	
								,"d_uid":"AA3400"
								,"D_GRP_CD":"KR"
								,"D_JICCODEP_NAME":"M"
								,"left_result":"0"
								,"right_result":"0"
								};
					var item = data;
					var parentid = item["parentid"];

					var id = item["id"];


					if (children[parentid]) {
						var item2 = {parentid: parentid, item: item };

						for(var k in rowname){
							item2[rowname[k]] = item[rowname[k]];
						}

						if (!children[parentid].children) {
							children[parentid].children = [];
						}
						children[parentid].children[children[parentid].children.length] = item2;
						children[id] = item2;
					}
					else {
						children[id] = {parentid: parentid, item: item };
						for(var k in rowname){
							children[id][rowname[k]] = item[rowname[k]];

						}
						source[id] = children[id];
					}
			
				//rowname 를 추가하였으면 아래 부분에도 변수명과 데이터를 세팅
					var data = {"olevel":"5"
								,"id":"35921"
								,"d_no":"35921"
								,"name":"고현연1"
								,"parentid":"35912"
								,"d_date":"20/11/17"
								,"d_jicname":"대리점"
								,"d_cename":"부산한마음센타"
								,"d_jiccode":"20"							
								,"pv1":"0"	
								,"d_uid":"K1004"
								,"D_GRP_CD":"KR"
								,"D_JICCODEP_NAME":"M"
								,"left_result":"0"
								,"right_result":"0"
								};
					var item = data;
					var parentid = item["parentid"];

					var id = item["id"];


					if (children[parentid]) {
						var item2 = {parentid: parentid, item: item };

						for(var k in rowname){
							item2[rowname[k]] = item[rowname[k]];
						}

						if (!children[parentid].children) {
							children[parentid].children = [];
						}
						children[parentid].children[children[parentid].children.length] = item2;
						children[id] = item2;
					}
					else {
						children[id] = {parentid: parentid, item: item };
						for(var k in rowname){
							children[id][rowname[k]] = item[rowname[k]];

						}
						source[id] = children[id];
					}
			
				//rowname 를 추가하였으면 아래 부분에도 변수명과 데이터를 세팅
					var data = {"olevel":"6"
								,"id":"38433"
								,"d_no":"38433"
								,"name":"이성자"
								,"parentid":"35921"
								,"d_date":"20/11/24"
								,"d_jicname":"대리점"
								,"d_cename":"경기평택쎈타"
								,"d_jiccode":"20"							
								,"pv1":"0"	
								,"d_uid":"K0031"
								,"D_GRP_CD":"KR"
								,"D_JICCODEP_NAME":"M"
								,"left_result":"0"
								,"right_result":"0"
								};
					var item = data;
					var parentid = item["parentid"];

					var id = item["id"];


					if (children[parentid]) {
						var item2 = {parentid: parentid, item: item };

						for(var k in rowname){
							item2[rowname[k]] = item[rowname[k]];
						}

						if (!children[parentid].children) {
							children[parentid].children = [];
						}
						children[parentid].children[children[parentid].children.length] = item2;
						children[id] = item2;
					}
					else {
						children[id] = {parentid: parentid, item: item };
						for(var k in rowname){
							children[id][rowname[k]] = item[rowname[k]];

						}
						source[id] = children[id];
					}
			
				//rowname 를 추가하였으면 아래 부분에도 변수명과 데이터를 세팅
					var data = {"olevel":"5"
								,"id":"35922"
								,"d_no":"35922"
								,"name":"고현연2"
								,"parentid":"35912"
								,"d_date":"20/11/17"
								,"d_jicname":"대리점"
								,"d_cename":"부산한마음센타"
								,"d_jiccode":"20"							
								,"pv1":"0"	
								,"d_uid":"KK1004"
								,"D_GRP_CD":"KR"
								,"D_JICCODEP_NAME":"M"
								,"left_result":"0"
								,"right_result":"0"
								};
					var item = data;
					var parentid = item["parentid"];

					var id = item["id"];


					if (children[parentid]) {
						var item2 = {parentid: parentid, item: item };

						for(var k in rowname){
							item2[rowname[k]] = item[rowname[k]];
						}

						if (!children[parentid].children) {
							children[parentid].children = [];
						}
						children[parentid].children[children[parentid].children.length] = item2;
						children[id] = item2;
					}
					else {
						children[id] = {parentid: parentid, item: item };
						for(var k in rowname){
							children[id][rowname[k]] = item[rowname[k]];

						}
						source[id] = children[id];
					}
			
				//rowname 를 추가하였으면 아래 부분에도 변수명과 데이터를 세팅
					var data = {"olevel":"4"
								,"id":"35913"
								,"d_no":"35913"
								,"name":"안현정3"
								,"parentid":"35911"
								,"d_date":"20/11/17"
								,"d_jicname":"대리점"
								,"d_cename":"부산한마음센타"
								,"d_jiccode":"20"							
								,"pv1":"0"	
								,"d_uid":"AAA3400"
								,"D_GRP_CD":"KR"
								,"D_JICCODEP_NAME":"M"
								,"left_result":"0"
								,"right_result":"0"
								};
					var item = data;
					var parentid = item["parentid"];

					var id = item["id"];


					if (children[parentid]) {
						var item2 = {parentid: parentid, item: item };

						for(var k in rowname){
							item2[rowname[k]] = item[rowname[k]];
						}

						if (!children[parentid].children) {
							children[parentid].children = [];
						}
						children[parentid].children[children[parentid].children.length] = item2;
						children[id] = item2;
					}
					else {
						children[id] = {parentid: parentid, item: item };
						for(var k in rowname){
							children[id][rowname[k]] = item[rowname[k]];

						}
						source[id] = children[id];
					}
			
	//			}
				console.log(source);
				return source;
			}

			var source1 = builddata();	
			console.log("source1 :"+source1);
			sap.ui.core.Control.extend('dennisseah.OrgChart', {
				metadata: {
					properties: {
						//width: {type: 'int', defaultValue: screen.width},
						width: {type: 'int', defaultValue: (document.body.scrollWidth == 0 ? screen.width : document.body.scrollWidth)},
						height: {type: 'int', defaultValue: screen.height}
					}
				},

				init : function() {
					this.root = {};
				},

				setRoot : function(root) {
					this.root = root;
				},

				renderer : function(oRm, oControl) {
					oRm.write("<div");
					oRm.writeControlData(oControl);
					oRm.addClass("dennisseah-orgchart");
					oRm.writeClasses();
					oRm.write('>');
					oRm.write("</div>");
				},

				onAfterRendering: function() {
					console.log("여기 언제 호출됨")
					var	root = this.root;
					margin = {
						top: 20,
						right: 120,
						bottom: 20,
						left: 120
					};

					var nodeToNode = rectW + 10; //노드와 노드사이의 거리
					var bottom_edge = 32;//32 아래 선 크기

					var width = this.getWidth() - margin.right - margin.left;
					var height = this.getHeight() - margin.top - margin.bottom;
					var thisGetWidth = (this.getWidth() /2);

					rectHWrap = rectH + subRectH*rowCnt;

					var tree = d3.layout.tree().nodeSize([nodeToNode]);//노드와 노드 걸이
					var diagonal = d3.svg.diagonal()
						.projection(function (d) {					
							return [d.x + rectW / 2, d.y+rectHWrap /2];
					});

					svg = d3.select("#" + this.getId())
					.append("svg")
					.attr("width", "100%")
					.attr("height", "500px")
					.call(zm = d3.behavior.zoom().scaleExtent([0.1,1.5])
					.on("zoom", redraw)).append("g")
					.attr("transform", "translate(" + (this.getWidth() /3.5) + "," + 20 + ")");
					//.attr("transform", "translate(" + 0 + "," + 20 + ")");

					zm.translate([this.getWidth() / 3.5, 20]);
					console.log("여기 언제 호출됨2"+root);
					root.x0 = 0;
					root.y0 = height / 2;

					function collapse(d) {

						/*처음 확장
						if (d.children) {
							d._children = d.children;
							d._children.forEach(collapse);
							d.children = null;
						}
						*/
					}

					if(root.children !=  null){
						root.children.forEach(collapse);			
					}

					update(root);
					d3.select("#" + this.getId()).style("height", "100%");

					function update(source) {
						var nodes = tree.nodes(root).reverse(),
						links = tree.links(nodes);

						nodes.forEach(function (d) {
							//선 길이
							d.y = d.depth * rowCnt * bottom_edge; //32
							d.x0 = d.x;
						});

						var node = svg.selectAll("g.node")
						.data(nodes, function (d) {
							return d.id || (d.id = ++i);
						});

						// Enter any new nodes at the parent's previous position.
						var nodeEnter = node.enter().append("g")
							.attr("id", function (d) {
								return d.id;
						})
						.attr("class", "node")
						.attr("transform", function (d) {
							return "translate(" + source.x0 + "," + source.y0 + ")";
						})
						.on("click", click);

						var colListCnt = 1;
						//Header Div
						nodeEnter.append("rect")
						.attr("x", "0")
						.attr("y", "0")
						.attr("rx", "20")
						.attr("ry", "20")
						.attr("width", rectW)
						.attr("height", rectH*rowCnt)
						.attr("stroke", "black")
						.attr("stroke-width", 1);


						nodeEnter.append("text")
						.attr("x", rectW / 2)
						.attr("y", subRectH)
						.attr("dy", ".35em")
						.attr("text-anchor", "middle")
						.style("font-size", "16")
						.style("fill", function(d){
							var nodefill = getTextColor(d.d_jicname);
							return nodefill;						
						})
						.append("tspan")
						.text(function (d) {
						/*	
							if (d.d_uid.length <= 16)
								return d.d_uid;
							else
								return d.d_uid.substr(0,15)+"...";
						*/
							var uid = d.d_uid;
							var search_loc = uid.indexOf("@");

							if (search_loc != -1)
								return uid.substr(0, uid.indexOf("@"));
							else
								return uid;

						});

						nodeEnter.append("text")
						.attr("x", rectW / 2)
						.attr("y", subRectH + 15)
						.attr("dy", ".35em")
						.attr("text-anchor", "middle")
						.style("font-size", "16")
						.style("fill", function(d){
							var nodefill = getTextColor(d.d_jicname);
							return nodefill;						
						})
						.append("tspan")
						.text(function (d) {
						/*	
							if (d.d_uid.length <= 16)
								return d.d_uid;
							else
								return d.d_uid.substr(0,15)+"...";
						*/
							var uid = d.d_uid;
							var search_loc = uid.indexOf("@");

							if (search_loc != -1)
								return uid.substr(search_loc, uid.length);
							else
								return "";

						});
						colListCnt++;


   
						nodeEnter.append("text")
						.attr("x", rectW / 2)
						.attr("y", subRectH + (18*colListCnt))
						.attr("dy", ".35em")
						.attr("text-anchor", "middle")
						.style("font-size", "0.75em")
						.style("fill", function(d){
							var nodefill = getTextColor(d.d_jicname);
							return nodefill;						
						})
						.append("tspan")
						.text(function (d) {
							return d.name;
						});
						colListCnt++;


						/*            
						nodeEnter.append("image")
						.attr("x", 28)
						.attr("y", "3")
						.attr("width", 25)
						.attr("height", 25)
						.attr("xlink:href",function (d) {
						return "http://icpa.hosuco.co.kr/image/D_CONTRY/Korea.jpg";
						});
						*/




						//sub Div

						/*			
						nodeEnter.append("text")
						.attr("x", rectW / 2)
						.attr("y", subRectH + (20*colListCnt))
						.attr("dy", ".35em")
						.attr("text-anchor", "middle")
						.attr("value", function (d) {
						return d.d_no;
						})
						.text(function (d) {
						return d.d_no;
						});	
						colListCnt++;
						*/



/*						nodeEnter.append("text")
						.attr("x", rectW / 2)
						.attr("y", subRectH + (20*colListCnt))
						.attr("dy", ".35em")
						.attr("text-anchor", "middle")
						.style("font-size", "12")
						.text(function (d) {
							return d.D_GRP_CD;
						});	
*/
						/*	이미지 센터 맞춤*/
/*
						nodeEnter.append("image")
						.attr("x", (rectW/2)/4)
						.attr("y", subRectH/2 + (20*colListCnt))
						.attr("xlink:href",function (d) {
							return "/image/country/"+d.D_GRP_CD+".png";
						}).attr('width', 100)
	                    .attr('height', 22);
						
						colListCnt++;
*/
						nodeEnter.append("text")
						.attr("x", rectW / 2)
						.attr("y", subRectH + (21*colListCnt))
						.attr("dy", ".35em")
						.attr("text-anchor", "middle")
						.style("font-size", "12")
						.style("fill", function(d){
							var nodefill = getTextColor(d.d_jicname);
							return nodefill;						
						})
						.text(function (d) {
							return d.d_jicname;
						});	
						colListCnt++;

						nodeEnter.append("text")
						.attr("x", rectW / 2)
						.attr("y", subRectH + (21*colListCnt))
						.attr("dy", ".35em")
						.attr("text-anchor", "middle")
						.style("font-size", "12")
						.style("fill", function(d){
							var nodefill = getTextColor(d.d_jicname);
							return nodefill;						
						})
						.text(function (d) {
							return d.d_date;
						});	
						colListCnt++;

						
						nodeEnter.append("text")
						.attr("x", rectW / 2)
						.attr("y", subRectH + (20*colListCnt))
						.attr("dy", ".35em")
						.attr("text-anchor", "middle")
						.style("font-size", "12")
						.style("fill", function(d){
							var nodefill = getTextColor(d.d_jicname);
							return nodefill;						
						})
						.text(function (d) {
							return d.d_cename;
						});	
						colListCnt++;

/*
						nodeEnter.append("text")
						.attr("x", (rectW / 2)/2)
						.attr("y", subRectH + (20*colListCnt))
						.attr("dy", ".35em")
						.attr("text-anchor", "middle")
						.style("font-size", "12")
						.style("fill", function(d){
							var nodefill = "#fff";
							for(var i = 0 ; i < 2; i ++) {
								if(d.D_JICCODEP_NAME == $("#orgchart_color"+i).attr("value"))
								{
									nodefill = $("#orgchart_color"+i).css("fill");
								}								
							}
							return nodefill;						
						})
						.text(function (d) {
							return d.D_JICCODEP_NAME;
						});	
						nodeEnter.append("text")
						.attr("x", rectW / 2)
						.attr("y", subRectH + (20*colListCnt))
						.attr("dy", ".35em")
						.attr("text-anchor", "middle")
						.style("font-size", "12")
						.text(function (d) {
							return "/";
						});	
						nodeEnter.append("text")
						.attr("x", (rectW / 2)/2*3)
						.attr("y", subRectH + (20*colListCnt))
						.attr("dy", ".35em")
						.attr("text-anchor", "middle")
						.style("font-size", "12")
						.style("fill", function(d){
							var nodefill = "#ff7f0e";
							return nodefill;						
						})
						.text(function (d) {
							return d.d_jicname;
						});	
						colListCnt++;
*/

						
/*
						nodeEnter.append("text")
						.attr("x", 35)
						.attr("y", subRectH + (20*colListCnt))
						.attr("dy", ".35em")
						.attr("text-anchor", "middle")
						.style("font-size", "12")
						.text(function (d ) {
							//return d.d_cename;
							return "Left :";
						});	
						nodeEnter.append("text")
						.attr("x", 75)
						.attr("y", subRectH + (20*colListCnt))
						.attr("dy", ".35em")
						.attr("text-anchor", "middle")
						.style("font-size", "12")
						.style("fill", function(d){
							var nodefill = "#ff7f0e";
							return nodefill;						
						})
						.text(function (d ) {
							//return d.d_cename;
							return addComma(d.left_result);
						});	
						
						colListCnt++;


						nodeEnter.append("text")
						.attr("x", 30)
						.attr("y", subRectH + (20*colListCnt))
						.attr("dy", ".35em")
						.attr("text-anchor", "middle")
						.style("font-size", "12")
						.text(function (d ) {
							//return "PV : "+addComma(d.pv1);
							//return addComma(d.pv1) + "pv";
							return "Right :";
						});
						nodeEnter.append("text")
						.attr("x", 75)
						.attr("y", subRectH + (20*colListCnt))
						.attr("dy", ".35em")
						.attr("text-anchor", "middle")
						.style("font-size", "12")
						.style("fill", function(d){
							var nodefill = "#2ca02c";
							return nodefill;						
						})
						.text(function (d ) {
							//return "PV : "+addComma(d.pv1);
							//return addComma(d.pv1) + "pv";
							return addComma(d.right_result);
						});						
						colListCnt++;
*/

						
						// Transition nodes to their new position.
						var nodeUpdate = node.transition()
						.duration(duration)
						.attr("transform", function (d) {
							return "translate(" + d.x + "," + d.y + ")";
						});

						nodeUpdate.select("rect")
						.attr("width", rectW)
						.attr("height",  rectH*rowCnt)
//						.attr("stroke", "black")
//						.attr("stroke-width", 0.1)
						.style("fill", function (d,i) {

							var nodefill = "#ffffe6";
							for(var i = 0 ; i < 2; i ++) {
								if(d.d_jicname == $("#orgchart_color"+i).attr("value"))
								{
									nodefill = $("#orgchart_color"+i).css("fill");
								}								
							}
//							return d._children ? "lightsteelblue" : nodefill;
							return nodefill;
						});

						nodeUpdate.select("text")
						.style("fill-opacity", 1);

						// Transition exiting nodes to the parent's new position.
						var nodeExit = node.exit().transition()
						.duration(duration)
						.attr("transform", function (d) {
							return "translate(" + source.x + "," + source.y + ")";
						})
						.remove();

						nodeExit.select("rect")
						.attr("width", rectW)
						.attr("height", rectH)
//						.attr("stroke", "black")
//						.attr("stroke-width", 0.1);
						nodeExit.select("text");

						// Update the links…
						var link = svg.selectAll("path.link")
						.data(links, function (d) {
							return d.target.id;
						});


						// Enter any new links at the parent's previous position.
						link.enter().insert("path", "g")
						.attr("class", "link")
						.attr("d", elbow);


						// Transition links to their new position.
						link.transition()
						.duration(duration)
						.attr("d", elbow);


						// Transition exiting nodes to the parent's new position.
						link.exit().transition()
						.duration(duration)
						.attr("d", elbow)
						.remove();

						// Stash the old positions for transition.
						nodes.forEach(function (d) {
							d.x0 = d.x;
							d.y0 = d.y;
						});
						
						setOnload();
					}

					// Toggle children on click.
					function click(d) {

						if (wasDrag) 
						{
							event.stopPropagation();
							return false;
						}

						var addParam = "";
						
						if (d.d_no != "32601")
						{
							if (d.d_no == source1[32601].d_no)
							{
								addParam = "&is_up=Y";
							}
							document.location.href = "?s_no="+d.d_no+"&sdate=2001-10-28&edate=2020-12-27&s_Level=5&s_stat=0" + addParam;							
						}

						
						/*클릭 확장*/
						/*
						if (d.children) {
							d._children = d.children;
							d.children = null;
						} else {
							d.children = d._children;
							d._children = null;
						}
						update(d);

						*/
					}

					//Redraw for zoom
					var scaleSize;
					function redraw() {
						//console.log("here", d3.event.translate, d3.event.scale);
						svg.attr("transform",function(d,i){
							var movX =0;
							var movY =0;
							movX = d3.event.translate[0];
							movY = d3.event.translate[1];

							//movX = d3.event.translate[0] + thisGetWidth;

							scaleSize = d3.event.scale;

							return  "translate(" + movX+","+movY + ")"  + " scale(" + scaleSize + ")";
						});
					}

				}
			});
			
			
			function elbow(d, i) {
			/*
				return "M" + d.source.x + "," + Number(d.source.y+rectH+20)
				+ "H" + Number(d.target.x+rectW/2) + "V" + d.target.y
				+ (d.target.children ? "" : "h" + margin.top);
			*/

				//alert("d.source.y : "+d.source.y+"//d.source.x"+d.source.x+"//d.target.y"+d.target.y+"//d.target.x"+d.target.x);
				return "M" + Number(d.source.x+rectW/2) + "," + Number(d.source.y+rectHWrap)
				+ "L" + Number(d.source.x+rectW/2)+ "," + Number(d.source.y+rectHWrap+margin.top)
				+ "L" + Number(d.target.x+rectW/2)+ "," +Number(d.source.y+rectHWrap+margin.top)
				+ "L" + Number(d.target.x+rectW/2)+ "," +d.target.y
				// + (d.target.children ? "" : "h" + margin.top);

			}

			var org_chart = new dennisseah.OrgChart();
			org_chart.setRoot( source1[32601]);
			org_chart.placeAt('content');

		});


	function getTextColor(jicname) {
		if (jicname == "AM" || jicname == "1 Level")		
			return "#000";
		else
			return "#fff";
		
	}


	function setOnload(){
		parent.document.getElementById('isRunning').value = '';
		parent.document.getElementById("processbar").style.display = "none";
		parent.document.getElementById("org_main").style.display = "block";
	}

	function JSONtoString(object) {
		var results = [];
		for (var property in object) {
			var value = object[property];
			if (value)
				results.push(property.toString() + ': ' + value);
		}						 
		return '{' + results.join(', ') + '}';
	}
	</script>
</head>

<body class='sapUiBody' style="background:#fff">
<div style="width:70px;height:200px; top:5px;left:5px;position:absolute;font:11px sans-serif;">

	<svg width="100%" height="100%">
	
				<g>
					<rect id="orgchart_color0" y="0" width="13" height="13" style="stroke:rgb(0,0,0);" value="M"/>
					<text x="20" y="11" id="orgchart_jic_0">M</text>
				</g>			
				
				<g>
					<rect id="orgchart_color1" y="20" width="13" height="13" style="stroke:rgb(0,0,0);" value="대리점"/>
					<text x="20" y="31" id="orgchart_jic_1">대리점</text>
				</g>			
				
	</svg>
</div>
<div id='content' style="height:100%;"></div>
</body>
</html>


