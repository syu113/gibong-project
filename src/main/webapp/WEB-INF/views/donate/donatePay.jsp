<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<style>
.breadcrumb-text p {
  font-size: 20px;
}
a.boxed-btn4 {
  font-family: 'Poppins', sans-serif;
  display: inline-block;
  background-color: #FFCC80 ;
  color: #fff;
  padding: 10px 20px;

}
.center-align{
	align:center;
}

</style>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script>
$(document).ready(function(){
	
	$("#kakaoPay").on("click", function(){
		
		var form = $("#payForm")[0]
	    var formData = new FormData(form);
	
	
		$.ajax({
			type:"POST",
			url:"/kakao/payReady",
			data:formData,
			processData:false,
	  	    contentType:false,
	  	    cache:false,
	      	datatype:"JSON",
	      	success:function(response)
	      	{
	      		if(response.code == 0)
	  			{
	      			var orderId = response.data.orderId;
					var tId = response.data.tId;
					var pcUrl = response.data.pcUrl;
					  
					  $("#orderId").val(orderId);
					  $("#tId").val(tId);
					  $("#pcUrl").val(pcUrl);
					  
					  var win = window.open('', 'kakaoPopUp', 'toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=540,height=700,left=100,top=100');
				  	  //새로운 윈도우 창을 연다.
					  
					  $("#kakaoForm").submit();	//값 받아온걸로 띄워줌(QR코드).
	  			}
	      		else
	  			{
	      			alert("오류가 발생하였습니다.");
	  			}
	      		
	      	},
	      	error:function(xhr, status, error)
	      	{
	      		 icia.common.error(error);
	      	}
		
	    });
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
	

	
	<!-- breadcrumb-section -->
	<div class="breadcrumb-section breadcrumb-bg" style="margin: auto;">
		<div class="container">
			<div class="">
				<div class="col-lg-8 offset-lg-2 text-center">
					<div class="breadcrumb-text">
						
						<h1>후원금액 결제</h1>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- end breadcrumb section -->

	<!-- 결제정보 시작 -->
	<div class="center-align mt-150 mb-150" >
		<div class="center-align">
			<div class="center-align">
				<div class="col-lg-8" style="margin: 0 auto; width:50%;">
					<div class="checkout-accordion-wrap">
						<div class="accordion" id="accordionExample">
						  <div class="card single-accordion">
						    <div class="card-header" id="headingOne">
						      <h5 class="mb-0">
						        <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
						          후원자 정보 
						        </button>
						      </h5>
						    </div>

						    <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
						      <div class="card-body">
						        <div class="billing-address-form">
						        	<form action="index.html">
						        		<p>아이디<input type="text" placeholder="아이디" value="${user.userId}"></p>
						        		<p>이름<input type="text" placeholder="이름" value="${user.userName}"></p>
						        		<p>이메일<input type="email" placeholder="이메일" value="${user.userEmail}"></p>
						        		<p>전화번호<input type="tel" placeholder="전화번호" value="${user.userPhone}"></p>
						        		<p>남기고 싶은 말<textarea name="bill" id="bill" cols="30" rows="10" placeholder="후원하는 아동에게 남기고 싶은 말을 적어주세요"></textarea></p>
						        		<!-- 남기고 싶은 말 항목은 추후 DB칼럼 추가 필요해보임 -->
						        	</form>
						        </div>
						      </div>
						    </div>
						  </div>
						  <div class="card single-accordion">
						    <div class="card-header" id="headingTwo">
						      <h5 class="mb-0">
						        <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
						          후원 프로그램 정보
						        </button>
						      </h5>
						    </div>
						    <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionExample">
						      <div class="card-body">
						        <div class="billing-address-form">
						        	<form action="index.html">
						        		<p>후원 항목<input type="text" placeholder="후원 항목" value="아동 복지"></p><!-- 카카오 결제시 '상품명'파라미터로 적용(상품코드와 수량은 '1'로 적용 -->
						        		<p>후원 방식<input type="email" placeholder="정기 후원" value="일시 후원"></p><!-- 후원상세 페이지에서 선택한 값 적용 -->
						        		<p>총괄 기업명<input type="tel" placeholder="맨발의 기봉이" value="맨발의 기봉이"></p>
						        	</form>						       
						         </div>
						      </div>
						    </div>
						  </div>
						  <div class="card single-accordion">
						    <div class="card-header" id="headingThree">
						      <h5 class="mb-0">
						        <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
						          결제수단
						        </button>
						      </h5>
						    </div>
						    <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordionExample">
						      <div class="card-body">
						        <div class="card-details">
						        <input type="checkbox" name="카카오페이" style="accent-color: #FFB74D;" checked/>카카오페이&nbsp;
						        <input type="checkbox" name="카카오페이" style="accent-color: #FFB74D;"/>무통장입금
						        
						        	
						        </div>
						      </div>
						    </div>
						  </div>
						  <div class="card-header" id="headingThree">
						      <h5 class="mb-0">
						          결제 후원 금액 : ${price}원 <!-- 카카오페이 결제 시 '금액' 파라미터 값으로 적용. 후원상세 페이지에서 선택한 값 적용 -->
						      </h5>
						    </div>
						    <br/>
						    <div style=" float: right;">
						   
						    <a id="kakaoPay" name="kakaoPay" class="boxed-btn" >결제진행</a>&nbsp;&nbsp;
						    <a href="#" class="boxed-btn" >결제취소</a>
						    </div>
						</div>

					</div>
				</div>

			</div>
		</div>
	</div>
	<br/><br/>
	<!-- 결제정보 끝 -->

	
	<form id="payForm" name="payForm" method="post">
	   <input type="hidden" name="itemCode" id="itemCode" maxlength="32" class="form-control mb-2" placeholder="상품코드" value="${donate.donateSeq}" />
	   <input type="hidden" name="itemName" id="itemName" maxlength="50" class="form-control mb-2" placeholder="상품명" value="맨발의 기봉이 아동복지" />
	   <input type="hidden" name="quantity" id="quantity" maxlength="3" class="form-control mb-2" placeholder="수량" value="1" />
       <input type="hidden" name="totalAmount" id="totalAmount" maxlength="10" class="form-control mb-2" placeholder="금액" value="${price }" /> 	
	</form>
	
	<form name="kakaoForm" id="kakaoForm" method="POST" target="kakaoPopUp" action="/kakao/payPopUp">
   		<input type="hidden" name="orderId" id="orderId" value="" />
   		<input type="hidden" name="tId" id="tId" value="" />
   		<input type="hidden" name="pcUrl" id="pcUrl" value="${price}" />
   </form>
	
</body>
</html>

