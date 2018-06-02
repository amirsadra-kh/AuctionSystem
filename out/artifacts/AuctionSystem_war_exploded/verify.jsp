<%@ page import="com.AuctionSystem.bll.UserMgr" %>
<%@ page import="com.AuctionSystem.bll.MembershipMgr" %>
<%@ page import="java.util.Random" %>
<%@ page import="static com.AuctionSystem.bll.UserMgr.*" %>
<%--
  Created by IntelliJ IDEA.
  User: Sadra
  Date: 11/27/15
  Time: 12:55 AM
  To change this template use File | Settings | File Templates.
--%>
<%! UserMgr vu; %>
<%! MembershipMgr mm; %>
<%
    mm = MembershipMgr.getCurrent(session,response,request);
    vu = new UserMgr();
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Verifying...</title>
</head>
<body>

<%! String uname, pass, pass_c, act; %>
<%
    uname = request.getParameter("uName");
    pass = request.getParameter("password");
    pass_c = request.getParameter("password_c");
    act = request.getParameter("act");
    if(act.equals("Logout"))
    {
        mm.logOut();
        response.sendRedirect("login.jsp");
    }
    else if(uname == "" && pass == "")
    {%>
        <jsp:forward page="login.jsp?randNum=<%=(new Random()).nextInt() %>" />
    <%}
    else if(uname != "" && pass != "" && mm.loginUser(uname,pass)){
        response.sendRedirect("products.jsp");
    }
    else if (act.equals("Register") && vu.isNewUserValid(uname)){%>
        <h3>User is already registered. Please try again with a different username.</h3>
        <a href="/register.jsp">Try again</a>
<%}
//else if (act.equals("Register") && uname != "" && pass != "" && pass_c != "" && pass == pass_c && !mm.loginUser(uname,pass) && !vu.isNewUserValid(uname,pass,pass_c)){
    else if (act.equals("Register") && uname != "" && pass != "" && pass_c != "" && pass.equals(pass_c)){
        UserMgr.add(uname,pass);
        %>
        <jsp:forward page="/success.jsp" />
        <%
    }
    else {%>
        <h1>Wrong user credentials...!</h1>
        <h2><a href="/login.jsp">Go back to login page.</a></h2>
    <%}%>
</body>
</html>
