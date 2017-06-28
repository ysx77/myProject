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
<form action="admin/suppliersjk.jsp?f=f" method="post">
	<%
	 String sql = "select * from cgdinfo where 1=1  ";
	 String url = "/hysupermarketjxcsys/admin/suppliersjk.jsp?1=1";
	 String key = request.getParameter("key")==null?"":request.getParameter("key");
	 String key1 = request.getParameter("key1")==null?"":request.getParameter("key1");
	 String key2 = request.getParameter("key2")==null?"":request.getParameter("key2");
	 String key3 = request.getParameter("key3")==null?"":request.getParameter("key3");
	 String key4 = request.getParameter("key4")==null?"":request.getParameter("key4");
	 String f = request.getParameter("f");
	 if(f==null)
	 {
	 key = Info.getUTFStr(key);
	 key3 = Info.getUTFStr(key3);
	 key4 = Info.getUTFStr(key4);
	 }
	 if(!key.equals(""))
	 {
	 sql+=" and (cgdno like'%"+key+"%')";
	 url+="&key="+key;
	 }if(!key1.equals(""))
	 {
		 sql+=" and (savetime >'"+key1+"')";
		 url+="&key1="+key1;
		 }
		 if(!key2.equals(""))
		 {
		 sql+=" and (savetime <='"+key2+"')";
		 url+="&key2="+key2;
		 }if(!key3.equals(""))
		 {
			 sql+=" and (status ='"+key3+"')";
			 url+="&key3="+key3;
			 }if(!key4.equals(""))
			 {
				 sql+=" and (isjk ='"+key4+"')";
				 url+="&key4="+key4;
				 }
	 sql+=" order by id desc";
%>
<TABLE cellSpacing=1 cellPadding=3 width="95%" align=center bgColor=#6ab6b6 
border=0>
  <TBODY>
  <TR>
    <TD  height=24>【采购单查询】</TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24 align="left">
    按单据编号查询:<input type="text" id="key" name="key" value="<%=key %>">&nbsp;
    日期区间:<input type="text" id="key1" name="key1" value="<%=key1 %>" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/>-
    <input type="text" id="key2" name="key2" value="<%=key2 %>" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/>
    &nbsp;
    到货状态：
    <select id="key3" name="key3">
    	<option value="">请选择</option>
    	<option value="未到货" <%if(key3.equals("未到货")){out.print("selected==selected");} %>>未到货</option>
    	<option value="已到货" <%if(key3.equals("已到货")){out.print("selected==selected");} %>>已到货</option>
    </select>
    &nbsp;
    结款状态：
    <select id="key4" name="key4">
    	<option value="">请选择</option>
    	<option value="未结款" <%if(key4.equals("未结款")){out.print("selected==selected");} %>>未结款</option>
    	<option value="已结款" <%if(key4.equals("已结款")){out.print("selected==selected");} %>>已结款</option>
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
    <TD  height=24>【采购单结款管理】</TD>
  	<TD  height=24 align="right" colspan="7"></TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24>单据编号</TD>
    <TD class=forumrow  height=24>采购商品</TD>
    <TD class=forumrow  height=24>数量</TD>
    <TD class=forumrow  height=24>进货单价</TD>
    <TD class=forumrow  height=24>单据总价</TD>
    <TD class=forumrow  height=24>供应商</TD>
    <TD class=forumrow  height=24>状态</TD>
    <TD class=forumrow  height=24>是否结款</TD>
    <TD class=forumrow  height=24>操作人</TD>
    <TD class=forumrow  height=24>创建日期</TD>
    <TD class=forumrow  height=24>操作</TD>
  </TR>
  <%String did = request.getParameter("did");
   if(did!=null)
   {
	   dao.commOper("delete from  cgdinfo  where id="+did);
   }
   
   String jkid = request.getParameter("jkid");
   if(jkid!=null)
   {
	   dao.commOper("update  cgdinfo set isjk='已结款'  where id="+jkid);
   }
   PageManager pageManager = PageManager.getPage(url,10, request);
   pageManager.doList(sql);
   PageManager bean= (PageManager)request.getAttribute("page");
   ArrayList<HashMap> list=(ArrayList)bean.getCollection();
   	for(HashMap map:list){
   		HashMap m = dao.select("select * from product where id="+map.get("pid")).get(0);
   		HashMap mm = dao.select("select * from suppliers where id="+map.get("suppliersid")).get(0);
   		HashMap mmm = dao.select("select * from sysuser where id="+map.get("oper")).get(0);
	    %>
  <TR align=center>
    <TD class=forumrow  height=24><%=map.get("cgdno") %></TD>
    <TD class=forumrow  height=24><%=m.get("pname") %></TD>
    <TD class=forumrow  height=24><%=map.get("num") %></TD>
    <TD class=forumrow  height=24><%=map.get("dprice") %>元</TD>
    <TD class=forumrow  height=24><%=map.get("tprice") %>元</TD>
    <TD class=forumrow  height=24><%=mm.get("sname") %></TD>
    <TD class=forumrow  height=24><%=map.get("status") %></TD>
    <TD class=forumrow  height=24><%=map.get("isjk") %></TD>
    <TD class=forumrow  height=24><%=mmm.get("realname") %></TD>
    <TD class=forumrow  height=24><%=map.get("savetime") %></TD>
    <TD class=forumrow  height=24>
    <%if(map.get("isjk").equals("未结款")){ %>
    <a href="admin/suppliersjk.jsp?jkid=<%=map.get("id") %>">结款</a>
    <!--  
    &nbsp;|&nbsp;
    <a href="admin/suppliersjk.jsp?did=<%=map.get("id") %>">删除</a>-->
    <%} %>
    </TD>
  </TR>
  <%} %>
  <TR align=center>
    <TD class=forumrow  height=24 colspan="11">${page.info }</TD>
  </TR>
  
  </TBODY></TABLE>
  </body>
</html>
