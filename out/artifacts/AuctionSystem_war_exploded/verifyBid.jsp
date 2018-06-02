<%@ page import="com.AuctionSystem.bll.MembershipMgr" %><%--
  Created by IntelliJ IDEA.
  User: Sadra
  Date: 11/29/15
  Time: 4:00 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%! MembershipMgr mm; %>
<% mm = MembershipMgr.getCurrent(session,response, request); %>
<html>
<head>
    <title>submitting your bid</title>
</head>
<body>
    <%! String bidValue, bidAction, prodId, prodPrice; %>
    <%
        prodPrice = request.getParameter("prodPrice");
        bidValue = request.getParameter("bidValue");
        bidAction = request.getParameter("bidAction");
        prodId = request.getParameter("prodId");
        if(bidAction.equals("Submit") && bidValue != "" && prodId != "" && mm.isLoggedIn())
        {
            try {
                if (Float.parseFloat(bidValue) > Float.parseFloat(prodPrice)){
                    if(mm.bm.add(mm.getLoggedInUser(), Integer.valueOf(prodId), Float.valueOf(bidValue)))
                        response.sendRedirect("productshow.jsp?id=" + prodId);
                }
                else if (Float.parseFloat(bidValue) < Float.parseFloat(prodPrice))
                {%>
                   <h1> ERROR! Entered bid is lower than base price. <h1>
                       <a href="productshow.jsp?id=<%= prodId%>">Try again</a>
                <%}
                else if (Float.parseFloat(bidValue) == Float.parseFloat(prodPrice))
                {%>
                       <h1> ERROR! Entered bid is equal to base price. <h1>
                           <a href="productshow.jsp?id=<%= prodId%>">Try again</a>
                               <%}
                else {
                    %><h1>Wrong bid...</h1><a href="productshow.jsp?id=<%= prodId%>">Try again</a><%
                }
            }
            catch (Exception ex){
                System.out.println(ex.getMessage());
                ex.printStackTrace();
            }
        }
        else
        {
            response.sendRedirect("login.jsp");
        }
    %>

</body>
</html>
