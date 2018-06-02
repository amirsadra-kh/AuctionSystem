package com.AuctionSystem.bll;

import com.AuctionSystem.dal.*;
import java.sql.*;

/**
 * Created by Sadra on 11/22/15.
 */
public class UserMgr {

    public static void add(String userName, String password)
    {
        userName = userName.toLowerCase();
        CommandMgr.runCommand(
                "INSERT INTO `AuctionSystem`.`User` (`U_Name`, `Password`) VALUES ('"+userName+"', '"+password+"');");
        System.out.println("User "+userName+" is added");
            //return true;
        //else
        //System.out.println("Query error!");
        //return false;

        //ResultSet rs = CommandMgr.runQuery("INSERT INTO AuctionSystem.User VALUES '"+userName+"', '"+password+"';");
//        if(prestmt != null)
//            return true;
//        return false;
    }

    public boolean delete(String userName)
    {
        userName = userName.toLowerCase();
        ResultSet rs = CommandMgr.runQuery("DELETE FROM AuctionSystem.User WHERE U_Name='"+userName+"';");
        if(rs != null)
            return true;
        return false;
    }

    public boolean isUserValid(String userName, String password)
    {
        userName = userName.toLowerCase();
        ResultSet rs = CommandMgr.runQuery("SELECT * FROM AuctionSystem.User WHERE U_Name='"+userName+"' AND Password='"+password+"';");
        if(rs != null) {
            try {
                if (rs.last() && rs.getRow() > 0) {
                    return true;
                } else {
                    return false;
                }
            }
            catch (SQLException ex){
                return false;
            }
        }
        return false;
    }

    public boolean isNewUserValid(String userName)
    {
        userName = userName.toLowerCase();
        System.out.println("func new valid user is called");

        ResultSet rs = CommandMgr.runQuery("SELECT * FROM AuctionSystem.User WHERE U_Name='"+userName+"';");
        if (rs != null) {
            try {
                if (rs.last() && rs.getRow() > 0) {
                    return true;
                }
                else {
                    return false;
                }
            } catch (SQLException ex) {
                return false;
            }
        }
        return false;
    }
}
