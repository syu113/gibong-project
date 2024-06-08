package com.gibong.web.controller;

import java.util.List;

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
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gibong.common.model.FileData;
import com.gibong.common.util.StringUtil;
import com.gibong.web.dao.DonateDao;
import com.gibong.web.model.Donate;
import com.gibong.web.model.DonateFile;
import com.gibong.web.model.Paging;
import com.gibong.web.model.Response;
import com.gibong.web.model.Review;
import com.gibong.web.model.ReviewFile;
import com.gibong.web.model.User;
import com.gibong.web.service.DonateService;
import com.gibong.web.service.UserService;
import com.gibong.web.util.CookieUtil;
import com.gibong.web.util.HttpUtil;

@Controller("donateController")
public class DonateController 
{
	private static Logger logger = LoggerFactory.getLogger(DonateController.class);
	
	@Autowired
	private DonateService donateService;
	
	@Autowired
	private UserService userService;
	
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	@Value("#{env['upload.donate.save.dir']}")
	private String UPLOAD_DONATE_SAVE_DIR;
	
	
	public static final int LIST_COUNT = 5;
	public static final int PAGE_COUNT = 5;
	
	@RequestMapping(value = "/donate/donateList")
	public String donateList(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long curPage = HttpUtil.get(request, "curPage", 1);
		List<Donate> list = null;
		Paging paging = null;
		
		Donate donate = new Donate();
		
		long totalCount = 0;
		
		
		
		totalCount = donateService.donateTotalCount(donate);
		
		if(totalCount > 0)
		{
			paging = new Paging("/donate/donateList", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
			
			donate.setStartRow(paging.getStartRow());
			donate.setEndRow(paging.getEndRow());
			
			list = donateService.donateList(donate);
			
			long amt1 = 0;
			long amt2 = 0;
			
			for(int i=0; i< list.size(); i++)
			{
				Donate donate2 = null;
				donate2 = list.get(i);
				
				amt1 = donate2.getDonateGoalAmt();
				amt2 = donate2.getDonateNowAmt();
				
				if(amt1 > 0 && amt2 > 0)
				{
					donate2.setProgress((amt2*100)/amt1);
				}
			}
		}
		
		logger.debug("===========================================");
		logger.debug("paging startPage : " + paging.getStartPage());
		logger.debug("paging endPage : " + paging.getEndPage());
		logger.debug("totalCount : " + totalCount);
		
		logger.debug("===========================================");
		
		model.addAttribute("list", list);
		model.addAttribute("paging", paging);
		model.addAttribute("curPage", curPage);
		model.addAttribute("cookieUserId", cookieUserId);
		
		
		
		return "/donate/donateList";
		
	}
	
	@RequestMapping(value = "/donate/donateView")
	public String donateView(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		long donateSeq = HttpUtil.get(request, "donateSeq", 0);
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		if(donateSeq > 0 )
		{
			Donate donate = donateService.donateViewSelect(donateSeq);
			
			if(donate != null)
			{
				model.addAttribute("donate", donate);
				model.addAttribute("cookieUserId", cookieUserId);
			}
		}
		
		return "/donate/donateView";
	}
	
	@RequestMapping(value="/donate/donateWrite")
	public String donateWrite(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		if(cookieUserId != null)
		{
			User user = userService.userSelect(cookieUserId);
			
			if(user != null)
			{
				model.addAttribute("user", user);
			}
		}
	
		return"/donate/donateWrite";
	}
	
	@RequestMapping(value="donate/writeProc")
	@ResponseBody
	public Response<Object> writeProc(MultipartHttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long amount = HttpUtil.get(request, "amount", 0);
		String donateTitle = HttpUtil.get(request, "donateTitle", "");
		String donateContent = HttpUtil.get(request, "donateContent", "");
		String closeDate = HttpUtil.get(request, "closeDate", "");
		FileData fileData = HttpUtil.getFile(request, "btnAtt", UPLOAD_DONATE_SAVE_DIR);
		
		logger.debug("=======================");
		logger.debug("amount : " + amount);
		logger.debug("=======================");
		
		if(!StringUtil.isEmpty(donateTitle) && !StringUtil.isEmpty(donateContent) && !StringUtil.isEmpty(amount))
		{
			Donate donate = new Donate();
			
			donate.setUserId(cookieUserId);
			donate.setDonateTitle(donateTitle);
			donate.setDonateGoalAmt(amount);
			donate.setDonateContent(donateContent);
			donate.setCloseDate(closeDate);
			
			if(fileData != null && fileData.getFileSize() > 0)
			{
				
				DonateFile donateFile = new DonateFile();
				
				donateFile.setFileOrgName(fileData.getFileOrgName());
				donateFile.setFileName(fileData.getFileName());
				donateFile.setFileExt(fileData.getFileExt());
				donateFile.setFileSize(fileData.getFileSize());
				
				donate.setDonateFile(donateFile);
			}
			
			
			try
			{
				if(donateService.donateInsert(donate) > 0)
				{
					ajaxResponse.setResponse(0, "success");
				}
				else
				{
					ajaxResponse.setResponse(500, "error");
				}
			}
			catch(Exception e)
			{
				logger.error("[DonateController] writeProc Exception", e);
				ajaxResponse.setResponse(401, "error");
			}
			
		}
		else
		{
			ajaxResponse.setResponse(400, "bad request");
		}
		
		
		return ajaxResponse;
	}
	
	
	
	@RequestMapping(value="/donate/donatePay")
	public String donatePay(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		long price = HttpUtil.get(request, "price", 0);
		long donateSeq = HttpUtil.get(request, "donateSeq", 0);
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long priceSelf = HttpUtil.get(request, "priceSelf", 0);
		
		if(priceSelf > 0)
		{
			price = priceSelf;
		}
		
		if(price > 0)
		{
			logger.debug("111111111111111111111111111");
			
			Donate donate = donateService.donateViewSelect(donateSeq);
			User user = userService.userSelect(cookieUserId);
			
			if(donate != null && user != null)
			{
				logger.debug("2222222222222222222222222222");
				logger.debug("price : " + price);
				
				model.addAttribute("user", user);
				model.addAttribute("donate", donate);
				model.addAttribute("price", price);
			}
		}
				
		return "/donate/donatePay";
	}
}
