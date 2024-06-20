<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>居住记录</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<%@include file="sidebar.jsp"%>
<%
    if (session.getAttribute("teacher") == null) {
        response.sendRedirect("login.jsp");
    }
%>
<div id="wrapper">
    <div id="page-content-wrapper">
        <div class="container-fluid">
            <div id="checkinrecord-container">
            </div>
        </div>
    </div>
</div>
<%@include file="footer.jsp" %>
<script>
    $(document).ready(function() {
        $.ajax({
            type: "POST",
            url: "selectCIRByIDServlet?teacherID=<%= teacherID %>",
            dataType: "json",
            success: function(data) {
                var checkinrecords = data;
                var container = $("#checkinrecord-container");
                container.empty();

                var table = "<table style='width: 100%; border-collapse: collapse;'>" +
                    "<thead>" +
                    "<tr>" +
                    "<th style='border: 1px solid #ddd; padding: 8px;'>房间号</th>" +
                    "<th style='border: 1px solid #ddd; padding: 8px;'>入住日期</th>" +
                    "<th style='border: 1px solid #ddd; padding: 8px;'>退宿日期</th>" +
                    "<th style='border: 1px solid #ddd; padding: 8px;'>状态</th>" +
                    "<th style='border: 1px solid #ddd; padding: 8px;'>操作</th>" +
                    "</tr>" +
                    "</thead>" +
                    "<tbody>";

                for (var i = 0; i < checkinrecords.length; i++) {
                    var checkinrecord = checkinrecords[i];
                    var status = (checkinrecord.checkInDate && checkinrecord.checkOutDate) ? "退宿" : "入住";
                    table += "<tr>" +
                        "<td style='border: 1px solid #ddd; padding: 8px;'>" + checkinrecord.dormID + "</td>" +
                        "<td style='border: 1px solid #ddd; padding: 8px;'>" + checkinrecord.checkInDate + "</td>" +
                        "<td style='border: 1px solid #ddd; padding: 8px;'>" + (checkinrecord.checkOutDate ? checkinrecord.checkOutDate : "") + "</td>" +
                        "<td style='border: 1px solid #ddd; padding: 8px;'>" + status + "</td>" +
                        "<td style='border: 1px solid #ddd; padding: 8px;'>" +
                        "<button class='CheckOut-btn' data-recordID='" + checkinrecord.recordID + "'>退宿</button>" +
                        "</td>" +
                        "</tr>";
                }

                table += "</tbody></table>";
                container.append(table);

                // Event handling for the CheckOut buttons
                $(".CheckOut-btn").click(function() {
                    var recordID = $(this).data("recordID");
                    var checkOutDate = new Date().toISOString().slice(0, 19).replace('T', ' ');

                    console.log("recordID: " + recordID); // Debug information
                    console.log("checkOutDate: " + checkOutDate); // Debug information

                    $.ajax({
                        type: "POST",
                        url: "updateRecordServlet",
                        data: { recordID: recordID, checkOutDate: checkOutDate },
                        success: function(response) {
                            alert(response.msg);
                            // Optionally update UI or reload data
                        },
                        error: function(xhr, status, error) {
                            console.error(error);
                            alert("更新失败，请稍后再试。");
                        }
                    });
                });

            },
            error: function(xhr, status, error) {
                console.error(error);
                alert("数据加载失败，请稍后再试。");
            }
        });
    });
</script>
</body>
</html>
