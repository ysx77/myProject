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
  <body>
    <BR>
    <%String pid = request.getParameter("pid"); %>
  <form action="/hysupermarketjxcsys/hysupermarketjxcsys?ac=kcout&type=out" name="f1" method="post" onsubmit="return ck()">
  <input type="hidden" id="pid" name="pid" value="<%=pid %>" >
<TABLE cellSpacing=1 cellPadding=3 width="95%" align=center bgColor=#6ab6b6 
border=0>
  <TBODY>
  <TR>
    <TD  height=24>【商品出库】</TD>
  	<TD  height=24  align="right"></TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24 width="20%">数量</TD>
    <TD class=forumrow  height=24 align="left"><input type="text" id="num" name="num"></TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24 width="20%">事由</TD>
    <TD class=forumrow  height=24 align="left">
    	<input type="text" id="reason" name="reason">
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
		var reg=/^([1-9]\d*)$/;
		if(f1.num.value==""){
			alert("数量不能为空");
			return false;
		}else if(reg.test(f1.num.value)==false){
			alert("请输入正整数");
			return false;
		}if(f1.reason.value==""){
			alert("事由不能为空");
			return false;
		}
	}
<%
String suc = (String)request.getAttribute("suc");
String no = (String)request.getAttribute("no");
if(no!=null)
{
 %>
 alert("出库数量不能大于总库存量");
 <%}
if(suc!=null)
{
 %>
 alert("操作成功");
location.replace("/hysupermarketjxcsys/admin/kcmanage.jsp");
 <%}%>
</script>
