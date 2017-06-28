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
  <form action="/hysupermarketjxcsys/hysupermarketjxcsys?ac=propertyadd" name="f1" method="post" onsubmit="return ck()" >
<TABLE cellSpacing=1 cellPadding=3 width="95%" align=center bgColor=#6ab6b6 
border=0>
  <TBODY>
  <TR>
    <TD  height=24>【数据备份】</TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24 align="left">
    <a href="/hysupermarketjxcsys/hysupermarketjxcsys?ac=backup">数据备份</a>
    </TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24 align="left">
    <a href="/hysupermarketjxcsys/hysupermarketjxcsys?ac=datahf">数据还原</a>
    </TD>
  </TR>
  </TBODY></TABLE>
  </body>
</html>
<script type="text/javascript">
	
<%
String suc1 = (String)request.getAttribute("suc1");
String suc2 = (String)request.getAttribute("suc2");
if(suc2!=null)
{
 %>
 alert("数据库恢复成功");
 location.replace("/hysupermarketjxcsys/admin/databackup.jsp");
 <%}
if(suc1!=null)
{
 %>
 alert("数据库备份成功，文件路径D:/backupDatabase");
location.replace("/hysupermarketjxcsys/admin/databackup.jsp");
 <%}%>
</script>
