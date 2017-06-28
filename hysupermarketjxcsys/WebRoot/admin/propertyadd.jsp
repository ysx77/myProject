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
    <TD  height=24>【新增属性】</TD>
  	<TD  height=24 colspan="2" align="right"><a href="admin/property.jsp" target=frmright>返回上一层</a></TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24 width="20%">属性名称</TD>
    <TD class=forumrow  height=24 align="left"><input type="text" id="propertyname" name="propertyname" size="50"></TD>
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
		if(f1.propertyname.value==""){
			alert("属性名称不能为空");
			return false;
		}
	}
<%
String suc = (String)request.getAttribute("suc");
String no = (String)request.getAttribute("no");
if(no!=null)
{
 %>
 alert("");
 <%}
if(suc!=null)
{
 %>
 alert("操作成功");
location.replace("/hysupermarketjxcsys/admin/property.jsp");
 <%}%>
</script>
