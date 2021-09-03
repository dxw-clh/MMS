package com.hut.dxw.sevice;

import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

import com.hut.dxw.pojo.Users;

public interface UserService {
	
	boolean findUsername(String username);

	boolean findEmail(String email);

	int addUsers(Users users);

	boolean UserLogin(Users users, String verify, HttpSession session, Model model);

}
