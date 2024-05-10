<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Online LPK12 Course</title>
</head>
<body>
	

	<div> 
		
	</div>
</body>
<script type="text/javascript">
	//This javascript file is only run for login/register pages, as if there is a token already in the session storage, the user shouldn't be able to go
	// back to those pages, this jsp file is only included in the login and register pages for the time being
	const username = sessionStorage.getItem("username");
	const userRole = sessionStorage.getItem("UserRole");
	const token = sessionStorage.getItem("token")

	function validateRoutes() {

		if (token) {
	        window.location.href = "home.jsp"; // Redirect to login page if no token
			alert('You are already Logged In, please logout to signIn with a new account')
	    }
		
		
	}
	
	document.addEventListener("DOMContentLoaded", validateRoutes);
</script>
</html>
