// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   soft.java

package test;

import ConnDatabase.SDatabase;
import ConnDatabase.menu1;
import getBytes.getBytes;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.Vector;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import login.UserLogin1;
import online.ListUser;
import setProperty.setpopedom;

public class soft extends HttpServlet
{

    public soft()
    {
    }

    public void destroy()
    {
        super.destroy();
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html");
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
        out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
        out.println("<HTML>");
        out.println("  <HEAD><TITLE>\u767B\u5F55\u9A8C\u8BC1</TITLE></HEAD>");
        out.println("  <BODY onload='alertmess();' oncontextmenu='return false;' >");
        try
        {
            session.setMaxInactiveInterval(50000);
            getBytes getTo = new getBytes();
            Object temp = request.getSession().getAttribute("rand");
            String rand = temp != null ? temp.toString() : "";
            String validate = request.getParameter("checkCode");
            if(rand.equals(""))
                response.sendRedirect("index.jsp");
            else
            if(!rand.equals(validate))
                response.sendRedirect("index.jsp");
            String showtype = request.getParameter("showtype");
            String showmenu = request.getParameter("menu");
            Cookie userCookie = new Cookie("showmenu", showmenu);
            userCookie.setPath("/");
            userCookie.setMaxAge(0x1e13380);
            response.addCookie(userCookie);
            Cookie showtypeCookie = new Cookie("showtype", showtype);
            showtypeCookie.setPath("/");
            showtypeCookie.setMaxAge(0x1e13380);
            response.addCookie(showtypeCookie);
            session.setAttribute("menu", showmenu);
            session.setAttribute("showtype", showtype);
            String username = request.getParameter("username");
            String userpassword = request.getParameter("userpassword");
            String txtMACAddr = request.getParameter("txtMACAddr");
            UserLogin1 userS = new UserLogin1();
            String readd = "";
            readd = request.getRemoteAddr();
            String SectionList = "";
            try
            {
                SectionList = userS.CheckUser(username, userpassword, readd, txtMACAddr);
            }
            catch(Exception se)
            {
                out.print(se);
            }
            userS.colorFace();
            String ManModuleS = "";
            if(userS.str != null)
                ManModuleS = userS.str;
            session.removeAttribute("loginfg");
            if(ManModuleS.equals("outsys"))
            {
                out.print(" <script language=javascript>");
                out.print(" alert(\"\u6B64\u7528\u6237\u8BBF\u95EE\u5DF2\u53D7\u9650\u5236\uFF0C\u8BF7\u5728\u516C\u53F8\u89C4\u5B9A\u7684\u7535\u8111\u4E0A\u8BBF\u95EE\uFF01\"); ");
                out.print("window.location=\"../index.jsp'\");");
                out.print("</script>");
                out.close();
            }
            if(!ManModuleS.equals(""))
                ManModuleS = ManModuleS.substring(ManModuleS.indexOf(",") + 1);
            session.setAttribute("FactColorC", userS.ClssFile);
            String returnStr = SectionList.substring(SectionList.lastIndexOf("*") + 1);
            setpopedom setpopedom = new setpopedom();
            setpopedom.setPopedomlist(SectionList.substring(SectionList.indexOf("*") + 1, SectionList.lastIndexOf("*")));
            SectionList = SectionList.substring(0, SectionList.indexOf("*"));
            if(SectionList.indexOf("/") > 0)
                session.setAttribute("SectionList", getTo.Repalce4(SectionList, "/"));
            else
                session.setAttribute("SectionList", (new StringBuilder("'")).append(SectionList).append("'").toString());
            if(SectionList.indexOf("/") > 0)
                session.setAttribute("secno", getTo.Repalce6(SectionList, "/"));
            else
                session.setAttribute("secno", (new StringBuilder("'")).append(SectionList).append("'").toString());
            session.setAttribute("loginid", returnStr.substring(0, returnStr.indexOf(",")));
            String eUser = returnStr.substring(0, returnStr.indexOf(","));
            returnStr = returnStr.substring(returnStr.indexOf(",") + 1);
            session.setAttribute("PMS_ROOT", "../");
            session.setAttribute("job", returnStr.substring(0, returnStr.indexOf(",")));
            returnStr = returnStr.substring(returnStr.indexOf(",") + 1);
            session.setAttribute("loginname", returnStr.substring(0, returnStr.indexOf(",")));
            int existstate = 0;
            String existUserSQL = (new StringBuilder(" select existstate,id,password from CortrolMan WHERE serialno='")).append(eUser).append("'").toString();
            SDatabase aBean = new SDatabase();
            try
            {
                ResultSet existRs = aBean.executeQuery(existUserSQL);
                if(existRs.next())
                {
                    session.setAttribute("login_id", existRs.getString("id"));
                    session.setAttribute("pwd", existRs.getString("password"));
                    existstate = existRs.getInt("existstate");
                }
            }
            catch(SQLException sqlexception) { }
            ListUser ListUser = new ListUser();
            if(ListUser.existUser((new StringBuilder(String.valueOf(returnStr.substring(0, returnStr.indexOf(","))))).append("[").append(request.getRemoteAddr()).append("]").toString()))
            {
                out.println((new StringBuilder("\u7528\u6237<font color=red>")).append(returnStr.substring(0, returnStr.indexOf(","))).append("</font>\u5DF2\u7ECF\u767B\u9646\uFF01").toString());
                if(existstate == 1)
                {
                    out.print("<script language=javascript>");
                    out.print("alert(\"\u6B64\u7528\u6237\u5DF2\u767B\u5F55!\");");
                    out.print("window.open(\"index.jsp\");");
                    out.print("</script>");
                }
            } else
            {
                session.setAttribute((new StringBuilder(String.valueOf(returnStr.substring(0, returnStr.indexOf(","))))).append("[").append(request.getRemoteAddr()).append("]").toString(), ListUser);
            }
            Vector vt = ListUser.getOnLineUser();
            Enumeration e = vt.elements();
            int user1 = 0;
            String username1;
            for(; e.hasMoreElements(); out.print((new StringBuilder(String.valueOf(username1))).append("<br>").toString()))
            {
                user1++;
                username1 = (String)e.nextElement();
            }

            returnStr = returnStr.substring(returnStr.indexOf(",") + 1);
            session.setAttribute("logindept", returnStr.substring(0, returnStr.indexOf(",")));
            returnStr = returnStr.substring(returnStr.indexOf(",") + 1);
            session.setAttribute("time", returnStr.substring(0, returnStr.indexOf(",")));
            String mess = returnStr.substring(0, returnStr.indexOf(","));
            returnStr = returnStr.substring(returnStr.indexOf(",") + 1);
            session.setAttribute("userstate", "1");
            session.setAttribute("loginuserid", returnStr);
            session.setAttribute("ip", request.getRemoteAddr());
            session.setAttribute("statesmess", mess);
            String userid = (String)session.getAttribute("loginid");
            if(userid == null)
                userid = "";
            menu1 smenu = new menu1();
            out.print(smenu.doStart(userid, user1));
        }
        catch(IOException se)
        {
            out.println("\u7CFB\u7EDF\u51FA\u9519\uFF0C\u539F\u56E0\u5982\u4E0B\uFF1A<br>");
            out.println(se.getMessage());
            out.println("<br>\u8BF7\u6309F5\u952E\u5237\u65B0\u4E00\u6B21\u5373\u53EF\u4EE5\u6B63\u5E38\u767B\u5F55\u3002");
            out.close();
        }
        out.println("  </BODY>");
        out.println("</HTML>");
        out.flush();
        out.close();
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html");
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
        out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
        out.println("<HTML>");
        out.println("  <HEAD><TITLE>\u767B\u5F55\u9A8C\u8BC1</TITLE></HEAD>");
        out.println("  <BODY onload='alertmess();' oncontextmenu='return false;' >");
        try
        {
            session.setMaxInactiveInterval(50000);
            getBytes getTo = new getBytes();
            Object temp = request.getSession().getAttribute("rand");
            String rand = temp != null ? temp.toString() : "";
            String validate = request.getParameter("checkCode");
            if(rand.equals(""))
                response.sendRedirect("index.jsp");
            else
            if(!rand.equals(validate))
                response.sendRedirect("index.jsp");
            String showtype = request.getParameter("showtype");
            String showmenu = request.getParameter("menu");
            Cookie userCookie = new Cookie("showmenu", showmenu);
            userCookie.setPath("/");
            userCookie.setMaxAge(0x1e13380);
            response.addCookie(userCookie);
            Cookie showtypeCookie = new Cookie("showtype", showtype);
            showtypeCookie.setPath("/");
            showtypeCookie.setMaxAge(0x1e13380);
            response.addCookie(showtypeCookie);
            session.setAttribute("menu", showmenu);
            session.setAttribute("showtype", showtype);
            String username = request.getParameter("username");
            String userpassword = request.getParameter("userpassword");
            String txtMACAddr = request.getParameter("txtMACAddr");
            UserLogin1 userS = new UserLogin1();
            String readd = "";
            readd = request.getRemoteAddr();
            String SectionList = "";
            try
            {
                SectionList = userS.CheckUser(username, userpassword, readd, txtMACAddr);
            }
            catch(Exception se)
            {
                out.print(se);
            }
            userS.colorFace();
            String ManModuleS = "";
            if(userS.str != null)
                ManModuleS = userS.str;
            session.removeAttribute("loginfg");
            if(ManModuleS.equals("outsys"))
            {
                out.print("<script language=javascript>");
                out.print("function alertmess(){");
                out.print("alert(\"\u6B64\u7528\u6237\u8BBF\u95EE\u5DF2\u53D7\u9650\u5236\u6216\u662F\u5E10\u53F7\u662F\u542F\u7528\u4E86\u52A0\u5F3A\u5B89\u5168\u63A7\u5236\u529F\u80FD\uFF0C\u8BF7\u5728\u516C\u53F8\u89C4\u5B9A\u7684\u7535\u8111\u4E0A\u8BBF\u95EE\uFF01\u6216\u5728\u767B\u5F55\u9875\u6839\u636E\u5E2E\u52A9\u63D0\u793A\u8BBE\u7F6E!\");");
                out.print("window.location=\"index.jsp\";}");
                out.print("</script>");
            } else
            {
                if(!ManModuleS.equals(""))
                    ManModuleS = ManModuleS.substring(ManModuleS.indexOf(",") + 1);
                session.setAttribute("FactColorC", userS.ClssFile);
                String returnStr = SectionList.substring(SectionList.lastIndexOf("*") + 1);
                setpopedom setpopedom = new setpopedom();
                setpopedom.setPopedomlist(SectionList.substring(SectionList.indexOf("*") + 1, SectionList.lastIndexOf("*")));
                SectionList = SectionList.substring(0, SectionList.indexOf("*"));
                if(SectionList.indexOf("/") > 0)
                    session.setAttribute("SectionList", getTo.Repalce4(SectionList, "/"));
                else
                    session.setAttribute("SectionList", (new StringBuilder("'")).append(SectionList).append("'").toString());
                if(SectionList.indexOf("/") > 0)
                    session.setAttribute("secno", getTo.Repalce6(SectionList, "/"));
                else
                    session.setAttribute("secno", (new StringBuilder("'")).append(SectionList).append("'").toString());
                session.setAttribute("loginid", returnStr.substring(0, returnStr.indexOf(",")));
                String eUser = returnStr.substring(0, returnStr.indexOf(","));
                returnStr = returnStr.substring(returnStr.indexOf(",") + 1);
                session.setAttribute("PMS_ROOT", "../");
                session.setAttribute("job", returnStr.substring(0, returnStr.indexOf(",")));
                returnStr = returnStr.substring(returnStr.indexOf(",") + 1);
                session.setAttribute("loginname", returnStr.substring(0, returnStr.indexOf(",")));
                int existstate = 0;
                String existUserSQL = (new StringBuilder(" select existstate,id,password from CortrolMan WHERE serialno='")).append(eUser).append("'").toString();
                SDatabase aBean = new SDatabase();
                try
                {
                    ResultSet existRs = aBean.executeQuery(existUserSQL);
                    if(existRs.next())
                    {
                        session.setAttribute("login_id", existRs.getString("id"));
                        session.setAttribute("pwd", existRs.getString("password"));
                        existstate = existRs.getInt("existstate");
                    }
                }
                catch(SQLException sqlexception) { }
                ListUser ListUser = new ListUser();
                if(ListUser.existUser((new StringBuilder(String.valueOf(returnStr.substring(0, returnStr.indexOf(","))))).append("[").append(request.getRemoteAddr()).append("]").toString()))
                {
                    out.println((new StringBuilder("\u7528\u6237<font color=red>")).append(returnStr.substring(0, returnStr.indexOf(","))).append("</font>\u5DF2\u7ECF\u767B\u9646\uFF01").toString());
                    if(existstate == 1)
                    {
                        out.print("<script language=javascript>");
                        out.print("alert(\"\u6B64\u7528\u6237\u5DF2\u767B\u5F55!\");");
                        out.print("window.open(\"index.jsp\");");
                        out.print("</script>");
                    }
                } else
                {
                    session.setAttribute((new StringBuilder(String.valueOf(returnStr.substring(0, returnStr.indexOf(","))))).append("[").append(request.getRemoteAddr()).append("]").toString(), ListUser);
                }
                Vector vt = ListUser.getOnLineUser();
                Enumeration e = vt.elements();
                int user1 = 0;
                String username1;
                for(; e.hasMoreElements(); out.print((new StringBuilder(String.valueOf(username1))).append("<br>").toString()))
                {
                    user1++;
                    username1 = (String)e.nextElement();
                }

                returnStr = returnStr.substring(returnStr.indexOf(",") + 1);
                session.setAttribute("logindept", returnStr.substring(0, returnStr.indexOf(",")));
                returnStr = returnStr.substring(returnStr.indexOf(",") + 1);
                session.setAttribute("time", returnStr.substring(0, returnStr.indexOf(",")));
                String mess = returnStr.substring(0, returnStr.indexOf(","));
                returnStr = returnStr.substring(returnStr.indexOf(",") + 1);
                session.setAttribute("userstate", "1");
                session.setAttribute("loginuserid", returnStr);
                session.setAttribute("ip", request.getRemoteAddr());
                session.setAttribute("statesmess", mess);
                String userid = (String)session.getAttribute("loginid");
                if(userid == null)
                    userid = "";
                menu1 smenu = new menu1();
                out.print(smenu.doStart(userid, user1));
            }
        }
        catch(IOException se)
        {
            out.println("\u7CFB\u7EDF\u51FA\u9519\uFF0C\u539F\u56E0\u5982\u4E0B\uFF1A<br>");
            out.println(se.getMessage());
            out.println("<br>\u8BF7\u6309F5\u952E\u5237\u65B0\u4E00\u6B21\u5373\u53EF\u4EE5\u6B63\u5E38\u767B\u5F55\u3002");
            out.close();
        }
        out.println("  </BODY>");
        out.println("</HTML>");
        out.flush();
        out.close();
    }

    public void ddd()
        throws SQLException
    {
    }

    public void init()
        throws ServletException
    {
    }
}
