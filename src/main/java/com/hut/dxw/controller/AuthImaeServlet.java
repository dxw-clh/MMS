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

	//��д����ķ���
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//����ͷ������Ϣ  ��ʹ�û���
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		response.setContentType("image/jpeg");
		//������֤�������ַ���
		String verifyCode = VerifyCodeUtils.generateVerifyCode(4);
		//��ȡsession����
		HttpSession session = request.getSession();
		//��ԭ�е�����ɾ��  ��ֹˢ����֤�� �����޸����� //����֤�����ݴ�ŵ�session
		session.removeAttribute("verifyCode");
		session.setAttribute("verifyCode", verifyCode);
		//����ͼƬ
		int w = 100 , h = 30;
		VerifyCodeUtils.outputImage(w, h, response.getOutputStream(), verifyCode);
	}
}
