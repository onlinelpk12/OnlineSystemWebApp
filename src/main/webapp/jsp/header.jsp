<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Online LPK12 Course</title>
</head>
<body>
	<script type="text/javascript">
		/* window.onload = function() {
			let usernameEle = document.getElementById("userName");
			usernameEle.innerHTML = sessionStorage.getItem("username");

			let homepagelink = document.getElementById("homepagelink");
			homepagelink.href = sessionStorage.getItem("userRole") == "Teacher" ? "hometeacher.jsp" : 
				    sessionStorage.getItem("enrolledCourses") == "LPK12" ? "home_student_logicds.jsp": 
				    	sessionStorage.getItem("enrolledCourses") == "OnlineLPK12" ? "home_student_onlinelpk12.jsp": "home.jsp";
			
			} */
			window.onload = function() {
			    let usernameEle = document.getElementById("userName");
			    let usernameSpan = document.getElementById("userNameSpan");
			    let username = sessionStorage.getItem("username");

			    usernameEle.innerHTML = username;
			    usernameSpan.innerHTML = username;

			    let homepagelink = document.getElementById("homepagelink");
			    homepagelink.href = sessionStorage.getItem("userRole") == "Teacher" ? "hometeacher.jsp" : 
			        sessionStorage.getItem("enrolledCourses") == "LPK12" ? "home_student_logicds.jsp": 
			        sessionStorage.getItem("enrolledCourses") == "OnlineLPK12" ? "home_student_onlinelpk12.jsp": "home.jsp";
			}
	</script>

	<div class="container-fluid bg-primary text-white"
		style="width: 100%; height: 10%; margin-bottom: 5%; padding-top:1.2%">
		<div class="row">
			<div class="col-md-3">
			<form action="header.jsp">
				<a href="#" id="goBackButton" onclick="history.back()"
					style="margin-top: 0px"><img height="30" width="40"
					src="../images/back.png" style="margin-top: 0px"></a>
				<a id="homepagelink" href="home.jsp" style="margin-top: 0px"><img
					height="30" width="40" src="../images/home.png"
					style="margin-top: 0px"></a>
			</form>
		</div>


		<div class="col-md-6 d-flex justify-content-center">
			<!-- <h2 id="title" style="color: white">Welcome to Online LPK12
				Course</h2> -->
				<h2 id="title" style="margin-top: 0px; color: white">Welcome <span id="userNameSpan"></span> to Online LPK12 Course</h2>
				
		</div>
<!-- 
		<div class="col-md-2 d-flex justify-content-center" style="margin-top: 0px">
			<h4 id="userName" style="color: white"></h4>
		</div> -->
		<div class="col-md-1">
			<a onclick="sessionclear()" style="margin-top: 0px; margin-left: 200px;"
				class="btn btn-warning">Logout</a>
		</div>
		</div>

		
	</div>
</body>
<script type="text/javascript">
	function sessionclear() {

		sessionStorage.clear();
		window.location.href = "login.html"
	}
</script>
</html>
