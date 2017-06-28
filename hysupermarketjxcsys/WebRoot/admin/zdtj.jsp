<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="dao.CommDAO"%>
<%@page import="util.Info"%>
<%@page import="util.PageManager"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%CommDAO dao = new CommDAO(); 
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title></title>
    
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
<SCRIPT language=javascript src="syscome.files/mhsearch.js"></SCRIPT>

<STYLE type=text/css>.STYLE1 {
	FONT-WEIGHT: bold; COLOR: #0099ff
}
</STYLE>
  </head>
  
  <body>
<form action="admin/zdtj.jsp?f=f" method="post">
	<%
	 String url = "/hysupermarketjxcsys/admin/zdtj.jsp?1=1";
	 String key = request.getParameter("key")==null?"":request.getParameter("key");
	 String key1 = request.getParameter("key1")==null?"":request.getParameter("key1");
	 String f = request.getParameter("f");
	 if(f==null)
	 {
	 key = Info.getUTFStr(key);
	 key1 = Info.getUTFStr(key1);
	 }
%>
<TABLE cellSpacing=1 cellPadding=3 width="95%" align=center bgColor=#6ab6b6 
border=0>
  <TBODY>
  <TR>
    <TD  height=24>【帐单统计查询】</TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24 align="left">
    按日期区间查询:<input type="text" id="key" name="key" value="<%=key %>" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/>-
    <input type="text" id="key1" name="key1" value="<%=key1 %>" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/>
    <script type="text/javascript" src="/hysupermarketjxcsys/commfiles/js/calendar/WdatePicker.js"></script>
    <input type="submit" value="查询" class="button blue small">
    </TD>
  </TR>
</TBODY>
</TABLE>
</form>

<TABLE cellSpacing=1 cellPadding=3 width="95%" align=center bgColor=#6ab6b6 
border=0>
  <TBODY>
  <TR>
    <TD  height=24>【应付款】</TD>
  	<TD  height=24  align="right"><a href="admin/yqlinkadd.jsp" target=frmright></a></TD>
  </TR>
  <TR align=center>
    <TD class=forumrow width="20%" height=24 colspan="2">应付总金额(元)</TD>
  </TR>
  
  <TR align=center>
    <TD class=forumrow  height=24 colspan="2">
	<%String sql2 = "select sum(tprice) as fmoney from cgdinfo where status='已到货' and isjk='未结款' "; 
    if(!key.equals(""))
	 {
	 sql2+=" and (savetime >'"+key+"')";
	 }if(!key1.equals(""))
	 {
		 sql2+=" and (savetime <='"+key1+"')";
		 }
	HashMap m2 = dao.select(sql2).get(0);
	%>
	<%=m2.get("fmoney") %>
	</TD>
    
  </TR>
  
  
  </TBODY></TABLE>
  </body>
</html>
