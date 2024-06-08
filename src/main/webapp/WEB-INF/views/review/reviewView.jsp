<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<style>
	table {
	  border-collapse: collapse;
	  width: 100%;
	  background-color: white;
	}
	
	thead{
	  box-shadow: 4px 4px 10px rgba(0,0,0,0.1);
	}
	
	/* 테이블 행 */
	td {
	  padding: 5px;
	  text-align: left;
	  border-bottom: 1px solid #ddd;
	  text-align: center;
	}
	
	th {
		padding: 7px;
	}
	
	/* 테이블 비율 */
	th:nth-child(1),
	td:nth-child(1) {
	  width:20%;
	}
	
	th:nth-child(2),
	td:nth-child(2) {
	  width: 40%;
	}
	
	th:nth-child(3),
	td:nth-child(3) {
	  width: 90%;
	}
	
	th, td {
	  border-left: none;
	  border-right: none;
	}
	
	textarea, button {
		vertical-align: middle;
	}
</style>
<script type="text/javascript">
$(document).ready(function(){
	
	$("#btnUpdate").on("click", function(){
		document.bbsForm.action = "/review/reviewUpdate";
		document.bbsForm.submit();
	});
	
	$("#btnDelete").on("click", function(){
		if(confirm("게시글을 정말 삭제하시겠습니까?") == true)
		{
			$.ajax({
				type:"POST",
				url:"/review/reviewDeleteProc",		
				data:{
					reviewSeq:$("#reviewSeq").val()
				},
				datatype:"JSON",
				success:function(response)
				{
					if(response.code == 0)
					{
						alert("게시글을 삭제하였습니다.");
						document.reviewForm.action = "/review/reviewList";
						document.reviewForm.submit();
					}
					else if(response.code == 400)
					{
						alert("댓글 등록 중 오류가 발생");	
					}
					else if(response.code == 404)
					{
						alert("값이 올바르지 않습니다.");	
					}
					else
					{
						alert("오류 발생");	
					}
				},	
				error:function(xhr, status, error)
				{
					icia.common.error(error);
				}
			});		
		}
	});
	
	
	$("#btnReply").on("click", function(){
		$.ajax({
		type:"POST",
		url:"/review/replyProc",		
		data:{
			comment:$("#comment").val(),
			reviewSeq:$("#reviewSeq").val()
		},
		datatype:"JSON",
		success:function(response)
		{
			if(response.code == 0)
			{
				alert("댓글을 등록하였습니다.");
				document.reviewForm.action = "/review/reviewView";
				document.reviewForm.submit();
			}
			else if(response.code == 400)
			{
				alert("댓글 등록 중 오류가 발생");	
			}
			else if(response.code == 404)
			{
				alert("값이 올바르지 않습니다.");	
			}
			else
			{
				alert("오류 발생");	
			}
		},	
		error:function(xhr, status, error)
		{
			icia.common.error(error);
		}
		});
	});
	
	

	$("#btnReply2").on("click", function(){
		$.ajax({
			type:"POST",
			url:"/review/replyProc2",		
			data:{
				comment2:$("#comment2").val(),
				reviewSeq:$("#reviewSeq2").val(),
				replySeq:$("#replySeq2").val()
			},
			datatype:"JSON",
			success:function(response)
			{
				if(response.code == 0)
				{
					alert("댓글을 등록하였습니다.");
					document.reviewForm.action = "/review/reviewView";
					document.reviewForm.submit();
				}
				else if(response.code == 404)
				{
					alert("댓글 등록 중 오류가 발생");	
				}
				else if(response.code == 404)
				{
					alert("값이 올바르지 않습니다.");	
				}
				else
				{
					alert("오류 발생");	
				}
			},	
			error:function(xhr, status, error)
			{
				icia.common.error(error);
			}
		});
	});
	
	$("#btnList").on("click", function(){
		location.href = "/review/reviewList";
	});
});
	
function fnReply2(i) 
{
    var replyFormContainer = $("#replyFormContainer" + i);
    if (replyFormContainer.is(":visible")) 
    {
        replyFormContainer.hide(); // 보이는 상태면 숨김
    } 
    else 
    {
        replyFormContainer.show(); // 숨겨진 상태면 보임
    }
}
function fnDelete2(i) 
{	
	if(confirm("정말로 삭제하시겠습니까?") == true)
	{
		$.ajax({
			type:"POST",
			url:"/review/deleteProc",		
			data:{
				replySeq:$("#replySeq2").val()
			},
			datatype:"JSON",
			success:function(response)
			{
				if(response.code == 0)
				{
					alert("댓글을 삭제하였습니다.");
					document.reviewForm.action = "/review/reviewView";
					document.reviewForm.submit();
				}
				else if(response.code == 500)
				{
					alert("댓글 삭제 중 오류가 발생");	
				}
				else if(response.code == 400)
				{
					alert("값이 올바르지 않습니다.");	
				}
				else
				{
					alert("오류 발생");	
				}
			},	
			error:function(xhr, status, error)
			{
				icia.common.error(error);
			}
		});
	}
}
	
</script>
</head>
<body>
	
	<!--PreLoader-->
    <div class="loader">
        <div class="loader-inner">
            <div class="circle"></div>
        </div>
    </div>
    <!--PreLoader Ends-->
    
	<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
	<!-- breadcrumb-section -->
	<div class="breadcrumb-section breadcrumb-bg">
		<div class="container">
			<div class="row">
				<div class="col-lg-8 offset-lg-2 text-center">
					<div class="breadcrumb-text">
						<p>(성인 | 청소년)</p>
						<h1>사랑의 연탄 나눔 운동</h1>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- end breadcrumb section -->
	
	<!-- single article section -->
	<div class="mt-150 mb-150">
		<div class="container">
			<div class="row">
				<div class="col-lg-8">
					<div class="single-article-section">
						<div class="single-article-text">
							<div>
							<c:choose>
							<c:when test="${!empty review.fileName}">
								<img style="width:100%;" src="/resources/upload/review/${review.fileName}" width="600px" height="500px"/><br/><br/>
							</c:when>
							<c:otherwise>
								<img style="width:100%;" src="/resources/upload/basic.jpg" width="600px" height="500px"/><br/><br/>
							</c:otherwise>
							</c:choose>
							</div>
								 <table>
								    <thead>
								      <tr>
								        <th><i class="fas fa-calendar"></i> 봉사활동 내역</th>
								      </tr>
								    </thead>
								    <tbody>
								      <tr>
								        <td>글쓴이</td>
								        <td>${review.userId}</td>
								      </tr>
								      <tr>
								        <td>작성일자</td>
								        <td>${review.regdate}</td>
								      </tr>
								      <tr>
								        <td>봉사분야</td>
								        <td>생활편의지원</td>
								      </tr>
								      <tr>
								        <td>모집기관</td>
								        <td>사랑의 집</td>
								      </tr>
								    </tbody>
								  </table>
							 <div style = "padding: 5px 1px 7px 3px;"></div>
							<h2>${review.reviewTitle}</h2>
							<pre>${review.reviewContent}</pre>
						</div>
						
						<div class="comments-list-wrap">
						<div class="bbttnnw" style="text-align: right;">
				
<c:if test="${cookieUserId eq review.userId}">
						 <button type="button" id="btnUpdate" name="btnUpdate">수정</button>
						 <button type="button" id="btnDelete" name="btnDelete">삭제</button>
						 <button type="button" id="btnList" name="btnList">리스트</button>
</c:if>
						</div>
			
							<hr class="hr-8" style="border: 0; background-color: #fff; border-top: 2px dotted #8c8c8c;">
							
						<div class="comment-template"><br />
							<h4>댓글달기</h4>
							<form id="reviewForm" name="reviewForm" action="">
								<p><textarea name="comment" id="comment" cols="30" rows="10" placeholder="댓글을 남겨보세요.">
								   </textarea> 
								   <button type="button" id="btnReply" name="btnReply" style="float: right;">등록</button>
								   </p>
							   <input type="hidden" id="reviewSeq" name="reviewSeq" value="${reviewSeq}" />
							</form>
							 
						</div>
						
						
							<div class="comment-list">
								<div class="single-comment-body">
									<br /><br />
									<p>

<c:if test="${!empty list}">
	<c:forEach var="review" items="${list}" varStatus="status">
		<c:if test="${review.replyDelFlag eq 'N'}">
			<form id="replyForm" name="replyForm" >
						<div class="comment-text-body" style="margin-left:${review.reviewReplyIndent}em" ><h5>
							<c:if test="${review.reviewReplyIndent gt 0}" >
									<img src="/resources/images/icon_reply.gif" style="width:20px; height:20px;" />
							</c:if>
									${review.userName} 
									<span class="comment-date">${review.regdate}</span> 
										<a href="javascript:void(0);" onclick="fnReply2(${review.reviewReplySeq});">답글쓰기</a>
							<c:if test="${cookieUserId eq review.userId}">
										<a href="javascript:void(0);" onclick="fnDelete2(${review.reviewReplySeq});">삭제</a></h5>
							</c:if>
										<p>${review.reviewReplyContent}</p>
									</div>
						</c:if>
						
						
						<div class="comment-template" id="replyFormContainer${review.reviewReplySeq}" style="display: none;">
                        <form id="replyForm2" name="replyForm2" method="POST" >
                        <div>
                           <input type="hidden" id="reviewSeq2" name="reviewSeq2" value="${reviewSeq}" />
                           <input type="hidden" id="replySeq2" name="replySeq2" value="${review.reviewReplySeq}" />
                           <textarea name="comment2" id="comment2" cols="10" rows="10" placeholder="댓글을 남겨보세요." style="height: 100px"></textarea>
                           <button type="button" id="btnReply2" name="btnReply2" style="float: right; margin-top:35px;">등록</button>
                        </div>   
                        </form>
                        <br/>
                        </div>		
									
						
			</form>
	</c:forEach>
</c:if>

							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-4">
					<div class="sidebar-section">
						<div class="recent-posts">
							<h4>최근 게시물</h4>
							<ul>
								<li><a href="single-news.html">유기견 봉사활동</a></li>
								<li><a href="single-news.html">무료 급식 봉사활동</a></li>
								<li><a href="single-news.html">장애아동 학습 봉사활동</a></li>
								<li><a href="single-news.html">연탄 나눔 봉사활동</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- end single article section -->
	
	
	
	<form name="bbsForm" id="bbsForm" method="post">
		<input type="hidden" name="reviewSeq" value="${reviewSeq}" />
	</form>
</body>
</html>

