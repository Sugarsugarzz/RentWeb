<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>

<!DOCTYPE html>
<html lang="zxx">

<head>
    <title>House Hunter</title>
    <meta charset="utf-8"/>
    <script>

        /*
        登录操作
        */
        function login() {
            $.ajax({
                type: 'POST',

                contentType: 'application/json; charset-utf-8',

                url: '/Rent/checkLogin',

                dataType: 'json',

                data: '{"username":"' + document.getElementById("username").value
                    + '","password":"' + document.getElementById("password").value + '"}',

                success: function (data) {
                    if (data.flag == "success") {
                        // location.href = "/Rent/main";

                        document.getElementById("SignUp").style.display = "none";
                        document.getElementById("SignIn").style.display = "none";
                        document.getElementById("loginUserText").innerHTML = document.getElementById("username").value;
                        document.getElementById("loginUser").style.display = "block";

                        //display:none方法会影响模态框的下次出现
                        $('#loginModal').modal('hide');


                    } else if (data.flag == "failure") {
                        var errorMessageDiv = document.getElementById("errorMessageDiv");
                        if (!errorMessageDiv.hasChildNodes()) {
                            var newNode = document.createElement("p");
                            newNode.innerHTML = "账号或密码错误！";
                            newNode.style.color = "#FF6347";
                            errorMessageDiv.appendChild(newNode);
                        }
                    }
                },

                error: function () {
                  alert("网络错误！");
                }
            })
        }

        /*
        用户名查重
         */
        function usernameValidate(obj) {
            $.ajax({
                type: 'POST',

                contentType: 'application/json; charset=utf-8',

                url: '/Rent/checkExistence',

                dataType: 'json',

                data: '{"username":"' + obj.value + '"}',

                success: function (data) {
                    var rootDiv = document.getElementById("messageDiv");
                    var newNode;

                    if (!rootDiv.hasChildNodes()) {
                        newNode = document.createElement("p");
                        newNode.id = "messageNode";
                        rootDiv.appendChild(newNode);
                    } else {
                        newNode = document.getElementById("messageNode");
                    }

                    if (data.flag == "true" && obj.value != " ") {
                        document.getElementById("password2").setCustomValidity("Passwords Don't Match")
                        newNode.innerHTML = "该用户名已被注册！";
                        newNode.style.color = "#FF6347";
                    } else if (data.flag == "false") {
                        newNode.innerHTML = "该用户名可以使用！";
                        newNode.style.color = "#87CEFA";
                    } else {
                        newNode.innerHTML == " ";
                    }
                },

                error: function (data) {
                    alert("网络错误！");
                }
            })
        }

        /*
        两次密码是否重复
        */
        function passwordValidate() {
            var rootDiv = document.getElementById("passwordMessageDiv");
            var newNode;
            var pass1 = document.getElementById("password1").value;
            var pass2 = document.getElementById("password2").value;

            if (!rootDiv.hasChildNodes()) {
                newNode = document.createElement("p");
                newNode.id = "passwordMessageNode";
                rootDiv.appendChild(newNode);
            } else {
                newNode = document.getElementById("passwordMessageNode");
            }

            if (pass1 != pass2) {
                newNode.innerHTML = "两次输入的密码不一致！";
                newNode.style.color = "#FF6347";
            } else {
                newNode.innerHTML = " ";
            }

        }
        /*
        注册操作
         */
        function register() {

            if (document.getElementById("messageNode").innerHTML == "该用户名已被注册！") {

            } else {
                $.ajax({
                    type: 'POST',

                    contentType: 'application/json; charset=utf-7',

                    url: '/Rent/doRegister',

                    dataType: 'json',

                    data: '{"username":"' + document.getElementById("username1").value
                        +   '", "password":"' + document.getElementById("password1").value + '"}',

                    success: function (data) {
                        if (data.flag == "success") {
                            document.getElementById("SignUp").style.display = "none";
                            document.getElementById("SignIn").style.display = "none";
                            document.getElementById("loginUserText").innerHTML = document.getElementById("username1").value;
                            document.getElementById("loginUser").style.display = "block";

                            //display:none方法会影响模态框的下次出现
                            $('#registerModal').modal('hide');
                        }  else if (data.flag == "failure") {
                            alert("注册失败，请稍后重试。")
                        }
                    },

                    error: function () {
                        alert("网络错误！")
                    }
                })
            }

        }


    </script>
    <!-- Custom Theme files -->
    <link href="${pageContext.request.contextPath}/static/css/login/bootstrap.css" type="text/css" rel="stylesheet"
          media="all">
    <link href="${pageContext.request.contextPath}/static/css/login/style.css" type="text/css" rel="stylesheet"
          media="all">
    <!-- font-awesome icons -->
    <link href="${pageContext.request.contextPath}/static/css/login/fontawesome-all.min.css" rel="stylesheet">
    <!-- //Custom Theme files -->
    <!-- online-fonts -->
    <link href="//fonts.googleapis.com/css?family=Ubuntu:300,300i,400,400i,500,500i,700,700i" rel="stylesheet">
    <!-- //online-fonts -->
</head>

<body>
<div class="home">
    <!-- banner -->
    <div class="banner" id="banner">
        <!-- header -->
        <header>
            <nav class="navbar navbar-expand-lg navbar-light bg-gradient-secondary">
                <h1>
                    <a class="navbar-brand text-white" href="home.jsp">
                        地图找房
                    </a>
                </h1>

                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav ml-lg-auto text-center">
                        <li class="nav-item active  mr-lg-3">
                            <a class="nav-link" href="home.jsp">主页
                                <span class="sr-only">(current)</span>
                            </a>
                        </li>
                        <li class="nav-item dropdown mr-lg-3 mt-lg-0 mt-3">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
                               data-toggle="dropdown" aria-haspopup="true"
                               aria-expanded="false">
                                北京
                            </a>
                            <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <a class="dropdown-item scroll" href="#process">北京</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item scroll" href="#pricing">上海</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item scroll" href="#partners">深圳</a>
                                <div class="dropdown-divider"></div>
                            </div>
                        </li>
                        <li class="nav-item mr-lg-3 mt-lg-0 mt-3">
                            <a class="nav-link scroll" href="#contact">房源收藏</a>
                        </li>
                        <li class="nav-item mb-lg-0 mb-3">
                            <a class="nav-link scroll" href="#register">说明/公告</a>
                        </li>
                        <li>
                            <button id="SignUp" style="display: block;" type="button" class="btn  ml-lg-2 w3ls-btn" data-toggle="modal" aria-pressed="false"
                                    data-target="#registerModal">
                                注册
                            </button>
                        </li>
                        <li>
                            <button id="SignIn" style="display: block;" type="button" class="btn  ml-lg-2 w3ls-btn" data-toggle="modal" aria-pressed="false"
                                    data-target="#loginModal">
                                登录
                            </button>
                        </li>
                        <li style="display: none;" id="loginUser" class="nav-item dropdown mr-lg-3 mt-lg-0 mt-3">
                            <a class="nav-link dropdown-toggle" id="loginUserText" role="button"
                               data-toggle="dropdown" aria-haspopup="true"
                               aria-expanded="false">

                            </a>
                            <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <a class="dropdown-item scroll" href="#process">设置地址</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item scroll" href="#partners">退出登录</a>
                                <div class="dropdown-divider"></div>
                            </div>
                        </li>

                    </ul>
                </div>

            </nav>
        </header>
        <!-- //header -->
        <div class="container">
            <!-- banner-text -->
            <div class="banner-text text-center">
                <div class="slider-info">
                    <h3>
                        大街找租房心力憔悴？<br>
                        试试换个方式直接在地图上找房！
                    </h3>

                    <p class="text-white">
                        多平台房源爬虫+百度地图强力驱动，助您迅速找到合适房源。
                    </p>

                    <a class="btn btn-theme mt-lg-5 mt-3 agile-link-bnr scroll btn-outline-secondary btn-change5"
                       href="<c:url value="/main"/> " role="button">
                        马上开始
                    </a>
                </div>
            </div>
        </div>
    </div>


    <!-- footer -->
    <footer id="footer" class="text-sm-left text-center">
        <div class="container py-4 py-sm-5">
            <h2>
                <p class="navbar-brand text-white">
                    这是什么？
                </p>
            </h2>
            <div class="row py-sm-5 py-3">
                <div >
                    <p class="d-inline">
                        通过实时爬虫获取公开租房信息，直接在高德地图上直观展示房源位置+基础信息，同时提供住址到公司的路线计算（公交+地图 or 步行导航）。 <br>
                        已实现【豆瓣租房小组】、【豆瓣租房小程序】、【Zuber合租】、【蘑菇租房】、【CCB建融家园】、【58同城品牌公寓】、【Hi住租房】、【房多多】、【贝壳租房】、【v2ex租房帖子】、【上海互助租房】等房源信息数据爬取，部分房源价格支持筛选功能。
                    </p>
                </div>
            </div>
            <h2>
                <p class="navbar-brand text-white">
                    有更好的房源平台推荐？
                    想吐槽一下网站的内容？
                    可以通过以下方式联系我啦！
                </p>
            </h2>
            <div class="row py-sm-5 py-3">
                <div class="col-lg-3 col-md-4 footer-end-grid mt-md-0 mt-sm-5">
                    <div class="fv3-contact">
                        <span class="fas fa-envelope-open mr-2"></span>
                        <p class="d-inline">
                            tzchuan1@gmail.com
                        </p>
                    </div>
                </div>
            </div>
            <hr>
            <div class="d-flex justify-content-between footer-bottom-cpy">
                <div class="cpy-right">
                    <p>© 2018. All rights reserved | Design by Sugar
                    </p>
                </div>
            </div>
        </div>
    </footer>
    <!-- //footer -->
</div>


<!-- login  -->
<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="loginModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="loginModalLabel">登录</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="javascript:login()" method="post">
                    <div class="form-group">
                        <label for="username" class="col-form-label">用户名</label>
                        <input id="username" type="text" class="form-control" placeholder=" " name="Name" required>
                    </div>
                    <div class="form-group">
                        <label for="password" class="col-form-label">密码</label>
                        <input id="password" type="password" class="form-control" placeholder=" " name="Password"
                               required>
                    </div>
                    <%--输入错误提示占位--%>
                    <div id="errorMessageDiv"></div>
                    <div class="right-w3l">
                        <input type="submit" class="form-control" value="登录">
                    </div>
                    <div class="row sub-w3l my-3">
                        <div class="col sub-agile">
                            <input type="checkbox" id="brand1" value="">
                            <label for="brand1" class="text-secondary">
                                <span></span>记住密码?</label>
                        </div>
                        <div class="col forgot-w3l text-right">
                            <a href="#" class="text-secondary">忘记密码?</a>
                        </div>
                    </div>
                    <p class="text-center dont-do">还没有账号?
                        <a href="#register" class="scroll text-dark font-weight-bold">
                            现在注册</a>
                    </p>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- //login -->

<!-- register  -->
<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="registerModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="registerModalLabel">注册账户</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="javascript:register()" method="post">
                    <div class="form-group">
                        <label for="username1" class="col-form-label">用户名</label>
                        <input id="username1" onkeyup="usernameValidate(this)" type="text" class="form-control" placeholder=" " name="Name" required>
                    </div>
                    <%--用户名输入提示占位--%>
                    <div id="messageDiv"></div>
                    <div class="form-group">
                        <label for="password1" class="col-form-label">密码</label>
                        <input id="password1" type="password" class="form-control" placeholder=" " name="Password"
                               required>
                        <label for="password2" class="col-form-label">确认密码</label>
                        <input id="password2" onkeyup="passwordValidate()" type="password" class="form-control" placeholder=" " name="Password"
                               required>
                    </div>
                    <%--密码输入提示占位--%>
                    <div id="passwordMessageDiv"></div>
                    <div class="right-w3l">
                        <input type="submit" class="form-control" value="注册">
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- //register -->


<!-- js -->
<script src="${pageContext.request.contextPath}/static/js/login/jquery-2.2.3.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/login/bootstrap.js"></script>
<!-- //js -->

</body>

</html>