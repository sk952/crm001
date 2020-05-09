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


	<link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
	<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

	<script type="text/javascript">
		$(function(){

			$("#isCreateTransaction").click(function(){
				if(this.checked){
					$("#create-transaction2").show(200);
				}else{
					$("#create-transaction2").hide(200);
				}
			});

			$(".time").datetimepicker({
				minView: "month",
				language:  'zh-CN',
				format: 'yyyy-mm-dd',
				autoclose: true,
				todayBtn: true,
				pickerPosition: "bottom-left"
			});

			//为搜索市场活动的文本框，绑定事件，执行搜索市场活动的操作
			//绑定的是敲键盘事件，如果敲的键位是13，说明是回车键，执行搜索市场活动的操作
			$("#aname").keydown(function (event) {

				if(event.keyCode==13){

					//alert("搜索并展现市场活动列表");

					$.ajax({

						url : "workbench/clue/getActvityListByName.do",
						data : {

							"name" : $.trim($("#aname").val())

						},
						type : "get",
						dataType : "json",
						success : function (data) {

							/*

                                data
                                    List<Activity> aList
                                    [{市场活动1},{2},{3}]

                             */

							var html = "";

							$.each(data,function (i,n) {

								html += '<tr>';
								html += '<td><input type="radio" name="xz" value="'+n.id+'"/></td>';
								html += '<td id="'+n.id+'">'+n.name+'</td>';
								html += '<td>'+n.startDate+'</td>';
								html += '<td>'+n.endDate+'</td>';
								html += '<td>'+n.owner+'</td>';
								html += '</tr>';

							})

							$("#activitySearchBody").html(html);

						}

					})


					return false;

				}

			})

			$("#submitActivityBtn").click(function () {

				//取得选中的记录的id
				//我们以前操作过复选框，操作单选框与操作复选框的形式一模一样，将单选框当做成只选中了一条记录的复选框
				var $xz = $("input[name=xz]:checked");

				if($xz.length==0){

					alert("请选择需要提交的市场活动");

				}else{

					//肯定选了，而且肯定只选了一条（因为是单选框）
					//如果只选中了一条记录（不论单选框还是复选框），可以直接通过val()方法取得唯一一条记录的value值
					var id = $xz.val();

					//为表单隐藏域中的id赋值
					$("#activityId").val(id);

					//找到选中的市场活动记录的名称
					var name = $("#"+id).html();

					//为表单中的市场活动源的文本框赋值
					$("#activityName").val(name);

					//关闭模态窗口
					$("#searchActivityModal").modal("hide");

					/*

                        关于上述对于jquery代码存取值的总结：

                            一般情况下，如果你所有的存取值操作，统一写在了一个方法当中
                            我们都是先处理id，再处理其他的表单元素
                            因为处理完id之后，有可能在处理其他元素的时候，有可能会使用到id


                     */

				}

			})

			//为转换按钮绑定事件，执行线索的转换操作
			$("#convertBtn").click(function () {

				/*

                    执行线索转换的操作，发出传统请求还是ajax请求？

                    在执行完线索的转换之后，不需要在线索转换的页面局部刷新任何信息
                    在转换完成后，回到线索的列表页
                    同时在列表页上，我们已经看不到刚刚转换的线索了（潜在客户已经升级为真实客户了，线索中已经把这条记录去除了）

                    传统请求：

                        在浏览器地址栏，输入地址，敲回车
                        <a href>超链接
                        提交form表单（get/post）
                        执行js代码：window.location.href=""
                        ...

                 */

				/*

                    执行线索的转换，分成两种情况

                    一种是只做线索的转换，不创建交易
                    一种是在做线索转换的同时，创建一笔临时交易

                    如何判断要不要创建交易？
                        根据"为客户创建交易"的复选框有没有选中来决定是否需要创建交易
                        如果选中了，则需要创建交易，否则不需要创建交易

                    不论是否需要创建交易，主营业务就是线索转换，是不变的
                    所以，请求的路径都是走convert.do

                 */

				if($("#isCreateTransaction").prop("checked")){

					alert("需要创建交易");

					/*

                        传递参数：clueId
                            这个参数是必须传的，必须要让后台知道我们要转换的是哪条记录

                        除了做线索转换业务使用到的clueId参数之外，还得需要创建交易业务所需要的参数
                        这些参数从交易表单中得来，共5个交易表单的参数

                     */

					/*

                        以下处理方式是可以执行的，但是会产生两个问题
                        1.参数数量比较多，共6个参数，从可读性来讲比较难以读懂，从可操作性来讲比较麻烦（参数是手动拼接的）
                        2.不利于将来的维护

                     */

					//window.location.href = "workbench/clue/convert.do?clueId=xxx&money=xxx&name=xxx&expectedDate=xxx&stage=xxx&activityId=xxx";

					//我们可以以提交表单的方式来发出这个线索转换的请求
					//对于参数的传递会很方便，而且有利于日后的维护及扩展

					//提交表单
					$("#tranSaveForm").submit();

				}else{

					alert("不需要创建交易")

					/*

                        传递参数：clueId
                            这个参数是必须传的，必须要让后台知道我们要转换的是哪条记录

                     */
					window.location.href = "workbench/clue/convert.do?clueId=${c.id}";

				}



			})

		});
	</script>

</head>
<body>

<!-- 搜索市场活动的模态窗口 -->
<div class="modal fade" id="searchActivityModal" role="dialog" >
	<div class="modal-dialog" role="document" style="width: 90%;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">×</span>
				</button>
				<h4 class="modal-title">搜索市场活动</h4>
			</div>
			<div class="modal-body">
				<div class="btn-group" style="position: relative; top: 18%; left: 8px;">
					<form class="form-inline" role="form">
						<div class="form-group has-feedback">
							<input type="text" class="form-control" id="aname" style="width: 300px;" placeholder="请输入市场活动名称，支持模糊查询">
							<span class="glyphicon glyphicon-search form-control-feedback"></span>
						</div>
					</form>
				</div>
				<table id="activityTable" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
					<thead>
					<tr style="color: #B3B3B3;">
						<td></td>
						<td>名称</td>
						<td>开始日期</td>
						<td>结束日期</td>
						<td>所有者</td>
						<td></td>
					</tr>
					</thead>
					<tbody id="activitySearchBody">
					<%--<tr>
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
                    </tr>--%>
					</tbody>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				<button type="button" class="btn btn-primary" id="submitActivityBtn">提交</button>
			</div>
		</div>
	</div>
</div>

<div id="title" class="page-header" style="position: relative; left: 20px;">
	<h4>转换线索 <small>${c.fullname}${c.appellation}-${c.company}</small></h4>
</div>
<div id="create-customer" style="position: relative; left: 40px; height: 35px;">
	新建客户：${c.company}
</div>
<div id="create-contact" style="position: relative; left: 40px; height: 35px;">
	新建联系人：${c.fullname}${c.appellation}
</div>
<div id="create-transaction1" style="position: relative; left: 40px; height: 35px; top: 25px;">
	<input type="checkbox" id="isCreateTransaction"/>
	为客户创建交易
</div>
<div id="create-transaction2" style="position: relative; left: 40px; top: 20px; width: 80%; background-color: #F7F7F7; display: none;" >

	<!--

        一旦我们选择了以传统方式提交表单
        那么关于参数的传递，我们一定要为表单元素赋予name属性值

        workbench/clue/convert.do?
        clueId=xxx&money=xxx&name=xxx&expectedDate=xxx&stage=xxx&activityId=xxx&flag=a

    -->
	<form id="tranSaveForm" action="workbench/clue/convert.do" method="post">

		<input type="hidden" name="flag" value="a"/>

		<input type="hidden" name="clueId" value="${c.id}"/>
		<div class="form-group" style="width: 400px; position: relative; left: 20px;">
			<label for="amountOfMoney">金额</label>
			<input type="text" class="form-control" id="amountOfMoney" name="money">
		</div>
		<div class="form-group" style="width: 400px;position: relative; left: 20px;">
			<label for="tradeName">交易名称</label>
			<input type="text" class="form-control" id="tradeName" name="name">
		</div>
		<div class="form-group" style="width: 400px;position: relative; left: 20px;">
			<label for="expectedClosingDate">预计成交日期</label>
			<input type="text" class="form-control time" id="expectedClosingDate" name="expectedDate">
		</div>
		<div class="form-group" style="width: 400px;position: relative; left: 20px;">
			<label for="stage">阶段</label>
			<select id="stage"  class="form-control" name="stage">
				<option></option>
				<c:forEach items="${stageList}" var="s">
					<option value="${s.value}">${s.text}</option>
				</c:forEach>
			</select>
		</div>
		<div class="form-group" style="width: 400px;position: relative; left: 20px;">
			<label for="activity">市场活动源&nbsp;&nbsp;<a href="javascript:void(0);" data-toggle="modal" data-target="#searchActivityModal" style="text-decoration: none;"><span class="glyphicon glyphicon-search"></span></a></label>
			<input type="text" class="form-control" id="activityName" placeholder="点击上面搜索" readonly>
			<input type="hidden" id="activityId" name="activityId">
		</div>
	</form>

</div>

<div id="owner" style="position: relative; left: 40px; height: 35px; top: 50px;">
	记录的所有者：<br>
	<b>${c.owner}</b>
</div>
<div id="operation" style="position: relative; left: 40px; height: 35px; top: 100px;">
	<input class="btn btn-primary" type="button" value="转换" id="convertBtn">
	&nbsp;&nbsp;&nbsp;&nbsp;
	<input class="btn btn-default" type="button" value="取消">
</div>
</body>
</html>