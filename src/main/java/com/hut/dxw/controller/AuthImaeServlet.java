package com.hut.dxw.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hut.dxw.utils.VerifyCodeUtils;

@WebServlet("/authImage")
public class AuthImaeServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;

	//重写服务的方法
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//设置头部的信息  不使用缓存
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		response.setContentType("image/jpeg");
		//生成验证码的随机字符串
		String verifyCode = VerifyCodeUtils.generateVerifyCode(4);
		//获取session对象
		HttpSession session = request.getSession();
		//将原有的数据删除  防止刷新验证码 重新修改数据 //将验证码数据存放到session
		session.removeAttribute("verifyCode");
		session.setAttribute("verifyCode", verifyCode);
		//生成图片
		int w = 100 , h = 30;
		VerifyCodeUtils.outputImage(w, h, response.getOutputStream(), verifyCode);
	}
}
