package com.hut.dxw.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hut.dxw.pojo.Users;
import com.hut.dxw.pojo.UsersExample;
import com.hut.dxw.pojo.UsersExample.Criteria;
import com.hut.dxw.sevice.UserService;

@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	UserService userService;
	
	//查看当前用户名是否重复
	@RequestMapping("/findUsername")
	@ResponseBody
	public boolean findUsername(String username) {
		//在业务层判定用户名是否重复
		boolean b1 = userService.findUsername(username);
		//将结果返回前台
		return b1;
	}
	
	//查看当前邮箱是否重复
	@RequestMapping("/findEmail")
	@ResponseBody
	public boolean findEmail(String email) {
		//在业务层判定用户名是否重复
		boolean b1 = userService.findEmail(email);
		//将结果返回前台
		return b1;
	}
	
	@RequestMapping("/regist")
	public String UserRegist(Users users) {
		//业务层完成注册方法
		int i = userService.addUsers(users);
		//根据不同结果跳转不同页面
		if (i==1) {
			return "forward:/login.jsp";
		}else{
			return "forward:/regist.jsp";
		}
	}
	
	//用户登录办法
	@RequestMapping("/Login")
	public String UserLogin(Users users, String verify, HttpSession session, Model model) {
		//业务层完成注册方法
		boolean b1 = userService.UserLogin(users,verify,session,model);
		//根据不同结果跳转不同页面
		if (b1) {
			return "forward:/index.jsp";
		}else{
			return "forward:/login.jsp";
		}
	}
	
	@RequestMapping("/logout")
	public String UserLogout() {
		return "forward:/login.jsp";
	}
}
