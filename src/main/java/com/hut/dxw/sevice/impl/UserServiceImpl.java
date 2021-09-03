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
		//����usersʵ����
		UsersExample ue = new UsersExample();
		
		Criteria criteria = ue.createCriteria();
		criteria.andUsernameEqualTo(username);
		//��ѯ���
		List<Users> list = usersMapper.selectByExample(ue);
		if (list.isEmpty()) {
			return true;
		}
		return false;
	}
	
	@Override
	public boolean findEmail(String email) {
		System.out.println(email);
		//����usersʵ����
		UsersExample ue = new UsersExample();
		
		Criteria criteria = ue.createCriteria();
		criteria.andEmailEqualTo(email);
		//��ѯ���
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
		//�ж���֤���Ƿ���ȷ
		if(!verify.equalsIgnoreCase(session.getAttribute("verifyCode").toString())) {
			//��֤�����
			model.addAttribute("message","��֤���������");
			//���ؽ��
			return false;
		}
		
		//����users��ʵ����
		UsersExample ue = new UsersExample();
		//����users��������
		Criteria criteria = ue.createCriteria();
		//ͨ���û���¼�����ж��Ƿ��и��û�
		criteria.andUsernameEqualTo(users.getUsername());
		//��ȡ��ѯ���
		List<Users> list = usersMapper.selectByExample(ue);
		//�ж��Ƿ��и��û�
		if(!list.isEmpty()) {
			//���������û�ȡ������û�
			Users user = list.get(0);
			//�ж������Ƿ���ȷ
			if(user.getPassword().equals(users.getPassword())) {
				//�жϵ�ǰ�û���״̬
				if(user.getStatus() == 1) {
					//��½�ɹ�,����ǰ�û����ݴ�ŵ�session
					session.setAttribute("login", user);
					//���ߵ����ߣ���½�ɹ�
					return true;
				}else {
					//��ǰ�˻�������
					model.addAttribute("message", "�Բ��������˺ű����ã�����ϵ����Ա��");
				}
			}else {
				//�������  ��½ʧ��
				model.addAttribute("message","�û����������������������룡");
			}
		}else {//�ǿյ�  ��ʾû������û�
			//����ǰ̨  û������û�
			model.addAttribute("message","û������û�����ע����½");
		}
		return false;
	}
}
