<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<style>
input[type="submit"] {
  -webkit-transition: 0.3s;
  -o-transition: 0.3s;
  transition: 0.3s;
  border-radius: 50px !important;
  background-color:#f4a0a0;
  color:#fff;
}
input[type="submit"]:hover {
  background-color: #ff6e6e;
  color: #fff;
}
.breadcrumb-text p {
  font-size: 20px;
}
</style>
<script>
function fn_huwon(i)
{
	if(i == 1)
	{
		var box = document.getElementById("box");
		box.style.color = "black";
		
		var box2 = document.getElementById("box2");
		box2.style.color = "white";
	}
	else
	{
		var box = document.getElementById("box");
		box.style.color = "white";
		
		var box2 = document.getElementById("box2");
		box2.style.color = "black";
	}
}
function fn_price(i)
{
	document.donateForm.price.value = i;
	
	if(i == 20000)
	{
		var pricebox1 = document.getElementById("pricebox1");
		pricebox1.style.color = "black";
		
		var pricebox2 = document.getElementById("pricebox2");
		pricebox2.style.color = "white";
		
		var pricebox3 = document.getElementById("pricebox3");
		pricebox3.style.color = "white";
	}
	else if(i == 30000)
	{
		var pricebox1 = document.getElementById("pricebox1");
		pricebox1.style.color = "white";
		
		var pricebox2 = document.getElementById("pricebox2");
		pricebox2.style.color = "black";
		
		var pricebox3 = document.getElementById("pricebox3");
		pricebox3.style.color = "white";
	}
	else
	{
		var pricebox1 = document.getElementById("pricebox1");
		pricebox1.style.color = "white";
		
		var pricebox2 = document.getElementById("pricebox2");
		pricebox2.style.color = "white";
		
		var pricebox3 = document.getElementById("pricebox3");
		pricebox3.style.color = "black";
	}
}

$(document).ready(function(){
	$("#donate").on("click", function(){
		if($.trim($("#cookieUserId").val()).length > 0)
		{
			document.donateForm.action = "/donate/donatePay";
			document.donateForm.submit();
		}
		else
		{
			alert("후원은 로그인 후 이용가능합니다.");
		}
	});
	
	
});
</script>
</head>
<body>
   <%@ include file="/WEB-INF/views/include/navigation.jsp" %>
   
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
                  <p>지금,00이의 후원자가 되어주세요</p>
                  <h1>후원하기</h1>
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
             		<c:choose>
             			<c:when test="${!empty donate.fileName}">
                     		<div class="single-artcile-bg"><img src="/resources/upload/donate/${donate.fileName}" width="600px" height="450px"></div>
                     	</c:when>
                   		<c:otherwise>
                     		<div class="single-artcile-bg"><img src="/resources/upload/basic.jpg" width="600px" height="450px"></div>
                   		</c:otherwise>
                   	</c:choose>
                     	
                    <p class="blog-meta">
                       <span class="date"><i class="fas fa-calendar"></i>${donate.regdate} ~ ${donate.closeDate}</span>
                    </p>
                    <h2>${donate.donateTitle}</h2>
                    <p>${donate.donateContent}</p>
                 </div>

              </div>
            </div>

   <!-- 기봉 후원 금액 버튼 html 시작-->
            <div class="col-lg-4">
               <div class="sidebar-section"><br/>
                  <div class="cart-buttons">
                        <a onclick="fn_huwon(1)" id="box" class="boxed-btn4" ><b>정기후원</b></a>
                        <a onclick="fn_huwon(2)" id="box2" class="boxed-btn4"><b>일시후원</b></a>
                  </div>
                  <div class="vote_tab_contbx">
                     <ul class="no_dot" >
                        <li class="step1 active"><!-- 최소 정기후원금액 20,000원 이하로 등록시 팝업노출 (하단에 숨김처리되어있습니다.) -->
                          <form id="donateForm" name="donateForm" method="post">
                           <input type="hidden" id="cookieUserId" name="cookieUserId" value="${cookieUserId}">
                           <input type="hidden" style="display:none;" name="price" id="price" value=""><!--밑에 선택하는 대로 value값 설정 -->
                           <input type="hidden" id="donateSeq" name="donateSeq" value="${donate.donateSeq}" >
                           <h5>후원금 선택</h5>
                           <div class="price-buttons">
                          	  <a onclick="fn_price(20000)" id="pricebox1" class="boxed-btn3" style="color: #fff;">20000</a>
                          	  <a onclick="fn_price(30000)" id="pricebox2" class="boxed-btn3" style="color: #fff;">30000</a>
                              <a onclick="fn_price(50000)" id="pricebox3" class="boxed-btn3" style="color: #fff;">50000</a>
                           </div>
                           <br/>
                           <p>
                              <input type="text" id="priceSelf" name="priceSelf" placeholder="후원금액 직접입력" style="width:85%">
                           </p>
                           <br/>
                              <input type="submit" id="donate" name="donate" value="후원하기" style="width:85%" >
                           <br/><br/>
                           <p style="width:87%"><img src="/resources/images/free-icon-padlock-159069.png" width="15"> 후원을 위해 제공해주신 개인정보는 맨발의기봉이의 <a href="/privacy-policy/" class="color" target="_blank">개인정보처리방침</a>에 따라 안전하게 보호됩니다.</p>
                           </form>
                        </li>
                     </ul>
                  </div>
               </div>
            </div>
   <!-- 기봉 후원 금액 버튼 html 끝 -->
         </div>
      </div>
   </div>
   <!-- end single article section -->
   <br/><br/>

</body>
</html>