<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="dao.CommDAO"%>
<%@page import="util.Info"%>
<%@page import="util.PageManager"%>
<%@page import="java.text.DecimalFormat"%>
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
<form action="admin/customerjk.jsp?f=f" method="post">
	<%
	 String sql = "select * from xsdinfo where 1=1  ";
	 String url = "/hysupermarketjxcsys/admin/customerjk.jsp?1=1";
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
	 sql+=" and (xsdno like'%"+key+"%')";
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
				 sql+=" and (isfk ='"+key4+"')";
				 url+="&key4="+key4;
				 }
	 sql+=" order by id desc";
%>
<TABLE cellSpacing=1 cellPadding=3 width="95%" align=center bgColor=#6ab6b6 
border=0>
  <TBODY>
  <TR>
    <TD  height=24>【销售单查询】</TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24 align="left">
    按单据编号查询:<input type="text" id="key" name="key" value="<%=key %>">&nbsp;
    日期区间:<input type="text" id="key1" name="key1" value="<%=key1 %>" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/>-
    <input type="text" id="key2" name="key2" value="<%=key2 %>" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/>
    &nbsp;
    出货状态：
    <select id="key3" name="key3">
    	<option value="">请选择</option>
    	<option value="未出货" <%if(key3.equals("未出货")){out.print("selected==selected");} %>>未出货</option>
    	<option value="已出货" <%if(key3.equals("已出货")){out.print("selected==selected");} %>>已出货</option>
    </select>
    结账状态：
    <select id="key4" name="key4">
    	<option value="">请选择</option>
    	<option value="未结账" <%if(key4.equals("未结账")){out.print("selected==selected");} %>>未结账</option>
    	<option value="已结账" <%if(key4.equals("已结账")){out.print("selected==selected");} %>>已结账</option>
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
    <TD  height=24>【销售单结账管理】</TD>
  	<TD  height=24 align="right" colspan="7"></TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24>单据编号</TD>
    <TD class=forumrow  height=24>客户</TD>
    <TD class=forumrow  height=24>商品信息</TD>
    <TD class=forumrow  height=24>总金额</TD>
    <TD class=forumrow  height=24>备注</TD>
    <TD class=forumrow  height=24>出货状态</TD>
    <TD class=forumrow  height=24>结账状态</TD>
    <TD class=forumrow  height=24>操作人</TD>
    <TD class=forumrow  height=24>创建日期</TD>
    <TD class=forumrow  height=24>操作</TD>
  </TR>
  <%String jzid = request.getParameter("jzid");
   if(jzid!=null)
   {
	   dao.commOper("update   xsdinfo set isfk='已结账' where id="+jzid);
   }

   PageManager pageManager = PageManager.getPage(url,10, request);
   pageManager.doList(sql);
   PageManager bean= (PageManager)request.getAttribute("page");
   ArrayList<HashMap> list=(ArrayList)bean.getCollection();
   	for(HashMap map:list){
   		HashMap mm = dao.select("select * from suppliers where id="+map.get("customerid")).get(0);
   		HashMap mmm = dao.select("select * from sysuser where id="+map.get("oper")).get(0);
	    %>
  <TR align=center>
    <TD class=forumrow  height=24><%=map.get("xsdno") %></TD>
    <TD class=forumrow  height=24><%=mm.get("sname") %></TD>
    <TD class=forumrow  height=24 align="left">
    <%String pinfo = map.get("pinfo").toString();
		String numinfo = map.get("numinfo").toString();
		String yinfo = "";
		String a[] = pinfo.split("\\$");
		String b[] = numinfo.split("\\$");
		Double totalprice1 = 0.0;
		String totalprice = "";;
		DecimalFormat decimal = new DecimalFormat("#.#");
		for(int i=0;i<a.length;i++){
			HashMap am = dao.select("select * from product where id='"+a[i]+"'").get(0);
			yinfo += am.get("pname")+"&nbsp;&nbsp;单价："+am.get("price")+"元&nbsp;&nbsp;数量:"+b[i]+"<br/>";
		}
		%>
		<%=yinfo %>
    </TD>
    <TD class=forumrow  height=24><%=map.get("tprice") %>元</TD>
    <TD class=forumrow  height=24><%=map.get("remark") %></TD>
    <TD class=forumrow  height=24><%=map.get("status") %></TD>
    <TD class=forumrow  height=24><%=map.get("isfk") %></TD>
    <TD class=forumrow  height=24><%=mmm.get("realname") %></TD>
    <TD class=forumrow  height=24><%=map.get("savetime") %></TD>
    <TD class=forumrow  height=24>
    <%if(map.get("status").equals("已出货")&&map.get("isfk").equals("未结账")){ %>
    	<a href="admin/customerjk.jsp?jzid=<%=map.get("id") %>">结账</a>
    <%} %>
    
    </TD>
  </TR>
  <%} %>
  <TR align=center>
    <TD class=forumrow  height=24 colspan="10">${page.info }</TD>
  </TR>
  
  </TBODY></TABLE>
  </body>
</html>
