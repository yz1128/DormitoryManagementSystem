<%--
  Created by IntelliJ IDEA.
  User: Yanz
  Date: 2024/6/19
  Time: 下午6:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <script src="https://cdn.jsdelivr.net/npm/echarts/dist/echarts.min.js"></script>
</head>
<body>
<h1 style="margin: auto; text-align: center">宿舍居住情况 <a style="background-color: green">__</a>为空闲，<a style="background-color: yellow">__</a>为有人，<a style="background-color: red">__</a>为维修中</h1>
<div id="main" style="margin: auto;height:600px;"></div>
<script type="text/javascript">
    fetch('http://localhost/DormitoryManagementSystem/dormitoryData')
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            var chartData = data.map(d => ({
                dormID: d.dormID,
                buildingNumber: d.buildingNumber,
                floor: d.floor,
                rooms: d.rooms,
                status: d.status
            }));

            var groupedData = {};  // 用于分组存储数据
            chartData.forEach(item => {
                if (!groupedData[item.buildingNumber]) {
                    groupedData[item.buildingNumber] = {};
                }
                if (!groupedData[item.buildingNumber][item.floor]) {
                    groupedData[item.buildingNumber][item.floor] = [];
                }
                groupedData[item.buildingNumber][item.floor].push(item);
            });

            var seriesData = [];
            Object.keys(groupedData).forEach(building => {
                Object.keys(groupedData[building]).forEach(floor => {
                    seriesData.push({
                        name: building + '号楼' + floor + '层',
                        type: 'bar',
                        stack: 'status',
                        data: groupedData[building][floor].map(room => ({
                            name: room.dormID,
                            value: 1 ,
                            itemStyle: {color: room.status === 'Vacant' ? 'green' : room.status === 'Occupied' ? 'yellow' : 'red'}
                        }))
                    });
                });
            });

            // 生成1到28的宿舍号作为 yAxis 数据
            var yAxisData = Array.from({length: 28}, (v, k) => (k + 1) + '宿舍');
            var myChart = echarts.init(document.getElementById('main'));
            var option = {
                tooltip: {},
                legend: {
                    data: seriesData.map(series => series.name)  // 动态生成图例数据
                },
                xAxis: {
                    type: 'value'
                },
                yAxis: {
                    type: 'category',
                    data: yAxisData
                },
                series: seriesData
            };

            myChart.setOption(option);
            myChart.on('click', function(params) {
                // 控制台打印数据的名称
                console.log(params.name);
            });
        })
        .catch(error => {
            console.error('There was a problem with the fetch operation:', error);
        });
</script>
</body>
</html>
