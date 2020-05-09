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

	<script type="text/javascript">

		//默认情况下取消和保存按钮是隐藏的
		var cancelAndSaveBtnDefault = true;

		$(function(){
			$("#remark").focus(function(){
				if(cancelAndSaveBtnDefault){
					//设置remarkDiv的高度为130px
					$("#remarkDiv").css("height","130px");
					//显示
					$("#cancelAndSaveBtn").show("2000");
					cancelAndSaveBtnDefault = false;
				}
			});

			$("#cancelBtn").click(function(){
				//显示
				$("#cancelAndSaveBtn").hide();
				//设置remarkDiv的高度为130px
				$("#remarkDiv").css("height","90px");
				cancelAndSaveBtnDefault = true;
			});

			$(".remarkDiv").mouseover(function(){
				$(this).children("div").children("div").show();
			});

			$(".remarkDiv").mouseout(function(){
				$(this).children("div").children("div").hide();
			});

			$(".myHref").mouseover(function(){
				$(this).children("span").css("color","red");
			});

			$(".myHref").mouseout(function(){
				$(this).children("span").css("color","#E6E6E6");
			});

			/*

                在页面加载完毕后，自动发出一个ajax请求，取得备注信息列表

                1.为什么是在页面加载完毕后，发出请求取得备注信息列表呢？（为什么备注信息列表的数据不随着市场活动的详细信息一起发送过来呢？）

                2.为什么发出的是ajax请求？
                    （1）如果1成立，那么必须是ajax请求才能做到这项操作
                    （2）我们一会要在该页面上处理备注的添加，修改，删除操作，每一次操作完毕后，都需要"局部刷新"备注信息列表

             */

			//在页面加载完毕后，展现备注信息列表
			showRemarkList();

			$("#remarkBody").on("mouseover",".remarkDiv",function(){
				$(this).children("div").children("div").show();
			})
			$("#remarkBody").on("mouseout",".remarkDiv",function(){
				$(this).children("div").children("div").hide();
			})

			//为保存按钮绑定事件，执行备注的添加操作
			$("#saveRemarkBtn").click(function () {

				$.ajax({

					url : "workbench/activity/saveRemark.do",
					data : {

						"noteContent" : $.trim($("#remark").val()),
						"activityId" : "${a.id}"

					},
					type : "post",
					dataType : "json",
					success : function (data) {

						/*

                            data
                                {"success":true/false,"ar":{备注}}

                         */

						if(data.success){

							//添加成功

							//将文本域中的信息去除
							$("#remark").val("");

							//新建div，在列表上进行追加
							var html = "";
							html += '<div id="'+data.ar.id+'" class="remarkDiv" style="height: 60px;">';
							html += '<img title="zhangsan" src="image/user-thumbnail.png" style="width: 30px; height:30px;">';
							html += '<div style="position: relative; top: -40px; left: 40px;" >';

							html += '<h5 id="e'+data.ar.id+'">'+data.ar.noteContent+'</h5>';
							// html += '<h5>'+data.ar.noteContent+'</h5>';

							html += '<font color="gray">市场活动</font> <font color="gray">-</font> <b>${a.name}</b> <small style="color: gray;"> '+(data.ar.createTime)+' 由'+(data.ar.createBy)+'</small>';
							html += '<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">';
							html += '<a class="myHref" href="javascript:void(0);" onclick="updateRemark(\''+data.ar.id+'\')"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #FF0000;"></span></a>';
							html += '&nbsp;&nbsp;&nbsp;&nbsp;';
							html += '<a class="myHref" href="javascript:void(0);" onclick="deleteRemark(\''+data.ar.id+'\')"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #FF0000;"></span></a>';
							html += '</div>';
							html += '</div>';
							html += '</div>';
							$("#remarkDiv").before(html);

/*
							pageList($("#activityPage").bs_pagination('getOption', 'currentPage')
									,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));
									onclick="updateRemark(\''+n.id+'\')"
*/


						}else{

							alert("添加备注失败");

						}

					}

				})

			})


			//为更新按钮绑定事件，执行备注的修改操作
			$("#updateRemarkBtn").click(function () {

				var id = $("#remarkId").val();

				$.ajax({

					url : "workbench/activity/updateRemark.do",
					data : {

						"id" : id,
						"noteContent" : $.trim($("#noteContent").val())

					},
					type : "post",
					dataType : "json",
					success : function (data) {

						/*

                            data
                                {"success":true/false,"ar":{备注}}

                         */

						if(data.success){

							//修改成功

							//更新备注信息列表上的 备注信息，修改时间，修改人

							//更新备注信息
							$("#e"+id).html(data.ar.noteContent);
							//更新修改时间，修改人
							$("#s"+id).html(data.ar.editTime+" 由"+data.ar.editBy);

							//关闭模态窗口
							$("#editRemarkModal").modal("hide");


						}else{

							alert("修改备注失败");

						}

					}

				})

			})

		});

		function showRemarkList() {

			//alert("展现备注信息列表");

			$.ajax({

				url : "workbench/activity/getRemarkListByAid.do",
				data : {

					"activityId" : "${a.id}"

				},
				type : "get",
				dataType : "json",
				success : function (data) {

					/*

                        data
                            List<ActivityRemark> arList...
                            [{备注1},{2},{3}]

                     */

					var html = "";

					$.each(data,function (i,n) {

						/*

                            javascript:void(0)
                                禁用超链接，超链接必须以触发（绑定）事件的形式执行操作

                            如果元素是通过在js或者java脚本
                            如果是动态拼接的for循环中的元素
                            那么我们一般的做法都是以直接触发事件的方式来进行操作，而不是绑定事件
                            在js动态拼接的元素中，直接触发事件传递的参数必须要包含在引号当中

                         */

						html += '<div id="'+n.id+'" class="remarkDiv" style="height: 60px;">';
						html += '<img title="zhangsan" src="image/user-thumbnail.png" style="width: 30px; height:30px;">';
						html += '<div style="position: relative; top: -40px; left: 40px;" >';
						html += '<h5 id="e'+n.id+'">'+n.noteContent+'</h5>';
						html += '<font color="gray">市场活动</font> <font color="gray">-</font> <b>${a.name}</b> <small id="s'+n.id+'" style="color: gray;"> '+(n.editFlag==0?n.createTime:n.editTime)+' 由'+(n.editFlag==0?n.createBy:n.editBy)+'</small>';
						html += '<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">';
						html += '<a class="myHref" href="javascript:void(0);" onclick="updateRemark(\''+n.id+'\')"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #FF0000;"></span></a>';
						html += '&nbsp;&nbsp;&nbsp;&nbsp;';
						html += '<a class="myHref" href="javascript:void(0);" onclick="deleteRemark(\''+n.id+'\')"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #FF0000;"></span></a>';
						html += '</div>';
						html += '</div>';
						html += '</div>';

					})

					//以上备注列表信息拼接完毕
					//找到添加操作文本域所在的div，在上方追加备注信息列表
					$("#remarkDiv").before(html);

				}

			})

		}

		//
		function deleteRemark(id) {

			$.ajax({

				url : "workbench/activity/deleteRemarkById.do",
				data : {

					"id" : id

				},
				type : "get",
				dataType : "json",
				success : function (data) {

					/*

                        data
                            {"success":true/false}

                     */

					if(data.success){

						//删除成功

						//刷新列表？？？ 不行，我们使用的是before方法，删除之后刷列表会不断的在原有内容的基础上追加新信息
						//showRemarkList();

						//取得删除记录所在的div的jquery对象
						//将这个div给移除掉
						$("#"+id).remove();

					}else{

						alert("删除备注失败");

					}

				}

			})

		}

		function updateRemark(id) {

			//为修改操作模态窗口，隐藏域中的id赋值
			$("#remarkId").val(id);

			//取得需要编辑的信息
			//取得需要编辑的信息所在的h5标签对
			var noteContent = $("#e"+id).html();

			//将需要编辑的信息，赋值给修改操作模态窗口中的文本域
			$("#noteContent").val(noteContent);

			//以上信息全部处理完毕后，将模态窗口打开
			$("#editRemarkModal").modal("show");

		}

	</script>

</head>
<body>

<!-- 修改市场活动备注的模态窗口 -->
<div class="modal fade" id="editRemarkModal" role="dialog">
	<%-- 备注的id --%>
	<input type="hidden" id="remarkId">
	<div class="modal-dialog" role="document" style="width: 40%;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">×</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">修改备注</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" role="form">
					<div class="form-group">
						<label for="edit-describe" class="col-sm-2 control-label">内容</label>
						<div class="col-sm-10" style="width: 81%;">
							<textarea class="form-control" rows="3" id="noteContent"></textarea>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" id="updateRemarkBtn">更新</button>
			</div>
		</div>
	</div>
</div>



<!-- 返回按钮 -->
<div style="position: relative; top: 35px; left: 10px;">
	<a href="javascript:void(0);" onclick="window.history.back();"><span class="glyphicon glyphicon-arrow-left" style="font-size: 20px; color: #DDDDDD"></span></a>
</div>

<!-- 大标题 -->
<div style="position: relative; left: 40px; top: -30px;">
	<div class="page-header">
		<h3>市场活动-${a.name} <small>${a.startDate} ~ ${a.endDate}</small></h3>
	</div>

</div>

<br/>
<br/>
<br/>

<!-- 详细信息 -->
<div style="position: relative; top: -70px;">
	<div style="position: relative; left: 40px; height: 30px;">
		<div style="width: 300px; color: gray;">所有者</div>
		<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${a.owner}</b></div>
		<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">名称</div>
		<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${a.name}</b></div>
		<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
		<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
	</div>

	<div style="position: relative; left: 40px; height: 30px; top: 10px;">
		<div style="width: 300px; color: gray;">开始日期</div>
		<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${a.startDate}</b></div>
		<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">结束日期</div>
		<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${a.endDate}</b></div>
		<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
		<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
	</div>
	<div style="position: relative; left: 40px; height: 30px; top: 20px;">
		<div style="width: 300px; color: gray;">成本</div>
		<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${a.cost}</b></div>
		<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px;"></div>
	</div>
	<div style="position: relative; left: 40px; height: 30px; top: 30px;">
		<div style="width: 300px; color: gray;">创建者</div>
		<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${a.createBy}&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;">${a.createTime}</small></div>
		<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
	</div>
	<div style="position: relative; left: 40px; height: 30px; top: 40px;">
		<div style="width: 300px; color: gray;">修改者</div>
		<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${a.editBy}&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;">${a.editTime}</small></div>
		<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
	</div>
	<div style="position: relative; left: 40px; height: 30px; top: 50px;">
		<div style="width: 300px; color: gray;">描述</div>
		<div style="width: 630px;position: relative; left: 200px; top: -20px;">
			<b>
				${a.description}
			</b>
		</div>
		<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
	</div>
</div>

<!-- 备注 -->
<div style="position: relative; top: 30px; left: 40px;" id="remarkBody">
	<div class="page-header">
		<h4>备注</h4>
	</div>

	<!-- 备注1 -->
	<%--<div class="remarkDiv" style="height: 60px;">
        <img title="zhangsan" src="image/user-thumbnail.png" style="width: 30px; height:30px;">
        <div style="position: relative; top: -40px; left: 40px;" >
            <h5>哎呦！</h5>
            <font color="gray">市场活动</font> <font color="gray">-</font> <b>发传单</b> <small style="color: gray;"> 2017-01-22 10:10:10 由zhangsan</small>
            <div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">
                <a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #E6E6E6;"></span></a>
                &nbsp;&nbsp;&nbsp;&nbsp;
                <a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #E6E6E6;"></span></a>
            </div>
        </div>
    </div>--%>

	<!-- 备注2 -->
	<%--<div class="remarkDiv" style="height: 60px;">
        <img title="zhangsan" src="image/user-thumbnail.png" style="width: 30px; height:30px;">
        <div style="position: relative; top: -40px; left: 40px;" >
            <h5>呵呵！</h5>
            <font color="gray">市场活动</font> <font color="gray">-</font> <b>发传单</b> <small style="color: gray;"> 2017-01-22 10:20:10 由zhangsan</small>
            <div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">
                <a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #E6E6E6;"></span></a>
                &nbsp;&nbsp;&nbsp;&nbsp;
                <a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #E6E6E6;"></span></a>
            </div>
        </div>
    </div>--%>

	<div id="remarkDiv" style="background-color: #E6E6E6; width: 870px; height: 90px;">
		<form role="form" style="position: relative;top: 10px; left: 10px;">
			<textarea id="remark" class="form-control" style="width: 850px; resize : none;" rows="2"  placeholder="添加备注..."></textarea>
			<p id="cancelAndSaveBtn" style="position: relative;left: 737px; top: 10px; display: none;">
				<button id="cancelBtn" type="button" class="btn btn-default">取消</button>
				<button type="button" class="btn btn-primary" id="saveRemarkBtn">保存</button>
			</p>
		</form>
	</div>
</div>
<div style="height: 200px;"></div>
</body>
</html>