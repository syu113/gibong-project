<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script>
function fn_list(curPage)
{
	document.bbsForm.curPage.value = curPage;
	document.bbsForm.action = "/donate/donateList";
	document.bbsForm.submit();
}
function fn_view(donateSeq)
{
	document.bbsForm.donateSeq.value = donateSeq;
	document.bbsForm.action = "/donate/donateView";
	document.bbsForm.submit();
}
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
   <!--PreLoader-->
    <div class="loader">
        <div class="loader-inner">
            <div class="circle"></div>
        </div>
    </div>
    <!--PreLoader Ends-->
   

   <!-- search area -->
   <div class="search-area">
      <div class="container">
         <div class="row">
            <div class="col-lg-12">
               <span class="close-btn"><i class="fas fa-window-close"></i></span>
               <div class="search-bar">
                  <div class="search-bar-tablecell">
                     <h3>Search For:</h3>
                     <input type="text" placeholder="Keywords">
                     <button type="submit">Search <i class="fas fa-search"></i></button>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>
   <!-- end search arewa -->
   
   <!-- breadcrumb-section -->
   <div class="breadcrumb-section breadcrumb-bg">
      <div class="container">
         <div class="row">
            <div class="col-lg-8 offset-lg-2 text-center">
               <div class="breadcrumb-text">
                  <h1>후원</h1>
               </div>
            </div>
         </div>
      </div>
   </div>
   <!-- end breadcrumb section -->

   <!-- products -->
   <div class="product-section mt-150 mb-150">
      <div class="container">

         <div class="row">
                <div class="col-md-12">
                    <div class="product-filters">
                        <ul>
                            <li class="active" data-filter="*">All</li>
                            <li data-filter=".정기후원">정기후원</li>
                            <li data-filter=".일시후원">일시후원</li>
                        </ul>
                    </div>
                </div>
            </div>

         <div class="row product-lists">
<c:if test="${!empty list}">
	<c:forEach var="donate" items="${list}" varStatus="status">
            <div class="col-lg-4 col-md-6 text-center 일시후원">
               <div class="single-product-item">
                  <div class="product-image">
                  <c:choose>
						<c:when test="${!empty donate.fileName}">
                     	<img src="/resources/upload/donate/${donate.fileName}" alt="">
                    	</c:when>
                  		<c:otherwise>
                  		<img src="/resources/upload/basic.jpg" alt="">
                  		</c:otherwise>
                  </c:choose>
                  </div>
                  <h3>${donate.donateTitle}</h3>
                  <p class="product-price" align="center"><span>${donate.donateContent}</span></p>
                  <div class="progress">
				  	  <div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" aria-valuenow="" aria-valuemin="0" aria-valuemax="100" 
				  	  	style="width:${donate.progress}%"></div>
				  </div>
				  <br/><span>후원금액 </span><br />
				  <span>현재모금액/목표액 : <fmt:formatNumber value="${donate.donateNowAmt}" pattern="#,##0" />원 / 
				  <fmt:formatNumber value="${donate.donateGoalAmt}" pattern="#,##0" />원</span><br />
				  <span>후원기간 ${donate.regdate} ~ ${donate.closeDate} </span><br /><br />
				<a onclick="fn_view(${donate.donateSeq})" class="cart-btn"><span class="material-symbols-outlined">volunteer_activism</span>후원하러 가기</a>
               </div>
            </div>
      </c:forEach>
</c:if>            

<c:if test="${!empty cookieUserId}">
            <div class="col-lg-4 col-md-6 text-center ">
               <div class="single-product-item">
                  <div class="product-image">
                  <br/><br/><br/>
                    <a href="/donate/donateWrite" ><img src="/resources/assets/img/products/20.jpg" alt=""></a><br/>
                    <h3>후원모금을 시작해보세요.</h3><br /><br /><br/><br/><br/><br />
                  </div>
               </div>
            </div>
</c:if>
         </div>

         <div class="row">
            <div class="col-lg-12 text-center">
               <div class="pagination-wrap">
<c:if test="${!empty paging}">
                  <ul>
           <c:if test="${paging.prevBlockPage gt 0}">
                     <li><a href="${paging.prevBlockPage}">이전</a></li>
           </c:if>
           
        		<c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
					<c:choose>
						<c:when test="${i ne curPage}">
                     	<li><a onclick="fn_list(${i})">${i}</a></li>
                   		 </c:when>
                    <c:otherwise>
                     <li><a class="active">${i}</a></li>
                    </c:otherwise>
                </c:choose>
               </c:forEach>
                
                    <c:if test="${paging.nextBlockPage gt 0}">
                     <li><a href="#">Next</a></li>
                    </c:if>
                  </ul>
</c:if>
               </div>
            </div>
         </div>
      </div>
   </div>
   <!-- end products -->
   
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
   
   
   
   <form name="bbsForm" id="bbsForm" method="post" >
		<input type="hidden" name="curPage" id="curPage" value="${curPage}" />
		<input type="hidden" name="donateSeq" id="donateSeq" value="" />
	</form>


   
</body>
</html>