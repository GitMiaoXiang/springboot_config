package com.maoxiang.springboot_config.utils;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import org.apache.ibatis.javassist.*;
import org.apache.ibatis.javassist.bytecode.CodeAttribute;
import org.apache.ibatis.javassist.bytecode.LocalVariableAttribute;
import org.apache.ibatis.javassist.bytecode.MethodInfo;
import org.aspectj.lang.JoinPoint;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

/**
 * @author ShangGuanMingPeng
 * date: 2018/9/15 19:34
 * Description:
 */
public class RequestUtil {

    /**
     * 获取ip
     * @param request
     * @return
     */
    public static String getRequestIp(HttpServletRequest request){
        if(request==null){
            return "";
        }
        String ip = request.getHeader("x-forwarded-for");
        if(ip == null || ip.trim().equals("") || "unknown".equalsIgnoreCase(ip)){
            ip = request.getHeader("Proxy-Client-IP");
        }
        if(ip == null || ip.trim().equals("")||"unknown".equalsIgnoreCase(ip)){
            ip = request.getHeader("WL-Proxy-Client_IP");
        }
        if(ip == null || ip.trim().equals("")||"unknown".equalsIgnoreCase(ip)){
            ip = request.getRemoteAddr();
        }
        final String[] arr = ip.split(",");
        for (final String str:arr) {
            ip = str;
            break;
        }
        return ip;
    }

    /**
     * 获取请求方式：普通请求 ajax请求
     * @param request
     * @return
     */
    public static String getRequestType(HttpServletRequest request){
        if(request==null){
            return "";
        }
        String xRequestWith = request.getHeader("X-Requested-With");
        return xRequestWith == null ? "普通请求" : "ajax请求";
    }

    public static Map<String, Object> getJoinPointInfoMap(JoinPoint joinPoint){
        Map<String, Object> joinPointInfo = new HashMap<>();
        String classPath = joinPoint.getTarget().getClass().getName();
        String methodName = joinPoint.getSignature().getName();
        joinPointInfo.put("classPath", classPath);
        joinPointInfo.put("methodName", methodName);
        Class<?> clazz = null;
        CtMethod ctMethod = null;
        LocalVariableAttribute attr = null;
        int length = 0;
        int pos = 0;
        try {
            clazz = Class.forName(classPath);
            String className = clazz.getName();
            ClassPool pool = ClassPool.getDefault();
            ClassClassPath classClassPath = new ClassClassPath(clazz);
            pool.insertClassPath(className);
            CtClass ctClass = pool.get(className);
            ctMethod = ctClass.getDeclaredMethod(methodName);
            MethodInfo methodInfo = ctMethod.getMethodInfo();
            CodeAttribute codeAttribute = methodInfo.getCodeAttribute();
            attr = (LocalVariableAttribute) codeAttribute.getAttribute(LocalVariableAttribute.tag);
            if(attr == null){
                return joinPointInfo;
            }
            length = ctMethod.getParameterTypes().length;
            pos = Modifier.isStatic(ctMethod.getModifiers())?0:1;
        }catch (ClassNotFoundException e){
            e.printStackTrace();
        }catch (NotFoundException e){
            e.printStackTrace();
        }
        Map<String,Object> map = new HashMap<>();
        Object[] paramsArgsValues = joinPoint.getArgs();
        String[] paramsArgsNames = new String[length];
        for (int i = 0; i<length;i++){
            paramsArgsNames[i] = attr.variableName(i+pos);
            String paramsArgsName = attr.variableName(i+pos);
            if(paramsArgsName.equalsIgnoreCase("request")||
               paramsArgsName.equalsIgnoreCase("response")||
               paramsArgsName.equalsIgnoreCase("session")){
                break;
            }
            Object paramsArgsValue = paramsArgsValues[i];
            map.put(paramsArgsName,paramsArgsValue);
        }
        joinPointInfo.put("paramMap", JSON.toJSONString(map, SerializerFeature.DisableCircularReferenceDetect, SerializerFeature.WriteMapNullValue));
        return joinPointInfo;
    }
}
