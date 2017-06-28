<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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
  
  <body>
    <BR>

<TABLE cellSpacing=1 cellPadding=3 width="95%" align=center bgColor=#6ab6b6 
border=0>
  <TBODY>
  <TR>
    <TD colSpan=2 height=24>【系统用户信息】</TD> </TR>
  <TR align=center>
    <TD class=forumrow  height=24>用户编号</TD>
    <TD class=forumrow  height=24>用户类型</TD>
    <TD class=forumrow  height=24>用户名</TD>
    <TD class=forumrow  height=24>密码</TD>
    <TD class=forumrow  height=24>姓名</TD>
    <TD class=forumrow  height=24>身份证号</TD>
    <TD class=forumrow  height=24>所属部门</TD>
    <TD class=forumrow  height=24>职级</TD>
    <TD class=forumrow  height=24>联系电话</TD>
    <TD class=forumrow  height=24>邮箱属性</TD>
    <TD class=forumrow  height=24>操作</TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24>00001</TD>
    <TD class=forumrow  height=24>0</TD>
    <TD class=forumrow  height=24>admin</TD>
    <TD class=forumrow  height=24>123</TD>
    <TD class=forumrow  height=24>王老大</TD>
    <TD class=forumrow  height=24>429000199012120000</TD>
    <TD class=forumrow  height=24>信息部</TD>
    <TD class=forumrow  height=24>主管</TD>
    <TD class=forumrow  height=24>13667899876</TD>
    <TD class=forumrow  height=24>admin@163.com</TD>
    <TD class=forumrow  height=24>编辑&nbsp;|&nbsp;删除</TD>
  </TR>
  </TBODY></TABLE>
  </body>
</html>
