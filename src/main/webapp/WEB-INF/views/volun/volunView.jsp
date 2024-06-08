<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<%@ include file="/WEB-INF/views/include/head.jsp" %>
	<style>
		#volunForm button[type="button"] {
		    /* background-color: #FFCC80; */
		    color: #051922;
		    font-weight: 700;
		    text-transform: uppercase;
		    font-size: 15px;
		    /* border: none !important; */
		    cursor: pointer;
		    /* padding: 15px 25px; */
		    /* border-radius: 3px;
		    }
	    element.style {
		    height: 900px;
		}
		table{
			border:0 white;
		}
		#btnTogether button{
			float: right;   
			background-color: #FFCC80;
			color: #051922;
			font-weight: 700;
			text-transform: uppercase;
			font-size: 15px;
			border: none !important;
			cursor: pointer;
			padding: 10px 15px;
			border-radius: 3px;"
		}
	</style>
	<script>
	
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
                  <h1 id="font" style="color: #554838; font-size: 50px">'사랑의 로켓배송'<br /> 도시락배달 봉사자 모집</h1>
               </div>
            </div>
         </div>
      </div>
   </div>
   <!-- end breadcrumb section -->
   
   <div class="container"><br />
   <div class="bbttnnw" style="text-align: right;">
		<button type="button" id="btnUpdate">수정</button>
		<button type="button" id="btnList">리스트</button>
		<button type="button" id="btnTogether" >신청하기</button>
   </div> 
      </div>
      
      <br>
      <form name="volunForm" id="volunForm" method="post" >
      <div class="form-join d-flex justify-content-center">
         <table style="width:550px; height: 170px">
            
            <tr>
            	<th><i class="bi bi-calendar"></i>&nbsp;모집 기간</th>
            	<td>SYSDATE - 2022.08.09</td>
            </tr>
            
            <tr>
               <th><i class="bi bi-bank"></i>&nbsp;봉사 대상</th>
               <td>&nbsp;방학로 사람들</td>
               <th>&nbsp;<i class="bi bi-pin-map"></i>&nbsp;봉사 장소</th>
               <td>서울시 도봉구 방학로 7길 90</td>
            </tr>
            
            <tr>
               <th><i class="bi bi-card-list"></i>&nbsp;봉사 분야</th>
               <td>&nbsp;생활편의지원</td>
               <th>&nbsp;<i class="bi bi-person"></i>&nbsp;모집 인원</th>
               <td>190 명</td>
            </tr>
            
            <tr>
               <th><i class="bi bi-card-list"></i>&nbsp;봉사 날짜</th>
               <td>&nbsp;2022.07.09</td>
               <th>&nbsp;<i class="bi bi-card-list"></i>&nbsp;봉사 시간</th>
               <td>5 시간</td>
            </tr>
            
         </table>
      </div><br />
      <div class="form-join d-flex justify-content-center" style="width:600px; border-bottom:1px solid black; margin: 0 auto;"></div><br />
      <div class="form-join d-flex justify-content-center">
         <table style="width:560px; height: 100px">
            <tr>
               <th><i class="bi bi-building"></i>&nbsp;봉사기관</th>
               <td>&nbsp;나눔의 집</td>
            </tr>
            
            <tr>
               <th><i class="bi bi-envelope"></i>&nbsp;이메일</th>
               <td>&nbsp;nanuja@naver.com</td>
               <th><i class="bi bi-telephone"></i>&nbsp;전화</th>
               <td>&nbsp;02-980-4669</td>
            </tr>
         </table>
      </div>
      </form>
	<!-- end breadcrumb section -->

	<!-- single article section -->
	<div class="mt-150 mb-150">
		<div class="container">
				<div class="col-lg-8" style="margin: 0 auto;">
					<div class="single-article-section" style="margin: 0 auto;">
						<div class="single-article-text">
							<div>
							<img style="width:100%;" src="/resources/assets/img/latest-news/sarang1.jpeg" />
							</div>
							 <div style = "padding: 5px 1px 7px 3px;"></div>
								<p>1. 일         정: 2023년 12월 ~ 2024년 2월 평일( 주말, 공휴일 제외)</p>
								<p>2. 활 동 시 간 : 10:00 ~ 13:00 내 2시간 활동 **봉사시간 2시간(또는 3시간) 인정****협의가능</p>
								<p>3. 모 집 유 형 : 성인 (개별 또는 단체 가능)</p>
								<p>4. 모 집 인 원 : 최소1명 / 최대 20명  </p>
								<p>5. 봉 사 내 용 : 중구 내 무료급식 수혜어르신 가정으로 도시락 배달 후 전날 어르신들이 식사하셨던 도시락 수거
								                    배달 장소는 당일 복지관 내에서 도시락 배달 담당자가 안내해드릴 예정임 ( 이동 방법: 도보 또는 대중교통 이용 가능 **교통비 지급X )
								                    봉사활동 전 복지관에서 자원봉사 신청서 및 활동일지 작성 안내 도와드릴 예정입니다.</p>
								<p>6. 집 합 장 소 : 약수노인종합복지관 2층 사무실 (서울시 중구 동호로 다산로 6길 11)</p>
								<p>7. 봉 사 장 소 : 중구 내 수혜어르신 가정</p>
								<p>8. 담 당 : 박혜미 사회복지사(070-5159-9415)</p>
								<p>9. 비 고
								- 어르신께 친절하게 안내 가능하신 분
								- 코로나 백신접종 여부 상관없이 봉사활동 신청가능
								- 활동 참여가 가능하신 분들만 신청해주시길 바랍니다. (당일 취소X)
								- 날씨가 추워 손이 시려울 수 있습니다. 손가락 장갑 착용 부탁드립니다!!
								</p>
						</div>
						
						<br />
						<div class="form-join d-flex justify-content-center" style="width:600px; border-bottom:1px solid black; margin: 0 auto;"></div><br />
						
						
						<div class="single-article-text">
							지도 api
						</div>
					</div>
				</div>
		</div>
	</div>
	<!— end single article section —>
</body>
</html>