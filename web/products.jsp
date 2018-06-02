<%@ page import="java.util.ArrayList" %>
<%@ page import="com.AuctionSystem.models.Product" %>
<%@ page import="com.AuctionSystem.bll.ProductMgr" %><%--
  Created by IntelliJ IDEA.
  User: Sadra
  Date: 11/22/15
  Time: 4:51 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.AuctionSystem.bll.*" %>
<%@ page import="com.AuctionSystem.models.Bid" %>
<%! MembershipMgr mm; %>
<%! ProductMgr pm;%>
<%! BidMgr bm;%>
<%! String tempBid; %>
<% mm = MembershipMgr.getCurrent(session,response, request); %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Sadra's Auction System | All Products</title>
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
    <link href="css/styles.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        function addTimer(elementId, initVal){
            elem = document.getElementById('t' + elementId);
            price = document.getElementById('price' + elementId);

            if(elem == null || initVal == null || initVal < 1){
                if(price.innerHTML.indexOf('given by users') < 0) {
                    initVal = 300;
                }
                else {
                    elem.innerHTML = "<b>Sold!</b>";
                    bb = document.getElementById('btnBid' + elementId);
                    bb.style.display = "none";
                    return;
                }
            }

            if(initVal > 60)
                elem.innerHTML = "<b>"+Math.floor(initVal/60)+":"+(initVal%60)+"</b>";
            else elem.innerHTML = "<b>"+initVal+"</b>";

            setTimeout(function(){
                addTimer(elementId,initVal-1);
            },1000);
        }
        function loader(){
            <%
            pm = new ProductMgr();
            bm = new BidMgr();

            ArrayList<Product> prods = new ArrayList<Product>();
            try{

                prods = pm.getAllProducts();
                if(prods == null)
                {
                    %>alert('MySQL connection error...');<%
                }
                else
                {
                    for (int i = 0 ; i < prods.size(); i++)
                    {%>
                    addTimer('<%=prods.get(i).getId()%>',<%=prods.get(i).getRemainingTime()%>);
                    <%}
                }
            }
            catch (Exception ex){
                %>alert('<%=ex.getMessage()%>');<%
            }
            %>
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
                <li><a class="active" href="#">Products</a></li>
                <li><a href="/login.jsp">Login</a>me</li>
                <li><a href="/register.jsp">Register</a></li>
            </ul>
        </div>
        <!--- menu ends here -->
    </div>
    <!---headerends here -->
</div>
<div class="clear"></div>
<div class="Products">
    <%
        for (int i = 0 ; i < prods.size(); i++)
    {
        ArrayList<Bid> bids = bm.getAllProductBids(prods.get(i).getId());
        if(bids.size() > 0)
            tempBid = "" + bids.get(0).getPrice() + " given by users";
        else tempBid = "" + prods.get(i).getPrice();
    %>
        <div class="Product B1">
            <%--<img src="products/<%=prods.get(i).getId()%>.jpg" alt="Product Image" /><br/>--%>
            <div>
                <h1><%=prods.get(i).getName()%></h1>
                <h3 id="price<%= prods.get(i).getId()%>">Price : CAD <%=tempBid%></h3>
                <h5>Time left : <span id="t<%= prods.get(i).getId()%>"></span></h5>
            </div><br/>
            <a id="btnBid<%=prods.get(i).getId()%>" href="productshow.jsp?id=<%=prods.get(i).getId()%>" style="float: right; padding-right: 1px" class="Button">Place Bid</a>
        </div>
    <%}
    %>
</div>
</body>
</html>
