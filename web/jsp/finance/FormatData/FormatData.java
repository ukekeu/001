 

package FormatData;
import java.util.*;

public class FormatData {
  
 public String getFloat(float temp,int lens) {
      String tempstr="";
      if(temp<0)
      {
         temp=-temp;
         tempstr="-";
      }
		java.text.DecimalFormat df = null;
		if (lens == 4)
			df = new java.text.DecimalFormat("###.####");
		if (lens == 3)
			df = new java.text.DecimalFormat("##,###,###.###");
		if (lens == 2)
			df = new java.text.DecimalFormat("##,###,###.##");
		if (lens == 1)
			df = new java.text.DecimalFormat("##,###,###.#");	
		if (lens == 0)
    		df = new java.text.DecimalFormat("##,###,###");	
		return (tempstr+df.format(temp).toString());
	}
 public String getFloat1(float temp,int lens) {
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
		return df.format(temp).toString();
	}
 
public String getFloat3(float temp,int lens) 
{
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
                String a=df.format(temp).toString();
                if(a.equals("0.0") || a.equals("0"))
                  a="";
                else
                {
                 int pos=a.indexOf(".");
                 if(pos==-1)
                    a=a+".00";
                 else
                 {
                   int slen=a.substring(pos+1).length();
                   for(int i=0;i<2-slen;i++)
                   {
                     a+="0";
                   }
                 }
                }
		return a;
	}
public String changeStr(String a) {
      //String s="";
		if(a.equals("0.0") || a.equals("0"))
         a="";
      else
      {
         int pos=a.indexOf(".");
         if(pos==-1)
            a=a+".00";
         else
         {
             int slen=a.substring(pos+1).length();
             for(int i=0;i<2-slen;i++)
             {
                  a+="0";
             }
         }
         //s=""+a;
      }
		return a;
	}
	public String getFloat4(float temp,int lens) 
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
	      return "/";
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

      int pos=strf.indexOf(".");
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
	  }
      return retstr;		
	}
	public String getFloat2(double temp,int lens) 
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
	      return "/";
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

      int pos=strf.indexOf(".");
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
	  }
      return retstr;		
	}
    public String getFloat5(String strtfloat,int lens) 
    {
       String tempstr="";
	   String strf="";
	   String retstr="";
	   float temp=0.0f;
	   if(strtfloat==null)
		  return "";
	   else if(strtfloat.equals(""))
		  return "";

	   temp=Float.parseFloat(strtfloat);

       if(temp<0)
       {
         temp=-temp;
         tempstr="-";
       }
       if(temp==0 || temp==0.0)
	      return "/";
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

      int pos=strf.indexOf(".");
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
	  }
      return retstr;		
	}
	public String getFloat6(float temp,int lens) 
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
	      return "0.00";
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

      int pos=strf.indexOf(".");
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
	  }
      return retstr;		
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
	      return "0.00";
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

      int pos=strf.indexOf(".");
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
	  }
      return retstr;		
	}
   public String getFloat8(String strtfloat,int lens) 
    {
      String tempstr="";
	   String strf="";
	   String retstr="";
	   float temp=0.0f;
	   if(strtfloat==null)
		  return "0.00";
	   else if(strtfloat.equals(""))
		  return "0.00";

	   temp=Float.parseFloat(strtfloat);

       if(temp<0)
       {
         temp=-temp;
         tempstr="-";
       }
       if(temp==0 || temp==0.0)
	      return "0.00";
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

      int pos=strf.indexOf(".");
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
	  }
      return retstr;		
	}


}






