package com.example.test_prefect.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpSession;

import com.example.test_prefect.mapper.LoginDao;
import com.example.test_prefect.model.MessageVO;
import com.example.test_prefect.model.UserVO;
import com.example.test_prefect.service.CodeService;
import com.example.test_prefect.service.LoginService;
import com.example.test_prefect.service.UserService;
import com.example.test_prefect.util.PcwkLogger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;


@Controller
@RequestMapping("login")
public class LoginController implements PcwkLogger {

	@Autowired
	LoginService loginService;

	@Autowired
	LoginDao loginDao;

	@Autowired
	UserService userService;

	@Autowired
	CodeService codeService;

	public LoginController() {
	}

	@RequestMapping(value = "/loginView.do")
	public String loginView() {
		String view = "login/login";
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ loginView                                 │");
		LOG.debug("└───────────────────────────────────────────┘");

		return view;
	}

	
	@RequestMapping(value="/doLogin.do", method = RequestMethod.POST
			,produces = "application/json;charset=UTF-8"
			)
	@ResponseBody// HTTP 요청 부분의 body부분이 그대로 브라우저에 전달된다.
	public String doLogin(UserVO user, HttpSession httpSession)throws SQLException{
		String jsonString = "";
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doLogin                                   │user:"+user);
		LOG.debug("└───────────────────────────────────────────┘");				
		
		MessageVO message =new MessageVO();
		
		//입력 validation
		//id null check 
		if(null == user.getEmail() || "".equals(user.getEmail())) {
			message.setMsgId("1");
			message.setMsgContents("아이디를 입력 하세요.");
			
			jsonString = new Gson().toJson(message);
			LOG.debug("jsonString:"+jsonString);
			return jsonString;
		}
		
		
		//pass null check
		if(null == user.getPassword()|| "".equals(user.getPassword())) {
			message.setMsgId("2");
			message.setMsgContents("비밀번호를 입력 하세요.");
			
			jsonString = new Gson().toJson(message);
			LOG.debug("jsonString:"+jsonString);
			return jsonString;
		}		
		
		  
	    int check = loginService.loginCheck(user);
	    if(10==check) {//id확인
	    	message.setMsgId("10");
			message.setMsgContents("아이디를 확인 하세요.");
			
	    }else if(20==check) {//비번확인
	    	message.setMsgId("20");
			message.setMsgContents("비번을 확인 하세요.");	    	
		
	    }else if(30==check) {//비번확인
	    	UserVO outVO = loginService.doSelectOne(user);
	    	String role = outVO.getRole();
	    	
			LOG.debug("role:"+role);
			LOG.debug("outVO.getStatus():"+outVO.getStatus());
			
	    	if(outVO.getStatus().equals("1")) {
	    		message.setMsgId("30");
				message.setMsgContents(outVO.getName()+"님 반갑습니다.");	
				httpSession.setAttribute("user", outVO);
				httpSession.setAttribute("role", role);
	    	}
	    	else {
	    		message.setMsgId("40");
	    		message.setMsgContents(outVO.getName()+"님은 활동정지되었습니다.");	
	    	}
	    }else {
	    	message.setMsgId("99");
			message.setMsgContents("오류가 발생 했습니다.");	   	    	
	    }
	    jsonString = new Gson().toJson(message);
		LOG.debug("jsonString:"+jsonString);
		
		return jsonString;
	}
	@RequestMapping(value = "/doLogout.do")
	public String logout(HttpSession session) {
		//logout의 메인기능 - session 정리해주고 로그아웃처리가 되었을때 return 부분에서 다시 로그인페이지로 처리
		session.invalidate();
		
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ loginView                                 │");
		LOG.debug("└───────────────────────────────────────────┘");

		return "redirect:/login/loginView.do";
	}

}
