package com.DM.entity;

public class Dormitorie {
    private String DormID;
    private String BuildingNumber;
    private int Floor;
    private int Rooms;
    private String Status;

    public String getDormID() {
        return DormID;
    }

    public void setDormID(String dormID) {
        DormID = dormID;
    }

    public String getBuildingNumber() {
        return BuildingNumber;
    }

    public void setBuildingNumber(String buildingNumber) {
        BuildingNumber = buildingNumber;
    }

    public int getFloor() {
        return Floor;
    }

    public void setFloor(int floor) {
        Floor = floor;
    }

    public int getRooms() {
        return Rooms;
    }

    public void setRooms(int rooms) {
        Rooms = rooms;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String status) {
        Status = status;
    }
}
