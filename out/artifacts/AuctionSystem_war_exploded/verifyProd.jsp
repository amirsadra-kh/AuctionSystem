<%--
  Created by IntelliJ IDEA.
  User: Sadra
  Date: 12/3/15
  Time: 12:03 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.AuctionSystem.bll.*" %>
<%@ page import="java.util.Random" %>
<%@ page import="com.AuctionSystem.models.Product" %>
<%@ page import="java.util.ArrayList" %>
<%! MembershipMgr mm; %>
<%! ProductMgr pm; %>
<%! String act, prodName, prodPrice, prodComments, prodId; %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Adding product...</title>
</head>
<body>

<%
    mm = MembershipMgr.getCurrent(session,response,request);
    if(!mm.isLoggedIn())
        response.sendRedirect("login.jsp?randNum=" + (new Random()).nextInt());

    act = request.getParameter("act");

    if(act.equals("Add")) {
        prodName = request.getParameter("prodName");
        prodPrice = request.getParameter("prodPrice");
        prodComments = request.getParameter("prodComment");
        pm = new ProductMgr();
        try {
            if(pm.add(prodName, Float.valueOf(prodPrice), mm.getLoggedInUser(), prodComments))
            {

                response.sendRedirect("productManager.jsp?randNum=" + (new Random()).nextInt());
            }
            else
%><h1>Error connecting to database..</h1>Please <a href="productManager.jsp">try again</a> later.<%
}
catch (Exception ex){
    ex.printStackTrace();
%><h1>Bad parameters..</h1>Please <a href="productManager.jsp">try again</a>.<%
    }
}
else if(act.equals("Delete")){
    prodId = request.getParameter("prodId");
    pm = new ProductMgr();
    try{
        if(pm.delete(Integer.valueOf(prodId)))
        {
            response.sendRedirect("productManager.jsp?randNum=" + (new Random()).nextInt());
        }
    }
    catch (Exception ex){
        ex.printStackTrace();
%><h1>Bad parameters..</h1>Please <a href="productManager.jsp">try again</a>.<%
        }
    }
%>
</body>
</html>
