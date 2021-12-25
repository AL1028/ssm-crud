package com.atguigu.crud.controller;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author HUA
 * @create 2021-12-19 16:37
 */
@Controller
public class DepartmentController {
    @Autowired
    DepartmentService departmentService;

    @ResponseBody
    @RequestMapping("/depts")
    public Msg getDepts(){
        List<Department> depts = departmentService.getEmps();

        return Msg.success().add("depts",depts);
    }
}
