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
	
	//添加一个页面跳转的方法
	@RequestMapping("/{path}")
	public String forWard(@PathVariable String path) {
		//跳转页面
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
		//System.out.println("跳转");
		return "index";
	}
	
	//添加和修改医生的方法
	@RequestMapping("/addOrEdit")
	public String addOrEdit(Doctor doctor , Model model) {
		//调用业务层实现添加或修改的方法
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
	
	//根据id查询医生信息
	@RequestMapping("/lookDoctorByDid")
	public String lookDoctorByDid(Integer did,Model model) {
		Doctor doctor = doctorService.findDoctorByDid(did);
		//将数据返回到页面
		model.addAttribute("doctor",doctor);
		return "look";
	}
	
	@RequestMapping("/findDoctorByDid")
	public String findDoctorByDid(Integer did,Model model) {
		Doctor doctor = doctorService.findDoctorByDid(did);
		//将数据返回到页面
		model.addAttribute("doctor",doctor);
		return "edit";
	}
	
	@RequestMapping("/delDoctor")
	public String delDoctor(String ids) {
		//调用业务层删除方法
		doctorService.delDoctor(ids);
		//跳转到展示页面
		return "forward:pageList";
	}
}
