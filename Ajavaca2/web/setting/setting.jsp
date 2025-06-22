<%@page import="java.sql.PreparedStatement" %>
<%@ include file="/dbconn.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="setting.css">
        <title>Settings Page</title>
    </head>
    <body>
        <div class="container">
            <h1>Settings Page</h1>
            <form method="POST" action="setting.jsp">
                <div class="form-group">
                    <label for="updatedname">Update your Username:</label>
                    <input type="text" name="updatedname" id="updatedname" placeholder="Enter new username" required>
                </div>
                <input type="submit" value="Update" class="submit-btn">
            </form>
            <p class="delete-account">To delete your account, click <a href="deleteUser.jsp">Here</a></p>
        </div>
    </body>
</html>

<%
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String updatedName = request.getParameter("updatedname");
        String email = (String) session.getAttribute("email");
        if (email == null) {
            out.println("<p>Error: Session expired or invalid. Please log in again.</p>");
        } else if (updatedName != null && !updatedName.trim().isEmpty()) {
            PreparedStatement pst = null;
            try {
                String query = "UPDATE customers SET username = ? WHERE email = ?";
                pst = connection.prepareStatement(query);
                pst.setString(1, updatedName);
                pst.setString(2, email);

                int rowsUpdated = pst.executeUpdate();
                if (rowsUpdated > 0) {
                    out.println("<p class='success'>Username updated successfully!</p>");
                } else {
                    out.println("<p class='error'>Failed to update username. Please try again.</p>");
                }
            } catch (Exception e) {
                out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
            } finally {
                if (pst != null) try { pst.close(); } catch (Exception ex) { }
            }
        } else {
            out.println("<p class='error'>Please enter a valid username to update.</p>");
        }
    }
%>
