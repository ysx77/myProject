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
<form action="admin/suppliers.jsp?f=f" method="post">
	<%
	 String sql = "select * from suppliers where 1=1 and delstatus='0' and type='供应商'";
	 String url = "/hysupermarketjxcsys/admin/suppliers.jsp?1=1";
	 String key = request.getParameter("key")==null?"":request.getParameter("key");
	 String key1 = request.getParameter("key1")==null?"":request.getParameter("key1");
	 String f = request.getParameter("f");
	 if(f==null)
	 {
	 key = Info.getUTFStr(key);
	 }
	 if(!key.equals(""))
	 {
	 sql+=" and (sname like'%"+key+"%')";
	 url+="&key="+key;
	 }
	 sql+=" order by id desc";
%>
<TABLE cellSpacing=1 cellPadding=3 width="95%" align=center bgColor=#6ab6b6 
border=0>
  <TBODY>
  <TR>
    <TD  height=24>【供应商查询】</TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24 align="left">
    按供应商名称查询:<input type="text" id="key" name="key" value="<%=key %>">
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
    <TD  height=24>【供应商管理】</TD>
  	<TD  height=24 align="right" colspan="4"><a href="admin/supplieradd.jsp" target=frmright>【新增供应商】</a></TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24>供应商名称</TD>
    <TD class=forumrow  height=24>联系人</TD>
    <TD class=forumrow  height=24>电话</TD>
    <TD class=forumrow  height=24>地址</TD>
    <TD class=forumrow  height=24>操作</TD>
  </TR>
  <%String did = request.getParameter("did");
   if(did!=null)
   {
	   dao.commOper("update suppliers set delstatus='1' where id="+did);
   }
   PageManager pageManager = PageManager.getPage(url,10, request);
   pageManager.doList(sql);
   PageManager bean= (PageManager)request.getAttribute("page");
   ArrayList<HashMap> list=(ArrayList)bean.getCollection();
   	for(HashMap map:list){
	    %>
  <TR align=center>
    <TD class=forumrow  height=24><%=map.get("sname") %></TD>
    <TD class=forumrow  height=24><%=map.get("lxr") %></TD>
    <TD class=forumrow  height=24><%=map.get("tel") %></TD>
    <TD class=forumrow  height=24><%=map.get("addr") %></TD>
    <TD class=forumrow  height=24>
    <a href="admin/supplieredit.jsp?id=<%=map.get("id") %>">编辑</a>
    &nbsp;|&nbsp;
    <a href="admin/suppliers.jsp?did=<%=map.get("id") %>">删除</a>
    </TD>
  </TR>
  <%} %>
  <TR align=center>
    <TD class=forumrow  height=24 colspan="5">${page.info }</TD>
  </TR>
  
  </TBODY></TABLE>
  </body>
</html>
