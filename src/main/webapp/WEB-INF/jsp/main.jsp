<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
    <script src="https://webapi.amap.com/maps?v=1.4.14&key=ac0954489531af464cb5d86b6d522a7d&&plugin=AMap.Scale,AMap.Geocoder,AMap.Autocomplete,AMap.ArrivalRange,AMap.Transfer,AMap.MarkerClusterer"></script>
    <script src="http://cache.amap.com/lbs/static/jquery.range.js"></script>

    <style>
        html, body, #container {
            height: 100%;
            width: 100%;
        }
        .btn{
            margin-left: 0.5rem;
            width:4rem;
        }
        #transfer_panel {
            position: fixed;
            background-color: white;
            max-height: 90%;
            overflow-y: auto;
            top: 10px;
            left: 10px;
            width: 280px;
            background-color: #009cf9;
            border-top-left-radius: 4px;
            border-top-right-radius: 4px;
            border-bottom-left-radius: 4px;
            border-bottom-right-radius: 4px;
            overflow: hidden;
        }
    </style>
</head>
<%-------------------------Body-------------------------%>
<body>

<div id="container"></div>

<div class="input-card" style='width:25rem;'>
    <h4 style='color:grey'>当前全国共有 <span id="country-houses-count"></span> 套租赁房源</h4>
    <h4 style='color:grey'>当前 <span id="city-houses"></span> 共有 <span id="city-houses-count"></span> 套租赁房源</h4>
    <div class="input-item">
        <div class="input-item-prepend">
        <label class="input-item-text">城市</label>
        </div>
        <select id="city" onchange="setCity()" >
            <option selected value ="北京市">北京市</option>
            <option value ="上海市">上海市</option>
            <option value ="广州市">广州市</option>
            <option value ="深圳市">深圳市</option>
            <option value ="杭州市">杭州市</option>
            <option value ="成都市">成都市</option>
            <option value ="南京市">南京市</option>
            <option value ="武汉市">武汉市</option>
            <option value ="长沙市">长沙市</option>
            <option value ="天津市">天津市</option>
            <option value ="厦门市">厦门市</option>
            <option value ="西安市">西安市</option>
            <option value ="重庆市">重庆市</option>
            <option value ="青岛市">青岛市</option>
            <option value ="合肥市">合肥市</option>
        </select>
    </div>
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
    </div>
    <div>
        <input type="button" class="btn" style="width:9rem;" onclick="delWorkRange()" value="清除到达圈" />
        <input type="button" class="btn" style="width:9rem;" onclick="delTransferPlan()" value="清除路程规划" />
    </div>
</div>

<div id="transfer_panel"></div>

<%-------------------------Script-------------------------%>
<script>

    // 全局变量们
    var map;                                        // 地图
    var city = "${city}";                           // 城市
    var workAddress, workMarker;                    // 工作地点
    var x, y, t, v, arrivalRange, polygonArray=[];  // 到达圈
    arrivalRange = new AMap.ArrivalRange();
    var cluster, rentMarkerArray = [];              // 租房房源
    var mapTransfer;                                // 交通路程规划

    var cityToLngLat = {
        "北京市": [116.397428,39.909230],
        "上海市": [121.473658,31.230378],
        "广州市": [113.264385,23.129112],
        "深圳市": [114.085947,22.547000],
        "成都市": [104.066143,30.573095],
        "杭州市": [120.155150,30.274150],
        "南京市": [118.796470,32.058380],
        "武汉市": [114.305250,30.592760],
        "长沙市": [112.938860,28.227780],
        "天津市": [117.199370,39.085100],
        "厦门市": [118.089480,24.479510],
        "西安市": [108.939840,34.341270],
        "重庆市": [106.550730,29.564710],
        "青岛市": [120.382990,36.066230],
        "合肥市": [117.229010,31.820570],
    };

    var cityToSimple = {
        "北京市": "bj",
        "上海市": "sh",
        "广州市": "gz",
        "深圳市": "sz",
        "成都市": "cd",
        "杭州市": "hz",
        "南京市": "nj",
        "武汉市": "wh",
        "长沙市": "cs",
        "天津市": "tj",
        "厦门市": "xm",
        "西安市": "xa",
        "重庆市": "cq",
        "青岛市": "qd",
        "合肥市": "hf",
    };


    // 初始化地图
    if (map) map.destroy();
    map = new AMap.Map("container", {
        resizeEnable: true, //是否监控地图容器尺寸变化
        zoomEnable: true,
        zoom: 11, //初始化地图层级
        center: cityToLngLat[city], //初始化地图中心
    });



    // 限制地图显示范围
    lockMapBounds();

    // 加载房源坐标
    loadRentLocation();

    // 加载房源统计信息
    countPoints();

    function setCity() {
        city = $("#city").val();
        window.location.href = '/Rent/main?city=' + cityToSimple[city];
    }
    $(function(){
        $("#city").val(city);
    });


    // 信息窗体
    var infoWindow = new AMap.InfoWindow({offset: new AMap.Pixel(0, -30)});

    // 添加左下角的刻度尺
    var scale = new AMap.Scale();
    map.addControl(scale);


    // 输入提示
    // 给输入提示控件注册监听，选中地址后加载点标记和到达圈
    var autoComplete = new AMap.Autocomplete({
        input: "work_address"
    });
    AMap.event.addListener(autoComplete, "select", function (e) {
        workAddress = e.poi.name;
        delTransferPlan();
        loadWorkLocation();
    });

    // 加载房源标记
    function loadRentLocation() {

        delRentLocation();

        <c:forEach items="${houses}" var="item" >

            var rentMark = new AMap.Marker({
                position: ${item.lnglat},
                title: "${item.title}",
                icon: 'http://webapi.amap.com/theme/v1.3/markers/n/mark_b.png',
            });

            rentMark.on('click', function (e) {
                // 划分坐标x和y，String转List
                var strLnglat = "${item.lnglat}";
                strLnglat = strLnglat.substring(2, strLnglat.length - 2);
                var lnglat = strLnglat.split("', '");

                // 信息窗体
                var info = [];
                info.push("<h4 style='color:grey'><b>房源：</b>" + "${item.title}" + "️</h4>");
                info.push("<h4 style='color:grey'><b>小区：</b>" + "${item.location}" + "️</h4>");
                info.push("<h4 style='color:grey'><b>面积：</b>" + "${item.size}" + "️</h4>");
                info.push("<h4 style='color:grey'><b>朝向：</b>" + "${item.orient}" + "️</h4>");
                info.push("<h4 style='color:grey'><b>户型：</b>" + "${item.type}" + "️</h4>");
                info.push("<h4 style='color:grey'><b>价钱：</b>" + "${item.price}" + " 月/元️</h4>");
                info.push("<h4 style='color:grey'><b>发布时间：</b>" + "${item.time}" + "️</h4>");
                info.push("<h4 style='color:grey'><b>点击跳转：</b><a target='_blank' href='" + "${item.url}" + "'>➡️</a>️</h4>");

                infoWindow.setContent(info.join(" "));
                infoWindow.open(map, e.target.getPosition());
                // 路程规划
                if (mapTransfer) mapTransfer.clear();
                mapTransfer = new AMap.Transfer({
                    map: map,
                    city: city,
                    panel: 'transfer_panel',
                    policy: AMap.TransferPolicy.LEAST_TIME //乘车策略
                });
                mapTransfer.search(
                    new AMap.LngLat(x, y),
                    new AMap.LngLat(lnglat[0], lnglat[1])
                    , function(status, result) { });
            });
            rentMarkerArray.push(rentMark);

        </c:forEach>

        // 点聚合
        addCluster();
    }

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
            }
        }, {
            policy: v
        });
    }

    // 加载工作地点位置
    function loadWorkLocation() {
        delWorkLocation();
        var geocoder = new AMap.Geocoder({
            city: city,
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

    // 点聚合
    function addCluster() {
        if (cluster) cluster.setMap(null);
        var sts = [{
            url: "https://a.amap.com/jsapi_demos/static/images/green.png",
            size: new AMap.Size(32, 32),
            offset: new AMap.Pixel(-16, -16)
        }, {
            url: "https://a.amap.com/jsapi_demos/static/images/green.png",
            size: new AMap.Size(32, 32),
            offset: new AMap.Pixel(-16, -16)
        }, {
            url: "https://a.amap.com/jsapi_demos/static/images/orange.png",
            size: new AMap.Size(36, 36),
            offset: new AMap.Pixel(-18, -18)
        }, {
            url: "https://a.amap.com/jsapi_demos/static/images/red.png",
            size: new AMap.Size(48, 48),
            offset: new AMap.Pixel(-24, -24)
        }, {
            url: "https://a.amap.com/jsapi_demos/static/images/darkRed.png",
            size: new AMap.Size(48, 48),
            offset: new AMap.Pixel(-24, -24)
        }];
        cluster = new AMap.MarkerClusterer(map, rentMarkerArray, {
            styles: sts,
            gridSize: 80,
            minClusterSize: 8
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

    // 删除路程规划
    function delTransferPlan() {
        if (mapTransfer) mapTransfer.clear();
    }

    //限制地图显示范围
    function lockMapBounds() {
        var bounds = map.getBounds();
        map.setLimitBounds(bounds);
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

    // 统计房源总数
    function countPoints() {

        document.getElementById("country-houses-count").innerHTML = 521212;

        document.getElementById("city-houses-count").innerHTML = ${houses.size()};

        document.getElementById("city-houses").innerHTML = city;
    }
</script>
</body>
</html>