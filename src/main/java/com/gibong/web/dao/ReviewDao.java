package com.gibong.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.gibong.web.model.Review;
import com.gibong.web.model.ReviewFile;
import com.gibong.web.model.ReviewReply;


@Repository
public interface ReviewDao 
{
	//후기 게시판
	public List<Review> reviewList(Review review);
	
	//토탈 리스트
	public long reviewTotalCount(Review review);
	
	//후기 글쓰기
	public int reviewInsert(Review review);
	
	//첨부파일 등록
	public int reviewFileInsert(ReviewFile reviewFile);
	
	//첨부파일 조회
	public ReviewFile reviewFileSelect(long reviewSeq);
	
	//후기 상세글 조회
	public Review reviewViewSelect(long reviewSeq);
	
	//후기 댓글
	public List<ReviewReply> reviewReplySelect(long reviewSeq);
	
	//후기 작성
	public int reviewReplyInsert(ReviewReply reviewReply);
	
	//후기 대댓글
	public int reviewReplyInsert2(ReviewReply reviewReply);
	
	//후기 조회수증가
	public int reviewReadCntPlus(long reviewSeq);
	
	//후기 댓글 카운트
	public long reviewReplyCount(long reviewSeq);
	
	//후기 댓글에 부모값 가져오기
	public ReviewReply viewReplySelect(long reviewReplySeq);
	
	//후기댓글 삭제
	public long replyDelete(long reviewReplySeq);
	
	//후기글 수정
	public long reviewUpdate(Review review);
	
	//후기글 수정 중 첨부파일 삭제후 추가
	public long reviewFileDelete(long reviewSeq);
	
	//후기글 삭제
	public long reviewDelete(long reviewSeq);
}
