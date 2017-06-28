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
<form action="admin/sysuser.jsp?f=f" method="post">
	<%
	 String sql = "select * from sysuser where 1=1 and usertype not in('会员') and delstatus=0 ";
	 String url = "/hysupermarketjxcsys/admin/sysuser.jsp?1=1";
	 String key = request.getParameter("key")==null?"":request.getParameter("key");
	 String key1 = request.getParameter("key1")==null?"":request.getParameter("key1");
	 String f = request.getParameter("f");
	 if(f==null)
	 {
	 key = Info.getUTFStr(key);
	 }
	 if(!key.equals(""))
	 {
	 sql+=" and (username like'%"+key+"%' or realname like'%"+key+"%')";
	 url+="&key="+key;
	 }
	 sql+=" order by id desc";
%>
<TABLE cellSpacing=1 cellPadding=3 width="95%" align=center bgColor=#6ab6b6 
border=0>
  <TBODY>
  <TR>
    <TD  height=24>【系统用户查询】</TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24 align="left">
    按用户名或姓名模糊查询:<input type="text" id="key" name="key" value="<%=key %>">
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
    <TD  height=24>【系统用户管理】</TD>
  	<TD  height=24 colspan="9" align="right"><a href="admin/sysuseradd.jsp" target=frmright>【添加系统用户】</a></TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24>用户类型</TD>
    <TD class=forumrow  height=24>登陆名</TD>
    <TD class=forumrow  height=24>登陆密码</TD>
    <TD class=forumrow  height=24>姓名</TD>
    <TD class=forumrow  height=24>性别</TD>
    <TD class=forumrow  height=24>身份证号</TD>
    <TD class=forumrow  height=24>联系电话</TD>
    <TD class=forumrow  height=24>email</TD>
    <TD class=forumrow  height=24>创建日期</TD>
    <TD class=forumrow  height=24>操作</TD>
  </TR>
  <%String did = request.getParameter("did");
   if(did!=null)
   {
dao.commOper("update sysuser set delstatus='1' where id="+did);
   }
   PageManager pageManager = PageManager.getPage(url,10, request);
   pageManager.doList(sql);
   PageManager bean= (PageManager)request.getAttribute("page");
   ArrayList<HashMap> list=(ArrayList)bean.getCollection();
   	for(HashMap map:list){
	    %>
  <TR align=center>
    <TD class=forumrow  height=24><%=map.get("usertype") %></TD>
    <TD class=forumrow  height=24><%=map.get("username") %></TD>
    <TD class=forumrow  height=24><%=map.get("userpwd") %></TD>
    <TD class=forumrow  height=24><%=map.get("realname") %></TD>
    <TD class=forumrow  height=24><%=map.get("sex") %></TD>
    <TD class=forumrow  height=24><%=map.get("idcard") %></TD>
    <TD class=forumrow  height=24><%=map.get("tel") %></TD>
    <TD class=forumrow  height=24><%=map.get("email") %></TD>
    <TD class=forumrow  height=24><%=map.get("savetime") %></TD>
    <TD class=forumrow  height=24>
    <a href="admin/sysuseredit.jsp?id=<%=map.get("id") %>">编辑</a>
    &nbsp;|&nbsp;
    <a href="admin/sysuser.jsp?did=<%=map.get("id") %>">删除</a>
    </TD>
  </TR>
  <%} %>
  <TR align=center>
    <TD class=forumrow  height=24 colspan="10">${page.info }</TD>
  </TR>
  
  </TBODY></TABLE>
  </body>
</html>
