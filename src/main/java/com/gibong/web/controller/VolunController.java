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

import com.gibong.web.service.VolunService;
import com.gibong.web.util.HttpUtil;
import com.gibong.web.model.Paging;
import com.gibong.web.model.Volun;
import com.gibong.web.service.UserService;

@Controller("volunController")
public class VolunController 
{
	private static Logger logger = LoggerFactory.getLogger(DonateController.class);
	
	@Autowired
	private VolunService volunService;
	
	@Autowired
	private UserService userService;
	
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	private static final int LIST_COUNT = 5;		//한 페이지의 게시물 수
	private static final int PAGE_COUNT = 5;		//페이징수 
	
	
	@RequestMapping(value = "/volun/volunList", method=RequestMethod.GET)
	public String volunList(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		//현재 페이지
		long curPage = HttpUtil.get(request, "curPage", 1);
		//리스트
		List<Volun> list = null;
		//페이징 객체
		Paging paging = null;
		//조회 객체
		Volun search = new Volun();
		
		long totalCount = 0;
		
		totalCount = volunService.volunListCount(search);
		
		logger.debug("============================");
		logger.debug("totalCount : " + totalCount);
		logger.debug("============================");
		
		if(totalCount > 0)
		{
			paging = new Paging("/volun/volunList", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
			
			list = volunService.volunList(search);
		}
		
		model.addAttribute("list", list);
		model.addAttribute("curPage", curPage);
		model.addAttribute("paging", paging);
		
		return "/volun/volunList";
	}
	
	@RequestMapping(value = "/volun/volunWrite", method=RequestMethod.GET)
	public String volunWrite(HttpServletRequest request, HttpServletResponse response)
	{
		return "/volun/volunWrite";
	}
	
	@RequestMapping(value = "/volun/volunView", method=RequestMethod.GET)
	public String volunView(HttpServletRequest request, HttpServletResponse response)
	{
		
		return "/volun/volunView";
	}
}
