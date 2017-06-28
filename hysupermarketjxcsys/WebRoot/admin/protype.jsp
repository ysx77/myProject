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
<form action="admin/protype.jsp?f=f" method="post">
	<%
	 String sql = "select * from protype where 1=1 and delstatus='0' and fatherid='0' ";
	 String url = "/hysupermarketjxcsys/admin/protype.jsp?1=1";
	 String key = request.getParameter("key")==null?"":request.getParameter("key");
	 String key1 = request.getParameter("key1")==null?"":request.getParameter("key1");
	 String f = request.getParameter("f");
	 if(f==null)
	 {
	 key = Info.getUTFStr(key);
	 }
	 if(!key.equals(""))
	 {
	 sql+=" and (typenamename like'%"+key+"%')";
	 url+="&key="+key;
	 }
	 sql+=" order by id desc";
%>
<TABLE cellSpacing=1 cellPadding=3 width="95%" align=center bgColor=#6ab6b6 
border=0>
  <TBODY>
  <TR>
    <TD  height=24>【类别查询】</TD>
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
    <TD  height=24>【类别管理】</TD>
  	<TD  height=24  align="right"><a href="admin/protypeadd.jsp?fatherid=0" target=frmright>【新增父类别】</a></TD>
  </TR>
  <TR align=center>
    <TD class=forumrow width="20%" height=24>父类</TD>
    <TD class=forumrow  height=24>子类</TD>
  </TR>
  <%String did = request.getParameter("did");
   if(did!=null)
   {
dao.commOper("update protype set delstatus='1' where id="+did);
   }
   PageManager pageManager = PageManager.getPage(url,10, request);
   pageManager.doList(sql);
   PageManager bean= (PageManager)request.getAttribute("page");
   ArrayList<HashMap> list=(ArrayList)bean.getCollection();
   	for(HashMap map:list){
	    %>
  <TR align=center>
    <TD class=forumrow  height=24><%=map.get("typename") %>&nbsp;&nbsp;&nbsp;
    [<a href="admin/protypeedit.jsp?id=<%=map.get("id") %>"><img src="images/037.gif" width="9" height="9" border="0"/></a>
    &nbsp;
    <a href="admin/protype.jsp?did=<%=map.get("id") %>"><img src="images/010.gif" width="9" height="9" border="0"/></a>
    ]
    </TD>
    <TD class=forumrow  height=24 align="left">
    <a href="admin/protypeadd.jsp?fatherid=<%=map.get("id") %>"><img src="images/001.gif" width="11" height="11" border="0"/></a>
    &nbsp;&nbsp;
    <%ArrayList<HashMap> sonlist = (ArrayList<HashMap>)dao.select("select * from protype where delstatus='0' and fatherid="+map.get("id")); 
    for(HashMap sonmap:sonlist){%>
    <%=sonmap.get("typename") %> [<a href="admin/protypeedit.jsp?id=<%=sonmap.get("id") %>"><img src="images/037.gif" width="9" height="9" border="0"/></a>&nbsp;
    <a href="admin/protype.jsp?did=<%=sonmap.get("id") %>"><img src="images/010.gif" width="9" height="9" border="0"/></a>]&nbsp;&nbsp;&nbsp;
    <%} %>
    </TD>
  </TR>
  <%} %>
  <TR align=center>
    <TD class=forumrow  height=24 colspan="2">${page.info }</TD>
  </TR>
  
  </TBODY></TABLE>
  </body>
</html>
