package com.atguigu.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.bean.Employee;
import com.atguigu.dao.EmployeeMapper;

@Service
public class EmployeeService {
	@Autowired
	EmployeeMapper employeeMapper;
	
	
	
	public List<Employee> getAll() {
		
		return employeeMapper.selectByExampleWithDept(null);
	}



	public void saveEmp(Employee employee) {
		employeeMapper.insertSelective(employee);
		
	}

}
