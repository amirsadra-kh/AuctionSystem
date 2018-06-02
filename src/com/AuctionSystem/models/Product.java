package com.AuctionSystem.models;

import com.AuctionSystem.bll.BidMgr;
import com.AuctionSystem.bll.ProductMgr;

import java.util.Date;

/**
 * Created by Sadra on 11/26/15.
 */
public class Product {

    private String name;
    public String getName(){
        return this.name;
    }
    public void setName(String name){
        this.name = name;
    }

    private String ownerUserName;
    public String getOwnerUserName(){
        return this.ownerUserName;
    }
    public void setOwnerUserName(String ownerUserName){
        this.ownerUserName = ownerUserName;
    }

    private int id;
    public int getId(){
        return this.id;
    }
    public void setId(int id){
        this.id = id;
    }

    private float price;
    public float getPrice(){
        return this.price;
    }
    public void setPrice(float price){
        this.price = price;
    }

    private String regDate;
    public String getRegDate(){
        return this.regDate;
    }
    public void setRegDate(String regDate){
        this.regDate = regDate;
    }

    private Date date;
    public Date getDate(){
        return date;
    }
    public void setDate(Date date){
        this.date = date;
    }

    public int getRemainingTime(){
        if(isExpired()){
            if((new BidMgr()).getAllProductBids(getId()).size() > 0)
                return 0;
            else
            {
                (new ProductMgr()).renewProduct(getId());
                setDate(new Date());
                setRegDate(""+getDate());
            }
        }

        int val = 300 - ((int)((new Date()).getTime() - getDate().getTime()) / (1000));
        //System.out.println(getName() + " " + val + " [" + (new Date()).getTime() + "] - [" +  getDate().getTime() + "]");
        return val;
    }

    public boolean isExpired(){
        java.util.Date prodTime = (Date)getDate().clone();
        prodTime.setMinutes(prodTime.getMinutes() + 5);
        java.util.Date sysTime = new java.util.Date();
        return sysTime.after(prodTime);
    }

    private String comment;
    public String getComment(){
        return this.comment;
    }
    public void setComment(String comment){
        this.comment = comment;
    }

    private boolean isSold;
    public boolean getIsSold(){
        return this.isSold;
    }
    public void setIsSold(boolean isSold){
        this.isSold = isSold;
    }

}
