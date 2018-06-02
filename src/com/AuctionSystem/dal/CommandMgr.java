package com.AuctionSystem.dal;

import java.sql.*;


/**
 * Created by Sadra on 11/18/15.
 */
public class CommandMgr {
    public static ResultSet runQuery(String query){
        Connection connection = null;
        ResultSet rs = null;
        Statement stmt = null;
        try{
            connection = DBConnMgr.getConnection();
            if (connection != null)
            {
                stmt = connection.createStatement();
                rs = stmt.executeQuery(query);
                /*while(rs.next())
                {
                    System.out.println(rs.getString("U_Name"));
                }
                if(rs.last()){
                    System.out.println(rs.getRow());
                } else {

                }*/

            }
        }
        catch (Exception exc){
            exc.printStackTrace();
            System.out.println("Errorsssss - - - - \n"+exc.getMessage() + "\n - - - - - - \n");
        }
        /*finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }*/
        return rs;
    }

    public static boolean runCommand(String query){
        Connection connection = null;
        int res = 0;
        Statement stmt = null;
        try{
            connection = DBConnMgr.getConnection();
            if (connection != null)
            {
                stmt = connection.createStatement();
                res = stmt.executeUpdate(query);
                return true;
            }
        }
        catch (Exception exc){
            exc.printStackTrace();
        }
        finally {
            /*if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }*/
        }
        return false;
    }
}
