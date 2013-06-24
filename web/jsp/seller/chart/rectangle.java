package chart;
import java.awt.*;
import java.applet.*;
import java.awt.event.*;
import java.util.*;
import java.lang.*;
import javax.swing.*;
import javax.swing.border.*;
import javax.swing.plaf.basic.*;
import java.net.*;


public class rectangle extends Applet {
  public String X,Y;
  public String[] xdate;
  public double[] ydate;
  public double[] ydate1;
  public double[] ydate2;

  //public double[] height;
  public int xlen,ylen;
  public int xbetween=40,ybetween=20;
	
  public int appletwidth,appletheight;
  public void init() {
    //setBackground(Color.gray);
	setBackground(Color.white); 
	int appletwidth=this.getBounds().width;
    int appletheight=this.getBounds().height;
  }
 
  public void paint(Graphics g)
  { 
	int inix=40,iniy=40;
	double y,ya,ya1,sum=0;
	int x1,y1,x2,y2;
	double pre;
	if(ylen>0){
		g.setColor(Color.black);
		//ª≠Y÷·
		x1=inix;
		y1=iniy;
		x2=x1;
		y2=y1+ylen+ybetween;		
		g.drawLine(x1,y1-50,x2,y2);
		g.drawLine(x1,y1-50,x1-5,y1+5-30);
		g.drawLine(x1,y1-50,x1+5,y1+5-30);
		g.setColor(Color.red);
		g.drawString(Y,x1,y1-10);
		
		//ª≠X÷·
		g.setColor(Color.black);
		x1=x2;
		y1=y2;
		x2=x1+xlen+xbetween;
		g.drawLine(x1,y1,x2+50,y2);
		g.drawLine(x2+50,y2,x2+30,y2-5);
		g.drawLine(x2+50,y2,x2+30,y2+5);
		g.setColor(Color.red);	
		g.drawString(X,x2,y2-10);
		
		int i=0;
		g.setColor(Color.black);
		//ª≠X÷·øÃ∂»
	    for(i=0;i<xlen/xbetween;i++){
		  x2=x1+i*(xbetween+10)+20;
		  y2=y1+5;		 		  
		  g.drawLine(x2,y1,x2,y2);
		  g.drawString(xdate[i],x2,y2+10);
		}
		for(i=0;i<ydate.length;i++){
           sum=sum+ydate[i];
		}
		int max;
		max=getMaxVal(ydate);
		int sum1=1;
		String strsum=(int)max+"";
		for(i=0;i<strsum.length();i++){
		  sum1=sum1*8;
		}
		sum=sum1;
		//ª≠Y÷·øÃ∂»
		for(i=1;i<20;i++){
		  x1=inix-5;
		  y1=iniy+ybetween+(10-i)*(ylen/10);
		  x2=inix;
		  y2=y1;
		  g.drawLine(x1,y1,x2,y2);
		 // g.drawString((int)((sum)*i)+"",x1-20,y1);
		}
		
		g.setColor(Color.black);
		//java.text.DecimalFormat df = new java.text.DecimalFormat("########.##");
		for(i=0;i<ydate.length;i++){
           //y=ydate[i];
		   y=(int)ylen*ydate[i]/sum;
		   ya=(int)ylen*ydate1[i]/sum;
		   ya1=(int)ylen*ydate2[i]/sum;
		   pre=ydate[i]*100/sum;
		   g.setColor(Color.blue);
		   g.drawString(getFloat7(ydate[i],2),inix+i*(xbetween+10)+20,(int)(ylen+iniy-y+10));
		   g.setColor(Color.blue);
		   g.fillRect(inix+i*(xbetween+10)+20,(int)(ylen+iniy-y)+ybetween,xbetween-65,(int)y);
		   g.setColor(Color.red);
		   g.drawString(getFloat7(ydate1[i],2),inix+i*(xbetween+10)-25+xbetween,(int)(ylen+iniy-ya+10));
		   g.setColor(Color.red);
		   g.fillRect(inix+i*(xbetween+10)-25+xbetween,(int)(ylen+iniy-ya)+ybetween,xbetween-65,(int)ya);


g.drawString(getFloat7(ydate2[i],2),inix+i*(xbetween+10)+45+xbetween,(int)(ylen+iniy-ya+10));
		   g.setColor(Color.green);
		   g.fillRect(inix+i*(xbetween+10)+45+xbetween,(int)(ylen+iniy-ya1)+ybetween,xbetween-65,(int)ya1);

		}
	}
  } 
  
  public static int[] Substr1(String str){
    int I=0;
    StringTokenizer st = new StringTokenizer(str,",");
    int len=st.countTokens();
    int[] val=new int[len];
    while(st.hasMoreTokens()) {
      val[I]=Integer.parseInt(st.nextToken());
      I++;
    }
    return val;
  }
 
  public static String[] Substr2(String str){
    int I=0;
    StringTokenizer st = new StringTokenizer(str,",");
    int len=st.countTokens();
    String[] val=new String[len];
    while(st.hasMoreTokens()) {
      val[I]=(String)st.nextToken();
      I++;
    }
    return val;
  }
  
   public static String[] Substr3(String str){
    int I=0;
    StringTokenizer st = new StringTokenizer(str,"&");
    int len=st.countTokens();
    String[] val=new String[len];
    while(st.hasMoreTokens()) {
      val[I]=(String)st.nextToken();
      I++;
    }
    return val;
  }

   public static double[] Substr4(String str){
    int I=0;
    StringTokenizer st = new StringTokenizer(str,",");
    int len=st.countTokens();
    double[] val=new double[len];
    while(st.hasMoreTokens()) {
	  Double tmp=new Double((String)st.nextToken());
      val[I]=tmp.doubleValue();
      I++;
    }
    return val;
  }  
 
  public static int getMaxVal(double[] Maxval){
    int I;
	double result;
    result=Maxval[0];
    for(I=0;I<Maxval.length;I++){
 if(result<Maxval[I])
   result=Maxval[I];
    }
    return (int)result;
  }
 public void setParameter(String X,String Y,String xdate,String ydate,String ydate1,String ydate2,String ylen,String xbetween){
        
		this.X=X;
		this.Y=Y;
		this.xdate=Substr2(xdate);
		this.ydate=Substr4(ydate);
		this.ydate1=Substr4(ydate1);
		this.ydate2=Substr4(ydate2);
		this.ylen=Integer.parseInt(ylen);
		this.xbetween=Integer.parseInt(xbetween);	
		this.xlen=this.xdate.length*this.xbetween;
 }
  public String getFloat7(double temp,int lens) 
   {
      String tempstr="";
	   String strf="";
	   String retstr="";
       if(temp<0)
       {
         temp=-temp;
         tempstr="-";
       }
       if(temp==0 || temp==0.0)
	      return "0";
	   java.text.DecimalFormat df = null;
	   if (lens == 4)
			df = new java.text.DecimalFormat("#######.####");
		if (lens == 3)
			df = new java.text.DecimalFormat("########.###");
		if (lens == 2)
			df = new java.text.DecimalFormat("########.##");
		if (lens == 1)
			df = new java.text.DecimalFormat("########.#");	
		if (lens == 0)
    		df = new java.text.DecimalFormat("########");	

	  strf=df.format(temp).toString();

     /* int pos=strf.indexOf(".");
      if(pos==-1)
	  {
         retstr=tempstr+strf+".00";
	  }
	  else
	  {	 
        String substr=strf.substring(pos+1);
        int sublen=substr.length();
        for(int i=0;i<lens-sublen;i++)
        {
          strf+="0";
        }
		retstr=tempstr+strf;
	  }*/
      return strf;		
	}
}


