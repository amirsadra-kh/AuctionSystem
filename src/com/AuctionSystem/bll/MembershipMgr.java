package com.AuctionSystem.bll;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Created by Sadra on 11/29/15.
 */
public class MembershipMgr{

    public String getLoggedInUser(){
        try {
            if(_request == null){
                System.out.println("Request is null!!!");
                return "";
            }
            Cookie cookies[] = _request.getCookies();
            //System.out.println("Total cookies: " + cookies.length);
            for (int i = 0; i < cookies.length ; i++)
            {
                if(cookies[i].getName().equals("loggedInUser"))
                    return cookies[i].getValue();
            }
        }
        catch (Exception ex){
            System.out.println(ex.getMessage());
            ex.printStackTrace();
        }
        return "";
    }

    public boolean isLoggedIn(){
        try {
            if(_request == null){
                System.out.println("Request is null!!!");
                return false;
            }
            Cookie cookies[] = _request.getCookies();
            if(cookies == null) return false;
            //System.out.println("Total cookies: " + cookies.length);
            for (int i = 0; i < cookies.length; i++) {
                if (cookies[i].getName().equals("loggedInUser"))
                    return true;
            }
        }
        catch (Exception ex){
            System.out.println(ex.getMessage());
            ex.printStackTrace();
        }
        return false;
    }

    public UserMgr um;
    public BidMgr bm;
    public ProductMgr pm;
    private HttpServletResponse _response;
    private HttpServletRequest _request;

    private MembershipMgr(HttpServletResponse response, HttpServletRequest request){
        um = new UserMgr();
        bm = new BidMgr();
        pm = new ProductMgr();
        this._response = response;
        this._request = request;
    }

    public static MembershipMgr getCurrent(HttpSession session, HttpServletResponse response, HttpServletRequest request){
        if(session == null || response == null || request == null) return null;

        /*if(session.getAttribute("membershipSession") == null) {
            session.setAttribute("membershipSession",new MembershipMgr(response, request));
        }
        MembershipMgr mm = (MembershipMgr)session.getAttribute("membershipSession");
        mm._request = request;
        mm._response = response;
        return mm;*/
        return new MembershipMgr(response, request);
    }

    public boolean loginUser(String uName, String password){
        if(_response != null && um.isUserValid(uName,password))
        {
            //isLoggedIn();
            Cookie cookie = new Cookie("loggedInUser",uName);
            //cookie.setPath("/");
            cookie.setMaxAge(3600);
            //cookie.setHttpOnly(true);
            //cookie.setSecure(true);
            _response.addCookie(cookie);

            System.out.println("-----\nUser " + uName + " validated and the cookie is generated..\n-----");
            /*try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }*/
            return true;//isLoggedIn();
        }
        return false;
    }

    public void logOut(){
        if(_response != null) {
            Cookie killMyCookie = new Cookie("loggedInUser", null);
            killMyCookie.setMaxAge(0);
            //killMyCookie.setPath("/");
            _response.addCookie(killMyCookie);
            /*try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }*/
        }
    }
}
