<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="dao.CommDAO"%>
<%@page import="util.Info"%>
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
  HashMap map = dao.select("select * from planinfo where id="+id).get(0);
  %>
  <form action="/hysupermarketjxcsys/hysupermarketjxcsys?ac=planedit&id=<%=id %>" name="f1" method="post" onsubmit="return ck()" >
<TABLE cellSpacing=1 cellPadding=3 width="95%" align=center bgColor=#6ab6b6 
border=0>
  <TBODY>
  <TR>
    <TD  height=24>【新增销售计划】</TD>
  	<TD  height=24 colspan="2" align="right"><a href="admin/planinfo.jsp" target=frmright>返回上一层</a></TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24 width="20%">销售人员</TD>
    <TD class=forumrow  height=24 align="left">
	    	<%HashMap m = dao.select("select * from sysuser where id="+map.get("id")).get(0); %>
	    	<%=m.get("realname") %>
    </TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24 width="20%">年月份</TD>
    <TD class=forumrow  height=24 align="left">
    	<%=map.get("plandate") %>
    </TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24 width="20%">计划金额</TD>
    <TD class=forumrow  height=24 align="left">
    	<input type="text" id="planmoney" name="planmoney" onkeyup='checkDecimal(this)'>元
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
	var record={ 
	num:"" 
	} 
	var checkDecimal=function(n){ 
	var decimalReg=/^\d{0,8}\.{0,1}(\d{1,2})?$/;//var decimalReg=/^[-\+]?\d{0,8}\.{0,1}(\d{1,2})?$/; 
	if(n.value!=""&&decimalReg.test(n.value)){ 
	record.num=n.value; 
	}else{ 
	if(n.value!=""){ 
	n.value=record.num; 
	} 
	} 
	} 
	function ck(){
		if(f1.planmoney.value==""){
			alert("计划金额不能为空");
			return false;
		}
	}
<%
String suc = (String)request.getAttribute("suc");
String no = (String)request.getAttribute("no");
if(no!=null)
{
 %>
 alert("该销售人员此月的计划已录入，不能重复录入");
 <%}
if(suc!=null)
{
 %>
 alert("操作成功");
location.replace("/hysupermarketjxcsys/admin/planinfo.jsp");
 <%}%>
</script>
<%=Info.tform(map)%>