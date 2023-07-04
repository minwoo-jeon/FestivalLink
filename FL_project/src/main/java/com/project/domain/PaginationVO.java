package com.project.domain;

import javax.servlet.http.HttpSession;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PaginationVO {
    
	private String keyword;
	
	private int pageId;
    private int pageSize = 12;
    private int totalCount;
    private int pageCount;
    
    private int start;
    private int end;
    
    private int pagingBlock = 5;
    private int prevBlock;
    private int nextBlock;
    
    
    public void init(HttpSession session) {
        if (session != null)
            session.setAttribute("pageSize", pageSize);
        
        pageCount = (totalCount - 1) / pageSize + 1;
        
        if (pageId < 1)
            pageId = 1;
        if (pageId > pageCount)
            pageId = pageCount;
        
       // start = (pageId - 1) * pageSize;
       // end = start + pageSize;
        end = pageId*pageSize;
        start=end-(pageSize-1);
        prevBlock = (pageId - 1) / pagingBlock * pagingBlock;
        nextBlock = prevBlock + (pagingBlock + 1);
    }
    
    public String getPageNavi(String myctx, String loc) {
    	if(keyword==null)keyword="";
        StringBuilder buf = new StringBuilder("<ul class=\"pagination justify-content-center\">");
        if (prevBlock > 0) {
            buf.append("<li class=\"page-item\">")
               .append("<a class='page-link' href='/search?keyword="+keyword+"&pageId=" + prevBlock + "'>")
               .append("Prev")
               .append("</a>")
               .append("</li>");
        }
        for (int i = prevBlock + 1; i <= nextBlock - 1 && i <= pageCount; i++) {
            String css = (i == pageId) ? "active" : "";
            buf.append("<li class='page-item " + css + "'>")
               .append("<a class='page-link' href='/search?keyword="+keyword+"&pageId=" + i + "'>")
               .append(i)
               .append("</a>")
               .append("</li>");
        }
        if (nextBlock <= pageCount) {
            buf.append("<li class=\"page-item\">")
               .append("<a class='page-link' href='/search?keyword="+keyword+"&pageId=" + nextBlock + "'>")
               .append("Next")
               .append("</a>")
               .append("</li>");
        }
        buf.append("</ul>");
        
        return buf.toString();
    }
}
