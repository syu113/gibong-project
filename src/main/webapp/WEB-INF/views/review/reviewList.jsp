<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>	
<style type="text/css">
	.excerpt {
        display: block;
        font-size: 14px;
        font-weight: bolder !important;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: normal;
        line-height: 1.2;
/*        height: 4.8em;*/
        text-align: left;
        word-wrap: break-word;
        display: -webkit-box;
        -webkit-line-clamp: 3;
        -webkit-box-orient: vertical;
	}
	
	.img {
	    width:350px;
	    height:200px;
	    overflow:hidden;
	    margin:0 auto;
	}

	#author {
		font-size : 15px;
	}
	
	#date {
		font-size : 15px;
	}
	
	#title {
        display: block;
        font-weight: bolder !important;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: normal;
        line-height: 1.2;
/*        height: 4.8em;*/
        text-align: left;
        word-wrap: break-word;
        display: -webkit-box;
        -webkit-line-clamp: 1 ;
        -webkit-box-orient: vertical;
	}
	
	#news {
		width: 350px; height: 500px
	}
	
	.select {
  width: 150px;
  height: 30px;
  background: url('https://freepikpsd.com/media/2019/10/down-arrow-icon-png-7-Transparent-Images.png') calc(100% - 5px) center no-repeat;
  background-size: 20px;
  padding: 5px 30px 5px 10px;
  border-radius: 4px;
  outline: 0 none;
}
.select option {
  background: black;
  color: #fff;
  padding: 3px 0;
}

 .btn55{
  background-color: #bccc80;
  color: #051922;
  font-weight: 700;
  text-transform: uppercase;
  font-size: 15px;
  border: none !important;
  cursor: pointer;
  padding: 4px 20px;
  border-radius: 8px;
}
	
</style>
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js" ></script>
<script>
$(document).ready(function(){
	
	$("#btnSearch").on("click", function(){
		document.bbsForm.searchType.value = $("#searchType").val();
		document.bbsForm.searchValue.value = $("#searchValue").val();
		document.bbsForm.curPage.value = "1";
		document.bbsForm.action = "/review/reviewList";
		document.bbsForm.submit();
	});
	
	$("#btnWrite").on("click", function(){
		document.bbsForm.action = "/review/reviewWrite";
		document.bbsForm.submit();
	});
});


function fn_list(curPage)
{
	document.bbsForm.curPage.value = curPage;
	document.bbsForm.action = "/review/reviewList";
	document.bbsForm.submit();
}
function fn_view(reviewSeq)
{
	document.bbsForm.reviewSeq.value = reviewSeq;
	document.bbsForm.action = "/review/reviewView";
	document.bbsForm.submit();
}
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>	
	<!-- breadcrumb-section -->
	<div class="breadcrumb-section breadcrumb-bg" style="height:80px" >
		<div class="container">
			<div class="row">
				<div class="col-lg-8 offset-lg-2 text-center">
					<div class="breadcrumb-text">
						<h1 id="font" style="color: #554838; font-size: 50px">봉사후기</h1>
					</div>
				</div>
			</div>
		</div>
	</div><br />

	<div style="float:right;width:35%;">
	<select class="select" name="searchType" id="searchType">
		<option id="userName" value="1" <c:if test="${searchType eq '1'}">selected</c:if>>작성자</option>
		<option id="reviewTitle" value="2" <c:if test="${searchType eq '2'}">selected</c:if> >제목</option>
		<option id="reviewContent" value="3" <c:if test="${searchType eq '3'}">selected</c:if>>내용</option>
	</select>
	<input type="text" name="searchValue" id="searchValue" value="${searchValue}" />
	<input type="button" name="btnSearch" id="btnSearch" class="btn55" value="조회" />
	</div>
            
	<!-- end breadcrumb section -->
	<!-- latest news -->
	<div class="latest-news mt-150 mb-150" style="margin-top: 50px" >
		<div class="container">
			<div class="row">
                <div class="col-md-12">
                    <div class="product-filters">
                        <ul>
                            <li class="active" data-filter="*" onclick="" >최신순</li>
                            <li data-filter=".정기후원" onclick="" >조회순</li>
                            <li data-filter=".일시후원" onclick="" >추천순</li>
                        </ul>
<%
			if(com.gibong.web.util.CookieUtil.getCookie(request, (String)request.getAttribute("AUTH_COOKIE_NAME")) != null)
			{
%>
                        <button style="float: right;"type="button" id="btnWrite" name="btnWrite">글쓰기</button>
<%
			}
%>
                    </div>
                </div>
            </div>
            
			<div class="row">
<c:if test="${!empty list}">
	<c:forEach var="review" items="${list}" varStatus="status">
				<div class="col-lg-4 col-md-6">
					<div class="single-latest-news" id="news">
					<c:choose>
						<c:when test="${!empty review.fileName}">
						<div class="latest-news-bg" ><img class="img" src="/resources/upload/review/${review.fileName}" /></div>
						</c:when>
						<c:otherwise>
						<div class="latest-news-bg" ><img class="img" src="/resources/upload/basic.jpg"/></div>
						</c:otherwise>
					</c:choose>
						<div class="news-text-box">
							<h3 id="title"><a onclick="fn_view(${review.reviewSeq})">${review.reviewTitle}</a></h3>
							<p class="blog-meta">
								<span class="author" id="author"><i class="fas fa-user"></i>${review.userName}</span>
								<span class="date" id="date"><i class="fas fa-calendar"></i>${review.regdate}</span>
						 	</p>
							<p id="excerpt" class="excerpt" >${review.reviewContent}</p>
							<div>
								<div align="left" style="font-size: 16px">
									<i class="bi bi-suit-heart-fill"></i>&nbsp;${review.reviewReadCnt}&nbsp; 
									<i class="bi bi-chat-dots"></i>&nbsp;${review.replyCount}
								</div>
							</div>
							<a onclick="fn_view(${review.reviewSeq})" class="read-more-btn">자세히 <i class="fas fa-angle-right"></i></a>
						</div>
					</div>
				</div>
	</c:forEach>
</c:if>
		</div>

		<div class="row">
			<div class="container">
				<div class="row">
					<div class="col-lg-12 text-center">
						<div class="pagination-wrap">
						<c:if test="${!empty paging}">
							<ul>
							<c:if test="${paging.prevBlockPage gt 0}">
								<li><a onclick="fn_list(${paging.prevBlockPage})">이전</a></li>
							</c:if>
							
							<c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
								<c:choose>
									<c:when test="${i ne curPage}">
								<li ><a onclick="fn_list(${i})">${i}</a></li>
									</c:when>
									<c:otherwise>
								<li ><a class="active">${i}</a></li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							
							<c:if test="${paging.nextBlockPage gt 0}">
								<li><a onclick="fn_list(${paging.nextBlockPage})">다음</a></li>
							</c:if>
							</ul>
						</c:if>
						</div>
					</div>
				</div>
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
   
	
	<form name="bbsForm" id="bbsForm" method="post" >
		<input type="hidden" name="curPage" id="curPage" value="${curPage}" />
		<input type="hidden" name="searchType" id="searchType" value="${searchType}" />
		<input type="hidden" name="searchValue" id="searchValue" value="${searchValue}" />
		<input type="hidden" name="reviewSeq" id="reviewSeq" value="" />
	</form>
</body>
</html>