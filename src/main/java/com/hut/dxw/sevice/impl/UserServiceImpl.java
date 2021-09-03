package com.hut.dxw.sevice.impl;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.hut.dxw.mapper.UsersMapper;
import com.hut.dxw.pojo.Users;
import com.hut.dxw.pojo.UsersExample;
import com.hut.dxw.pojo.UsersExample.Criteria;
import com.hut.dxw.sevice.UserService;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	UsersMapper usersMapper;
	@Override
	public boolean findUsername(String username) {
		//创建users实例类
		UsersExample ue = new UsersExample();
		
		Criteria criteria = ue.createCriteria();
		criteria.andUsernameEqualTo(username);
		//查询结果
		List<Users> list = usersMapper.selectByExample(ue);
		if (list.isEmpty()) {
			return true;
		}
		return false;
	}
	
	@Override
	public boolean findEmail(String email) {
		System.out.println(email);
		//创建users实例类
		UsersExample ue = new UsersExample();
		
		Criteria criteria = ue.createCriteria();
		criteria.andEmailEqualTo(email);
		//查询结果
		List<Users> list = usersMapper.selectByExample(ue);
		if (list.isEmpty()) {
			return true;
		}
		return false;
	}
	
	@Override
	public int addUsers(Users users) {
		users.setStatus(1);
		users.setModifytime(new Date());
		int i = usersMapper.insertSelective(users);
		return i;
	}
	
	@Override
	public boolean UserLogin(Users users, String verify, HttpSession session, Model model) {
		//判断验证码是否正确
		if(!verify.equalsIgnoreCase(session.getAttribute("verifyCode").toString())) {
			//验证码错误
			model.addAttribute("message","验证码输入错误");
			//返回结果
			return false;
		}
		
		//创建users的实例类
		UsersExample ue = new UsersExample();
		//创建users的条件类
		Criteria criteria = ue.createCriteria();
		//通过用户登录名称判断是否有该用户
		criteria.andUsernameEqualTo(users.getUsername());
		//获取查询结果
		List<Users> list = usersMapper.selectByExample(ue);
		//判断是否有该用户
		if(!list.isEmpty()) {
			//如果有这个用户取出这个用户
			Users user = list.get(0);
			//判断密码是否正确
			if(user.getPassword().equals(users.getPassword())) {
				//判断当前用户的状态
				if(user.getStatus() == 1) {
					//登陆成功,将当前用户数据存放到session
					session.setAttribute("login", user);
					//告诉调用者，登陆成功
					return true;
				}else {
					//当前账户被禁用
					model.addAttribute("message", "对不起，您的账号被禁用，请联系管理员！");
				}
			}else {
				//密码错误  登陆失败
				model.addAttribute("message","用户输入的密码错误，请重新输入！");
			}
		}else {//是空的  表示没有这个用户
			//告诉前台  没有这个用户
			model.addAttribute("message","没有这个用户，请注册后登陆");
		}
		return false;
	}
}
