<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="util.Info"%>
<%@page import="dao.CommDAO"%>
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
  HashMap map = dao.select("select * from siteinfo where id=1").get(0);
  %>
  <body>
    <BR>
  <form action="/hysupermarketjxcsys/hysupermarketjxcsys?ac=siteinfoedit&id=1" name="f1" method="post" onsubmit="return ck()"  enctype="multipart/form-data">
<TABLE cellSpacing=1 cellPadding=3 width="95%" align=center bgColor=#6ab6b6 
border=0>
  <TBODY>
  <TR>
    <TD  height=24>【网站基本信息维护】</TD>
  	<TD  height=24 colspan="2" align="right"></TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24 width="20%">客服电话</TD>
    <TD class=forumrow  height=24 align="left"><input type="text" id="tel" name="tel" value="<%=map.get("tel")%>"></TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24 width="20%">联系地址</TD>
    <TD class=forumrow  height=24 align="left"><input type="text" id="addr" name="addr" size="50" value="<%=map.get("addr")%>"></TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24>网站LOGO</TD>
    <TD class=forumrow  height=24 align="left"><input type="file" id="img" name="img"></TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24>网站简介</TD>
    <TD class=forumrow  height=24 align="left"><textarea rows="" cols="" id="note" name="note"><%=map.get("note") %></textarea> </TD>
  </TR>
  <TR align=center>
	<TD class=forumrow  height=24 colspan="2">
		<input type="submit" value="提交" class="button blue small"/>
		<input type="reset" value="重置" class="button blue small"/>
	</TD>
  </TR>
  <script  language=javascript src="/hysupermarketjxcsys/fckeditor/fckeditor.js"></script>
  </TBODY></TABLE>
  </body>
</html>
<script type="text/javascript">
function window.onload() { 

var of = new FCKeditor("note");
of.BasePath="/hysupermarketjxcsys/fckeditor/";
of.Height = "300";
of.ToolbarSet="Default";
of.ReplaceTextarea();

if(top.location != self.location){ 

var a = window.parent.document.getElementsByTagName('iframe'); 

for (var i=0; i<a.length; i++){ 

if (a[i].name == self.name) {a[i].height = document.body.scrollHeight+150; return;}}} 

}
	function ck(){
		if(f1.tel.value==""){
			alert("客服电话不能为空");
			return false;
		}if(f1.addr.value==""){
			alert("联系地址不能为空");
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
location.replace("/hysupermarketjxcsys/admin/siteinfo.jsp");
 <%}%>
</script>
