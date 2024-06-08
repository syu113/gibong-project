<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<link href="/resources/assets/bootstrap/css/style.css" rel="stylesheet" />
<link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600;700&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.1.2/dist/tailwind.min.css" rel="stylesheet">
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<style type="text/css">
  body {
    font-family: 'Open+Sans', sans-serif;
  }
</style>
<script>
$(document).ready(function() {
	
	$("#btnReply").on("click", function(){
		location.href = "/volun/volunView";
	});
});

</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<!-- breadcrumb-section -->
   <div class="breadcrumb-section breadcrumb-bg" style="height:80px">
      <div class="container">
         <div class="row">
            <div class="col-lg-8 offset-lg-2 text-center">
               <div class="breadcrumb-text">
                  <h1 id="font" style="color: #554838; font-size: 50px">봉사활동</h1>
               </div>
            </div>
         </div>
      </div>
   </div>
   <br/>
    <!-- Main Content -->
    <div class="container" >
      <div class="row">
          <div class="col-md-12">
              <div class="product-filters">
                  <ul>
                      <li class="active" data-filter="*">All</li>
                      <li data-filter=".">최신순</li>
                      <li data-filter=".">추천순</li>
                  </ul>
              </div>
          </div>
      </div>

<c:if test="${!empty list}">
	<c:forEach var="volun" items="${list}" varStatus="status">
      <div style="display: flex; justify-content: center;">
         <table class="table-auto " style="width:900px; justify-content: center;" >
           <tbody>
             <tr >
               <td class="align-center" style="width:300px; height:200px; margin-right:10px">
                 <img src="/resources/upload/basic.jpg" style="width:300px; height:170px;">
               </td>
               <td class="px-4" style="width:500px; height:200px; margin-right:10px">
                 <p style="font-size: 20px;" class="font-semibold">${volun.volunTitle}</p>
                 <p class="text-sm text-gray-600" style="font-size: 15px">모집기간 : ${volun.regdate} ~ ${volun.endDate}</p>
               </td>
               <td>
                 <button type="button" id="btnReply" style="float: right; margin-top:35px;">모집중</button>
               </td>
             </tr>
             
           </tbody>
         </table>
      </div>
     </c:forEach>
</c:if>

       <div class="row">
            <div class="col-lg-12 text-center">
               <div class="pagination-wrap">
                  <ul>
                     <li><a href="#">Prev</a></li>
                     <li><a href="#">1</a></li>
                     <li><a class="active" href="#">2</a></li>
                     <li><a href="#">3</a></li>
                     <li><a href="#">Next</a></li>
                  </ul>
               </div>
            </div>
         </div>
    </div>
    <br><br>
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
   
   <form id="volunForm" name="volunForm" method="post">
   		<input type="hidden" name="hiBbsSeq" value="" />
		<input type="hidden" name="searchType" value="" />
		<input type="hidden" name="searchValue" value="" />
		<input type="hidden" name="curPage" value="" />
   
   </form>
</body>
</html>
