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
	
	//���һ��ҳ����ת�ķ���
	@RequestMapping("/{path}")
	public String forWard(@PathVariable String path) {
		//��תҳ��
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
	
	//��Ӻ��޸�ҩƷ�ķ���
		@RequestMapping("/addOrEdit")
		public String addOrEdit(Medicine medicine , Model model) {
			//����ҵ���ʵ����ӻ��޸ĵķ���
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
	
	//����mid��ѯҩƷ��Ϣ
	@RequestMapping("/showMedicineDetails")
	public String showMedicineDetail(String mid,Model model) {
		Medicine medicine = medicineService.showMedicineDetail(mid);
		//�����ݷ��ص�ҳ��
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
