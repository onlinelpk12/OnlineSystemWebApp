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
            width: 50px;
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
          
	       .richTextEditor{
	       		height: 10rem;
	       		width: 100%;
	       }
	       
	       #title{
	       		width: 80%;
	       		height: 5rem;
	       }
	       .head{
	       		display: flex;
	       		justify-content: space-between;
	       		align-items: center;	
	       }
    </style>

    <link rel="stylesheet" href="../styles/assessmentList.css">
    <script src="../js/lessonDataStructureJSON.js"></script>
    <script src="../js/script.js"></script>   
</head>
<body>
	    <%@ include file = "authRoutes.jsp" %>
	<%@ include file = "header1.jsp" %>
	  <div class="container">
					<div class="head">
						<div class="selectContent">
				    		<select name="lesson" id="lessons">
							  
							  
							</select>
				    	</div>
				    	<div class="selectContent">
				    		<select name="course" id="courses">
							  <option value="1">OnlineLPK12</option>
							  <option value="2">LogicLDS</option>
						
							</select>
				    	</div>
					<button
		                type="submit"
		                id="submit"
		                class="btn btn-primary submit_btn w-50 my-4 centered-text"
		              >
		                Save
		              </button>
					</div>
					<input class="richTextEditor" contenteditable="true" id="assessment_desc" placeholder = "Assessment Description Content Editor"></input>

				<div class="displayContent"></div>
				<input class="richTextEditor" contenteditable="true" id="codeEditor" placeholder = "Code Snippet Editor for the assessment"></input>
				
					

	  </div>
    



<%@ include file = "footer1.jsp" %>
<script type="text/javascript">

</script>
<script src="../js/lesson4.1/validations.js" type="text/javascript">  </script>
<script>
	const lessons = document.getElementById('lessons');
	const courses = document.getElementById('courses');
	const question = document.getElementById('assessment_desc');
	const answer = document.getElementById('codeEditor')
	const userIdInSession = sessionStorage.getItem("userId");
	const userRoleInSession = sessionStorage.getItem("userRole");

	
	var optionsArr = []
	
	for(var i = 1; i<=200; i++ ){
		optionsArr.push(i)
	}
	
	optionsArr.forEach(data => {
		const newOption = new Option('Lesson ' + data, data)
		lessons.add(newOption)
	})
	
	
	function saveAssessment(){
		const selectedLesson = lessons.value;
		const selectedCourse = courses.value;
		
		if(!userId){
			alert('There is no userId available, sorry cannot create assessment')
			return;
		}
		
		if(userRoleInSession !== "Teacher"){
			alert("Only teacher can create assessments, no authorization for others")
			return;
		}
		
		if(question.value == '' || answer.value == '') {
			alert('The question and answer field cannot be empty');
			return;
		}
		
		//the created_by should come from the session stored user, but the login functionality is not working right now, so just doing it manually
		const requestData = {
				lessonId: parseInt(selectedLesson),
				courseId: parseInt(selectedCourse),
				question: question.value,
				answer: answer.value,
				createdBy: userIdInSession,
				modifiedBy: userIdInSession
		}
		
		console.log(requestData)
		
		const apiUrl = 'https://localhost:7155/api/LessonAssessment/add'
	        
	        $.ajax({
	            url: apiUrl,
	            type: 'POST',
	            contentType: 'application/json',
	            data: JSON.stringify(requestData),
	            success: function(response) {
	                console.log("Response:", response);
	                if (response.errors.length == 0) {
	                	if(response.message == "An error occurred while saving the entity changes. See the inner exception for details.") {
	                		alert("Only the teacher who created this lesson can create an assessment for this, you are not eligible")
	                	}
	                	else alert(response.message);
	                } else {
	                    alert("Failed to add the Assessment.");
	                }
	            },
	            error: function(xhr, status, error) {
	                console.log("Error:", xhr.responseText);
	                alert("Error occurred while adding the Assessment: " + xhr.responseText, "error");
	            }
	        });
	}
	
	document.getElementById('submit').addEventListener('click', saveAssessment)
</script>
</body>
</html>
