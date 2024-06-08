package com.gibong.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonObject;
import com.gibong.common.util.StringUtil;
import com.gibong.web.model.Donate;
import com.gibong.web.model.KakaoPayApprove;
import com.gibong.web.model.KakaoPayOrder;
import com.gibong.web.model.KakaoPayReady;
import com.gibong.web.model.Response;
import com.gibong.web.service.DonateService;
import com.gibong.web.service.KakaoPayService;
import com.gibong.web.util.CookieUtil;
import com.gibong.web.util.HttpUtil;

@Controller("kakaoPayController")
public class KakaoPayController 
{
	private static Logger logger = LoggerFactory.getLogger("KakaoPayController.class");
	
	@Autowired
	private KakaoPayService kakaoPayService; 
	
	@Autowired
	private DonateService donateService;
	
	//쿠키
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	
	
	@RequestMapping(value="/kakao/payReady", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> payReady(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String orderId = StringUtil.uniqueValue();
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String itemCode = HttpUtil.get(request, "itemCode", "");
		String itemName = HttpUtil.get(request, "itemName", "");
		int quantity = HttpUtil.get(request, "quantity", 0);
		int totalAmount = HttpUtil.get(request, "totalAmount", 0);		//카드결제가 아니라서 안넣어줘도됌
		int taxFreeAmount = HttpUtil.get(request, "taxFreeAmount", 0);	//위와동일
		int vatAmount = HttpUtil.get(request, "vatAmount", 0);			//위와동일
		
		KakaoPayOrder kakaoPayOrder = new KakaoPayOrder();
		
		kakaoPayOrder.setPartnerOrderId(orderId);		//고유한 그 가맹점의 주문번호
		kakaoPayOrder.setPartnerUserId(userId);			//하이보드 회원 아이디
		kakaoPayOrder.setItemCode(itemCode);			
		kakaoPayOrder.setItemName(itemName);
		kakaoPayOrder.setQuantity(quantity);
		kakaoPayOrder.setTotalAmount(totalAmount);
		kakaoPayOrder.setTaxFreeAmount(taxFreeAmount);
		kakaoPayOrder.setVatAmount(vatAmount);
		
		KakaoPayReady kakaoPayReady = kakaoPayService.kakaoPayReady(kakaoPayOrder);
		
		if(kakaoPayReady != null)
		{
			logger.debug("[KakaoPayController] payReady : " + kakaoPayReady);
			
			kakaoPayOrder.settId(kakaoPayReady.getTid());		//서비스로 타고간 kakaoPayReady메서드와 중복 되고있음(둘중 하나 지워도됌)
			
			JsonObject json = new JsonObject();
			json.addProperty("orderId", orderId);
			json.addProperty("tId", kakaoPayReady.getTid());
			json.addProperty("appUrl", kakaoPayReady.getNext_redirect_app_url());
			json.addProperty("mobileUrl", kakaoPayReady.getNext_redirect_mobile_url());
			json.addProperty("pcUrl", kakaoPayReady.getNext_redirect_pc_url());
				
			
			
			ajaxResponse.setResponse(0, "Success", json);
			
		}
		else
		{
			ajaxResponse.setResponse(-1, "fail", null);
		}
		
		return ajaxResponse;
	}
	
	@RequestMapping(value="/kakao/payPopUp", method=RequestMethod.POST)
	public String payPopUp(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String pcUrl = HttpUtil.get(request, "pcUrl", ""); 
		String orderId = HttpUtil.get(request, "orderId", ""); 
		String tId = HttpUtil.get(request, "tId", ""); 
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		
		logger.debug("11111111111111111111111");
		logger.debug("pcURL : " + pcUrl);
		
		
		model.addAttribute("pcUrl", pcUrl);
		model.addAttribute("orderId", orderId);
		model.addAttribute("tId", tId);
		model.addAttribute("userId", userId);
		
		return "/kakao/payPopUp";
	}
	
	@RequestMapping(value="/kakao/paySuccess")
	public String paySuccess(ModelMap model,HttpServletRequest request, HttpServletResponse response)
	{
		String pgToken = HttpUtil.get(request, "pg_token", "");
		
		model.addAttribute("pgToken", pgToken);
		
		return "/kakao/paySuccess";
	}
	
	@RequestMapping(value="/kakao/payResult")
	public String payResult(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		KakaoPayApprove kakaoPayApprove = null;
		
		String tId = HttpUtil.get(request, "tId", "");
		String orderId = HttpUtil.get(request, "orderId");
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String pgToken = HttpUtil.get(request, "pgToken", "");
		
		KakaoPayOrder kakaoPayOrder = new KakaoPayOrder();
		
		kakaoPayOrder.setPartnerOrderId(orderId);
		kakaoPayOrder.setPartnerUserId(userId);
		kakaoPayOrder.settId(tId);
		kakaoPayOrder.setPgToken(pgToken);
		
		kakaoPayApprove = kakaoPayService.kakaoPayApprove(kakaoPayOrder);
		
		Donate donate = donateService.donateViewSelect(Long.parseLong(kakaoPayApprove.getItem_code()));
		
		if(donate != null)
		{
			donate.setDonateNowAmt(donate.getDonateNowAmt()+ kakaoPayApprove.getAmount().getTotal());
			
			donateService.donatePayment(donate);
		}
		
		model.addAttribute("kakaoPayApprove", kakaoPayApprove);
		
		return "/kakao/payResult";
	}
	
	
	/*
	@RequestMapping(value="/kakao/payCancel")
	public String payCancel(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		KakaoPayCancel kakaoPayCancel = null;
		
		String tId = HttpUtil.get(request, "tId", "");
		String orderId = HttpUtil.get(request, "orderId");
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		KakaoPayOrder kakaoPayOrder = new KakaoPayOrder();
		
		kakaoPayOrder.setPartnerOrderId(orderId);
		kakaoPayOrder.setPartnerUserId(userId);
		kakaoPayOrder.settId(tId);
		
		kakaoPayCancel = kakaoPayService.kakaoPayCancel(kakaoPayOrder);
		
		
		model.addAttribute("kakaoPayCancel", kakaoPayCancel);
		
		return "/kakao/payCancel";
	}
	*/
	
	
	//결제 취소시
	@RequestMapping(value="/kakao/payCancel")
	public String payCancel(HttpServletRequest request, HttpServletResponse response)
	{
		return "/kakao/payCancel";
	}
	
	//결제 실패시
	@RequestMapping(value="/kakao/payFail")
	public String payCanFail(HttpServletRequest request, HttpServletResponse response)
	{
		return "/kakao/payFail";
	}
	
}

