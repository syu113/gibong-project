<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<link href="/resources/assets/bootstrap/css/style.css" rel="stylesheet" />
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<style type="text/css">
.font {
	color: #554838;
	font-size: 20px;
}
</style>
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
	<br>
		<div style="width:100%" align="center" class="font"> 
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-2 control-label">
						<label id="flag"><b>회원구분</b></label>
					</div>
					<div class="col-sm-2" style="font-size: 20px">
						개인회원
					</div>
				</div>
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-2 control-label">
						<label><b>아이디</b></label>
					</div>
					<div class="col-sm-2"> 
						test
					</div>
				</div>
			         
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-2 control-label">
						<label id="name"><b>이름</b></label>
					</div>
					<div class="col-sm-2">
						홍길동
					</div>
				</div>        
			          
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-2 control-label">
						<label id="email"><b>이메일</b></label>
					</div>
					<div class="col-sm-2">
						tttt@test.co.kr
					</div>
				</div>   
			          
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-2 control-label">
						<label id="phone"><b>휴대전화</b></label>
					</div>
					<div class="col-sm-2">
						010-2222-2222
					</div>
				</div>
				
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-2 control-label">
						<label id="postcode"><b>우편번호</b></label>
					</div>
					<div class="col-sm-2">
						08516
					</div>
				</div>   
			   
				<div class="form-join d-flex justify-content-center" >
					<div class="col-sm-2 control-label">
						<label id="address"><b>주소</b></label>
					</div>
					<div class="">
						 서울시 강남구 역삼동
					</div>   
				</div>
			      
				<div class="form-join d-flex justify-content-center"> 
					<div class="col-sm-2 control-label">
						<label id="detailAddress"><b>상세주소</b></label>
					</div>
					<div class="col-sm-2"> 
						123
					</div>
				</div>
			    <br>      
				<input type="hidden" id="userId" name="userId" value="" /> 
				<div class="col-sm-12 text-center" >
					<button type="button" id="btnReg" class="btn btn-lg btn-success" onclick="location.href='/user/infoUpdate'" style="font-size: 20px">수정</button>&nbsp;&nbsp;
					<button type="button" id="btnReset" class="btn btn-lg btn-warning" onclick="" style="font-size: 20px">탈퇴</button>
				</div><br>
		</div>
	</div>
</body>
</html>

