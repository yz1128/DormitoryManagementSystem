/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80036
 Source Host           : localhost:3306
 Source Schema         : dormitorymanagementsystem

 Target Server Type    : MySQL
 Target Server Version : 80036
 File Encoding         : 65001

 Date: 20/06/2024 23:04:51
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for checkinrecords
-- ----------------------------
DROP TABLE IF EXISTS `checkinrecords`;
CREATE TABLE `checkinrecords`  (
  `RecordID` int NOT NULL AUTO_INCREMENT,
  `TeacherID` int NOT NULL,
  `DormID` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `CheckInDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `CheckOutDate` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`RecordID`) USING BTREE,
  INDEX `TeacherID`(`TeacherID` ASC) USING BTREE,
  INDEX `DormID`(`DormID` ASC) USING BTREE,
  CONSTRAINT `checkinrecords_ibfk_2` FOREIGN KEY (`DormID`) REFERENCES `dormitories` (`DormID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for dormitories
-- ----------------------------
DROP TABLE IF EXISTS `dormitories`;
CREATE TABLE `dormitories`  (
  `DormID` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `BuildingNumber` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Floor` int NOT NULL,
  `Rooms` int NOT NULL,
  `Status` enum('Vacant','Occupied','UnderMaintenance') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`DormID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for maintenancerecords
-- ----------------------------
DROP TABLE IF EXISTS `maintenancerecords`;
CREATE TABLE `maintenancerecords`  (
  `RecordID` int NOT NULL AUTO_INCREMENT,
  `DormID` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ReportDate` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `MaintenanceDate` datetime NULL DEFAULT NULL,
  `Status` enum('Pending','Completed') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Pending',
  PRIMARY KEY (`RecordID`) USING BTREE,
  INDEX `DormID`(`DormID` ASC) USING BTREE,
  CONSTRAINT `maintenancerecords_ibfk_1` FOREIGN KEY (`DormID`) REFERENCES `dormitories` (`DormID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for notifications
-- ----------------------------
DROP TABLE IF EXISTS `notifications`;
CREATE TABLE `notifications`  (
  `NotificationID` int NOT NULL AUTO_INCREMENT,
  `UserID` int NOT NULL,
  `Title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Date` datetime NOT NULL,
  PRIMARY KEY (`NotificationID`) USING BTREE,
  INDEX `UserID`(`UserID` ASC) USING BTREE,
  CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for teachers
-- ----------------------------
DROP TABLE IF EXISTS `teachers`;
CREATE TABLE `teachers`  (
  `TeacherID` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Password` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Gender` enum('Male','Female') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Age` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Contact` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Department` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`TeacherID`) USING BTREE,
  INDEX `Password`(`Password` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `UserID` int NOT NULL AUTO_INCREMENT,
  `Username` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Password` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Contact` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`UserID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Procedure structure for GenerateDormitories
-- ----------------------------
DROP PROCEDURE IF EXISTS `GenerateDormitories`;
delimiter ;;
CREATE PROCEDURE `GenerateDormitories`()
BEGIN
    DECLARE buildingNumber INT;
    DECLARE floorNumber INT;
    DECLARE roomNumber INT;
    DECLARE dormID VARCHAR(10);

    SET buildingNumber = 5;
    WHILE buildingNumber <= 6 DO
        SET floorNumber = 1;
        WHILE floorNumber <= 6 DO
            SET roomNumber = 1;
            WHILE roomNumber <= 28 DO
                SET dormID = CONCAT(buildingNumber, floorNumber, LPAD(roomNumber, 2, '0'));
                INSERT INTO Dormitories (DormID, BuildingNumber, Floor, Rooms, Status)
                VALUES (dormID, buildingNumber, floorNumber, roomNumber, 'Vacant');
                SET roomNumber = roomNumber + 1;
            END WHILE;
            SET floorNumber = floorNumber + 1;
        END WHILE;
        SET buildingNumber = buildingNumber + 1;
    END WHILE;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
