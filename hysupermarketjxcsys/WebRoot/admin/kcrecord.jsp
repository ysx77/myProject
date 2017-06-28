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
<form action="admin/kcrecord.jsp?f=f" method="post">
	<%
	 String sql = "select * from kcrecord where 1=1 ";
	 String url = "/hysupermarketjxcsys/admin/kcrecord.jsp?1=1";
	 String key = request.getParameter("key")==null?"":request.getParameter("key");
	 String key1 = request.getParameter("key1")==null?"":request.getParameter("key1");
	 String key2 = request.getParameter("key2")==null?"":request.getParameter("key2");
	 String f = request.getParameter("f");
	 if(f==null)
	 {
	 key = Info.getUTFStr(key);
	 key1 = Info.getUTFStr(key1);
	 }
	 if(!key.equals(""))
	 {
	 sql+=" and (savetime >'"+key+"')";
	 url+="&key="+key;
	 }
	 if(!key1.equals(""))
	 {
	 sql+=" and (savetime <='"+key1+"')";
	 url+="&key1="+key1;
	 }
	 if(!key2.equals(""))
	 {
	 sql+=" and (type ='"+key2+"')";
	 url+="&key2="+key2;
	 }
	 sql+=" order by id desc";
%>
<TABLE cellSpacing=1 cellPadding=3 width="95%" align=center bgColor=#6ab6b6 
border=0>
  <TBODY>
  <TR>
    <TD  height=24>【库存记录查询】</TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24 align="left">
    按日期区间查询:<input type="text" id="key" name="key" value="<%=key %>" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/>-
    <input type="text" id="key1" name="key1" value="<%=key1 %>" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/>
    &nbsp;
    类型：
    <select id="key2" name="key2">
    	<option value="">请选择</option>
    	<option value="in">入库</option>
    	<option value="out">出库</option>
    </select>
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
    <TD  height=24>【库存记录管理】</TD>
  	<TD  height=24 colspan="5" align="right"><a href="admin/yqlinkadd.jsp" target=frmright></a></TD>
  </TR>
  <TR align=center>
    <TD class=forumrow width="15%"  height=24>商品编号</TD>
    <TD class=forumrow width="20%" height=24>商品名称</TD>
    <TD class=forumrow width="10%" height=24>发生数量</TD>
    <TD class=forumrow width="5%" height=24>类型</TD>
    <TD class=forumrow  height=24>事由</TD>
    <TD class=forumrow width="15%" height=24>事件日期</TD>
  </TR>
  <%
   PageManager pageManager = PageManager.getPage(url,10, request);
   pageManager.doList(sql);
   PageManager bean= (PageManager)request.getAttribute("page");
   ArrayList<HashMap> list=(ArrayList)bean.getCollection();
   
   
   for(HashMap map:list){
	   ArrayList<HashMap> cklist = (ArrayList<HashMap>)dao.select("select * from product where id="+map.get("pid")+"");
	   if(cklist.size()>0){	
	   HashMap m = cklist.get(0);
	    %>
  <TR align=center>
    <TD class=forumrow  height=24><%=m.get("pno") %></TD>
    <TD class=forumrow  height=24><%=m.get("pname") %></TD>
    <TD class=forumrow  height=24><%=map.get("num") %></TD>
    <TD class=forumrow  height=24><%=map.get("type").equals("in")?"入库":"出库" %></TD>
    <TD class=forumrow  height=24><%=map.get("reason") %></TD>
    <TD class=forumrow  height=24><%=map.get("savetime") %></TD>
  </TR>
  <%} }%>
  <TR align=center>
    <TD class=forumrow  height=24 colspan="6">${page.info }</TD>
  </TR>
  
  </TBODY></TABLE>
  </body>
</html>
