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
		
		/**���Բ���
		 * departmentMapper.insertSelective(new Department(null,"������"));
		 * departmentMapper.insertSelective(new Department(null,"���Բ�"));
		 */
		
		/**Ա������
		 * employeeMapper.insertSelective(new Employee(null, "������", "M", "xiaopang@xiaofeng.com", "2"));
		 */
		
		/**��������Ա�����ϣ�ʹ�ÿ���ִ������������sqlsession
		 * 
		 */
		EmployeeMapper employeeMapper = sqlSession.getMapper(EmployeeMapper.class);
		for(int i=0;i<1000;i++) {
			String uid = UUID.randomUUID().toString().substring(0,5)+i;
			employeeMapper.insertSelective(new Employee(null,uid,"M",uid+"@atguigu.com", uid));
			
		}
		System.out.println("�������");
	}
}
