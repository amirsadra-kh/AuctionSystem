<%@ page import="com.AuctionSystem.bll.*" %>
<%! MembershipMgr mm; %>
<% mm = MembershipMgr.getCurrent(session,response, request); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Sadra's Auction System | Registration</title>
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
    <link href="css/styles.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div class="header-wrapper">
    <div class="header">
        <div style="font-size: 10px"; class="logo">
            <h1>Auction System</h1>
        </div>
        <% if (mm.isLoggedIn()){%>
        <div class="B1 R LoginForm">
            Greetings dear <b><%=mm.getLoggedInUser() %>!</b><br/>
            <form action="verify.jsp" method="get">
                <input type="submit" class="Button" name="act" value="Logout"/>
                <a href="productManager.jsp" class="Button" style="">Manage your products</a>
            </form>
        </div>
        <%}%>
        <!---logo ends here -->
        <div class="menu">
            <ul>
                <li><a href="/index.jsp">Home</a></li>
                <li><a href="/about.jsp">About</a></li>
                <li><a href="/products.jsp">Products</a></li>
                <li><a href="/login.jsp">Login</a></li>
                <li><a class="active" href="#">Register</a>me</li>

            </ul>
        </div>
        <!--- menu ends here -->
    </div>
    <!---headerends here -->
</div>
<div class="clear"></div>
<div class="quickreg">
    <div class="quickreg-input">
        <% if(!mm.isLoggedIn()){%>
        <h1>Register</h1>
        <form action="verify.jsp" method="post">
            <input name="uName" type="text" class="quickreg" placeholder="Email Address" />
            <br>

            <input name="password" type="password" class="quickreg" placeholder="Password"/>
            <br>

            <input name="password_c" type="password" class="quickreg" placeholder="Confirm Password"/>
            <br>

            <input type="submit" class="Button" name="act" value="Register"/>
        </form>
        <%}else{%>
        <form action="verify.jsp" method="get">
            You are already signed in as <b><%=mm.getLoggedInUser() %></b><br/>
            <input type="submit" name="act" value="Logout"/>
        </form>
        <%}%>
    </div>


</div>
</body>
</html>