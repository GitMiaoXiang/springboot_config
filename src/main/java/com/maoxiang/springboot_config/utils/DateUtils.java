package com.maoxiang.springboot_config.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @author ShangGuanMingPeng
 * date: 2018/9/17 11:31
 * Description: 时间戳转换时间工具类
 */
public class DateUtils {

    private static SimpleDateFormat format =  new SimpleDateFormat("yyyy年MM月dd日:HH时mm分ss秒SSS毫秒");

    /**
     * 将时间戳转为日期格式
     * @param time
     * @return
     */
    public static String getDateToString(long time){
        Date date = new Date(time);
        return format.format(date);
    }

    /**
     * 两个时间戳相减得到相差秒
     * //yy/1000:相差多少秒
     * //yy/1000/60:相差多少分钟
     * //yy/1000/60/60:相差多少小时
     * //yy/1000/60/60/24:相差多少天
     * @param startTime
     * @param returnTime
     * @return
     */
    public static String subtractTime(long startTime, long returnTime){
        Date startDate = new Date(startTime);
        Date returnDate = new Date(returnTime);
        String diffTime = String.valueOf((startDate.getTime()-returnDate.getTime())/1000/1000);
        return diffTime+"ms";
    }
}
