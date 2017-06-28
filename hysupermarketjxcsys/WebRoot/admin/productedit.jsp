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
    HashMap map = dao.select("select * from product where id="+id).get(0);%>
  <form action="/hysupermarketjxcsys/hysupermarketjxcsys?ac=productedit" name="f1" method="post" onsubmit="return ck()">
  <input type="hidden" id="spsx" name="spsx" value="<%=map.get("property")%>" >
  <input type="hidden" id="id" name="id" value="<%=id %>">
<TABLE cellSpacing=1 cellPadding=3 width="95%" align=center bgColor=#6ab6b6 border=0>
  <TBODY>
  <TR>
    <TD  height=24>【编辑商品】</TD>
  	<TD  height=24 colspan="5" align="right"><a href="admin/product.jsp" target=frmright>返回上一层</a></TD>
  </TR>
  <TR align=center>
    <TD class=forumrow  height=24 width="10%">商品名称</TD>
    <TD class=forumrow  height=24 align="left"><input type="text" id="pname" name="pname" size="50" value="<%=map.get("pname") %>"></TD>
    <TD class=forumrow  height=24 width="10%">所属大类</TD>
    <TD class=forumrow  height=24 align="left">
    	<select id="fprotype" name="fprotype" onChange="Change_Select()">
    		<option value="">请选择</option>
    		<%ArrayList<HashMap> fprotypelist = (ArrayList<HashMap>)dao.select("select * from protype where delstatus='0' and fatherid='0' "); 
    		for(HashMap fprotype:fprotypelist){%>
    		<option value="<%=fprotype.get("id") %>" <%if(map.get("fprotype").equals(fprotype.get("id"))){out.print("selected==selected");} %>><%=fprotype.get("typename") %></option>
    		<%} %>
    	</select>
    </TD>
    <TD class=forumrow  height=24 width="10%">所属子类</TD>
    <TD class=forumrow  height=24 align="left">
    	<select id="protype" name="protype">
    		<option value="">请选择</option>
    		<%ArrayList<HashMap> sprotypelist = (ArrayList<HashMap>)dao.select("select * from protype where  fatherid='"+map.get("fprotype")+"' "); 
    		for(HashMap sprotype:sprotypelist){%>
    		<option value="<%=sprotype.get("id") %>" <%if(map.get("protype").equals(sprotype.get("id"))){out.print("selected==selected");} %>><%=sprotype.get("typename") %></option>
    		<%} %>
    	</select>
    </TD>
    
  </TR>
   
  <TR align=center>
  	<TD class=forumrow  height=24 >商品售价</TD>
    <TD class=forumrow  height=24 align="left" colspan="5"><input type="text" id="price" name="price" size="5" onkeyup='checkDecimal(this)' value="<%=map.get("price") %>">元</TD>
  </TR>
  <TR align=center>
  	<TD class=forumrow  height=24 >商品属性</TD>
  	<TD class=forumrow  height=24 align="left" colspan="5">
  		<TABLE cellSpacing=1 cellPadding=3 width="50%" align=left bgColor=#6ab6b6 border=0>
  				<%
  				String property = map.get("property")==null?"":map.get("property").toString();
  				ArrayList<HashMap> yslist = new ArrayList<HashMap>();
  				if(!property.equals("")){
	  				String a[] = property.split("\\|");
	  				for(int i=0;i<a.length;i++){
	  					HashMap ysmap = new HashMap();
	  					String b[] = a[i].split("\\$");
	  					//String bbzhi = "";
	  					//if(b[1].equals("")||b[1].equals(" "))
	  					//bbzhi = " ";
	  					ysmap.put("id",b[0]);
	  					ysmap.put("zhi",b[1]);
	  					yslist.add(ysmap);
	  				}
  				}
  				ArrayList<HashMap> sxlist = (ArrayList<HashMap>)dao.select("select * from property where delstatus='0' "); 
  				int i = 0;
  				String zhi = "";
  				for(HashMap sxmap:sxlist){
  					i++;
  					if(yslist.size()>0){
	  					for(HashMap zhimap:yslist){
	  						if(sxmap.get("id").toString().equals(zhimap.get("id").toString())){
	  							zhi = zhimap.get("zhi").toString();
	  						}
	  					}
  					}
  					%>
  				<TR>
  					<td class=forumrow align=center width="10%"><%=sxmap.get("propertyname") %> </td>
  					<td class=forumrow align=left><input type="text" id="sx" name="sx" onchange="getzhi()" value="<%=zhi%>">
  					<input type="hidden" id="sxid" name="sxid" value="<%=sxmap.get("id") %>" >
  					</td>
  				</TR>
  				<%} %>
  		</Table>
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
		<input type="submit" value="提交" class="button blue small"/>
		<input type="reset" value="重置" class="button blue small"/>
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
	var decimalReg=/^\d{0,8}\.{0,1}(\d{1,2})?$/;
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
		}else if(decimalReg.test(f1.price.value)==false||f1.price.value=="0"){
			alert("请输入正确的价格");
			return false;
		}if(f1.discount.value!=""&&decimalReg.test(f1.discount.value)==false||f1.discount.value=="0"){
			alert("请输入正确的促销价格");
			return false;
		}else if(f1.discount.value>=f1.price.value){
			alert("促销价格不能高于或等于销售价格");
			return false;
		}
	}
	var count=0 ;
	count = <%=sxlist.size()%>;
	
	function getzhi(){
	var spsx = ""
		for (var i = 0 ;i<count;i++){
		var sxid = document.getElementsByName("sxid")[i].value;
		var a = document.getElementsByName("sx")[i].value;
		if(a==""){
			a = " ";
		}
		spsx += sxid+'$'+a+'|';
		}
		document.getElementById("spsx").value = spsx;
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
<%=Info.tform(map)%>