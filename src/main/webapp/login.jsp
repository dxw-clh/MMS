<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/* request.getScheme():获取协议 http
		request.getServerName():获取服务器名  localhost
		request.getServerPort():获取端口号 8080
		request.getContextPath():获取项目根目录 hospital
		http://localhost:8080/hospital/login.jsp
	*/
	String path=request.getScheme()+"://"+request.getServerName()+":"+
	request.getServerPort()+request.getContextPath()+"/";
	pageContext.setAttribute("path", path);
%>
<!DOCTYPE html>
<html>
<head>
    <title>优就业-在线医疗管理系统</title>
	<meta charset="UTF-8">
	<link rel="icon" href="${pageContext.request.contextPath}/Images/logo_favicon.ico" type="image/x-icon" />
   <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Css/bootstrap-responsive.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Css/style.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/Js/jquery.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/Js/jquery.sorted.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/Js/bootstrap.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/Js/ckform.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/Js/common.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/Js/jquery-3.4.1.js"></script>
    <style type="text/css">
        body {
            padding-top: 140px;
            padding-bottom: 40px;
            background-color: #f5f5f5;
            font-family: "微软雅黑";
            background: url("${pageContext.request.contextPath}/Images/yy.jpg");
            background-size: 100%;
            background-repeat: no-repeat;
        }

        .form-signin {
            max-width: 400px;
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
			font-size: 12px;
		}
		
    </style>  
</head>
<body>
<div class="container">
	
    <form id="form2" class="form-signin" method="post" action="${pageContext.request.contextPath}/user/Login">
    	<input type="hidden" name="method" value="userLogin">
        <h2 class="form-signin-heading" >在线医疗管理系统</h2>
        <span id="message" class="message">${message }</span><br>
        <input type="text" id="username" name="username" value="${username}" class="input-block-level" placeholder="账号">
        <input type="password" id="password" name="password" class="input-block-level" placeholder="密码" >
        <input type="text" id="verify" name="verify" class="input-medium" placeholder="验证码"> 
        <img id="code" class="code_images" onclick="refresh(this)" src="${path}authImage" /> 
		<!--  
			验证码功能参考：
			https://www.cnblogs.com/jianlun/articles/5553452.html
		-->
        <p style="text-align: center;">
        <input id="login" type="button" value="登录" name="login" class="btn btn-large btn-primary" style="width: 150px;"/>
        <a href="${pageContext.request.contextPath}/regist.jsp">请先注册</a>
        </p>
    </form>
</div>	
<script type="text/javascript">
	function refresh(obj) {
		//刷新验证码
		obj.src = "${path}authImage?id="+Math.random();
	}
	//页面加加载后执行的js代码
	$(function () {
		//为登录按钮添加一个鼠标点击事件：
		$("#login").click(function () {
			//获取账号、密码、验证码的值
			var username = $("#username").val();
			var password = $("#password").val();
			var verify = $("#verify").val();
			//判断账号是否为空：
			if(username==null||username==""){
				$("#message").text("用户名不能为空");
				return;
			}
			//判断账号是否为空：
			if(password==null||password==""){
				$("#message").text("密码不能为空");
				return;
			}
			//判断账号是否为空：
			if(verify==null||verify==""){
				$("#message").text("验证码不能为空");
				return;
			}
			//判断验证码是否正确
			$("#form2").submit();
			//判断验证码是否正确：使用异步判断
			/*$.ajax({
				url:"user",
				data:{"method":"verifyCode","verfiy":verify},
				type:"post",
				dataType:"json",
				success:function(obj){
					//判断验证码是否正确
					if(obj){
						//提交表单
						$("#form2").submit();
					}else{
						$("#message").text("验证码输入错误！");
					}
				}
			})*/
		})
	})
</script>
</body>
</html>