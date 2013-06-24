package charts;
import java.awt.*;
import java.applet.*;
import java.awt.event.*;
import java.util.*;
import java.lang.*;
import javax.swing.*;



public class charts extends Applet {
  static int LEN;
  static final int X1=50,Y1=30;  //Y轴顶点坐标(Xo,Yo)
  static int Yunit,Xunit;
  static float Unit;
  static String[] down_task_code;
  static int[] up_task_code;
  static String[] exist_sub_task;
  static int[] task_type;
  //static String[] begin_date;
  //static String[] end_date;
  //static int[] datelength;
  static int[] beginX;
  static int[] endX;
  static String[] datelist;
  static int[] down_length;
  static String xbeginX,xendX,xdown_task_code,xup_task_code,xexist_sub_task,xtask_type,xbegin_date,xend_date,xdatelength,minDate,maxDate,weekcount,xdatelist,xdown_length; //接收从html传进的数据
  static String[] week={"日","一","二","三","四","五","六"};
  Image img1;
  Image img2;
  Image img3;
  Image img4;
  Image img5;
  Image img6;
  Image img7;
  Image img8;

  public void init() {
    //setBackground(Color.gray);
    int width=this.getBounds().width;
    int height=this.getBounds().height;
    setSize(width,height);
    xdown_task_code=getParameter("down_task_code");
	xup_task_code=getParameter("up_task_code");
	xexist_sub_task=getParameter("exist_sub_task");
	xtask_type=getParameter("task_type");
	//xbegin_date=getParameter("begin_date");
	//xend_date=getParameter("end_date");
	//xdatelength=getParameter("datelength");
	minDate=getParameter("minDate");
	maxDate=getParameter("maxDate");
	weekcount=getParameter("weekcount");
	xbeginX=getParameter("beginX");
	beginX=Substr1(xbeginX);
	xendX=getParameter("endX");
	endX=Substr1(xendX);
    down_task_code=Substr2(xdown_task_code);
	up_task_code=Substr1(xup_task_code);
	exist_sub_task=Substr2(xexist_sub_task);
	task_type=Substr1(xtask_type);
	xdatelist=getParameter("datelist");
	datelist=Substr2(xdatelist);
	xdown_length=getParameter("down_length");
	down_length=Substr1(xdown_length);
	//begin_date=Substr2(xbegin_date);
	//end_date=Substr2(xend_date);
	//datelength=Substr1(xdatelength);
    LEN=down_task_code.length;
    
	
	
  }
 
  public void paint(Graphics g){
  //g.setBackground(Color.write); 
  img1=getImage(getCodeBase(),"1.gif");//任务条
  img2=getImage(getCodeBase(),"2.gif");//黑三角
  img3=getImage(getCodeBase(),"3.gif");//黑条
  img4=getImage(getCodeBase(),"4.gif");//里程碑
  img5=getImage(getCodeBase(),"jt.gif");//蓝三角 
  img6=getImage(getCodeBase(),"black.gif");//黑三角 
  img7=getImage(getCodeBase(),"jt-l.gif");//黑三角 
  img8=getImage(getCodeBase(),"jt-b.gif");//黑三角 
	g.setColor(Color.black);//坐标原点(30,290)
	//g.drawRect(30,20,100,10);
	//g.drawImage(img3,25,15,95,LEN,null);
	int j=0;int k=0;
	int rowwidth=20;
	int yweekcount=Integer.parseInt(weekcount);
	for(j=0;j<yweekcount;j++){
	  
	  //g.drawLine(j*7*rowwidth,0,j*7*rowwidth,10);
	  g.drawString(datelist[j],j*7*rowwidth+10,15);
	  //g.drawLine(j*7*row
	  g.drawRect(j*7*rowwidth,0,7*rowwidth,15);
	}
	
	for(j=0;j<yweekcount;j++){
	   for(k=0;k<7;k++){
	   g.drawRect(j*7*rowwidth+k*rowwidth,15,rowwidth,15);
	   g.drawString(week[k],j*7*rowwidth+k*rowwidth+5,30);
	   }
	}
	//g.drawString("test",20,10);
    String ydown_task_code;
    int yup_task_code=0;
    String yexist_sub_task;
    int ytask_type=0;
	int ybeginX=0;
	int yendX=0;
	int ydown_length=0;
    //String ybegin_date;
    //String yend_date;
    //int ydatelength;
	int add=0;
	
	for(j=0;j<LEN;j++){
	   ydown_task_code=down_task_code[j];
	   yup_task_code=up_task_code[j];
	   yexist_sub_task=exist_sub_task[j];
	   ytask_type=task_type[j];
	   ybeginX=beginX[j];
	   yendX=endX[j];
	   ydown_length=down_length[j];
	   //ybegin_date=begin_date[j];
	   //yend_date=end_date[j];
       //ydatelength=datelength[j];
	   k=j+2;
	   if(yexist_sub_task.equals("1")){
         g.drawImage(img3,ybeginX*rowwidth-10,k*15,(yendX-ybeginX+1)*rowwidth+20,5,null);
         g.drawImage(img2,ybeginX*rowwidth-10,k*15+5,null);
	     g.drawImage(img2,(yendX+1)*rowwidth,k*15+5,null);
	   }else{
         if(ytask_type==0){
		     g.setColor(Color.blue);
             g.drawImage(img1,ybeginX*rowwidth,k*15,(yendX-ybeginX+1)*rowwidth,10,null);
		     if(!ydown_task_code.equals("0")){
             g.drawLine((yendX+1)*rowwidth,k*15+5,(yendX+1)*rowwidth+ydown_length,k*15+5);
			 if(Integer.parseInt(ydown_task_code)-j-2>=0){
			   g.drawLine((yendX+1)*rowwidth+ydown_length,k*15+5,(yendX+1)*rowwidth+ydown_length,k*15+5+5+(Integer.parseInt(ydown_task_code)-j-2)*15);
			   g.drawImage(img5,(yendX+1)*rowwidth+ydown_length-5,k*15+5+5+(Integer.parseInt(ydown_task_code)-j-2)*15,null);
		     }else{
			   g.drawLine((yendX+1)*rowwidth+ydown_length,k*15+5,(yendX+1)*rowwidth+ydown_length,k*15+(j-Integer.parseInt(ydown_task_code)-2)*15);
			   g.drawImage(img7,(yendX+1)*rowwidth+ydown_length-5,k*15+(j-Integer.parseInt(ydown_task_code)-2)*15-5,null);
			 }
		   }
		 }else{
		    g.setColor(Color.black);
		    g.drawImage(img4,ybeginX*rowwidth-5,k*15,null);
			if(!ydown_task_code.equals("0")){
             g.drawLine((ybeginX)*rowwidth+ydown_length,k*15+5,(yendX+1)*rowwidth+ydown_length,k*15+5);
			 if(Integer.parseInt(ydown_task_code)-j-2>=0){
			   g.drawLine((yendX+1)*rowwidth+ydown_length,k*15+5,(yendX+1)*rowwidth+ydown_length,k*15+5+5+(Integer.parseInt(ydown_task_code)-j-2)*15);
			   g.drawImage(img6,(yendX+1)*rowwidth+ydown_length-5,k*15+5+5+(Integer.parseInt(ydown_task_code)-j-2)*15,null);
			 }else{
			   g.drawLine((yendX+1)*rowwidth+ydown_length,k*15+5,(yendX+1)*rowwidth+ydown_length,k*15+(j-Integer.parseInt(ydown_task_code)-2)*15);
			   g.drawImage(img8,(yendX+1)*rowwidth+ydown_length-5,k*15+(j-Integer.parseInt(ydown_task_code)-2)*15-5,null);
			 }
			 
		   }
		 }
       }
	}
   /* g.drawImage(img1,30,20,100,10,null);
	//g.drawRect(30,20,100,10);
	//g.setColor(Color.blue);
	//g.fillRect(30,20,100,10);
	g.drawLine(130,25,140,25);
	g.drawLine(140,25,140,60);
	//g.drawLine(130,55,140,60);
	//g.drawLine(150,55,140,60);
	//img1 = getImage(getCodeBase(), "jt.gif"); 
	g.drawImage(img5,135,60,null);
	//g.setColor(Color.black);
	g.drawImage(img3,30,70,200,5,null);
	//g.drawRect(30,70,200,10);
	//g.fillRect(30,70,200,10);
    g.drawImage(img2,30,75,null);
	g.drawImage(img2,220,75,null);
	//g.drawArc(200,250,300,350,400,450);
	//g.drawRect(Xo,Yo,X1,Y1); //Y轴
    /*int I;
    for(I=0;I<5;I++){
      g.drawLine(Xo,Yo-Yunit*I,Xo-5,Yo-Yunit*I); //Y
      g.drawString(Float.toString(Y[I]),Xo-38,Yo-Yunit*I);
    }
    g.drawLine(X1,Y1,X1-5,Y1+5); //Y轴左箭头
    g.drawLine(X1,Y1,X1+5,Y1+5); //Y轴右箭头



    g.drawLine(Xo,Yo,X2,Y2); //X轴
    //System.out.println("");
    for(I=0;I<LEN;I++){
      g.drawLine(Xo+Xunit*I,Yo,Xo+Xunit*I,Yo+5); //X
      //System.out.print((Xo+Xunit*I)+" ");
      g.drawString(Integer.toString(Xval[I]),Xo+Xunit*I-6,Yo+20);
    }
    g.drawLine(X2,Y2,X2-5,Y2-5); //X轴左箭头
    g.drawLine(X2,Y2,X2-5,Y2+5); //X轴右箭头



    g.setColor(Color.black);
    g.drawString("Y",X1-20,Y1);
    g.drawString("X",X2,Y2+20);
    for(I=0;I<LEN-1;I++)
 g.drawLine(Xo+Xunit*I,Yvalue[I],Xo+Xunit*(I+1),Yvalue[I+1]);*/
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
   public static int[] Substr3(String str){
    int I=0;
    StringTokenizer st = new StringTokenizer(str,"#");
    int len=st.countTokens();
    int[] val=new int[len];
    while(st.hasMoreTokens()) {
      val[I]=Integer.parseInt(st.nextToken());
      I++;
    }
    return val;
  }


  public static int getMaxVal(int[] Maxval){
    int I,result;
    result=Maxval[0];
    for(I=0;I<Maxval.length;I++){
 if(result<Maxval[I])
   result=Maxval[I];
    }
    return result;
  }
  public static int getMinVal(int[] Minval){
    int I,result;
    result=Minval[0];
    for(I=0;I<Minval.length;I++){
 if(result>Minval[I])
          result=Minval[I];
    }
    return result;
  }
}
/*
//取得指定年月的天数
public static int getMonthDay(int year,int month){
   int result;
   int[] day={31,28,31,30,31,30,31,31,30,31,30,31};
   if(month==2){
     if(year%400=0 || (year%4=0 && year%100!=0)){
	   result=29;
	 }else{
	   result=28;
	 }
   }else{
     result=day[month-1];
   }
   return result;
}

public static String getNextWeek(String toDate){
  int year=Integer.parseInt(toDate.substring(0,4));
  int month=Integer.parseInt(toDate.substring(5,7));
  int day=Integer.parseInt(toDate.substring(8,10));
  int daynum=getMonthDay(year,month);
  if(daynum-day<7){ //下一周不在同一个月内
     day=7-daynum-day;
	 month=month+1;
	 if(month==13){
	   year=year+1;
	   month=1;
	 }  
  }else{
    day=day+7;
  }
  String result=year+"-"+month+"-"+day;
  return result;
}*/