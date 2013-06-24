package charts;
import java.awt.*;
import java.applet.*;
import java.awt.event.*;
import java.util.*;
import java.lang.*;
import javax.swing.*;
import javax.swing.border.*;
import javax.swing.plaf.basic.*;
import java.net.*;

public class graph  extends Applet {
  public String X,Y;
  public String[] xdate;
  public double[] ydate;
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
	double y,sum=0;
	int x1,y1,x2,y2;
	double pre;
	                    
	if(ylen>0){
		g.setColor(Color.black);
		//ª≠Y÷·
		x1=inix;
		y1=iniy;
		x2=x1;
		y2=y1+ylen+ybetween;		
		g.drawLine(x1,y1,x2,y2);
		g.drawLine(x1,y1,x1-5,y1+5);
		g.drawLine(x1,y1,x1+5,y1+5);
		g.setColor(Color.red);
		g.drawString(Y,x1,y1-10);
		
		//ª≠X÷·
		g.setColor(Color.black);
		x1=x2;
		y1=y2;
		x2=x1+xlen+xbetween;
		g.drawLine(x1,y1,x2,y2);
		g.drawLine(x2,y2,x2-5,y2-5);
		g.drawLine(x2,y2,x2-5,y2+5);
		g.setColor(Color.red);	
		g.drawString(X,x2,y2-10);
		
		int i=0;
		g.setColor(Color.black);
		//ª≠X÷·øÃ∂»
		for(i=0;i<xlen/xbetween;i++){
		  x2=x1+i*xbetween+20;
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
		  sum1=sum1*10;
		}
		sum=sum1;
		//ª≠Y÷·øÃ∂»
		for(i=1;i<11;i++){
		  x1=inix-5;
		  y1=iniy+ybetween+(10-i)*(ylen/10);
		  x2=inix;
		  y2=y1;
		  g.drawLine(x1,y1,x2,y2);
		  g.drawString((int)((sum/10)*i)+"",x1-20,y1);
		}
		
		g.setColor(Color.black);
		//java.text.DecimalFormat df = new java.text.DecimalFormat("########.##");
		for(i=0;i<ydate.length;i++){
           //y=ydate[i];
		   if(i==0){
			 y=(int)ylen*ydate[i]/sum;
		     y2=(int)(ylen+iniy-y)+ybetween;
			 x2=inix+20;
			 g.setColor(Color.red);
		     g.drawString(ydate[i]+"",inix+i*xbetween+20,(int)(ylen+iniy-y+10));
		   }else{
			 y1=y2;
			 x1=x2;
			 y=(int)ylen*ydate[i]/sum;
		     y2=(int)(ylen+iniy-y)+ybetween;
			 x2=inix+i*xbetween+20;
		     pre=ydate[i]*100/sum;
		     g.setColor(Color.red);
		     g.drawString(ydate[i]+"",inix+i*xbetween+20,(int)(ylen+iniy-y+10));
		     g.setColor(Color.blue);
		     g.drawLine(x1,y1,x2,y2);
		   //g.fillRect(inix+i*xbetween+20,(int)(ylen+iniy-y)+ybetween,xbetween-10,(int)y);
	       }
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
 public void setParameter(String X,String Y,String xdate,String ydate,String ylen,String xbetween){
        
		this.X=X;
		this.Y=Y;
		this.xdate=Substr2(xdate);
		this.ydate=Substr4(ydate);
		this.ylen=Integer.parseInt(ylen);
		this.xbetween=Integer.parseInt(xbetween);	
		this.xlen=this.xdate.length*this.xbetween;
 }
}


