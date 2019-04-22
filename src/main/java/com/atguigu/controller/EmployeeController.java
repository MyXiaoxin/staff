package com.atguigu.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.bean.Employee;
import com.atguigu.bean.Msg;
import com.atguigu.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
public class EmployeeController {
	@Autowired
	EmployeeService employeeService;
	
	
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value="pn",defaultValue="1")Integer pn,Model model) {
		PageHelper.startPage(pn,5);
		List<Employee> emps = employeeService.getAll();
		//使用pageinfo包装查询后的信息，只需要将pageinfo交给页面即可
		//封装了详细的分页信息，包括我们查询出来的信息
		PageInfo page = new PageInfo(emps,5);
		return Msg.success().add("pageinfo",page);
	}
	@RequestMapping(value="/emp",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(Employee employee) {
		employeeService.saveEmp(employee);
		return Msg.success();
	}
	//@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn",defaultValue="1")Integer pn,Model model) {
		//引入pageHelper插件
		//传入页码，及分页的大小
		PageHelper.startPage(pn,5);
		List<Employee> emps = employeeService.getAll();
		//使用pageinfo包装查询后的信息，只需要将pageinfo交给页面即可
		//封装了详细的分页信息，包括我们查询出来的信息
		PageInfo page = new PageInfo(emps);
		model.addAttribute("pageinfo",page);
		return "list";
	}
	
	public Msg checkUser(String empName) {
		employeeService.checkUser(empName);
		return null;
	}
	
	
}
