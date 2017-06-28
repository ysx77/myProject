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
  
  <body>
    <BR>
  <%CommDAO dao = new CommDAO(); 
  String id = request.getParameter("id");
  HashMap map = dao.select("select * from suppliers where id="+id).get(0);
  %>
  <form action="/hysupermarketjxcsys/hysupermarketjxcsys?ac=customeredit&id=<%=id %>" name="f1" method="post" onsubmit="return ck()" >
<TABLE cellSpacing=1 cellPadding=3 width="95%" align=center bgColor=#6ab6b6 
border=0>
  <TBODY>
  <TR>
    <TD  height=24>【编辑客户】</TD>
  	<TD  height=24 colspan="2" align="right"><a href="admin/customers.jsp" target=frmright>返回上一层</a></TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24 width="20%">客户名称</TD>
    <TD class=forumrow  height=24 align="left"><input type="text" id="sname" name="sname" size="30"></TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24 width="20%">联系人</TD>
    <TD class=forumrow  height=24 align="left"><input type="text" id="lxr" name="lxr"></TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24 width="20%">电话</TD>
    <TD class=forumrow  height=24 align="left"><input type="text" id="tel" name="tel"></TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24 width="20%">地址</TD>
    <TD class=forumrow  height=24 align="left"><input type="text" id="addr" name="addr" size="50"></TD>
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
		if(f1.sname.value==""){
			alert("客户名称不能为空");
			return false;
		}if(f1.lxr.value==""){
			alert("联系不能为空");
			return false;
		}if(f1.tel.value==""){
			alert("电话不能为空");
			return false;
		}if(f1.addr.value==""){
			alert("地址不能为空");
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
location.replace("/hysupermarketjxcsys/admin/customers.jsp");
 <%}%>
</script>
<%=Info.tform(map)%>