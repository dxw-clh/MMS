package com.hut.dxw.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.pagehelper.PageInfo;
import com.hut.dxw.pojo.Medicine;
import com.hut.dxw.sevice.MedicineService;

@Controller
@RequestMapping("/medicine")
public class MedicineController {
	@Autowired
	MedicineService medicineService;
	
	//添加一个页面跳转的方法
	@RequestMapping("/{path}")
	public String forWard(@PathVariable String path) {
		//跳转页面
		return path;
	}
	
	@RequestMapping("/medicinepageList")
	public String pageList(@RequestParam(defaultValue="1")Integer pageNum,
			@RequestParam(defaultValue="5")Integer pageSize,
			String name,@RequestParam(defaultValue="0")Integer type,Model model ) {
		PageInfo<Medicine> pageInfo = medicineService.findmedicinePageSerach(pageNum,pageSize,name,type,model);
		model.addAttribute("pageInfo",pageInfo);
		model.addAttribute("name",name);
		model.addAttribute("type",type);
		return "index";
	}
	
	//添加和修改药品的方法
		@RequestMapping("/addOrEdit")
		public String addOrEdit(Medicine medicine , Model model) {
			//调用业务层实现添加或修改的方法
			Integer i = medicineService.addOrEdit(medicine);
			if (i==0) {
				return "forward:pageList?name="+medicine.getName();
			}else if(i == 1){
				return "add";
			}else{
				model.addAttribute("medicine",medicine);
				return "edit";
			}
		}
	
	//根据mid查询药品信息
	@RequestMapping("/showMedicineDetails")
	public String showMedicineDetail(String mid,Model model) {
		Medicine medicine = medicineService.showMedicineDetail(mid);
		//将数据返回到页面
		model.addAttribute("medicine",medicine);
		return "look";
	}
	
	@RequestMapping("/findMedicineByMid")
	public String findMedicineByMid(String mid,Model model) {
		Medicine medicine = medicineService.showMedicineDetail(mid);
		model.addAttribute("medicine",medicine);
		return "edit";
	}
	
}
