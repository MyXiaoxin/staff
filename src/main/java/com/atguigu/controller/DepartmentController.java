package com.atguigu.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.bean.Department;
import com.atguigu.bean.Msg;

@Controller
public class DepartmentController {
	@Autowired
	private DeparmentService departmentService;
	
	@ResponseBody
	@RequestMapping("/depts")
	public Msg getDepts() {
		List<Department> list = departmentService.getDepts();
		return Msg.success().add("depts",list);
	}
}
