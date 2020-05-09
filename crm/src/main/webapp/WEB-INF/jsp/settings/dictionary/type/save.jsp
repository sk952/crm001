<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
			//将错误消息清空
			$("#code").focus(function () {
				$("#msg").html("");
				
			})


			$("#saveTypeBtn").click(function () {
				//取字典类型编码验证是否为空
				var code=$.trim($("#code").val());

				//验证是否为空
				if (code==""){
					$("#msg").html("字符类型编码不能为空");
					return false;


				}

				$.ajax({

					url : "settings/dictionary/type/checkCode1.do",
					data : {
						"code":code
					},
					type : "get",
					dataType : "json",
					success : function (data) {
					//	data
						//{"success":true/false}
						if (data.success){
							$("#saveTypeFrom").submit();
							
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
		<h3>新增字典类型</h3>
	  	<div style="position: relative; top: -40px; left: 70%;">
			<button type="button" id="saveTypeBtn" class="btn btn-primary">保存</button>
			<button type="button" class="btn btn-default" onclick="window.history.back();">取消</button>
		</div>
		<hr style="position: relative; top: -40px;">
	</div>

	<%--提交传统from表单，变淡元素中必须提供name属性--%>
	<form id="saveTypeFrom" action="settings/dictionary/type/saveType.do" method="post" class="form-horizontal" role="form">
					
		<div class="form-group">
			<label for="create-code" class="col-sm-2 control-label">编码<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="code" name="code" autocomplete="off" style="width: 200%;">
				<span id="msg" style="color: red"></span>
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-name" class="col-sm-2 control-label">名称</label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="name" name="name" style="width: 200%;">
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-describe" class="col-sm-2 control-label">描述</label>
			<div class="col-sm-10" style="width: 300px;">
				<textarea class="form-control" rows="3" id="description" name="description" style="width: 200%;"></textarea>
			</div>
		</div>
	</form>
	
	<div style="height: 200px;"></div>
</body>
</html>