<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表</title>
<!-- web路径问题
1.不已/为开始的相对路径，以当前资源的路径为基础，经常容易出问题
2.以/开始的相对路径，以服务器为标准，需要加上项目名，
 -->
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<script type="text/javascript"
	src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
<link
	href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover">
					<tr>
						<td>#</td>
						<td>员工姓名</td>
						<td>性别</td>
						<td>电子邮件</td>
						<td>部门</td>
						<td>操作</td>
					</tr>

			<c:forEach items="${pageinfo.list}" var="emp">
					<tr>
						<td>${emp.empId}</td>
						<td>${emp.empName }</td>
						<td>${emp.gender=="M"?"男":"女" }</td>
						<td>${emp.email}</td>
						<td>${emp.department.deptName}</td>
						<td>
							<button class="btn btn-primary btn-sm">
								<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>操作
							</button>
							<button class="btn btn-danger btn-sm">
								<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
							</button>
						</td>
					</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<div class="row">
			<div class="col-md-6">
				当前${pageinfo.pageNum}页，总${pageinfo.pages}页，共${pageinfo.total}条记录
				
			</div>
			<div class="col-md-6">
				<nav aria-label="Page navigation">
				<ul class="pagination">
					<li><a href="${APP_PATH}/emps?pn=1">首页</a></li>
					<c:if test="${pageinfo.hasPreviousPage}">
						<li><a href="${APP_PATH}/emps?pn=${pageinfo.pageNum-1}" aria-label="Previous"> <span
							aria-hidden="true">&laquo;</span>
					</a></li>
					</c:if>
					<c:forEach items="${pageinfo.navigatepageNums }"  var="page_Num">
						<c:if test="${page_Num==pageinfo.pageNum}"><li class="active"><a href="#">${page_Num}</a></li></c:if>
						<c:if test="${page_Num!=pageinfo.pageNum }"><li><a href="${APP_PATH}/emps?pn=${page_Num}">${page_Num}</a></li></c:if>
					</c:forEach>
					<c:if test="${pageinfo.hasNextPage}">
						<li><a href="${APP_PATH}/emps?pn=${pageinfo.pageNum+1}" aria-label="Next"> <span
							aria-hidden="true">&raquo;</span>
					</a></li>
					</c:if>
					<li><a href="${APP_PATH}/emps?pn=${pageinfo.pages}">末页</a></li>
				</ul>
				</nav>
			</div>
			<div></div>
		</div>

	</div>
</body>
</html>