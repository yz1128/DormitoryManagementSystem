<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>居住记录</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<%@include file="ADsidebar.jsp"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("ADlogin.jsp");
    }
%>
<div id="wrapper">
    <div id="page-content-wrapper">
        <div class="container-fluid">
            <div id="checkinrecord-container">
            </div>
            <div>
                <form action="addCheckInRecord" method="post" id="addForm" style="margin: 0 auto">
                    <table class="table">
                        <tr>
                            <td></td>
                            <td><h2>入住</h2></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td class="right"><label for="dormID">宿舍号：</label> </td>
                            <td><input type="text" name="dormID" id="dormID"> </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td class="right"><label for="teacherID">教工号：</label> </td>
                            <td><input type="text" name="teacherID" id="teacherID"> </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="text-align: center">
                                <span id="msg" style="font-size: 12px;color: red"> ${messageModel.msg}</span>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <input type="submit" id="add-Btn" value="提交">
                            </td>
                        </tr>
                    </table>
                </form>

            </div>
        </div>
    </div>
</div>
<%@include file="footer.jsp" %>
<script>
    $("#add-Btn").click(function () {
        var dormID = $("#dormID").val(); // 修改这里，确保获取正确的宿舍号
        var teacherID = $("#teacherID").val();;

        // 确保宿舍号和教工号不为空
        if (isEmpty(dormID)){
            $("#msg").html("宿舍号不可为空！");
            return;
        }
        if (isEmpty(teacherID)){
            $("#msg").html("教工号不可为空！");
            return;
        }
        $("#addForm").submit();
    });

    // 确保 isEmpty 函数的定义正确
    function isEmpty(str){
        return !str || str.trim() === "";
    }
    $(document).ready(function() {
        $.ajax({
            type: "GET",
            url: "checkInRecordsDataServlet",
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
                        (checkinrecord.checkOutDate ? "" : "<button class='CheckOut-btn' data-recordID='" + checkinrecord.recordID + "'>退宿</button>") +
                        "</td>" +
                        "</td>" +
                        "</tr>";
                }

                table += "</tbody></table>";
                container.append(table);

                // Event handling for the CheckOut buttons
                $(".CheckOut-btn").click(function() {
                    var recordID = $(this).data("recordid");
                    var checkOutDate = new Date().toISOString().slice(0, 19).replace('T', ' ');

                    console.log("recordID: " + recordID); // Debug information
                    console.log("checkOutDate: " + checkOutDate); // Debug information

                    $.ajax({
                        type: "POST",
                        url: "updateRecordServlet",
                        data: { recordID: recordID, checkOutDate: checkOutDate },
                        success: function(response) {
                            // Optionally update UI or reload data
                            window.location.href = "ADCheckinrecord.jsp";
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
