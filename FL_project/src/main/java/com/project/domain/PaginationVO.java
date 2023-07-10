package com.project.domain;

import javax.servlet.http.HttpSession;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PaginationVO {
	private int pageId;
	private int pageSize = 5;
	private int totalCount;
	private int pageCount;
	
	private int start;
	private int end;
	
	private int pagingBlock = 5;
	private int prevBlock;
	private int nextBlock;
	
	public void init(HttpSession session) {
		if(session != null)
			session.setAttribute("pageSize", pageSize);
		
		pageCount = (totalCount-1) / pageSize + 1;
		
		if(pageId < 1 )
			pageId = 1;	
		if(pageId > pageCount)
			pageId = pageCount;
		
		start = (pageId-1) * pageSize;
		end = pageId * pageSize + 1;
		
		prevBlock = (pageId - 1)/pagingBlock * pagingBlock;
		nextBlock = prevBlock + (pagingBlock + 1);
	}
	
	public String getReviewPageNavi(String myctx, String loc, String sort) {		
		StringBuilder buf = new StringBuilder("<ul class=\"pagination justify-content-center\">");
		if(prevBlock > 0) {
			buf.append("<li class=\"page-item\">");
			if(sort.equals("none"))
				buf.append("<a class='page-link' href='/community?pageId="+prevBlock+"'>");
			else
				buf.append("<a class='page-link' href='/community?sort="+sort+"&pageId="+prevBlock+"'>");
			buf.append("Prev")
			.append("</a>")
			.append("</li>");
		}
		for(int i=prevBlock+1; i<=nextBlock-1 && i<=pageCount; i++) {
			String css = (i == pageId)? "active":"";
			buf.append("<li class='page-item "+css+"'>");
			if(sort.equals("none"))
				buf.append("<a class='page-link' href='/community?pageId="+i+"'>");
			else
				buf.append("<a class='page-link' href='/community?sort="+sort+"&pageId="+i+"'>");
			buf.append(i)
			.append("</a>")
			.append("</li>");
		}
		if(nextBlock <= pageCount) {
			buf.append("<li class=\"page-item\">");
			if(sort.equals("none"))
				buf.append("<a class='page-link' href='/community?pageId="+nextBlock+"'>");
			else
				buf.append("<a class='page-link' href='/community?sort="+sort+"&pageId="+nextBlock+"'>");
			buf.append("Next")
			.append("</a>")
			.append("</li>");
		}
		buf.append("</ul>");
		
		return buf.toString();
	}
	
	public String getNoticePageNavi(String myctx, String loc) {		
		StringBuilder buf = new StringBuilder("<ul class=\"pagination justify-content-center\">");
		if(prevBlock > 0) {
			buf.append("<li class=\"page-item\">")
			.append("<a class='page-link' href='/community/notice?pageId="+prevBlock+"'>")
			.append("Prev")
			.append("</a>")
			.append("</li>");
		}
		for(int i=prevBlock+1; i<=nextBlock-1 && i<=pageCount; i++) {
			String css = (i == pageId)? "active":"";
			buf.append("<li class='page-item "+css+"'>")
			.append("<a class='page-link' href='/community/notice?pageId="+i+"'>")
			.append(i)
			.append("</a>")
			.append("</li>");
		}
		if(nextBlock <= pageCount) {
			buf.append("<li class=\"page-item\">")
			.append("<a class='page-link' href='/community/notice?pageId="+nextBlock+"'>")
			.append("Next")
			.append("</a>")
			.append("</li>");
		}
		buf.append("</ul>");
		
		return buf.toString();
	}
	
}
