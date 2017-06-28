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
<form action="admin/product.jsp?f=f" method="post">
	<%
	 String sql = "select * from product where 1=1 and delstatus='0' ";
	 String url = "/hysupermarketjxcsys/admin/product.jsp?1=1";
	 String key = request.getParameter("key")==null?"":request.getParameter("key");
	 String key1 = request.getParameter("key1")==null?"":request.getParameter("key1");
	 String key2 = request.getParameter("key2")==null?"":request.getParameter("key2");
	 String f = request.getParameter("f");
	 if(f==null)
	 {
	 key = Info.getUTFStr(key);
	 }
	 if(!key.equals(""))
	 {
	 sql+=" and (pname like'%"+key+"%' or pno like'%"+key+"%')";
	 url+="&key="+key;
	 }
	 if(!key1.equals(""))
	 {
	 sql+=" and (fprotype ='"+key1+"')";
	 url+="&key1="+key1;
	 }
	 if(!key2.equals(""))
	 {
	 sql+=" and (protype ='"+key2+"')";
	 url+="&key2="+key2;
	 }
	 sql+=" order by id desc";
%>
<TABLE cellSpacing=1 cellPadding=3 width="95%" align=center bgColor=#6ab6b6 
border=0>
  <TBODY>
  <TR>
    <TD  height=24>【商品查询】</TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24 align="left">
    按名称或编号模糊查询:<input type="text" id="key" name="key" value="<%=key %>">
    &nbsp;
    所属大类：
    <select id="key1" name="key1" onChange="Change_Select()">
    		<option value="">请选择</option>
    		<%ArrayList<HashMap> fprotypelist = (ArrayList<HashMap>)dao.select("select * from protype where delstatus='0' and fatherid='0' "); 
    		for(HashMap fprotype:fprotypelist){%>
    		<option value="<%=fprotype.get("id") %>" <%if(key1.equals(fprotype.get("id"))){out.print("selected==selected");} %>><%=fprotype.get("typename") %></option>
    		<%} %>
    	</select>
    &nbsp;
    所属子类：
    <select id="key2" name="key2">
    		<option value="">请选择</option>
    		<%ArrayList<HashMap> sprotypelist = (ArrayList<HashMap>)dao.select("select * from protype where  fatherid='"+key1+"' "); 
    		for(HashMap sprotype:sprotypelist){%>
    		<option value="<%=sprotype.get("id") %>" <%if(key2.equals(sprotype.get("id"))){out.print("selected==selected");} %>><%=sprotype.get("typename") %></option>
    		<%} %>
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
    <TD  height=24>【属性管理】</TD>
  	<TD  height=24 align="right" colspan="6"><a href="admin/productadd.jsp" target=frmright>【新增商品】</a></TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24>商品编号</TD>
    <TD class=forumrow  height=24>商品名称</TD>
    <TD class=forumrow  height=24>所属大类</TD>
    <TD class=forumrow  height=24>所属小类</TD>
    <TD class=forumrow  height=24>商品销售价格</TD>
    <TD width="20%" class=forumrow  height=24>操作</TD>
  </TR>
  <%String did = request.getParameter("did");
   if(did!=null)
   {
	   dao.commOper("update product set delstatus='1' where id="+did);
   }
   String tjid = request.getParameter("tjid");
   if(tjid!=null)
   {
	   dao.commOper("update product set issuggest='是' where id="+tjid);
   }
   String qxtjid = request.getParameter("qxtjid");
   if(qxtjid!=null)
   {
	   dao.commOper("update product set issuggest='否' where id="+qxtjid);
   }
   PageManager pageManager = PageManager.getPage(url,10, request);
   pageManager.doList(sql);
   PageManager bean= (PageManager)request.getAttribute("page");
   ArrayList<HashMap> list=(ArrayList)bean.getCollection();
   	for(HashMap map:list){
   		HashMap fmap = dao.select("select * from protype where id="+map.get("fprotype")).get(0);
   		HashMap smap = dao.select("select * from protype where id="+map.get("protype")).get(0);
	    %>
  <TR align=center>
    <TD class=forumrow  height=24><%=map.get("pno") %></TD>
    <TD class=forumrow  height=24><%=map.get("pname") %></TD>
    <TD class=forumrow  height=24><%=fmap.get("typename") %></TD>
    <TD class=forumrow  height=24><%=smap.get("typename") %></TD>
    <TD class=forumrow  height=24><%=map.get("price") %>元</TD>
    <TD class=forumrow  height=24>
    <a href="admin/productedit.jsp?id=<%=map.get("id") %>">编辑</a>
    &nbsp;|&nbsp;
    <a href="admin/product.jsp?did=<%=map.get("id") %>">删除</a>
    </TD>
  </TR>
  <%} %>
  <TR align=center>
    <TD class=forumrow  height=24 colspan="8">${page.info }</TD>
  </TR>
  
  </TBODY></TABLE>
  <script type="text/javascript">
  	var req;

   
    function Change_Select(){//当第一个下拉框的选项发生改变时调用该函数
      var fprotype = document.getElementById('key1').value;
      var url = "/hysupermarketjxcsys/hysupermarketjxcsys?ac=searchsontype&fprotype="+ escape(fprotype);
      if(window.XMLHttpRequest){
        req = new XMLHttpRequest();
      }else if(window.ActiveXObject){
        req = new ActiveXObject("Microsoft.XMLHTTP");
      }  
      if(req){
     
        req.open("GET",url,true);
         //指定回调函数为callback
        req.onreadystatechange = callback;
        req.send(null);
      }
    }
    //回调函数
    function callback(){
    
      if(req.readyState ==4){
        if(req.status ==200){
        //var msg = req.responseText;
		//		alert(msg);
        
          parseMessage();//解析XML文档
        }else{
          alert("不能得到描述信息:" + req.statusText);
        }
      }
    }
    //解析返回xml的方法
    function parseMessage(){
      var xmlDoc = req.responseXML.documentElement;//获得返回的XML文档
      var xSel = xmlDoc.getElementsByTagName('select');
      //获得XML文档中的所有<select>标记
      var select_root = document.getElementById('key2');
      //获得网页中的第二个下拉框
      select_root.options.length=0;
      //每次获得新的数据的时候先把每二个下拉框架的长度清0
     
      for(var i=0;i<xSel.length;i++){
        var xValue = xSel[i].childNodes[0].firstChild.nodeValue;
        //获得每个<select>标记中的第一个标记的值,也就是<value>标记的值
        var xText = xSel[i].childNodes[1].firstChild.nodeValue;
        //获得每个<select>标记中的第二个标记的值,也就是<text>标记的值
       
        var option = new Option(xText, xValue);
        //根据每组value和text标记的值创建一个option对象
       
        try{
          select_root.add(option);//将option对象添加到第二个下拉框中
        }catch(e){
        }
      }
    }    
  </script>
  </body>
</html>
