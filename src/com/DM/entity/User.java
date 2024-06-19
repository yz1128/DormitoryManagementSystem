package com.DM.entity;

/**
 * User实体类
 */
public class User {
    private int userID;
    private String userName;
    private String password;
    private String confirmPassword;
    private String contact;
    private String newUserPassword1;
    private String newUserPassword2;

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getConfirmPassword() {
        return confirmPassword;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getNewUserPassword1() {
        return newUserPassword1;
    }

    public void setNewUserPassword1(String newUserPassword1) {
        this.newUserPassword1 = newUserPassword1;
    }

    public String getNewUserPassword2() {
        return newUserPassword2;
    }

    public void setNewUserPassword2(String newUserPassword2) {
        this.newUserPassword2 = newUserPassword2;
    }
}
