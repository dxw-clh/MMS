package com.hut.dxw.sevice.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hut.dxw.mapper.PersonMapper;
import com.hut.dxw.pojo.Person;
import com.hut.dxw.sevice.PersonService;

@Service
public class PersonServiceImpl implements PersonService {
	@Autowired
	PersonMapper PersonMapper;

	@Override
	public List<Person> findPersonList() {
		// TODO Auto-generated method stub
		return PersonMapper.getPersonAll();
	}
	
}
