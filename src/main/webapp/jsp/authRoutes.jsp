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
	const username = sessionStorage.getItem("username");
	const token = sessionStorage.getItem("token")

	function validateRoutes() {

		if (!token) {
	        window.location.href = "login.html"; // Redirect to login page if no token
			alert('Please Login first to access this particular Resource')
	    }
		
		
	}
	
	document.addEventListener("DOMContentLoaded", validateRoutes);
</script>
</html>
