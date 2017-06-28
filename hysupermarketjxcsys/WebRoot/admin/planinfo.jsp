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
<form action="admin/planinfo.jsp?f=f" method="post">
	<%
	 String sql = "select * from planinfo where 1=1  ";
	 String url = "/hysupermarketjxcsys/admin/planinfo.jsp?1=1";
	 String key = request.getParameter("key")==null?"":request.getParameter("key");
	 String key1 = request.getParameter("key1")==null?"":request.getParameter("key1");
	 String f = request.getParameter("f");
	 if(f==null)
	 {
	 key = Info.getUTFStr(key);
	 }
	 if(!key.equals(""))
	 {
	 sql+=" and (uid ='"+key+"')";
	 url+="&key="+key;
	 }
	 if(!key1.equals(""))
	 {
	 sql+=" and (plandate ='"+key1+"')";
	 url+="&key1="+key1;
	 }
	 sql+=" order by id desc";
%>
<TABLE cellSpacing=1 cellPadding=3 width="95%" align=center bgColor=#6ab6b6 
border=0>
  <TBODY>
  <TR>
    <TD  height=24>【销售计划查询】</TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24 align="left">
    按销售人员查询:
    <select id="key" name="key">
    	<option value="">请选择</option>
    	<%ArrayList<HashMap> keylist = (ArrayList<HashMap>)dao.select("select * from sysuser where usertype='销售'"); 
    	for(HashMap m:keylist){%>
    	<option value="<%=m.get("id") %>" <%if(key.equals(m.get("id"))){out.print("selected==selected");} %>><%=m.get("realname") %></option>
    	<%} %>
    </select>&nbsp;
    年月份:
    <input type="text" id="key1" name="key1" value="<%=key1 %>" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM'});">
    <script type="text/javascript" src="/hysupermarketjxcsys/commfiles/js/calendar/WdatePicker.js"></script>
    &nbsp;<input type="submit" value="查询" class="button blue small">
    </TD>
  </TR>
</TBODY>
</TABLE>
</form>

<TABLE cellSpacing=1 cellPadding=3 width="95%" align=center bgColor=#6ab6b6 
border=0>
  <TBODY>
  <TR>
    <TD  height=24>【销售计划管理】</TD>
  	<TD  height=24 align="right" colspan="4"><a href="admin/planadd.jsp" target=frmright>【新增销售计划】</a></TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24>销售人员</TD>
    <TD class=forumrow  height=24>年月份</TD>
    <TD class=forumrow  height=24>计划金额</TD>
    <TD class=forumrow  height=24>完成金额(元)</TD>
    <TD class=forumrow  height=24>操作</TD>
  </TR>
  <%String did = request.getParameter("did");
   if(did!=null)
   {
	   dao.commOper("delete from  planinfo where id="+did);
   }
   PageManager pageManager = PageManager.getPage(url,10, request);
   pageManager.doList(sql);
   PageManager bean= (PageManager)request.getAttribute("page");
   ArrayList<HashMap> list=(ArrayList)bean.getCollection();
   	for(HashMap map:list){
   		HashMap mm = dao.select("select * from sysuser where id="+map.get("uid")).get(0);
	    %>
  <TR align=center>
    <TD class=forumrow  height=24><%=mm.get("realname") %></TD>
    <TD class=forumrow  height=24><%=map.get("plandate") %></TD>
    <TD class=forumrow  height=24><%=map.get("planmoney") %>元</TD>
    <TD class=forumrow  height=24>
    
    <%
    HashMap mmm = dao.select("select sum(tprice) as tmoney from xsdinfo where oper='"+map.get("uid")+"' and isfk='已结账' and date_format(savetime,'%Y-%m')='"+map.get("plandate")+"' ").get(0); 
    %>
    <%=mmm.get("tmoney") %>
    </TD>
    <TD class=forumrow  height=24>
    <a href="admin/planedit.jsp?id=<%=map.get("id") %>">编辑</a>
    &nbsp;|&nbsp;
    <a href="admin/planinfo.jsp?did=<%=map.get("id") %>">删除</a>
    </TD>
  </TR>
  <%} %>
  <TR align=center>
    <TD class=forumrow  height=24 colspan="5">${page.info }</TD>
  </TR>
  
  </TBODY></TABLE>
  </body>
</html>
