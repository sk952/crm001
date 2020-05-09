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

<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
	<script>

		$(function () {

			//为编辑按钮绑定事件，跳转到修改页
			$("#abtn").click(function () {

				//选中所有name=xz的input元素，筛选条件是选中的元素
				//如果在js代码中，既有jquery对象，又有dom对象，那么我们一般都是在jquery对象的命名前加上一个$符号，以示区分
				var $xz = $("input[name=xz]:checked");

				//判断用户有没有对复选框进行选择，如果选了则跳转到修改页，如果没选或者选多了，则给予相应的提示信息1
				//jquery对象可以当做dom对象的数组来使用
				/*

					例如以上jquery对象$xz,里面有的是[dom1,dom2,dom3...]，每一个dom都是选中的一个复选框

				 */
				if($xz.length==0){

					alert("请选择需要修改的记录");

				}else if($xz.length>1){

					alert("只能选择一条记录执行修改操作");

					//肯定是挑√了，而且只选中了一条
				}else{

					//只所以判断复选框的挑√情况，是因为最终我们要拿到需要修改的记录的code
					//通过该code为参数，将该参数传递到后台，后台根据code取得详细信息
					//拿到了该条记录的详细信息后，最终打开修改页，修改页上才会有记录的原始值

					//取得选中的记录的code
					//虽然是复选框，但是我们现在在else语句块中，是能够确保只选中了一条记录的
					//所以，我们就直接调用val()方法，取值表单元素值即可
					var value = $xz.val();
					// alert(value)

					//进入到用来跳转到修改页的后台
					window.location.href = "settings/dictionary/value/toValueUpdate.do?value="+value;

				}


			})

			//为全选的复选框绑定事件，执行全选/反选操作
			$("#qx").click(function () {

				//判断qx是挑√了还是灭√了
				/*if($("#qx").prop("checked")){

					//alert("挑√了");
					var $xz = $("input[name=xz]");

					//遍历所有name=xz的input
					for(var i=0;i<$xz.length;i++){

						//取得每一个复选框的dom
						$xz[i].checked = true;

					}

				}else{

					//alert("灭√了")
					var $xz = $("input[name=xz]");

					//遍历所有name=xz的input
					for(var i=0;i<$xz.length;i++){

						//取得每一个复选框的dom
						$xz[i].checked = false;

					}
				}*/

				//this:绑定的当前jquery对象的dom对象

				// $("input[name=xz]").prop("checked",$("#qx")[0].checked);
				$("input[name=xz]").prop("checked",this.checked);



			})

			//为普通的复选框绑定事件，操作全选的复选框
			$("input[name=xz]").click(function () {

				$("#qx").prop("checked",$("input[name=xz]").length==$("input[name=xz]:checked").length)

			})

			//为删除按钮绑定事件，执行字典类型的删除操作（可批量删除+关联关系表相关的删除）
			$("#bbtn").click(function () {

				var $xz = $("input[name=xz]:checked");

				if($xz.length==0){

					alert("请选择需要删除的记录");

					//在else体内，肯定挑√了，有可能是选中了一条，也有可能是选中了多条
				}else{

					//deleteType.do?codes=xxx&codes=xxx&codes=xxx

					//先要取得所有的需要删除的code，然后将code拼接成为传递的参数的形态codes=xxx&codes=xxx&codes=xxx

					//通过$xz.val()直接取值，只能取得选中的第一个复选框的值，这样是不能做批量删除的
					 //alert($xz.val());

					//删除功能在系统中属于危险动作，必须给予提示

					if(confirm("确定删除所选记录吗？")){

						var param = "";

						//遍历所有选中的复选框
						for(var i=0;i<$xz.length;i++){

							/*

                                jquery对象转换为dom对象
                                    jquery[0]


                                dom对象转换为jquery对象
                                    $(dom)

                             */

							param += "codes="+$($xz[i]).val();
							//如果不是最后一条记录
							if(i<$xz.length-1){

								//在后面多追加一个&符
								param += "&";

							}

						}
						 //alert(param);

						//以上参数拼接完毕后，为后台发出请求，执行类型的删除操作
						 window.location.href = "settings/dictionary/value/deleteValue.do?"+param;

					}



				}

			})


		})

	</script>

</head>
<body>

	<div>
		<div style="position: relative; left: 30px; top: -10px;">
			<div class="page-header">
				<h3>字典值列表</h3>
			</div>
		</div>
	</div>
	<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;left: 30px;">
		<div class="btn-group" style="position: relative; top: 18%;">
		  <button type="button" class="btn btn-primary" onclick="window.location.href='settings/dictionary/value/toValueSave.do'"><span class="glyphicon glyphicon-plus"></span> 创建</button>
		  <button type="button" class="btn btn-default"  id="abtn" ><span class="glyphicon glyphicon-edit"></span>编辑</button>
		  <button type="button" class="btn btn-danger" id="bbtn"><span class="glyphicon glyphicon-minus"></span> 删除</button>
		</div>
	</div>
	<div style="position: relative; left: 30px; top: 20px;">
		<table class="table table-hover">
			<thead>
				<tr style="color: #B3B3B3;">
					<td><input type="checkbox" id="qx"/></td>
					<td>序号</td>
					<td>字典值</td>
					<td>文本</td>
					<td>排序号</td>
					<td>字典类型编码</td>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${dvList}" var="dv" varStatus="vs">
					<tr class="active">
						<td><input type="checkbox" name="xz" value="${dv.value}"/></td>
						<td>${vs.count}</td>
						<td>${dv.value}</td>
						<td>${dv.text}</td>
						<td>${dv.orderNo}</td>
						<td>${dv.typeCode}</td>
					</tr>
					
				</c:forEach>


				<%--<tr class="active">
					<td><input type="checkbox" /></td>
					<td>1</td>
					<td>m</td>
					<td>男</td>
					<td>1</td>
					<td>sex</td>
				</tr>
				<tr>
					<td><input type="checkbox" /></td>
					<td>2</td>
					<td>f</td>
					<td>女</td>
					<td>2</td>
					<td>sex</td>
				</tr>
				<tr class="active">
					<td><input type="checkbox" /></td>
					<td>3</td>
					<td>1</td>
					<td>一级部门</td>
					<td>1</td>
					<td>orgType</td>
				</tr>
				<tr>
					<td><input type="checkbox" /></td>
					<td>4</td>
					<td>2</td>
					<td>二级部门</td>
					<td>2</td>
					<td>orgType</td>
				</tr>
				<tr class="active">
					<td><input type="checkbox" /></td>
					<td>5</td>
					<td>3</td>
					<td>三级部门</td>
					<td>3</td>
					<td>orgType</td>
				</tr>--%>
			</tbody>
		</table>
	</div>
	
</body>
</html>