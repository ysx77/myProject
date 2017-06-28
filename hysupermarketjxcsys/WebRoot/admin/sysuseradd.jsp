<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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
  <form action="/hysupermarketjxcsys/hysupermarketjxcsys?ac=sysuseradd" name="f1" method="post" onsubmit="return ck()" >
<TABLE cellSpacing=1 cellPadding=3 width="95%" align=center bgColor=#6ab6b6 
border=0>
  <TBODY>
  <TR>
    <TD  height=24>【添加系统用户】</TD>
  	<TD  height=24 colspan="2" align="right"><a href="admin/sysuser.jsp" target=frmright>返回上一层</a></TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24 width="20%">登陆名</TD>
    <TD class=forumrow  height=24 align="left"><input type="text" id="username" name="username" onBlur="checkname();">&nbsp;&nbsp;<span id="namets"></span></TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24>登陆密码</TD>
    <TD class=forumrow  height=24 align="left"><input type="password" id="userpwd" name="userpwd"></TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24>真实姓名</TD>
    <TD class=forumrow  height=24 align="left"><input type="text" id="realname" name="realname"></TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24>性别</TD>
    <TD class=forumrow  height=24 align="left">
    	<select id="sex" name="sex">
    		<option value="男">男</option>
    		<option value="女">女</option>
    	</select>
    </TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24>身份证</TD>
    <TD class=forumrow  height=24 align="left"><input type="text" id="idcard" name="idcard" size="30"></TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24>联系电话</TD>
    <TD class=forumrow  height=24 align="left"><input type="text" id="tel" name="tel"></TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24>email</TD>
    <TD class=forumrow  height=24 align="left"><input type="text" id="email" name="email"></TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24>家庭住址</TD>
    <TD class=forumrow  height=24 align="left"><input type="text" id="addr" name="addr" size="50"></TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24>用户角色</TD>
    <TD class=forumrow  height=24 align="left">
    	<select id="usertype" name="usertype">
    		<option value="">请选择</option>
    		<option value="采购">采购</option>
    		<option value="销售">销售</option>
    		<option value="仓库">仓库</option>
    		<option value="财务">财务</option>
    		<option value="管理员">管理员</option>
    	</select>
    </TD>
  </TR>
  <TR align=center>
	<TD class=forumrow  height=24 colspan="2">
		<input type="submit" value="提交" name="regsubmit" disabled="disabled" class="button blue small"/>
		<input type="reset" value="重置" class="button blue small"/>
	</TD>
  </TR>
  </TBODY></TABLE>
  </body>
</html>
<script type="text/javascript">
//定义一个变量用于存放XMLHttpRequest对象
	var xmlHttp; 
	//该函数用于创建一个XMLHttpRequest对象
	function createXMLHttpRequest() {
		if (window.ActiveXObject) {
			xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
		} 
		else if (window.XMLHttpRequest) {
			xmlHttp = new XMLHttpRequest();
		}
	}
		//这是一个启动AJAX异步通信的方法
	function checkname(){
	if(f1.username.value==""){
		alert("请输入登陆名");
		return false;
	}
		//创建一个XMLHttpRequest对象
		createXMLHttpRequest();
		//将状态触发器绑定到一个函数
		xmlHttp.onreadystatechange = processor;
		//通过GET方法向指定的URL建立服务器的调用
		xmlHttp.open("GET", "/hysupermarketjxcsys/hysupermarketjxcsys?ac=sysuserscheck&username="+f1.username.value+"&timeStamp="+new Date().getTime());
		//发送请求
		xmlHttp.send(null);
	}
	function processor (){
		//定义一个变量用于存放从服务器返回的响应结果
		var responseContext;
		if(xmlHttp.readyState == 4) 
		{ //如果响应完成
			if(xmlHttp.status == 200) 
			{//如果返回成功
				//取出服务器的响应内容
				responseContext = xmlHttp.responseText;
				//如果注册名检查有效
				if ( responseContext.indexOf("1") )
				{
					document.getElementById("namets").innerHTML="√";
					document.getElementById("namets").style.cssText="font-size:11px;color:green;";
					document.all.regsubmit.disabled=false;
				}
				else{
					document.getElementById("namets").innerHTML="×已存在的用户名";
					document.getElementById("namets").style.cssText="font-size:11px;color:red;";
					document.all.regsubmit.disabled=true;
				}
			}
		}
	}
	function InitAjax(){ 
　var ajax=false; 
　try { 
　　ajax = new ActiveXObject("Msxml2.XMLHTTP"); 
　} catch (e) { 
　　try { 
　　　ajax = new ActiveXObject("Microsoft.XMLHTTP"); 
　　} catch (E) { 
　　　ajax = false; 
　　} 
　} 
　if (!ajax && typeof XMLHttpRequest!='undefined') { 
　　ajax = new XMLHttpRequest(); 
　} 
　return ajax; 
} 

	function ck(){
		if(f1.username.value==""){
			alert("登陆名不能为空");
			return false;
		}if(f1.userpwd.value==""){
			alert("密码不能为空");
			return false;
		}if(f1.realname.value==""){
			alert("姓名不能为空");
			return false;
		}if(f1.idcard.value==""){
			alert("身份证不能为空");
			return false;
		}if(f1.tel.value==""){
			alert("联系电话不能为空");
			return false;
		}if(f1.email.value==""){
			alert("email不能为空");
			return false;
		}if(f1.addr.value==""){
			alert("住址不能为空");
			return false;
		}if(f1.usertype.value==""){
			alert("用户角色不能为空");
			return false;
		}
	}
<%
String suc = (String)request.getAttribute("suc");
String no = (String)request.getAttribute("no");
if(no!=null)
{
 %>
 alert("已存在的用户名");
 <%}
if(suc!=null)
{
 %>
 alert("操作成功");
location.replace("/hysupermarketjxcsys/admin/sysuser.jsp");
 <%}%>
</script>
