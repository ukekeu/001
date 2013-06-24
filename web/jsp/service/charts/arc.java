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
//import FormatData.FormatData;
public class arc  extends Applet {
  public String X,Y,mess;
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
	//setSize(appletwidth,appletheight); 
  }
 
  public void paint(Graphics g)
  { 
	int inix=40,iniy=40;
	double y,sum=0;
	int x1,y1,x2,y2,x3,y3;
	x1=10;
	y1=50/2;
	x2=140;
	y2=140;
	x3=0;
	y3=0;
	//g.setColor(Color.black);
	//g.drawString("x1="+x1+" y1="+y1,10,10);
	double pre;
	int i=0;
	int sum1=0,sum2=0;
	int j=0;
	java.text.DecimalFormat df = new java.text.DecimalFormat("########");	
    if(ylen>0){
	   
	   g.setColor(Color.black);
	   g.drawArc(x1,y1,x2,y2,x3,360);
	   for(i=0;i<ydate.length;i++){
           sum=sum+ydate[i];
		}
	   for(i=0;i<ydate.length;i++){
	     if(i==0){
		    g.setColor(Color.blue);
		 }
		 if(i==1){
		    g.setColor(Color.red);
		 }
		 if(i==2){
		    g.setColor(Color.green);
		 }
		 if(i==3){
		    g.setColor(Color.yellow);
		 }
		 if(i==4){
		    g.setColor(Color.orange);
		 }
		 if(i==5){
		    g.setColor(Color.black);
		 }
		  if(i==6){
		    g.setColor(Color.magenta);
		 }
		  if(i==7){
		    g.setColor(Color.gray);
		 }
		  if(i==8){
		    g.setColor(Color.pink);
		 }
		  if(i==9){
		    g.setColor(Color.darkGray);
		 }
		  

		 //sum1=(dsum1+ydate[i];		 
		 if(i==0){
		   x3=0;
		 }else{
		   x3=x3+y3;
		 }
		 if(i==ydate.length-1){
		    y3=360-sum2;
		 }else{		 
		    y3=(int)(ydate[i]*360/sum);
	     }
		 sum2=sum2+y3;
		 if(y3>0){ 
		  j++;
		  g.fillArc(x1,y1,x2,y2,x3,y3);
		   g.setColor(Color.black);
	      g.drawArc(x1,y1,x2,y2,x3,y3);		  
		  
		 }
	   }
	}
	
	x1=x1+x2+20;
	y1=60;
	
	g.setColor(Color.black);
	g.drawRect(x1-5,y1-35,150,(j+3)*20);
	g.setColor(Color.black);
	
	g.drawString("×Ü¼Æ:"+df.format(sum).toString()+mess,x1,y1);
	
	for(i=0;i<ydate.length;i++){
	  if(ydate[i]>0){	   
		if(i==0){
		    g.setColor(Color.blue);
		 }
		 if(i==1){
		    g.setColor(Color.red);
		 }
		 if(i==2){
		    g.setColor(Color.green);
		 }
		 if(i==3){
		    g.setColor(Color.yellow);
		 }
		 if(i==4){
		    g.setColor(Color.orange);
		 }
		 if(i==5){
		    g.setColor(Color.black);
		 }
		  if(i==6){
		    g.setColor(Color.magenta);
		 }
		  if(i==7){
		    g.setColor(Color.gray);
		 }
		  if(i==8){
		    g.setColor(Color.pink);
		 }
		  if(i==9){
		    g.setColor(Color.darkGray);
		 }
	     g.fillRect(x1,y1+20*(i+1),20,15);
		g.setColor(Color.black);
		g.drawString(xdate[i]+":"+df.format(ydate[i]).toString()+mess,x1+30,y1+20*(i+1)+10);
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
 public void setParameter(String X,String Y,String xdate,String ydate,String ylen,String xbetween,String mes){
        
		this.X=X;
		this.Y=Y;
		this.xdate=Substr2(xdate);
		this.ydate=Substr4(ydate);
		this.ylen=Integer.parseInt(ylen);
		this.xbetween=Integer.parseInt(xbetween);	
		this.xlen=this.xdate.length*this.xbetween;
		this.mess=mes;
 }
}


