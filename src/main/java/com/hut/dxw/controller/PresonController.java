package com.hut.dxw.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hut.dxw.pojo.Person;
import com.hut.dxw.sevice.PersonService;

@Controller
public class PresonController {
	@Autowired
	PersonService personservice;
	
	@RequestMapping("/findPerson")
	public String FindPerson(Model model) {
		List<Person> list = personservice.findPersonList();
		model.addAttribute("list",list);
		return "list";
	}
}
