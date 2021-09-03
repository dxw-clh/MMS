package com.hut.dxw.sevice.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hut.dxw.mapper.MedicineMapper;
import com.hut.dxw.pojo.Medicine;
import com.hut.dxw.pojo.MedicineExample;
import com.hut.dxw.pojo.MedicineExample.Criteria;
import com.hut.dxw.sevice.MedicineService;

@Service
public class MedicineServiceImpl implements MedicineService{
	@Autowired
	MedicineMapper medicineMapper;

	@Override
	public PageInfo<Medicine> findmedicinePageSerach(Integer pageNum, Integer pageSize, String name,
			Integer type,Model model) {
		PageHelper.startPage(pageNum,pageSize);
		MedicineExample me = new MedicineExample();
		Criteria criteria = me.createCriteria();
		if(name != null) {
			criteria.andNameLike("%"+name+"%");
		}
		
		if(type != null && type != 0) {
			criteria.andTypeEqualTo(type);
		}
		List<Medicine> list = medicineMapper.selectByExample(me);
		PageInfo<Medicine> pageInfo = new PageInfo<Medicine>(list);
		return pageInfo;
	}
	
	@Override
	public Integer addOrEdit(Medicine medicine) {
		// 判断是修改还是添加
		if (medicine.getMid() != null) {
			//修改的方法
			int i = medicineMapper.updateByPrimaryKeySelective(medicine);
			if(i != 1 ) 
				//修改失败
				return 2;
			}else {//没有mid，调用添加方法
				int i = medicineMapper.insertSelective(medicine);
				if (i!=1) {
					return 1;
				}
			}
		return 0;
	}
	
	@Override
	public Medicine showMedicineDetail(String mid) {
		return medicineMapper.selectByPrimaryKey(mid);
	}
}
