package com.gibong.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.gibong.common.util.FileUtil;
import com.gibong.web.dao.ReviewDao;
import com.gibong.web.model.Review;
import com.gibong.web.model.ReviewFile;
import com.gibong.web.model.ReviewReply;

@Service("reviewService")
public class ReviewService 
{
	private static Logger logger = LoggerFactory.getLogger(ReviewService.class);
	
	
	@Autowired
	private ReviewDao reviewDao;
	
	@Value("#{env['upload.review.save.dir']}")
	private String UPLOAD_REVIEW_SAVE_DIR;
	
	
	public List<Review> reviewList(Review review)
	{
		List<Review> list = null;
		
		try
		{
			list = reviewDao.reviewList(review);
			
		}
		catch(Exception e)
		{
			logger.error("[ReviewService] reviewList Exception", e);
		}
		
		return list;
	}
	
	public long reviewTotalCount(Review review)
	{
		long count = 0;
		
		try
		{
			count = reviewDao.reviewTotalCount(review);
		}
		catch(Exception e)
		{
			logger.error("[ReviewService] reviewTotalCount Exception", e);
		}
		
		
		return count;
	}
	
	//후기 글쓰기(첨부파일, 글 두개 트랜잭션)
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int reviewInsert(Review review) throws Exception
	{
		int count = 0;
		
		count = reviewDao.reviewInsert(review);				//글 등록
		
		if(count > 0 && review.getReviewFile() != null)
		{
			ReviewFile reviewFile = review.getReviewFile();
			
			reviewFile.setReviewSeq(review.getReviewSeq());
			reviewFile.setFileSeq((short)1);
			
			
			reviewDao.reviewFileInsert(reviewFile);			//첨부파일 등록
		}
		
		return count;
	}
	
	//첨부파일 조회
	
	public ReviewFile reviewFileSelect(long reviewSeq)
	{
		ReviewFile reviewFile = null;
		
		try
		{
			reviewFile = reviewDao.reviewFileSelect(reviewSeq);
		}
		catch(Exception e)
		{
			logger.error("[ReviewService] reviewFileSelect Exception", e);
		}
		
		return reviewFile;
	}
	
	
	
	//후기글 상세 조회
	public Review reviewViewSelect(long reviewSeq)
	{
		Review review = null;
		
		try
		{
			review = reviewDao.reviewViewSelect(reviewSeq);
			
			if(review != null)
			{
				reviewDao.reviewReadCntPlus(reviewSeq);
			}
		}
		catch(Exception e)
		{
			logger.error("[ReviewService] reviewViewSelect Exception", e);
		}
		
		return review;
	}
	
	
	//후기글 수정
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public long reviewUpdate(Review review) throws Exception
	{
		long count = 0;
		
		count = reviewDao.reviewUpdate(review);
		
		if(count > 0 && review.getReviewFile() != null)
		{
			ReviewFile delReviewFile = reviewDao.reviewFileSelect(review.getReviewSeq());
			
			if(delReviewFile != null)
			{
				FileUtil.deleteFile(UPLOAD_REVIEW_SAVE_DIR + FileUtil.getFileSeparator() + 
						 delReviewFile.getFileName());
				
				reviewDao.reviewFileDelete(review.getReviewSeq());
			}
			
			ReviewFile reviewFile = review.getReviewFile();
			
			reviewFile.setReviewSeq(review.getReviewSeq());
			reviewFile.setFileSeq((short)1);
			
			reviewDao.reviewFileInsert(reviewFile);
		}
		
		return count;
	}

	//후기글 삭제
	public long reviewDelete(long reviewSeq)
	{
		long count = 0;
		
		try
		{
			count = reviewDao.reviewDelete(reviewSeq);
		}
		catch(Exception e)
		{
			logger.debug("[ReviewService] reviewDelete Exception", e);
		}
		
		return count;
	}
	
	
	//후기 댓글 조회
	public List<ReviewReply> reviewReplySelect(long reviewSeq)
	{
		List<ReviewReply> list = null;
		
		try
		{
			list = reviewDao.reviewReplySelect(reviewSeq);
		}
		catch(Exception e)
		{
			logger.error("[ReviewService] reviewReplyList Exception", e);
		}
		
		return list;
	}
	
	//후기 댓글 작성
	public int reviewReplyInsert(ReviewReply reviewReply)
	{
		int count = 0;
		
		try
		{
			count = reviewDao.reviewReplyInsert(reviewReply);
		}
		catch(Exception e)
		{
			logger.error("[ReviewService] reviewReplyInsert Exception", e);
		}
		
		return count;
	}
	
	//후기 댓글 작성2
		public int reviewReplyInsert2(ReviewReply reviewReply)
		{
			int count = 0;
			
			try
			{
				count = reviewDao.reviewReplyInsert2(reviewReply);
			}
			catch(Exception e)
			{
				logger.error("[ReviewService] reviewReplyInsert Exception", e);
			}
			
			return count;
		}
	
	//후기 댓글 카운트
	public long reviewReplyCount(long reviewSeq)
	{
		long count = 0;
		
		try
		{
			count = reviewDao.reviewReplyCount(reviewSeq);
		}
		catch(Exception e)
		{
			logger.error("[ReviewService] reviewReplyCount Exception", e);
		}
		
		return count;
	}
	
	//후기 댓글 부모글 불러오기(오더 인덴트 값 설정위해)
	public ReviewReply viewReplySelect(long reviewReplySeq)
	{
		ReviewReply reviewReply = null;
		
		try
		{
			reviewReply = reviewDao.viewReplySelect(reviewReplySeq);
		}
		catch(Exception e)
		{
			logger.error("[ReviewService] viewReplySelect Exception", e);
		}
		
		return reviewReply;
	}
	
	//후기 댓글 삭제
	public long replyDelete(long reviewReplySeq)
	{
		long count = 0;
		
		try
		{
			count = reviewDao.replyDelete(reviewReplySeq);
		}
		catch(Exception e)
		{
			logger.error("[ReviewService] replyDelete Exception", e);
		}
		
		return count;
	}
	
	
}
