<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script type="text/javascript">
$(document).ready(function(){
	$("#btnClose").on("click", function(){
		opener.movePage();
		window.close();
		
		location.href = "/donate/donateList";
	});
	
	$("#btnCancel").on("click", function(){
		if(confirm("결제를 취소하시겠습니까?") == true)
		{
			document.kakaoForm.action = "/kakao/payCancel";
			document.kakaoForm.submit();
		}
	});
	
});
</script>
</head>
<body>
<div class="container">
<c:choose>
	<c:when test="${!empty kakaoPayApprove}">
		<h2>카카오페이 결제가 정상적으로 완료되었습니다.</h2>
		결제일시 : ${kakaoPayApprove.approved_at} 	<br />
		주문번호 : ${kakaoPayApprove.partner_order_id}	<br />
		상품명 : ${kakaoPayApprove.item_name}	<br />
		상품수량 :	${kakaoPayApprove.quantity}	<br />
		결제금액 : ${kakaoPayApprove.amount.total}	<br />
		결제방법 :	${kakaoPayApprove.payment_method_type}	<br />
	</c:when>
	<c:otherwise>
		<h2>카카오페이 결제 중 오류가 발생하였습니다.</h2>
	</c:otherwise>
</c:choose>	
</div>
<button id="btnCancel" name="btnCancels" type="button">취소하기</button>
<button id="btnClose" name="btnClose" type="button">닫기</button>

<form name="kakaoForm" id="kakaoForm" method="post">
	<input type="hidden" name="orderId" id="orderId" value="${orderId}" />
	<input type="hidden" name="tId" id="tId" value="${tId}" />
	<input type="hidden" name="userId" id="userId" value="${userId}" />
</form>

</body>
</html>