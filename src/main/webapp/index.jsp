<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<html>
<head>
    <title>员工列表</title>
    <script src="${APP_PATH}/static/js/jquery-3.4.1.min.js"></script>
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <link type="text/css" href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%--员工修改--%>
<div class="modal fade" id="empUpdateModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update" placeholder="email">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" >

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update">修改</button>
            </div>
        </div>
    </div>
</div>


<%--//员工添加--%>
<div class="modal fade" id="empAddModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add" placeholder="email">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_select_add">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save">保存</button>
            </div>
        </div>
    </div>
</div>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add">新增</button>
            <button class="btn btn-danger" id="emp_delete_all">删除</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="check_all">
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
    <div class="row">
        <div class="col-md-6" id="page_info">
        </div>
        <div class="col-md-6" id="page_nav">

        </div>
    </div>

    <script type="text/javascript">

        var totalRecord,currentPage;
        $(function (){
            to_page(1);
        });

        function to_page(pn) {
            $.ajax({
                url:"${APP_PATH}/emps",
                data:"pn="+pn,
                type:"get",
                success:function (result){
                    build_emps_table(result);
                    build_page_info(result);
                    build_page_nav(result);
                }
            });

        }

        function  build_emps_table(result){
            $("#emps_table tbody").empty();

            var emps=result.extend.pageInfo.list;
            $.each(emps,function (i,n) {
                var checkBox=$("<td><input type='checkbox' class='check_item'/></td>");
                var empIdTd=$("<td></td>").append(n.empId);
                var empNameTd=$("<td></td>").append(n.empName);
                var empSexTd=$("<td></td>").append(n.gender=='M'? "男":"女");
                var emailTd=$("<td></td>").append(n.email);
                var deptNameTd=$("<td></td>").append(n.department.deptName);

                var editBtn=$("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
                editBtn.attr("edit-id",n.empId);
                var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
                delBtn.attr("del-id",n.empId);
                var btnTd=$("<td></td>").append(editBtn).append(" ").append(delBtn);
                $("<tr></tr>").append(checkBox)
                    .append(empIdTd)
                    .append(empNameTd)
                    .append(empSexTd)
                    .append(emailTd)
                    .append(deptNameTd)
                    .append(btnTd)
                    .appendTo("#emps_table tbody");
            })
        }

        //全选全不选
        $("#check_all").click(function (){
            $(".check_item").prop("checked",$(this).prop("checked"))
        })
        //判断选中的元素是否是5格
        $(document).on("click",".check_item",function () {
            var flag=$(".check_item:checked").length==$(".check_item").length;
            $("#check_all").prop("checked",flag);
        })

        //分页信息
        function build_page_info(result){
            $("#page_info").empty();
            $("#page_info").append("第"+result.extend.pageInfo.pageNum+"页，总共"+result.extend.pageInfo.pages+"页，总共"+result.extend.pageInfo.total+"条记录")
            totalRecord=result.extend.pageInfo.total;
            currentPage=result.extend.pageInfo.pageNum;
        }
      //解析显示分页条
        function build_page_nav(result){

            $("#page_nav").empty();
            var ul=$("<ul></ul>").addClass("pagination");

            var firstPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
            var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));
            if(result.extend.pageInfo.hasPreviousPage == false){
                firstPageLi.addClass("disabled");
                prePageLi.addClass("disabled");
            }else{
                prePageLi.click(function () {
                    to_page(result.extend.pageInfo.pageNum-1);
                });
                firstPageLi.click(function () {
                    to_page(1);
                });
            }


            var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));
            var lastPageLi=$("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
            if(result.extend.pageInfo.hasNextPage == false){
                lastPageLi.addClass("disabled");
                nextPageLi.addClass("disabled");
            }else{
                nextPageLi.click(function () {
                    to_page(result.extend.pageInfo.pageNum+1);
                });
                lastPageLi.click(function () {
                    to_page(result.extend.pageInfo.pages);
                });
            }


            ul.append(firstPageLi).append(prePageLi);
            $.each(result.extend.pageInfo.navigatepageNums,function (i,item) {

               var numLi= $("<li></li>").append($("<a></a>").append(item));
               if(result.extend.pageInfo.pageNum==item){
                   numLi.addClass("active");
               }
               numLi.click(function () {

                   to_page(item);
               })
               ul.append(numLi);
            });

            ul.append(nextPageLi).append(lastPageLi);
            var nav=$("<nav></nav>").append(ul);
            nav.appendTo("#page_nav");
        }

        //清空扁担样式及内容
        function reset_form(ele){
            $(ele)[0].reset();
            //清空表单样式
            $(ele).removeClass("has-error has-success");
            $(ele).find(".help-block").text("");
        }
        //弹出模态框
        $("#emp_add").click(function () {

            //将表单样式重置
            reset_form("#empAddModel form");

            //清除表单数据
            // $("#empAddModel form")[0].reset();
            //发送ajax请求
            getDepts("#empAddModel select");
            $("#empAddModel").modal({
                backdrop:"static"
            })
        })
        function getDepts(ele){
            $.ajax({
                url: "${APP_PATH}/depts",
                type: "get",
                success:function (result){
                    //显示部门信息在下拉列表中
                    $("#dept_select_add").empty();
                    $.each(result.extend.depts,function (i,item){
                        var option=$("<option></option>").append(item.deptName).attr("value",item.deptId);
                        option.appendTo(ele);
                    })
                }
            })
        }

        //添加信息的表单校验
        function validate_add_form() {
            var empName=$("#empName_add").val();
            var regName=/(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
            if(!regName.test(empName)){
                show_validate_msg("#empName_add","error","用户名可以是2-5位中文或6-16位英文字母组合")
                return false;
            }else{
                show_validate_msg("#empName_add","success","");
            }

            var email=$("#email_add").val();
            var regEmail=/^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]+$/;
            if(!regEmail.test(email)){
                show_validate_msg("#email_add","error","邮箱格式不正确")
                return false;
            }else{
                show_validate_msg("#email_add","success","");
            }
            return true;
        }

        //校验显示信息的抽取
        function show_validate_msg(element,status,msg) {
            $(element).parent().removeClass("has-success has-error");
            $(element).next("span").text("");
            if("success"==status){
                $(element).parent().addClass("has-success");
                $(element).next("span").text(msg);
            }else{
                $(element).parent().addClass("has-error");
                $(element).next("span").text(msg);
            }
        }


        $("#empName_add").change(function (){

            //发送ajax请求校验姓名
            var name=this.value;
            $.ajax({
                url:"${APP_PATH}/checkuser",
                data:"empName="+name,
                type:"get",
                success:function (result){
                    if(result.code==100){
                        show_validate_msg("#empName_add","success","用户名可用");
                        $("#emp_save").attr("ajax-va","success");
                    }else{
                        show_validate_msg("#empName_add","error",result.extend.va_msg);
                        $("#emp_save").attr("ajax-va","error");
                    }
                }
            })
        })

        //点击保存员工数据
        $("#emp_save").click(function () {

            //模态框中表单数据提交给服务器保存

            //数据校验
            if(!validate_add_form()){
                return false;
            }
            //失败后防止添加,去除重复添加
            if($(this).attr("ajax-va")=="error"){
                return false;
            }
            $.ajax({
                url:"${APP_PATH}/emp",
                type:"POST",
                data:$("#empAddModel form").serialize(),
                success:function (result) {
                    //判断返回结果
                    if(result.code==100){
                        $("#empAddModel").modal("hide");
                        to_page(totalRecord);
                    }else {
                        if(undefined!=result.extend.errorFields.email){
                            show_validate_msg("#email_add","error",result.extend.errorFields.email);
                        }
                        if(undefined!=result.extend.errorFields.empName){
                            show_validate_msg("#empName_add","error",result.extend.errorFields.empName);
                        }
                    }
                }
            });
        });

        $(document).on("click",".edit_btn",function (){
            getDepts("#empUpdateModel select");
            getEmp($(this).attr("edit-id"));


            //将员工id传递给更新按钮
            $("#emp_update").attr("edit-id",$(this).attr("edit-id"));
            $("#empUpdateModel").modal({
                "backdrop":"static"
            });
        })

        //点击单个删除
        $(document).on("click",".delete_btn",function () {
            //alert($(this).parents("tr").find("td:eq(1)").text());

            var empName=$(this).parents("tr").find("td:eq(2)").text();
            var empId=$(this).attr("del-id");
            if(confirm("确认删除【"+empName+"】吗？")){
                $.ajax({
                    url:"${APP_PATH}/emp/"+empId,
                    type:"DELETE",
                    success:function (result){
                        to_page(currentPage);
                    }

                })
            }
        })

        function getEmp(id){
            $.ajax({
                url:"${APP_PATH}/emp/"+id,
                type:"get",
                success:function (result){
                    var empData=result.extend.emp;
                    $("#empName_update").text(empData.empName);
                    $("#email_update").val(empData.email);
                    $("#empUpdateModel input[name=gender]").val([empData.gender]);
                    $("#empUpdateModel select").val([empData.dId]);
                }
            })
        }

        $("#emp_update").click(function () {
            var email=$("#email_update").val();
            var regEmail=/^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]+$/;
            if(!regEmail.test(email)){
                show_validate_msg("#email_add","error","邮箱格式不正确")
                return false;
            }else{
                show_validate_msg("#email_add","success","");
            }

            $.ajax({
                url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
                type:"PUT",
                data:$("#empUpdateModel form").serialize(),
                success:function (result) {
                    //关闭模态框
                    $("#empUpdateModel").modal("hide");
                    //回到本页面
                    to_page(currentPage);
                }
            })
        })

        $("#emp_delete_all").click(function () {
            var empName="";
            var del_idstr=""
            $.each($(".check_item:checked"),function (i,item){
                empName+=$(this).parents("tr").find("td:eq(2)").text()+",";
                del_idstr+=$(this).parents("tr").find("td:eq(1)").text()+"-";
            });
            empName=empName.substring(0,empName.length-1);
            del_idstr=del_idstr.substring(0,del_idstr.length-1);
            if(confirm("确认删除【"+empName+"】吗？")){
                //发送请求删除所有
                $.ajax({
                    url:"${APP_PATH}/emp/"+del_idstr,
                    type:"DELETE",
                    success:function (result) {
                        alert(result.msg);
                        to_page(currentPage);
                    }
                })
            }
        })
    </script>
</div>
</body>
</html>
