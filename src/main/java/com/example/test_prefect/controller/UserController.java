package com.example.test_prefect.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.example.test_prefect.model.*;
import com.example.test_prefect.service.CodeService;
import com.example.test_prefect.service.LicensesService;
import com.example.test_prefect.service.MailSendService;
import com.example.test_prefect.service.UserService;
import com.example.test_prefect.util.PcwkLogger;
import com.example.test_prefect.util.ShaUtil;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

@Controller
@RequestMapping("user") //url 시작
public class UserController implements PcwkLogger {

	@Autowired
	UserService userService;

	@Autowired
	CodeService codeService;

	@Autowired
	private MailSendService mailService;

	@Autowired
	LicensesService service;

	public UserController() {

	}

	// 이메일 인증
	@RequestMapping(value = "/mailCheck.do", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	@ResponseBody // HTTP 요청 부분의 body부분이 그대로 브라우저에 전달된다.
	public String mailCheck(HttpServletRequest request) {
		String email = request.getParameter("email");

		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ mailCheck()                               │email:" + email);
		LOG.debug("└───────────────────────────────────────────┘");
		return mailService.joinEmail(email);

	}

	// http://localhost:8080/user/idDuplicateCheck.do?userId='p8-03'
	@RequestMapping(value = "/emailDuplicateCheck.do", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	@ResponseBody // HTTP 요청 부분의 body부분이 그대로 브라우저에 전달된다.
	public String emailDuplicateCheck(UserVO inVO) throws SQLException {
		String jsonString = "";
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ emailDuplicateCheck()                     │inVO:" + inVO);
		LOG.debug("└───────────────────────────────────────────┘");

		int flag = userService.emailDuplicateCheck(inVO);
		String message = "";
		if (0 == flag) {
			message = inVO.getEmail() + "사용 가능한 아이디 입니다.";
		} else {
			message = inVO.getEmail() + "사용 불가한 아이디 입니다.";
		}
		MessageVO messageVO = new MessageVO(flag + "", message);
		jsonString = new Gson().toJson(messageVO);
		LOG.debug("jsonString:" + jsonString);
		return jsonString;
	}

	@RequestMapping(value = "/moveToReg.do", method = RequestMethod.GET)
	public String moveToReg(Model model) throws SQLException {
		String view = "user/user_reg";
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ moveToReg                                 │");
		LOG.debug("└───────────────────────────────────────────┘");

		// 코드목록 조회 : 'EDUCATION','ROLE'
		Map<String, Object> codes = new HashMap<String, Object>();
		String[] codeStr = { "EDUCATION", "ROLE", "GENDER" };

		codes.put("code", codeStr);
		List<CodeVO> codeList = this.codeService.doRetrieve(codes);
		List<CodeVO> educationList = new ArrayList<CodeVO>();
		List<CodeVO> roleList = new ArrayList<CodeVO>();
		List<CodeVO> genderList = new ArrayList<CodeVO>();

		for (CodeVO vo : codeList) {
			// EDUCATION
			if (vo.getMstCode().equals("EDUCATION")) {
				educationList.add(vo);
			}

			if (vo.getMstCode().equals("ROLE")) {
				roleList.add(vo);
			}

			if (vo.getMstCode().equals("GENDER")) {
				genderList.add(vo);
			}
			LOG.debug(vo);
		}

		LOG.debug("educationList");
		for (CodeVO vo : educationList) {
			LOG.debug(vo);
		}

		LOG.debug("roleList");
		for (CodeVO vo : roleList) {
			LOG.debug(vo);
		}

		LOG.debug("genderList");
		for (CodeVO vo : genderList) {
			LOG.debug(vo);
		}

		model.addAttribute("education", educationList);

		model.addAttribute("role", roleList);

		model.addAttribute("gender", genderList);

		return view;
	}

	// 목록조회
	// http://localhost:8080/user/doRetrieve.do?searchDiv=10&searchWord=점심시간
	@RequestMapping(value = "/doRetrieve.do", method = RequestMethod.GET)
	public String doRetrieve(UserVO searchVO, HttpServletRequest req, Model model) throws SQLException {
		String view = "user/user_list";
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doRetrieve                                │DTO:" + searchVO);
		LOG.debug("└───────────────────────────────────────────┘");

		// 검색 null처리 : null -> ""
		String searchDiv = StringUtil.nvl(req.getParameter("searchDiv"));
		String searchWord = StringUtil.nvl(req.getParameter("searchWord"));
		searchVO.setSearchDiv(searchDiv);
		searchVO.setSearchWord(searchWord);

		// 브라우저에서 숫자 : 문자로 들어 온다.
		// 페이지 사이즈: null -> 10
		// 페이지 번호: null -> 1
		String pageSize = StringUtil.nvl(req.getParameter("pageSize"), "10");
		String pageNo = StringUtil.nvl(req.getParameter("pageNo"), "1");

		long tPageNo = Long.parseLong(pageNo);
		long tPageSize = Long.parseLong(pageSize);

		long pageValue = (0 == tPageNo) ? 1 : tPageNo;
		searchVO.setPageNo(pageValue);

		long tPageSizeValue = (0 == tPageSize) ? 10 : tPageSize;
		searchVO.setPageSize(tPageSizeValue);

		LOG.debug("pageSize:" + searchVO.getPageSize());
		LOG.debug("pageNo:" + searchVO.getPageNo());

		LOG.debug("searchDiv:" + searchDiv);
		LOG.debug("searchWord:" + searchWord);

		LOG.debug("searchVO:" + searchVO);

		// 코드목록 조회 : 'PAGE_SIZE', 'USER_SEARCH', 'EDUCATION','ROLE'
		Map<String, Object> codes = new HashMap<String, Object>();
		String[] codeStr = { "PAGE_SIZE", "USER_SEARCH", "EDUCATION", "ROLE", "GENDER" };
		codes.put("code", codeStr);

		List<CodeVO> codeList = codeService.doRetrieve(codes);

		List<CodeVO> userSearchList = new ArrayList<CodeVO>();
		List<CodeVO> pageSizeList = new ArrayList<CodeVO>();
		List<CodeVO> educationList = new ArrayList<CodeVO>();
		List<CodeVO> roleList = new ArrayList<CodeVO>();
		List<CodeVO> genderList = new ArrayList<CodeVO>();

		for (CodeVO vo : codeList) {
			if (vo.getMstCode().equals("USER_SEARCH")) {
				userSearchList.add(vo);
			}

			if (vo.getMstCode().equals("PAGE_SIZE")) {
				pageSizeList.add(vo);
			}

			// EDUCATION
			if (vo.getMstCode().equals("EDUCATION")) {
				educationList.add(vo);
			}

			if (vo.getMstCode().equals("ROLE")) {
				roleList.add(vo);
			}
			if (vo.getMstCode().equals("GENDER")) {
				genderList.add(vo);
			}
			LOG.debug(vo);
		}

		// 검색조건 : USER_SEARCH
		model.addAttribute("userSearch", userSearchList);

		// 페이지사이즈
		model.addAttribute("pageSize", pageSizeList);

		model.addAttribute("education", educationList);

		model.addAttribute("role", roleList);

		model.addAttribute("gender", genderList);

		List<UserVO> list = this.userService.doRetrieve(searchVO);

		// 화면에 데이터 전달
		model.addAttribute("list", list);
		// 검색조건
		model.addAttribute("searchVO", searchVO);

		// paging
		long bottomCount = 10;// 바닥글
		long totalCnt = 0;
		for (UserVO vo : list) {
			if (totalCnt == 0) {
				totalCnt = vo.getTotalCnt();
				break;
			}
		}

		String html = StringUtil.renderingPager(totalCnt, searchVO.getPageNo(), searchVO.getPageSize(), bottomCount,
				"/user/doRetrieve.do", "pageDoRerive");
		model.addAttribute("pageHtml", html);

		return view;
	}

	@RequestMapping(value = "/doPauseUser.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody // HTTP 요청 부분의 body부분이 그대로 브라우저에 전달된다.
	public MessageVO doPauseUser(UserVO inVO, Model model) throws SQLException {
		MessageVO messageVO = null;

		int flag = userService.doPauseUser(inVO);

		String message = "";

		if (1 == flag) {
			message = "수정완료";
		} else {
			message = "수정실패";
		}

		messageVO = new MessageVO(flag + "", message);

		LOG.debug("│ messageVO                           │" + messageVO);

		return messageVO;
	}

	// 수정
	@RequestMapping(value = "/doUpdate.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody // HTTP 요청 부분의 body부분이 그대로 브라우저에 전달된다.
	public String doUpdate(UserVO inVO, Model model, HttpSession httpsession) throws SQLException {
		String jsonString = "";
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doUpdate()                                │inVO:" + inVO);
		LOG.debug("└───────────────────────────────────────────┘");

		int flag = userService.doUpdate(inVO);
		String message = "";
		if (1 == flag) {
			message = inVO.getEmail() + "가 수정 되었습니다.";
		} else {
			message = inVO.getEmail() + "수정 실패";
		}

		String role = (String) httpsession.getAttribute("role");
		model.addAttribute("role", role);
		LOG.debug("role:" + role);

		MessageVO messageVO = new MessageVO(flag + "", message);
		jsonString = new Gson().toJson(messageVO);
		LOG.debug("jsonString:" + jsonString);

		return jsonString;
	}

	// 수정
	@RequestMapping(value = "/doUpdatePassword.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody // HTTP 요청 부분의 body부분이 그대로 브라우저에 전달된다.
	public String doUpdatePassword(UserVO inVO) throws SQLException {
		String jsonString = "";

		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doUpdatePassword()                        │inVO:" + inVO);
		LOG.debug("└───────────────────────────────────────────┘");

		// SHA-256 + salt를 사용한 비밀번호 암호화 (2024-02-13)
		String salt = ShaUtil.generateSalt();     //원래의 비밀번호를 찾아주는 것이 아닌 비밀번호를 새로 생성하는 방식으로 비밀번호 찾기를 구현
		inVO.setSalt(salt);						  // 새로운 salt 코드를 만들어 inVO에 넣어줌
		String raw = inVO.getPassword();		  // inVO에 새로운 패스워드를 넣고 raw에 대입
		String rawAndSalt = raw + salt;			  // 원래있던 비밀번호와 생성된 salt 값을 합쳐 rawAndSalt에 대입
		String hex = ShaUtil.hash(rawAndSalt);    // rawAndSalt를 com.pcwk.util에 정의된 hash() 메서드로 해시
		inVO.setPassword(hex);  				  // 해시된 코드를 inVO의 비밀번호 컬럼에 저장
		//

		int flag = userService.doUpdatePassword(inVO);
		String message = "";
		if (1 == flag) {
			message = inVO.getEmail() + "가 수정 되었습니다.";
		} else {
			message = inVO.getEmail() + "수정 실패";
		}
		MessageVO messageVO = new MessageVO(flag + "", message);
		jsonString = new Gson().toJson(messageVO);
		LOG.debug("jsonString:" + jsonString);

		return jsonString;
	}

	@RequestMapping(value = "/doSelectOne.do", method = RequestMethod.GET)
	public String doSelectOne(UserVO inVO, HttpServletRequest req, Model model, HttpSession httpSession)
			throws SQLException, EmptyResultDataAccessException {
		String view = "user/user_mod";
		String email = "";

		UserVO userSession = new UserVO();

		// user 세션에 들어있는 user정보가null이 아니면, 세션에 user정보를 userVO타입의 user에 담고 그 이메일을 세팅해서
		// 서비스를 호출해서 doSelectOne을 돌린 결과가 userSession이 되고 그 것을 화면으로 뿌림.
		if (null != httpSession.getAttribute("user")) {
			UserVO user = (UserVO) httpSession.getAttribute("user");
			user.setEmail(user.getEmail());
			userSession = this.userService.doSelectOne(user);
		}

		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doSelectOne()                             │inVO:" + inVO);
		LOG.debug("└───────────────────────────────────────────┘");

		// 서비스 호출하고 inVO를 doSelectOne한 결과. outVO
		UserVO outVO = this.userService.doSelectOne(inVO);
		LOG.debug("│ outVO                                :" + outVO);

		// outVO가 null이 아니면 outVO를 화면으로 보내고 null이면 userSession을 화면으로 보낸다.
		if (outVO != null) {
			model.addAttribute("outVO", outVO);
		} else {
			model.addAttribute("userSession", userSession);
		}

		// 코드목록 조회 : 'EDUCATION','ROLE'
		Map<String, Object> codes = new HashMap<String, Object>();
		String[] codeStr = { "EDUCATION", "ROLE", "GENDER" };

		codes.put("code", codeStr);
		List<CodeVO> codeList = this.codeService.doRetrieve(codes);

		List<CodeVO> educationList = new ArrayList<CodeVO>();
		List<CodeVO> roleList = new ArrayList<CodeVO>();
		List<CodeVO> genderList = new ArrayList<CodeVO>();

		for (CodeVO vo : codeList) {
			// EDUCATION
			if (vo.getMstCode().equals("EDUCATION")) {
				educationList.add(vo);
			}

			if (vo.getMstCode().equals("ROLE")) {
				roleList.add(vo);
			}
			if (vo.getMstCode().equals("GENDER")) {
				genderList.add(vo);
			}
			LOG.debug(vo);
		}

		LOG.debug("educationList");
		for (CodeVO vo : educationList) {
			LOG.debug(vo);
		}

		LOG.debug("roleList");
		for (CodeVO vo : roleList) {
			LOG.debug(vo);
		}

		LOG.debug("genderList");
		for (CodeVO vo : genderList) {
			LOG.debug(vo);
		}

		model.addAttribute("education", educationList);

		model.addAttribute("role1", roleList); // header 의 ${role}과 겹쳐서 이름 바꿨음
		model.addAttribute("gender", genderList);

		// 자격증을 담았다.
		List<LicensesVO> licenses = new ArrayList<LicensesVO>();
		licenses = service.getLicensesName();

		// 화면으로 뿌린다.
		model.addAttribute("licenses", licenses);

		// 유저 자격증을 담았다.
		List<LicensesVO> userLicenses = new ArrayList<LicensesVO>();
		userLicenses = service.getUserLicenses(inVO);

		// 유저 자격증을 뿌린다.
		model.addAttribute("userLicenses", userLicenses);

		String role = (String) httpSession.getAttribute("role");
		model.addAttribute("role", role);
		LOG.debug("role :" + role);

		return view;

	}

	// 삭제
	// GET방식 요청: http://localhost:8080/user/doDelete.do?userId=pcwk
	@RequestMapping(value = "/doDelete.do", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String doDelete(UserVO inVO, HttpServletRequest req) throws SQLException {
		String jsonString = "";
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doDelete()                                │inVO:" + inVO);
		LOG.debug("└───────────────────────────────────────────┘");
		String userId = req.getParameter("Email");
		LOG.debug("│ userId                                :" + userId);

		int flag = userService.doDelete(inVO);
		String message = "";

		if (1 == flag) {
			message = inVO.getEmail() + "가 삭제 되었습니다.";
		} else {
			message = inVO.getEmail() + " 삭제 실패.";
		}

		MessageVO messageVO = new MessageVO(String.valueOf(flag), message);
		jsonString = new Gson().toJson(messageVO);

		LOG.debug("jsonString:" + jsonString);
		return jsonString;
	}

	// 등록
	@RequestMapping(value = "/doSave.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody // HTTP 요청 부분의 body부분이 그대로 브라우저에 전달된다.
	public String doSave(UserVO inVO) throws SQLException {
		String jsonString = "";
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doSave()                                  │inVO:" + inVO);
		LOG.debug("└───────────────────────────────────────────┘");

		// SHA-256 + salt를 사용한 비밀번호 암호화 (2024-02-13)
		String salt = ShaUtil.generateSalt();     // package : com.pcwk.ehr.util의 ShaUtil에 정의된 generateSalt() 메서드로 salt 생성

		inVO.setSalt(salt);  					  // 새로운 계정에 대한 salt 설정
		String raw = inVO.getPassword(); 		  // 계정의 비밀번호를 raw 문자열에 저장
		String rawAndSalt = raw + salt;           // 계정 비밀번호와 salt 를 합쳐 rawAndSalt 라는 새로운 문자열에 저장
		String hex = ShaUtil.hash(rawAndSalt);    // rawAndSalt를 해시
		inVO.setPassword(hex);  				  // 해시된 비밀번호를 저장
		LOG.debug("inVO :" + inVO);

		int flag = userService.doSave(inVO);
		String message = "";

		if (1 == flag) {
			message = inVO.getEmail() + "가 등록 되었습니다.";
		} else {
			message = inVO.getEmail() + "등록 실패.";
		}

		MessageVO messageVO = new MessageVO(flag + "", message);
		jsonString = new Gson().toJson(messageVO);
		LOG.debug("jsonString:" + jsonString);

		return jsonString;
	}

	@GetMapping(value = "/doMemberPopup.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public List<UserVO> doMemberPopup(UserVO searchVO, HttpServletRequest req, Model model) throws SQLException {
		String view = "user/user_list";
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doMemberPopup                             │DTO:" + searchVO);
		LOG.debug("└───────────────────────────────────────────┘");

		// 검색 null처리 : null -> ""
		String searchDiv = StringUtil.nvl(req.getParameter("searchDiv"));
		String searchWord = StringUtil.nvl(req.getParameter("searchWord"));
		searchVO.setSearchDiv(searchDiv);
		searchVO.setSearchWord(searchWord);

		// 브라우저에서 숫자 : 문자로 들어 온다.
		// 페이지 사이즈: null -> 10
		// 페이지 번호: null -> 1
		String pageSize = StringUtil.nvl(req.getParameter("pageSize"), "10");
		String pageNo = StringUtil.nvl(req.getParameter("pageNo"), "1");

		long tPageNo = Long.parseLong(pageNo);
		long tPageSize = Long.parseLong(pageSize);

		long pageValue = (0 == tPageNo) ? 1 : tPageNo;
		searchVO.setPageNo(pageValue);

		long tPageSizeValue = (0 == tPageSize) ? 10 : tPageSize;
		searchVO.setPageSize(tPageSizeValue);

		LOG.debug("pageSize:" + searchVO.getPageSize());
		LOG.debug("pageNo:" + searchVO.getPageNo());

		LOG.debug("searchDiv:" + searchDiv);
		LOG.debug("searchWord:" + searchWord);

		LOG.debug("searchVO:" + searchVO);

		List<UserVO> list = this.userService.doRetrieve(searchVO);

		for (UserVO vo : list) {
			LOG.debug("vo:" + vo);
		}

		return list;
	}


}
