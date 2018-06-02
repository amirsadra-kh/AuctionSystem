package com.AuctionSystem.dal;

/**
 * Created by Sadra on 11/16/15.
 */

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class DBConnMgr {
    private final static String dbUser = "sadra_admin";
    private final static String dbPass = "123456";

    public static Connection getConnection() throws ClassNotFoundException{
        Connection connection = null;
//        try{
            String url = "";
//            if(SystemProperty.environment != null && SystemProperty.environment.value() ==
//                    SystemProperty.Environment.Value.Production) {
//                //Connecting from App Engine.
//                //Load the class that provides the "jdbc:google:mysql://"
//                //prefix.
//                Class.forName("com.mysql.jdbc.GoogleDriver");
//                url = "jdbc:google:mysql://sadrasauctionsystem:auctiondb2?user=root";
//            }
//            /*else{
//                    // Connecting from an external network.
//                    Class.forName("com.mysql.jdbc.Driver");
//                    url = "jdbc:mysql://173.194.86.78:3306/AuctionSystem?user=sadra&password=sadra13691991";
//                }*/
//            else{
                Class.forName("com.mysql.jdbc.Driver");
                url =  "jdbc:mysql://localhost:8889/AuctionSystem";
                //DriverManager.getConnection(url,dbUser,dbPass);
                //DriverManager.getConnection(url, dbUser, dbPass);
        try {
            connection =  DriverManager.getConnection(url, dbUser, dbPass);//jdbc:mysql://173.194.86.78:3306/AuctionSystem
        } catch (SQLException e) {
            e.printStackTrace();
        }
        //}

        //}
//        catch (Exception exc){
//            exc.printStackTrace();
//            System.out.println("Database Errors - - - - - \n"+exc.getMessage() + "\n - - - - - - \n");
//        }
        return connection;
    }
}
