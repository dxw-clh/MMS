package com.hut.dxw.sevice.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hut.dxw.mapper.DoctorMapper;
import com.hut.dxw.pojo.Doctor;
import com.hut.dxw.pojo.DoctorExample;
import com.hut.dxw.sevice.DoctorService;

@Service
public class DoctorServiceImpl implements DoctorService{
	@Autowired
	DoctorMapper doctorMapper;

	@Override
	public PageInfo<Doctor> findDoctorPageSerach(Integer pageNum, Integer pageSize, String name, Integer department,
			Model model) {
		PageHelper.startPage(pageNum,pageSize);
		DoctorExample de = new DoctorExample();
		com.hut.dxw.pojo.DoctorExample.Criteria criteria = de.createCriteria();
		criteria.andNameLike("%"+name+"%");
		if(department != null && department != 0) {
			criteria.andDepartmentEqualTo(department);
		}
		List<Doctor> list = doctorMapper.selectByExample(de);
		PageInfo<Doctor> pageInfo = new PageInfo<Doctor>(list);
		
		return pageInfo;
	}

	@Override
	public Integer addOrEdit(Doctor doctor) {
		// 判断是修改还是添加
		if (doctor.getDid() != null && doctor.getDid() != 0) {
			//修改的方法
			int i = doctorMapper.updateByPrimaryKeySelective(doctor);
			if(i != 1 ) 
				//修改失败
				return 2;
			}else {//没有id，调用添加方法
				int i = doctorMapper.insertSelective(doctor);
				if (i!=1) {
					return 1;
				}
		}
		return 0;
	}

	@Override
	public Doctor findDoctorByDid(Integer did) {
		// TODO Auto-generated method stub
		return doctorMapper.selectByPrimaryKey(did);
	}
	
	@Override
	public void delDoctor(String ids) {
		// TODO Auto-generated method stub
		doctorMapper.delDoctorsByIds(ids);
	}
}
