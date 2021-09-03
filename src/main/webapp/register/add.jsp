<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path=request.getScheme()+"://"+request.getServerName()+":"+
	request.getServerPort()+request.getContextPath()+"/";
	pageContext.setAttribute("path", path);
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=this.getServletContext().getContextPath() %>/register/">
    <title>挂号</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="../Css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="../Css/bootstrap-responsive.css" />
    <link rel="stylesheet" type="text/css" href="../Css/style.css" />
    <script type="text/javascript" src="../Js/jquery.js"></script>
    <script type="text/javascript" src="../Js/jquery.sorted.js"></script>
    <script type="text/javascript" src="../Js/bootstrap.js"></script>
    <script type="text/javascript" src="../Js/ckform.js"></script>
    <script type="text/javascript" src="../Js/common.js"></script>
    <script type="text/javascript" src="../Js/ckeditor/ckeditor.js"></script>
    <script type="text/javascript" src="../Js/jquery-3.4.1.js"></script>
    <style type="text/css">
        body {
            padding-bottom: 40px;
        }
        .sidebar-nav {
            padding: 9px 0;
        }

        @media (max-width: 980px) {
            /* Enable use of floated navbar text */
            .navbar-text.pull-right {
                float: none;
                padding-left: 5px;
                padding-right: 5px;
            }
        }


    </style>
    <script type="text/javascript">
    
    
    </script>
</head>
<body>
<form action="${path }register" method="post" class="definewidth m20">
	<input name="method" value="insertRegister" type="hidden">
<table class="table table-bordered table-hover definewidth m10">
	<tr>
        <td width="10%" class="tableleft">病历号</td>
        <td><input type="text" name="rid" value=""/></td>
    </tr>
    <tr>
        <td width="10%" class="tableleft">姓名</td>
        <td><input type="text" name="name" value=""/></td>
    </tr>

    <tr>
        <td width="10%" class="tableleft">身份证号</td>
        <td><input type="text" name="idCard" value=""/></td>
    </tr>
    <tr>
        <td width="10%" class="tableleft">社保号</td>
        <td><input type="text" name="siNumber" value=""/></td>
    </tr>
    <tr>
        <td width="10%" class="tableleft">挂号费</td>
        <td><input type="text" name="registerMoney" value=""/>元</td>
    </tr>
    <tr>
        <td width="10%" class="tableleft">联系电话</td>
        <td><input type="text" name="phone" value=""/></td>
    </tr>
    <tr>
        <td width="10%" class="tableleft">是否自费</td>
        <td><input type="radio" name="isPay" value="0" checked/>否&nbsp;&nbsp;&nbsp;
            <input type="radio" name="isPay" value="1"/>是</td>
    </tr>
    <tr>
        <td width="10%" class="tableleft">性别</td>
        <td><input type="radio" name="sex" value="0" checked/>男&nbsp;&nbsp;&nbsp;
            <input type="radio" name="sex" value="1"/>女</td>
    </tr>
    <tr>
        <td width="10%" class="tableleft">年龄</td>
        <td><input type="text" name="age" value=""/></td>
    </tr>
    <tr>
        <td width="10%" class="tableleft">初复诊</td>
        <td><input type="radio" name="consultation" value="0" checked/>初诊&nbsp;&nbsp;&nbsp;
            <input type="radio" name="consultation" value="1"/>复诊</td>
    </tr>
    <tr>
        <td width="10%" class="tableleft">所挂科室</td>
        <td>
        	<select name="department" id="department" onchange="editDid(this)">
        		<option value="0">==-请选择科室-==</option>
        		<option value="1">急诊科</option>
        		<option value="2">儿科</option>
        		<option value="3">妇科</option>
        		<option value="4">皮肤科</option>
        		<option value="5">内分泌科</option>
        		<option value="6">牙科</option>
        	</select>
        </td>
    </tr>
    <tr>
        <td width="10%" class="tableleft">指定医生</td>
        <td>
        	<select name="did" id="doctor">
				
	        </select>
    </tr>
	<tr>
        <td width="10%" class="tableleft">备注</td>
        <td><textarea name="remark"></textarea></td>
	</tr>
    <tr>
        <td colspan="2">
			<center>
				<button type="submit" class="btn btn-primary" type="button">保存</button> &nbsp;&nbsp;
				<button type="button" class="btn btn-success" name="backid" id="backid">返回列表</button>
			</center>
		</td>
    </tr>
</table>
</form>
</body>
<script type="text/javascript">
	//返回列表
	$("#backid").click(function(){
		window.location="${path}register?method=findRegisterByPage";
	});
	
	//根据选择不同的科室加载医生下拉列表
	function editDid(obj) {
		//得到当前选择的科室 对应的值
		var did = obj.value;
		//使用异步根据科室查询对应的医生信息
		$.getJSON("${path}doctor",{"method":"findDoctByDe","deid":did},function(data){
			//清空原有的数据
			$("#doctor").empty();
			//将获取到的集合遍历
			$.each(data,function(index,item){
				//创建一个option标签
				var opt = "<option value='"+item.did+"'>"+item.name+"</option>";
				//将标签追加到select标签中：
				$("#doctor").append(opt);
			})
		})
	}
</script>
</html>