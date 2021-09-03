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
    <title>门诊查询</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="../Css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="../Css/bootstrap-responsive.css" />
    <link rel="stylesheet" type="text/css" href="../Css/style.css" />
    <script type="text/javascript" src="../Js/jquery.js"></script>
    <script type="text/javascript" src="../Js/jquery.sorted.js"></script>
    <script type="text/javascript" src="../Js/bootstrap.js"></script>
    <script type="text/javascript" src="../Js/ckform.js"></script>
    <script type="text/javascript" src="../Js/common.js"></script>

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
<input name="method" value="findRegisterByPage" type="hidden"/>
<table class="table table-bordered table-hover definewidth m10">
    <tr>
        <td width="10%" class="tableleft">病历号：</td>
        <td><input type="text" id="rid" name="rid" value="${sid }"/></td>
		
        <td width="10%" class="tableleft">姓名：</td>
        <td><input type="text" id="name" name="name" value="${name }"/></td>
		
        <td width="10%" class="tableleft">科室：</td>
        <td>
        	<select name="department" id="department">
	        	<option value="0" >==请选择==</option>
	        	<option value="1" <c:if test="${department ==1 }">selected='selected'</c:if>>急诊科</option>
	        	<option value="2" <c:if test="${department ==2 }">selected='selected'</c:if>>儿科</option>
	        	<option value="3" <c:if test="${department ==3 }">selected='selected'</c:if>>妇科</option>
	        	<option value="4" <c:if test="${department ==4 }">selected='selected'</c:if>>皮肤科</option>
	        	<option value="5" <c:if test="${department ==5 }">selected='selected'</c:if>>内分泌科</option>
	        	<option value="6" <c:if test="${department ==6 }">selected='selected'</c:if>>牙科</option>
        	</select>
        </td>
    </tr>
    <tr>
		  <td colspan="6">
		  <center>
            <input id="find" name="find" type="submit" class="btn btn-primary" value="查询"/>
			<input name="ret" id="ret" type="button" class="btn btn-primary" value="清空"/>
            </center>
        </td>
    </tr>
</table>
</form>
   
<table class="table table-bordered table-hover definewidth m10" >
   <thead>
    <tr>
    	<th><input type="checkbox" id="checkall" onChange="checkall();"></th>
        <th>病例号</th>
        <th>病人姓名</th>
        <th>主治医生</th>
        <th>挂号时间</th>
        <th>挂号科室</th>
        <th>状态</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    	<c:forEach items="${list }" var="r">
	    	<tr>
		    	<td><input type="checkbox" name="chk" value="${r.sid }" ></td>
		        <td>${r.sid }</td>
		        <td>${r.name }</td>
		        <td>${r.doctor.name }</td>
		        <td>${r.registerDate }</td>
		        <td>
		        <!-- 1-急诊  2-儿科 3-妇科 4-皮肤科 5-内分泌科 6-牙科  -->
		        <c:if test="${r.department == 1}">急诊</c:if>
		        <c:if test="${r.department == 2}">儿科</c:if>
		        <c:if test="${r.department == 3}">妇科</c:if>
		        <c:if test="${r.department == 4}">皮肤科</c:if>
		        <c:if test="${r.department == 5}">内分泌科</c:if>
		        <c:if test="${r.department == 6}">牙科</c:if>
		        </td>
		        <td>
		        	<c:if test="${r.status == 1}">挂号</c:if>
		        	<c:if test="${r.status == 2}">已住院</c:if>
		        	<c:if test="${r.status == 3}">已出院</c:if>
		        	<c:if test="${r.status == 4}">已结算</c:if>
		        </td>
		        <td>
		        	<a href="${path }register?method=findRegisterByRid&rid=${r.sid}">详情>>></a>
		        	<c:if test="${r.status == 1 }">
		        		<a href="${path }register?method=showRegisterDetails&rid=${r.sid}&department=${r.department}">修改</a>
		        	</c:if>
		        </td>
	    	</tr>
    	</c:forEach>
     </tbody>
  </table>
  
  <table class="table table-bordered table-hover definewidth m10" >
  	<tr><th colspan="5">  
  		<div class="inline pull-right page">
	          <a href="${path }register?method=findRegisterByPage&currentPage=1" >首页</a> 
	          <a href="${path }register?method=findRegisterByPage&currentPage=${pageTool.prePage}">上一页</a>     
	          <a href="${path }register?method=findRegisterByPage&currentPage=${pageTool.nextPage}" >下一页</a> 
	          <a href="${path }register?method=findRegisterByPage&currentPage=${pageTool.totalPages}" >尾页</a>
			  &nbsp;&nbsp;&nbsp;
			     共<span class='current'>${pageTool.totalCount } </span>条记录
			     <span class='current'>${pageTool.currentPage }/${pageTool.totalPages } </span>页
		</div>
		<div>
		   <button type="button" class="btn btn-success" id="newNav">门诊挂号</button>&nbsp;&nbsp;&nbsp;
		   <button type="button" class="btn btn-success" id="delRegister" onclick="delAll()">批量删除</button>
		</div>
	</th></tr>
  </table>
  <script type="text/javascript">
  	//清空
  	$("#ret").click(function(){
  		$("#rid").val("");
  		$("#name").val("");
  		$("#department").val("0");
  	});
  	//单击门诊挂号按钮跳转到add.jsp页面
  	$("#newNav").click(function(){
  		window.location="${path}register/add.jsp";
  	});
  	//全选全不选
  	$("#checkall").click(function(){
  		$('[name="chk"]').prop("checked",this.checked);
  	});
  	//批量删除
  	function delAll(){
  		var ids="";//保存所有被选中的复选框的id号
  		//获取到所有被选中的复选框
  		var chks=document.getElementsByName("chk");
  		//循环判断
  		for(var i=0;i<chks.length;i++){
  			if(chks[i].checked){
  				ids=ids+"'"+chks[i].value+"',";
  			}
  		}
  		//判断是否选择要删除的项
  		if(ids!=""){
  			if(confirm("是否确定要删除？")){
  				//截掉最后拼接的逗号
  	  			ids=ids.substring(0,ids.length-1);
  				window.location="${path}register?method=deleteRegister&ids="+ids;
  			}
  		}else{
  			alert("请选择要删除的项！");
  		}
  	}
  </script>
</body>
</html>
