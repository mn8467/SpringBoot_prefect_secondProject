package com.example.test_prefect.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.example.test_prefect.model.MessageVO;
import com.example.test_prefect.model.UserVO;
import com.example.test_prefect.service.MailSendService;
import com.example.test_prefect.service.SearchService;
import com.example.test_prefect.service.UserService;
import com.example.test_prefect.util.PcwkLogger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.google.gson.Gson;

@Controller
@RequestMapping("/user/search")
public class SearchController implements PcwkLogger {

	@Autowired
	SearchService searchEmailService;
	
	@Autowired
	private MailSendService mailService;
	
	@Autowired
	private UserService userService;

	public SearchController() {
	}

	@RequestMapping(value = "/searchEmailView.do")

	//이메일 찾기 창 띄우기
	public String searchEmail() {
		String view = "search/search_email";
		LOG.debug("이메일 찾기 창");

		return view;
	}

	//이름이랑 전화번호 확인
	@RequestMapping(value = "/searchEmail.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody // HTTP 요청 부분의 body부분이 그대로 브라우저에 전달된다.
	public String findEmail(UserVO user, HttpSession httpSession) throws SQLException {
		String jsonString = "";
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ findEmail                                 │user:" + user);
		LOG.debug("└───────────────────────────────────────────┘");

		MessageVO message = new MessageVO();

		// 입력 validation
		// 이름 null check
		if (null == user.getName() || "".equals(user.getName())) {
			message.setMsgId("1");
			message.setMsgContents("이름을 입력 하세요.");

			jsonString = new Gson().toJson(message);
			LOG.debug("jsonString:" + jsonString);
			return jsonString;
		}

		// 전화번호 null check
		if (null == user.getTel() || "".equals(user.getTel())) {
			message.setMsgId("2");
			message.setMsgContents("전화번호를 입력 하세요.");

			jsonString = new Gson().toJson(message);
			LOG.debug("jsonString:" + jsonString);
			return jsonString;
		}

		int check = searchEmailService.searchEmailCheck(user);
		if (10 == check) {// 이메일 확인
			message.setMsgId("10");
			message.setMsgContents("이름을 확인 하세요.");

		} else if (20 == check) {// 비번확인
			message.setMsgId("20");
			message.setMsgContents("전화번호를 확인 하세요.");

		} else if (30 == check) {
			UserVO outVO = searchEmailService.searchEmail(user);
			message.setMsgId("30");
			message.setMsgContents("찾으시는 이메일은:" + outVO.getEmail() + "입니다.");

			if (null != outVO) {
				httpSession.setAttribute("user", outVO);
			}
		} else {
			message.setMsgId("99");
			message.setMsgContents("오류가 발생 했습니다.");
		}
		jsonString = new Gson().toJson(message);
		LOG.debug("jsonString:" + jsonString);

		return jsonString;
	}

	//이메일 찾기 결과 창 띄우기
	@RequestMapping(value = "/searchEmailResultView.do")
	public String searchEmailResult() {
		String view = "search/search_result_email";
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ searchEmailResultView                     │");
		LOG.debug("└───────────────────────────────────────────┘");

		return view;
	}
	
	//비밀번호 변경 창 띄우기
	@RequestMapping(value = "/changePassword.do")
	public String searchPasswordResult(UserVO inVO, Model model) throws EmptyResultDataAccessException{
		String view = "search/change_password";
		UserVO user = userService.doSelectOne(inVO);
		
		model.addAttribute("user", user);	
		
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ changePasswordView                        │");
		LOG.debug("│ user                                      │" + user);
		LOG.debug("└───────────────────────────────────────────┘");

		return view;
	}

	//비밀번호 찾기 창 띄우기
	@RequestMapping(value = "/searchPasswordView.do")
	public String searchPassword() {
		String view = "search/search_password";
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ searchPassword                            │");
		LOG.debug("└───────────────────────────────────────────┘");

		return view;
	}
	
	//비밀번호 찾기 (이름, 이메일 인증하기)
	@RequestMapping(value = "/searchPassword.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody // HTTP 요청 부분의 body부분이 그대로 브라우저에 전달된다.
	public String findPassword(UserVO user, HttpSession httpSession) throws SQLException {
		String jsonString = "";
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ findPassword                              │user:" + user);
		LOG.debug("└───────────────────────────────────────────┘");

		MessageVO message = new MessageVO();

		// 입력 validation
		// 이름 null check
		if (null == user.getName() || "".equals(user.getName())) {
			message.setMsgId("1");
			message.setMsgContents("이름을 입력 하세요.");

			jsonString = new Gson().toJson(message);
			LOG.debug("jsonString:" + jsonString);
			return jsonString;
		}

		// 전화번호 null check
		if (null == user.getEmail() || "".equals(user.getEmail())) {
			message.setMsgId("2");
			message.setMsgContents("이메일을 입력 하세요.");

			jsonString = new Gson().toJson(message);
			LOG.debug("jsonString:" + jsonString);
			return jsonString;
		}

		int check = searchEmailService.emailCheckForPassword(user);
		if (10 == check) {// 이메일 확인
			message.setMsgId("10");
			message.setMsgContents("이름을 확인 하세요.");

		} else if (20 == check) {// 비번확인
			message.setMsgId("20");
			message.setMsgContents("이메일을 확인 하세요.");

		} else if (30 == check) {
			UserVO outVO = userService.doSelectOne(user);
			message.setMsgId("30");
			message.setMsgContents("찾으시는 이메일은:" + outVO.getEmail() + "입니다.");
			
			LOG.debug("outVO:" + outVO);
		} else {
			message.setMsgId("99");
			message.setMsgContents("오류가 발생 했습니다.");
		}
		jsonString = new Gson().toJson(message);
		LOG.debug("jsonString:" + jsonString);

		return jsonString;
	}
	
	//이메일 인증번호 보내기
	@RequestMapping(value="/findPassword.do",method = RequestMethod.GET
			,produces = "application/json;charset=UTF-8"
			)
	@ResponseBody// HTTP 요청 부분의 body부분이 그대로 브라우저에 전달된다.
	public String mailCheck(HttpServletRequest request) {
		String email = request.getParameter("email");
		
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ mailCheck()                               │email:"+email);
		LOG.debug("└───────────────────────────────────────────┘");	
		return mailService.findPassword(email);
		
	}

}