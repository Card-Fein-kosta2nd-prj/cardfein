package cardfein.kro.kr.dto;

public class PageCnt {
	public static final int PAGE_SIZE = 4; // 한 페이지에 보여줄 게시글 수
	public static final int BLOCK_COUNT = 5; // 한 번에 보여줄 페이지 번호 수

	private int totalCount; // 전체 게시글 수
	private int pageNo; // 현재 페이지 번호
	private int pageCnt; // 전체 페이지 수

	private int startPage; // 현재 블록 시작 페이지 번호
	private int endPage; // 현재 블록 끝 페이지 번호

	public PageCnt(int totalCount, int pageNo) {
		this.totalCount = totalCount;
		this.pageNo = pageNo;

		// 전체 페이지 수 계산
		this.pageCnt = (int) Math.ceil((double) totalCount / PAGE_SIZE);

		// 시작 페이지 번호 계산 (1, 6, 11, ...)
		this.startPage = ((pageNo - 1) / BLOCK_COUNT) * BLOCK_COUNT + 1;

		// 끝 페이지 번호 계산 (5, 10, 15, ...)
		this.endPage = startPage + BLOCK_COUNT - 1;

		// 끝 페이지가 전체 페이지 수보다 클 수 없으므로 보정
		if (endPage > pageCnt) {
			endPage = pageCnt;
		}
	}

	// 조회 시작 offset (LIMIT에서 사용)
	public int getStartRow() {
		return (pageNo - 1) * PAGE_SIZE;
	}

	// Getter
	public int getPageSize() {
		return PAGE_SIZE;
	}

	public int getBlockCount() {
		return BLOCK_COUNT;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public int getPageNo() {
		return pageNo;
	}

	public int getPageCnt() {
		return pageCnt;
	}

	public int getStartPage() {
		return startPage;
	}

	public int getEndPage() {
		return endPage;
	}
}
