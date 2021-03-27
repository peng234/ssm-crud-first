package com.peng.controller;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.peng.bean.Employee;
import com.peng.bean.Msg;
import com.peng.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;
    //查询员工数据
    //@RequestMapping(value = "/emps")
    public String getEmps(@RequestParam(value="pn",defaultValue = "1") Integer pn, Model model){

        PageHelper.startPage(pn,5);

        List<Employee> employeeList=employeeService.getAll();

        PageInfo page=new PageInfo(employeeList,5);
        model.addAttribute("pageInfo",page);

        return "list";
    }

    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        Map<String,Object> map=new HashMap<>();
        if(result.hasErrors()){
            //在模态框中显示后端校验失败的信息
            List<FieldError> errors= (List<FieldError>) result.getFieldError();
            for(FieldError fieldError:errors){
                System.out.println("错误的字段名"+fieldError.getField());
                System.out.println("错误信息"+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail();
        }else{
            employeeService.saveEmp(employee);
            return Msg.success().add("errorFields",map);
        }
    }

    @RequestMapping(value = "/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value="pn",defaultValue = "1") Integer pn, Model model){

        PageHelper.startPage(pn,5);

        List<Employee> employeeList=employeeService.getAll();

        PageInfo page=new PageInfo(employeeList,5);

        return Msg.success().add("pageInfo",page);

    }



    //支持jsr303校验
    //检查该用户名是否可以用
    @ResponseBody
    @RequestMapping("/checkuser")
    public Msg checkUser(String empName){
        //先判断用户名是否合适
        String regx="(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        boolean okk=empName.matches(regx);
        boolean ok=employeeService.checkUser(empName);
        if(!okk){
            return Msg.fail().add("va-msg","用户名必须是6到16位数字和字母组合或2到5位中文");
        }
        if(ok){
            return Msg.success();
        }else{
            return Msg.fail().add("va_msg","用户名不可用");
        }
    }

    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee value=employeeService.getEmp(id);
        return Msg.success().add("emp",value);
    }

    @ResponseBody
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    public Msg saveEmp(Employee employee){

        System.out.println(employee);
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    @ResponseBody
    @RequestMapping(value="/emp/{ids}",method = RequestMethod.DELETE)
    public Msg deleteEmp(@PathVariable("ids") String ids){
        //批量删除
        if(ids.contains("-")){
            List<Integer> list=new ArrayList<>();
            String [] str=ids.split("-");
            for(String s :str){
                list.add(Integer.parseInt(s));
            }
            employeeService.deleteBath(list);
        }else{
            Integer id=Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }
        return Msg.success();

    }
}
