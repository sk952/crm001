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
	<%--日历控件--%>
	<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
	<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
	 <%--分页的插件--%>
	<link rel="stylesheet" type="text/css" href="jquery/bs_pagination/jquery.bs_pagination.min.css">
	<script type="text/javascript" src="jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
	<script type="text/javascript" src="jquery/bs_pagination/en.js"></script>

    <script type="text/javascript">

        $(function(){

            $(".time").datetimepicker({
                minView: "month",
                language:  'zh-CN',
                format: 'yyyy-mm-dd',
                autoclose: true,
                todayBtn: true,
                pickerPosition: "bottom-left"
            });


            /*

                点击按钮没有反应
                具体排查流程

                1.先点击F12，再点击"创建"按钮
                    观察你的Network，看看请求有没有发出去
                    如果请求没有发出去，一定是该方法中有js代码写错语法了，排查语法，可以使用简单的alert弹框去做标记
                    如果请求发出去了，请看第二步

                2.在你的ajax的回调函数中第一行，加入alert(data)
                    观察结果
                    如果弹框没反应 说明是后台代码出错了，进入到第三步
                    如果弹出了 object Object，说明我们是有json数据的，打印你拼接的html，看看是不是我们想要的拼接后的option
                    如果弹出了 [{},{},{}],说明这个json字符串并没有解析为json对象，查看你的dataType
                                        （a.看看你是不是写的是dateType b.看看你是不是写的是datatype）

                3.观察后台

                    从Controller开始排查
                    （1）看参数是不是我们想要接收的
                    （2）观察业务层有没有报错（错误信息大多数情况比较模糊，不容易排查，需要总结异常经验）

                    观察Service层
                    如果是比较复杂的业务逻辑，需要你打断点一步一步进行调试，每走一步，都需要观察结果，是不是我们想要的
                    如果是比较简单的业务逻辑，则不需要观察

                    观察dao层
                    主要观察的是log4j日志为我们打印的sql语句
                        观察sql语句本身
                        观察参数
                        观察返回记录数

                    如果dao层没有问题，service层也没有问题，controller也没问题（这3层都没有抛异常）
                    肯定是你的业务层写了一个return null;



            */

            //为创建按钮绑定一个事件，打开添加操作的模态窗口
            $("#toSaveActivityBtn").click(function () {

                /*

                    操作模态窗口
                        取得指定模态窗口的jquery对象，由该对象调用modal方法
                        该modal方法有两种取值
                                            show:打开模态窗口
                                            hide:关闭模态窗口

                 */

                //alert("查询用户信息列表，填充所有者下拉框");
                //打开模态窗口
                //$("#createActivityModal").modal("show");

                $.ajax({

                    url : "workbench/activity/getUserList.do",
                    type : "get",
                    dataType : "json",
                    success : function (data) {

                        /*

                            data
                                List<User> uList..
                                {"uList":[{用户1},{2},{3}...]}
                                如果我们现在返回的结果仅仅只有json数组本身，那么我们就不用为数组单独起一个key
                                所以上述json对象，可以简写为
                                [{用户1},{2},{3}...]

                         */

                        //data是一个json数组，我们现在要遍历这个数组，取得里面的每一个用户

                        /*

                            使用$.each遍历json数组

                            第一个参数data，就是我们需要遍历的数组

                            后面的function函数，我们要使用的是第二个参数n
                            每一个n，就是我们遍历出来的每一个json对象

                            对于本例来将，每一个n，就是每一个用户的json对象

                            json是以json.key的形式来取得value值

                         */

                        var html = "<option></option>";

                        $.each(data,function (i,n) {

                            html += "<option value='"+n.id+"'>"+n.name+"</option>";

                        })

                        //以上所有的option拼接完毕后，填充到所有者的select下拉框中
                        $("#create-owner").html(html);

                        //以上所有者的下拉框中的数据处理完毕了
                        //将添加市场活动的模态窗口打开
                        /*

                            出错点：
                                以下打开模态窗口的这行代码，没有写在ajax的回调函数中

                         */


                        //将当前登录的用户，作为所有者的默认选项
                        //取得当前登录的用户的id
                        //el表达式的取值是能够用在js代码中的，只不过需要套用在字符串的引号中
                        var id = "${user.id}";
                        //将id赋值给所有者下拉框
                        $("#create-owner").val(id);

                        $("#createActivityModal").modal("show");


                    }

                })



            })


            //为保存按钮绑定事件，执行市场活动的添加操作
            $("#saveActivityBtn").click(function () {

                $.ajax({

                    url : "workbench/activity/saveActivity.do",
                    data : {

                        "owner" : $.trim($("#create-owner").val()),
                        "name" : $.trim($("#create-name").val()),
                        "startDate" : $.trim($("#create-startDate").val()),
                        "endDate" : $.trim($("#create-endDate").val()),
                        "cost" : $.trim($("#create-cost").val()),
                        "description" : $.trim($("#create-description").val())

                    },
                    type : "post",
                    dataType : "json",
                    success : function (data) {

                        /*

                            data
                                {"success":true/false}

                         */

                        if(data.success){

                            //添加成功

                            //刷新列表
                            //pageList(1,2);
                            pageList(1,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));

                            //清空添加的form表单
                            /*

                                对于表单的jquery对象，jquery为我们提供了submit()方法用来提交表单
                                但是jquery并没有为我们提供reset()方法来重置表单（坑：idea有方法提示，其实没有这个方法）

                                虽然jquery没有为我们提供reset()方法，但是原生js的dom对象为我们提供了这个方法
                                所以我们现在的解题思路就是，将当前的form表单的jquery对象，给他转换称为dom对象就可以了

                             */
                            $("#activitySaveForm")[0].reset();

                            //关闭模态窗口
                            $("#createActivityModal").modal("hide");


                        }else{

                            alert("添加市场活动失败");

                        }

                    }

                })


            })

            pageList(1,2);


            //为查询按钮绑定事件，执行条件查询市场活动列表操作
            $("#searchActivityListBtn").click(function () {

                //在每一次，点击"查询"按钮后，将搜索框中的信息保存到隐藏域中
                $("#hidden-name").val($.trim($("#search-name").val()));
                $("#hidden-owner").val($.trim($("#search-owner").val()));
                $("#hidden-startDate").val($.trim($("#search-startDate").val()));
                $("#hidden-endDate").val($.trim($("#search-endDate").val()));

                pageList($("#activityPage").bs_pagination('getOption', 'currentPage')
                    ,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));

            })

            //为全选的复选框绑定事件，执行全选和反选操作
            $("#qx").click(function () {

                $("input[name=xz]").prop("checked",this.checked);

            })

            //为普通的复选框绑定事件，触发全选的复选框
            /*$("input[name=xz]").click(function () {

                alert(123);

            })*/

            /*

                以上写法不行了（在数据字典里面的处理是可以的，但是今天在市场活动里面就不行了）
                根数据字典列表的展现，比较起来
                我们市场活动列表生成的元素及数据，都是使用js代码拼接的方式动态生成的
                如果是我们自己拼接生成的元素，那么我们就不能够通过以传统方式的形式来对元素绑定事件
                我们要使用on方法来绑定动态生成的元素

                $(需要绑定的元素的有效的父级元素).on(绑定事件的方式,需要绑定的元素,回调函数)


                我们现在需要绑定的元素是$("input[name=xz]")
                父级元素是td标签，但是td标签不是有效的父级元素，因为td标签也是我们自己手动拼接生成的
                如果父级不行，则继续向上扩，直到是有效的父级为止
                最终我们找到了tBody


             */

            $("#activityBody").on("click",$("input[name=xz]"),function () {

                $("#qx").prop("checked",$("input[name=xz]").length==$("input[name=xz]:checked").length);

            })

            //为删除按钮绑定事件，执行市场活动的删除操作
            $("#deleteActivityBtn").click(function () {

                var $xz = $("input[name=xz]:checked");

                if($xz.length==0){

                    alert("请选择需要删除的记录");

                }else{

                    //肯定选了，有可能是一条，有可能选了多条

                    if(confirm("确定要删除所选记录吗?")){

                        var param = "";
                        //遍历所有选中的元素，取得id值，拼接为为后台传递的参数
                        for(var i=0;i<$xz.length;i++){

                            param += "ids="+$($xz[i]).val();

                            //如果不是最后一条记录，需要使用&做拼接
                            if(i<$xz.length-1){

                                param += "&";

                            }

                        }

                        //以上参数处理完毕后，发出ajax请求，删除市场活动
                        $.ajax({

                            url : "workbench/activity/deleteActivity.do",
                            data : param,
                            type : "post",
                            dataType : "json",
                            success : function (data) {

                                if(data.success){

                                    //删除成功
                                    //刷新列表
                                    //pageList(1,2);

                                    pageList(1,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));

                                }else{

                                    alert("删除市场活动失败");

                                }

                            }

                        })

                    }

                }

            })

            //为修改按钮绑定事件，打开修改市场活动的模态窗口
            $("#toUpdateActivityBtn").click(function () {

                var $xz = $("input[name=xz]:checked");

                if($xz.length==0){

                    alert("请选择需要修改的记录");

                }else if($xz.length>1){

                    alert("执行选择一条记录执行修改操作");

                }else{

                    //肯定选了，而且肯定只选了一条
                    var id = $xz.val();

                    //发出ajax请求，取得模态窗口中需要的值
                    $.ajax({

                        url : "workbench/activity/getUserListAndActivity.do",
                        data : {

                            "id" : id

                        },
                        type : "get",
                        dataType : "json",
                        success : function (data) {

                            /*

                                data
                                    List<User> uList
                                    Activity a
                                    {"uList":[{用户1},{2},{3}],"a":{市场活动}}

                             */

                            //处理所有者
                            var html = "<option></option>";

                            $.each(data.uList,function (i,n) {

                                html += "<option value='"+n.id+"'>"+n.name+"</option>";

                            })

                            $("#edit-owner").html(html);

                            //处理表单原始信息
                            $("#edit-id").val(data.a.id);
                            $("#edit-name").val(data.a.name);
                            $("#edit-owner").val(data.a.owner);
                            $("#edit-startDate").val(data.a.startDate);
                            $("#edit-endDate").val(data.a.endDate);
                            $("#edit-cost").val(data.a.cost);
                            $("#edit-description").val(data.a.description);

                            //以上两组信息处理完毕后
                            //打开修改操作的模态窗口
                            $("#editActivityModal").modal("show");


                        }

                    })

                }

            })



            //为修改按钮绑定事件，执行市场活动的修改操作
            $("#updateActivityBtn").click(function () {

                $.ajax({

                    url : "workbench/activity/updateActivity.do",
                    data : {

                        "id" : $.trim($("#edit-id").val()),
                        "owner" : $.trim($("#edit-owner").val()),
                        "name" : $.trim($("#edit-name").val()),
                        "startDate" : $.trim($("#edit-startDate").val()),
                        "endDate" : $.trim($("#edit-endDate").val()),
                        "cost" : $.trim($("#edit-cost").val()),
                        "description" : $.trim($("#edit-description").val())

                    },
                    type : "post",
                    dataType : "json",
                    success : function (data) {

                        /*

                            data
                                {"success":true/false}

                         */

                        if(data.success){

                            //修改成功

                            //刷新列表
                            //pageList(1,2);

                            /*

                                $("#activityPage").bs_pagination('getOption', 'currentPage')
                                    执行完以上操作后，维持当前页

                                $("#activityPage").bs_pagination('getOption', 'rowsPerPage')
                                    执行完以上操作后，维持每页展现的记录数

                             */
                            pageList($("#activityPage").bs_pagination('getOption', 'currentPage')
                                ,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));



                            //关闭模态窗口
                            $("#editActivityModal").modal("hide");


                        }else{

                            alert("修改市场活动失败");

                        }

                    }

                })


            })


            //为批量导出按钮绑定事件，执行批量导出操作（将市场活动表中所有的数据生成excel）
            $("#exportActivityAllBtn").click(function () {

                if(confirm("确定导出所有记录吗？")){

                    window.location.href = "workbench/activity/exportActivityAll.do";

                }

            })

            //为选择导出按钮绑定事件，执行选择导出操作（将市场活动表中选中的记录生成excel）
            $("#exportActivityXzBtn").click(function () {

                var $xz = $("input[name=xz]:checked");

                if($xz.length==0){

                    alert("请选择需要导出的记录");

                }else{

                    //肯定选择了，有可能是一条或者多条
                    //window.location.href = "workbench/activity/exportActivityXz.do?id=xxx&id=xxx&id=xxx";

                    var param = "";

                    for(var i=0;i<$xz.length;i++){

                        param += "ids="+$($xz[i]).val();

                        if(i<$xz.length-1){

                            param += "&";

                        }

                    }

                    //以上参数部分处理完毕后，发出请求
                    window.location.href = "workbench/activity/exportActivityXz.do?"+param;

                }


            })


            //为导入按钮绑定事件，执行导入操作（通过excel文件生成表中的记录）
            $("#importActivityBtn").click(function () {

                var activityFileName = $("#activityFile").val();

                //alert(activityFile);

                /*

                    asdfasdfasf.xls

                 */

                var suffix = activityFileName.substr(activityFileName.lastIndexOf(".")+1);

                if(!(suffix=="xls"||suffix=="xlsx")){

                    alert("不是有效的excel文件");

                    return false;

                }

                //取得文件
                /*

                    jquery没有为我们提供取得文件的方法，所以我们还是必须要使用到原生js的dom来取
                    使用files属性


                 */
                var activityFile = $("#activityFile")[0].files[0];

                //判断文件大小
                if(activityFile.size>1024*1024*5){

                    alert("文件大小不超过5MB!");
                    return false;

                }


                //FormData是ajax定义的接口,可以模拟键值对向服务器提交数据
                //FormData类型的作用是可以提交文本数据,还可以提交二进制数据.

                //做文件上传，请求方式必须是post请求

                var formData=new FormData();

                formData.append("myFile",$("#activityFile")[0].files[0]);

                /*

                      contentType:false
                          默认情况下,ajax向服务器发送数据之前,
                          把所有数据统一按照applciation/x-www-form-urlencoded编码格式进行编码;
                          把contentType设置为false,能够阻止这种行为.

                    processData:false
                        主要是配合contentType使用的,
                        默认情况下,ajax把所有数据进行applciation/x-www-form-urlencoded编码之前,
                        会把所有数据统一转化为字符串;把proccessData设置为false,可以阻止这种行为.

                */

                $.ajax({

                    url : "workbench/activity/importActivity.do",
                    data : formData,
                    type : "post",
                    dataType : "json",
                    processData : false,
                    contentType : false,
                    success : function (data) {

                        /*

                            data
                                {"success":true/false}

                         */

                        if(data.success){

                            //上传成功
                            //清空文件上传的信息
                            $("#activityFile").val("");

                            //刷新列表
                            pageList(1,2);

                            //关闭导入模态窗口
                            $("#importActivityModal").modal("hide");


                        }else{

                            alert("文件上传失败");

                        }

                    }

                })


            })


        });

        /*

            pageList方法：查询并局部刷新市场活动列表的操作

                该方法都有哪些入口呢？（都在什么情况下需要调用该方法）

                1.点击工作台左侧菜单"市场活动",在页面加载完毕后，需要调用pageList方法，查询并局部刷新市场活动列表
                2.点击查询按钮，需要调用pageList方法，查询并局部刷新市场活动列表
                3.点击分页组件的时候，需要调用pageList方法，查询并局部刷新市场活动列表
                4.添加操作后，需要调用pageList方法，查询并局部刷新市场活动列表
                5.修改操作后，需要调用pageList方法，查询并局部刷新市场活动列表
                6.删除操作后，需要调用pageList方法，查询并局部刷新市场活动列表

            pageList方法的参数：
                1.pageNo:当前页的页码
                2.pageSize:每页展现的记录数
                这两个参数是前端操作分页插件的基础参数（所有关系型数据库都会使用到这两个参数作为基础参数）
                其他前端需要展现的数据，都可以通过这两个参数计算出来

            关于ajax的data参数问题：
                需要分页查询相关的参数
                pageNo
                pageSize
                需要条件查询相关的参数
                name
                owner
                startDate
                endDate

            共计6个参数

            问题：
                关于ajax的data的参数
                pageNo
                pageSize
                这两个参数是必须传的，没有疑问，因为我们肯定要实行分页查询操作

                但是条件查询的4个参数
                name
                owner
                startDate
                endDate
                一定是有必要的吗？
                这4个条件查询的参数，最终应该交给dao层去处理
                怎么处理？动态sql：
                <where>
                    <if></if>
                </where>
                使用动态sql的目的是，有哪个查询条件，我们就查哪个，没有的不查

         */
        function pageList(pageNo,pageSize) {

            //alert("查询并局部刷新市场活动列表");

            //将全选的复选框的√灭掉
            $("#qx").prop("checked",false);

            //将隐藏域中的信息取出，重新赋值给搜索框
            $("#search-name").val($.trim($("#hidden-name").val()));
            $("#search-owner").val($.trim($("#hidden-owner").val()));
            $("#search-startDate").val($.trim($("#hidden-startDate").val()));
            $("#search-endDate").val($.trim($("#hidden-endDate").val()));

            $.ajax({

                url : "workbench/activity/pageList2.do",
                data : {

                    "pageNoStr" : pageNo,
                    "pageSizeStr" : pageSize,
                    "name" : $.trim($("#search-name").val()),
                    "owner" : $.trim($("#search-owner").val()),
                    "startDate" : $.trim($("#search-startDate").val()),
                    "endDate" : $.trim($("#search-endDate").val())

                },
                type : "get",
                dataType : "json",
                success : function (data) {

                    /*

                        data

                            List<Activity> dataList...
                            [{市场活动1},{2},{3}]

                            一会我们不仅仅只是要从后台取得dataList，还要取得查询的总条数
                            List<Activity> dataList...
                            int total...
                            {"total":100,"dataList":[{市场活动1},{2},{3}]}

                     */

                    var html = "";

                    //var html1 = "'\"\"'";
                    //var html2 = '"\'\'"';


                    $.each(data.dataList,function (i,n) {

                        html += '<tr class="active">';
                        html += '<td><input type="checkbox" name="xz" value="'+n.id+'"/></td>';
                        html += '<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href=\'workbench/activity/toActivityDetail.do?id='+n.id+'\';">'+n.name+'</a></td>';
                        html += '<td>'+n.owner+'</td>';
                        html += '<td>'+n.startDate+'</td>';
                        html += '<td>'+n.endDate+'</td>';
                        html += '</tr>';

                    })

                    $("#activityBody").html(html);

                    //以上列表信息展现完毕后，使用bs_pagination来操作分页相关的信息

                    //计算总页数
                    var totalPages = data.total%pageSize==0?data.total/pageSize:parseInt(data.total/pageSize)+1;

                    $("#activityPage").bs_pagination({
                        currentPage: pageNo, // 页码
                        rowsPerPage: pageSize, // 每页显示的记录条数
                        maxRowsPerPage: 20, // 每页最多显示的记录条数
                        totalPages: totalPages, // 总页数
                        totalRows: data.total, // 总记录条数

                        visiblePageLinks: 3, // 显示几个卡片

                        showGoToPage: true,
                        showRowsPerPage: true,
                        showRowsInfo: true,
                        showRowsDefaultInfo: true,

                        //该函数的触发时机：在我们点击分页组件的时候（上一页，下一页，首页，尾页，12345...页）
                        onChangePage : function(event, data){
                            /*

                                data.currentPage：点击分页组件后的当前页码
                                data.rowsPerPage：点击分页组件后每页展现的记录数

                                以上这两个值，是分页插件为我们提供的，我们千万不要去改动

                             */
                            pageList(data.currentPage , data.rowsPerPage);
                        }
                    });




                }

            })


        }


    </script>
</head>
<body>

<input type="hidden" id="hidden-name"/>
<input type="hidden" id="hidden-owner"/>
<input type="hidden" id="hidden-startDate"/>
<input type="hidden" id="hidden-endDate"/>

<!-- 导入市场活动的模态窗口 -->
<div class="modal fade" id="importActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">导入市场活动</h4>
            </div>
            <div class="modal-body" style="height: 350px;">
                <div style="position: relative;top: 20px; left: 50px;">
                    请选择要上传的文件：<small style="color: gray;">[仅支持.xls或.xlsx格式]</small>
                </div>
                <div style="position: relative;top: 40px; left: 50px;">
                    <input type="file" id="activityFile">
                </div>
                <div style="position: relative; width: 400px; height: 320px; left: 45% ; top: -40px;" >
                    <h3>重要提示</h3>
                    <ul>
                        <li>操作仅针对Excel，仅支持后缀名为XLS/XLSX的文件。</li>
                        <li>给定文件的第一行将视为字段名。</li>
                        <li>请确认您的文件大小不超过5MB。</li>
                        <li>日期值以文本形式保存，必须符合yyyy-MM-dd格式。</li>
                        <li>日期时间以文本形式保存，必须符合yyyy-MM-dd HH:mm:ss的格式。</li>
                        <li>默认情况下，字符编码是UTF-8 (统一码)，请确保您导入的文件使用的是正确的字符编码方式。</li>
                        <li>建议您在导入真实数据之前用测试文件测试文件导入功能。</li>
                    </ul>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="importActivityBtn" type="button" class="btn btn-primary">导入</button>
            </div>
        </div>
    </div>
</div>

<!-- 创建市场活动的模态窗口 -->
<div class="modal fade" id="createActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel1">创建市场活动123</h4>
            </div>
            <div class="modal-body">

                <form id="activitySaveForm" class="form-horizontal" role="form">

                    <div class="form-group">
                        <label for="create-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="create-owner">



                            </select>
                        </div>
                        <label for="create-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-name">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-startTime" class="col-sm-2 control-label">开始日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control time" id="create-startDate">
                        </div>
                        <label for="create-endTime" class="col-sm-2 control-label">结束日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control time" id="create-endDate">
                        </div>
                    </div>
                    <div class="form-group">

                        <label for="create-cost" class="col-sm-2 control-label">成本</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-cost">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="create-describe" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" id="create-description"></textarea>
                        </div>
                    </div>

                </form>

            </div>
            <div class="modal-footer">
                <!--

                    data-dismiss="modal"
                        关闭模态窗口

                -->
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="saveActivityBtn">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 修改市场活动的模态窗口 -->
<div class="modal fade" id="editActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel2">修改市场活动</h4>
            </div>
            <div class="modal-body">

                <form class="form-horizontal" role="form">

                    <input type="hidden" id="edit-id"/>

                    <div class="form-group">
                        <label for="edit-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="edit-owner">



                            </select>
                        </div>
                        <label for="edit-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-name">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-startTime" class="col-sm-2 control-label">开始日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control time" id="edit-startDate">
                        </div>
                        <label for="edit-endTime" class="col-sm-2 control-label">结束日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control time" id="edit-endDate">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-cost" class="col-sm-2 control-label">成本</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-cost">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-describe" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <!--

                                textarea:文本域
                                    文本域是表单元素，但是他操作值的方式与其他元素有些差别
                                    其他的表单元素都有其value值，但是文本域没有value值
                                    是以textarea标签对中的信息去操作表单元素的值

                                    虽然textarea操作的是标签对中的内容，但是他也是属于表单元素范畴
                                    所以我们必须以val()方法的方式去操作文本域的值，而不是html()方法


                            -->
                            <textarea class="form-control" rows="3" id="edit-description"></textarea>
                        </div>
                    </div>

                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="updateActivityBtn">更新</button>
            </div>
        </div>
    </div>
</div>




<div>
    <div style="position: relative; left: 10px; top: -10px;">
        <div class="page-header">
            <h3>市场活动列表</h3>
        </div>
    </div>
</div>
<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
    <div style="width: 100%; position: absolute;top: 5px; left: 10px;">

        <div class="btn-toolbar" role="toolbar" style="height: 80px;">
            <form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">名称</div>
                        <input class="form-control" type="text" id="search-name">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">所有者</div>
                        <input class="form-control" type="text" id="search-owner">
                    </div>
                </div>


                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">开始日期</div>
                        <input class="form-control" type="text" id="search-startDate" />
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">结束日期</div>
                        <input class="form-control" type="text" id="search-endDate">
                    </div>
                </div>

                <button type="button" class="btn btn-default" id="searchActivityListBtn">查询</button>

            </form>
        </div>
        <div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
            <div class="btn-group" style="position: relative; top: 18%;">

                <!--

                    data-toggle="modal"和data-target="#id"
                    这两对属性和属性值我们以前在学习html和css的时候，没有接触过
                    也就是说，这两组属性和属性值并不是html为我们提供好的组件
                    是由boostrap的UI框架为我们提供的

                    这两组属性和属性值是用来操作页面中的模态窗口所使用的


                    data-toggle="modal"
                        点击button按钮，将会触发一个模态窗口，此处的modal表示的就是模态窗口

                    data-target="#id"
                        表示指定触发模态窗口的目标，目标是以#+id的形式来指定
                        例如我们以下案例写的是data-target="#createActivityModal"
                        createActivityModal就是我们要开启的模态窗口的目标
                        一般来将，目标都是一个div

                    需求：
                        在点击"创建"按钮后，打开模态窗口前，在此期间，我要弹出一个alert(123)

                        能做在button元素中直接植入onclick="alert(123)"

                        问题1：以上操作能够正常进行，是因为我们经过了测试，看到了效果，
                                但是在此之前，我们并不确定是先弹alert123，还是先展现模态窗口
                                对于触发的时机我们并不确定，对于该行代码的可读性并不强、

                        问题2：我们现在的测试是弹出了一个alert123，但是将来有可能会遇到非常复杂的业务，
                                来取代现在的alert123，那么我们直接在onclick里面写代码就不现实了

                        通过以上两个问题，我们发现了我们处理按钮的时机，和打开模态窗口的时机，并不是由我们自己决定的
                        而是由在button元素中写死的属性和属性值决定的

                        所以我们以后都不是这样来操作模态窗口，对于button按钮的行为，我们一般都是绑定事件，由js方法去处理

                -->

                <button type="button" id="toSaveActivityBtn" class="btn btn-primary"><span class="glyphicon glyphicon-plus"></span> 创建</button>
                <button type="button" class="btn btn-default" id="toUpdateActivityBtn"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
                <button type="button" class="btn btn-danger" id="deleteActivityBtn"><span class="glyphicon glyphicon-minus"></span> 删除</button>
            </div>
            <div class="btn-group" style="position: relative; top: 18%;">
                <button type="button" class="btn btn-default" data-toggle="modal" data-target="#importActivityModal" ><span class="glyphicon glyphicon-import"></span> 上传列表数据（导入）</button>
                <button id="exportActivityAllBtn" type="button" class="btn btn-default"><span class="glyphicon glyphicon-export"></span> 下载列表数据（批量导出）</button>
                <button id="exportActivityXzBtn" type="button" class="btn btn-default"><span class="glyphicon glyphicon-export"></span> 下载列表数据（选择导出）</button>
            </div>
        </div>
        <div style="position: relative;top: 10px;">
            <table class="table table-hover">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td><input type="checkbox" id="qx"/></td>
                    <td>名称</td>
                    <td>所有者</td>
                    <td>开始日期</td>
                    <td>结束日期</td>
                </tr>
                </thead>
                <tbody id="activityBody">
                <%--<tr class="active">
                    <td><input type="checkbox" /></td>
                    <td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='detail.jsp';">发传单</a></td>
                    <td>zhangsan</td>
                    <td>2020-10-10</td>
                    <td>2020-10-20</td>
                </tr>--%>
                <%--<tr class="active">
                    <td><input type="checkbox" /></td>
                    <td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='detail.jsp';">发传单</a></td>
                    <td>zhangsan</td>
                    <td>2020-10-10</td>
                    <td>2020-10-20</td>
                </tr>--%>
                </tbody>
            </table>
        </div>

        <div style="height: 50px; position: relative;top: 30px;">

            <div id="activityPage"></div>

        </div>

    </div>

</div>
</body>
</html>