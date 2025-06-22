<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@include file="/dbconn.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="login.css">
        <title>Login Page</title>
    </head>
    <body>
        <h1>Login Page</h1>
        <a href="/Ajavaca2/index.jsp">Go to main page</a>
        <br>
        <form method="POST">
            <p>Enter your Registered email</p>
            <input type="email" name="email" required>
            <p>Enter your Registered password</p> 
            <input type="password" name="password" required><br>
            <br>
            <input type="submit" value="Login"> 
        </form>
        <br><br>
        <p>Not signed in yet? Click <a href="/Ajavaca2/register/register.jsp">here</a></p>
    </body>
</html>

<%
    if(request.getMethod().equalsIgnoreCase("POST")){
        String email=request.getParameter("email");
        String pass=request.getParameter("password");
        if(email!=null && pass!=null){
            PreparedStatement stmt=null;
            try{
                String query="select * from customers where email=? And password=?";
                stmt=connection.prepareStatement(query);
                stmt.setString(1,email);
                stmt.setString(2,pass);
                
                ResultSet rs=stmt.executeQuery();
                if (rs.next()){
                    session.setAttribute("email",email);
                    out.println("<p class='success'>Login successful!</p>");
                    response.sendRedirect("/Ajavaca2/index.jsp");
                }
                else{
                    out.println("<p class='error'>Email does not exist</p>");
                }
            }catch(Exception e){
                out.println("<p class='error'>" + e + "</p>");
            }
        }else{
            out.println("<p class='error'>Both email and password are required</p>");
        }
    }
%>
