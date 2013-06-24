<%response.setHeader("Pragma","No-cache"); 
response.setHeader("Cache-Control","no-cache"); 
response.setDateHeader("Expires", 0);  %>
<%@ page contentType="text/html;charset=GBK" %>
  <%
  String useridl=(String) session.getAttribute("loginid");
  if (useridl==null||useridl.equals("")){

   response.sendRedirect("../../index.jsp");

  }
  


%> 
<%!  public String getFloat6(float temp,int lens) 
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
}%>