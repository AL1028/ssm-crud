<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: HUA
  Date: 2021/12/18
  Time: 15:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%pageContext.setAttribute("ctp",request.getContextPath());%>
<html>
<%--web路径
不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3306 )：需要加上项目名
        http://localhost:3306/ssm_crud

--%>
<script type="text/javascript" src="${ctp}/static/js/jquery-1.12.4.min.js"></script>
<link rel="stylesheet" href="${ctp}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
<script src="${ctp}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<head>
    <title>员工列表</title>
</head>
<body>
<%--搭建显示页面 --%>
<div class="container">
    <%--标题--%>
    <div class="row">
        <div href="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary">新增</button>
            <button class="btn btn-danger">删除</button>
        </div>
    </div>
    <%--表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover">
                <tr>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                <c:forEach items="${pageInfo.list}" var="emp">
                    <tr>
                        <td>${emp.empId}</td>
                        <td>${emp.empName}</td>
                        <td>${emp.gender=="M"?"男":"女"}</td>
                        <td>${emp.email}</td>
                        <td>${emp.department.deptName}</td>
                        <td>
                            <button class="btn btn-primary btn-sm">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                编辑
                            </button>
                            <button class="btn btn-danger btn-sm">
                                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                删除
                            </button>
                        </td>
                    </tr>
                </c:forEach>

            </table>
        </div>
    </div>
    <%--分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6">
            当前第${pageInfo.pageNum}页,共${pageInfo.pages}页,共${pageInfo.total}记录
        </div>
        <%--分页信息--%>
        <div class="col-md-6">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li><a href="${ctp}/emps?pn=1">首页</a></li>
                    <c:if test="${pageInfo.hasPreviousPage}">
                        <li>
                            <a href="${ctp}/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>

                    <c:forEach items="${pageInfo.navigatepageNums}" var="pageNum">
                        <c:if test="${pageNum == pageInfo.pageNum}">
                            <li class="active"><a href="#">${pageNum}</a></li>
                        </c:if>
                        <c:if test="${pageNum != pageInfo.pageNum}">
                            <li><a href="${ctp}/emps?pn=${pageNum}">${pageNum}</a></li>
                        </c:if>
                    </c:forEach>

                    <c:if test="${pageInfo.hasNextPage}">
                        <li>
                            <a href="${ctp}/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                    
                    <li><a href="${ctp}/emps?pn=${pageInfo.pages}">末页</a></li>
                </ul>
            </nav>
        </div>
    </div>
</div>
</body>
</html>
