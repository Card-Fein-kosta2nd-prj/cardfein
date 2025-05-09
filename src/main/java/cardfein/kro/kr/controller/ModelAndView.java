package cardfein.kro.kr.controller;

/**
 * 	각 요청에 대한 처리를 한 후 최종적으로 이동할
 * 	뷰 정보와 이동방식에 대한 속성을 관리하는 객체
 */
public class ModelAndView {
	private String viewName;	// 이동할 뷰 이름
	private boolean redirect;	//  이동할 방식 (true이면 redirect, false이면 forward)
	
	public ModelAndView() {}
	
	public ModelAndView(String viewName) {
		this.viewName = viewName;
	}
	
	public ModelAndView(String viewName, boolean redirect) {
		this(viewName);
		this.redirect = redirect;
	}

	public String getViewName() {
		return viewName;
	}

	public void setViewName(String viewName) {
		this.viewName = viewName;
	}

	public boolean isRedirect() {
		return redirect;
	}

	public void setRedirect(boolean redirect) {
		this.redirect = redirect;
	}
}
