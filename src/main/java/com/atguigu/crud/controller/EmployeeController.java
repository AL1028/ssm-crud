package com.atguigu.crud.controller;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.dao.EmployeeMapper;
import com.atguigu.crud.service.EmployeeService;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.xml.ws.BindingType;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author HUA
 * @create 2021-12-18 15:45
 */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    @ResponseBody
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    public Msg deleteEmpById(@PathVariable("ids")String ids){
        if (ids.contains("-")){
            List<Integer> del_ids = new ArrayList<>();
            String[] str_ids = ids.split("-");
            for (String str_id : str_ids) {
                del_ids.add(Integer.parseInt(str_id));
            }
            employeeService.deleteBatch(del_ids);
        }else {
            Integer id = Integer.parseInt(ids);
            employeeService.deleteEmpById(id);
        }

        return Msg.success();
    }


    /**
     * 员工更新
     * 要想PUT生效需要配置FormContentFilter
     * @param
     * @param employee
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    public Msg updateEmp(Employee employee){
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    /**
     * 根据id查询员工
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee = employeeService.getEmp(id);

        return Msg.success().add("employee",employee);
    }


    //校验用户名是否可用
    @ResponseBody
    @RequestMapping("/checkuser")
    public Msg checkuser(@RequestParam("empName") String userName){
        //先判断用户名是否是合法的表达式
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if (!userName.matches(regx)) {
            return Msg.fail().add("va-msg","用户名必须是6-16位的数组或者2-5个汉字");
        }

        //数据库用户名校验
        boolean b = employeeService.checkUser(userName);
        if (b){
            return Msg.success();
        }else {
            return Msg.fail().add("va-msg","用户名不可用");
        }
    }

    /**
     * 添加员工
     * @param employee
     * @param result
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    public Msg saveEmp(@Valid Employee employee, BindingResult result){

        if (result.hasErrors()){
            //校验失败，应该返回失败，在模态框中显示校验失败的信息
            Map<String,Object> map = new HashMap<>();
            List<FieldError> fieldErrors = result.getFieldErrors();
            for (FieldError fieldError : fieldErrors) {
                System.out.println("错误的字段：" + fieldError.getField());
                System.out.println("错误的信息：" + fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }

            return Msg.fail().add("errorField",map);
        }else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }


    @ResponseBody
    @RequestMapping("/emps")
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1")Integer pn){
        PageHelper.startPage(pn, 5);
        List<Employee> emps = employeeService.getEmps();
        PageInfo<Employee> pageInfo = new PageInfo<>(emps,5);

        return Msg.success().add("pageInfo",pageInfo);
    }

  //  @RequestMapping("/emps")
    public String getAllEmp(@RequestParam(value = "pn",defaultValue = "1") Integer pn, Model model){
        //引入PageHelper分页插件
        //在查询之前只需要调用，传入页码，以及每页的大小
        PageHelper.startPage(pn,5);
        //startPage后面紧跟的这个查询就是一个分页查询
        List<Employee> emps = employeeService.getEmps();
        //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了
        //封装了详细的分页信息，包括我们查询出来的数据,传入连续显示的页数
        PageInfo<Employee> page = new PageInfo<>(emps,5);

        model.addAttribute("pageInfo",page);
        return "list";
    }

}
