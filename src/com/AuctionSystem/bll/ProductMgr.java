package com.AuctionSystem.bll;

import com.AuctionSystem.dal.CommandMgr;
import com.AuctionSystem.models.Product;

import java.sql.*;
import java.util.ArrayList;

/**
 * Created by Sadra on 11/22/15.
 */
public class ProductMgr {

    public ArrayList<Product> getProductsByOwner(String userName){
        ArrayList<Product> result = new ArrayList<Product>();

        ResultSet rs =
                CommandMgr.runQuery(
                        "SELECT * FROM AuctionSystem.Product WHERE Owner_Uname='"+userName+"';");
        if(rs == null)
            return result;

        try {
            while (rs.next()){
                Product b = new Product();
                b.setName(rs.getString("Name"));
                b.setOwnerUserName(userName);
                b.setId(Integer.valueOf(rs.getString("ID")));
                b.setRegDate(rs.getString("Reg_Date"));
                b.setDate(rs.getTimestamp("Reg_Date"));
                b.setPrice(Float.valueOf(rs.getString("Price")));
                b.setComment(rs.getString("Comment"));
                b.setIsSold(Boolean.valueOf(rs.getString("Is_Sold")));
                result.add(b);
            }
        } catch (SQLException e) {
            return null;
        }


        return  result;
    }

    public ArrayList<Product> getAllProducts(){
        ArrayList<Product> result = new ArrayList<Product>();

        ResultSet rs =
                CommandMgr.runQuery(
                        "SELECT * FROM AuctionSystem.Product;");
        if(rs == null)
            return result;

        try {
            while (rs.next()){
                Product b = new Product();
                b.setName(rs.getString("Name"));
                b.setOwnerUserName(rs.getString("Owner_Uname"));
                b.setId(Integer.valueOf(rs.getString("ID")));
                b.setRegDate(rs.getString("Reg_Date"));
                b.setDate(rs.getTimestamp("Reg_Date"));
                b.setPrice(Float.valueOf(rs.getString("Price")));
                b.setComment(rs.getString("Comment"));
                b.setIsSold(Boolean.valueOf(rs.getString("Is_Sold")));
                result.add(b);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Errorsssss - - - - \n"+e.getMessage() + "\n - - - - - - \n");
            return null;
        }


        return  result;
    }

    public ArrayList<Product> getProduct(long id){
        ArrayList<Product> result = new ArrayList<Product>();

        ResultSet rs =
                CommandMgr.runQuery(
                        "SELECT * FROM AuctionSystem.Product WHERE ID="+id+";");
        if(rs == null)
            return result;

        try {
            while (rs.next()){
                Product b = new Product();
                b.setName(rs.getString("Name"));
                b.setOwnerUserName(rs.getString("Owner_Uname"));
                b.setId(Integer.valueOf(rs.getString("ID")));
                b.setRegDate(rs.getString("Reg_Date"));
                b.setDate(rs.getTimestamp("Reg_Date"));
                b.setPrice(Float.valueOf(rs.getString("Price")));
                b.setComment(rs.getString("Comment"));
                b.setIsSold(Boolean.valueOf(rs.getString("Is_Sold")));
                result.add(b);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        return result;
    }

    public boolean add(String name, float price, String userName, String comment)
    {
        return CommandMgr.runCommand(
                "INSERT INTO AuctionSystem.Product(`Name`, Price, Owner_Uname, Reg_Date, `Comment`) VALUES ('"+
                name+"', "+price+", '"+userName+"', NOW(), '"+comment+"');");
    }

    public boolean delete(int productId)
    {
        return CommandMgr.runCommand("DELETE FROM AuctionSystem.Product WHERE ID="+productId+";");
    }

    public boolean setSold(int productId, boolean isSold){
        return CommandMgr.runCommand("UPDATE AuctionSystem.Product SET Is_Sold='"+isSold+"' WHERE ID="+productId+";");
    }

    public boolean renewProduct(int productId){
        return CommandMgr.runCommand("UPDATE AuctionSystem.Product SET Reg_Date=NOW() WHERE ID="+productId+";");
    }

    public int getLastId(){
        ResultSet rs =
                CommandMgr.runQuery(
                        "SELECT LAST_INSERT_ID() AS LastID FROM AuctionSystem.Product;");
        if(rs == null)
            return -1;

        try {
            while (rs.next()){
                return Integer.valueOf(rs.getString("LastID"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
        return -1;
    }
}
