<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<link href="/resources/assets/bootstrap/css/style.css" rel="stylesheet" />
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<style>
   .form-signin {
     max-width: 700px;
     padding: 200px;
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
$(document).ready(function() {
	$("#userId").focus();
	
	/*
	$("#userId").on("keypress", function(e){
		if(e.which == 13)
		{
			fn_loginCheck();
		}
	});
	
	$("#userPwd").on("keypress", function(e){
		if(e.which == 13)
		{
			fn_loginCheck();
		}
	});
	*/
	
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
	});
	
	$("#userPwd").focusout(function(){
		if($.trim($("#userPwd").val()).length <= 0)
		{
			$("#label_userPwd").css("color", "red").text("비밀번호를 입력하세요.");
			$("#userPwd").val("");
			return;
		}
		else
		{
			$("#label_userPwd").css("color", "black").text("");
			
			$("#btnLogin").on("click", function(){
				fn_loginCheck();
			});
		}
	});
	
	
	$("#btnReg").on("click", function(){
		location.href = "/user/join";
	});
});

function fn_loginCheck()
{
	$.ajax({
		type:"POST",
		url:"/user/loginProc",		
		data:{
			userId:$("#userId").val(),
			userPwd:$("#userPwd").val()
		},
		datatype:"JSON",
		success:function(response){
			if(!icia.common.isEmpty(response))			
			{
				icia.common.log(response);
				
				var code = icia.common.objectValue(response, "code", -500);	
				
				if(code == 0)
				{
					alert("로그인 성공");
					document.loginForm.action = "/";
					document.loginForm.submit();
				}
				else
				{
					if(code == -1)
					{
						alert("아이디 또는 비밀번호가 올바르지 않습니다.");
						$("userPwd").focus();
					}
					else if(code == -99)
					{
						alert("탈퇴된 사용자입니다.");
						$("#userId").focus();
					}
					else if(code == 400)
					{
						alert("파라미터 값이 올바르지 않습니다.");
						$("#userId").focus();
					}
					else
					{
						alert("오류가 발생하였습니다.");
						$("#userId").focus();
					}
				}
			}
			else
			{
				alert("오류가 발생하였습니다.");
				$("#userId").focus();
			}
		},	
		complete:function(data)
		{
			icia.common.log(data);
		},
		error:function(xhr, status, error)
		{
			icia.common.error(error);
		}
	});
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
                  <h1 id="font" style="color: #554838; font-size: 50px">로그인</h1>
               </div>
            </div>
         </div>
      </div>
   </div>
   <div class="container" style="padding-top: 10px; margin-top: 10px">
      <form name="loginForm" id="loginForm" method="post"  class="form-signin" style="padding-top: 10px; margin-top: 10px">
         <!--  <br/>
          <h2 class="form-signin-heading m-b3" align="center" style="color:#554838"><b>로그인</b></h2><br/>-->
         <label for="userId" class="sr-only">아이디</label>
         <input type="text" id="userId" name="userId" class="form-control" maxlength="20" placeholder="아이디"><br/>
         <label id="label_userId"></label>
         <label for="userPwd" class="sr-only">비밀번호</label>
         <input type="password" id="userPwd" name="userPwd" class="form-control" maxlength="20" placeholder="비밀번호"><br/>
         <label id="label_userPwd"></label>
         <div align="center" class="">
              <a class="" id="find" style="font-size: 16px; text-decoration: none; color: #554838" onclick="location.href='/user/findId'">아이디 찾기</a>
              <span style="color: #554838; font-size: 16px;">/</span>
              <a class="" id="find" style="font-size: 16px; text-decoration: none; color: #554838" onclick="location.href='/user/findPwd'">비밀번호 찾기</a>
           </div><br/>  
           <div class="d-grid gap-2 col-12 mx-auto">
              <a style="background-color: #FFCC80; color: #554838; font-size: 20px; text-align: center" class="cart-btn" id="btnLogin" name="btnLogin"><b>로그인</b></a>
              <a href="/user/join" style="background-color: #FFCC80 ; color: #554838; font-size: 20px; text-align: center" class="cart-btn"><b>회원가입</b></a>
          </div>
      </form>
   </div>
</body>
</html>