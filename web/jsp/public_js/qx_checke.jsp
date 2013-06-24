<%!
public String  checke_qx ( ConnDatabase.SDatabase Bean , 
                               String sellerid ,String modulename 
                               
                              ) 
{							  
 String qx="select * from PopedomConrtrol where  sellerid='"+sellerid+"' and ModuleNo='"+modulename+"'";
String check="";

try{

ResultSet rs=Bean.executeQuery(qx);
if (rs.next()){
  check=rs.getString("checked");

}
rs.close();
}catch(Exception s){return s.getMessage();}
 return check;
 }
 %>
