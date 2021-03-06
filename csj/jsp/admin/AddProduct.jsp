<!doctype html public \"-//w3c//dtd html 4.0 " +
"transitional//en\">
<%@ page session="false" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.util.*" %>
<%@ page import="saxParser.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.FileUploadException" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>
<link href="/csj/css/bootstrap.css" rel="stylesheet">
<link href="/csj/css/freelancer.css" rel="stylesheet">
<link href="/csj/css/normalize.css" rel="stylesheet">
<link href="/csj/css/skeleton.css" rel="stylesheet">
<link href="/csj/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link href="http://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
<link href="http://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css">
<!-- <link href="/csj/css/simple-sidebar.css" rel="stylesheet"> -->

<%

HttpSession session=request.getSession();
Object username = session.getAttribute("username");
Object userId = session.getAttribute("userId");
session.setAttribute("userId",(String)userId);
if(null == (String)username){
    request.setAttribute("ERROR", "Session timed out.");
    request.getRequestDispatcher("/jsp/Login.jsp").forward(request, response);
}else{

    String name = request.getParameter("name");
    String retailer = request.getParameter("retailer");
    String category = request.getParameter("category");
    String price = request.getParameter("price");
    String image = request.getParameter("image");
    String description = request.getParameter("description");

    saxParser.Product p= new saxParser.Product();
    //p.setId(Integer.toString(maxId+1));
    p.setName(name);
    p.setRetailer(retailer);
    p.setCategory(category);
    p.setPrice(Integer.parseInt(price));
    p.setUsername((String)username);
    p.setImage(image);
    p.setDescription(description);
    p.setQuantity(1);
    
    ServletContext scw = request.getSession().getServletContext();
    try {
        MySQLDataStoreUtilities.addProduct(p);
    } catch (Exception e) {
        System.out.println("AddProduct>>Write to serializable>>Exception occured");
    }
    
    //>>Redirect to salesmen homepage
    session.setAttribute("username",(String)username);
    //request.getRequestDispatcher("/jsp/admin/HomePageAdmin.jsp").forward(request, response);
    response.sendRedirect(request.getContextPath() +"/jsp/admin/HomePageAdmin.jsp");
    //<<Redirect to salesmen homepage
}
%>
