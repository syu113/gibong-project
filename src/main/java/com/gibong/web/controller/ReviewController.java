package com.gibong.web.controller;

import java.util.ArrayList;
import java.util.Collections;
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

import com.gibong.web.model.Paging;
import com.gibong.web.model.Response;
import com.gibong.web.model.Review;
import com.gibong.web.model.ReviewFile;
import com.gibong.web.model.ReviewReply;
import com.gibong.web.model.User;
import com.gibong.web.service.ReviewService;
import com.gibong.web.service.UserService;
import com.gibong.web.util.CookieUtil;
import com.gibong.web.util.HttpUtil;
import com.gibong.common.model.FileData;
import com.gibong.common.util.StringUtil;

@Controller("reviewController")
public class ReviewController 
{
	private static Logger logger = LoggerFactory.getLogger(ReviewController.class);
	
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private UserService userService;
	
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	@Value("#{env['upload.review.save.dir']}")
	private String UPLOAD_REVIEW_SAVE_DIR;
	
	private static final int LIST_COUNT = 6;		
	private static final int PAGE_COUNT = 5;		 
	
	@RequestMapping(value="/review/reviewList")
	public String reviewList(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		long curPage = HttpUtil.get(request, "curPage", 1);
		List<Review> list = null;
		Paging paging = null;
		Review search = new Review();
		ReviewReply reviewReply = new ReviewReply();
		
		String searchType = HttpUtil.get(request, "searchType", "");
		String searchValue = HttpUtil.get(request, "searchValue", "");
		
		if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue))
		{
			search.setSearchType(searchType);
			search.setSearchValue(searchValue);
		}
		
		
		long totalCount = 0;
		
		totalCount = reviewService.reviewTotalCount(search);
		
		if(totalCount > 0)
		{
			paging = new Paging("/review/reviewList", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
			
			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());
			
			list = reviewService.reviewList(search);
			
			for(int i =0; i < list.size(); i++)
			{
				Review review2 = null;
				
				review2 = list.get(i);
				long replyCount = reviewService.reviewReplyCount(review2.getReviewSeq());
				review2.setReplyCount(replyCount);
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
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		
		return "/review/reviewList";
	}
	
	//후기 게시글쓰기
	@RequestMapping(value="/review/reviewWrite")
	public String reviewWrite(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		if(userId != null)
		{
			User user = userService.userSelect(userId);
			
			if(user != null)
			{
				model.addAttribute("user", user);
			}
		}
		
		return "/review/reviewWrite";
	}
	
	@RequestMapping(value="/review/writeProc")
	@ResponseBody
	public Response<Object> writeProc(MultipartHttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String reviewTitle = HttpUtil.get(request, "reviewTitle", "");
		String reviewContent = HttpUtil.get(request, "newTweetContent", "");
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		FileData fileData = HttpUtil.getFile(request, "btnAtt", UPLOAD_REVIEW_SAVE_DIR);
		//List<FileData> fileData = HttpUtil.getFiles(request, "btnAtt", UPLOAD_REVIEW_SAVE_DIR);
		
		
		if(!StringUtil.isEmpty(reviewTitle) && !StringUtil.isEmpty(reviewContent))
		{
			Review review = new Review();
			
			review.setUserId(cookieUserId);
			review.setReviewTitle(reviewTitle);
			review.setReviewContent(reviewContent);
			
			/*
			if(fileData != null && fileData.size() > 0)
			{
				ReviewFile reviewFile = new ReviewFile();
				for(int i =0; i < fileData.get(i).getFileSize(); i++)
				{
					reviewFile.setFileOrgName(fileData.get(i).getFileOrgName());
					reviewFile.setFileName(fileData.get(i).getFileName());
					reviewFile.setFileExt(fileData.get(i).getFileExt());
					reviewFile.setFileSize(fileData.get(i).getFileSize());
					
					review.setReviewFile(reviewFile);
				}
			}
			*/
			
			
			if(fileData != null && fileData.getFileSize() > 0)
			{
				
				ReviewFile reviewFile = new ReviewFile();
				
				reviewFile.setFileOrgName(fileData.getFileOrgName());
				reviewFile.setFileName(fileData.getFileName());
				reviewFile.setFileExt(fileData.getFileExt());
				reviewFile.setFileSize(fileData.getFileSize());
				
				review.setReviewFile(reviewFile);
			}
			
			
			try
			{
				if(reviewService.reviewInsert(review) > 0)
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
				logger.error("[ReviewController] writeProc Exception", e);
				ajaxResponse.setResponse(401, "error");
			}
			
		}
		else
		{
			ajaxResponse.setResponse(400, "bad request");
		}
			
			
		return ajaxResponse;
	}
	
	
	@RequestMapping(value="/review/reviewView")
	public String reviewView(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		long curPage = HttpUtil.get(request, "curPage", 1);
		String searchType = HttpUtil.get(request, "searchType", "");
		String searchValue = HttpUtil.get(request, "searchValue", "");
		long reviewSeq = HttpUtil.get(request, "reviewSeq", 0);
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		List<ReviewReply> list = null; 
		ReviewReply reviewReply = new ReviewReply();
		
		if(reviewSeq > 0)
		{
			Review review = reviewService.reviewViewSelect(reviewSeq);
			
			if(review != null)
			{
				model.addAttribute("review", review);
				model.addAttribute("cookieUserId", cookieUserId);
				
				User user = userService.userSelect(cookieUserId);
				
				list = reviewService.reviewReplySelect(reviewSeq);
				
				model.addAttribute("user", user);
				if(list != null)
				{
					model.addAttribute("list", list);
					model.addAttribute("reviewSeq", reviewSeq);
					model.addAttribute("cookieUserId", cookieUserId);
					
					
					for(int i =0; i < list.size(); i++)
					{
						logger.debug("=======================");
						logger.debug("list size :" + list.get(i));
						logger.debug("=======================");
					}
				}
				else
				{
					logger.debug("-=-=-=-=-==-=-=-=-=-=-=-=-=-=");
				}
			}
		}
		
		
		return "/review/reviewView";
	}
	
	
	@RequestMapping(value="/review/reviewUpdate")
	public String reviewUpdate(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		long reviewSeq = HttpUtil.get(request, "reviewSeq", 0);
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		if(reviewSeq > 0)
		{
			Review review = reviewService.reviewViewSelect(reviewSeq);
			
			if(review != null)
			{
				if(StringUtil.equals(cookieUserId, review.getUserId()))
				{
					ReviewFile reviewFile = reviewService.reviewFileSelect(reviewSeq);
					if(reviewFile != null)
					{
						review.setReviewFile(reviewFile);
						
						logger.debug("222222222222222222222222222222");
						logger.debug("review fileName : " + review.getFileName());
						logger.debug("review fileOrgName : " + review.getFileOrgName());
						logger.debug("222222222222222222222222222222");
						
					}
					
					model.addAttribute("review", review);
				}
			}
		}
		
		return "/review/reviewUpdate";
	}
	
	
	@RequestMapping(value="/review/updateProc")
	@ResponseBody
	public Response<Object> updateProc(MultipartHttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String reviewContent = HttpUtil.get(request, "newTweetContent", "");
		String reviewTitle = HttpUtil.get(request, "reviewTitle", "");
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long reviewSeq = HttpUtil.get(request, "reviewSeq", 0);
		FileData fileData = HttpUtil.getFile(request, "btnAtt", UPLOAD_REVIEW_SAVE_DIR);
		
		
		if(reviewSeq > 0 && !StringUtil.isEmpty(cookieUserId) && 
				!StringUtil.isEmpty(reviewTitle) && !StringUtil.isEmpty(reviewContent))
		{
			
			Review review = reviewService.reviewViewSelect(reviewSeq);
			
			logger.debug("1111111111111111111111111");
			
			if(review != null)
			{
				logger.debug("2222222222222222222222222222");
				
				if(StringUtil.equals(review.getUserId(), cookieUserId))
				{
					logger.debug("33333333333333333333333333");
					
					review.setReviewTitle(reviewTitle);
					review.setReviewContent(reviewContent);
					
					if(fileData != null && fileData.getFileSize() > 0 )
					{
						logger.debug("444444444444444444444444");
						
						
						ReviewFile reviewFile = new ReviewFile();
						
						reviewFile.setFileName(fileData.getFileName());
						reviewFile.setFileOrgName(fileData.getFileOrgName());
						reviewFile.setFileExt(fileData.getFileExt());
						reviewFile.setFileSize(fileData.getFileSize());
						
						review.setReviewFile(reviewFile);
					}
					
					try
					{
						logger.debug("5555555555555555555");
						
						if(reviewService.reviewUpdate(review) > 0)
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
						logger.error("[ReviewController] updateProc Exception", e);
						ajaxResponse.setResponse(405, "error5");
					}
				}
				else
				{
					ajaxResponse.setResponse(403, "error2");
				}
			}
			else
			{
				ajaxResponse.setResponse(404, "error3");
			}
			
		}
		else
		{
			ajaxResponse.setResponse(400, "error4");
		}
		
		return ajaxResponse;
	}
	
	@RequestMapping(value="/review/reviewDeleteProc")
	@ResponseBody
	public Response<Object> reviewDeleteProc(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long reviewSeq = HttpUtil.get(request, "reviewSeq", 0);
		
		if(reviewSeq > 0 && !StringUtil.isEmpty(cookieUserId))
		{
			Review review = reviewService.reviewViewSelect(reviewSeq);
			
			if(review != null)
			{
				if(StringUtil.equals(review.getUserId(), cookieUserId))
				{
					if(reviewService.reviewDelete(reviewSeq) > 0)
					{
						ajaxResponse.setResponse(0, "success");
					}
					else
					{
						ajaxResponse.setResponse(500, "error1");
					}
				}
				else
				{
					ajaxResponse.setResponse(401, "error2");
				}
			}
			else
			{
				ajaxResponse.setResponse(402, "error3");
			}
		}
		else
		{
			ajaxResponse.setResponse(403, "error1");
		}
		
		
		return ajaxResponse;
	}
	
	
	@RequestMapping(value="/review/replyProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> replyProc(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String comment = HttpUtil.get(request, "comment", "");
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long reviewSeq = HttpUtil.get(request, "reviewSeq", 0);
		
		
		logger.debug("++++++++++++++++++++++++++");
		logger.debug("reviewSeq :" + reviewSeq);
		logger.debug("++++++++++++++++++++++++++");
		
		if(!StringUtil.isEmpty(comment) && !StringUtil.isEmpty(cookieUserId))
		{
			ReviewReply reviewReply = new ReviewReply();
			
			reviewReply.setUserId(cookieUserId);
			reviewReply.setReviewReplyContent(comment);
			reviewReply.setReviewSeq(reviewSeq);
			
			if(reviewService.reviewReplyInsert(reviewReply) > 0)
			{
				ajaxResponse.setResponse(0, "success");
			}
			else
			{
				ajaxResponse.setResponse(404, "error");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "success");
		}
		
		return ajaxResponse;
	}
	
	@RequestMapping(value="/review/replyProc2", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> replyProc2(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String comment2 = HttpUtil.get(request, "comment2", "");
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long replySeq = HttpUtil.get(request, "replySeq", 0);
		long reviewSeq = HttpUtil.get(request, "reviewSeq", 0);
		
		if(replySeq > 0 && !StringUtil.isEmpty(comment2) && !StringUtil.isEmpty(cookieUserId))
		{
			ReviewReply parent = reviewService.viewReplySelect(replySeq);
			
			if(parent != null)
			{
				ReviewReply reviewReply = new ReviewReply();
				
				reviewReply.setUserId(cookieUserId);
				reviewReply.setReviewReplyContent(comment2);
				reviewReply.setReviewReplyGroup(replySeq);
				reviewReply.setReviewSeq(reviewSeq);
				
				reviewReply.setReviewReplyOrder(parent.getReviewReplyOrder()+1);
				reviewReply.setReviewReplyIndent(parent.getReviewReplyIndent()+1);
				
				if(reviewService.reviewReplyInsert2(reviewReply) > 0)
				{
					ajaxResponse.setResponse(0, "success");
				}
				else
				{
					ajaxResponse.setResponse(404, "error");
				}
			}
			
			
		}
		else
		{
			ajaxResponse.setResponse(400, "success");
		}
		
		return ajaxResponse;
	}
	
	//게시글 삭제(update로 플래그값 변경해주기)
	@RequestMapping(value="/review/deleteProc")
	@ResponseBody
	public Response<Object> deleteProc(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse= new Response();
		
		long replySeq = HttpUtil.get(request, "replySeq", 0);
		
		if(replySeq > 0)
		{
			if(reviewService.replyDelete(replySeq) > 0)
			{
				ajaxResponse.setResponse(0, "success");
			}
			else
			{
				ajaxResponse.setResponse(500, "error");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "no request");
		}
		
		return ajaxResponse;
	}
	
	
}
