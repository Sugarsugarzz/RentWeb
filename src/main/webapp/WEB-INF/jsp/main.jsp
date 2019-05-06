<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>

<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">
    <title>租房地图</title>
    <link rel="stylesheet" href="https://a.amap.com/jsapi_demos/static/demo-center/css/demo-center.css" />
    <link rel="stylesheet" href="http://cache.amap.com/lbs/static/jquery.range.css" />
    <script src="http://cache.amap.com/lbs/static/jquery-1.9.1.js"></script>
    <script src="https://cache.amap.com/lbs/static/es5.min.js"></script>
    <script src="https://webapi.amap.com/maps?v=1.4.14&key=ac0954489531af464cb5d86b6d522a7d&&plugin=AMap.Scale,AMap.Geocoder,AMap.Autocomplete,AMap.ArrivalRange"></script>
    <script src="http://cache.amap.com/lbs/static/jquery.range.js"></script>
    <script src="https://cache.amap.com/lbs/static/addToolbar.js"></script>

    <style>
        html, body, #container {
            height: 100%;
        }
        .btn{
            margin-left: 0.5rem;
            width:4rem;
        }
    </style>
</head>
<%-------------------------Body-------------------------%>
<body>

<div id="container"></div>

<div class="input-card" style='width:25rem;'>
    <h4 style='color:grey'>公交到达圈查询</h4>
    <div class="input-item">
        <div class="input-item-prepend"><span class="input-item-text" >工作地点</span></div>
        <input id='work_address' type="text">
    </div>
    <div class="input-item" style='margin-bottom:2rem;'>
        <label>时长(分钟)</label>
        <input type="hidden" id="t" class="single-slider" value="30" />
    </div>

    <div class="input-item">
        <div class="input-item-prepend">
            <label class="input-item-text">出行方式</label>
        </div>
        <select id="v" onchange="loadWorkRange()" >
            <option selected value ="SUBWAY,BUS">地铁+公交</option>
            <option value ="SUBWAY">地铁</option>
            <option value ="BUS">公交</option>
        </select>
        <input id="search" type="button" class="btn" onclick="loadWorkRange()" value="查询" />
        <input id="clear" type="button" class="btn"  onclick="delWorkRange()" value="清除" />
    </div>
    <div>
        <input type="button" class="btn" onclick="loadRentLocation()" value="导入" />
        <input type="button" class="btn" onclick="delRentLocation()" value="清除" />
    </div>
</div>

<div id="transfer_panel"></div>

<%-------------------------Script-------------------------%>

<script>
    // 初始化地图
    var map = new AMap.Map("container", {
        resizeEnable: true, //是否监控地图容器尺寸变化
        zoomEnable: true,
        zoom: 11, //初始化地图层级
        center: [116.397428, 39.90923], //初始化地图中心点 （北京）
    });

    // 添加左下角的刻度尺
    var scale = new AMap.Scale();
    map.addControl(scale);

    // 全局变量们
    var workAddress, workMarker;                    // 工作地点
    var x, y, t, v, arrivalRange, polygonArray=[];  // 到达圈
    arrivalRange = new AMap.ArrivalRange();

    var rentMarkerArray = [];                       // 租房房源

    // 输入提示
    // 给输入提示控件注册监听，选中地址后加载点标记和到达圈
    var autoComplete = new AMap.Autocomplete({
        input: "work_address"
    });
    AMap.event.addListener(autoComplete, "select", function (e) {
        workAddress = e.poi.name;
        loadWorkLocation();
    });

    // 信息窗体
    var infoWindow = new AMap.InfoWindow({offset: new AMap.Pixel(0, -30)});



    // 添加工作地点标记
    function addWorkMarker() {
        workMarker = new AMap.Marker({
            map: map,
            title: workAddress,
            icon: 'http://webapi.amap.com/theme/v1.3/markers/n/mark_r.png',
            position: [x, y]
        });

    }

    // 加载工作地点通勤到达圈
    function loadWorkRange() {
        t = $("#t").val();
        v = $("#v").val();

        arrivalRange.search([x, y], t, function (status, result) {
            map.remove(polygonArray);
            polygonArray = [];
            if (result.bounds) {
                for (var i = 0; i < result.bounds.length; i++) {
                    // 新建多边形对象
                    var polygon = new AMap.Polygon({
                        map: map,
                        fillColor: "#3366FF",
                        fillOpacity: "0.4",
                        strokeColor: "#00FF00",
                        strokeOpacity: "0.5",
                        strokeWeight: 1
                    });
                    polygon.setPath(result.bounds[i]);
                    polygonArray.push(polygon);
                }
                map.add(polygonArray);
                map.setFitView();
            }
        }, {
            policy: v
        });
    }

    // 加载工作地点位置
    function loadWorkLocation() {
        delWorkLocation();
        var geocoder = new AMap.Geocoder({
            city: "北京",
            radius: 1000
        });

        geocoder.getLocation(workAddress, function (status, result) {
            if (status === "complete" && result.info === "OK") {
                var geocode = result.geocodes[0];
                x = geocode.location.getLng();
                y = geocode.location.getLat();
                addWorkMarker();
                loadWorkRange();
                map.setZoomAndCenter(12, [x, y]);
            }

        });
    }

    // 添加房源标记
    function addMarkerByAddress(address) {
        var geocoder = new AMap.Geocoder({
            city: "北京",
            radius: 1000
        });

        geocoder.getLocation(address, function (status, result) {
            if (status === "complete" && result.info === 'OK') {
                var geocode = result.geocodes[0];
                rentMarker = new AMap.Marker({
                    map: map,
                    title: address,
                    icon: 'http://webapi.amap.com/theme/v1.3/markers/n/mark_b.png',
                    position: [geocode.location.getLng(), geocode.location.getLat()]
                });
                rentMarkerArray.push(rentMarker);

                rentMarker.content = "我是Marker";
                rentMarker.on('click', function (e) {
                    infoWindow.setContent(e.target.content);
                    infoWindow.open(map, e.target.getPosition());
                });



            }
        })
    }

    // 加载房源位置
    function loadRentLocation() {
        delRentLocation(); //必要时删除
        var rent_locations = new Set();

        $.get("/Rent/static/csv/rent.csv", function (data) {
            data = data.split("\n");
            data.forEach(function (item, index) {
                rent_locations.add(item.split(",")[1]);
            });
            rent_locations.forEach(function (element, index) {
                addMarkerByAddress(element);
            });
        });
    }

    // 删除工作地点标记
    function delWorkLocation() {
        if (workMarker) map.remove(workMarker);
        if (polygonArray) map.remove(polygonArray);
        polygonArray = [];
    }

    // 删除所有房源标记
    function delRentLocation() {
        if (rentMarkerArray) map.remove(rentMarkerArray);
        rentMarkerArray = [];
    }

    // 删除通勤到达圈
    function delWorkRange() {
        map.remove(polygonArray);
        polygonArray = [];
    }

    // 到达时间调控条
    $(function(){
        $('.single-slider').jRange({
            onstatechange: loadWorkRange,
            from: 1,
            to: 60,
            step: 1,
            scale: [1,15,30,45,60],
            format: '%s',
            width: 400,
            showLabels: true,
            showScale: true
        });
    });
</script>
</body>
</html>