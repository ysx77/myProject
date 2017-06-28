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
<form action="admin/gqproductck.jsp?f=f" method="post">
	<%
	 String sql = "select * from gqproduct where 1=1  ";
	 String url = "/hysupermarketjxcsys/admin/gqproductck.jsp?1=1";
	 String key = request.getParameter("key")==null?"":request.getParameter("key");
	 String key1 = request.getParameter("key1")==null?"":request.getParameter("key1");
	 String f = request.getParameter("f");
	 if(f==null)
	 {
	 key = Info.getUTFStr(key);
	 key1 = Info.getUTFStr(key1);
	 }
	 if(!key.equals(""))
	 {
	 sql+=" and (pid ='"+key+"')";
	 url+="&key="+key;
	 }
	 if(!key1.equals(""))
	 {
	 sql+=" and (status ='"+key1+"')";
	 url+="&key1="+key1;
	 }
	 sql+=" order by id desc";
%>
<TABLE cellSpacing=1 cellPadding=3 width="95%" align=center bgColor=#6ab6b6 
border=0>
  <TBODY>
  <TR>
    <TD  height=24>【过期商品查询】</TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24 align="left">
    按商品查询:
    <select id="key" name="key">
    	<option value="">请选择</option>
    	<%ArrayList<HashMap> keylist = (ArrayList<HashMap>)dao.select("select * from product where delstatus='0' order by id desc");
    	for(HashMap keymap:keylist){%>
    	<option value="<%=keymap.get("id") %>" <%if(keymap.get("id").equals(key)){out.print("selected==selected"); }%>><%=keymap.get("pname") %></option>
    	<%} %>
    </select>&nbsp;
    状态:
    <select id="key1" name="key1">
    	<option value="">请选择</option>
    	<option value="未退货" <%if(key1.equals("未退货")){out.print("selected==selected");} %>>未退货</option>
    	<option value="已退货" <%if(key1.equals("已退货")){out.print("selected==selected");} %>>已退货</option>
    </select>
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
    <TD  height=24>【过期商品管理】</TD>
  	<TD  height=24 align="right" colspan="5"></TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24>商品名称</TD>
    <TD class=forumrow  height=24>退货数量</TD>
    <TD class=forumrow  height=24>状态</TD>
    <TD class=forumrow  height=24>操作人</TD>
    <TD class=forumrow  height=24>创建日期</TD>
    <TD class=forumrow  height=24>操作</TD>
  </TR>
  <%String did = request.getParameter("did");
   if(did!=null)
   {
	   dao.commOper("delete from  gqproduct  where id="+did);
   }
   PageManager pageManager = PageManager.getPage(url,10, request);
   pageManager.doList(sql);
   PageManager bean= (PageManager)request.getAttribute("page");
   ArrayList<HashMap> list=(ArrayList)bean.getCollection();
   if(list.size()>0){
   	for(HashMap map:list){
   		HashMap m = dao.select("select * from product where id="+map.get("pid")).get(0);
   		HashMap mm = dao.select("select * from sysuser where id="+map.get("oper")).get(0);
	    %>
  <TR align=center>
    <TD class=forumrow  height=24><%=m.get("pname") %>
    <font color="red">(库存量:<%=Info.getkc(map.get("pid").toString()) %>)</font>
    </TD>
    <TD class=forumrow  height=24><%=map.get("num") %></TD>
    <TD class=forumrow  height=24><%=map.get("status") %></TD>
    <TD class=forumrow  height=24><%=mm.get("realname") %></TD>
    <TD class=forumrow  height=24><%=map.get("savetime") %></TD>
    <TD class=forumrow  height=24>
    <%if(map.get("status").equals("未退货")){ %>
    <a href="/hysupermarketjxcsys/hysupermarketjxcsys?ac=gqth&id=<%=map.get("id") %>">退货</a>
    &nbsp;|&nbsp;
    <a href="admin/gqproductck.jsp?did=<%=map.get("id") %>">撤销</a>
    <%} %>
    </TD>
  </TR>
  <%} }%>
  <TR align=center>
    <TD class=forumrow  height=24 colspan="6">${page.info }</TD>
  </TR>
  
  </TBODY></TABLE>
  </body>
  <script type="text/javascript">
  <%String no = (String)request.getAttribute("no");
  if(no!=null)
 {
 %>
 alert("退库数量大于商品的总库存");
 <%}%>
  </script>
</html>

