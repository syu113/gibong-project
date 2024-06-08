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
			
		});
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
							<img style="width:100%;" src="/resources/assets/img/latest-news/sarang1.jpeg" />
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
								        <td>황해정</td>
								      </tr>
								      <tr>
								        <td>작성일자</td>
								        <td>2020-03-20</td>
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
							<h2>착한척을 통해 착해지는 방법</h2>
							<p>이번에 처음 봉사에 참여한 개인봉사자 두 분이 쌓던 연탄창고에 문제가 생겼다. 바닥이 평평하지 않은 상태에서 연탄개수를 잘 세기 위해 10장씩 한 줄 한 줄 위태위태한 탑을 쌓다보니 결국 몇 줄 못 쌓고 금방이라도 쓰러질 듯 흔들거리기 시작했다. 도와달라는 다급한 요청에 황급히 달려가서 넘어지려는 연탄 더미를 몸으로 막았다. 
							결국 떨어지는 연탄 한 장을 얼굴로 받았고 살짝 기스가 난 광대에는 피가 송글 맺혔다. 따끔했지만 다행이었다. 연탄이 깨지지는 않았다. 괜찮냐는 걱정스런 물음에 너털웃음을 지으며 ‘저는 이 바닥 구력이 좀 있어서 이 정도는 아무렇지도 않습니다. 연탄이 안 깨져서 다행이에요!’ 하고 또 착한 척을 해버렸다. 착한 척은 중독이다.</p>
							<p>얼마 전, 신문지상을 통해 한 기획기사(백종원의 골목식당 100회 인터뷰)를 보았다. 방송을 하면 어쩔 수 없이 착한 척, 남을 배려하는 척을 할 수밖에 없고 그런 모습을 사람들이 좋아하다 보니 생활에서도 척을 안 할 수 없어서 그게 삶이 되어버렸다는 내용이다. 지금껏 살면서 수많은 크고 작은 나쁜 짓을 저질러온 나 역시 최소한 착한 ‘척’이라도 하고 살아야지 하는 마음이 늘 간절했고, 그렇게 척하다보니 생활이 되었다. 
							백종원 씨가 내 변명을 대신 해준 셈이다. 그리고 연탄이 나의 척하는 생활에 참 좋은 매개가 되어주어 다행이다.</p>
							<p>종교가 예수를, 석가모니를, 마호메트를 닮기 위한 매개체라면, 나의 착한 ‘척’ 역시 비록 위선적일지라도 그들을 닮기 위한 하나의 방법일 수 있고, 
							또 누군가 역시 나의 척을 닮아주기를 바라게 되는 것이 자연스러운 선의 순환이 아닐까? 나는 오늘도 다음 달에 방문 예정인 유기견 쉼터에 대한 설렘과 또 한 번의 착한 척에 대한 기대감으로 가슴이 벅차오름을 느낀다</p>
						</div>
						
						<div class="comments-list-wrap">
						
						<div class="bbttnnw" style="text-align: right;">
						 <button type="button" id="btnUpdate">수정</button>
						 <button type="button" id="btnDelete">삭제</button>
						</div>
						
							<hr class="hr-8" style="border: 0; background-color: #fff; border-top: 2px dotted #8c8c8c;">
							
						<div class="comment-template"><br />
							<h4>댓글달기</h4>
							<form action="index.html">
								<p><textarea name="comment" id="comment" cols="30" rows="10" placeholder="댓글을 남겨보세요.">
								   </textarea> <button type="button" id="btnReply" style="float: right;">등록</button>
								   </p>
							</form>
							 
						</div>
						
							<div class="comment-list">
								<div class="single-comment-body">
									<br /><br />
									<p>
									<div class="comment-text-body">
										<h5>조민지 <span class="comment-date">2024.09.08 18:08</span> <a href="/board/replyProc">답글쓰기</a></h5>
										<p>주님께서 감사하다고 꿈에 나오겠는걸요?</p>
									</div>
									<div class="single-comment-body child">
										<div class="comment-user-avater">
										</div>
										<div class="comment-text-body">
											<h5>양희주 <span class="comment-date">2023.11.07 18:08</span> <a href="/board/replyProc">답글쓰기</a> 
																										 <a href="/board/replyDeleteProc">삭제</a></h5>
											<p>착한 척으로 착해지기라.. 쉽지 않군요</p>
										</div>
										</div>
									</div>
									
									<div class="single-comment-body">
										<div class="comment-user-avater">
										</div>
										<div class="comment-text-body">
											<h5>임승준 <span class="comment-date">2023.12.30 18:08</span> <a href="/board/replyProc">답글쓰기</a></h5>
											<p>유기견 봉사활동 흥미롭네요 !</p>
										</div>
									</div>
									</p>
								
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
</body>
</html>

