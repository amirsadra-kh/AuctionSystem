package com.AuctionSystem.bll;

import com.AuctionSystem.dal.CommandMgr;
import com.AuctionSystem.models.Bid;

import java.sql.*;
import java.util.ArrayList;

/**
 * Created by Sadra on 11/22/15.
 */
public class BidMgr {

    public ArrayList<Bid> getAllUserBids(String userName){
        ArrayList<Bid> result = new ArrayList<Bid>();

        ResultSet rs =
                CommandMgr.runQuery(
                        "SELECT * FROM AuctionSystem.Bid WHERE U_name='"+userName+"' ORDER BY Bid_Date DESC;");
        if(rs == null)
            return result;

        try {
            while (rs.next()){
                Bid b = new Bid();
                b.setUserName(rs.getString("U_name"));
                b.setProductId(Integer.valueOf(rs.getString("Product_ID")));
                b.setBidDate(rs.getString("Bid_Date"));
                b.setDate(rs.getTimestamp("Bid_Date"));
                b.setPrice(Float.valueOf(rs.getString("Price")));
                result.add(b);
            }
        } catch (SQLException e) {
            return null;
        }


        return  result;
    }

    public ArrayList<Bid> getAllProductBids(int productId){
        ArrayList<Bid> result = new ArrayList<Bid>();

        ResultSet rs =
                CommandMgr.runQuery(
                        "SELECT * FROM AuctionSystem.Bid WHERE Product_ID="+productId+" ORDER BY Bid_Date DESC;");
        if(rs == null)
            return result;

        try {
            while (rs.next()){
                Bid b = new Bid();
                b.setUserName(rs.getString("U_name"));
                b.setProductId(Integer.valueOf(rs.getString("Product_ID")));
                b.setBidDate(rs.getString("Bid_Date"));
                b.setDate(rs.getTimestamp("Bid_Date"));
                b.setPrice(Float.valueOf(rs.getString("Price")));
                result.add(b);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }

        return  result;
    }

    public boolean add(String userName, int productId, float price)
    {
        ArrayList<Bid> bids = getAllProductBids(productId);
        if(bids == null){
            System.out.println("bids null");
            return false;
        }

        if(bids.size() == 0 || bids.get(0).getPrice() < price) {
            System.out.println("bids ok");
            if (CommandMgr.runCommand(
                            "INSERT INTO AuctionSystem.Bid(U_name, Product_ID, `Price`, Bid_Date) VALUES ('"
                                    + userName + "', " + productId + ", " + price + ", NOW());")) {
                return true;
            }
            System.out.println("Query error!");
        }
        return false;
    }
}
