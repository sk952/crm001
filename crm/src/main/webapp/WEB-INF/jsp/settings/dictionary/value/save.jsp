<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
<meta charset="UTF-8">

<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
	<script>
		$(function () {
			//111111111111将错误消息清空
			$("#code").focus(function () {
				$("#msg").html("");

			})


			//为保存按钮绑定单击事件，执行字典值的添加操作
			$("#saveValueBtn").click(function () {
				//取字典类型编码验证是否为空
				var code=$.trim($("#code").val());

				//验证是否为空
				if (code==""){
					$("#msg").html("字典值不能为空");
					return false;
				}
				$.ajax({

					url : "settings/dictionary/value/checkCode2.do",
					data : {
						"code":code
					},
					type : "get",
					dataType : "json",
					success : function (data) {
						//	data
						//{"success":true/false}
						if (data.success){
							//提交表单
							$("#saveValueFrom").submit();

						}else {
							//表示有重复
							$("#msg").html("类型重复")

						}

					}

				})

			})
		})



	</script>
</head>
<body>

	<div style="position:  relative; left: 30px;">
		<h3>新增字典值</h3>
	  	<div style="position: relative; top: -40px; left: 70%;">
			<button type="button" class="btn btn-primary" id="saveValueBtn">保存</button>
			<button type="button" class="btn btn-default" onclick="window.history.back();">取消</button>
		</div>
		<hr style="position: relative; top: -40px;">
	</div>
	<%--提交from表单必须要提供name元素--%>
	<form  id="saveValueFrom" action="settings/dictionary/value/saveValue.do" method="post" class="form-horizontal" role="form">
					



		<div class="form-group">
			<label for="create-dicTypeCode" class="col-sm-2 control-label">字典类型编码<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
				<select class="form-control" id="create-dicTypeCode"  name="typeCode" style="width: 200%;">
				  <option></option>
					<c:forEach items="${dtList}" var="dt">
						<option value="${dt.code}">${dt.name}</option>

					</c:forEach>
				<%--
					<option>性别</option>
				  	<option>机构类型</option>
				  --%>
				</select>
			</div>
		</div>
		


		<%--11111111111111111111111111111111--%>
		<div class="form-group">
			<label for="create-dicValue" class="col-sm-2 control-label">字典值<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="code" name="value" style="width: 200%;">
				<span id="msg" style="color: red"></span>
			</div>
		</div>
		





		<div class="form-group">
			<label for="create-text" class="col-sm-2 control-label">文本</label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="create-text" name="text" style="width: 200%;">
			</div>
		</div>
		





		<div class="form-group">
			<label for="create-orderNo" class="col-sm-2 control-label">排序号</label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="create-orderNo" name="orderNo" style="width: 200%;">
			</div>
		</div>
	</form>
	


	<div style="height: 200px;"></div>
</body>
</html>