<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>title</title>
    <script src="jquery/jquery-1.11.1-min.js"></script>
    <script src="ECharts/echarts.min.js"></script>
    <script>

        $(function () {

            getTranChart();

        })

        function getTranChart() {

            $.ajax({

                url : "workbench/chart/transaction/getChartData.do",
                type : "get",
                dataType : "json",
                success : function (data) {

                    /*

                        data
                            int max
                            List<Map<String,Object>> dataList
                            List<String> stageNameList
                            {

                                "max":100,

                                "dataList":[{value:100,name:"01资质审查"},{value:10,name:"02需求分析"}...],

                                "stageNameList" : ["01资质审查","02需求分析"....]

                            }


                    */

                    //alert("绘制统计图表");
                    // 基于准备好的dom，初始化echarts实例
                    //myChart:绘图者
                    var myChart = echarts.init(document.getElementById('main'));

                    // 指定图表的配置项和数据
                    //option:我们要画的图
                    var option = {
                        title: {
                            text: '交易漏斗图',
                            subtext: '统计交易阶段数量的漏斗图'
                        },
                        legend: {
                            data: data.stageNameList
                        },
                        calculable: true,
                        series: [
                            {
                                name:'交易漏斗图',
                                type:'funnel',
                                left: '10%',
                                top: 60,
                                //x2: 80,
                                bottom: 60,
                                width: '80%',
                                // height: {totalHeight} - y - y2,
                                min: 0,
                                max: data.max, //最大值
                                minSize: '0%',
                                maxSize: '100%',
                                sort: 'descending',
                                gap: 2,
                                label: {
                                    show: true,
                                    position: 'inside'
                                },
                                labelLine: {
                                    length: 10,
                                    lineStyle: {
                                        width: 1,
                                        type: 'solid'
                                    }
                                },
                                itemStyle: {
                                    borderColor: '#fff',
                                    borderWidth: 1
                                },
                                emphasis: {
                                    label: {
                                        fontSize: 20
                                    }
                                },
                                //统计项，统计数量
                                /*

                                    value：统计的数量
                                    name：统计项

                                    我们想要的数据
                                    [{value:100,name:"01资质审查"},{value:10,name:"02需求分析"}...]

                                 */
                                data: data.dataList
                                /*[
                                {value: 60, name: '访问'},
                                {value: 40, name: '咨询'},
                                {value: 20, name: '订单'},
                                {value: 80, name: '点击'},
                                {value: 100, name: '展现'}
                            ]*/
                            }
                        ]
                    };

                    // 使用刚指定的配置项和数据显示图表。
                    //绘图者，调用一个画图的方法来绘制统计图表，参数就是我们要画的图
                    myChart.setOption(option);


                }

            })




        }

    </script>
</head>
<body>

<!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
<div id="main" style="width: 950px;height:400px;"></div>

</body>
</html>
