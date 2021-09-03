<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path=request.getScheme()+"://"+request.getServerName()+":"+
	request.getServerPort()+request.getContextPath()+"/";
	pageContext.setAttribute("path", path);
%>
<!DOCTYPE html>
<html>
<head>
    <title>优就业-在线医疗管理系统</title>
	<meta charset="UTF-8">
	<link rel="icon" href="Images/logo_favicon.ico" type="image/x-icon" />
   <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Css/bootstrap-responsive.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Css/style.css" />
    <script type="text/javascript" src="Js/jquery.js"></script>
    <script type="text/javascript" src="Js/jquery.sorted.js"></script>
    <script type="text/javascript" src="Js/bootstrap.js"></script>
    <script type="text/javascript" src="Js/ckform.js"></script>
    <script type="text/javascript" src="Js/common.js"></script>
    <script type="text/javascript" src="Js/jquery-3.4.1.js"></script>
    <script type="text/javascript" src="Js/jquery.validate.js"></script>
    <script type="text/javascript" src="Js/messages_zh.js"></script>
    <style type="text/css">
        body {
            padding-top: 140px;
            padding-bottom: 40px;
            background-color: #f5f5f5;
            font-family: "微软雅黑";
            background-color: buttonhighlight;
        }

        .form-signin {
            max-width: 600px;
            padding: 19px 29px 29px;
            margin: 0 auto 20px;
            background-color: #fff;
            border: 1px solid #e5e5e5;
            -webkit-border-radius: 5px;
            -moz-border-radius: 5px;
            border-radius: 5px;
            -webkit-box-shadow: 0 1px 2px rgba(0, 0, 0, .05);
            -moz-box-shadow: 0 1px 2px rgba(0, 0, 0, .05);
            box-shadow: 0 1px 2px rgba(0, 0, 0, .05);
            background: rgba(255,255,255,0.5);
        }

        .form-signin .form-signin-heading,
        .form-signin .checkbox {
            margin-bottom: 10px;
            font-size: 24px;
            margin-left: 90px;
        }
        
        .form-signin .form-signin-heading{
        	margin-bottom: 10px;
            font-size: 24px;
            margin-left: 200px;
        }

        .form-signin input[type="text"],
        .form-signin input[type="password"] {
            font-size: 16px;
            height: auto;
            margin-bottom: 15px;
            padding: 7px 9px;
        }
		
		
		#message{
			font-size: 14px;
			color:red;
			margin-left: 40px;
		}
		
		.input-block-level{
			width: 300px;
			margin-left: 40px;
		}
		.input-medium{
			margin-left: 40px;
		}
		.code_images{
			width: 115px;
			height: 35px;
			margin-top: -15px;
			margin-left: 10px;
		}
		.error{
			color: red;
			font-size: 14px;
		}
		
    </style>  
</head>
<body>
${message}
<div class="container">	
    <form id="form2" class="form-signin" method="post" action="user/regist">
    	<input type="hidden" name="method" value="regist">
        <h2 class="form-signin-heading" >管理员注册</h2>
                        姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名：
		<input type="text" name="name" value="${user.name}" class="input-block-level" placeholder="真实姓名">
			<font color="red" size="4" id="nameError"></font>
		<br/>
                        密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码：
        <input id="password" type="password" name="password"  class="input-block-level" placeholder="密码">
        	<font color="red" size="4" id="pwd1Error"></font>
        <br/>
                       确认密码：<input type="password" name="password2" class="input-block-level" placeholder="确认密码">
        	<font color="red" size="4" id="pwd2Error"></font>
        <br/>
                        用&nbsp;&nbsp;户&nbsp;&nbsp;名：
         <input type="text" id="username" name="username" value="${user.username}" class="input-block-level" placeholder="用户名">
        	<font color="red" size="4" id="usernameError"></font><br>
                        邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;箱：
         <input type="text" id="email" name="email" value="${user.email}" class="input-block-level" placeholder="邮箱">
        	<font color="red" size="4" id="emailError"></font><br/>               
        <p style="text-align: center;">
        <input id="login" onclick="userRegist()" type="button" value="注册" name="login" class="btn btn-large btn-info" style="width: 100px;"/>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input id="reset" type="reset" value="清空" name="login" class="btn btn-large btn-info" style="width: 100px;"/>
        </p>
    </form>
</div>


<script type="text/javascript">
	function userRegist() {
		//设置一个变量，用来判断是否可以提交
		var sub = 0;
		//判断真实姓名是否是空
		if($("input[name='name']").val().length==0){
			//添加提示
			$("#nameError").text("用户名不能为空");
			//不能注册，返回
			sub = 1;
		}else{
			//如果不为空，删除文本
			$("#nameError").text("");
		}
		//判断密码是否为空
		if($("input[name='password']").val().length==0){
			//添加提示
			$("#pwd1Error").text("密码不能为空");
			//不能注册，返回
			sub = 1;
		}else{
			//如果不为空，删除文本
			$("#pwd1Error").text("");
		}
		//判断密码 确认是否为空
		if($("input[name='password2']").val().length==0){
			//添加提示
			$("#pwd2Error").text("密码确认不能为空");
			//不能注册，返回
			sub = 1;
		}else{
			//两次密码是否一致
			if($("input[name='password2']").val() != $("input[name='password']").val()){
				//添加提示
				$("#pwd2Error").text("两次密码输入不一致");
				//不能注册，返回
				sub = 1;
			}else{
				//如果不为空，删除文本
				$("#pwd2Error").text("");
			}
		}
		//判断登陆名是否是空
		if($("input[name='username']").val().length==0){
			//添加提示
			$("#usernameError").text("登陆名不能为空");
			//不能注册，返回
			sub = 1;
		}else{
			//判断登陆名是否重复的方法
			$.ajax({
				url : "user/findUsername",
				type : "post",
				data : {"username":$("input[name='username']").val()},
				dataType:"json",
				async:false,//将当前请求设置为同步
				success : function (flag) {
					if(flag){
						$("#usernameError").text("该用户名可以注册");
					}else{
						$("#usernameError").text("用户名重复，请更换");
						//不能注册，返回
						sub = 1;
					}
				}
			})
			
		}
		//判断邮箱是否是空
		if($("input[name='email']").val().length==0){
			//添加提示
			$("#emailError").text("邮箱不能为空");
			//不能注册，返回
			sub = 1;
		}else{
			//判断登陆名是否重复的方法
			$.ajax({
				url : "user/findEmail",
				type : "post",
				data : {"email":$("input[name='email']").val()},
				dataType:"json",
				async:false,//将当前请求设置为同步
				success : function (flag) {
					
					if(flag){
						$("#emailError").text("该邮箱可以注册");
					}else{
						$("#emailError").text("邮箱重复，请更换");
						//不能注册，返回
						sub = 1;
					}
				}
			})
		}
		
		
		//判断是否可以提交
		if(sub == 1){
			return;
		}else{
			//提交表单数据  找到form表单 进行提交 
			$("#form2").submit();
		}
	}
</script>
</body>
</html>