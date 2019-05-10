<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: sugar
  Date: 2019-05-10
  Time: 00:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script type="text/JavaScript" src="js/jquery.js"></script>
</head>
<body>
    <div>整个list集合：${houses}</div>
    <div>list集合大小：${houses.size()}</div>
    <div>第一行全部数据：${houses[0]}</div>
    <div>第一行的某一个数据：${houses[0].title}</div>

    <div>第一行的某一个数据：<span id="test"></span> </div>

<script>
    document.getElementById("test").innerHTML = "${houses[0].lnglat}"

    var array = new Array();
    //console.info("info");
    <c:forEach items="${houses}" var="item" varStatus="status" >
    array.push("${item}");  //对象，加引号
    <%--var temp = "${item}";--%>
    <%--alert("${status.count}");  //获得其下标--%>
    <%--alert("${item.title}");   //传递过来的是字符串，加引号--%>
    <%--alert(${item.type});  //传递过来的是int或float类型，不需要加引号--%>
    </c:forEach>

    <%--for (var i = 0; i < ${houses.size()}; i++)--%>
        <%--alert("${houses[i].title}")--%>

    <c:forEach items="${houses}" var="item" >
        alert("${item.title}")
    </c:forEach>

</script>
</body>
</html>
