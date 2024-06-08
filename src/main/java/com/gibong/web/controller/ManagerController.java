package com.gibong.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("managerController")
public class ManagerController 
{
	private static Logger logger = LoggerFactory.getLogger(DonateController.class);
	
	
	@RequestMapping(value = "/manager/donateView", method=RequestMethod.GET)
	public String donateView(HttpServletRequest request, HttpServletResponse response)
	{
		return "/manager/donateView";
	}
}
