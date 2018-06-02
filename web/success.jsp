<%@ page import="java.util.Random" %>
<h3>Registration was successful!</h3>
<a href="login.jsp?randNum=<%=(new Random()).nextInt() %>">Click here to login to the system.</a>
