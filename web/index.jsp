<%@ page import="com.AuctionSystem.bll.*" %>
<%! MembershipMgr mm; %>
<% mm = MembershipMgr.getCurrent(session,response, request); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title>Sadra's Auction System</title>
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
        <li><a class="active" href="#">Home</a>me</li>
        <li><a href="/about.jsp">About</a></li>
        <li><a href="/products.jsp">Products</a></li>
        <li><a href="/login.jsp">Login</a></li>
        <li><a href="/register.jsp">Register</a></li>
      </ul>
    </div>
    <!--- menu ends here -->
  </div>
  <!---headerends here -->
</div>
<!---header-wrapper-ends here -->
<div class="clear"></div>
<div class="banner-wrapper">
  <div class="banner">
    <div class="banner-image"> <img src="images/banner.png" alt="img" /> </div>
    <!---banner-image ends here-->
  </div>
  <!---bannerends here-->
</div>
<!---banner-wrapper ends here-->
  <div class="clear" style="text-align: center;">Copyright &copy; 2015 Amir Sadra Khorramizadeh. All rights reserved.</div>
</div>
<!---footer-wrapper ends here-->
</body>
</html>
