package com.DM.entity;

public class Dormitories {
    private String dormID;
    private String buildingNumber;
    private int floor;
    private int rooms;
    private String status;

    public String getDormID() {
        return dormID;
    }

    public void setDormID(String dormID) {
        this.dormID = dormID;
    }

    public String getBuildingNumber() {
        return buildingNumber;
    }

    public void setBuildingNumber(String buildingNumber) {
        this.buildingNumber = buildingNumber;
    }

    public int getFloor() {
        return floor;
    }

    public void setFloor(int floor) {
        this.floor = floor;
    }

    public int getRooms() {
        return rooms;
    }

    public void setRooms(int rooms) {
        this.rooms = rooms;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
