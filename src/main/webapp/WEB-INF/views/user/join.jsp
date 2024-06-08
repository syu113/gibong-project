<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<link href="/resources/assets/bootstrap/css/style.css" rel="stylesheet" />
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<style>

</style>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function execDaumPostcode(){
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
            // 예제를 참고하여 다양한 활용법을 확인해 보세요.
            
            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }
            document.getElementById('zipcode').value = data.zonecode
            document.getElementById('addr1').value = addr
            document.getElementById('addr2').focus()
        }
    }).open();
}
</script>
<script>
$(document).ready(function() {
	//공백체크
	var emptCheck = /\s/g;
	//영문 대소문자, 숫자로만 이루어진 4~12자리 정규식
	var idPwCheck = /^[a-zA-Z0-9]{4,12}$/;
	//휴대폰번호 
	var regPhone = /^(01[016789]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
	
   $("#sel_userFlag").change(function(){
	   
	   var val = $("#sel_userFlag :selected").val();
	   
	   $("#userFlag").val(val);
   });
	
   $("#sel_userFlag").focus();
   
   $("#sel_userFlag").focusout(function(){
	   if($("#sel_userFlag").val() == 0)
		{
		   $("#label_userFlag").css("color", "red").text("회원구분을 선택하세요.");
			return;
		}
	   else
	   {
		   $("#label_userFlag").css("color", "black").text("");
	   }
   });
   
   
   $("#userId").focusout(function(){
		
		if($.trim($("#userId").val()).length <= 0)
		{
			$("#label_userId").css("color", "red").text("아이디를 입력하세요.");
			$("#userId").val("");
			$("#userId").focus();
			return;
		}
		else
		{
			$("#label_userId").css("color", "black").text("");
		}
		
		if(emptCheck.test($("#userId").val()))
		{
			$("#label_userId").css("color", "red").text("아이디는 공백을 포함할 수 없습니다.");
			$("#userId").val("");
			$("#userId").focus();
			return;
		}
		else
		{
			$("#label_userId").css("color", "black").text("");
		}
		
		if(!idPwCheck.test($("#userId").val()))
		{
			$("#label_userId").css("color", "red").text("4~12자의 영문 대소문자로 입력하세요.");
			$("#userId").val("");
			$("#userId").focus();
			return;
		}
		else
		{
			$("#label_userId").css("color", "black").text("");
		}
		
		
		//아이디중복체크 ajax
		$.ajax({
			type:"POST",
			url:"/user/idCheck",
			data:{
				userId:$("#userId").val()
			},
			datatype:"JSON",
			beforeSend:function(xhr)
			{
				xhr.setRequestHeader("AJAX", "true");	
			},
			success:function(response)
			{
				if(response.code == 0)
				{
					$("#label_userId").css("color", "blue").text("사용할 수 있는 아이디입니다.");
				}
				else if(response.code == 100)
				{
					$("#label_userId").css("color", "red").text("중복된 아이디입니다.");
					$("#userId").focus();
				}
				else if(response.code == 400)
				{
					$("#label_userId").css("color", "red").text("올바르지 않습니다.");
					$("#userId").focus();
				}
				else
				{
					$("#label_userId").css("color", "red").text("틀립니다.");
					$("#userId").focus();
				}
			},
			error:function(xhr, status, error)
			{
				icia.common.error(error);	
			}
		});
		
	});
   
   $("#userPwd1").focusout(function(){
	   
	   
		if($.trim($("#userPwd1").val()).length <= 0)
		{
			$("#label_userPwd1").css("color", "red").text("비밀번호를 입력하세요.");
			$("#userPwd1").val("");
			return;
		}
		else
		{
			$("#label_userPwd1").css("color", "black").text("");
		}
		
		if(!idPwCheck.test($("#userPwd1").val()))
		{
			$("#label_userPwd1").css("color", "red").text("4~12자의 영문 대소문자로 입력하세요.");
			$("#userPwd1").val("");
			return;
		}
		else
		{
			$("#label_userPwd1").css("color", "black").text("");
		}
	});
   
   $("#userPwd2").focusout(function(){
	   
	   if($.trim($("#userPwd2").val()).length <= 0)
		{
		   $("#label_userPwd2").css("color", "red").text("비밀번호확인을 입력하세요.");
			$("#userPwd2").val("");
			return;
		}
	   else
	   {
		   $("#label_userPwd2").css("color", "black").text("");
	   }
		
		if($("#userPwd1").val() != $("#userPwd2").val())
		{
			$("#label_userPwd2").css("color", "red").text("비밀번호와 일치하지 않습니다.");
			$("#userPwd2").val("");
			return;
		}
		else
		{
			$("#label_userPwd2").css("color", "black").text("");
		}
		
		$("#userPwd").val($("#userPwd1").val());
	});
   
   $("#userName").focusout(function(){
	   
	   if($.trim($("#userName").val()).length <= 0)
		{
		    $("#label_userName").css("color", "red").text("이름을 입력하세요.");
			$("#userName").val("");
			return;
		}
	   else
	   {
		   $("#label_userName").css("color", "black").text("");
	   }
   });
   
   
   var email_auth_cd = "";
   
   
	$("#userEmail").focusout(function(){
	   
	   if($.trim($("#userEmail").val()).length <= 0)
		{
		    $("#label_userEmail").css("color", "red").text("이메일을 입력하세요.");
			$("#userEmail").val("");
			return;
		}
	   else
	   {
		   $("#label_userEmail").css("color", "black").text("");
	   }
	   
	   if(!fn_validateEmail($("#userEmail").val()))
		{
		   $("#label_userEmail").css("color", "red").text("이메일형식이 올바르지 않습니다.");
			$("#userEmail").val("");
			return;
		}
	   else
	   {
		   $("#label_userEmail").css("color", "black").text("");
	   }
   });
	
	$("#emailSend").on("click", function(){
		$.ajax({
			type : "POST",
			url : "/emailAuth",
			data : {
				email : $("#userEmail").val()
			},
			success: function(data){
				alert("인증번호가 발송되었습니다.");
				email_auth_cd = data;
			},
			error: function(data){
				alert("메일 발송에 실패했습니다.");
			}
		}); 
	})
	
	//이메일 인증 유효성체크
	$("#emailFlag").focusout(function(){
	   
	   if($.trim($("#emailFlag").val()).length <= 0)
		{
		    $("#label_emailFlag").css("color", "red").text("인증번호를 입력하세요.");
			$("#emailFlag").val("");
			return;
		}
	   else
	   {
		   $("#label_emailFlag").css("color", "black").text("");
	   }
	   
   });
	
	$("#emailconfirm").on("click", function(){
		
		if($.trim($("#emailFlag").val()).length <= 0)
		{
			$("#label_emailFlag").css("color", "red").text("이메일을 인증하세요.");
			$("#emailFlag").val("");
			return;
		}
		
		if($("#emailFlag").val() != email_auth_cd)
		{
		   $("#label_emailFlag").css("color", "red").text("인증번호가 일치하지 않습니다.");
			$("#emailFlag").val("");
			return;
		}
	   else
	   {
		   $("#label_emailFlag").css("color", "blue").text("인증에 성공하였습니다.");
	   }
	});
	
	
	$("#userPhone").focusout(function(){
		   
		   if($.trim($("#userPhone").val()).length <= 0)
			{
			    $("#label_userPhone").css("color", "red").text("휴대폰번호를 입력하세요.");
				$("#userPhone").val("");
				return;
			}
		   else
		   {
			   $("#label_userPhone").css("color", "black").text("");
		   }
		   
		   if(!regPhone.test($("#userPhone").val()))
			{
			   $("#label_userPhone").css("color", "red").text("전화번호 형식이 올바르지 않습니다.");
				$("#userPhone").val("");
				return;
			}
		   else
		   {
			   $("#label_userPhone").css("color", "black").text("");
		   }
	   });
	
	$("#zipcode").focusout(function(){
		   
		   if($.trim($("#zipcode").val()).length <= 0)
			{
			    $("#label_zipcode").css("color", "red").text("우편번호를 입력하세요.");
				$("#zipcode").val("");
				return;
			}
		   else
		   {
			   $("#label_zipcode").css("color", "black").text("");
		   }
		   
	   });
	
	$("#addr1").focusout(function(){
		   
		   if($.trim($("#addr1").val()).length <= 0)
			{
			    $("#label_addr1").css("color", "red").text("주소를 입력하세요.");
				$("#addr1").val("");
				return;
			}
		   else
		   {
			   $("#label_addr1").css("color", "black").text("");
		   }
		   
	   });
	
	$("#addr2").focusout(function(){
		   
		   if($.trim($("#addr2").val()).length <= 0)
			{
			    $("#label_addr2").css("color", "red").text("상세주소를 입력하세요.");
				$("#addr2").val("");
				return;
			}
		   else
		   {
			   $("#label_addr2").css("color", "black").text("");
		   }
		   
	   });
   
	 $("#btnJoin").on("click", function() {
		   
		   var agree1 = document.getElementById('agree1');
	       var agree2 = document.getElementById('agree2');
	       
	       if(agree1.checked == false || agree2.checked == false) {
	    	   $("#label_agree").css("color", "red").text("필수 약관에 동의해주세요.");
	           return;
	       }
	       else
	   	   {
	    	   $("#label_agree").css("color", "black").text("");
	   	   }
	       
		   if(!icia.common.isEmpty($("#userId").val()) && !icia.common.isEmpty($("#userPwd1").val()) &&
				   !icia.common.isEmpty($("#userPwd2").val()) && !icia.common.isEmpty($("#userName").val()) &&
				   !icia.common.isEmpty($("#userEmail").val()) && !icia.common.isEmpty($("#emailFlag").val()) &&
				   !icia.common.isEmpty($("#userPhone").val()) && !icia.common.isEmpty($("#zipcode").val()) &&
				   !icia.common.isEmpty($("#addr1").val()) && !icia.common.isEmpty($("#addr2").val()))
			 {
			   fn_userReg();
			 }
		   else
		   {
		   		alert("아직 입력하지 않은 정보가 있습니다.");
		   }
	   });
   	  
});

function fn_userReg()
{
	var form = $("#regForm")[0]
    var formData = new FormData(form);
	
   $.ajax({
	   type:"POST",
	   url:"/user/regProc",
	   data:formData,
	   processData:false,
  	   contentType:false,
  	   cache:false,
	   datatype:"JSON",
	   beforeSend:function(xhr)
		{
			xhr.setRequestHeader("AJAX", "true");	
		},
		success:function(response)
		{
			if(response.code == 0)
			{
				alert("회원가입에 성공하였습니다.");
				location.href = "/user/login";
			}
			else if(response.code == 100)
			{
				alert("회원 아이디가 중복 되었습니다.");
				$("#userId").focus();
			}
			else if(response.code == 400)
			{
				alert("파라미터 값이 올바르지 않습니다.");
				$("#userId").focus();
			}
			else if(response.code == 500)
			{
				alert("회원가입 중 오류가 발생하였습니다.");
				$("#userId").focus();
			}
			else
			{
				alert("회원가입 중 알 수 없는 오류가 발생하였습니다.");
				$("#userId").focus();
			}
		},
		error:function(xhr, status, error)
		{
			icia.common.error(error);
		}
   });
   
}

function fn_validateEmail(value)
{
   var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
   
   return emailReg.test(value);
}
</script> 

</head>
<body class="d-flex flex-column min-vh-100">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<!-- breadcrumb-section -->
   <div class="breadcrumb-section breadcrumb-bg" style="height:80px">
      <div class="container">
         <div class="row">
            <div class="col-lg-8 offset-lg-2 text-center">
               <div class="breadcrumb-text">
                  <h1 id="font" style="color: #554838; font-size: 50px">회원가입</h1>
               </div>
            </div>
         </div>
      </div>
   </div>
   <!--  
   <br/>
   <h2 class="" style="padding-top: 200px; color:#554838" align="center"><b>회원가입</b></h2>
   -->
   <br/>
   <div class="container" style="font-size: 20px;"> 
      <div class="form-join" style="font-size: 20px;"> 
         <form id="regForm" name="regForm"  method="post"> 
            <div class="form-join d-flex justify-content-center">
               <div class="col-sm-2 control-label">
                  <label style="color:#554838"><b>회원구분</b></label>
               </div>
               <div class="col-sm-4">
                  <select id="sel_userFlag" class="form-select form-select mb-3" aria-label=".form-select-lg example" style="font-size: 20px;">
                     <option value="" selected >선택</option>
                     <option value="U" >개인회원</option>
                     <option value="G">봉사기관</option>
                  </select>
                  <input type="hidden" id="userFlag" name="userFlag" value="">
                  <label id="label_userFlag"></label>
               </div>
            </div>
         
            <div class="form-join d-flex justify-content-center">
               <div class="col-sm-2 control-label">
                  <label style="color:#554838"><b>아이디</b></label>
               </div>
               <div class="col-sm-4"> 
                  <input type="text" class="form-control" name="userId" id="userId" value="" placeholder="4 ~ 20자의 영문, 숫자만 사용가능" style="font-size: 20px;">
               	  <label id="label_userId"></label>
               </div>
            </div>

            <div class="form-join d-flex justify-content-center">
               <div class="col-sm-2 control-label">
                  <label style="color:#554838"><b>비밀번호</b></label>
               </div>
               <div class="col-sm-4">
                  <input type="password" class="form-control" name="userPwd1" id="userPwd1" placeholder="4 ~ 20자의 영문, 숫자만 사용가능" style="font-size: 20px;">
               	  <label id="label_userPwd1"></label> 
               </div>
            </div>
                   
            <div class="form-join d-flex justify-content-center">
               <div class="col-sm-2 control-label">
                  <label style="color:#554838"><b>비밀번호확인</b></label>
               </div>
               <div class="col-sm-4">
                  <input type="password" class="form-control" name="userPwd2" id="userPwd2" style="font-size: 20px;">
               	  <label id="label_userPwd2"></label> 
               </div>
            </div>
                  
            <div class="form-join d-flex justify-content-center">
               <div class="col-sm-2 control-label">
                  <label style="color:#554838"><b>이름</b></label>
               </div>
               <div class="col-sm-4">
                  <input type="text" class="form-control" name="userName" id="userName" value="" style="font-size: 20px;">
               	  <label id="label_userName"></label> 
               </div>
            </div>        
                   
            <div class="form-join d-flex justify-content-center">
               <div class="col-sm-2 control-label">
                  <label style="color:#554838"><b>이메일</b></label>
               </div>
               <div class="col-sm-3">
                  <input type="email" class="form-control" name="userEmail" id="userEmail" value="" placeholder="(ex)email@gibong.com" style="font-size: 20px;">
               	  <label id="label_userEmail"></label> 
               </div>
               <div class="col-sm-1-1">
                  <a id="emailSend" style="width:53pt;background-color: #FFB74D; color: #554838; font-size: 13px" class="cart-btn"><b>전송</b></a>
                  <!-- <input type="button" onclick="execDaumPostcode();" value="우편번호찾기" class="btn btn-purple"> -->
               </div>
            </div>   
            
            <div class="form-join d-flex justify-content-center">
               <div class="col-sm-2 control-label">
                  <label style="color:#554838"><b>이메일인증</b></label>
               </div>
               <div class="col-sm-3">
                  <input type="email" class="form-control" name="emailFlag" id="emailFlag" value="" placeholder="" style="font-size: 20px;">
               	   <label id="label_emailFlag"></label> 
               </div>
               <div class="col-sm-1-1">
                  <a id="emailconfirm" name="emailconfirm" style="width:53pt;background-color: #FFB74D; color: #554838; font-size: 13px" class="cart-btn"><b>인증</b></a>
                   <label id="label_emailFlag2"></label> 
                  <!-- <input type="button" onclick="execDaumPostcode();" value="우편번호찾기" class="btn btn-purple"> -->
               </div>
            </div>   
                   
            <div class="form-join d-flex justify-content-center">
               <div class="col-sm-2 control-label">
                  <label style="color:#554838"><b>휴대전화</b></label>
               </div>
               <div class="col-sm-4">
                  <input type="text" class="form-control" name="userPhone" id="userPhone" value="" placeholder="'-'빼고 숫자만 입력" style="font-size: 20px;">
                  <label id="label_userPhone"></label> 
               </div>
            </div>
            
            <div class="form-join d-flex justify-content-center">
               <div class="col-sm-2 control-label">
                  <label style="color:#554838"><b>우편번호</b></label>
               </div>
               <div class="col-sm-3">
                  <input type="text" id="zipcode" name="zipcode" class="form-control" value="" style="font-size: 20px;">
                  <label id="label_zipcode"></label> 
               </div>
               <div class="col-sm-1-1">
                 <input type="button" onclick="execDaumPostcode();" value="검색" class="btn" style="background-color:#FFB74D;font-size: 20px;">
               </div>
            </div>   
            
            <div class="form-join d-flex justify-content-center" >
               <div class="col-sm-2 control-label">
                  <label style="color:#554838"><b>주소</b></label>
               </div>
               <div class="col-sm-4">
                  <input type="text" id="addr1" name="addr1" class="form-control" value="" style="font-size: 20px;">
               	  <label id="label_addr1"></label> 
               </div>   
            </div>
               
            <div class="form-join d-flex justify-content-center"> 
               <div class="col-sm-2 control-label">
                  <label style="color:#554838"><b>상세주소</b></label>
               </div>
               <div class="col-sm-4"> 
                  <input type="text" id="addr2" name="addr2" class="form-control" value="" style="font-size: 20px;">
                  <label id="label_addr2"></label> 
               </div>
            </div>
                   
             <div class="text-center">
                 <input id="agree1" type="checkbox" class="form-check-input">&nbsp;
                 <label class="">
                     <a style="color:#554838">이용약관 동의(필수)</a>
                 </label><br/>
                 <input id="agree2" type="checkbox" class="form-check-input">&nbsp;
                 <label class="">
                     <span style="color:#554838">개인정보 수집∙이용 동의(필수)</span>
                 </label><br/>
                 <label id="label_agree"></label> 
            </div>
            <input type="hidden" id="userPwd" name="userPwd" value="" /><br/>
            <div class="col-sm-12 text-center" >
               <a style="background-color: #FFCC80; color: #554838; font-size: 20px" class="cart-btn" id="btnJoin" name="btnJoin"><b>회원가입</b></a>
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               <a href="cart.html" style="background-color: #FFCC80; color: #554838; font-size: 20px" class="cart-btn"><b>취소</b></a>
            </div>
         </form>  
      </div>
   </div>
</body>
</html>