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
    <%CommDAO dao = new CommDAO();  %>
  <form action="/hysupermarketjxcsys/hysupermarketjxcsys?ac=productadd" name="f1" id="f1" method="post" onsubmit="return ck()">
<TABLE cellSpacing=1 cellPadding=3 width="95%" align=center bgColor=#6ab6b6 border=0>
  <TBODY>
  <TR>
    <TD  height=24>【新增商品】</TD>
  	<TD  height=24 colspan="5" align="right"><a href="admin/product.jsp" target=frmright>返回上一层</a></TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24 width="10%">商品名称</TD>
    <TD class=forumrow  height=24 align="left"><input type="text" id="pname" name="pname" size="50"></TD>
    <TD class=forumrow  height=24 width="10%">所属大类</TD>
    <TD class=forumrow  height=24 align="left">
    	<select id="fprotype" name="fprotype" onChange="Change_Select()">
    		<option value="">请选择</option>
    		<%ArrayList<HashMap> fprotypelist = (ArrayList<HashMap>)dao.select("select * from protype where delstatus='0' and fatherid='0' "); 
    		for(HashMap fprotype:fprotypelist){%>
    		<option value="<%=fprotype.get("id") %>"><%=fprotype.get("typename") %></option>
    		<%} %>
    	</select>
    </TD>
    <TD class=forumrow  height=24 width="10%">所属小类</TD>
    <TD class=forumrow  height=24 align="left">
    	<select id="protype" name="protype">
    		<option value="">请选择</option>
    	</select>
    </TD>
    
  </TR>
   
  <TR align=center>
  	<TD class=forumrow  height=24 >商品价格</TD>
    <TD class=forumrow  height=24 align="left"><input type="text" id="price" name="price" size="5">元</TD>
    <TD class=forumrow  height=24 >促销价格</TD>
    <TD class=forumrow  height=24 align="left"><input type="text" id="discount" name="discount" size="5">元</TD>
    <TD class=forumrow  height=24 >是否推荐</TD>
    <TD class=forumrow  height=24 align="left">
    	<select id="issuggest" name="issuggest">
    		<option value="否">否</option>
    		<option value="是">是</option>
    	</select>
    </TD>
  </TR>
  <TR align=center>
  	<TD class=forumrow  height=24 >商品属性</TD>
  	<TD class=forumrow  height=24 align="left" colspan="5">
  		<TABLE cellSpacing=1 cellPadding=3 width="50%" align=left  border=0>
  			<tr>
  				<TD class=forumrow  height=24 >
  				<input name="button" type="button" onclick='additem("tb")' value="添加>>"/>
  				<input type="button" value="删除" onclick="deleteitem();" />
  				<input id="Hidden1" name="Hidden1" type="hidden"  />
  				</TD>
  			</tr>
  			<tr><td>
  				<table id="tb" cellSpacing=1 cellPadding=3 width="100%" align=left  border=0></table>
  			</td></tr>
  		</TABLE>
  		<TABLE cellSpacing=1 cellPadding=3 width="50%" height="100%" align=left bgColor=#6ab6b6 border=0>
  				<tr>
  					<td class=forumrow align=center width="10%">图片</td>
  					<td class=forumrow align=center ><%=Info.getImgUpInfo2(95) %></td>
  				</tr>
  		</TABLE>
  	</TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24>商品详情</TD>
    <TD class=forumrow  height=24 align="left" colspan="5"><textarea rows="" cols="" id="remark" name="remark"></textarea> </TD>
  </TR>
  
  <TR align=center>
	<TD class=forumrow  height=24 colspan="10">
		<input type="submit" value="提交"/>
		<input type="reset" value="重置"/>
	</TD>
  </TR>
  <script  language=javascript src="/hysupermarketjxcsys/fckeditor/fckeditor.js"></script>
  </TBODY></TABLE>
  </body>
</html>
<script type="text/javascript">
function window.onload() {

var of = new FCKeditor("remark");
of.BasePath="/hysupermarketjxcsys/fckeditor/";
of.Height = "300";
of.ToolbarSet="Default";
of.ReplaceTextarea();

if(top.location != self.location){ 

var a = window.parent.document.getElementsByTagName('iframe'); 

for (var i=0; i<a.length; i++){ 

if (a[i].name == self.name) {a[i].height = document.body.scrollHeight+150; return;}}} 

}

    var req;
    function Change_Select(){//当第一个下拉框的选项发生改变时调用该函数
      var fprotype = document.getElementById('fprotype').value;
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
      var select_root = document.getElementById('protype');
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
	
	
<%
String suc = (String)request.getAttribute("suc");
String no = (String)request.getAttribute("no");
if(no!=null)
{
 %>
 alert("");
 <%}
if(suc!=null)
{
 %>
 alert("操作成功");
location.replace("/hysupermarketjxcsys/admin/product.jsp");
 <%}%>
</script>

<script type="text/javascript">
var count=0 ;
var num = 0;

if(num!=0){
count = num;
}

function additem(id)
{

    var row,cell,str;
    
    row = document.getElementById(id).insertRow();
    
    if(row != null )
    {
	cell = row.insertCell();
	cell.innerHTML=""+(count+1)+" <input  onfocus='loadXMLDoc(this)'   id='St"+count+"' type='text' name='St"+count+"' size='40' > ";
	count ++;
    }
}
function deleteitem()
{
    //var curRow = obj.parentNode.parentNode;
    //tb.deleteRow(curRow.rowIndex);
    
    var tbl = document.getElementById('tb');
	var lastRow = tbl.rows.length;
	if (lastRow > 1){
		tbl.deleteRow(lastRow - 1);
		count--;
	}else if(lastRow==1){
		tbl.deleteRow(-1);
		count--;
	}
	
}

function ck()
{
	var reg=/^([1-9]\d*)$/;
	var re="";
	if(f1.pname.value==""){
		alert("商品名称不能为空");
		return false;
	}if(f1.fprotype.value==""){
		alert("所属大类不能为空");
		return false;
	}if(f1.protype.value==""){
		alert("所属子类不能为空");
		return false;
	}if(f1.price.value==""){
		alert("商品价格不能为空");
		return false;
	}
	for (var i = 0 ;i<count;i++)
	{
		if(document.getElementsByName("St"+i)[0].value==undefined||document.getElementsByName("St"+i)[0].value==''||document.getElementsByName("St"+i)[0].value==null){
			alert("第"+(i+1)+"项为空,请填写");
			return false;
		}else{
			re += document.getElementsByName("St"+i)[0].value+'$';
		}
		
	}
	document.getElementById("Hidden1").value=re;
	//}
}
  </script>
