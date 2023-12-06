<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@page import="net.sf.json.JSONObject"%>


<%
String slidesData = request.getParameter("data");
JSONObject jsonObject = new JSONObject(slidesData);
console.log(jsonObject);

try {
    // Parse the JSON data received from the client
    //slidesData = data;

    // Perform database operations
    //for (SlideData slide : slidesData) {
    	//String course = slide.getCourse();
    	//String lesson = slide.getLesson();
        //String header = slide.getHeader();
        //String para = slide.getPara();
        //String body = slide.getBody();
        //String input = slide.getInput();

        String dbUrl = "sql.freedb.tech/freedb_onlinelpk12";
        String dbUsername = "freedb_lpk12user";
        String dbPassword = "k$NZPQDEwFG39b%";

        Connection connection = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

            String sql = "INSERT INTO slide_data (course_name, lesson_name, data) VALUES (?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, "ssd");
            statement.setString(2, "lesson1");
            statement.setString(3, '["kjjdoj"]');
            statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (connection != null) {
                connection.close();
            }
        }
    //}
} catch (Exception e) {
    e.printStackTrace();
    // Handle errors here
}
%>
