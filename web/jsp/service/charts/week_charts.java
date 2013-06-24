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

public class week_charts extends Applet {
 //接收从html传进的数据
  public String xtask_no,xbeginX,xendX;
  public String xafter_task_no,xexist_sub_task;
  public String minDate,maxDate,weekcount;
  public String xdatelist,xtask_is_landmark,xresource; 
  public int LEN;
  public String xhidden_no;
  public String xtask_name;
  public String xshow_no;
 //存放数据的数组
  public int[] task_no;
  public int[] show_no;
  public int[] beginX;
  public int[] endX;
  public String[] after_task_no;
  public int[] exist_sub_task;
  public String[] datelist;
  public int[] hidden_no;
  public int[] task_is_landmark;
  public String[] resource;
  public String[] task_name; 
  public int[] task_id;
  public String[] begin_date;
  public String[] end_date;
  public String[] work_day;
  public String[] task_state;
  public String[] week={"日","一","二","三","四","五","六"};
  public String[] month={"一","二","三","四","五","六","七","八","九","十","十一","十二"};
  
  Polygon PL;
  public int cx=0;
  public int cy=0; 
  public int oldx=0;
  public int oldy=0;
  URL docur=null;
  public int move=0;
  Label label1=new Label();
  Label label2=new Label();
  Label label3=new Label();
 
	
  public void init() {
    //setBackground(Color.gray);
	setBackground(Color.white);
    int width=this.getBounds().width;
    int height=this.getBounds().height;
    setSize(width,height); 
	this.add(label1);
    label1.setForeground(Color.black);
	label1.setBackground(new Color(252,250,203));
	label1.setVisible(false);
	this.add(label2);
    label2.setForeground(Color.black);
	label2.setBackground(new Color(252,250,203));
	label2.setVisible(false);
    this.add(label3);
    label3.setForeground(Color.black);
	label3.setBackground(new Color(252,250,203));
	label3.setVisible(false);
  }
 
  public void paint(Graphics g)
  {
     /*img1=getImage(getCodeBase(),"1.gif");//任务条
     img2=getImage(getCodeBase(),"2.gif");//黑三角
     img3=getImage(getCodeBase(),"3.gif");//黑条
     img4=getImage(getCodeBase(),"4.gif");//里程碑
     img5=getImage(getCodeBase(),"jt.gif");//上蓝三角 
     img6=getImage(getCodeBase(),"black.gif");//上黑三角 
     img7=getImage(getCodeBase(),"jt-l.gif");//下蓝三角 
     img8=getImage(getCodeBase(),"jt-b.gif");//下黑三角
	 img9=getImage(getCodeBase(),"jt-b-b.gif");//左黑三角 
	 img10=getImage(getCodeBase(),"jt-b-r.gif");//右黑三角 
	 img11=getImage(getCodeBase(),"jt-l-l.gif");//左蓝三角 
	 img12=getImage(getCodeBase(),"jt-l-r.gif");//右蓝三角 */
	 
	 g.setColor(Color.black);
	 
	 int j=0;int k=0,i=0,m=0;
	 int rowwidth=20;
	 int rowheight=20;
	 int taskheight=10;
	 
	 int yweekcount=Integer.parseInt(weekcount);
	 //g.setColor(new Color(216, 216, 216));
	 g.setColor(new Color(186, 220, 255));
	 g.fillRect(0,0,yweekcount*7*rowwidth,2*rowheight-5);
	 
	  g.drawLine(0,0,yweekcount*7*rowwidth,0);
	  for(j=0;j<=yweekcount;j++)
	  {  
		 g.setColor(new Color(231, 243, 255)); 
		 //g.drawRect(j*7*rowwidth-rowwidth,2*rowheight-5,rowwidth,this.getBounds().height);
         g.fillRect(j*7*rowwidth-rowwidth,2*rowheight-5,rowwidth,this.getBounds().height);
		 if(j<yweekcount){
		    //g.drawRect(j*7*rowwidth,2*rowheight-5,rowwidth,this.getBounds().height);
            g.fillRect(j*7*rowwidth,2*rowheight-5,rowwidth,this.getBounds().height);
		 }
		 //g.setColor(Color.black);
		 g.setColor(new Color(154,197,233));
		 g.drawLine(j*7*rowwidth,2*rowheight-5,j*7*rowwidth,this.getBounds().height);
	  }
       
	 //画日期表格
	 for(j=0;j<yweekcount;j++)
	 {
		
		g.setColor(Color.black);
	    g.drawRect(j*7*rowwidth,0,7*rowwidth,rowheight);
		g.setColor(Color.black);
	    g.drawString(datelist[j],j*7*rowwidth+10,rowheight-5);
	 }
	
	 for(j=0;j<yweekcount;j++)
	 {
	    for(k=0;k<7;k++)
	    {
            g.setColor(Color.black);
	        g.drawRect(j*7*rowwidth+k*rowwidth,rowheight,rowwidth,rowheight-5);
			g.setColor(Color.black);
			g.drawString(week[k],j*7*rowwidth+k*rowwidth+5,2*rowheight-7);
			
	    }
	 }    	
  
	 g.setColor(new Color(154,197,233));
	 g.drawLine(0,this.getBounds().height,yweekcount*7*rowwidth,this.getBounds().height);
    
	 String yyafter_task_no;
	 String[] yafter_task_no;
     int yup_task_code=0;
     int yexist_sub_task=0;
     int ytask_is_landmark=0;
	 int ybeginX=0;
	 int yendX=0;
	 int ydown_length=0;
	 int after_no=0;
	 int ytask_no=0;
	 String after_type;
	 String yresource="";
     String ybegin_date;
     String yend_date;
	 String ytask_name;
	 String yytaskstate="";
	 int[] after;
	 double ytask_state=0.0d;
	 
	 //int ydatelength;
	 int add=0;
	 int[] ydown_task_code;
	 int x1,y1,x2,y2;
	 //g.drawString("LEN="+LEN,80,160);
	 j=0;
	 for(j=0;j<LEN;j++)
	 {    
	    
		ytask_no=task_no[j];
	    yyafter_task_no=after_task_no[j];
	    yafter_task_no=Substr3(yyafter_task_no);
		
	    yexist_sub_task=exist_sub_task[j];
	    ytask_is_landmark=task_is_landmark[j];
	    ybeginX=beginX[j];
	    yendX=endX[j];
		ytask_name=task_name[j];
	   
		/*try{
		ytask_state=Double.parseDouble("0.0");
		} catch(java.lang.NumberFormatException e) {
             System.err.println("error: " + e.getMessage());
       }*/
	 
	    yytaskstate=task_state[j];
		Double test=new Double(yytaskstate);
	    ytask_state=test.doubleValue();
		//ytask_state=Float.parseFloat(yytaskstate);
	    if(test_task_hidden(ytask_no)==0){
			k=m+2;
			m++;			
		   //j++;
			if(yexist_sub_task==1)
			{  
			   //g.drawImage(img3,ybeginX*rowwidth-rowwidth/2,k*rowheight,(yendX-ybeginX+1)*rowwidth+rowwidth,rowheight/2,null);
			   g.setColor(new Color(198,198,198));
			   g.fillRect(ybeginX*rowwidth-rowwidth/2,k*rowheight,(yendX-ybeginX+1)*rowwidth+rowwidth,rowheight/2);
			   g.setColor(Color.black);
			   g.drawRect(ybeginX*rowwidth-rowwidth/2,k*rowheight,(yendX-ybeginX+1)*rowwidth+rowwidth,rowheight/2);
			   
			   g.setColor(Color.black);
			   if(ytask_state>0 && ytask_state<100){
			     g.fillRect(ybeginX*rowwidth-rowwidth/2,k*rowheight,(int)(ytask_state*(yendX-ybeginX+1)*rowwidth/100)+rowwidth/2,rowheight/2);
			   }
			   if(ytask_state>=100){
                 g.fillRect(ybeginX*rowwidth-rowwidth/2,k*rowheight,(yendX-ybeginX+1)*rowwidth+rowwidth,rowheight/2);
			   }
			   //g.fillRect(ybeginX*rowwidth=rowwidth/2,k*rowheight,(ytask_state*(yendX-ybeginX+1)*rowwidth/100),rowheight/2);
			   //g.fillRect(ybeginX*rowwidth-rowwidth/2,k*rowheight,(yendX-ybeginX+1)*rowwidth+rowwidth,rowheight/2);
			   PL=new Polygon();
			   PL.addPoint(ybeginX*rowwidth-rowwidth/2,k*rowheight+rowheight/2);
			   PL.addPoint(ybeginX*rowwidth-rowwidth/2+5,k*rowheight+rowheight/2+5);
			   PL.addPoint(ybeginX*rowwidth,k*rowheight+rowheight/2);
			   PL.addPoint(ybeginX*rowwidth-rowwidth/2,k*rowheight+rowheight/2);
			  //  g.setColor(Color.black);
			   g.setColor(new Color(198,198,198));
               g.fillPolygon(PL);
			   g.setColor(Color.black);
			   g.drawPolygon(PL);               
			   
			   if(ytask_state>0){
				g.setColor(Color.black);
			    g.fillPolygon(PL);
			   }
			   PL.addPoint((yendX+1)*rowwidth,k*rowheight+rowheight/2);
			   PL.addPoint((yendX+1)*rowwidth+5,k*rowheight+rowheight/2+5);
			   PL.addPoint((yendX+1)*rowwidth+rowwidth/2,k*rowheight+rowheight/2);
			   PL.addPoint((yendX+1)*rowwidth,k*rowheight+rowheight/2);
			  //  g.setColor(Color.black);
			   g.setColor(new Color(198,198,198));
               g.fillPolygon(PL);
               g.setColor(Color.black);
			   g.drawPolygon(PL);
			   		   
			   if(ytask_state>=100){
				 g.setColor(Color.black);
			     g.fillPolygon(PL);
			   }
			   //g.drawImage(img2,ybeginX*rowwidth-rowwidth/2,k*rowheight+rowheight/2,null);
			   //g.drawImage(img2,(yendX+1)*rowwidth,k*rowheight+rowheight/2,null);
			   g.drawString(ytask_name,(yendX+2)*rowwidth+rowwidth/2,k*rowheight+taskheight);
			}else
			{
			   if(ytask_is_landmark==0)
			   {
                  g.setColor(new Color(186,216,246));
                  g.fillRect(ybeginX*rowwidth,k*rowheight,(yendX-ybeginX+1)*rowwidth,taskheight);
				  g.setColor(Color.blue);
				  g.drawRect(ybeginX*rowwidth,k*rowheight,(yendX-ybeginX+1)*rowwidth,taskheight);
				  
				  g.setColor(Color.blue);
				  if(ytask_state>0 && ytask_state<100){
				     g.fillRect(ybeginX*rowwidth,k*rowheight,(int)(ytask_state*(yendX-ybeginX+1)*rowwidth/100),taskheight);
				  }
				  if(ytask_state>=100){
				     g.fillRect(ybeginX*rowwidth,k*rowheight,(yendX-ybeginX+1)*rowwidth,taskheight); 
				  }
				  //g.fillRect(ybeginX*rowwidth,k*rowheight,(yendX-ybeginX+1)*rowwidth,taskheight);
				  g.drawString(ytask_name,(yendX+1)*rowwidth+rowwidth,k*rowheight+taskheight);
			   }else
			   {    
				  g.setColor(Color.black);
				  PL=new Polygon();
				  PL.addPoint(ybeginX*rowwidth-5,k*rowheight+taskheight/2);
				  PL.addPoint(ybeginX*rowwidth,k*rowheight+taskheight/2+5);
				  PL.addPoint(ybeginX*rowwidth+5,k*rowheight+taskheight/2);
				  PL.addPoint(ybeginX*rowwidth,k*rowheight+taskheight/2-5);
				  PL.addPoint(ybeginX*rowwidth-5,k*rowheight+taskheight/2);
				  g.fillPolygon(PL);
				  //g.drawImage(img4,ybeginX*rowwidth-rowheight/2,k*rowheight,null);
				  g.drawLine(ybeginX*rowwidth,k*rowheight+taskheight/2,(yendX+1)*rowwidth,k*rowheight+taskheight/2);
				  g.drawString(ytask_name,(yendX+1)*rowwidth+rowwidth,k*rowheight+taskheight);
				  //g.drawString(ybegin_date.substring(5,10),ybeginX*rowwidth-rowheight/2+15,k*rowheight+10);
				  /*if(ydown_task_code.length>0 && ydown_task_code[0]>0){
				  g.drawLine((ybeginX)*rowwidth+ydown_length,k*rowheight+taskheight/2,(yendX+1)*rowwidth+ydown_length,k*rowheight+taskheight/2);
				  */
			   }    
			}
			
			 if(ytask_is_landmark==1)
			 {
				 g.setColor(Color.black);
			 }else
			 {
				 if(yexist_sub_task==0)
				 {
					 g.setColor(Color.blue);
				 }else
				 {
					 g.setColor(Color.black);
				 }
			 }
					  
			
			if(!yafter_task_no[0].equals("0"))
			{  
			   for(i=0;i<yafter_task_no.length;i++)
			   {
				  after_type=yafter_task_no[i].substring(0,2);
				  after_no=Integer.parseInt(yafter_task_no[i].substring(2,yafter_task_no[i].length()));
				  after=get_after_task(ytask_no,after_no);
							
				  if(after[0]>-1)
				  {  
				
					 if(after_type.equals("FS"))
					 {  //如果是FS类型
						if(after[1]-yendX>=1)
					 {
						//画第一条横线
						x1=(yendX+1)*rowwidth;
						if(yexist_sub_task==1)
						 {
							x1=(yendX+1)*rowwidth+rowwidth/2;
						 }
						y1=k*rowheight+taskheight/2;
						y2=y1;
						
						if(after[1]-yendX==1)
						{
						   x2=x1+rowwidth/2;
						}else
						{
						   if(after[3]==1 && after[0]-ytask_no<0)
						   {
							  x2=after[1]*rowwidth+rowwidth/2;
						   }else
						   {
							  x2=after[1]*rowwidth;
						   }
						}
						g.drawLine(x1,y1,x2,y2);

						//画第二条竖线
						x1=x2;
						if(after_no>ytask_no)
						 {
							 y2=(after[0]+2)*rowheight;
						 }else
						 {
							 y2=(after[0]+2)*rowheight+taskheight;
						 }               
						g.drawLine(x1,y1,x2,y2);
			
						//画三角
						x1=x2-5;
						y1=y2;
						if(after_no>ytask_no)
						{                        
						   PL=new Polygon();
						   PL.addPoint(x1,y1-5);
						   PL.addPoint(x1+10,y1-5);
						   PL.addPoint(x1+5,y1);
						   PL.addPoint(x1,y1-5);
						   g.fillPolygon(PL);
						}else
						{
						   PL=new Polygon();
						   PL.addPoint(x1,y1+5);
						   PL.addPoint(x1+10,y1+5);
						   PL.addPoint(x1+5,y1);
						   PL.addPoint(x1,y1+5);
						   g.fillPolygon(PL);
						}  
					 }else
					 {
						//画第一条横线
						x1=(yendX+1)*rowwidth;
						if(yexist_sub_task==1)
						 {
							x1=(yendX+1)*rowwidth+rowwidth/2;
						 }
						y1=k*rowheight+taskheight/2;
						y2=y1;
						
						x2=x1+rowwidth/4;
						g.drawLine(x1,y1,x2,y2);
				  
						//画第二条竖线
						x1=x2;
						if(after_no<ytask_no)
						{
						   y2=y1-rowheight/2;
						}else
						{
						   y2=y1+rowheight/2;
						}
						g.drawLine(x1,y1,x2,y2);
				 
						//画第三条横线
						if(after[3]==1){
						   x2=after[1]*rowwidth-rowwidth;
						}else
						{  
						   x2=after[1]*rowwidth-rowwidth/2;
						}
						//x2=after[1]*rowwidth-rowwidth/2;
						y1=y2;
						g.drawLine(x1,y1,x2,y2);
				 
						//画第四条竖线
						x1=x2;
						if(after_no<ytask_no)
						{
						   y2=(after[0]+2)*rowheight+taskheight/2;
						}else
						{
						   y2=(after[0]+3)*rowheight+taskheight/2;
						}
						y2=(after[0]+2)*rowheight+taskheight/2;
						g.drawLine(x1,y1,x2,y2);
				  
						//画第五条横线
						x2=x1+rowwidth/2;
						if(yexist_sub_task==1){
						 x2=x1+3*rowwidth/4;
						}
						//x2=x1+rowwidth/2;
						y1=y2;
						g.drawLine(x1,y1,x2,y2);
					
						//画三角
						x1=x2-5;
						PL=new Polygon();
						PL.addPoint(x1,y1-5);
						PL.addPoint(x1,y1+5);
						PL.addPoint(x1+5,y1);
						PL.addPoint(x1,y1-5);
						g.fillPolygon(PL);					 
					 }  
				  }  
			  
				  if(after_type.equals("SS"))
				  {  //如果是SS类型
					 if(after[1]-ybeginX>=0)
					 {  
						//画第一条横线
						x1=ybeginX*rowwidth;
						y1=k*rowheight+taskheight/2;
						y2=y1;
						if(yexist_sub_task==0)
						{
							if(after[1]==ybeginX)
							{
								x2=x1-rowwidth/2;
							}else
							{
								x2=x1-rowwidth/4;
							}
						}else
						{
							if(after[1]==ybeginX)
							{
								x2=x1-rowwidth/2-rowwidth/2;
							}else
							{
								x2=x1-rowwidth/2-rowwidth/4;
							}
						}
						g.drawLine(x1,y1,x2,y2);

						//画第二条竖线
						x1=x2;
						y2=(after[0]+2)*rowheight+taskheight/2;
						g.drawLine(x1,y1,x2,y2);
					 
						//画第三条横线
						x2=after[1]*rowwidth;
						y1=y2;
						g.drawLine(x1,y1,x2,y2);
					  
						//画三角
						x1=x2-5;
						PL=new Polygon();
						PL.addPoint(x1,y1-5);
						PL.addPoint(x1,y1+5);
						PL.addPoint(x1+5,y1);
						PL.addPoint(x1,y1-5);
						g.fillPolygon(PL);	                    
				  
					 }else
					 {
						//画第一条横线
						x1=ybeginX*rowwidth;
						if(yexist_sub_task==1)
						 {
							x1=ybeginX*rowwidth-rowwidth/2;
						 }
						y1=k*rowheight+taskheight/2;
						y2=y1;
						if(after[3]==0)
						{  
						   x2=after[1]*rowwidth-rowwidth/2;
						}else
						{
						   x2=after[1]*rowwidth-rowwidth/2-rowwidth/2;
						}
						g.drawLine(x1,y1,x2,y2);
				  
						//画第二条竖线
						x1=x2;
						y2=(after[0]+2)*rowheight+taskheight/2;
						g.drawLine(x1,y1,x2,y2);
				 
						//画第三条横线
						x2=x1+rowwidth/2;					 
						y1=y2;
						g.drawLine(x1,y1,x2,y2);				    	

						//画三角
						x1=x2-5;
						PL=new Polygon();
						PL.addPoint(x1,y1-5);
						PL.addPoint(x1,y1+5);
						PL.addPoint(x1+5,y1);
						PL.addPoint(x1,y1-5);
						g.fillPolygon(PL);	    
					 }    
				  }     
					  
				  if(after_type.equals("FF"))
				  {  //如果是FF类型
					 if(after[2]-yendX>=0)
					 {
						//画第一条横线
						x1=(yendX+1)*rowwidth;
						y1=k*rowheight+taskheight/2;
						y2=y1;
					   
						x2=(after[2]+1)*rowwidth+rowwidth/2;                    
						g.drawLine(x1,y1,x2,y2);
				   
						//画第二条竖线
						x1=x2;
						y2=(after[0]+2)*rowheight+taskheight/2;
						g.drawLine(x1,y1,x2,y2);
				   
						//画第三条横线
						x2=x1-rowwidth/2;
						y1=y2;
						g.drawLine(x1,y1,x2,y2);
				   
						//画三角
						x1=x2+5;
						PL=new Polygon();
						PL.addPoint(x1,y1+5);
						PL.addPoint(x1,y1-5);
						PL.addPoint(x1-5,y1);
						PL.addPoint(x1,y1+5);
						g.fillPolygon(PL);	
							  
					 }else
					 {
						//画第一条横线
						x1=(yendX+1)*rowwidth;
						y1=k*rowheight+taskheight/2;
						y2=y1;
						
						x2=x1+rowwidth/4;
						g.drawLine(x1,y1,x2,y2);
				  
						//画第二条竖线
						x1=x2;
						y2=(after[0]+2)*rowheight+taskheight/2;
						g.drawLine(x1,y1,x2,y2);
				  
						//画第三条横线
						x2=(after[2]+1)*rowwidth;
						y1=y2;
						g.drawLine(x1,y1,x2,y2);
									 
						//画三角
						x1=x2+5;
						PL=new Polygon();
						PL.addPoint(x1,y1+5);
						PL.addPoint(x1,y1-5);
						PL.addPoint(x1-5,y1);
						PL.addPoint(x1,y1+5);
						g.fillPolygon(PL);

					 }      
				  }   
			  
			  
				  if(after_type.equals("SF"))
				  {  //如果是SF类型
					 if(after[2]-ybeginX>=-1)
					 {
						//画第一条横线
						x1=ybeginX*rowwidth;
						y1=k*rowheight+taskheight/2;
						y2=y1;
					   
						x2=x1-rowwidth/4;
						g.drawLine(x1,y1,x2,y2);

						//画第二条竖线
						x1=x2;
						if(after_no<ytask_no)
						{
						   y2=y1-rowheight/2;
						}else
						{
						   y2=y1+rowheight/2;
						}
						g.drawLine(x1,y1,x2,y2);
				   
						//画第三条横线
						x2=(after[2]+1)*rowwidth+rowwidth/2;
						y1=y2;
						g.drawLine(x1,y1,x2,y2);
				   
						//画第四条竖线
						x1=x2;
						y2=(after[0]+2)*rowheight+taskheight/2;
						g.drawLine(x1,y1,x2,y2);
				   
						//画第五条横线
						y1=y2;
						x2=x1-rowwidth/2;
						g.drawLine(x1,y1,x2,y2);
				   
						//画三角
						x1=x2+5;
						PL=new Polygon();
						PL.addPoint(x1,y1+5);
						PL.addPoint(x1,y1-5);
						PL.addPoint(x1-5,y1);
						PL.addPoint(x1,y1+5);
						g.fillPolygon(PL);

							  
					 }else
					 {
						//画第一条横线
						x1=ybeginX*rowwidth;
						y1=k*rowheight+taskheight/2;
						y2=y1;
						
						x2=x1-rowwidth/4;
						g.drawLine(x1,y1,x2,y2);

						//画第二条竖线
						x1=x2;
						y2=y1+rowheight/2;
						g.drawLine(x1,y1,x2,y2);
							  
						//画第三条横线
						x2=(after[2]+1)*rowwidth+rowwidth/2;
						y1=y2;
						g.drawLine(x1,y1,x2,y2);
					
						//画第四条竖线
						x1=x2;
						y2=(after[0]+2)*rowheight+taskheight/2;
						g.drawLine(x1,y1,x2,y2);
					
						//画第五条横线
						y1=y2;
						x2=x1-rowwidth/2;
						g.drawLine(x1,y1,x2,y2);
								 
						 //画三角
						x1=x2+5;
						PL=new Polygon();
						PL.addPoint(x1,y1+5);
						PL.addPoint(x1,y1-5);
						PL.addPoint(x1-5,y1);
						PL.addPoint(x1,y1+5);
						g.fillPolygon(PL);

					  }          
				   }   
				} 
			 }        
		  }       
	   }      
     }	 
  } 
  
   

   public boolean mouseMove(Event event, int x, int y )
	{
	    cx=x;
		cy=y;
		String  test[];
	    int I,J;
		I=cy/20-1;
		int i1,i2,i3,i4;
		test=get_task(I-1);

	    if(Integer.parseInt(test[0])>-1){
           i1=Integer.parseInt(test[1]);
		   i2=Integer.parseInt(test[2]);
		   i3=Integer.parseInt(test[3]);
           if(cx>=i1*20-20/2 && cx<=(i2+1)*20+20/2){
			   J=(i2+1)*20;
			   if(i3==1){
				   J=J+10;	   			    
			   }
			   label1.reshape(J,(I+1)*20+10,240,15);
			   label1.setText("任务:"+test[8]);
			   label1.setVisible(true);		   
			   label2.reshape(J,(I+1)*20+10+15,240,15);
			   label2.setText("开始日期:"+test[5]+" 工期:"+test[7]+"工作日");
			   label2.setVisible(true);
			   label3.reshape(J,(I+1)*20+10+30,240,15);
			   label3.setText("完成日期:"+test[6]);			 
			   label3.setVisible(true);
	      }
		}else{
           label1.setVisible(false);
		   label2.setVisible(false);
		   label3.setVisible(false);
		}	   
		return false;
	}

  public boolean mouseDown(Event event, int x, int y) 
	{
	  String test[];
	  int I,J;
	  I=cy/20-1;
	  test=get_task(I-1);
      int i1,i2,i3,i4;
	 
	  if(Integer.parseInt(test[0])>-1){
		   i1=Integer.parseInt(test[1]);
		   i2=Integer.parseInt(test[2]);
		   i3=Integer.parseInt(test[3]);
         if(cx>=i1*20-20/2 && cx<=(i2+1)*20+20/2){
			  try
			  {
				 docur=new URL(getCodeBase()+"show_task.jsp?task_id="+test[4]+"&cansubmit=0");
				 getAppletContext().showDocument(docur,"_blank");
			  }catch(Exception se)
			  {
				 System.out.print("error");
			  }
		 }
	  }	   
	  return false;
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

 

  public  int[] get_after_task(int taskno,int after_taskno){
     int I=0;
	 int[] val=new int[4];
	 val[0]=-1;
	 val[1]=0;
	 val[2]=0;
	 val[3]=0; 
	 for(I=0;I<show_no.length;I++)
	  {
		 if(show_no[I]==after_taskno)
		  {
			 val[0]=I;			 
			 break;
		  }
	  }
	  if(val[0]>-1){

		  for(I=0;I<task_no.length;I++)
		  {
			 if(task_no[I]==after_taskno)
			  {
				 val[1]=beginX[I];
				 val[2]=endX[I];
				 val[3]=exist_sub_task[I]; 			 
				 break;
			  }
		  }
	  }
	 return val; 
  }
  
  public String[] get_task(int i){
    String[] result=new String[9];
	result[0]="-1";
	result[1]="0";
	result[2]="0";
	result[3]="0";
	result[4]="0";
	result[5]="0";
	result[6]="0";
	result[7]="0";
	result[8]="0";
	int I;
	if(i<show_no.length){
	  result[0]=""+show_no[i];
	  for(I=0;I<task_no.length;I++){
		 if(task_no[I]==show_no[i]){
			 result[1]=""+beginX[I];
			 result[2]=""+endX[I];
			 result[3]=""+exist_sub_task[I];
			 result[4]=""+task_id[I];
			 result[5]=""+begin_date[I];
			 result[6]=""+end_date[I];
			 result[7]=""+work_day[I];
			 result[8]=""+task_name[I];
		 }
	   }
	}
	return result;
  }
  public int test_task_hidden(int taskno){
    int result;	
	int I;
	result=1;
	for(I=0;I<show_no.length;I++){
      if(show_no[I]==taskno){
	    result=0;
		break;
	  }
	}	
	return result;  
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
  
 
  
 public void setParameter(String task_no,String beginX,String endX,String after_task_no,String exist_sub_task,String task_is_landmark,String datelist,String weekcount,String hidden_no,String task_name,String show_no,String task_id,String begin_date,String end_date,String work_day,String task_state){
        this.xtask_no=task_no;
		this.xbeginX=beginX;
		this.xendX=endX;
		this.xafter_task_no=after_task_no;
		this.xexist_sub_task=exist_sub_task;
		this.xtask_is_landmark=task_is_landmark;
		this.xdatelist=datelist;
		this.weekcount=weekcount;
		this.xhidden_no=hidden_no;
		this.xtask_name=task_name;
		this.task_no=Substr1(task_no);
        this.beginX=Substr1(beginX);
	    this.endX=Substr1(endX);
        this.after_task_no=Substr2(after_task_no);
		this.exist_sub_task=Substr1(exist_sub_task);
	    this.task_is_landmark=Substr1(task_is_landmark);
	  	this.datelist=Substr2(datelist);
		this.hidden_no=Substr1(hidden_no);
		this.task_name=Substr2(task_name);
		this.show_no=Substr1(show_no);
		this.task_id=Substr1(task_id);
		this.begin_date=Substr2(begin_date);
		this.end_date=Substr2(end_date);
		this.work_day=Substr2(work_day);
		this.task_state=Substr2(task_state);
		this.LEN=this.task_no.length;
 }
}


