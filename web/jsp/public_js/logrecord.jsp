<jsp:useBean id="setlogBean" scope="page" class="ConnDatabase.SDatabase" />
<%!String loginID="";
   String loginName="";
%>
<% loginID=(String)session.getAttribute("workingID"); 
  loginName=(String)session.getAttribute("loginname"); 
%>
<%!
public String  setlog ( ConnDatabase.SDatabase jBean , 
                               String dengluren , 
                               String jinrumokuai , 
                               String dongzuomiaoxu 
                              ) 
{
    String mess="";
    String sq =   " update logrecord "
                + " set tuichushijian = getDate() "
                + " where id = "
                + " ( select max(id) from logrecord where "
                + " dengluren  = '" + loginName + "' )" ;
   String maxID=loginID;
   String sq2 =   " insert into logrecord "
                 + " (dengluren , jinrushijian , jinrumokuai , dongzuomiaoxu ) "
                 + " values ( "
                 + " '" + loginName + "' , "
                 + " getDate() , "
                 + " '" + jinrumokuai + "' , "
                 + " '" + dongzuomiaoxu + "' "
                 + " ) " ;
    try{
        jBean.executeUpdate( sq ) ;
        jBean.executeUpdate( sq2 ) ;
		mess="ok";
    }catch(Exception exp ) {
        mess="error";
    }
return  sq2;
}

%>
