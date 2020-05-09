<%@ page import="java.util.Map" %>
<%@ page import="java.util.Set" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";

	Map<String,String> pMap = (Map<String,String>)application.getAttribute("pMap");

	Set<String> set = pMap.keySet();

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
	<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
	<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

	<script src="jquery/bs_typeahead/bootstrap3-typeahead.min.js"></script>

	<script>

		var json = {

			<%

				for(String key:set){

					String value = pMap.get(key);
			%>

			"<%=key%>" : <%=value%>,

			<%


				}

			%>

		};

		//显示结果正确，不用特意的去处理最后一个逗号
		//alert(json); //object Object

		$(function () {

			$(".time1").datetimepicker({
				minView: "month",
				language:  'zh-CN',
				format: 'yyyy-mm-dd',
				autoclose: true,
				todayBtn: true,
				pickerPosition: "bottom-left"
			});

			$(".time2").datetimepicker({
				minView: "month",
				language:  'zh-CN',
				format: 'yyyy-mm-dd',
				autoclose: true,
				todayBtn: true,
				pickerPosition: "top-left"
			});

			//为查找联系人的搜索框绑定事件，根据名次搜索联系人列表
			$("#cname").keydown(function (event) {

				if(event.keyCode==13){

					//查询并展现联系人列表
					$.ajax({

						url : "workbench/transaction/getContactsListByFullname.do",
						data : {

							"fullname" : $.trim($("#cname").val())

						},
						type : "get",
						dataType : "json",
						success : function (data) {

							/*

                                data
                                List<Contacts> cList
                                [{联系人1},{2},{3}]

                             */

							var html = "";

							$.each(data,function (i,n) {

								html += '<tr>';
								html += '<td><input type="radio" value="'+n.id+'" name="xz"/></td>';
								html += '<td id="'+n.id+'">'+n.fullname+'</td>';
								html += '<td>'+n.email+'</td>';
								html += '<td>'+n.mphone+'</td>';
								html += '</tr>';

							})

							$("#contactsSearchBody").html(html);

						}

					})


					return false;


				}

			})

			//为搜索联系人的模态窗口中的提交按钮绑定事件，提交联系人
			//将联系人名称提交到联系人文本框中
			//将联系人的id提交到联系人文本框下面的隐藏域中
			$("#submitContactsBtn").click(function () {

				//取得选中的记录的id
				var $xz = $("input[name=xz]:checked");

				var id = $xz.val();

				//将id赋值给隐藏域
				$("#contactsId").val(id);

				//取得选中的联系人的名称
				var fullname = $("#"+id).html();

				//将选中的联系人名称，赋值到联系人的文本框中
				$("#contactsName").val(fullname);

				//以上值的部分处理完毕后
				//清空搜索框
				//清空搜索列表
				//关闭模态窗口
				$("#findContacts").modal("hide");


			})


			/*

				找到需要操作自动补全插件的文本框
				绑定typeahead事件，实现自动补全的操作
				typeahead事件我们以前基本的jquery操作是没有提供的，今天这个是由自动补全插件typeahead提供的

				一旦当我们在触发自动补全事件的文本框中，填写了信息
				source：function会立即执行
				该方法的执行时间，会在delay所设置的时间之后执行

				delay: 1500
				表示延迟加载方法的时间，单位是毫秒
				例如我们现在设置的是1500毫秒
				表示的就是在我们在文本框中输入了信息之后，过了1500毫秒，触发source:function方法

				source: function (query, process)
				该方法提供了两个参数
				第一个参数：是我们输入的关键字，将来要通过该关键字搜索自动补全列表，例如"阿"
				第二个参数：是我们在搜索完自动补全列表之后，用来展现列表的方法
							这个方法时由插件为我们提供好的，我们直接拿来使用即可

				自动补全的方法，只支持发送ajax请求来取得数据

			 */
			$("#create-customerName").typeahead({
				source: function (query, process) {
					$.get(
							"workbench/transaction/getCustomerNamesByName.do",
							{ "name" : query },
							function (data) {
								//alert(data);

								/*

									data
										List<String> sList...
										[{客户名称1},{2},{3}]

								 */

								process(data);
							},
							"json"
					);
				},
				delay: 500
			});


			//为阶段下拉框绑定选中事件，触发可能性文本框的赋值操作
			$("#create-stage").change(function () {

				//取得选中的阶段
				var stage = $("#create-stage").val();

				//alert(stage);

				//方式1：
				/*$.ajax({

					url : "workbench/transaction/getPossibilityByStage.do",
					data : {

						"stage" : stage

					},
					type : "get",
					dataType : "json",
					success : function (data) {

						/!*

							data
								{"possibility":"10"}

						 *!/

						var possibility = data.possibility;

						//为可能性的文本框赋值
						$("#create-possibility").val(possibility);



					}

				})*/

				//2.方式2

				//阶段：stage 有了
				//阶段和可能性之间的对应关系：pMap 有了
				/*

					虽然以上两个要素已经具备了，但是pMap是java脚本中的变量，这个变量是一个map集合，不能使用在js代码中

					我们现在需要将java脚本中的键值对关系pMap，转换为js中的键值对关系json，就能够正常取值了
					json(pMap)我们也有了
					object Object
					{"01资质审查":"10","02需求分析":25...}

				 */

				//var possibility = json.stage;

				/*

					以上取值方式失败
					我们以前使用的json，都是从后台处理好的键值对，
					key都是固定不变的常量，所以我们直接以json.key的形式来取得value值非常方便

					我们今天使用json.key的形式就不行了，因为key是stage，这个stage是一个变量
							每次我们通过阶段的下拉框进行选择后，key都是不同的
							如果key是一个变量，那么我们就要使用以json[key]的形式来取得value值

				 */
				var possibility = json[stage];
				//alert(possibility);

				//为可能性的文本框赋值
				$("#create-possibility").val(possibility);


			})


			//为保存按钮绑定事件，执行交易的添加操作
			/*

				由于不需要在页面中局部刷新任何信息
				所以发出传统请求即可，做交易的添加操作
				添加完毕后，跳转到交易的列表页


			 */
			$("#saveTranBtn").click(function () {

				/*

					我们是要处理添加操作，参数会非常多，按照我们之前的约定，添加、修改、删除操作统一走post请求方式

					如果我们发出普通的超链接window.location.href,发出的肯定是一个get请求，需要我们自己手动在路径后面挂参数，不确定参数的完整性

					所以我们肯定是要以提交form表单的方式，发出post请求


				 */

				$("#tranForm").submit();

			})


		})



	</script>

</head>
<body>

<!-- 查找市场活动 -->
<div class="modal fade" id="findMarketActivity" role="dialog">
	<div class="modal-dialog" role="document" style="width: 80%;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">×</span>
				</button>
				<h4 class="modal-title">查找市场活动</h4>
			</div>
			<div class="modal-body">
				<div class="btn-group" style="position: relative; top: 18%; left: 8px;">
					<form class="form-inline" role="form">
						<div class="form-group has-feedback">
							<input type="text" class="form-control" style="width: 300px;" placeholder="请输入市场活动名称，支持模糊查询">
							<span class="glyphicon glyphicon-search form-control-feedback"></span>
						</div>
					</form>
				</div>
				<table id="activityTable3" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
					<thead>
					<tr style="color: #B3B3B3;">
						<td></td>
						<td>名称</td>
						<td>开始日期</td>
						<td>结束日期</td>
						<td>所有者</td>
					</tr>
					</thead>
					<tbody>
					<tr>
						<td><input type="radio" name="activity"/></td>
						<td>发传单</td>
						<td>2020-10-10</td>
						<td>2020-10-20</td>
						<td>zhangsan</td>
					</tr>
					<tr>
						<td><input type="radio" name="activity"/></td>
						<td>发传单</td>
						<td>2020-10-10</td>
						<td>2020-10-20</td>
						<td>zhangsan</td>
					</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>

<!-- 查找联系人 -->
<div class="modal fade" id="findContacts" role="dialog">
	<div class="modal-dialog" role="document" style="width: 80%;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">×</span>
				</button>
				<h4 class="modal-title">查找联系人</h4>
			</div>
			<div class="modal-body">
				<div class="btn-group" style="position: relative; top: 18%; left: 8px;">
					<form class="form-inline" role="form">
						<div class="form-group has-feedback">
							<input type="text" class="form-control" id="cname" style="width: 300px;" placeholder="请输入联系人名称，支持模糊查询">
							<span class="glyphicon glyphicon-search form-control-feedback"></span>
						</div>
					</form>
				</div>
				<table id="activityTable" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
					<thead>
					<tr style="color: #B3B3B3;">
						<td></td>
						<td>名称</td>
						<td>邮箱</td>
						<td>手机</td>
					</tr>
					</thead>
					<tbody id="contactsSearchBody">
					<%--<tr>
                        <td><input type="radio" name="activity"/></td>
                        <td>李四</td>
                        <td>lisi@bjpowernode.com</td>
                        <td>12345678901</td>
                    </tr>
                    <tr>
                        <td><input type="radio" name="activity"/></td>
                        <td>李四</td>
                        <td>lisi@bjpowernode.com</td>
                        <td>12345678901</td>
                    </tr>--%>
					</tbody>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				<button type="button" class="btn btn-primary" id="submitContactsBtn">提交</button>
			</div>
		</div>
	</div>
</div>


<div style="position:  relative; left: 30px;">
	<h3>创建交易</h3>
	<div style="position: relative; top: -40px; left: 70%;">
		<button type="button" class="btn btn-primary" id="saveTranBtn">保存</button>
		<button type="button" class="btn btn-default">取消</button>
	</div>
	<hr style="position: relative; top: -40px;">
</div>
<form id="tranForm" action="workbench/transaction/saveTran.do" method="post" class="form-horizontal" role="form" style="position: relative; top: -30px;">
	<div class="form-group">
		<label for="create-transactionOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
		<div class="col-sm-10" style="width: 300px;">
			<select class="form-control" id="create-transactionOwner" name="owner">
				<option></option>
				<c:forEach items="${uList}" var="u">

					<%--

                        ${user} --> 从域对象中搜索叫做user的key
                        ${"user"} --> 在页面中输出一个user字符串

                    --%>

					<option value="${u.id}" ${u.id eq user.id ?"selected":""}>${u.name}</option>
				</c:forEach>
			</select>
		</div>
		<label for="create-amountOfMoney" class="col-sm-2 control-label">金额</label>
		<div class="col-sm-10" style="width: 300px;">
			<input type="text" class="form-control" id="create-amountOfMoney" name="money">
		</div>
	</div>

	<div class="form-group">
		<label for="create-transactionName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
		<div class="col-sm-10" style="width: 300px;">
			<input type="text" class="form-control" id="create-transactionName" name="name">
		</div>
		<label for="create-expectedClosingDate" class="col-sm-2 control-label">预计成交日期<span style="font-size: 15px; color: red;">*</span></label>
		<div class="col-sm-10" style="width: 300px;">
			<input type="text" class="form-control time1" id="create-expectedClosingDate" name="expectedDate">
		</div>
	</div>

	<div class="form-group">
		<label for="create-accountName" class="col-sm-2 control-label">客户名称<span style="font-size: 15px; color: red;">*</span></label>
		<div class="col-sm-10" style="width: 300px;">
			<!--

                在使用bootstrap的自动补全插件前
                需要禁用掉浏览器的自动补全机制
                autocomplete="off"

            -->
			<input type="text" class="form-control" id="create-customerName" name="customerName" autocomplete="off" placeholder="支持自动补全，输入客户不存在则新建">
		</div>
		<label for="create-transactionStage" class="col-sm-2 control-label">阶段<span style="font-size: 15px; color: red;">*</span></label>
		<div class="col-sm-10" style="width: 300px;">
			<select class="form-control" id="create-stage" name="stage">
				<option></option>
				<c:forEach items="${stageList}" var="s">
					<option value="${s.value}">${s.text}</option>
				</c:forEach>
			</select>
		</div>
	</div>

	<div class="form-group">
		<label for="create-transactionType" class="col-sm-2 control-label">类型</label>
		<div class="col-sm-10" style="width: 300px;">
			<select class="form-control" id="create-transactionType" name="type">
				<option></option>
				<c:forEach items="${transactionTypeList}" var="t">
					<option value="${t.value}">${t.text}</option>
				</c:forEach>
			</select>
		</div>
		<label for="create-possibility" class="col-sm-2 control-label">可能性</label>
		<div class="col-sm-10" style="width: 300px;">
			<input type="text" class="form-control" id="create-possibility">
		</div>
	</div>

	<div class="form-group">
		<label for="create-clueSource" class="col-sm-2 control-label">来源</label>
		<div class="col-sm-10" style="width: 300px;">
			<select class="form-control" id="create-clueSource" name="source">
				<option></option>
				<c:forEach items="${sourceList}" var="s">
					<option value="${s.value}">${s.text}</option>
				</c:forEach>
			</select>
		</div>
		<label for="create-activitySrc" class="col-sm-2 control-label">市场活动源&nbsp;&nbsp;<a href="javascript:void(0);" data-toggle="modal" data-target="#findMarketActivity"><span class="glyphicon glyphicon-search"></span></a></label>
		<div class="col-sm-10" style="width: 300px;">
			<input type="text" class="form-control" id="create-activitySrc" value="发传单1">
			<input type="hidden" value="0b94db302c3f44ceadef3a01e7974df2" name="activityId"/>
		</div>
	</div>

	<div class="form-group">
		<label for="create-contactsName" class="col-sm-2 control-label">联系人名称&nbsp;&nbsp;<a href="javascript:void(0);" data-toggle="modal" data-target="#findContacts"><span class="glyphicon glyphicon-search"></span></a></label>
		<div class="col-sm-10" style="width: 300px;">
			<input type="text" class="form-control" id="contactsName">
			<input type="hidden" id="contactsId" name="contactsId"/>
		</div>
	</div>

	<div class="form-group">
		<label for="create-describe" class="col-sm-2 control-label">描述</label>
		<div class="col-sm-10" style="width: 70%;">
			<textarea class="form-control" rows="3" id="create-describe" name="description"></textarea>
		</div>
	</div>

	<div class="form-group">
		<label for="create-contactSummary" class="col-sm-2 control-label">联系纪要</label>
		<div class="col-sm-10" style="width: 70%;">
			<textarea class="form-control" rows="3" id="create-contactSummary" name="contactSummary"></textarea>
		</div>
	</div>

	<div class="form-group">
		<label for="create-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
		<div class="col-sm-10" style="width: 300px;">
			<input type="text" class="form-control time2" id="create-nextContactTime" name="nextContactTime">
		</div>
	</div>

</form>
</body>
</html>