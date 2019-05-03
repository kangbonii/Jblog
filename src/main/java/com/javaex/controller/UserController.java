package com.javaex.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.javaex.service.UserService;
import com.javaex.vo.UserVo;


@Controller
@RequestMapping(value="/user")
public class UserController {
	
	@Autowired
	private UserService userService;
	
	
	@RequestMapping(value="/main", method=RequestMethod.GET)
	public String main() {
		
		return "main/index";
	}
	@RequestMapping(value="/joinform", method=RequestMethod.GET)
	public String joinform() {
		
		return "user/joinForm";
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String join(@ModelAttribute UserVo uservo) {
		System.out.println(uservo.toString());
		int count = userService.join(uservo);
		return "user/joinSuccess";
	}
	
	@ResponseBody
	@RequestMapping(value="/emailcheck", method = RequestMethod.POST)
	public boolean emailCheck(@RequestParam("id") String id) {
		System.out.println(id);
		boolean result = userService.emailCheck(id);
		return result;
	}
	
	@RequestMapping(value="/loginform", method=RequestMethod.GET)
	public String loginform() {
		
		return "user/loginForm";
	}
	
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String login(@RequestParam("id") String id, 
						@RequestParam("password") String password,
						HttpSession session) {
		UserVo authUser = userService.login(id, password);
		System.out.print(authUser);
		if(authUser != null) {//로그인 성공
			session.setAttribute("authUser", authUser);
			return "redirect:/user/main";
		}else {//로그인 실패
			return "redirect:/user/loginform?result=fail";
		}
		
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.removeAttribute("authUser");
		session.invalidate();
		return "redirect:/user/main";
	}
	
}
