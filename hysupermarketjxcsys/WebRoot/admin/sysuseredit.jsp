<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="dao.CommDAO"%>
<%@page import="util.Info"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'list.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<LINK href="images/syscome.files/Admin.css" rel=stylesheet>
<SCRIPT language=javascript src="syscome.files/Admin.js"></SCRIPT>

<STYLE type=text/css>.STYLE1 {
	FONT-WEIGHT: bold; COLOR: #0099ff
}
</STYLE>
  </head>
    <%CommDAO dao = new CommDAO(); 
  String id = request.getParameter("id");
  HashMap map = dao.select("select * from sysuser where id="+id).get(0);
  %>
  <body>
    <BR>
  <form action="/hysupermarketjxcsys/hysupermarketjxcsys?ac=sysuseredit&id=<%=id %>" name="f1" method="post" onsubmit="return ck()" >
<TABLE cellSpacing=1 cellPadding=3 width="95%" align=center bgColor=#6ab6b6 
border=0>
  <TBODY>
  <TR>
    <TD  height=24>【编辑系统用户】</TD>
  	<TD  height=24 colspan="2" align="right"><a href="admin/sysuser.jsp" target=frmright>返回上一层</a></TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24 width="20%">登陆名</TD>
    <TD class=forumrow  height=24 align="left"><%=map.get("username") %></TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24>登陆密码</TD>
    <TD class=forumrow  height=24 align="left"><input type="password" id="userpwd" name="userpwd"></TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24>真实姓名</TD>
    <TD class=forumrow  height=24 align="left"><input type="text" id="realname" name="realname"></TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24>性别</TD>
    <TD class=forumrow  height=24 align="left">
    	<select id="sex" name="sex">
    		<option value="男">男</option>
    		<option value="女">女</option>
    	</select>
    </TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24>身份证</TD>
    <TD class=forumrow  height=24 align="left"><input type="text" id="idcard" name="idcard" size="30"></TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24>联系电话</TD>
    <TD class=forumrow  height=24 align="left"><input type="text" id="tel" name="tel"></TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24>email</TD>
    <TD class=forumrow  height=24 align="left"><input type="text" id="email" name="email"></TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24>家庭住址</TD>
    <TD class=forumrow  height=24 align="left"><input type="text" id="addr" name="addr" size="50"></TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24>用户角色</TD>
    <TD class=forumrow  height=24 align="left">
    	<select id="usertype" name="usertype">
    		<option value="">请选择</option>
    		<option value="采购">采购</option>
    		<option value="销售">销售</option>
    		<option value="仓库">仓库</option>
    		<option value="财务">财务</option>
    		<option value="管理员">管理员</option>
    	</select>
    </TD>
  </TR>
  <TR align=center>
	<TD class=forumrow  height=24 colspan="2">
		<input type="submit" value="提交" class="button blue small"/>
		<input type="reset" value="重置" class="button blue small"/>
	</TD>
  </TR>
  </TBODY></TABLE>
  </body>
</html>
<script type="text/javascript">
	function ck(){
		if(f1.userpwd.value==""){
			alert("密码不能为空");
			return false;
		}if(f1.realname.value==""){
			alert("姓名不能为空");
			return false;
		}if(f1.idcard.value==""){
			alert("身份证不能为空");
			return false;
		}if(f1.tel.value==""){
			alert("联系电话不能为空");
			return false;
		}if(f1.email.value==""){
			alert("email不能为空");
			return false;
		}if(f1.addr.value==""){
			alert("住址不能为空");
			return false;
		}if(f1.usertype.value==""){
			alert("用户角色不能为空");
			return false;
		}
	}
<%
String suc = (String)request.getAttribute("suc");
String no = (String)request.getAttribute("no");
if(no!=null)
{
 %>
 alert("已存在的用户名");
 <%}
if(suc!=null)
{
 %>
 alert("操作成功");
location.replace("/hysupermarketjxcsys/admin/sysuser.jsp");
 <%}%>
</script>
<%=Info.tform(map)%>