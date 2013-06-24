package ConnDB;

import java.io.InputStream;
import java.io.PrintStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ConnDatabase.MailHandler;
import ConnDatabase.SDatabase;

public class ConnODBC
{
	private static Logger logger = LoggerFactory.getLogger(ConnODBC.class);

  String sDBDriver = "com.microsoft.jdbc.sqlserver.SQLServerDriver";
  String sConnStr = "jdbc:microsoft:sqlserver://127.0.0.1:1433";
  String user = "";
  String pass = "";
  String database = "";
  public Connection conn = null;
  ResultSet rs = null;
  Statement stmt = null;
  boolean transactionFlag = true;

  public void getDBdriver() {
    Properties localProperties = new Properties();
    InputStream localInputStream = getClass().getResourceAsStream("../../DataSource.Properties");
    try {
      localProperties.load(localInputStream);
    }
    catch (Exception localException) {
    	logger.error(localException.getMessage() + "can't   read   the   file");
    }
    this.user = localProperties.getProperty("DataSource.sauser");
    this.pass = localProperties.getProperty("DataSource.sapass");
    this.database = localProperties.getProperty("DataSource.database");
    this.sConnStr = localProperties.getProperty("DataSource.sConnStr");
    this.sDBDriver = localProperties.getProperty("DataSource.sDBDriver");
  }
  public ConnODBC() {
    try { getDBdriver();
      Class.forName(this.sDBDriver);
      setConnection();
      this.conn.setCatalog(this.database);
      this.stmt = this.conn.createStatement();
    } catch (ClassNotFoundException localClassNotFoundException)
    {
    	logger.error("ConnDatabase(): " + localClassNotFoundException.getMessage());
    }
    catch (SQLException localSQLException) {
    	logger.error("ConnDatabase(): " + localSQLException.getMessage());
    }
  }

  public int executeUpdate(String paramString) throws SQLException {
    int i = this.stmt.executeUpdate(paramString);
    return i;
  }

  public ResultSet executeQuery(String paramString) throws SQLException {
    this.rs = null;
    this.rs = this.stmt.executeQuery(paramString);
    return this.rs;
  }

  public void setConnection() throws SQLException {
    this.conn = DriverManager.getConnection(this.sConnStr, this.user, this.pass);
  }

  public void startTransaction() throws SQLException
  {
    this.transactionFlag = false;

    this.conn.setAutoCommit(this.transactionFlag);
  }

  public void endTransaction() throws SQLException {
    this.transactionFlag = true;
    this.conn.setAutoCommit(this.transactionFlag);
  }

  public boolean isAutocommit() {
    return this.transactionFlag;
  }

  public void commit() throws SQLException
  {
    if (!isAutocommit()) {
      this.conn.commit();
      logger.debug("commit");
    }
  }

  public void rollback() throws SQLException { if (!isAutocommit())
      this.conn.rollback();
  }

  public void closeConnection()
    throws SQLException
  {
    if (this.conn == null)
    {
      return;
    }

    this.conn.close();
    this.conn = null;
    this.stmt = null;
  }

  public void sendtomaill(String paramString)
  {
    MailHandler localMailHandler = new MailHandler("zlsale@vip.163.com", new String[] { "zlsale@vip.163.com" }, "已有客户在使用，请核对是否为合法用户", paramString);
    localMailHandler.send();
  }
}