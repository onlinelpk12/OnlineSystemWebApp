<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Course Dashboard</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <!-- Bootstrap JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <!-- JavaScript function to clear session -->
    <script type="text/javascript">
        function reInitiateFreshPage(){
            sessionStorage.setItem("pageIdToShow",'');
        }
    </script>
    <!-- Meta charset and title -->
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <!-- Include header file -->
    <%@ include file = "authCourseDeveloper.jsp" %>
    <%@ include file = "header.jsp" %>
    <!-- Custom CSS -->
    <style>
        a.disabled {
            /* Make the disabled links grayish */
            color: gray;
            /* And disable the pointer events */
            pointer-events: none;
        }
        .course-item{
     background-color: rgb(242, 242, 242);
    display: flex;
    justify-content: space-between;
    padding: 8px;
    border-radius: 8px;
    margin-bottom: 12px;
        }
        
        .search-bar {
            margin-right: 10px; /* Adjust margin as needed */
        }
       
       #courseList {
    list-style-type: disc; /* Apply bullets to list items */
    padding-left: 20px; /* Adjust padding for bullets */
    list-style-position: inside; /* Ensure bullets are displayed inside the flex container */
}

    html {
        position: relative;
        min-height: 100%;
    }
    body {
        margin-bottom: 40px; 
        margin-top: 100px;
    }
    .footer {
        position: fixed;
        bottom: 0;
        width: 100%;
        height: 40px;
        background-color: #f5f5f5;
    }
        
    </style>
</head>
<body>
    <!-- Container for content -->
    <div class="container ">
        <div class="row gx-4">
            <!-- First column for Courses heading -->
            
             <div style="display: flex; margin: 10px 0px;">
                    <!-- Search bar -->
                    <input type="text" class="form-control search-bar" placeholder="Search..." id="searchInput">
                    <button class="btn btn-primary" data-toggle="modal" data-target="#createCourseModal"style='border-radius:999px'>Create Course</button>
                   <div style="padding-left:8px">
                   <a href="assessmentListViewDev.jsp">
					  	<button class="btn btn-primary submit_btn my-4 centered-text" style="padding: 8px; font-size: 13px; width: 140px; border-radius:999px;" id="createAssessment">Create Assessment</button>
					  </a>
                   </div> 
                    <!-- Button for creating a course -->
                </div>
            </div>
        
        <div>
            <h2>Courses:</h2>
            <ul id="courseList"></ul>
        </div>
    </div>

    <!-- Create Course Modal -->
    <div id="createCourseModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content -->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title" >Create Course</h4>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-group">
                            <label for="courseName">Course Name:</label>
                            <input type="text" class="form-control" id="courseName">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" onclick="saveCourse()"style='border-radius:999px '>Save</button>
                    <button type="button" class="btn btn-danger" data-dismiss="modal"style='border-radius:999px'>Cancel</button>
                </div>
            </div>
        </div>
    </div>
    <!-- End Create Course Modal -->

    <!-- Include footer file -->
    <div class="footer">
    <%@ include file = "footer.jsp" %>
    </div>
    


<script type="text/javascript">
    // Session variable for userId, assumed to be stored when the user logs in
    const userId = sessionStorage.getItem("userId");

    $(document).ready(function() {
        fetchCourses();

        $("#searchInput").on("keyup", function() {
            var value = $(this).val().toLowerCase();
            $("#courseList li").filter(function() {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
            });
        });
    });

    function saveCourse() {
        var courseName = $("#courseName").val();
        var postData = {
            "courseName": courseName,
            "semester": "Fall", // Assuming a default value
            "year": 2024, // Assuming a default value
            "createdBy": userId,
            "createdAt": new Date().toISOString(),
            "modifiedBy": userId,
            "modifiedAt": new Date().toISOString(),
            "isCourseAvailable": true
        };

        $.ajax({

            headers:{
                'Authorization': "Bearer "+ sessionStorage.getItem("token")
            },
            url: "https://localhost:7155/api/Course/CreateCourse",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(postData),
            success: function(data) {
                fetchCourses();
                $("#createCourseModal").modal("hide");
                $("#courseName").val('');
                alert("Course created successfully.");
            },
            error: function(error) {
                alert("Failed to create course: " + error.responseText);
            }
        });
    }

    function fetchCourses() {
        $.ajax({
            url: `https://localhost:7155/api/Course/${userId}`,
            type: "GET",
            contentType: "application/json",
            success: function(data) {
                $("#courseList").empty();
                if (data && data.content) {
                    data.content.forEach(function(course) {
                        var listItem = $("<li class='course-item'></li>")
                            .append($("<span>").text(course.courseName))
                            .append($("<span class='courseId'>").text(course.courseId).hide()) // Hide course ID
                            .append(
                                $("<div class='course-buttons'>")
                                .append($("<button class='btn btn-success publish-toggle' style='border-radius: 999px'>").text(course.isCourseAvailable ? "Unpublish" : "Publish"))
                                .append($("<button class='btn btn-warning' style='margin-left: 5px; border-radius: 999px'>").text("Edit").click(function() { editCourse(course.courseId); }))
                                .append($("<button class='btn btn-danger' style='margin-left: 5px; border-radius: 999px'>").text("Delete").click(function() { deleteCourse(course.courseId); }))
                            );

                        $("#courseList").append(listItem);
                    });
                } else {
                    console.log("No courses found.");
                }
            },
            error: function() {
                alert("Failed to load courses.");
            }
        });
    }

    function editCourse(courseId) {
        window.location.href = `Lesson_Dashboard.jsp?courseId=${courseId}`;
    }

    function deleteCourse(courseId) {
        if (confirm("Are you sure you want to delete this course?")) {
            $.ajax({
                headers:{
                    'Authorization': "Bearer "+ sessionStorage.getItem("token")
                },
                url: `https://localhost:7155/api/Course/DeleteCourse/${courseId}`,
                type: "DELETE",
                success: function() {
                    alert("Course deleted successfully.");
                    fetchCourses();
                },
                error: function(xhr) {
                    if(xhr.status === 404) {
                        alert("Course not found.");
                    } else {
                        alert("Failed to delete course: " + xhr.statusText);
                    }
                }
            });
        }
    }




    $(document).on("click", ".publish-toggle", function() {
        var buttonText = $(this).text();
        var courseId = $(this).closest('.course-item').find('.courseId').text();
        var isCourseAvailable = buttonText === "Publish" ? true : false;

        $.ajax({
            headers:{
                'Authorization': "Bearer "+ sessionStorage.getItem("token")
            },
            url: `https://localhost:7155/api/Course/UpdateAvailability/${courseId}?isCourseAvailable=${isCourseAvailable}`,
            type: "PUT",
            success: function() {
                // Toggle the button text
                $(this).text(isCourseAvailable ? "Unpublish" : "Publish");
            },
            error: function(xhr) {
                console.error("Failed to update course availability:", xhr.statusText);
                alert("Failed to update course availability.");
            }
        });
    });
</script>

</body>
</html>
