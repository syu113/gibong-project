<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<link href="/resources/assets/bootstrap/css/style.css" rel="stylesheet" />
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script>
$(document).ready(function(){
	//공백체크
	var emptCheck = /\s/g;
	
	$("#userId").focusout(function(){
		
		if($.trim($("#userId").val()).length <= 0)
		{
			$("#label_userId").css("color", "red").text("아이디를 입력하세요.");
			$("#userId").val("");
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
			return;
		}
		else
		{
			$("#label_userId").css("color", "black").text("");
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
		   
		   $("#emailSend").on("click", function(){
				$.ajax({
					type : "POST",
					url : "/user/findPwdProc",
					data : {
						userId : $("#userId").val(),
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
			});
	   }
   });
	
});
function fn_validateEmail(value)
{
   var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
   
   return emailReg.test(value);
}
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
   <div class="breadcrumb-section breadcrumb-bg" style="height:80px">
      <div class="container">
         <div class="row">
            <div class="col-lg-8 offset-lg-2 text-center">
               <div class="breadcrumb-text">
                  <h1 id="font" style="color: #554838; font-size: 50px">비밀번호 찾기</h1>
               </div>
            </div>
         </div>
      </div>
   </div>
   </br></br>
   <div class="container">
   </br></br></br>
   <form name="findPwdForm" id="findPwdForm" class="form-signin" action="" method="POST">
                  <div class="form-join d-flex justify-content-center">
               <div class="col-sm-2 control-label">
                  <label style="color:#554838; font-size:18px;float:right;"><b>아이디</b></label>
               </div>
               <div class="col-sm-4">
                  <input type="text" class="form-control" name="userId" id="userId" value="" placeholder="아이디를 입력하세요." style="font-size: 20px;width:350px;">
               	  <label id="label_userId"></label>
               </div>
            </div>        
                   
            <div class="form-join d-flex justify-content-center">
               <div class="col-sm-2 control-label">
                  <label style="color:#554838;font-size:18px;float:right"><b>이메일</b></label>
               </div>
               <div class="col-sm-3">
                  <input type="email" class="form-control" name="userEmail" id="userEmail" value="" placeholder="이메일을 입력하세요." style="font-size: 20px; width:260px;">
               	  <label id="label_userEmail"></label>
               </div>
               <div class="col-sm-1-1">
               <a></a>
                  <a id="emailSend" style="width:52pt;background-color: #FFB74D; color: #554838; font-size:13px;float:right" class="cart-btn"><b>전 송</b></a>
                  <!-- <input type="button" onclick="execDaumPostcode();" value="우편번호찾기" class="btn btn-purple"> -->
               </div>
            </div>   
      <br/><br/>
  
                <div class="col-sm-12 text-center"  >
               <a href="/user/login" style="background-color: #FFCC80; color: #554838; font-size: 20px" class="cart-btn"><b>로그인 페이지로 이동</b></a>
               </div>
              <input type="hidden" id="password" name="password" value="" />
   </form>
</div>
</body>
</html>
