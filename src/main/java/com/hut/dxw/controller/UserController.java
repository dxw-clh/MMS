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
	
	//�鿴��ǰ�û����Ƿ��ظ�
	@RequestMapping("/findUsername")
	@ResponseBody
	public boolean findUsername(String username) {
		//��ҵ����ж��û����Ƿ��ظ�
		boolean b1 = userService.findUsername(username);
		//���������ǰ̨
		return b1;
	}
	
	//�鿴��ǰ�����Ƿ��ظ�
	@RequestMapping("/findEmail")
	@ResponseBody
	public boolean findEmail(String email) {
		//��ҵ����ж��û����Ƿ��ظ�
		boolean b1 = userService.findEmail(email);
		//���������ǰ̨
		return b1;
	}
	
	@RequestMapping("/regist")
	public String UserRegist(Users users) {
		//ҵ������ע�᷽��
		int i = userService.addUsers(users);
		//���ݲ�ͬ�����ת��ͬҳ��
		if (i==1) {
			return "forward:/login.jsp";
		}else{
			return "forward:/regist.jsp";
		}
	}
	
	//�û���¼�취
	@RequestMapping("/Login")
	public String UserLogin(Users users, String verify, HttpSession session, Model model) {
		//ҵ������ע�᷽��
		boolean b1 = userService.UserLogin(users,verify,session,model);
		//���ݲ�ͬ�����ת��ͬҳ��
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
