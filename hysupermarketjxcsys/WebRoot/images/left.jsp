<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'left.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<LINK href="images/left.files/style_left.css" type=text/css rel=stylesheet>
  </head>
  
  <body>
    <TABLE height="100%" cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TBODY>
  <TR>
    <TD style="PADDING-TOP: 10px" vAlign=top>
      <TABLE class=alpha>
        <TBODY>
        <TR>
          <TD class=menu id=menubar vAlign=top>
            <LI><A href="admin/userinfo.jsp" 
            target=frmright>个人信息修改</A> </LI>
            </TD></TR></TBODY></TABLE></TD></TR>
  <TR>
    <TD class=copyright><A href="#" 
    target=_blank></A></TD></TR>
  <TR>
    <TD class=copyright><A href="#" 
      target=_blank></A></TD></TR></TBODY></TABLE>
  </body>
</html>
