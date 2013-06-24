// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   ValidateImageServlet.java

package payRandom;

import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.PrintStream;
import java.util.Random;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.*;

public class ValidateImageServlet extends HttpServlet
{

    public ValidateImageServlet()
    {
    }

    protected void processRequest(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
        throws ServletException, IOException
    {
        httpservletresponse.setContentType("image/jpeg");
        httpservletresponse.setHeader("Pragma", "No-cache");
        httpservletresponse.setHeader("Cache-Control", "no-cache");
        httpservletresponse.setDateHeader("Expires", 0L);
        HttpSession httpsession = httpservletrequest.getSession();
        byte byte0 = 60;
        byte byte1 = 20;
        BufferedImage bufferedimage = new BufferedImage(byte0, byte1, 1);
        Graphics g = bufferedimage.getGraphics();
        Random random = new Random();
        g.setColor(Color.WHITE);
        g.fillRect(0, 0, byte0, byte1);
        g.setFont(new Font("Arial", 0, 18));
        g.setColor(getRandColor(160, 200));
        for(int i = 0; i < 0; i++)
        {
            int j = random.nextInt(byte0);
            int l = random.nextInt(byte1);
            int i1 = random.nextInt(12);
            int j1 = random.nextInt(12);
            g.drawLine(j, l, j + i1, l + j1);
        }

        String s = "";
        for(int k = 0; k < 4; k++)
        {
            String s1 = String.valueOf(goodChar[random.nextInt(goodChar.length)]);
            s = (new StringBuilder()).append(s).append(s1).toString();
            g.setColor(new Color(20 + random.nextInt(110), 20 + random.nextInt(110), 20 + random.nextInt(110)));
            g.drawString(s1, 13 * k + 6, 16);
        }

        httpsession.setAttribute("rand", s);
        httpsession.setMaxInactiveInterval(600);
        g.dispose();
        System.out.println("\u521D\u59CB\u5316\u6210\u529F!");
        ServletOutputStream servletoutputstream = httpservletresponse.getOutputStream();
        ImageIO.write(bufferedimage, "JPEG", servletoutputstream);
        servletoutputstream.flush();
        servletoutputstream.close();
    }

    Color getRandColor(int i, int j)
    {
        Random random = new Random();
        if(i > 255)
            i = 255;
        if(j > 255)
            j = 255;
        int k = i + random.nextInt(j - i);
        int l = i + random.nextInt(j - i);
        int i1 = i + random.nextInt(j - i);
        return new Color(k, l, i1);
    }

    protected void doGet(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
        throws ServletException, IOException
    {
        processRequest(httpservletrequest, httpservletresponse);
    }

    protected void doPost(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
        throws ServletException, IOException
    {
        processRequest(httpservletrequest, httpservletresponse);
    }

    public String getServletInfo()
    {
        return "Short description";
    }

    protected static char goodChar[] = {
        'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 
        'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 
        'U', 'V', 'W', 'X', 'Y', 'Z', '0', '1', '2', '3', 
        '4', '5', '6', '7', '8', '9'
    };

}
