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
<form action="admin/xstj.jsp?f=f" method="post">
	<%
	 String sql = "select * from xsdinfo where 1=1 and status='已出货' ";
	 String url = "/hysupermarketjxcsys/admin/xstj.jsp?1=1";
	 String key = request.getParameter("key")==null?"":request.getParameter("key");
	 String key1 = request.getParameter("key1")==null?"":request.getParameter("key1");
	 String key2 = request.getParameter("key2")==null?"":request.getParameter("key2");
	 String key3 = request.getParameter("key3")==null?"":request.getParameter("key3");
	 String f = request.getParameter("f");
	 if(f==null)
	 {
	 key = Info.getUTFStr(key);
	 key3 = Info.getUTFStr(key3);
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
			 }
	 sql+=" order by id desc";
%>
<TABLE cellSpacing=1 cellPadding=3 width="95%" align=center bgColor=#6ab6b6 
border=0>
  <TBODY>
  <TR>
    <TD  height=24>【条件查询】</TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24 align="left">
    日期区间:<input type="text" id="key1" name="key1" value="<%=key1 %>" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/>-
    <input type="text" id="key2" name="key2" value="<%=key2 %>" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/>
    &nbsp;
    <script type="text/javascript" src="/hysupermarketjxcsys/commfiles/js/calendar/WdatePicker.js"></script>
    <input type="submit" value="查询" class="button blue small">
    </TD>
  </TR>
</TBODY>
</TABLE>
</form>
<%ArrayList<HashMap> aaalist = (ArrayList<HashMap>)dao.select(sql);
double ppp = 0.0;
for(HashMap aaammm:aaalist){
	ppp+=Double.valueOf(aaammm.get("tprice").toString());
}
%>

<TABLE cellSpacing=1 cellPadding=3 width="95%" align=center bgColor=#6ab6b6 
border=0>
  <TBODY>
  <TR>
    <TD  height=24>【销售统计】</TD>
  	<TD  height=24 align="right" colspan="6">【销售总金额：<%=ppp %>元】</TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24>单据编号</TD>
    <TD class=forumrow  height=24>商品信息</TD>
    <TD class=forumrow  height=24>总金额</TD>
    <TD class=forumrow  height=24>备注</TD>
    <TD class=forumrow  height=24>状态</TD>
    <TD class=forumrow  height=24>操作人</TD>
    <TD class=forumrow  height=24>创建日期</TD>
  </TR>
  <%String did = request.getParameter("did");
   if(did!=null)
   {
	   dao.commOper("delete from  xsdinfo  where id="+did);
   }

   PageManager pageManager = PageManager.getPage(url,10, request);
   pageManager.doList(sql);
   PageManager bean= (PageManager)request.getAttribute("page");
   ArrayList<HashMap> list=(ArrayList)bean.getCollection();
   	for(HashMap map:list){
   		HashMap mmm = dao.select("select * from sysuser where id="+map.get("oper")).get(0);
	    %>
  <TR align=center>
    <TD class=forumrow  height=24><%=map.get("xsdno") %></TD>
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
    <TD class=forumrow  height=24><%=mmm.get("realname") %></TD>
    <TD class=forumrow  height=24><%=map.get("savetime") %></TD>

  </TR>
  <%} %>
  <TR align=center>
    <TD class=forumrow  height=24 colspan="9">${page.info }</TD>
  </TR>
  
  </TBODY></TABLE>
  </body>
</html>
