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
	const userRole = sessionStorage.getItem("userRole")
	
	function teacherAuthRoute() {

		if (userRole != "Teacher") {
	        window.history.back(); // Redirect to previous page if user is not teacher
			alert('Access Denied!! Only Teacher can access this resource!')
	    }
		
		
	}
	
	document.addEventListener("DOMContentLoaded", teacherAuthRoute);
</script>
</html>
