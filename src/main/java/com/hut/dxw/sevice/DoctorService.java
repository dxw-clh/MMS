package com.hut.dxw.sevice;

import org.springframework.ui.Model;

import com.github.pagehelper.PageInfo;
import com.hut.dxw.pojo.Doctor;

public interface DoctorService {

	PageInfo<Doctor> findDoctorPageSerach(Integer pageNum, Integer pageSize, String name, Integer department,
			Model model);

	Integer addOrEdit(Doctor doctor);

	Doctor findDoctorByDid(Integer did);

	void delDoctor(String ids);

}
