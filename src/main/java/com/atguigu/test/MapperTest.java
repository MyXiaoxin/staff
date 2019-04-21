package com.atguigu.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.atguigu.bean.Department;
import com.atguigu.bean.Employee;
import com.atguigu.dao.DepartmentMapper;
import com.atguigu.dao.EmployeeMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:applicationContext.xml"})
public class MapperTest {
	@Autowired
	DepartmentMapper departmentMapper;
	@Autowired
	EmployeeMapper employeeMapper;
	@Autowired
	SqlSession sqlSession;
	

	@Test
	public void testCRUD() {
		System.out.println(departmentMapper);
		
		/**测试部门
		 * departmentMapper.insertSelective(new Department(null,"开发部"));
		 * departmentMapper.insertSelective(new Department(null,"测试部"));
		 */
		
		/**员工测试
		 * employeeMapper.insertSelective(new Employee(null, "侯文鑫", "M", "xiaopang@xiaofeng.com", "2"));
		 */
		
		/**批量插入员工集合：使用可以执行批量操作的sqlsession
		 * 
		 */
		EmployeeMapper employeeMapper = sqlSession.getMapper(EmployeeMapper.class);
		for(int i=0;i<1000;i++) {
			String uid = UUID.randomUUID().toString().substring(0,5)+i;
			employeeMapper.insertSelective(new Employee(null,uid,"M",uid+"@atguigu.com", uid));
			
		}
		System.out.println("批量完成");
	}
}
