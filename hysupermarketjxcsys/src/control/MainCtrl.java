package control;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
import org.apache.commons.fileupload.RequestContext;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.servlet.ServletRequestContext;


import util.Info;
import util.StrUtil;

import dao.CommDAO;

public class MainCtrl extends HttpServlet {

	public MainCtrl() {
		super();
	}

	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
	this.doPost(request, response);
	}

		public void go(String url,HttpServletRequest request, HttpServletResponse response)
		{
		try {
			request.getRequestDispatcher(url).forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		}
		
		public void gor(String url,HttpServletRequest request, HttpServletResponse response)
		{
			try {
				response.sendRedirect(url);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
		}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
        response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		HashMap admin = (HashMap)session.getAttribute("admin");
		String ac = request.getParameter("ac");
		if(ac==null)ac="";
		CommDAO dao = new CommDAO();
		String date = Info.getDateStr();
		String today = date.substring(0,10);
		String tomonth = date.substring(0,7);
		
		//登录
		if(ac.equals("login"))
		{
			    String username = request.getParameter("username");
			    String userpwd = request.getParameter("userpwd");
			    	String sql = "select * from sysuser where username='"+username+"' and userpwd='"+userpwd+"'  ";
			    
			    	List<HashMap> list = dao.select(sql);
			    	if(list.size()==1)
			    	{
			    	session.setAttribute("admin", list.get(0));
			    	gor("/hysupermarketjxcsys/admin/index.jsp", request, response);
			    	}else{
			    		request.setAttribute("error", "");
				    	go("admin/login.jsp", request, response);
			    	}
		}
		//后台退出
		if(ac.equals("backexit")){
			session.removeAttribute("admin");
			go("admin/login.jsp", request, response);
		}

		
		
	
		//检查用户名唯一性AJAX
		if(ac.equals("sysuserscheck")){
			String username = request.getParameter("username");
			ArrayList cklist = (ArrayList)dao.select("select * from sysuser where username='"+username+"' and delstatus='0' ");
			if(cklist.size()>0){
				out.write("1");  
			}else{
				out.write("0");  
			}
		}
		//新增系统用户
		if(ac.equals("sysuseradd")){
			String usertype = request.getParameter("usertype");
			String username = request.getParameter("username");
			String userpwd = request.getParameter("userpwd");
			String realname = request.getParameter("realname");
			String sex = request.getParameter("sex");
			String idcard = request.getParameter("idcard");
			String tel = request.getParameter("tel");
			String email = request.getParameter("email");
			String addr = request.getParameter("addr");
			String delstatus = "0";
			String savetime = Info.getDateStr();
			dao.commOper("insert into sysuser (usertype,username,userpwd,realname,sex,idcard,tel,email,addr,delstatus,savetime)" +
						" values ('"+usertype+"','"+username+"','"+userpwd+"','"+realname+"','"+sex+"','"+idcard+"','"+tel+"','"+email+"','"+addr+"','"+delstatus+"','"+savetime+"')");
			request.setAttribute("suc", "");
			go("/admin/sysuseradd.jsp", request, response);
		}
		//编辑系统用户
		if(ac.equals("sysuseredit")){
			String id = request.getParameter("id");
			String usertype = request.getParameter("usertype");
			String userpwd = request.getParameter("userpwd");
			String realname = request.getParameter("realname");
			String sex = request.getParameter("sex");
			String idcard = request.getParameter("idcard");
			String tel = request.getParameter("tel");
			String email = request.getParameter("email");
			String addr = request.getParameter("addr");
			dao.commOper("update sysuser set userpwd='"+userpwd+"',realname='"+realname+"',sex='"+sex+"',idcard='"+idcard+"',tel='"+tel+"',email='"+email+"',addr='"+addr+"',usertype='"+usertype+"' where id="+id);
			request.setAttribute("suc", "");
			go("/admin/sysuseredit.jsp?id="+id, request, response);
		}
		//编辑个人信息
		if(ac.equals("userinfoedit")){
			String id = request.getParameter("id");
			String userpwd = request.getParameter("userpwd");
			String realname = request.getParameter("realname");
			String sex = request.getParameter("sex");
			String idcard = request.getParameter("idcard");
			String tel = request.getParameter("tel");
			String email = request.getParameter("email");
			String addr = request.getParameter("addr");
			dao.commOper("update sysuser set userpwd='"+userpwd+"',realname='"+realname+"',sex='"+sex+"',idcard='"+idcard+"',tel='"+tel+"',email='"+email+"',addr='"+addr+"' where id="+id);
			request.setAttribute("suc", "");
			go("/admin/userinfo.jsp?id="+id, request, response);
		}
		//商品类别新增
		if(ac.equals("protypeadd")){
			String typename = request.getParameter("typename");
			String fatherid = request.getParameter("fatherid");
			dao.commOper("insert into protype (typename,fatherid,delstatus) values ('"+typename+"','"+fatherid+"','0') ");
			request.setAttribute("suc", "");
			go("/admin/protypeadd.jsp", request, response);
		}
		//商品类别编辑
		if(ac.equals("protypeedit")){
			String id = request.getParameter("id");
			String typename = request.getParameter("typename");
			dao.commOper("update protype set typename='"+typename+"' where id="+id);
			request.setAttribute("suc", "");
			go("/admin/protypeedit.jsp?id="+id, request, response);
		}
		//商品属性新增
		if(ac.equals("propertyadd")){
			String propertyname = request.getParameter("propertyname");
			dao.commOper("insert into property (propertyname,delstatus) values ('"+propertyname+"','0') ");
			request.setAttribute("suc", "");
			go("/admin/propertyadd.jsp", request, response);
		}
		//商品属性编辑
		if(ac.equals("propertyedit")){
			String id = request.getParameter("id");
			String propertyname = request.getParameter("propertyname");
			dao.commOper("update property set propertyname='"+propertyname+"' where id="+id);
			request.setAttribute("suc", "");
			go("/admin/propertyedit.jsp?id="+id, request, response);
		}
		//AJAX根据父类查子类
		if(ac.equals("searchsontype")){
			String xml_start = "<selects>";
	        String xml_end = "</selects>";
	        String xml = "";
	        String fprotype = request.getParameter("fprotype");
	        ArrayList<HashMap> list = (ArrayList<HashMap>)dao.select("select * from protype where fatherid='"+fprotype+"' and delstatus='0' ");
			if(list.size()>0){
		        for(HashMap map:list){
					xml += "<select><value>"+map.get("id")+"</value><text>"+map.get("typename")+"</text><value>"+map.get("id")+"</value><text>"+map.get("typename")+"</text></select>";
				}
			}
			String last_xml = xml_start + xml + xml_end;
			response.setContentType("text/xml;charset=GB2312"); 
			response.setCharacterEncoding("utf-8");
			response.getWriter().write(last_xml);
			response.getWriter().flush();
			
		}
		//公用方法,图片上传
		if(ac.equals("uploadimg"))
		{
			try {
				String filename="";
			request.setCharacterEncoding("utf-8");
			RequestContext  requestContext = new ServletRequestContext(request);
			if(FileUpload.isMultipartContent(requestContext)){

			   DiskFileItemFactory factory = new DiskFileItemFactory();
			   factory.setRepository(new File(request.getRealPath("/upfile/")+"/"));
			   ServletFileUpload upload = new ServletFileUpload(factory);
			   upload.setSizeMax(100*1024*1024);
			   List items = new ArrayList();
			     items = upload.parseRequest(request);
			    FileItem fileItem = (FileItem) items.get(0);
			   if(fileItem.getName()!=null && fileItem.getSize()!=0)
			    {
			    if(fileItem.getName()!=null && fileItem.getSize()!=0){
			      File fullFile = new File(fileItem.getName());
			      filename = Info.generalFileName(fullFile.getName());
			      File newFile = new File(request.getRealPath("/upfile/")+"/" + filename);
			      try {
			       fileItem.write(newFile);
			      } catch (Exception e) {
			       e.printStackTrace();
			      }
			     }else{
			     }
			    }
			}
			
			go("/js/uploadimg.jsp?filename="+filename, request, response);
			} catch (Exception e1) {
				e1.printStackTrace();
			    }
		}
		
		//新增商品
		if(ac.equals("productadd")){
			String pno = Info.getAutoNo();
			String pname = request.getParameter("pname");
			String fprotype = request.getParameter("fprotype");
			String protype = request.getParameter("protype");
			String price = request.getParameter("price");
			String discount = request.getParameter("discount");
			String issuggest = request.getParameter("issuggest");
			String property = request.getParameter("spsx");
			String remark = request.getParameter("remark");
			String filename = request.getParameter("filename");
			dao.commOper("insert into product (pno,pname,price,discount,issuggest,filename,fprotype,protype,property,remark,delstatus,savetime) " +
					"values ('"+pno+"','"+pname+"','"+price+"','"+discount+"','"+issuggest+"','"+filename+"','"+fprotype+"','"+protype+"','"+property+"','"+remark+"','0','"+Info.getDateStr()+"') ");
			request.setAttribute("suc", "");
			go("/admin/productadd.jsp", request, response);
		}
		
		//编辑商品
		if(ac.equals("productedit")){
			String id = request.getParameter("id");
			String pname = request.getParameter("pname");
			String fprotype = request.getParameter("fprotype");
			String protype = request.getParameter("protype");
			String price = request.getParameter("price");
			String discount = request.getParameter("discount");
			String issuggest = request.getParameter("issuggest");
			String property = request.getParameter("spsx");
			String remark = request.getParameter("remark");
			String filename = request.getParameter("filename");
			dao.commOper("update  product set pname='"+pname+"',price='"+price+"',discount='"+discount+"',issuggest='"+issuggest+"'" +
					",filename='"+filename+"',fprotype='"+fprotype+"',protype='"+protype+"',property='"+property+"',remark='"+remark+"' where id="+id);
			request.setAttribute("suc", "");
			go("/admin/productedit.jsp?id="+id, request, response);
		}
		
		//新增供应商
		if(ac.equals("supplieradd")){
			String sname = request.getParameter("sname");
			String lxr = request.getParameter("lxr");
			String tel = request.getParameter("tel");
			String addr = request.getParameter("addr");
			String delstatus = "0";
			String savetime = Info.getDateStr();
			dao.commOper("insert into suppliers (sname,lxr,tel,addr,delstatus,savetime,type) " +
					"values ('"+sname+"','"+lxr+"','"+tel+"','"+addr+"','"+delstatus+"','"+savetime+"','供应商')");
			request.setAttribute("suc", "");
			go("/admin/supplieradd.jsp", request, response);
		}
		
		//编辑供应商
		if(ac.equals("supplieredit")){
			String id = request.getParameter("id");
			String sname = request.getParameter("sname");
			String lxr = request.getParameter("lxr");
			String tel = request.getParameter("tel");
			String addr = request.getParameter("addr");
			dao.commOper("update suppliers set sname = '"+sname+"',lxr='"+lxr+"',tel='"+tel+"',addr='"+addr+"' where id="+id);
			request.setAttribute("suc", "");
			go("/admin/supplieredit.jsp?id="+id, request, response);
		}
		
		//新增客户
		if(ac.equals("customeradd")){
			String sname = request.getParameter("sname");
			String lxr = request.getParameter("lxr");
			String tel = request.getParameter("tel");
			String addr = request.getParameter("addr");
			String delstatus = "0";
			String savetime = Info.getDateStr();
			dao.commOper("insert into suppliers (sname,lxr,tel,addr,delstatus,savetime,type) " +
					"values ('"+sname+"','"+lxr+"','"+tel+"','"+addr+"','"+delstatus+"','"+savetime+"','客户')");
			request.setAttribute("suc", "");
			go("/admin/customeradd.jsp", request, response);
		}
		
		//编辑客户
		if(ac.equals("customeredit")){
			String id = request.getParameter("id");
			String sname = request.getParameter("sname");
			String lxr = request.getParameter("lxr");
			String tel = request.getParameter("tel");
			String addr = request.getParameter("addr");
			dao.commOper("update suppliers set sname = '"+sname+"',lxr='"+lxr+"',tel='"+tel+"',addr='"+addr+"' where id="+id);
			request.setAttribute("suc", "");
			go("/admin/customeredit.jsp?id="+id, request, response);
		}
		
		//库存预警数值设置
		if(ac.equals("kcwarningset")){
			String num = request.getParameter("num");
			String id = request.getParameter("id");
			dao.commOper("update kcwarnning set num="+Integer.parseInt(num)+" where id="+id);
			request.setAttribute("suc", "");
			go("/admin/kcwarningset.jsp", request, response);
		}
		//商品入库
		if(ac.equals("kcinto")){
			String pid = request.getParameter("pid");
			String num = request.getParameter("num");
			String type = request.getParameter("type");
			String reason = request.getParameter("reason");
			String savetime = Info.getDateStr();
			dao.commOper("insert into kcrecord (pid,num,type,reason,savetime) values" +
					" ('"+pid+"','"+Integer.parseInt(num)+"','"+type+"','"+reason+"','"+savetime+"') ");
			request.setAttribute("suc", "");
			go("/admin/kcinto.jsp", request, response);
		}
		//商品出库
		if(ac.equals("kcout")){
			String pid = request.getParameter("pid");
			String num = request.getParameter("num");
			String type = request.getParameter("type");
			String reason = request.getParameter("reason");
			String savetime = Info.getDateStr();
			
			int znum = 0;
	    	int innum = 0;
	    	int outnum = 0;
	    	ArrayList<HashMap> inlist = (ArrayList<HashMap>)dao.select("select * from kcrecord where  type='in' and pid='"+pid+"' ");
	    	ArrayList<HashMap> outlist = (ArrayList<HashMap>)dao.select("select * from kcrecord where  type='out' and pid='"+pid+"' ");
	    	if(inlist.size()>0){
	    		for(HashMap inmap:inlist){
	    			innum += Integer.parseInt(inmap.get("num").toString());//总入库量
	    		}
	    	}
	    	if(outlist.size()>0){
	    		for(HashMap outmap:outlist){
	    			outnum += Integer.parseInt(outmap.get("num").toString());//总出库量
	    		}
	    	}
	    	znum = innum - outnum;//库存量
	    	if(Integer.parseInt(num)>znum){
	    		request.setAttribute("no", "");
				go("/admin/kcout.jsp", request, response);
	    	}else{
				dao.commOper("insert into kcrecord (pid,num,type,reason,savetime) values" +
						" ('"+pid+"','"+Integer.parseInt(num)+"','"+type+"','"+reason+"','"+savetime+"') ");
				request.setAttribute("suc", "");
				go("/admin/kcout.jsp", request, response);
	    	}
		}
		
		//新增图片
		if(ac.equals("imgadvadd")){
			try {
				String img = "";
				String imgtype="";
			request.setCharacterEncoding("utf-8");
			RequestContext  requestContext = new ServletRequestContext(request);
			if(FileUpload.isMultipartContent(requestContext)){
			   DiskFileItemFactory factory = new DiskFileItemFactory();
			   factory.setRepository(new File(request.getRealPath("/upfile/")+"/"));
			   ServletFileUpload upload = new ServletFileUpload(factory);
			   upload.setSizeMax(100*1024*1024);
			   List items = new ArrayList();
			     items = upload.parseRequest(request);
			     
			     imgtype = ((FileItem) items.get(1)).getString();
			     imgtype = Info.getUTFStr(imgtype);

			    FileItem fileItem = (FileItem) items.get(0);
			   if(fileItem.getName()!=null && fileItem.getSize()!=0)
			    {
			    if(fileItem.getName()!=null && fileItem.getSize()!=0){
			      File fullFile = new File(fileItem.getName());
			      img = Info.generalFileName(fullFile.getName());
			      File newFile = new File(request.getRealPath("/upfile/")+"/" + img);
			      try {
			       fileItem.write(newFile);
			      } catch (Exception e) {
			       e.printStackTrace();
			      }
			     }else{
			     }
			    }
			}
			
			String cksql = "select * from imgadv where imgtype='banner'";
			ArrayList cklist = (ArrayList)dao.select(cksql);
			if(imgtype.equals("banner")&&cklist.size()!=0){
				request.setAttribute("no", "");
				go("/admin/imgadvadd.jsp", request, response);
			}else{
				String sql = "insert into imgadv (filename,imgtype) " +
				"values('"+img+"','"+imgtype+"')" ;
				dao.commOper(sql);
				request.setAttribute("suc", "");
				go("/admin/imgadvadd.jsp", request, response);
			}
			} catch (Exception e1) {
				e1.printStackTrace();
				request.setAttribute("no", "");
			     request.getRequestDispatcher("/admin/imgadvadd.jsp").forward(request, response);
			    }
		}
		//编辑图片
		if(ac.equals("imgadvedit")){
			String id = request.getParameter("id");
			HashMap map = dao.select("select * from imgadv where id="+id).get(0);
			try {
				String img = map.get("filename").toString();
			request.setCharacterEncoding("utf-8");
			RequestContext  requestContext = new ServletRequestContext(request);
			if(FileUpload.isMultipartContent(requestContext)){

			   DiskFileItemFactory factory = new DiskFileItemFactory();
			   factory.setRepository(new File(request.getRealPath("/upfile/")+"/"));
			   ServletFileUpload upload = new ServletFileUpload(factory);
			   upload.setSizeMax(100*1024*1024);
			   List items = new ArrayList();
			     items = upload.parseRequest(request);
			     
			    FileItem fileItem = (FileItem) items.get(0);
			   if(fileItem.getName()!=null && fileItem.getSize()!=0)
			    {
			    if(fileItem.getName()!=null && fileItem.getSize()!=0){
			      File fullFile = new File(fileItem.getName());
			      img = Info.generalFileName(fullFile.getName());
			      File newFile = new File(request.getRealPath("/upfile/")+"/" + img);
			      try {
			       fileItem.write(newFile);
			      } catch (Exception e) {
			       e.printStackTrace();
			      }
			     }else{
			     }
			    }
			}
					String sql = "update imgadv set filename='"+img+"' where id="+id ;
					dao.commOper(sql);
					request.setAttribute("suc", "");
					go("/admin/imgadvedit.jsp?id="+id, request, response);
			} catch (Exception e1) {
				e1.printStackTrace();
				request.setAttribute("error", "");
			     request.getRequestDispatcher("/admin/imgadvedit.jsp?id="+id).forward(request, response);
			    }
	}
		
		//新增采购单
		if(ac.equals("cgdadd")){
			String pid = request.getParameter("pid");
			String num = request.getParameter("num");
			String dprice = request.getParameter("dprice");
			String tprice = String.valueOf(Float.valueOf(dprice)*Integer.parseInt(num));
			String suppliersid = request.getParameter("suppliersid");
			String savetime = Info.getDateStr();
			String status = "未到货";
			String oper = admin.get("id").toString();
			dao.commOper("insert into cgdinfo (cgdno,pid,num,dprice,tprice,suppliersid,savetime,status,oper,isjk) values " +
					"('"+Info.getAutoNo()+"','"+pid+"','"+num+"','"+dprice+"','"+tprice+"','"+suppliersid+"','"+savetime+"','"+status+"','"+oper+"','未结款')");
			request.setAttribute("suc", "");
			go("/admin/cgdadd.jsp", request, response);
		}
		//编辑采购单
		if(ac.equals("cgdedit")){
			String id = request.getParameter("id");
			String pid = request.getParameter("pid");
			String num = request.getParameter("num");
			String dprice = request.getParameter("dprice");
			String tprice = String.valueOf(Float.valueOf(dprice)*Integer.parseInt(num));
			String suppliersid = request.getParameter("suppliersid");
			dao.commOper("update cgdinfo set pid='"+pid+"',num='"+num+"',dprice='"+dprice+"',tprice='"+tprice+"',suppliersid='"+suppliersid+"' where id="+id);
			request.setAttribute("suc", "");
			go("/admin/cgdedit.jsp?id="+id, request, response);
		}
		
		//新增销售单
		if(ac.equals("xsdadd")){
			String xsdno = Info.getAutoNo();
			String customerid = request.getParameter("customerid");
			String pinfo = request.getParameter("Hidden1");
			String numinfo = request.getParameter("Hidden2");
			String remark = request.getParameter("remark");
			String savetime = Info.getDateStr();
			String oper = admin.get("id").toString();
			String status = "未出货";
			String a[] = pinfo.split("\\$");
			String b[] = numinfo.split("\\$");
			Double totalprice1 = 0.0;
			String tprice = "";
			DecimalFormat decimal = new DecimalFormat("#.#");
			for(int i=0;i<a.length;i++){
				String ynos[] = a[i].split("\\-");
				HashMap am = dao.select("select * from product where id='"+ynos[0]+"'").get(0);
				totalprice1 += Double.valueOf(am.get("price").toString())*Double.parseDouble(b[i].toString());
			}
			tprice = decimal.format(totalprice1);
			String sql = "insert into xsdinfo (xsdno,customerid,pinfo,numinfo,remark,tprice,savetime,oper,status,isfk) values" +
			" ('"+xsdno+"','"+customerid+"','"+pinfo+"','"+numinfo+"','"+remark+"','"+tprice+"','"+savetime+"','"+oper+"','"+status+"','已结账') ";
			System.out.println(sql);
			dao.commOper(sql);
			request.setAttribute("suc", "");
			go("/admin/xsdadd.jsp", request, response);
		}
		//编辑销售单
		if(ac.equals("xsdedit")){
			String id = request.getParameter("id");
			String customerid = request.getParameter("customerid");
			String pinfo = request.getParameter("Hidden1");
			String numinfo = request.getParameter("Hidden2");
			String remark = request.getParameter("remark");
			String tprice = "";;
			String a[] = pinfo.split("\\$");
			String b[] = numinfo.split("\\$");
			Double totalprice1 = 0.0;
			DecimalFormat decimal = new DecimalFormat("#.#");
			for(int i=0;i<a.length;i++){
				String ynos[] = a[i].split("\\-");
				HashMap am = dao.select("select * from product where id='"+ynos[0]+"'").get(0);
				totalprice1 += Double.valueOf(am.get("price").toString())*Double.parseDouble(b[i].toString());
			}
			tprice = decimal.format(totalprice1);
			String sql = "update xsdinfo set customerid='"+customerid+"',pinfo='"+pinfo+"',numinfo='"+numinfo+"',remark='"+remark+"',tprice='"+tprice+"' where id='"+id+"'";
			dao.commOper(sql);
			request.setAttribute("suc", "");
			go("/admin/xsdedit.jsp?id="+id, request, response);
		}
		
		//添加过期商品
		if(ac.equals("gqproductadd")){
			String pid = request.getParameter("pid");
			String num = request.getParameter("num");
			String status = "未退货";
			String savetime = Info.getDateStr();
			String oper = admin.get("id").toString();
			int znum = Info.getkc(pid);
	    	if(Integer.parseInt(num)>znum){
	    		request.setAttribute("no", "");
				go("/admin/gqproductadd.jsp", request, response);
	    	}else{
	    		dao.commOper("insert into gqproduct (pid,num,status,savetime,oper) values" +
						" ('"+pid+"','"+num+"','"+status+"','"+savetime+"','"+oper+"')  ");
				request.setAttribute("suc", "");
				go("/admin/gqproductadd.jsp", request, response);
	    	}
		}
		
		//编辑过期商品
		if(ac.equals("gqproductedit")){
			String id = request.getParameter("id");
			String pid = request.getParameter("pid");
			String num = request.getParameter("num");
			int znum = Info.getkc(pid);
	    	if(Integer.parseInt(num)>znum){
	    		request.setAttribute("no", "");
				go("/admin/gqproductedit.jsp?id="+id, request, response);
	    	}else{
	    		dao.commOper("update gqproduct set pid='"+pid+"',num='"+num+"' where id="+id);
				request.setAttribute("suc", "");
				go("/admin/gqproductedit.jsp?id="+id, request, response);
	    	}
		}
		
		//过期商品退货
	    if(ac.equals("gqth")){
	    	String id = request.getParameter("id");
	    	HashMap map = dao.select("select * from gqproduct where id="+id).get(0);
	    	int znum = Info.getkc(map.get("pid").toString());
	    	int num = Integer.parseInt(map.get("num").toString());
	    	if(num>znum){
	    		request.setAttribute("no", "");
				go("/admin/gqproductck.jsp", request, response);
	    	}else{
	    		dao.commOper("update gqproduct set status='已退货' where id="+id);
	    		dao.commOper("insert into kcrecord (pid,num,type,reason,savetime) values" +
						" ('"+map.get("pid")+"','"+num+"','out','过期退货','"+Info.getDateStr()+"') ");
	    		go("/admin/gqproductck.jsp", request, response);
	    	}
	    }
	    //新增销售计划
	    if(ac.equals("planadd")){
	    	String uid = request.getParameter("uid");
	    	String planmoney = request.getParameter("planmoney");
	    	String plandate = request.getParameter("plandate");
	    	ArrayList cklist = (ArrayList)dao.select("select * from planinfo where uid='"+uid+"' and plandate='"+plandate+"' ");
	    	if(cklist.size()>0){
	    		request.setAttribute("no", "");
				go("/admin/planadd.jsp", request, response);
	    	}else{
		    	dao.commOper("insert into planinfo (uid,planmoney,plandate) values ('"+uid+"','"+planmoney+"','"+plandate+"') ");
		    	request.setAttribute("suc", "");
				go("/admin/planadd.jsp", request, response);
	    	}
	    }
	    //编辑销售计划
	    if(ac.equals("planedit")){
	    	String id = request.getParameter("id");
	    	String planmoney = request.getParameter("planmoney");
	    	String plandate = request.getParameter("plandate");
	    	dao.commOper("update planinfo set planmoney='"+planmoney+"' where id="+id);
	    	request.setAttribute("suc", "");
			go("/admin/planedit.jsp?id="+id, request, response);
	    }
	    //销售单商品出库
	    if(ac.equals("xsdck")){
	    	String id = request.getParameter("id");
	    	HashMap map = dao.select("select * from xsdinfo where id="+id).get(0);
	    	String pinfo = map.get("pinfo").toString();
	    	String numinfo = map.get("numinfo").toString();
	    	String a[] = pinfo.split("\\$");
			String b[] = numinfo.split("\\$");
			String is = "yes";
			int m = 0;
			int kcnum = 0;
			for(int i=0;i<a.length;i++){
				//查库存
				kcnum = Info.getkc(a[i]);
				if(Integer.parseInt(b[i])>kcnum){//比较库存
					is = "no";
					m++;
				}
			}
			if(m==0){
				dao.commOper("update xsdinfo set status='已出货' where id="+id);
				for(int i=0;i<a.length;i++){
					dao.commOper("insert into kcrecord (pid,num,type,reason,savetime) values" +
							" ('"+a[i]+"','"+b[i]+"','out','销售出库','"+Info.getDateStr()+"') ");
				}
			}
			if(m==0){
				request.setAttribute("suc", "");
				go("/admin/xsdck.jsp", request, response);
			}else{
				request.setAttribute("no", "");
				go("/admin/xsdck.jsp", request, response);
			}
	    }
	    
	    if(ac.equals("backup")){
			try {
				MySQLDatabaseBackup.exportDatabaseTool("127.0.0.1", "root", "123", "D:/backupDatabase", "backup.sql", "hysupermarketjxcsys_db");
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("suc1", "");
			go("/admin/databackup.jsp", request, response);
		}
	    if(ac.equals("datahf")){
	    	request.setAttribute("suc2", "");
			go("/admin/databackup.jsp", request, response);
	    }
	dao.close();
	out.flush();
	out.close();
}


	public void init() throws ServletException {
		// Put your code here
	}
	
	
	
	public static void main(String[] args) {
		System.out.println(new CommDAO().select("select * from mixinfo"));
	}
	

}
