package kr.co.reo.common.util;

public class PageUtil {

	private final int ROW_PER_PAGE = 10; // 페이지당 레코드 출력 갯수
	private final int PAGE_PER_PAGE = 10; // 화면당 페이지 출력 갯수

	public int getLimit() {
		return ROW_PER_PAGE;
	}

	public int getOffset(int pageNo) {
		return (pageNo - 1) * ROW_PER_PAGE;
	}

	public int getTotalPages(int totalRows) {
		return (int) Math.ceil((double) totalRows / ROW_PER_PAGE);
	}

	public int ablePageNo(int pageNo, int totalRows) {
		int totalPages = getTotalPages(totalRows); // 전체 페이지 갯수
		if (pageNo > totalPages) { // 최대 페이지 갯수보다 큰 페이지번호가 들어오면 마지막 페이지 번호로
			pageNo = totalPages;
		}
		if (pageNo < 1) {
			pageNo = 1;
		}
		return pageNo;
	}

	public String paging(int pageNo, int totalRows, String uri, String query) { // 현재 페이지 번호, 전체 레코드 수, uri, 쿼리스트링
		String str = "";

		if (totalRows < 1) {
			return null;
		}

		if (query == null || query.equals("")) {
			query = "";
		} else if (!query.startsWith("&")) {
			query = "&" + query;
		}

		int totalPages = (int) Math.ceil((double) totalRows / ROW_PER_PAGE); // 전체 페이지 갯수

		// 페이지그룹 처리
		int totalRanges = (int) Math.ceil((double) totalPages / PAGE_PER_PAGE); // 전체 페이지그룹 갯수
		int currentRange = (int) Math.ceil((double) pageNo / PAGE_PER_PAGE); // 현재 페이지 그룹 번호

		// 현재 페이지 그룹의 페이지 번호
		int beginPage = (currentRange - 1) * PAGE_PER_PAGE + 1; // 시작 페이지 번호
		int endPage = currentRange * PAGE_PER_PAGE; // 마지막 페이지 번호

		if (currentRange == totalRanges) { // currentRange가 맨 마지막 range인 경우
			endPage = totalPages;
		}

		int prevPage = 0;
		if (currentRange != 1) {
			prevPage = (currentRange - 2) * PAGE_PER_PAGE + 1;
		}
		int nextPage = 0;
		if (currentRange != totalRanges) {
			nextPage = currentRange * PAGE_PER_PAGE + 1;
		}

		if (prevPage != 0) {
			str += "<ul class='pagination justify-content-center'><li class='page-item'><a href='" + uri + "?pageNo=1" + query
					+ "' class='page-link' aria-label='First'><span class='fas fa-angle-double-left' aria-hidden='true'></span><span class='sr-only'>First</span></a></li><li class='page-item'><a href='"
					+ uri + "?pageNo=" + prevPage + query
					+ "' class='page-link' aria-label='Previous'><span class='fas fa-angle-left' aria-hidden='true'></span><span class='sr-only'>Previous</span></a></li>";
		} else {
			str += "<ul class='pagination justify-content-center'>";
		}
		for (int i = beginPage; i <= endPage; i++) {
			if (pageNo == i) {
				str += "<li class='page-item active'><span class='page-link'>" + i + " </span></li>";
			} else {
				str += "<li class='page-item'><a href='" + uri + "?pageNo=" + i + query + "' class='page-link'>" + i + "</a></li>";
			}
		}
		if (nextPage != 0) {
			str += "<li class='page-item'><a href='" + uri + "?pageNo=" + nextPage + query
					+ "' class='page-link' aria-label='Next'><span class='fas fa-angle-right' aria-hidden='true'></span><span class='sr-only'>Next</span></a></li><li class='page-item'><a href='"
					+ uri + "?pageNo=" + totalPages + query + "' class='page-link' aria-label='Last'><span class='fas fa-angle-double-right' aria-hidden='true'></span><span class='sr-only'>Last</span></a></li></ul>";
		} else {
			str += "</ul>";
		}

		return str;
	}
}