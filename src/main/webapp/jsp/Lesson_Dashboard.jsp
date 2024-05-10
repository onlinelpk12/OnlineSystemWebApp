<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Lesson Dashboard</title>
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
    <%@ include file = "header.jsp" %>
    <!-- Custom CSS -->
    <style>
        a.disabled {
            /* Make the disabled links grayish */
            color: gray;
            /* And disable the pointer events */
            pointer-events: none;
        }
        .lesson-item {
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
       
        #lessonList {
            list-style-type: disc; /* Apply bullets to list items */
            padding-left: 20px; /* Adjust padding for bullets */
            list-style-position: inside; /* Ensure bullets are displayed inside the flex container */
        }
    </style>
</head>
<body>
    <!-- Container for content -->
    <div class="container">
        <div class="row gx-4">
            <!-- First column for Lessons heading -->
            <div style="display: flex; margin: 10px 0px;">
                <!-- Search bar -->
                <input type="text" class="form-control search-bar" placeholder="Search..." id="searchInput">
                <button class="btn btn-primary" data-toggle="modal" data-target="#createLessonModal" style="border-radius: 999px;">Create Lesson</button>
                <!-- Button for creating a lesson -->
            </div>
        </div>
        <div>
            <h2>Lessons:</h2>
            <ul id="lessonList"></ul>
        </div>
    </div>

    <!-- Create Lesson Modal -->
    <div id="createLessonModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content -->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Create Lesson</h4>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-group">
                            <label for="lessonName">Lesson Name:</label>
                            <input type="text" class="form-control" id="lessonName">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" onclick="saveLesson()" style="border-radius: 999px;">Save</button>
                    <button type="button" class="btn btn-danger" data-dismiss="modal" style="border-radius: 999px;">Cancel</button>
                </div>
            </div>
        </div>
    </div>
    <!-- End Create Lesson Modal -->

    <!-- Include footer file -->
    <%@ include file = "footer.jsp" %>


<script type="text/javascript">
    var courseId;
    var userId = sessionStorage.getItem("userId");
    $(document).ready(function() {
         courseId = new URLSearchParams(window.location.search).get('courseId');
        if (courseId) {
            fetchLessons(courseId);
        }

        $("#searchInput").on("keyup", function() {
            var value = $(this).val().toLowerCase();
            $("#lessonList li").filter(function() {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });
    });

    function fetchLessons(courseId) {
            $.ajax({
                headers: {
                    'Authorization': "Bearer " + sessionStorage.getItem("token")
                },
                url: `https://localhost:7155/api/Course/GetLessonsToEditById/${courseId}`,
                type: "GET",
                success: function(data) {
                    $("#lessonList").empty();
                    if (data && data.content) {
                        data.content.forEach(function(lesson) {
                            var lessonElement = createLessonElement(lesson);
                            $("#lessonList").append(lessonElement);
                        });
                    }else {
                    	console.log("No lessons found.");
                    }
                },
                error: function() {
                    alert('No lessons to load.');
                }
            });
    }


    function createLessonElement(lesson) {
        var buttons = $("<div class='lesson-buttons'></div>");
        <%--buttons.append(`<button class='btn btn-success publish-toggle' style='border-radius: 999px;'>${lesson.isLessonAvailable ? "Unpublish" : "Publish"}</button>`);--%>
        buttons.append($("<button class='btn publish-toggle' style='border-radius:999px'>").text(lesson.isLessonAvailable?"Published":"UnPublish").addClass(lesson.isLessonAvailable?"btn-success" : "btn-danger"))
        buttons.append(`<button class='btn btn-warning' style='margin-left: 5px; border-radius: 999px;' onclick='editLesson(${lesson.id})'>Edit</button>`);
        buttons.append(
        	    $("<button class='btn btn-danger' style='margin-left: 5px; border-radius: 999px'>")
        	        .text("Delete")
        	        .click(function() { deleteLesson(lesson.id, userId); }) // Pass userId as a parameter
        	);

        return $("<li class='lesson-item' style='background-color: #f2f2f2'></li>")
            .append(`<span>${lesson.lessonName}</span>`)
            .append(buttons);
    }

    function saveLesson() {
        var lessonName = $("#lessonName").val();
        if (!lessonName) {
            alert("Please enter a lesson name.");
            return;
        }
        var courseId = new URLSearchParams(window.location.search).get('courseId');
        if (!courseId) {
            alert("Course ID is not specified.");
            return;
        }

        var userId = sessionStorage.getItem("userId");
        if (!userId) {
            alert("User ID is not available. Please ensure you're logged in.");
            return;
        }

        console.log("Saving lesson:", lessonName, "for course ID:", courseId, "by user ID:", userId);

        $.ajax({
            headers:{
                'Authorization': "Bearer "+ sessionStorage.getItem("token")
            },
            url: `https://localhost:7155/api/CourseLesson/add?courseId=${courseId}`,
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify({
                "lessonName": lessonName,
                "createdBy": userId,
                "modifiedBy": userId,
                "isLessonAvailable": true
            }),
            success: function(response) {
                console.log("Lesson saved successfully:", response);
                $("#createLessonModal").modal("hide");
                $("#lessonName").val('');
                alert("Lesson added successfully.");
                fetchLessons(courseId);
            },
            error: function(xhr, status, error) {
                console.error("Error saving lesson:", xhr.responseText, "Status:", status, "Error:", error);
                alert("Failed to add lesson: " + xhr.responseText);
            }
        });
    }

    function editLesson(lessonId) {
        window.location.href = `Compiled.jsp?lessonId=${lessonId}&courseId=${courseId}`;
    }

    function deleteLesson(lessonId, userId) {
    	if (!userId) {
            alert("User ID is not available. Please ensure you're logged in.");
            return;
        }
        if (confirm("Are you sure you want to delete this lesson?")) {
            $.ajax({
                headers: {
                    'Authorization': "Bearer " + sessionStorage.getItem("token")
                },
                url: `https://localhost:7155/api/CourseLesson/delete?userId=${userId}&lessonId=${lessonId}`,
                type: "DELETE",
                success: function() {
                    alert("Lesson deleted successfully.");
                    fetchLessons(courseId);
                },
                error: function(xhr) {
                    if (xhr.status === 404) {
                        alert("Lesson not found.");
                    } else {
                        alert("Failed to delete lesson: " + xhr.statusText);
                    }
                }
            });
        }
    }


    $(document).on("click", ".publish-toggle", function() {
        var buttonText = $(this).text();
        if (buttonText === "Publish") {
            $(this).removeClass("btn-success").addClass("btn-secondary").text("Unpublish");
        } else {
            $(this).removeClass("btn-secondary").addClass("btn-success").text("Publish");
        }
    });
</script>


</body>
</html>
