<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<style>
	hr.hr-3 {
	  border: 0;
	  height: 0;
	  border-top: 1px solid #8c8c8c;
	}
    #att_zone {
	  width: 660px;
	  min-height: 150px;
	  padding: 10px;
	  border: 1px dotted gray;
	}
	
	#att_zone:empty:before {
	  content: attr(data-placeholder);
	  color: #999;
	  font-size: .9em;
	}
	textarea {
	    min-width: 100%;
	    min-height: 100rem;
	    overflow-y: hidden;
	    resize: none;
	    border: 0 white;
	}
	textarea:focus {
		outline: none;
	}
	
</style>
<script>
$(document).ready(function(){
	
	$("#btnUpload").on("click", function(){
		if(confirm("게시글을 수정하시겠습니까?") == true)
		{
			var form = $("#updateForm")[0]
		    var formData = new FormData(form);
		    
		    $.ajax({
		  	 type:"POST",
		  	 enctype:"multipart/form-data",
		  	 url:"/review/updateProc",
		  	 data:formData,
		  	 processData:false,
		  	 contentType:false,
		  	 cache:false,
		  	 success:function(response)
		  	 {
		  		 if(response.code == 0)
	 			 {
	  				alert("게시물 수정이 완료되었습니다.");
	 			 	document.updateForm.action = "/review/reviewView";
	 			 	document.updateForm.submit();
	 			 }
		  		 else if(response.code == 400)
	 			 {
	 			 	alert("파라미터 값이 올바르지 않습니다.");
	 			 }
		  		 else if(response.code == 404)
	 			 {
	  			 	alert("해당 게시물을 찾을 수 없습니다.");
	 			 }
		  		 else
	 			 {
	 			 	alert("게시물 수정 중 오류가 발생하였습니다.");
	 			 }
		  	 },
		  	 error:function(error)
		  	 {
		  		 icia.common.error(error);
		  		 alert("게시물 답변 중 오류가 발생하였습니다.");
		  		 $("#btnReply").prop("disabled", false);	
		  	 }
		  	 
		  	 
		    });
		}
	});
	
	$("#btnList").on("click", function(){
		location.href = "/review/reviewList";
	});
    
});


function resize(obj) {
    obj.style.height = '1px';
    obj.style.height = (12 + obj.scrollHeight) + 'px';
}

</script>
</head>
<body>
	
	<!--PreLoader-->
    <div class="loader">
        <div class="loader-inner">
            <div class="circle"></div>
        </div>
    </div>
    <!--PreLoader Ends-->
    
	<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
	<!-- breadcrumb-section -->
	<div class="breadcrumb-section breadcrumb-bg">
		<div class="container">
			<div class="row">
				<div class="col-lg-8 offset-lg-2 text-center">
					<div class="breadcrumb-text">
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- end breadcrumb section -->
	
	<!-- single article section -->
	<form id="updateForm" name="updateForm" method="post">
	<div class="mt-150 mb-150">
		<div class="container">
				<div class="col-lg-8" style="margin: 0 auto;">
					<div class="single-article-section" style="margin: 0 auto;">
						<div class="single-article-text">
							<div>
							</div>
						<div class="bbttnnw" style="text-align: right;">
						 <button type="button" id="btnUpload" name="btnUpload">수정</button>
						 <button type="button" id="btnList" name="btnList">리스트</button>
						</div>
						<p>
								 <table>
								    <thead>
								      <tr>
								        <th><i class="fas fa-calendar"></i> 봉사활동 내역</th>
								      </tr>
								    </thead>
								    <tbody>
								      <tr>
								        <td>글쓴이</td>
								        <td>${review.userId}</td>
								      </tr>
								      <tr>
								        <td>봉사분야</td>
								        <td></td>
								      </tr>
								      <tr>
								        <td>모집기관</td>
								        <td>${review.userName}</td>
								      </tr>
								    </tbody>
								  </table>
						</p>	  

							<!-- 이미지 미리보기 시작 -->
							  <div id='image_preview'>
							    <input type='file' id='btnAtt' name="btnAtt" multiple='multiple' />
							    <div id='att_zone'
							      data-placeholder='파일을 첨부 하려면 파일 선택 버튼을 클릭하거나 파일을 드래그앤드롭 하세요'>${review.fileOrgName}</div>
							  </div>
							  
							  	<script type="text/javascript">
						        ( /* att_zone : 이미지들이 들어갈 위치 id, btn : file tag id */
								  imageView = function imageView(att_zone, btn){
					
								    var attZone = document.getElementById(att_zone);
								    var btnAtt = document.getElementById(btn)
								    var sel_files = [];
								    
								    // 이미지와 체크 박스를 감싸고 있는 div 속성
								    var div_style = 'display:inline-block;position:relative;'
								                  + 'width:150px;height:120px;margin:5px;border:1px solid #00f;z-index:1';
								    // 미리보기 이미지 속성
								    var img_style = 'width:100%;height:100%;z-index:none';
								    // 이미지안에 표시되는 체크박스의 속성
								    var chk_style = 'width:30px;height:30px;position:absolute;'
								                  + 'right:0px;bottom:0px;z-index:999;background-color:white;color:black';
								  
								    btnAtt.onchange = function(e){
								      var files = e.target.files;
								      var fileArr = Array.prototype.slice.call(files)
								      for(f of fileArr){
								        imageLoader(f);
								      }
								    }  
								    
								  
								    // 탐색기에서 드래그앤 드롭 사용
								    attZone.addEventListener('dragenter', function(e){
								      e.preventDefault();
								      e.stopPropagation();
								    }, false)
								    
								    attZone.addEventListener('dragover', function(e){
								      e.preventDefault();
								      e.stopPropagation();
								      
								    }, false)
								  
								    attZone.addEventListener('drop', function(e){
								      var files = {};
								      e.preventDefault();
								      e.stopPropagation();
								      var dt = e.dataTransfer;
								      files = dt.files;
								      for(f of files){
								        imageLoader(f);
								      }
								      
								    }, false)
								    
					
								    
								    /*첨부된 이미지들을 배열에 넣고 미리보기 */
								    imageLoader = function(file){
								      sel_files.push(file);
								      var reader = new FileReader();
								      reader.onload = function(ee){
								        let img = document.createElement('img')
								        img.setAttribute('style', img_style)
								        img.src = ee.target.result;
								        attZone.appendChild(makeDiv(img, file));
								      }
								      
								      reader.readAsDataURL(file);
								    }
								    
								    /*첨부된 파일이 있는 경우 checkbox와 함께 attZone에 추가할 div를 만들어 반환 */
								    makeDiv = function(img, file){
								      var div = document.createElement('div')
								      div.setAttribute('style', div_style)
								      
								      var btn = document.createElement('input')
								      btn.setAttribute('type', 'button')
								      btn.setAttribute('value', 'x')
								      btn.setAttribute('delFile', file.name);
								      btn.setAttribute('style', chk_style);
								      btn.onclick = function(ev){
								        var ele = ev.srcElement;
								        var delFile = ele.getAttribute('delFile');
								        for(var i=0 ;i<sel_files.length; i++){
								          if(delFile== sel_files[i].name){
								            sel_files.splice(i, 1);      
								          }
								        }
								        
								        dt = new DataTransfer();
								        for(f in sel_files) {
								          var file = sel_files[f];
								          dt.items.add(file);
								        }
								        btnAtt.files = dt.files;
								        var p = ele.parentNode;
								        attZone.removeChild(p)
								      }
								      div.appendChild(img)
								      div.appendChild(btn)
								      return div
								    }
								  }
								)('att_zone', 'btnAtt')
							</script>
							<!-- 이미지 미리보기 끝 -->
							
							<p>
							<div style = "padding: 5px 1px 7px 3px;"></div>
							<h2><input type="text" id="reviewTitle" name="reviewTitle" placeholder="" style="outline: none; border:0px;" value="${review.reviewTitle}"/></h2>
							<hr class="hr-3">
							<img id="preview" onchange="readURL(this);" onkeydown="resize(this)" onkeyup="resize(this)"/>
						
							<textarea id="newTweetContent" name="newTweetContent" onkeydown="resize(this)" onkeyup="resize(this)">${review.reviewContent}</textarea>
							<input type="hidden" id="reviewSeq" name="reviewSeq" value="${review.reviewSeq}" />
							</p>
						</div>
					</div>
				</div>
		</div>
	</div>
	</form>
	<!-- end single article section --> 
</body>
</html>