package com.hut.dxw.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.core.convert.converter.Converter;

public class DateConverter implements Converter<String , Date> {

	@Override
	public Date convert(String str) {
		// 定义时间类型规则
		String str1= "";
		//根据传输的字符长度来判断是否有时分秒
		if (str.length() > 11) {//有时分秒
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
		//定义时间格式的类
        SimpleDateFormat sdf = new SimpleDateFormat(str1);
        try {
            //格式时间
            Date date = sdf.parse(str);
            return date;
        }catch (Exception e){
            System.out.println("转化失败，创建一个新的时间！");
            return new Date();
        }
	}

}
