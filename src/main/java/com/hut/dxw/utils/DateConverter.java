package com.hut.dxw.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.core.convert.converter.Converter;

public class DateConverter implements Converter<String , Date> {

	@Override
	public Date convert(String str) {
		// ����ʱ�����͹���
		String str1= "";
		//���ݴ�����ַ��������ж��Ƿ���ʱ����
		if (str.length() > 11) {//��ʱ����
			if (str.lastIndexOf("-") != -1 ) {
				str1 = "yyyy-MM-dd HH:mm:ss";
			}else {
				str1 = "yyyy/MM/dd HH:mm:ss";
			}
		}else {
			if (str.lastIndexOf("-") != -1 ) {
				str1 = "yyyy-MM-dd";
			}else {
				str1 = "yyyy/MM/dd";
			}
		}
		//����ʱ���ʽ����
        SimpleDateFormat sdf = new SimpleDateFormat(str1);
        try {
            //��ʽʱ��
            Date date = sdf.parse(str);
            return date;
        }catch (Exception e){
            System.out.println("ת��ʧ�ܣ�����һ���µ�ʱ�䣡");
            return new Date();
        }
	}

}
