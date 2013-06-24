// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   RequestDumperFilter.java

package filters;

import java.io.*;
import java.sql.Timestamp;
import java.util.Enumeration;
import java.util.Locale;
import javax.servlet.*;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

public final class RequestDumperFilter
    implements Filter
{

    public RequestDumperFilter()
    {
        filterConfig = null;
    }

    public void destroy()
    {
        filterConfig = null;
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
        throws IOException, ServletException
    {
        if(filterConfig == null)
            return;
        StringWriter sw = new StringWriter();
        PrintWriter writer = new PrintWriter(sw);
        writer.println("Request Received at " + new Timestamp(System.currentTimeMillis()));
        writer.println(" characterEncoding=" + request.getCharacterEncoding());
        writer.println("     contentLength=" + request.getContentLength());
        writer.println("       contentType=" + request.getContentType());
        writer.println("            locale=" + request.getLocale());
        writer.print("           locales=");
        Enumeration locales = request.getLocales();
        boolean first = true;
        Locale locale;
        for(; locales.hasMoreElements(); writer.print(locale.toString()))
        {
            locale = (Locale)locales.nextElement();
            if(first)
                first = false;
            else
                writer.print(", ");
        }

        writer.println();
        for(Enumeration names = request.getParameterNames(); names.hasMoreElements(); writer.println())
        {
            String name = (String)names.nextElement();
            writer.print("         parameter=" + name + "=");
            String values[] = request.getParameterValues(name);
            for(int i = 0; i < values.length; i++)
            {
                if(i > 0)
                    writer.print(", ");
                writer.print(values[i]);
            }

        }

        writer.println("          protocol=" + request.getProtocol());
        writer.println("        remoteAddr=" + request.getRemoteAddr());
        writer.println("        remoteHost=" + request.getRemoteHost());
        writer.println("            scheme=" + request.getScheme());
        writer.println("        serverName=" + request.getServerName());
        writer.println("        serverPort=" + request.getServerPort());
        writer.println("          isSecure=" + request.isSecure());
        if(request instanceof HttpServletRequest)
        {
            writer.println("---------------------------------------------");
            HttpServletRequest hrequest = (HttpServletRequest)request;
            writer.println("       contextPath=" + hrequest.getContextPath());
            Cookie cookies[] = hrequest.getCookies();
            if(cookies == null)
                cookies = new Cookie[0];
            for(int i = 0; i < cookies.length; i++)
                writer.println("            cookie=" + cookies[i].getName() + "=" + cookies[i].getValue());

            String name;
            String value;
            for(Enumeration names = hrequest.getHeaderNames(); names.hasMoreElements(); writer.println("            header=" + name + "=" + value))
            {
                name = (String)names.nextElement();
                value = hrequest.getHeader(name);
            }

            writer.println("            method=" + hrequest.getMethod());
            writer.println("          pathInfo=" + hrequest.getPathInfo());
            writer.println("       queryString=" + hrequest.getQueryString());
            writer.println("        remoteUser=" + hrequest.getRemoteUser());
            writer.println("requestedSessionId=" + hrequest.getRequestedSessionId());
            writer.println("        requestURI=" + hrequest.getRequestURI());
            writer.println("       servletPath=" + hrequest.getServletPath());
        }
        writer.println("=============================================");
        writer.flush();
        filterConfig.getServletContext().log(sw.getBuffer().toString());
        chain.doFilter(request, response);
    }

    public void init(FilterConfig filterConfig)
        throws ServletException
    {
        this.filterConfig = filterConfig;
    }

    public String toString()
    {
        if(filterConfig == null)
        {
            return "RequestDumperFilter()";
        } else
        {
            StringBuffer sb = new StringBuffer("RequestDumperFilter(");
            sb.append(filterConfig);
            sb.append(")");
            return sb.toString();
        }
    }

    private FilterConfig filterConfig;
}
