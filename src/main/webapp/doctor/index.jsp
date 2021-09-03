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
	<base href="<%=this.getServletContext().getContextPath() %>/doctor/">
    <title>门诊医生</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="../Css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="../Css/bootstrap-responsive.css" />
    <link rel="stylesheet" type="text/css" href="../Css/style.css" />
    <script type="text/javascript" src="../Js/jquery.js"></script>
    <script type="text/javascript" src="../Js/jquery.sorted.js"></script>
    <script type="text/javascript" src="../Js/bootstrap.js"></script>
    <script type="text/javascript" src="../Js/ckform.js"></script>
    <script type="text/javascript" src="../Js/common.js"></script>
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

<form action="${path}doctor/pageList" method="post" class="definewidth m20">
<table class="table table-bordered table-hover definewidth m10">
	<tr>
	  <td width="10%" class="tableleft">医生姓名：</td>
	  <td><input type="text" id="name" name="name" value="${name}" /></td>		
	  <td width="10%" class="tableleft">科室：</td>
	  <td>
	    <select name="department" id="department">
	    
	        <option value="0" <c:if test="${department == 0}">selected</c:if> >==请选择==</option>
	        <option value="1" <c:if test="${department == 1}">selected</c:if> >急诊科</option>
	        <option value="2" <c:if test="${department == 2}">selected</c:if> >儿科</option>
	        <option value="3" <c:if test="${department == 3}">selected</c:if> >妇科</option>
	        <option value="4" <c:if test="${department == 4}">selected</c:if> >皮肤科</option>
	        <option value="5" <c:if test="${department == 5}">selected</c:if> >内分泌科</option>
	        <option value="6" <c:if test="${department == 6}">selected</c:if> >牙科</option>
        </select>
	  </td>
	</tr>
	<tr>
	  <td colspan="6">
	    <center>
			<input id="find" name="find" type="submit" class="btn btn-primary" value="查询"/>
			<input id="ret" name="ret" type="button" class="btn btn-primary" value="清空"/>
		</center>
	  </td>
	 </tr>
</table>
</form>
   
<table class="table table-bordered table-hover definewidth m10" >
   <thead>
    <tr>
    	<th><input type="checkbox" id="checkall" onChange="checkall(this)">
    	<input type="checkbox" id="checkNo" onChange="checkNo()">
    	</th>
        <th>医生编号</th>
        <th>医生姓名</th>
        <th>联系方式</th>
        <th>所属科室</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    	<c:forEach items="${pageInfo.list}" var="doctor">
    	 <tr>
	    	<td><input type="checkbox"  name="chk" value="${doctor.did}"></td>
	        <td>${doctor.did}</td>
	        <td>${doctor.name}</td>
	        <td>${doctor.phone}</td>
	        <td>
	        	<c:if test="${doctor.department == 1}">急诊</c:if>
	        	<c:if test="${doctor.department == 2}">儿科</c:if>
	        	<c:if test="${doctor.department == 3}">妇科</c:if>
	        	<c:if test="${doctor.department == 4}">皮肤科</c:if>
				<c:if test="${doctor.department == 5}">内分泌科</c:if>
	        	<c:if test="${doctor.department == 6}">牙科</c:if>
	        </td>
	        <td>
	        	<a href="${path}doctor/lookDoctorByDid?did=${doctor.did}">详情>>></a>
	        	<a href="${path}doctor/findDoctorByDid?did=${doctor.did}">修改</a>
	        </td>
    	</tr>
    </c:forEach>
	 </tbody>
  </table>
  
  <table class="table table-bordered table-hover definewidth m10" >
  	<tr>
  		<th colspan="5">  <div class="inline pull-right page">
          <a href='${path}doctor/pageList?name=${name}&department=${department}' >首页</a> 
          
          <a href='${path}doctor/pageList?pageNum=${pageInfo.isFirstPage? 1 :pageInfo.pageNum-1}&name=${name}&department=${department}'>上一页</a>
          
          <a href='${path}doctor/pageList?pageNum=${pageTool.isLastPage? pageInfo.pages:pageInfo.pages}&name=${name}&department=${department}'>下一页</a> 
          
          <a href='${path}doctor/pageList?pageNum=${pageInfo.pages}&name=${name}&department=${department}'>尾页</a>
          
		  &nbsp;&nbsp;&nbsp;共<span class='current'>${pageInfo.total }</span>条记录
		  <span class='current'> ${pageInfo.pageNum}/${pageInfo.pages}</span>页
		  
		  </div>
		 <div>
		 <button type="button" class="btn btn-success" id="newNav">添加新医生</button>
		 <button type="button" class="btn btn-success" id="delAll">批量删除</button>
		 </div>
		 
		 </th>
	</tr>
  </table>  
</body>
<script type="text/javascript">
	//添加一个页面加载后执行的函数
	$(function () {
		//为newNav按钮添加一个鼠标点击-页面跳转的方法
		$("#newNav").click(function(){
			//跳转到add.jsp页面
			window.location.href = "${path}doctor/add";
		})
		//为delAll按钮添加一个批量删除的事件
		$("#delAll").click(function(){
			//获取所有多选框被选中的
			var nodes = $("input[name='chk']:checked");
			//判断当前被选择的节点个数
			if(nodes.length == 0){
				//没有选择  警告
				alert("最少要删除一个数据，请选择后点击！")
			}else{
				//设置一个字符串变量
				var ids = "";
				//要批量去删除数据
			    for (var i = 0; i < nodes.length; i++) {
			    	if(i != 0){
			    		ids += ",";
			    	}
			    	ids += nodes[i].value;	
				}
			    var  bl =  confirm("您是否确定要删除数据，删除将不可恢复！")
			    if(bl){
					//调用批量删除的方法
					window.location = "${path}doctor/delDoctor?ids="+ids;
			    }
			}
		})
	})
	
	//全选和全不选功能的函数
	function checkall(obj) {
		//通过name找到所有要操作的多选框  为jquery对象添加属性有两种方式 attr  prop
		$("input[name='chk']").prop("checked",obj.checked);
	}
	
	//实现反选功能的函数
	function checkNo() {
		//得到所有要操作的多选框  将里面的checked属性设置为相反的  遍历多个节点
		$("input[name='chk']").each(function () {
			//将当前单个节点的状态修改为相反的
			this.checked = !this.checked;
		}) 
	}
	
</script>
</html>
