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
	<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
	<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
	<script>

		$(function () {
			//如果不是顶级窗口 不是当前窗口
			if(window.top!=window){
				//将顶级窗口设置为当前窗口
				window.top.location=window.location;
			}

			//在页面加载完毕后，使得用户名文本框自动取得焦点
			$("#loginAct").focus();

			//为登录按钮绑定事件，执行登录操作
			$("#submitBtn").click(function () {

				//alert("登录操作1");
				login();

			})

			//为当前窗口绑定敲键盘事件，如果敲的是回车键，则执行登录操作
			/*

				我们可以通过event参数来取得所敲的键盘的码值
				如果码值为13，说明敲的是回车键

			 */
			$(window).keydown(function (event) {

				var code = event.keyCode;

				//如果码值为13，说明是回车键
				if(code==13){

					//执行登录操作
					//alert("登录操作2");
					login();

				}

			})


		})

		/*

			注意：
				未来的实际项目开发，我们自定义的function方法，一定要写在$(function(){})的体外

		 */
		function login() {

			/*

				关于jquery的存取值问题

				主要是针对于表单元素的value属性值的存取值操作
				相当于是原生js的 document.getElementById("").value
				val():取值
				val(值):赋值

				主要是针对于标签对中的内容的存取值操作(操作的是可带元素的文本)
				相当于是原生js的 document.getElementById("").innerHTML;
				html():取值
				html("<font color='red'>hello world!!!</font>"):赋值

				主要是针对于标签对中的内容的存取值操作(操作的是纯文本)
				text():取值
				text("hello world!!!"):赋值

			 */


			//验证账号密码是否为空
			//取得账号密码
			//取出内容左右空格：$.trim(内容)
			var loginAct = $.trim($("#loginAct").val());
			var loginPwd = $.trim($("#loginPwd").val());

			if(loginAct==""||loginPwd==""){

				$("#msg").html("账号密码不能为空");

				//及时终止掉方法
				return false;

			}

			var flag = "";

			if($("#flag").prop("checked")){
				//判断是否打钩，十天面登录
				flag = "a";

			}
			             
			//验证账号密码是否正确
			$.ajax({

				url : "settings/user/login.do", //请求路径
				data : {

					"loginAct" : loginAct,
					"loginPwd" : loginPwd,
					"flag" : flag

				},	//请求参数
				type : "post", //请求方式
				dataType : "json", //接收响应信息的方式
				success : function (data) {	//回调函数  data：从后台响应回来的信息

					/*

						data
							{"success":true/false,"msg":?}

					 */

					if(data.success){

						//登录成功
						//跳转到欢迎页
						//我们以下以超链接的形式，不可能直接访问到WEB-INF下的资源
						//WEB-INF下的资源只有一种方式能够访问到：请求转发
						window.location.href = "workbench/toIndex.do";

					}else{

						//登录失败
						//需要在<span id="msg"></span>的标签对中，局部刷新错误信息
						$("#msg").html(data.msg);

					}


				}

			})



		}

	</script>
</head>
<body>



<div style="position: absolute; top: 0px; left: 0px; width: 60%;">
	<img src="image/IMG_7114.JPG" style="width: 100%; height: 90%; position: relative; top: 50px;">
</div>
<div id="top" style="height: 50px; background-color: #3C3C3C; width: 100%;">
	<div style="position: absolute; top: 5px; left: 0px; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">CRM &nbsp;<span style="font-size: 12px;">&copy;2019&nbsp;动力节点</span></div>
</div>

<div style="position: absolute; top: 120px; right: 100px;width:450px;height:400px;border:1px solid #D5D5D5">
	<div style="position: absolute; top: 0px; right: 60px;">
		<div class="page-header">
			<h1>登录</h1>
		</div>
		<form action="workbench/index.html" class="form-horizontal" role="form">
			<div class="form-group form-group-lg">
				<div style="width: 350px;">
					<input class="form-control" type="text" placeholder="用户名" autocomplete="off" id="loginAct">
				</div>
				<div style="width: 350px; position: relative;top: 20px;">
					<input class="form-control" type="password" placeholder="密码" id="loginPwd">
				</div>
				<div class="checkbox"  style="position: relative;top: 30px; left: 10px;">
					<label>
						<input type="checkbox" id="flag"> 十天内免登录
					</label>
					&nbsp;&nbsp;
					<span id="msg" style="color: red"></span>
				</div>
				<!--

                    注意：
                        此处button按钮，类型必须设置为button，否则会发出传统请求，提交form表单

                -->
				<button type="button" id="submitBtn" class="btn btn-primary btn-lg btn-block"  style="width: 350px; position: relative;top: 45px;">登录</button>

			</div>
		</form>
	</div>
</div>
</body>
</html>