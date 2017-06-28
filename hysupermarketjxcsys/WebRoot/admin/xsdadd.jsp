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
  <%CommDAO dao = new CommDAO();  %>
  <body>
    <BR>
  <form action="/hysupermarketjxcsys/hysupermarketjxcsys?ac=xsdadd" name="f1" method="post" onsubmit="return getsub()" >
<TABLE cellSpacing=1 cellPadding=3 width="95%" align=center bgColor=#6ab6b6 
border=0>
  <TBODY>
  <TR>
    <TD  height=24>【新增销售单】</TD>
  	<TD  height=24 align="right"></TD>
  </TR>
  
  
  <TR align=center>
    <TD class=forumrow  height=24 width="20%"></TD>
    <TD class=forumrow  height=24 align="left">
    	<input name="button" type="button" class="button blue small" onclick='additem("tb")' value="添加>>"/><input type="button" class="button blue small" value="删除" onclick="deleteitem();" />
    	<input id="Hidden1" name="Hidden1" type="hidden"  />
    	<input id="Hidden2" name="Hidden2" type="hidden"  />
    </TD>
  </TR>
  	<tr align=center>
  			<TD class=forumrow  height=24 width="20%">明细：</TD>
    		<td class=forumrow  height=24 align="left">
    			<table id="tb"></table>   
    		</td>
	</tr>
	<tr align=center>
  			<TD class=forumrow  height=24 width="20%">备注</TD>
    		<td class=forumrow  height=24 align="left" >
    			<input type="text" id="remark" name="remark" size="60"/> 
    		</td>
	</tr>
  
  
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
location.replace("/hysupermarketjxcsys/admin/xsdlist.jsp");
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
	//cell.innerHTML=""+(count+1)+" <input  onfocus='loadXMLDoc(this)'   id='St"+count+"' type='text' name='St"+count+"' size='50'> ;数量:<input type='text' id='num"+count+"' name='num"+count+"' value='1' />";
	var a = ""+(count+1)+" .<select id='St"+count+"' name='St"+count+"'> " ;
	a += "<option value=''>请选择</option>";
	<%ArrayList<HashMap> productlist = (ArrayList<HashMap>)dao.select("select * from product where delstatus='0'");
	for(HashMap productm:productlist){
	%>
		a += "<option value='<%=productm.get("id")%>'><%=productm.get("pname")%></option>";
	<%}%>
	
	a += "</select>;数量:<input type='text' id='num"+count+"' name='num"+count+"' value='1' />";
	cell.innerHTML = a;
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

function getsub()
{
var reg=/^([1-9]\d*)$/;

		
var re="";
	//if(count==0){
	//	alert("请填写");
	//	return false;
	//}else{
	var renum="";
	for (var    i = 0 ;i<count;i++)
	{
		if(document.getElementsByName("St"+i)[0].value==undefined||document.getElementsByName("St"+i)[0].value==''||document.getElementsByName("St"+i)[0].value==null){
			alert("第"+(i+1)+"项为空,请选择商品");
			return false;
		}else{
			re += document.getElementsByName("St"+i)[0].value+'$';
		}
		if(document.getElementsByName("num"+i)[0].value==undefined||document.getElementsByName("num"+i)[0].value==''||document.getElementsByName("num"+i)[0].value==null){
			alert("第"+(i+1)+"项数量为空,请填写");
			return false;
		}else if(reg.test(document.getElementsByName("num"+i)[0].value)==false){
			alert("第"+(i+1)+"项数量请输入正整数");
			return false;
		}else{
			renum += document.getElementsByName("num"+i)[0].value+'$';
		}
	}
	if(re==""||renum==""){
		alert("请检查商品是否为空或数量是否为空");
		return false;
	}
	document.getElementById("Hidden1").value=re;
	document.getElementById("Hidden2").value=renum;
	//}
}
  </script>
