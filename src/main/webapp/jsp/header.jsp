<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Online LPK12 Course</title>
<style>
    /* Global Styles */
    body {
        margin: 0;
        padding-top: 60px; 
        font-family: Arial, sans-serif;
    }
    
    /* Header Styles */
    .header {
        position: fixed;
        top: 0;
        width: 100%;
        height: 60px;
        background-color: #2196F3;
        color: #fff;
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 0 20px;
        z-index: 1000;
    }
    
    .header img {
        width: 30px;
        height: auto;
        margin-right: 10px;
        cursor: pointer;
    }
    
    .header h2 {
        margin: 0;
    }
    
    .user-info {
        margin-right: 20px;
    }
    
    .logout-btn button {
        border: none;
        background-color: transparent;
        color: #fff;
        cursor: pointer;
        font-size: 16px;
    }
    
    @media screen and (max-width: 768px) {
        .header {
            height: 80px;
        }
        
        .header h2 {
            font-size: 18px;
        }
    }
</style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="header">
                <div class="col-md-3">
                    <a href="#" id="goBackButton" onclick="history.back()">
                        <img src="../images/back.png" alt="Go Back">
                    </a>
                    <a id="homepagelink" href="home.jsp">
                        <img src="../images/home.png" alt="Home">
                    </a>
                </div>
                <div class="col-md-6">
                    <h2>Welcome to Online LPK12 Course</h2>
                </div>
                <div class="col-md-3 d-flex justify-content-end">
                    <div class="user-info">
                        <h4><span id="userNameSpan"></span></h4>
                    </div>
                    <div class="logout-btn">
                        <button onclick="sessionclear()">Logout</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    window.onload = function() {
        let usernameSpan = document.getElementById("userNameSpan");
        let username = sessionStorage.getItem("username");

        if (!username) {
            window.location.href = "login.html"; // Redirect to login if no username is found
        } else {
            usernameSpan.innerHTML = username;
        }

        let homepagelink = document.getElementById("homepagelink");
        homepagelink.href = sessionStorage.getItem("userRole") === "Teacher" ? "hometeacher.jsp" :
            sessionStorage.getItem("enrolledCourses") === "LPK12" ? "home_student_logicds.jsp" :
            sessionStorage.getItem("enrolledCourses") === "OnlineLPK12" ? "home_student_onlinelpk12.jsp" : "home.jsp";
    }

    function sessionclear() {
        sessionStorage.clear();
        window.location.href = "login.html"; 
    }
</script>
</body>
</html>
