<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="dao.CommDAO"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'list.jsp' starting page</title>
    
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
    <BR>
  <%CommDAO dao = new CommDAO(); 
  String id = request.getParameter("id");
  HashMap map = dao.select("select * from gqproduct where id="+id).get(0);
  %>
  <form action="/hysupermarketjxcsys/hysupermarketjxcsys?ac=gqproductedit&id=<%=id %>" name="f1" method="post" onsubmit="return ck()" >
<TABLE cellSpacing=1 cellPadding=3 width="95%" align=center bgColor=#6ab6b6 
border=0>
  <TBODY>
  <TR>
    <TD  height=24>【编辑过期商品】</TD>
  	<TD  height=24 colspan="2" align="right"><a href="admin/gqproduct.jsp" target=frmright>返回上一层</a></TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24 width="20%">商品</TD>
    <TD class=forumrow  height=24 align="left">
    	<select id="pid" name="pid">
	    	<option value="">请选择</option>
	    	<%
	    	ArrayList<HashMap> keylist = (ArrayList<HashMap>)dao.select("select * from product where delstatus='0' order by id desc");
	    	for(HashMap keymap:keylist){%>
	    	<option value="<%=keymap.get("id") %>" <%if(keymap.get("id").equals(map.get("pid"))){out.print("selected==selected");} %>><%=keymap.get("pname") %></option>
	    	<%} %>
    	</select>
    </TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24 width="20%">数量</TD>
    <TD class=forumrow  height=24 align="left">
    	<input type="text" id="num" name="num" value="<%=map.get("num") %>">
    </TD>
  </TR>
  
  <TR align=center>
	<TD class=forumrow  height=24 colspan="2">
		<input type="submit" value="提交" class="button blue small"/>
		<input type="reset" value="重置" class="button blue small"/>
	</TD>
  </TR>
  </TBODY></TABLE>
  </body>
</html>
<script type="text/javascript">
	function ck(){
		var reg=/^([1-9]\d*)$/;
		if(f1.pid.value==""){
			alert("商品不能为空");
			return false;
		}
		if(f1.num.value==""){
			alert("数量不能为空");
			return false;
		}else if(reg.test(f1.num.value)==false){
			alert("数量必须为正整数");
			return false;
		}
	}
<%
String suc = (String)request.getAttribute("suc");
String no = (String)request.getAttribute("no");
if(no!=null)
{
 %>
 alert("输入的数量大于商品的总库存");
 <%}
if(suc!=null)
{
 %>
 alert("操作成功");
location.replace("/hysupermarketjxcsys/admin/gqproduct.jsp");
 <%}%>
</script>
