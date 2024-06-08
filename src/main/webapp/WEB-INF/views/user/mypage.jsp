<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<link href="/resources/assets/bootstrap/css/style.css" rel="stylesheet" />
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Web App Design</title>
<script src="https://cdn.tailwindcss.com"></script>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
<style>
body{
  padding: 0;
  margin: 0;
}
div{
  box-sizing: border-box;
}

.tname{
	font-size: 20px;
	color: #554838;
}

/* alert badge */
.circle{
  display: inline-block;
  width: 5px;
  height: 5px;
  border-radius: 2.5px;
  background-color: #ff0000;
  position: absolute;
  top: -5px;
  left: 110%;
}

.green{
  color: #FFB74D;
}

.wrap{
  background-color: #F8F8F8;  
}
/* 녹색배경 */
.greenContainer{  
  height: 132px;
  background-color: #24855b;    
  
  display: flex;
  align-items: flex-end;
  padding: 16px;
}

.greenContainer .name{
   font-size: 20px;
  font-weight: bold;
  color: #ffffff;
} 
.greenContainer .modify{
  margin-left: auto;
}

.summaryContainer{
  background-color: white;  
  display: flex;  
  padding: 21px 16px;  
  height: 90px;
  margin-bottom: 10px;
}
.summaryContainer .item{
  flex-grow: 1
}
.summaryContainer .number{
  font-size: 19px;
  font-weight: bold;
  color: #24855b;
}
/* 텍스트 */
.summaryContainer .item > div:nth-child(2){
  font-size: 20px;
}

.shippingStatusContainer{
  padding: 21px 16px;
  background-color: white;
  margin-bottom: 10px;
}

.shippingStatusContainer .title{
  font-size: 16px;
  font-weight: bold;
  margin-bottom: 15px;
}

.shippingStatusContainer .status{
  display: flex;
  justify-content: space-between;
  margin-bottom: 21px;
}
.shippingStatusContainer .item{
  display: flex;
}

.shippingStatusContainer .number{
  font-size: 31px;
  font-weight: 500;
  text-align: center;
}
.shippingStatusContainer .text{
  font-size: 12px;
  font-weight: normal;
  color: #c2c2c2;
  text-align: center;
}
.shippingStatusContainer .icon{
  display: flex;
  align-items: center;
  padding: 20px;
  width: 16px;
  height: 16px;
}

.listContainer{  
  padding: 0;
  background-color: #ffffff;
  margin-bottom: 10px;
}
.listContainer .item{  
  display: flex;
  align-items: center;
  padding: 16px;
  color: black;
  text-decoration: none;  
  height: 56px;
  box-sizing: border-box;
}
.listContainer .icon{  
  margin-right: 14px;
}
.listContainer .text{
  font-size: 16px;
  position: relative;
}
.listContainer .right{
  margin-left: auto;
}

.listContainer .smallLight{
  font-size: 14px;
  color: #c2c2c2;  
}
.listContainer .smallLight > span{
  margin-left: 10px;
}

.listContainer .right .blct{
  font-size: 14px;
  font-weight: bold;
  margin-right: 5px;
}

.infoContainer{
  background-color: white; 
  display: flex;
  height: 100px;
  margin-bottom: 10px;    
}

.infoContainer .item{
  flex-grow: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;
  font-size: 13px;
  text-decoration: none;
  color: black;
}
.infoContainer .item > div:first-child{
  margin-bottom: 2px;
}



/*  */
.listContainer .item:hover{
/*   background-color: #f8f8f8; */
}
.infoContainer .item:hover{
/*   background-color: #f8f8f8; */
}
</style>
</head>
<body class="bg-white text-gray-800">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
    <!-- breadcrumb-section -->
	<div class="breadcrumb-section breadcrumb-bg" style="height:80px">
		<div class="container">
				<div class="row">
					<div class="col-lg-8 offset-lg-2 text-center">
						<div class="breadcrumb-text">
							<h1 id="font" style="color: #554838; font-size: 50px">마이페이지</h1>
						</div>
					</div>
				</div>
			</div>
		</div>
		<br>
		<div class="container" style="font-size: 20px; width: 750px"> 
	
		<div class="wrap" >
		  <div class="shippingStatusContainer" >
		    <div class="status">
		      <div class="item">
		        <div>
		          <div class="green number">6</div>
		          <div class="tname">나의 봉사활동</div>
		        </div>
		      </div>     
		      <div class="item">
		        <div>
		          <div class="number">0</div>
		          <div class="tname">나의 봉사후기</div>
		        </div>
		      </div>     
		      <div class="item">
		        <div>
		          <div class="green number">1</div>
		          <div class="tname">나의 후원내역</div>
		        </div>
		      </div>      
		    </div>
		  </div>  
		  <div class="listContainer">
			  <div class="item">
		        <div class="tname"><b>회원정보수정</b></div>
		        <div class="right"><a href="/user/infoUpdate"><b>></b></a></div>
			  </div>
			  <div class="item">
		        <div class="tname"><b>나의 봉사활동</b></div>
		        <div class="right"><a href="/user/myVolun"><b>></b></a></div>
		      </div>
			  <div class="item">
		        <div class="tname"><b>나의 봉사후기</b></div>
		        <div class="right"><a href="/user/myReview"><b>></b></a></div>
		      </div>
			  <div class="item">  
		        <div class="tname"><b>나의 후원내역</b></div>
		        <div class="right"><a href="/user/myDonate"><b>></b></a></div>
		      </div>
		  </div>
		</div>
    </div>
    
     <!-- footer -->
     <div class="footer-area">
      <div class="container">
         <div >
            <div class="col-lg-3 col-md-6" style="display: inline-block;">
               <div class="footer-box about-widget" style="width:700px;">
                  <h2 class="widget-title">Introduce</h2>
                  <p style="font-size:16px; "><b>맨발의 기봉이는 오늘도 누구보다 먼저 맨발 벗고 나섭니다. <br/><br/>
                  세상을 바꿀 수 있는 힘은 기봉이와 함께하는 후원자님과 <br/>
                  이를 통해 일어선 사람들의 삶의 변화로 부터 나옵니다.</b> <br/>

                  <b>맨발의 기봉이의  다양한 이벤트와 활동에 참여하여 여러분의 재능과 열정을 나눠주세요!</b></p>
               </div>
            </div>
            <div class="col-lg-3 col-md-6" style="display: inline-block; position: absolute;  right:  160px;">
               <div class="footer-box get-in-touch">
                  <h2 class="widget-title" >Contack</h2>
                  
                    <p style="font-size:15px; "> 
                     <b>쌍용교육센터-E강의실 맨발의 기봉이<br/><br/>
                     <img src="/resources/images/location.png" width="22px">서울특별시 마포구 월드컵북로21 풍성빌딩<br/>
                     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;쌍용강북교육센터</b><br/>
                     <img src="/resources/images/tel.png" width="22px"> Tel.02-336-8546~8 
                     <img src="/resources/images/fax.png" width="21px"> Fax.02-334-5405</p>
               </div>
            </div>
         </div>
      </div>
   </div>
   <!-- end footer -->
</body>
</html>

