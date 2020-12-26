//怨듯넻蹂���
var objGlobal = {

	user_id			: '',
	d_no			: '',
	d_name_h		: '',
	ip_addr			: '',
	gModalId        : ''

};


var Request = function(url) {
	
	this.url = (url ? url : location.href);

	this.getParameter = function( name ) {

		var rtnval = '';
		//var nowAddress = unescape(this.url);
		var nowAddress = decodeURIComponent(this.url);
		var parameters = (nowAddress.slice(nowAddress.indexOf('?')+1,nowAddress.length)).split('&');
		for(var i = 0 ; i < parameters.length ; i++)
		{
			var varName = parameters[i].split('=')[0];
			if(varName.toUpperCase() == name.toUpperCase())
			{
				rtnval = parameters[i].split('=')[1];
				break;
			}
		}
		return rtnval;
	};
};

//�곷Ц,�レ옄留� �낅젰媛���
jQuery.fn.onlyEngNum = function() {
	
	this.bind("keypress keydown contextmenu", function(event){

		if (event.type == "keypress")
		{
			if(!(event.which>=48 && event.which<=57) && !(event.which>=65 && event.which<=90) && !(event.which>=97 && event.which<=122) && event.which!=0 && event.which!=8) {
				event.preventDefault();
			}
		}
		else if (event.type == "keydown")
		{
			if ((event.ctrlKey==true && (event.which == '118' || event.which == '86')) || (event.shiftKey==true && event.which == '45'))
			{
				event.preventDefault();
			} 
		}
		else if (event.type == "contextmenu")
		{
			event.preventDefault();
		}
	});
	
	return this;
};

function openAddrJuso(zcode, addr1, addr2) {
	tmpZipcodeaaabbbcccddd = zcode;
	tmpAddr1aaabbbcccddd = addr1;
	tmpAddr2aaabbbcccddd = addr2;
	var pop = window.open("/include/jusoPopup_utf8.asp","zippop","width=570,height=420, scrollbars=yes, resizable=yes"); 

}
function fnJusoCallBack(z, a1, a2) {
	document.getElementById(tmpZipcodeaaabbbcccddd).value = z;
	document.getElementById(tmpAddr1aaabbbcccddd).value = a1;
	document.getElementById(tmpAddr2aaabbbcccddd).value = a2;
}
//二쇱냼�쒓났�쒕퉬�� juso.go.kr END
//�レ옄留� �낅젰媛���
jQuery.fn.onlyNum = function() {

	this.css("ime-mode","disabled");
	
	this.bind("keypress keydown contextmenu", function(event){

		if (event.type == "keypress")
		{
			if(!(event.which>=48 && event.which<=57) && event.which!=0 && event.which!=8) {
				event.preventDefault();
			}
		}
		else if (event.type == "keydown")
		{
			if ((event.ctrlKey==true && (event.which == '118' || event.which == '86')) || (event.shiftKey==true && event.which == '45'))
			{
				event.preventDefault();
			} 
		}
		else if (event.type == "contextmenu")
		{
			event.preventDefault();
		}
	});
	
	return this;
};


jQuery.fn.center = function() {
	this.css("position","absolute");
	this.css("z-index",10001);

	if (this.height() + 50 < $(window).height())
	{
		this.css("top", ($(window).height() - this.height()) / 2 + $(window).scrollTop() + "px");
	}
	else
	{
		this.css("top", ($(window).scrollTop() + 50) + "px");
	}

	
	this.css("left", ($(window).width() - this.width()) / 2 + $(window).scrollLeft() + "px");
	return this;
};

function putComma(input) {

	if (!input)
	{
		return 0;
	}

	if (isNaN(input))
	{
		input = input.replace(/-/g,"");
		if (isNaN(input))
			return 0;
	}

	var num = input;

	if (num < 0) {
		num *= -1;
		var minus = true
	}else{
		var minus = false
	}

	var dotPos = (num+"").split(".")
	var dotU = dotPos[0]
	var dotD = dotPos[1]

	var commaFlag = dotU.length%3

	if(commaFlag) {
		var out = dotU.substring(0, commaFlag)
		if (dotU.length > 3) out += ","
	}
	else var out = ""

	for (var i=commaFlag; i < dotU.length; i+=3) {
		out += dotU.substring(i, i+3)
		if( i < dotU.length-3) out += ","
	}

	if(minus) out = "-" + out;

	if (dotPos.length <= 1)
		return out;
	else
		return out + "." + dotD;
	
}


var addComma = function(amt)
{
	return putComma(amt);
}

var rmComma = function(amt)
{
	return amt.replace(/,/g, "");
}


var getDateFormat = function(d, delim) {
	if (d != "")
	{
		if (d.length == 8)		
			return d.substr(0, 4) + delim + d.substr(4, 2) + delim + d.substr(6, 2);
		else if (d.length == 14)
			return d.substr(0, 4) + delim + d.substr(4, 2) + delim + d.substr(6, 2) + " " + d.substr(8, 2) + ":" + d.substr(10, 2) + ":" + d.substr(12, 2);
		
	}
	else
		return "";
}

				
var cutStr = function(str,limit){
	var tmpStr = str;
	var byte_count = 0;
	var len = str.length;
	var dot = "";

	for(i=0; i<len; i++){
		byte_count += chr_byte(str.charAt(i)); 
		if(byte_count == limit-1){
			if(chr_byte(str.charAt(i+1)) == 2){
				tmpStr = str.substring(0,i+1);
				dot = "...";
			}
			else
			{
				if(i+2 != len) dot = "...";
				tmpStr = str.substring(0,i+2);
			}
			break;
		}
		else if(byte_count == limit)
		{
			if(i+1 != len) dot = "...";
			tmpStr = str.substring(0,i+1);
			break;
		}
	}
	return tmpStr+dot;
}


var chr_byte = function(chr){
	if(escape(chr).length > 4)
		return 2;
	else
		return 1;
}

//ajax �붿껌
var ajaxRequest = function(url, param, callback, opt) {
	var returnData = "";
	
	var dataUrl		= url;
	var formdata	= param;
	var cb			= callback;

	if (typeof cb != "function")
	{
		cb = function(data){
			returnData = data;
		}
	}

	var isAsync		= (typeof opt.async != "undefined" ? opt.async : true);
	var method		= (typeof opt.method != "undefined" ? opt.method : "POST");
	var datatype	= (typeof opt.datatype != "undefined" ? opt.datatype : "json");	

	$.ajax({ 
		async: isAsync,
		cache:false,
		type: method, 
		url: dataUrl,
		data: formdata, 
		dataType: datatype, 
		contentType: "application/x-www-form-urlencoded; charset=utf-8",
		success: cb,
		error: function(request, status, error) {
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});

	if (isAsync == false)
	{
		return returnData;
	}
}

//由ъ뒪�� �먮뒗 �곗씠�� 媛��몄삤�� �⑥닔
var fnGetDataList = function(jsonOpt) {
	ajaxRequest(jsonOpt.url, jsonOpt.data, jsonOpt.callback, jsonOpt);
}

//�섏씠吏� 濡쒕뵫 �� 
$(function() {
	
	// 釉붾씪�몃뱶 �앹뾽�쒖옉
	$('[data-modal-id]').click(function(e) {
		
		e.preventDefault();
		var modalBox = $(this).attr('data-modal-id');
		objGlobal.gModalId = $(this).data('id');

		$('#'+modalBox).fadeIn($(this).data());
		var appendthis =  ("<div class='modal-overlay modal-overlay_"+ modalBox +"'></div>");
		$("body").append(appendthis);
		$(".modal-overlay").fadeTo(100, 0.6);

		//釉붾씪�몃뱶 �앹뾽媛�닔 援ы븯湲� (�レ옄 0遺���)
		var modalBoxCnt  = $('[class=modal-box]').length - 1;
		
		for (i=0; i <= modalBoxCnt; i++) {
			var modalArrayId = $("[class=modal-box]:eq("+ i +")").attr("id");
			if(modalBox != modalArrayId){
				$("#"+ modalArrayId).css("z-index", "1");
				$("#"+ modalBox ).css("z-index","2000");
			}
		}
		
		
		$(window).resize(function() {
			var modal_box = $('#'+modalBox).height() + 65;
			
			if ($(window).height() > modal_box) {
				$('#'+modalBox).css({
			    	top: ($(window).height() - $('#'+modalBox).outerHeight()) / 2,
			    	left: ($(window).width() - $('#'+modalBox).outerWidth()) / 2				        
			    });
			} else {
				$('#'+modalBox).css({ 
					top: 30,
					left: ($(window).width() - $('#'+modalBox).outerWidth()) / 2
				});
			}
		});
		
		$(window).resize();

		$("."+ modalBox +"_close").click(function() {
			//$("#"+ modalBox +", .modal-overlay_"+ modalBox).fadeOut(500, function() {
			$("#"+ modalBox).fadeOut(1, function() {
		 		
				for (k = modalBoxCnt; k >= 0; k--) {
					//alert(k + ' ' + modalBoxCnt);
					var modalArrayId = $("[class=modal-box]:eq("+ k +")").attr("id");
					if (modalArrayId == modalBox) {
						var openModal =  $("[class=modal-box]:eq("+ parseInt(k - 1) +")").attr("id");						
						$("#"+ openModal).css("z-index", "2000");
						$(".modal-overlay_"+modalBox).remove();
						break;
					}
					
				}
		    });
		});

	});
	// 釉붾씪�몃뱶 �앹뾽醫낅즺
	
});

//�レ옄留똭umberonly='true'
$(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9.]/gi,"") );});

//�곷Ц留똢ngOnly='true'
$(document).on("keyup", "input:text[engOnly]", function() {$(this).val( $(this).val().replace(/[0-9]|[^\!-z]/gi,"") );});

//�곷Ц�レ옄留똢ngnumberOnly='true'
$(document).on("keyup", "input:text[engnumberOnly]", function() {$(this).val( $(this).val().replace(/[^\!-z\^0-9]/gi,"") );});

//�곷Ц + �꾩뼱�곌린
$(document).on("keyup", "input:text[eng2Only]", function() {$(this).val( $(this).val().replace(/[0-9]|[^\!-z\s]/gi,"") );});

//�쒓�留똩orOnly='true' 
$(document).on("keyup", "input:text[korOnly]", function() {$(this).val( $(this).val().replace(/[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"\\]/g,"") );});

//�꾩뼱�곌린 留됯린
$(document).on("keyup", "input:text[NoSpace]", function() {$(this).val( $(this).val().replace(/[0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"\\]/g,"") );});

//�뚯씠釉� 由ъ뒪�� 珥덇린��
var initTableList = function(tbId) {
	$.each($(tbId + ' > tbody tr, '+ tbId + ' > tfoot tr'), function(index, entry) {
		$(this).remove();
	});
}

//�쒕쾭�좎쭨/�쒓컙 媛��몄삤湲�
var fnGetDate = function(gn,df,minus){	
	var data = ajaxRequest("/admin/server/etc/getDate.asp", "date_gn="+gn+"&df="+df+"&minus="+minus, null, {async:false});
	return data.result;
}

// jqgrid �곗씠�� 媛��몄삤湲�
// id : 洹몃━�쐇d, action_url : �꾨줈�쒖��몄텧 url, form : �낅젰��, page_no : �꾩젣 .�섏씠吏�踰덊샇
// fnJqgridList("#gridList", "/demo/demo4_db.php", "#tab1Form", "1");
var fnJqgridList = function(id, action_url, form, page_no) {
	$(id).clearGridData(true);
	
	$(id).setGridParam({url: action_url});
	$(id).setGridParam({postData:$(form).serialize()});
	$(id).setGridParam({datatype:'json'}); 
	$(id).setGridParam({mtype:'POST'});
	$(id).setGridParam({page: page_no});
	$(id).trigger("reloadGrid");
}

//由ъ뒪�� �섏씠吏�
function makePageList(PageVars) {
	
	var page = 1, pagesize = 20, blockpage = 10, totalcount = 0, fid = "#pageArea", fname = "fnSearch_page()";

	if (typeof PageVars == "object")
	{
		page		= PageVars.page;
		pagesize	= PageVars.pagesize;
		totalcount	= PageVars.totalcount;
		blockpage	= PageVars.blockpage;
		fid			= PageVars.fid;
		fname		= PageVars.fname;
	}

	$(fid + "> DIV.paging").smartpaginator({ totalrecords: totalcount, recordsperpage: pagesize, length: blockpage, initval: page, next: '/image/btn_next2.gif', prev: '/image/btn_prev2.gif', first: '/image/btn_prevEnd.gif', last: '/image/btn_nextend.gif', theme: 'pagerblack', onchange: function(newPage) {
			PageVars.page = newPage;			
			var dynamic_fun = new Function(fname);
			dynamic_fun();

		}
	});		

}



$.fn.selectRange = function(start, end) {

	return this.each(function() {

		if(this.setSelectionRange) {

			this.focus();

			this.setSelectionRange(start, end);

		}

		else if(this.createTextRange) {

			var range = this.createTextRange();

			range.collapse(true);

			range.moveEnd('character', end);

			range.moveStart('character', start);

			range.select();

		}

	});

};


function printPrice(price) {
	if (!isNaN(price))	
		return addComma(price.toFixed(8));
	else
		return price;
}

function printPrice0(price) {
	if (!isNaN(price))	
		return addComma(Math.floor(price));
	else
		return price;
}


/*-----------------------------------------------
 *  �쇳븘�쒖뿉 �レ옄留� �낅젰 諛쏅뒗 �⑥닔.
 *   onkeypress="isNumber();" style="ime-mode:disabled;"
 *-----------------------------------------------*/
function isNumber (){
	if ((event.keyCode<48)||(event.keyCode>57)){event.returnValue=false;}
}

// 荑좏궎 �곌린
function setCookie( name, value, expiredays ) {
  var todayDate = new Date();
  todayDate.setDate( todayDate.getDate() + expiredays );
  document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";";
}

// 荑좏궎 �쎄린
function getCookie(name)
{
	var arg = name + "=";
	var alen = arg.length;
	var clen = document.cookie.length;
	var i = 0;
	while(i < clen){
		var j = i + alen;
		if(document.cookie.substring(i, j) == arg)return getCookieVal(j);
		i = document.cookie.indexOf(" ", i) + 1;
		if(i == 0) break;
	}
	return null;
}


function getCookieVal(offset)
{
	var endstr = document.cookie.indexOf(";", offset);
	if(endstr == -1)endstr = document.cookie.length;
	return unescape(document.cookie.substring(offset, endstr));
}


function closeWin(name){
	setCookie(name, "true", 1);
	self.close();
} 
function aaa( name, value, expiredays ) {
  var todayDate = new Date();
  todayDate.setDate( todayDate.getDate() + expiredays );
  document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";";

}



function showBlindPopup(conts){
	
	var blind_id = "blind_popup";

	if ($("#mask").length == 0)
	{
		$("body").append('<div id="mask"></div>');
		$("#mask")
			.css("display","none")
			.css("overflow","hidden")
			.css("position","fixed")
			.css("left","0")
			.css("top","0")
			.css("z-index","10000")
			.css("background-color","#000");
	}

	if ($("#"+blind_id).length == 0)
	{
		$("body").append('<div id="'+blind_id+'" class="ui-widget-content" style="position:fixed;z-index:10001; display:none; background:transparent;border:0; padding:10px;"><div id="'+blind_id+'_content"></div></div>');
		$("#"+blind_id).append('<div id="btn_'+blind_id+'_close" style="position:absolute; right:-25px; top:-25px;"><img src="/image/button_close1.png"></div>');
		$("#btn_"+blind_id+"_close").css("cursor","pointer").bind("click", function(){
			hideBlindPopup();
		});

		$('body').bind('click', function(event) {
			if (!event) event = window.event;
			var target = (event.target) ? event.target : event.srcElement;
			event.stopPropagation(); // �대깽�� 踰꾨툝留� �꾪뙆瑜� 留됱쓬
			if(target.id == 'mask') {
				//hideBlindPopup();			
			}
		});
	}

	//�붾㈃�� �믪씠�� �덈퉬瑜� 援ы븳��.
	var maskHeight = $(document).height();  
	var maskWidth = $(window).width();  

	$('#mask').css({'width':maskWidth,'height':maskHeight});  

	//$('#mask').fadeIn(1000);      
	$('#mask').fadeTo("slow",0.7);

	$("#"+blind_id+"_content").html(conts);
	$("#"+blind_id).center().show();

	return false;	
}

function hideBlindPopup(){
	$("#blind_popup").hide();
	$("#mask").hide();	
	$("#blind_popup_content").html("");
}


//�몄쬆踰덊샇�붿껌
function requestAuthNo(sObj, nation, auth_gubun, auth_media, auth_value) {

	$(sObj).attr("disabled", "disabled");

	var param = "auth_gubun="+auth_gubun+"&auth_media="+auth_media+"&auth_value="+auth_value;
	fnGetDataList({async:true, url:"/admin/server/getAuthNo.asp", data:param, callback:function(data){

		var msg = "";

		if (data.result == "1") {

			if (nation == "KR") {
				msg = "�몄쬆踰덊샇瑜� 諛쒖넚�섏��듬땲��.";
			} else if (nation == 'CN') {
				msg = "�묇뺄藥꿨컛瑥곦묘煐뽩뤇��";
			} else if (nation == 'JP') {
				msg = "沃띹㉫�ゅ뤇�믧�곦에�쀣겲�쀣걼��";
			} else {
				msg = "We have forwarded the verification code.";
			}

			alert(msg);
		}
		else
		{

			if (nation == "KR") {
				msg = "�몄쬆踰덊샇 諛쒖넚�ㅽ뙣!";
			} else if (nation == 'CN') {
				msg = "溫ㅸ칮煐뽩뤇�묌�곩ㅁ兀ο펯";
			} else if (nation == 'JP') {
				msg = "沃띹㉫�ゅ뤇�븅�곩ㅁ�쀯펯";
			} else {
				msg = "verification code sent fail!";
			}

			alert(msg);
		}

		$(sObj).removeAttr("disabled")

	}});

}
