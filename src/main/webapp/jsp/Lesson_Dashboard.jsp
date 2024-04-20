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

    <!-- JavaScript function to save the lesson -->
    <script type="text/javascript">
        function saveLesson() {
            // Retrieve the lesson name from the input field
            var lessonName = $("#lessonName").val();

            // Create a new row element with the lesson name and buttons
            var newRow = $("<li class='lesson-item'></li>");
            newRow.css("background-color", "#f2f2f2"); // Set background color to ash color

            // Append the lesson name to the new row
            newRow.append("<span>" + lessonName + "</span>");

            // Add buttons for publish/unpublish, edit, and delete
            var buttons = $("<div class='lesson-buttons'></div>");
            buttons.append("<button class='btn btn-success publish-toggle' style='border-radius: 999px;'>Publish</button>");
            buttons.append("<button class='btn btn-warning' style='margin-left: 5px; border-radius: 999px;'>Edit</button>");
            buttons.append("<button class='btn btn-danger' style='margin-left: 5px; border-radius: 999px;'>Delete</button>");

            // Append buttons to the new row
            newRow.append(buttons);

            // Append the new row to the lesson list
            $("#lessonList").append(newRow);

            // Close the modal
            $("#createLessonModal").modal("hide");

            // Clear the input field for the next entry
            $("#lessonName").val("");
        }

        // Function to toggle publish/unpublish button
        $(document).on("click", ".publish-toggle", function() {
            var buttonText = $(this).text();
            if (buttonText === "Publish") {
                $(this).removeClass("btn-success").addClass("btn-secondary").text("Unpublish");
            } else {
                $(this).removeClass("btn-secondary").addClass("btn-success").text("Publish");
            }
        });

        // Function to handle search functionality
        $(document).ready(function(){
            $("#searchInput").on("keyup", function() {
                var value = $(this).val().toLowerCase();
                $("#lessonList li").filter(function() {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });
        });
    </script>
</body>
</html>
