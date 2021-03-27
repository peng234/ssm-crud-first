package com.peng.controller;

import com.peng.bean.Department;
import com.peng.bean.Msg;
import com.peng.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DepetmentController {


    @Autowired
    private DepartmentService departmentService;

    @ResponseBody
    @RequestMapping("/depts")
    public Msg getDepts(){
        List<Department> departmentList=departmentService.getDepts();
        return Msg.success().add("depts",departmentList);
    }
}
