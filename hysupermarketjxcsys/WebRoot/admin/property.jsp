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

<STYLE type=text/css>.STYLE1 {
	FONT-WEIGHT: bold; COLOR: #0099ff
}
</STYLE>
  </head>
  
  <body>
<form action="admin/property.jsp?f=f" method="post">
	<%
	 String sql = "select * from property where 1=1 and delstatus='0' ";
	 String url = "/hysupermarketjxcsys/admin/property.jsp?1=1";
	 String key = request.getParameter("key")==null?"":request.getParameter("key");
	 String key1 = request.getParameter("key1")==null?"":request.getParameter("key1");
	 String f = request.getParameter("f");
	 if(f==null)
	 {
	 key = Info.getUTFStr(key);
	 }
	 if(!key.equals(""))
	 {
	 sql+=" and (propertyname like'%"+key+"%')";
	 url+="&key="+key;
	 }
	 sql+=" order by id desc";
%>
<TABLE cellSpacing=1 cellPadding=3 width="95%" align=center bgColor=#6ab6b6 
border=0>
  <TBODY>
  <TR>
    <TD  height=24>【属性查询】</TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24 align="left">
    按名称模糊查询:<input type="text" id="key" name="key" value="<%=key %>">
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
    <TD  height=24>【属性管理】</TD>
  	<TD  height=24 align="right"><a href="admin/propertyadd.jsp" target=frmright>【新增属性】</a></TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24>名称</TD>
    <TD class=forumrow  height=24>操作</TD>
  </TR>
  <%String did = request.getParameter("did");
   if(did!=null)
   {
	   dao.commOper("update property set delstatus='1' where id="+did);
   }
   PageManager pageManager = PageManager.getPage(url,10, request);
   pageManager.doList(sql);
   PageManager bean= (PageManager)request.getAttribute("page");
   ArrayList<HashMap> list=(ArrayList)bean.getCollection();
   	for(HashMap map:list){
	    %>
  <TR align=center>
    <TD class=forumrow  height=24><%=map.get("propertyname") %></TD>
    <TD class=forumrow  height=24>
    <a href="admin/propertyedit.jsp?id=<%=map.get("id") %>">编辑</a>
    &nbsp;|&nbsp;
    <a href="admin/property.jsp?did=<%=map.get("id") %>">删除</a>
    </TD>
  </TR>
  <%} %>
  <TR align=center>
    <TD class=forumrow  height=24 colspan="2">${page.info }</TD>
  </TR>
  
  </TBODY></TABLE>
  </body>
</html>
