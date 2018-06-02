<%@ page import="java.util.ArrayList" %>
<%@ page import="com.AuctionSystem.models.*" %>
<%@ page import="com.AuctionSystem.bll.*" %>
<%--
  Created by IntelliJ IDEA.
  User: Sadra
  Date: 11/28/15
  Time: 11:44 PM
  To change this template use File | Settings | File Templates.
--%>
<%! MembershipMgr mm; %>
<% mm = MembershipMgr.getCurrent(session,response, request); %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Sadra's Auction System | Product Showcase</title>
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
    <link href="css/styles.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        function addTimer(elementId, initVal){
            elem = document.getElementById(elementId);

            if(elem == null || initVal == null || initVal < 0) return;

            if(initVal > 60)
                elem.innerHTML = "<b>"+Math.floor(initVal/60)+":"+(initVal%60)+"</b>";
            else elem.innerHTML = "<b>"+initVal+"</b>";

            setTimeout(function(){
                addTimer(elementId,initVal-1);
            },1000);
        }
        function loader(){
            addTimer('t1',63);
        }
    </script>
</head>

<body onload="loader();">
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
                <li><a href="/login.jsp">Login</a>me</li>
                <li><a href="/login.jsp">Register</a></li>
            </ul>
        </div>
        <!--- menu ends here -->
    </div>
    <!---headerends here -->
</div>
<div class="clear"></div>
<div class="Products B1">
<%! String prodId;
    ProductMgr pm;
%>
    <% prodId = request.getParameter("id");
        ArrayList<Product> prods;
        if(prodId == "" || prodId == null)
        {%>
            <jsp:forward page="products.jsp" />
        <%}
        else if ((prods = mm.pm.getProduct(Integer.valueOf(prodId))) != null && prods.size() > 0){%>
            <div class="Mrg4" style="overflow: hidden;">
                <img src="products/<%= prods.get(0).getId()%>.jpg">
                <h1><%= prods.get(0).getName()%></h1>
                <h3>
                    Price: CAD <%=prods.get(0).getPrice() %>
                </h3>
                <h5>Time left : <span id="t<%= prods.get(0).getId()%>"></span></h5>
                <%=prods.get(0).getComment()%>
                <hr />
                <% BidMgr bm = new BidMgr();
                    ArrayList<Bid> bids = bm.getAllProductBids(prods.get(0).getId());
                    if(bids != null && bids.size() > 0)
                    {%>
                        <div class="Mrg8">
                            Last bid: CAD <%= bids.get(0).getPrice()%> (by user <%= bids.get(0).getUserName() %> posted on <%= bids.get(0).getBidDate()%>)
                        </div>
                    <%}
                        java.util.Date prodTime = prods.get(0).getDate();
                        prodTime.setMinutes(prodTime.getMinutes() + 5);
                        java.util.Date sysTime = new java.util.Date();

                        %>SysTime: <%= sysTime%> | ProdTime: <%= prodTime%>   <%
                    if(!mm.isLoggedIn()){
                    %>
                    <div class="Mrg4 B1 R">
                        <h1>For bidding please sign in or register..</h1>
                    </div>
                    <%
                    }
                    else if(mm.getLoggedInUser().equals(prods.get(0).getOwnerUserName())){%>
                <div class="Mrg4 B1 R">
                    <form action="verifyBid.jsp" method="post">
                        Welcome Mr./Mrs. <b><%=mm.getLoggedInUser() %></b><br/>
                        <h2>The owner cannot place bid on his/her product.</h2>
                    </form>
                </div>
                <%}
                    // && pm.whoIsOwner(prods.get(0).getId()) != mm.getLoggedInUser()
                    else if(!prods.get(0).getIsSold() && sysTime.before(prodTime)){%>
                        <div class="Mrg4 B1 R">
                            <form action="verifyBid.jsp" method="post">
                                Welcome Mr./Mrs. <b><%=mm.getLoggedInUser() %></b><br/>
                                Your bid: <input name="bidValue" type="text" /><br />
                                <input type="hidden" name="prodId" value="<%=prods.get(0).getId()%>" />
                                <input type="hidden" name="prodPrice" value="<%=prods.get(0).getPrice()%>" />
                                <input type="submit" name="bidAction" value="Submit"/>
                            </form>
                        </div>
                    <%}
                    else{
                    %>
                    <div class="Mrg4 B1 R">
                        <h1>This product is expired and sold..</h1>
                    </div>
                <%}%>
            </div>
        <%}
        else{%>
            <jsp:forward page="products.jsp" />
        <%}%>
</div>
</body>
</html>
