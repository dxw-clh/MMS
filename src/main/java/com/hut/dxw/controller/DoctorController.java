package com.hut.dxw.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.pagehelper.PageInfo;
import com.hut.dxw.pojo.Doctor;
import com.hut.dxw.sevice.DoctorService;

@Controller
@RequestMapping("/doctor")
public class DoctorController {
	@Autowired
	DoctorService doctorService;
	
	//���һ��ҳ����ת�ķ���
	@RequestMapping("/{path}")
	public String forWard(@PathVariable String path) {
		//��תҳ��
		return path;
	}
	
	@RequestMapping("/pageList")
	public String pageList(@RequestParam(defaultValue="1")Integer pageNum,
			@RequestParam(defaultValue="5")Integer pageSize,
			String name,Integer department,Model model) {
		PageInfo<Doctor> pageInfo = doctorService.findDoctorPageSerach(pageNum,pageSize,name,department,model);
		model.addAttribute("pageInfo",pageInfo);
		model.addAttribute("name",name);
		model.addAttribute("department",department);
		//System.out.println("��ת");
		return "index";
	}
	
	//��Ӻ��޸�ҽ���ķ���
	@RequestMapping("/addOrEdit")
	public String addOrEdit(Doctor doctor , Model model) {
		//����ҵ���ʵ����ӻ��޸ĵķ���
		Integer i = doctorService.addOrEdit(doctor);
		if (i==0) {
			return "forward:pageList?name="+doctor.getName();
		}else if(i == 1){
			return "add";
		}else{
			model.addAttribute("doctor",doctor);
			return "edit";
		}
	}
	
	//����id��ѯҽ����Ϣ
	@RequestMapping("/lookDoctorByDid")
	public String lookDoctorByDid(Integer did,Model model) {
		Doctor doctor = doctorService.findDoctorByDid(did);
		//�����ݷ��ص�ҳ��
		model.addAttribute("doctor",doctor);
		return "look";
	}
	
	@RequestMapping("/findDoctorByDid")
	public String findDoctorByDid(Integer did,Model model) {
		Doctor doctor = doctorService.findDoctorByDid(did);
		//�����ݷ��ص�ҳ��
		model.addAttribute("doctor",doctor);
		return "edit";
	}
	
	@RequestMapping("/delDoctor")
	public String delDoctor(String ids) {
		//����ҵ���ɾ������
		doctorService.delDoctor(ids);
		//��ת��չʾҳ��
		return "forward:pageList";
	}
}
