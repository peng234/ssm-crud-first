package com.peng.text;

import com.peng.bean.Department;
import com.peng.bean.Employee;
import com.peng.dao.DepartmentMapper;
import com.peng.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.UUID;

public class text {
    private static SqlSession sqlSession;
    public static void main(String[] args) {
        ApplicationContext ioc=new ClassPathXmlApplicationContext("applicationContext.xml");

//        DepartmentMapper bean= (DepartmentMapper) ioc.getBean("departmentMapper");
//        System.out.println(bean);


        EmployeeMapper employeeMapper= (EmployeeMapper) ioc.getBean("employeeMapper");
        Employee employee=employeeMapper.selectByPrimaryKeyWithDept(1);
        System.out.println(employee);
//        sqlSession= (SqlSession) ioc.getBean("sqlSession");
//
//        EmployeeMapper employeeMapper=sqlSession.getMapper(EmployeeMapper.class);
//
//        for(int i=0;i<1000;i++){
//            String uuid=UUID.randomUUID().toString().substring(0,5)+i;
//            employeeMapper.insertSelective(new Employee(null,uuid,"M",uuid+"@peng.com",1));
//        }



        System.out.println("执行批量操作马sf");

    }
}
