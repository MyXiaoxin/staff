<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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



	<!-- 增加员工模块 -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">员工添加</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">员工姓名</label>
							<div class="col-sm-10">
								<input type="text" name="empName" class="form-control"
									id="emp_name_input" placeholder="员工姓名">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">电子邮件</label>
							<div class="col-sm-10">
								<input name="email" type="text" class="form-control"
									id="emp_email_input" placeholder="xiaopang@guigu.com">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">性别</label> <label
								class="radio-inline"> <input type="radio" name="gender"
								id="gender_add_input1" value="M" checked="checked"> 男
							</label> <label class="radio-inline"> <input type="radio"
								name="gender" id="gender_add_input2" value="W"> 女
							</label>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">部门</label>
							<div class="col-sm-4">
								<select class="form-control" id="dept_add_select" name="dept"></select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
				</div>
			</div>
		</div>
	</div>


	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<td>#</td>
							<td>员工姓名</td>
							<td>性别</td>
							<td>电子邮件</td>
							<td>部门</td>
							<td>操作</td>
						</tr>
					</thead>
					<tbody>

					</tbody>

				</table>
			</div>
		</div>
		<div class="row">
			<div class="col-md-6" id="page_info_area"></div>
			<div class="col-md-6" id="page_nav"></div>
			<div></div>
		</div>

	</div>
	<script type="text/javascript">
		var totalRecord;
		//直接发送Ajax请求，要到分页数据
		$(function() {
			to_page(1);
		});

		function build_emps_table(result) {
			$("#emps_table tbody").empty();
			var emps = result.extend.pageinfo.list;
			$.each(emps, function(index, item) {
				//alert(item.empName);
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var genderTd = $("<td></td>").append(
						item.gender == 'M' ? "男" : "女");
				var emailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>")
						.append(item.department.deptName);
				/*
				<button class="btn btn-primary btn-sm">
								<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>操作
							</button>
				 */
				var editBtn = $("<buton></button>").addClass(
						"btn btn-primary btn-sm").append("<span></span>")
						.addClass("glyphicon glyphicon-pencil").append("操作");
				var delBtn = $("<buton></button>").addClass(
						"btn btn-danger btn-sm").append("<span></span>")
						.addClass("glyphicon glyphicon-trash").append("删除");
				var btnTd = $("<td></td>").append(editBtn).append(" ").append(
						delBtn);
				$("<tr></tr>").append(empIdTd).append(empNameTd).append(
						genderTd).append(emailTd).append(deptNameTd).append(
						btnTd).appendTo("#emps_table tbody");
			});
		}
		//解析显示分页信息
		function build_page_info(result) {
			$("#page_info_area").empty();
			$("#page_info_area").append(
					"当前" + result.extend.pageinfo.pageNum + "页，总"
							+ result.extend.pageinfo.pages + "页，共"
							+ result.extend.pageinfo.total + "条记录");
			total = result.extend.pageinfo.total;
		}
		//解析显示分页条,点击显示要去下一页
		function build_page_nav(result) {
			$("#page_nav").empty();
			var ul = $("<ul></ul>").addClass("pagination");
			var firstPage = $("<li></li>").append(
					$("<a></a>").append("首页").attr("href", "#"));
			var prePage = $("<li></li>").append($("<a></a>").append("&laquo;"));
			var nextPage = $("<li></li>")
					.append($("<a></a>").append("&raquo;"));
			var lastPage = $("<li></li>").append(
					$("<a></a>").append("末页").attr("href", "#"));
			if (result.extend.pageinfo.hasPreviousPage == false) {
				firstPage.addClass("disabled");
				prePage.addClass("disabled");
			} else {
				firstPage.click(function() {
					to_page(1);
				});
				prePage.click(function() {
					to_page(result.extend.pageinfo.pageNum - 1);
				});
			}
			if (result.extend.pageinfo.hasNextPage == false) {
				lastPage.addClass("disabled");
				nextPage.addClass("disabled");
			} else {
				lastPage.click(function() {
					to_page(result.extend.pageinfo.pages);
				});
				nextPage.click(function() {
					to_page(result.extend.pageinfo.pageNum + 1);
				});
			}
			ul.append(firstPage).append(prePage);
			$.each(result.extend.pageinfo.navigatepageNums, function(index,
					item) {
				var numLi = $("<li></li>").append($("<a></a>").append(item));
				if (result.extend.pageinfo.pageNum == item) {
					numLi.addClass("active");
				}
				numLi.click(function() {
					to_page(item);
				});
				ul.append(numLi);
			});
			ul.append(nextPage).append(lastPage);
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav");
		}
		function to_page(pn) {
			$.ajax({
				url : "${APP_PATH}/emps",
				data : "pn=" + pn,
				type : "GET",
				success : function(result) {
					//console.log(result);
					//1.解析并显示员工数据
					//2.解析并显示分页数据
					build_emps_table(result);
					build_page_info(result);
					build_page_nav(result);

				}
			});
		}
		//点击新增员工
		$("#emp_add_modal_btn").click(function() {
			//发送ajax请求
			getDepts();
			//弹出
			$("#empAddModal").modal({
				backdrop : "static"
			});
		});
		
		function getDepts(){
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"GET",
				success:function(result){
					//$("#dept_add_select").append()
					$.each(result.extend.depts,function(){
						var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
						optionEle.appendTo("#dept_add_select");
					});
				}
				
			});
		}
		$("#emp_save_btn").click(function(){
			if(!validate_add_form()){
				return false;
			}
			//发送Ajax请求
			$.ajax({
				url:"${APP_PATH}/emp",
				type:"POST",
				data:$("#empAddModal form").serialize(),
				success:function(result){
					//成功之后关闭，来到最后一页
					$("#empAddModal").modal("hide");
					to_page(total);
				}
			});
			
		});
		function validate_add_form(){
			//拿到数据，进行正则表达式校验
			var empName = $("#emp_name_input").val();
			var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			if(!regName.test(empName)){
				alert("用户可以是2-5中文文或者2-16英文");
				return false;
			}
			var email =$("#emp_email_input").val();
			var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$^[a-z\d]+(\.[a-z\d]+)*@([\da-z](-[\da-z])?)+(\.{1,2}[a-z]+)+$/;
			if(!regEmail.test(email)){
				alert("邮箱格式不正确");
				return false;
			}
			return true;
		}
	</script>
</body>
</html>