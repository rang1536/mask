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

		var rootId = '';
		var baseId = '${id}';
		var maxLoop = '${maxLoop}';
		
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
				
				$.ajax({
					url : 'getSponsorTree',
					type : 'post',
					dataType: 'json',
					async : false,
					data : {'id':baseId, 'maxLoop': maxLoop},
					success:function(result){
						console.log("start~!!");
						var list = result.user;
						rootId = list[0].id;
						
						for(var i=0; i<list.length; i++){
							var data = list[i];
							data.D_GRP_CD = "KR";
							data.D_JICCODEP_NAME = "M";
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
						}
		
					} //success end
				}) //ajax end
				
				console.log(source);
				return source;
			} 
			
			
			var source1 = builddata();	
			console.log("source1 : "+source1);
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
					//console.log('init : function()');
				},

				setRoot : function(root) {
					this.root = root;
					//console.log('setRoot : function(root) : '+root);
				},

				renderer : function(oRm, oControl) {
					//console.log('renderer : function(oRm, oControl) '+oRm+', '+oControl);
					oRm.write("<div");
					oRm.writeControlData(oControl);
					oRm.addClass("dennisseah-orgchart");
					oRm.writeClasses();
					oRm.write('>');
					oRm.write("</div>");
				},

				onAfterRendering: function() {
					//console.log("여기 언제 호출됨")
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
							//console.log('var diagonal '+d.x + rectW / 2+', '+d.y+rectHWrap /2);
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
						//console.log('root.children !=  null : '+root.children);
					}

					update(root);
					d3.select("#" + this.getId()).style("height", "100%");

					function update(source) {
						//console.log('update(source) : '+source);
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
						
						//if (d.d_no != "32601")
						if (d.d_no != rootId)
						{
							//if (d.d_no == source1[32601].d_no)
							/* if (d.d_no == source1[rootId].d_no)
							{
								addParam = "&is_up=Y";
							} */
							document.location.href = "sponChart?baseIdSponsor="+d.d_uid+"&sponsorMaxLoop="+maxLoop;							
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
			//org_chart.setRoot( source1[32601]);
			//console.log('여긴 언제 호출함?! setRoot')
			org_chart.setRoot( source1[rootId]);
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


