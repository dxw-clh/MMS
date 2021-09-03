package com.hut.dxw.sevice;

import org.springframework.ui.Model;

import com.github.pagehelper.PageInfo;
import com.hut.dxw.pojo.Medicine;

public interface MedicineService {

	PageInfo<Medicine> findmedicinePageSerach(Integer pageNum, Integer pageSize, String name, Integer type,
			Model model);

	Medicine showMedicineDetail(String mid);

	Integer addOrEdit(Medicine medicine);

}
