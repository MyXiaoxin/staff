package com.atguigu.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.bean.Employee;
import com.atguigu.bean.EmployeeExample;
import com.atguigu.bean.EmployeeExample.Criteria;
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


	//判断用户名是否可用，都可以这么判断
	public boolean checkUser(String empName) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long count = employeeMapper.countByExample(example);
		return count==0;	
	}

}
