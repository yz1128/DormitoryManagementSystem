package com.DM.entity;

public class CheckInRecord {
    private int RecordID;
    private int TeacherID;
    private String DormID;
    private String CheckInDate;
    private String CheckOutDate;

    public int getRecordID() {
        return RecordID;
    }

    public void setRecordID(int recordID) {
        RecordID = recordID;
    }

    public int getTeacherID() {
        return TeacherID;
    }

    public void setTeacherID(int teacherID) {
        TeacherID = teacherID;
    }

    public String getDormID() {
        return DormID;
    }

    public void setDormID(String dormID) {
        DormID = dormID;
    }

    public String getCheckInDate() {
        return CheckInDate;
    }

    public void setCheckInDate(String checkInDate) {
        CheckInDate = checkInDate;
    }

    public String getCheckOutDate() {
        return CheckOutDate;
    }

    public void setCheckOutDate(String checkOutDate) {
        CheckOutDate = checkOutDate;
    }
}
