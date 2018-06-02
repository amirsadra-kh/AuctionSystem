<%@ page import="com.AuctionSystem.bll.*" %>
<%@ page import="java.util.Random" %>
<%@ page import="com.AuctionSystem.models.Product" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.AuctionSystem.models.Bid" %>
<%! MembershipMgr mm; %>
<%! ProductMgr pm; %>
<%! BidMgr bm; %>
<%! String tempBid; %>
<% mm = MembershipMgr.getCurrent(session,response, request); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Sadra's Auction System | User Products</title>
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
                <li><a href="/register.jsp">Register</a></li>
            </ul>
        </div>
        <!--- menu ends here -->
    </div>
    <!---headerends here -->
</div>
<!---header-wrapper-ends here -->
<div class="clear"></div>

<div class="Products">
<%
    if(!mm.isLoggedIn())
        response.sendRedirect("login.jsp?randNum=" + (new Random()).nextInt());
%>

<%
    pm = new ProductMgr();
    bm = new BidMgr();
    ArrayList<Product> prods = pm.getProductsByOwner(mm.getLoggedInUser());

    for (int i = 0 ; i < prods.size(); i++)
    {
        ArrayList<Bid> bids = bm.getAllProductBids(prods.get(i).getId());
        if(bids.size() > 0)
            tempBid = "" + bids.get(0).getPrice();
        else tempBid = "" + prods.get(i).getPrice();
%>
<div class="Product B1">
    <img src="products/<%=prods.get(i).getId()%>.jpg" alt="Product Image" /><br/>
    <div>
        <h1><%=prods.get(i).getName()%></h1>
        Last Bid : CAD <%=tempBid %>
    </div><br/>
    <a href="productshow.jsp?id=<%=prods.get(i).getId()%>" class="PButton"><img src="Images/btnBid.png" /></a>
    <a onclick="return confirm('Are you sure, you want to delete this product?');"
       href="verifyProd.jsp?act=Delete&prodId=<%=prods.get(i).getId()%>" class="PButton Delete"> X </a>
</div>
<%}
%>
</div>
<div class="clear"></div>

<div class="footer-wrapper">
    <div class="footer">
        <div class="footer-content">
            <h1>Offer new product</h1>
            <div>
                <form enctype="multipart/form-data" action="verifyProd.jsp">
                    <input type="text" name="prodName" class="quickreg" placeholder="Name of product" />

                    <input type="text" name="prodPrice" class="quickreg" placeholder="Price"/>

                    <input type="file" name="prodFile" class="quickreg" placeholder="Select the picture file"/>

                    <textarea rows="3" cols="100" name="prodComment" class="quickreg" placeholder="Comments of the product" ></textarea>

                    <input type="submit" name="act" value="Add"/>
                </form>
            </div>
        </div>
        <div class="footer-content">
            <h1>Be update</h1>
            <p>
                You can Remove or set the product as Sold.
                <br/>
                And, you can always look for sold ones...
            </p>
        </div>
        <div class="footer-content">
            <h1>5 Minutes</h1>
            <p>
                Each product has 5 minutes to be sold<br/>
                The project dicipline!!!
            </p>
        </div>

    </div>
    <div class="clear" style="text-align: center;">Copyright &copy; 2015 Amir Sadra Khorramizadeh. All rights reserved.</div>
</div>
<!---footer-wrapper ends here-->
</body>
</html>