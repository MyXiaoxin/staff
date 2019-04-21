package com.atguigu.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.bean.Department;
import com.atguigu.dao.DepartmentMapper;
@Service
public class DeparmentService {
	@Autowired
	private DepartmentMapper departmentMapper;
	
	
	public List<Department> getDepts() {
		List<Department> list = departmentMapper.selectByExample(null);
		return list;
	}

}
