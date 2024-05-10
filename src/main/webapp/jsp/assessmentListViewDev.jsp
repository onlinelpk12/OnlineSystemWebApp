 <%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Assessment List</title>
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
    <%@ include file = "authCourseDeveloper.jsp" %>
	<%@ include file = "header1.jsp" %>
	  <div class="container">
<div style="text-align:right;" >
	  <a href="createAssessment.jsp">
	  	<button class="btn btn-primary submit_btn my-4 centered-text" style="padding: 8px; font-size: 13px; width: 140px;" id="createAssessment">Create Assessment</button>
	  </a>
	  </div>
  <div class="row">
    <div class="col-4">
	    <div class="courseList">
	    	<div class="selectHead">Select Courses</div>
	    	<div class="selectContent">
				<select name="courses" id="courses" class="selectContentList">
				  <option value="1">OnlineLPK12</option>
				  <option value="2">LogicDS</option>
				</select>
	    	</div>
	    </div>
	    <div class="lessonList">
	    	<h3 class="selectHead">Select Lessons</h3>
	    	<div class="selectContent">
	    		<select name="lesson" id="lessons" class="selectContentList">
				 
				  
				</select>
	    	</div>
	    </div>
	    <button class="btn btn-primary submit_btn my-4 centered-text" style="padding: 8px; font-size: 13px; width: 140px;" id="fetchAssessment">Fetch Assessments</button>
    </div>
    <div class="col-8">
    <h2>Assessments</h2>
      <div id="cardContainer" class="cardContainer">
      </div>
    </div>

  </div>
</div>
    



<%@ include file = "footer1.jsp" %>
<script type="text/javascript">
	const container = document.getElementById("cardContainer");
	const lessons = document.getElementById('lessons')
	const courses = document.getElementById('courses')
	
	var optionsArr = []
	
	for(var i = 1; i<=200; i++ ){
		optionsArr.push(i)
	}
	
	optionsArr.forEach(data => {
		const newOption = new Option('Lesson ' + data, data)
		lessons.add(newOption)
	})

    
    function fetchAllAssessments(){
    	var apiUrl = 'https://localhost:7155/api/LessonAssessment/getAllAssessments' + '?courseId=' + parseInt(courses.value) + '&lessonId=' + parseInt(lessons.value)
    	    
    	
    	$.ajax({
            url: apiUrl,
            type: 'GET',
            contentType: 'application/json',
            success: function(response) {
                console.log("Response:", response);
                if (response.errors.length == 0) {
                	createCards(response.content)
                	console.log(response)
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
	
    function createCards(items){
    	container.innerHTML = ""; // Clear previous content
    	if(items.length == 0) {
    		container.innerHTML = 'No assessments to display'
    	}
    	items.forEach(function(item) {
            var card = document.createElement("div");
            card.classList.add("card");

            // Create anchor element
            var link = document.createElement("a");
            var params = "courseId=" + item.courseId + "&assessmentId=" + item.assessmentId + "&lessonId=" + item.lessonId
            var url = 'http://localhost:8080/OnlineSystemWebApp/jsp/assessmentGrades.jsp?' + params
            link.href = url; // Dynamically set href
            link.textContent = "Assessment " + item.assessmentId;

            // Append anchor element to card
            card.appendChild(link);
            
            // Append card to container
            container.appendChild(card);
        });
    }
    
    document.getElementById('fetchAssessment').addEventListener('click', fetchAllAssessments)


</script>
<script src="../js/lesson4.1/validations.js" type="text/javascript">  </script>
</body>
</html>