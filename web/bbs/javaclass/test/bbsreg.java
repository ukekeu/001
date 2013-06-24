package test;
import java.sql.*;

public class  bbsreg{
String sDBDriver = "sun.jdbc.odbc.JdbcOdbcDriver";
String sConnStr = "jdbc:odbc:bbs";
Connection conn = null;
ResultSet rs = null;

public bbsreg() {
try {
Class.forName(sDBDriver); 
}
catch(java.lang.ClassNotFoundException e) {
System.err.println("bbsreg(): " + e.getMessage());
}
}

public ResultSet executeQuery(String sql) {
rs = null;
try {
conn = DriverManager.getConnection(sConnStr); 
Statement stmt = conn.createStatement();
rs = stmt.executeQuery(sql);
} 
catch(SQLException ex) { 
System.err.println("aq.executeQuery: " + ex.getMessage());
System.err.println("aq.executeQuerystrSQL: " + sql);
}
return rs;
}


public void executeUpdate(String sql) {
try {
conn = DriverManager.getConnection(sConnStr); 
Statement stmt = conn.createStatement();
stmt.executeUpdate(sql);
} 
catch(SQLException ex) { 
System.err.println("aq.executeUpdate: " + ex.getMessage());
System.err.println("aq.executeUpadatestrSQL: " + sql);
}
}

}