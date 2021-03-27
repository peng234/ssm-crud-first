package com.peng.bean;


import com.github.pagehelper.PageInfo;

import java.util.HashMap;
import java.util.Map;

//返回json数据的
public class Msg {
    private int code;
    private String msg;

    private Map<String,Object> extend=new HashMap<String,Object>();

    public static Msg success(){
        Msg result=new Msg();
        result.setCode(100);
        result.setMsg("处理成功");
        return result;
    }

    public static Msg fail(){
        Msg result=new Msg();
        result.setCode(200);
        result.setMsg("处理失败");
        return result;
    }
    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }

    public Msg add(String pageInfo, Object page) {
        this.getExtend().put(pageInfo,page);
        return this;
    }
}
