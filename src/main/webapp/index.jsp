<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%pageContext.setAttribute("ctp", request.getContextPath());%>
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
<%pageContext.setAttribute("ctp", request.getContextPath());%>
<body>
<%--员工修改模态框--%>
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="emp_update_static"></p>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked">
                                男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">eamil</label>
                        <div class="col-sm-10">
                            <input type="eamil" class="form-control" name="email" id="email_update_input"
                                   placeholder="eamil@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_update_select">

                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>


<%--员工添加模态框--%>
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="empName" id="empName_add_input"
                                   placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">eamil</label>
                        <div class="col-sm-10">
                            <input type="eamil" class="form-control" name="email" id="email_add_input"
                                   placeholder="eamil@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_add_select">

                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>

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
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <%--表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>


            </table>
        </div>
    </div>
    <%--分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info_area">

        </div>
        <%--分页信息--%>
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
</div>
<script type="text/javascript">

    var totalRecord,currentPage;

    //页面加载完成以后，直接去发送ajax请求，要到分页数据
    $(function () {
        //去首页
        to_page(1);
    });

    function to_page(pn) {
        $("#check_all").prop("checked",false);
        $.ajax({
            url: "${ctp}/emps",
            data: "pn=" + pn,
            type: "GET",
            success: function (result) {
                // console.log(result);
                //解析并显示员工数据
                build_emps_table(result);
                //解析并显示分页信息
                build_page_info(result);
                //解析显示分页条信息
                build_page_nav(result);
            }
        });
    }

    function build_emps_table(result) {

        $("#emps_table tbody").empty();

        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            // alert(item.empName);
            var checkBoxTd = $("<td></td>").append("<input type='checkbox' class='check_item'/>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var empGenderTd = $("<td></td>").append(item.gender == 'M' ? '男' : '女');
            var empEmailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);

            /*
            <button class="btn btn-primary btn-sm">
                  <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                编辑
            </button>
            * */

            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                .append("编辑");

            //为编辑按钮添加一个自定义的属性，来表示当前员工的id
            editBtn.attr("edit_id", item.empId);

            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                .append("删除");
            //为删除按钮添加一个自定义的属性，来表示当前员工的name
            delBtn.attr("del_empName",item.empName);
            delBtn.attr("del_empId",item.empId);

            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);

            //append方法执行完成之后还是返回原来的元素
            $("<tr></tr>").append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(empGenderTd)
                .append(empEmailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        });
    }

    //解析显示分页信息
    function build_page_info(result) {
        $("#page_info_area").empty();
        var pageNum = result.extend.pageInfo.pageNum;
        var pages = result.extend.pageInfo.pages;
        var pageTotal = result.extend.pageInfo.total;

        $("#page_info_area").append("当前第" + pageNum + "页,共" + pages + "页,共" + pageTotal + "记录")

        totalRecord = pageTotal;
        currentPage = pageNum;
    }

    //解析显示分页条
    function build_page_nav(result) {
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");

        //构建元素
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href", "#"));


        if (result.extend.pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
            //为元素添加点击翻页事件
            firstPageLi.click(function () {
                to_page(1);
            });

            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            });

        }

        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;").attr("href", "#"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));

        if (result.extend.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1);
            });

            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
        }

        ul.append(firstPageLi).append(prePageLi);

        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item).attr("href", "#"));
            if (result.extend.pageInfo.pageNum == item) {
                numLi.addClass("active");
            }

            numLi.click(function () {

                to_page(item);
            });

            ul.append(numLi);
        });
        ul.append(nextPageLi).append(lastPageLi);

        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }

    //清空表单样式及内容
    function reset_form(ele) {
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }

    //点击新增按钮弹出模态框
    $("#emp_add_modal_btn").click(function () {
        //清除表单数据及表单样式（重置表单）
        reset_form("#empAddModal form");
        //发送ajax请求查出部门信息，显示在下拉列表中
        getDepts("#dept_add_select");
        $("#empAddModal").modal({
            backdrop: "static"
        });
    });

    function getDepts(ele) {
        $(ele).empty();
        $.ajax({
            url: "${ctp}/depts",
            type: "GET",
            success: function (result) {
                // console.log(result);
                //显示部门信息在下拉列表中
                $.each(result.extend.depts, function () {
                    $("<option></option>").append(this.deptName).attr("value", this.deptId)
                        .appendTo(ele);
                });

            }
        });

    }

    //校验表单数据
    function validate_add_form() {
        //1、拿到要校验的数据，使用正则表达式
        //校验用户名
        var empName = $("#empName_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regName.test(empName)) {
            // alert("用户名可以是2-5位中文或者6-16位英文和数字的组合");
            //清空元素之前样式
            show_validate_msg("#empName_add_input", "error", "用户名可以是2-5位中文或者6-16位英文和数字的组合");
            return false;
        } else {
            show_validate_msg("#empName_add_input", "success", "");
        }

        //校验邮箱
        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;

        if (!regEmail.test(email)) {
            // alert("邮箱格式不正确");
            show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
            // $("#email_add_input").parent().addClass("has_error");
            // $("#email_add_input").next("span").text("邮箱格式不正确");
            return false;
        } else {
            show_validate_msg("#email_add_input", "success", "");
            // $("#email_add_input").parent().addClass("has_success");
            // $("#email_add_input").next("span").text("");

        }
        return true;
    }

    //显示校验结构的提示信息
    function show_validate_msg(ele, status, msg) {
        //清除元素的校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if ("success" == status) {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        } else if ("error" == status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    //校验用户名是否可用
    $("#empName_add_input").change(function () {
        var empName = $(this).val();

        //发送Ajax请求校验用户名是否可用
        $.ajax({
            url: "${ctp}/checkuser",
            data: "empName=" + empName,
            type: "POST",
            success: function (result) {
                if (result.code == 100) {
                    show_validate_msg("#empName_add_input", "success", "用户名可用");
                    $("#emp_save_btn").attr("ajax-va", "success");
                } else {
                    show_validate_msg("#empName_add_input", "error", result.extend.va - msg);
                    $("#emp_save_btn").attr("ajax-va", "error");
                }
            }
        });
    });


    //点击保存员工
    $("#emp_save_btn").click(function () {
        //1、模态框中填写的表单数据提交给服务器进行保存
        //1、先对要提交给服务器的数据进行校验
        /*     if (!validate_add_form()){
                 return false;
             }*/

        //判断之前的Ajax用户名校验是否成功，
        if ($(this).attr("ajax-va") == "error") {
            return false;
        }

        //2、发送Ajax请求保存员工
        $.ajax({
            url: "${ctp}/emp",
            data: $("#empAddModal form").serialize(),
            type: "POST",
            success: function (result) {
                // alert(result.msg);

                if (result.code == 100) {
                    //员工保存成功
                    //1、关闭模态框
                    $("#empAddModal").modal('hide');
                    //2、来到最后一页，显示刚才保存的数据
                    to_page(totalRecord + 1);
                } else {
                    // console.log(result);
                    if (undefined != result.extend.errorField.email) {
                        //显示邮箱错误信息
                        show_validate_msg("#email_add_input", "error", result.extend.errorField.email);
                    }
                    if (undefined != result.extend.errorField.empName) {
                        //显示员工名字错误信息
                        show_validate_msg("#empName_add_input", "error", result.extend.errorField.empName);

                    }
                }
            }
        });
    });

    //1、我们是按钮创建之前就绑定了click，所以绑定不上
    //1）可以在创建按钮的时候绑定 2）绑定点击.live()
    //jquery新版没有live，使用on代替

    $(document).on("click", ".edit_btn", function () {
        // alert("edit");
        //查询部门信息
        getDepts("#dept_update_select");
        //查询员工信息，并显示员工信息
        var edit_id = $(this).attr("edit_id");
        getEmp(edit_id);

        //把员工的id传递给模态框的更新按钮
        $("#emp_update_btn").attr("edit_id", $(this).attr("edit_id"));

        $("#empUpdateModal").modal({
            backdrop: "static"
        });
    });

    //单个删除
    $(document).on("click",".delete_btn",function () {
        //1、弹出是否删除对话框
        var empName = $(this).attr("del_empName");
        // alert($(this).parent("tr").find("td:eq(1)").text());
        //  alert($(this).attr("del_empName"));


        if (confirm("确认删除【"+empName+"】吗？")){
            //确认，发送Ajax请求删除
            $.ajax({
                    url:"${ctp}/emp/"+$(this).attr("del_empId"),
                type:"DELETE",
                success:function (result) {
                    // alert(result.msg);
                    to_page(currentPage);
                }
            });
        }
    });

    function getEmp(id) {
        $.ajax({
            url: "${ctp}/emp/" + id,
            type: "GET",
            success: function (result) {
                // alert(result.extend.employee);
                var empData = result.extend.employee;
                $("#emp_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModal input[name=gender]").val([empData.gender]);
                $("#empUpdateModal select").val([empData.dId]);
            }
        });
    }

    //点击更新，更新员工信息
    $("#emp_update_btn").click(function () {
        //校验邮箱
        var email = $("#email_update_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;

        if (!regEmail.test(email)) {
            // alert("邮箱格式不正确");
            show_validate_msg("#email_update_input", "error", "邮箱格式不正确");
            return false;
        } else {
            show_validate_msg("#email_update_input", "success", "");
        }

        $.ajax({
            url: "${ctp}/emp/" + $(this).attr("edit_id"),
            type: "PUT",
            data:$("#empUpdateModal form").serialize()/*+"&_method=PUT"*/,
            success: function (result) {
                // alert("成功")
                //关闭对话框
                $("#empUpdateModal").modal("hide");
                //回到本页面
                to_page(currentPage);
            }
        });
    });

    //完成全选/全部选功能
    $("#check_all").click(function () {
        //attr获取checked是undefined
        //dom原生的属性建议使用prop获取，自定义属性，用attr获取值
        // alert($(this).prop("checked"));
        $(".check_item").prop("checked",$(this).prop("checked"));
    });

    //check_item
    $(document).on("click",".check_item",function () {
       var flag = $(".check_item:checked").length == $(".check_item").length;
           $("#check_all").prop("checked",flag);
    });

    //点击全部删除，就批量删除
    $("#emp_delete_all_btn").click(function () {
        var empNames = "";
        var del_idstr = "";
        $.each($(".check_item:checked"),function () {
            // alert($(this).parents("tr").find("td:eq(2)").text());
            empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
            del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        //去除多余的,
        empNames = empNames.substring(0,empNames.length-1);
        del_idstr = del_idstr.substring(0,del_idstr.length-1);
        if (confirm("确定删除【"+empNames+"】吗？")){
            //发送Ajax请求删除
            $.ajax({
                url:"${ctp}/emp/"+del_idstr,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    to_page(currentPage);
                }
            });
        }
    });


</script>
</body>
</html>

