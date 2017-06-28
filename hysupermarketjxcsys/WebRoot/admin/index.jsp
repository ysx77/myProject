<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="dao.CommDAO"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%CommDAO dao = new CommDAO(); 
HashMap titlemap = dao.select("select * from siteinfo where id=1 ").get(0);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title><%=titlemap.get("sitenameback") %></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<LINK href="images/style.css" type=text/css rel=stylesheet>
<STYLE>.main_left {
	TABLE-LAYOUT: auto; BACKGROUND: url(images/left_bg.gif)
}
.main_left_top {
	BACKGROUND: url(images/left_menu_bg.gif); PADDING-TOP: 5px
}
.main_left_title {
	PADDING-LEFT: 15px; FONT-WEIGHT: bold; FONT-SIZE: 14px; COLOR: #fff; TEXT-ALIGN: left
}
.left_iframe {
	BACKGROUND: none transparent scroll repeat 0% 0%; VISIBILITY: inherit; WIDTH: 180px; HEIGHT: 92%
}
.main_iframe {
	Z-INDEX: 1; VISIBILITY: inherit; WIDTH: 100%; HEIGHT: 92%
}
TABLE {
	FONT-SIZE: 12px; FONT-FAMILY: tahoma, 宋体, fantasy
}
TD {
	FONT-SIZE: 12px; FONT-FAMILY: tahoma, 宋体, fantasy
}
</STYLE>

<SCRIPT language=javaScript src="images/admin.js" 
type=text/javascript></SCRIPT>

<SCRIPT language=javascript 
src="images\Admin(1).js"></SCRIPT>

<SCRIPT>
var status = 1;
var Menus = new DvMenuCls;
document.onclick=Menus.Clear;
function switchSysBar(){
     if (1 == window.status){
		  window.status = 0;
          switchPoint.innerHTML = '<img src="images/left.gif">';
          document.all("frmTitle").style.display="none"
     }
     else{
		  window.status = 1;
          switchPoint.innerHTML = '<img src="images/right.gif">';
          document.all("frmTitle").style.display=""
     }
}
</SCRIPT>
  </head>
  
  <body style="MARGIN: 0px">
    <DIV class=top_table>
<DIV class=top_table_leftbg>
<DIV class=system_logo><IMG 
src="images/logo_up.gif"></DIV>
<DIV class=menu>
<UL>
<%HashMap admin = (HashMap)session.getAttribute("admin"); %>
<%if(admin.get("usertype").equals("管理员")){ %>
  <LI id=menu_1 onmouseover=Menus.Show(this,0) onclick=getleftbar(this);><A 
  href="admin/product.jsp" target=frmright>商品信息管理</A> 
  <DIV class=menu_childs onmouseout=Menus.Hide(0);>
  <UL>
    <LI><A href="admin/protype.jsp" 
    target=frmright>商品类别维护</A> </LI>
    <LI><A href="admin/property.jsp" 
    target=frmright>商品属性维护</A> </LI>
    <LI><A href="admin/product.jsp" 
    target=frmright>商品信息维护</A> </LI>
    </UL></DIV>
  <DIV class=menu_div><IMG style="VERTICAL-ALIGN: bottom" 
  src="images/menu01_right.gif"></DIV></LI>
  <%} %>
  <%if(admin.get("usertype").equals("管理员")||admin.get("usertype").equals("采购")){ %>
    <LI id=menu_1 onmouseover=Menus.Show(this,0) onclick=getleftbar(this);><A 
  href="admin/cgdadd.jsp" target=frmright>采购信息管理</A> 
  <DIV class=menu_childs onmouseout=Menus.Hide(0);>
  <UL>
    <LI><A href="admin/cgdadd.jsp" 
    target=frmright>采购单填写</A> </LI>
    <LI><A href="admin/cgdlist.jsp" 
    target=frmright>采购信息管理</A> </LI>
    </UL></DIV>
  <DIV class=menu_div><IMG style="VERTICAL-ALIGN: bottom" 
  src="images/menu01_right.gif"></DIV></LI>
  <%} %>
    <%if(admin.get("usertype").equals("管理员")||admin.get("usertype").equals("销售")){ %>
  <LI id=menu_1 onmouseover=Menus.Show(this,0) onclick=getleftbar(this);><A 
  href="admin/xsdadd.jsp" target=frmright>销售信息管理</A> 
  <DIV class=menu_childs onmouseout=Menus.Hide(0);>
  <UL>
    <LI><A href="admin/xsdadd.jsp" 
    target=frmright>销售单填写</A> </LI>
    <LI><A href="admin/xsdlist.jsp" 
    target=frmright>销售信息管理</A> </LI>
    <LI><A href="admin/gqproduct.jsp" 
    target=frmright>过期商品管理</A> </LI>
    </UL></DIV>
  <DIV class=menu_div><IMG style="VERTICAL-ALIGN: bottom" 
  src="images/menu01_right.gif"></DIV></LI>
  <%} %>
    <%if(admin.get("usertype").equals("管理员")||admin.get("usertype").equals("仓库")){ %>
  <LI id=menu_2 onmouseover=Menus.Show(this,0) onclick=getleftbar(this);><A 
  href="admin/kcmanage.jsp" target=frmright>商品库存管理</A> 
  <DIV class=menu_childs onmouseout=Menus.Hide(0);>
  <UL>
    <LI><A href="admin/kcmanage.jsp" 
    target=frmright>商品库存管理</A> </LI>
    <LI><A href="admin/kcrecord.jsp" 
    target=frmright>出入库记录</A> </LI>
    <LI><A href="admin/kcwarningset.jsp" 
    target=frmright>库存预警设置</A> </LI>
    <LI><A href="admin/xsdck.jsp" 
    target=frmright>销售单出库</A> </LI>
    <LI><A href="admin/gqproductck.jsp" 
    target=frmright>过期退货单</A> </LI>
    </UL></DIV>
  <DIV class=menu_div><IMG style="VERTICAL-ALIGN: bottom" 
  src="images/menu01_right.gif"></DIV></LI>
  <%} %>
  
    <%if(admin.get("usertype").equals("管理员")||admin.get("usertype").equals("财务")){ %>
  <LI id=menu_3 onmouseover=Menus.Show(this,0) onclick=getleftbar(this);><A 
  href="admin/suppliersjk.jsp" target=frmright>财务管理</A> 
  <DIV class=menu_childs onmouseout=Menus.Hide(0);>
  <UL>

  	<LI><A href="admin/suppliersjk.jsp" 
    target=frmright>供应商结款</A> </LI>

    <LI><A href="admin/zdtj.jsp" 
    target=frmright>帐单统计</A> </LI>
    
    <LI><A href="admin/xstj.jsp" 
    target=frmright>销售统计</A> </LI>
    </UL></DIV>
  <DIV class=menu_div><IMG style="VERTICAL-ALIGN: bottom" 
  src="images/menu01_right.gif"></DIV></LI>
  <%} %>
  
    <%if(admin.get("usertype").equals("管理员")){ %>
  <LI id=menu_4 onmouseover=Menus.Show(this,0) onclick=getleftbar(this);><A href="admin/sysuser.jsp" 
    target=frmright>系统管理</A> 
  <DIV class=menu_childs onmouseout=Menus.Hide(0);>
  <UL>
    <LI><A href="admin/sysuser.jsp" 
    target=frmright>系统用户管理</A> </LI>
    <LI><A href="admin/customers.jsp" 
    target=frmright>客户管理</A> </LI>
    <LI><A href="admin/suppliers.jsp" 
    target=frmright>供应商管理</A> </LI>
    <LI><A href="admin/databackup.jsp" 
    target=frmright>数据备份恢复</A> </LI></UL></DIV>
  <DIV class=menu_div><IMG style="VERTICAL-ALIGN: bottom" 
  src="images/menu01_right.gif"></DIV></LI>
  <%} %>
  
  <LI id=menu_4 onmouseover=Menus.Show(this,0) onclick=getleftbar(this);><A href="admin/userinfo.jsp" 
    target=frmright>个人信息</A> 
  <DIV class=menu_childs onmouseout=Menus.Hide(0);>
  <UL>
    <LI><A href="admin/userinfo.jsp" 
    target=frmright>个人信息修改</A> </LI>
    </UL></DIV>
  <DIV class=menu_div><IMG style="VERTICAL-ALIGN: bottom" 
  src="images/menu01_right.gif"></DIV></LI>
  
  </UL></DIV></DIV></DIV>
<DIV style="BACKGROUND: #337abb; HEIGHT: 24px"></DIV><!--导航部分结束-->
<TABLE style="BACKGROUND: #337abb" height="92%" cellSpacing=0 cellPadding=0 
width="100%" border=0>
  <TBODY>
  <TR>
    <TD class=main_left id=frmTitle vAlign=top align=middle name="fmTitle">
      <TABLE class=main_left_top cellSpacing=0 cellPadding=0 width="100%" 
      border=0>
        <TBODY>
        <TR height=32>
          <TD vAlign=top></TD>
          <TD class=main_left_title id=leftmenu_title>常用快捷功能</TD>
          <TD vAlign=top align=right></TD></TR></TBODY></TABLE><IFRAME 
      class=left_iframe id=frmleft name=frmleft 
      src="images/left.jsp" frameBorder=0 
      allowTransparency></IFRAME>
      <TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR height=32>
          <TD vAlign=top></TD>
          <TD vAlign=bottom align=middle></TD>
          <TD vAlign=top align=right></TD></TR></TBODY></TABLE></TD>
    <TD style="WIDTH: 10px" bgColor=#337abb>
      <TABLE height="100%" cellSpacing=0 cellPadding=0 border=0>
        <TBODY>
        <TR>
          <TD style="HEIGHT: 100%" onclick=switchSysBar()><SPAN class=navPoint 
            id=switchPoint title=关闭/打开左栏><IMG 
            src="images/right.gif"></SPAN> 
        </TD></TR></TBODY></TABLE></TD>
    <TD vAlign=top width="100%" bgColor=#337abb>
      <TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed 
        border=0><TBODY>
        <TR height=32>
          <TD vAlign=top width=10 
          background=images/bg2.gif><IMG alt="" 
            src="images/teble_top_left.gif"></TD>
          <TD width=28 
          background=images/bg2.gif></TD>
          <TD background=images/bg2.gif><SPAN 
            style="FLOAT: left">   </SPAN><SPAN 
            id=dvbbsannounce 
            style="FONT-WEIGHT: bold; FLOAT: left; WIDTH: 300px; COLOR: #c00"></SPAN></TD>
          <TD style="COLOR: #135294; TEXT-ALIGN: right" 
          background=images/bg2.gif> 
             <A href="/hysupermarketjxcsys/hysupermarketjxcsys?ac=backexit" >安全退出</A> </TD>
          <TD vAlign=top align=right width=28 
          background=images/bg2.gif><IMG alt="" 
            src="images/teble_top_right.gif"></TD>
          <TD align=right width=16 bgColor=#337abb></TD></TR></TBODY></TABLE><IFRAME 
      class=main_iframe id=frmright name=frmright 
      src="admin/product.jsp" frameBorder=0 
      scrolling=yes></IFRAME>
      <TABLE style="BACKGROUND: #c4d8ed" cellSpacing=0 cellPadding=0 
      width="100%" border=0>
        <TBODY>
        <TR>
          <TD><IMG height=6 alt="" 
            src="images/teble_bottom_left.gif" 
            width=5></TD>
          <TD align=right><IMG height=6 alt="" 
            src="images/teble_bottom_right.gif" 
            width=5></TD>
          <TD align=right width=16 
  bgColor=#337abb></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE>
<DIV id=dvbbsannounce_true style="DISPLAY: none"></DIV>
<SCRIPT language=JavaScript>
<!--
document.getElementById("dvbbsannounce").innerHTML = document.getElementById("dvbbsannounce_true").innerHTML;
//-->
</SCRIPT>
  </body>
</html>
