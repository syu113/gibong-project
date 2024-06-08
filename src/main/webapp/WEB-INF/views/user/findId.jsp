<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<link href="/resources/assets/bootstrap/css/style.css" rel="stylesheet" />
<script type="text/javascript" src="/resources/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="/resources/js/icia.common.js"></script>
<script type="text/javascript" src="/resources/js/icia.ajax.js"></script>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<style>
   .form-signin {
     max-width: 330px;
     padding: 15px;
     margin: 0 auto;
   }
   .form-signin .form-signin-heading,
   .form-signin .checkbox {
     margin-bottom: 10px;
   }
   .form-signin .checkbox {
     font-weight: 400;
   }
   .form-signin .form-control {
     position: relative;
     -webkit-box-sizing: border-box;
     -moz-box-sizing: border-box;
     box-sizing: border-box;
     height: auto;
     padding: 10px;
     font-size: 20px;
   }
   .form-signin .form-control:focus {
     z-index: 2;
   }
   .form-signin input[type="text"] {
     margin-bottom: 5px;
     border-bottom-right-radius: 0;
     border-bottom-left-radius: 0;
   }
   .form-signin input[type="password"] {
     margin-bottom: 10px;
     border-top-left-radius: 0;
     border-top-right-radius: 0;
   }
</style>
<script>
$(document).ready(function(){
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
	
	
	$("#findId").on("click", function(){
		document.findForm.submit();
	});
	
	$("#cancel").on("click", function(){
		location.href = "/user/login";
	});
});

function fn_validateEmail(value)
{
   var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
   
   return emailReg.test(value);
}


function fnSubmit() {
   
}
</script>
</head>
<body class="d-flex flex-column min-vh-100">
<%@ include file="/WEB-INF/views/include/navigation.jsp"%>
   <div class="breadcrumb-section breadcrumb-bg" style="height:80px">
      <div class="container">
         <div class="row">
            <div class="col-lg-8 offset-lg-2 text-center">
               <div class="breadcrumb-text">
                  <h1 id="font" style="color: #554838; font-size: 50px">아이디 찾기</h1>
               </div>
            </div>
         </div>
      </div>
   </div>
   <div class="container">
      <form name="findForm" id="findForm" method="post" action="/user/findIdProc" class="form-signin">
         <br/>
         <label for="userName" style="font-size: 20px; color:#554838;"><b>이름</b></label>
         <input type="text" id="userName" name="userName" class="form-control" maxlength="20" placeholder="이름" >
         <label id="label_userName"></label>
         <p class="check_font" id="name_check" style="color:#fd8505; font-size: 13px; margin-top: 0px"></p>
         <label for="userEmail" style="font-size: 20px; color:#554838;"><b>이메일</b></label>
         <input type="text" id="userEmail" name="userEmail" class="form-control" maxlength="20" placeholder="이메일" >
         <label id="label_userEmail"></label>
         <p class="check_font" id="email_check" style="color:#fd8505; font-size: 13px; margin-top: 0px"></p><br/>
         <div class="d-grid gap-2 col-12 mx-auto">
              <a id="findId" style="background-color: #FFCC80; color: #554838; font-size: 20px; text-align: center" class="cart-btn"><b>아이디 찾기</b></a>
              <a id="cancel" style="background-color: #FFCC80 ; color: #554838; font-size: 20px; text-align: center" class="cart-btn"><b>취소</b></a>
          </div>
      </form>
   </div>
</body>
</html>