const usernameStoredInSession = sessionStorage.getItem("username");
	const userRoleStoredInSession = sessionStorage.getItem("UserRole");
	const tokenStoredInSession = sessionStorage.getItem("token")

	function validateRoutes() {
		console.log('sometidng')
		if (!tokenStoredInSession) {
	        window.location.href = "login.html"; // Redirect to login page if no token
			alert('You are already Logged In, please logout to signIn with a new account')
	    }
		
		
	}
	
	document.addEventListener("DOMContentLoaded", validateRoutes);