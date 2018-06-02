package com.AuctionSystem.models;

import java.util.Date;

/**
 * Created by Sadra on 11/26/15.
 */
public class Bid {

    private String userName;
    public String getUserName(){
        return this.userName;
    }
    public void setUserName(String userName){
        this.userName = userName;
    }

    private int productId;
    public int getProductId(){
        return this.productId;
    }
    public void setProductId(int productId){
        this.productId = productId;
    }

    private float price;
    public float getPrice(){
        return this.price;
    }
    public void setPrice(float price){
        this.price = price;
    }

    private String bidDate;
    public String getBidDate(){
        return this.bidDate;
    }
    public void setBidDate(String bidDate){
        this.bidDate = bidDate;
    }


    private Date date;
    public Date getDate(){
        return date;
    }
    public void setDate(Date date){
        this.date = date;
    }

}
