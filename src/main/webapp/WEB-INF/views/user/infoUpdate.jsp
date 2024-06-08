<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<link href="/resources/assets/bootstrap/css/style.css" rel="stylesheet" />
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<style type="text/css">
label{
	font-size: 20px; width:500px; color: #554838;
}

.mar{
	margin-left: 50px; font-size: 20px;
}
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
	
	$("#btnReg").on("click", function(){
		
		$("#userPwd").val($("#userPwd1").val());
		
		var form = $("#updateForm")[0]
	    var formData = new FormData(form);
		
		
		$.ajax({
			type:"POST",
			url:"/user/updateProc",
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
	  				alert("회원 정보가 수정되었습니다.");
	  				location.href = "/user/mypage";
	  			}
	      		else if(response.code == 400)
	  			{
	  				alert("파라미터 값이 올바르지 않습니다.");
	  				$("#userPwd1").focus();
	  			}
	      		else if(response.code == 404)
	  			{
	      			alert("회원정보가 존재하지 않습니다.");
	  				location.href = "/";
	  			}
	      		else if(response.code == 410)
	  			{
	  				alert("로그인을 먼저 하세요.");
	  				location.href = "/";
	  			}
	      		else if(response.code == 430)
	  			{
	  				alert("아이디 정보가 다릅니다.");
	  				location.href = "/";
	  			}
	      		else if(response.code == 500)
	  			{
	  				alert("회원정보 수정 중 오류가 발생하였습니다.");
	  				$("#userPwd1").focus();
	  			}
	      		else
	  			{
	  				alert("회원정보 수정 중 오류발생.");
	  				$("#userPwd1").focus();
	  			}
	      		
	      	},
	      	error:function(xhr, status, error)
	      	{
	      		icia.common.error(error);
	      	}
		
	  });

	});
	
	$("#btnDelete").on("click", function(){
		$.ajax({
			type:"POST",
			url:"/user/deleteProc",		
			data:{
				userId:$("#userId").val()
			},
			datatype:"JSON",
			success:function(response){
				if(!icia.common.isEmpty(response))			
				{
					icia.common.log(response);
					
					var code = icia.common.objectValue(response, "code", -500);	
					
					if(code == 0)
					{
						alert("회원탈퇴에 성공하였습니다.");
						location.href = "/";
					}
					else
					{
						if(code == 400)
						{
							alert("값이 올바르지 않습니다.");
						}
						else if(code == 404)
						{
							alert("오류 발생1")
						}
						else
						{
							alert("오류가 발생하였습니다.");
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
	});
});

function fn_validateEmail(value)
{
   var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
   
   return emailReg.test(value);
}
</script>
</head>
<body class="d-flex flex-column min-vh-100">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
   <div class="breadcrumb-section breadcrumb-bg" style="height:80px">
      <div class="container">
         <div class="row">
            <div class="col-lg-8 offset-lg-2 text-center">
               <div class="breadcrumb-text">
                  <h1 id="font" style="color: #554838; font-size: 50px">회원정보수정</h1>
               </div>
            </div>
         </div>
      </div>
   </div>
	<div class="container"> 
		<div class="form-join"> 
			<form id="updateForm" name="updateForm" action="/user/userProc.jsp" method="post"> 
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-1 control-label">
						<label id="flag" style="font-size: 20px; width:500px"><b>회원구분</b></label>
					</div>
					<div class="col-sm-4 mar">
						개인회원
					</div>
				</div>
			
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-1 control-label">
						<label style="font-size: 20px; width:500px"><b>아이디</b></label>
					</div>
					<div class="col-sm-4 mar"> 
						${user.userId}
					</div>
				</div>
			          
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-1 control-label">
						<label id="pwd"><b>비밀번호</b></label>
					</div>
					<div class="col-sm-4 mar">
						<input type="password" class="form-control" name="userPwd1" id="userPwd1" placeholder="4 ~ 20자의 영문, 숫자와 특수문자만 사용가능" 
								value="${user.userPwd}" style="font-size: 20px;">
						<label id="label_userPwd1"></label> 
					</div>
				</div>
			          
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-1 control-label">
						<label id="pwdCheck"><b>비밀번호확인</b></label>
					</div>
					<div class="col-sm-4 mar">
						<input type="password" class="form-control" name="userPwd2" id="userPwd2" style="font-size: 20px;" value="${user.userPwd}">
						<label id="label_userPwd2"></label> 
					</div>
				</div>
			         
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-1 control-label">
						<label id="name"><b>이름</b></label>
					</div>
					<div class="col-sm-4 mar">
						<input type="text" class="form-control" name="userName" id="userName" value="${user.userName}" style="font-size: 20px;" >
						<label id="label_userName"></label> 
					</div>
				</div>        
			          
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-1 control-label">
						<label id="email"><b>이메일</b></label>
					</div>
					<div class="col-sm-4 mar">
						<input type="email" class="form-control" name="userEmail" id="userEmail" value="${user.userEmail}" style="font-size: 20px;" >
						<label id="label_userEmail"></label> 
					</div>
				</div>   
			          
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-1 control-label">
						<label id="phone"><b>휴대전화</b></label>
					</div>
					<div class="col-sm-4 mar">
						<input type="text" class="form-control" name="userPhone" id="userPhone" value="${user.userPhone}" style="font-size: 20px;" >
						<label id="label_userPhone"></label> 
					</div>
				</div>
				
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-1 control-label">
						<label id="postcode"><b>우편번호</b></label>
					</div>
					<div class="col-sm-3 mar">
						<input type="text" id="zipcode" name="zipcode" class="form-control" value="${user.userZipcode}" style="font-size: 20px;">
						<label id="label_zipcode"></label> 
					</div>
					<div class="col-sm-1-1">
						<input type="button" onclick="execDaumPostcode();" value="검색" class="btn" style="background-color:#FFB74D;font-size: 20px;">
					</div>
				</div>   
			   
				<div class="form-join d-flex justify-content-center" >
					<div class="col-sm-1 control-label">
						<label id="address"><b>주소</b></label>
					</div>
					<div class="col-sm-4 mar">
						<input type="text" id="addr1" name="addr1" class="form-control" value="${user.userAddr1}" style="font-size: 20px;">
						<label id="label_addr1"></label>
					</div>   
				</div>
			      
				<div class="form-join d-flex justify-content-center"> 
					<div class="col-sm-1 control-label">
						<label id="detailAddress"><b>상세주소</b></label>
					</div>
					<div class="col-sm-4 mar"> 
						<input type="text" id="addr2" name="addr2" class="form-control" value="${user.userAddr2}" style="font-size: 20px;"> 
						<label id="label_addr2"></label>
					</div>
				</div>
			    <br>    
				<input type="hidden" id="userId" name="userId" value="${user.userId}" />
				<input type="hidden" id="userPwd" name="userPwd" value=""> 
				<div class="col-sm-12 text-center" >
					<button type="button" id="btnReg" class="btn btn-lg" onclick="" style="font-size: 20px;">수정</button>&nbsp;&nbsp;&nbsp;
					<button type="button" id="btnReset" class="btn btn-lg" onclick="" style="font-size: 20px;">취소</button>
					
					<button type="button" id="btnDelete" class="btn btn-lg" style="float: right;" onclick="" style="font-size: 20px; ">탈퇴</button>
				</div>
			</form>  
		</div>
	</div>
</body>
</html>

