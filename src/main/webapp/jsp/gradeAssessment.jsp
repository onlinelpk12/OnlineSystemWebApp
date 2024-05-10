 <%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Assessment View</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>

	 <link rel="stylesheet" href="../styles/assessmentListView.css">
	 <style>

	 .scrollableDiv{
	 		height: 400px;
	 		overflow-y:auto;
	 		overflow-x:hidden;  
	 }
    
    body
    	{
            font-family: Arial, sans-serif;
            font-size: 14px;
            overflow-x:hidden;
        }
 
       
 
        h2 
        {
            margin-bottom: 20px;
            text-align: center;
            color: #0056b3;
        }
 
        ul 
        {
            margin-bottom: 30px;
        }
        
        section 
        {
	        margin-top:0!important;
	        margin-left:0!important;
	        min-height:100vh;
        }
 
        button.btn 
        {
            width: 100px;
        }
         .row
          {
			    border-radius: 10px; /* Rounded corners */
			    
			   
			   .lesson-list 
			   {
			    	padding-left: 0; /* Remove default left padding */
			   }
			 
			.lesson-list .sub-points 
			{
			    padding-left: 20px; /* Add some padding to the sub-points for hierarchy */
	        }
   
          }
    </style>

    <link rel="stylesheet" href="../styles/assessmentList.css">
    <script src="../js/lessonDataStructureJSON.js"></script>
    <script src="../js/script.js"></script>   
</head>
<body>
	<%@ include file = "authRoutes.jsp" %>
    <%@ include file = "AuthTeacher.jsp" %>
	<%@ include file = "header1.jsp" %>
	  <div class="container">
	  	<h1 id='studentHeading'></h1>
		<div class="displayArea">
			
		</div>
		<div class="row">
			<div class="col-4">
				<div>
					<input class="richTextEditor" contenteditable="true" id="grade" placeholder="enter grade here"></input>
				</div>
			</div>
			<div class="col-8">
				<div class="displayContent"></div>
				<div class="col-8"><input class="richTextEditor" contenteditable="true" id="comments" placeholder="enter comments"></input></div>
				<div class="col-4">
					<button
		                type="submit"
		                id="submitGrade"
		                class="btn btn-primary submit_btn w-50 my-4 centered-text"
		              >
		                Submit
		              </button>
				</div>
			</div>
		</div>
	  </div>
    



<%@ include file = "footer1.jsp" %>
<script type="text/javascript">
	//const studentAnswer = document.getElementById('studentAnswer')
	const comments = document.getElementById('comments')
	const grade = document.getElementById('grade')
	const submitGrade = document.getElementById('submitGrade')
	
	//Function to retrieve query parameters
	function getQueryParams() {
	    // Retrieve the query string from the URL, excluding the leading '?'
	    const queryString = window.location.search.substring(1);
	    
	    // Split the string into key-value pairs
	    const params = queryString.split('&');
	    
	    // Create an object to hold the key-value pairs
	    const queryParams = {};
	    
	    params.forEach(pair => {
	        // Split each pair into key and value
	        const [key, value] = pair.split('=');
	        
	        // Decode the value and assign it to the key
	        queryParams[decodeURIComponent(key)] = decodeURIComponent(value);
	    });
	    
	    return queryParams;
	}
	
	function loadParams(){
		// Use the function to obtain parameters
		params = getQueryParams();
		console.log(params); // Will display an object with the query parameters
	}
	
	function gradeSubmission(){
		if(params == ''){
			alert('something went wrong with loadinng data, try again')
			return;
		}
		var parameters = "courseId=" + params.courseId + "&assessmentId=" + params.assessmentId + "&lessonId=" + params.lessonId + "&studentId=" + params.studentId + "&submissionId=" + params.submissionId
		var apiUrl = 'https://localhost:7155/api/LessonAssessment/addGrade?' + parameters 
				
		if(comments.value == '' || grade.value == ''){
			alert('the comments and grades should not be empty')
			return;
		}
		
		
		console.log(apiUrl)
		
		const requestData = {
				teacherId: params.teacherId,
				grade: grade.value,
				comments: comments.value
		}
		
	    	
    	$.ajax({
            url: apiUrl,
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(requestData),
            success: function(response) {
                console.log("Response:", response);
                if (response.errors.length == 0) {
                	if(response.message == "An error occurred while saving the entity changes. See the inner exception for details."){
                		alert("grade already exists")
                	}
                } else {
                    alert("Failed to fetch the Assessments.");
                }
            },
            error: function(xhr, status, error) {
                console.log("Error:", xhr.responseText);
                alert("Error occurred while fetching the Assessments: " + xhr.responseText, "error");
            }
        });
	}
	
	submitGrade.addEventListener('click', gradeSubmission)
	
	window.addEventListener('DOMContentLoaded', loadParams)
	
</script>
<script src="../js/lesson4.1/validations.js" type="text/javascript">  </script>
</body>
</html>