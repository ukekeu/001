// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   sdatabase.java

package ConnDatabase;

import java.io.File;
import java.io.PrintStream;
import java.net.URL;
import java.sql.*;
import java.util.Properties;

import javax.swing.text.html.HTMLDocument.HTMLReader.PreAction;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

// Referenced classes of package ConnDatabase:
//            MailHandler

public class SDatabase {
	private static Logger logger = LoggerFactory.getLogger(SDatabase.class);

	public String getClassPath() {
		String s = "";
		File file = new File(".");
		try {
			s = (new File(getClass().getClassLoader().getResource("").toURI()))
					.getPath();
		} catch (Exception exception) {
		}
		return s;
	}

	public void getDBdriver() {
		Properties properties = new Properties();
		java.io.InputStream inputstream = getClass().getResourceAsStream(
				"../../DataSource.Properties");
		try {
			properties.load(inputstream);
		} catch (Exception exception) {
			logger.error((new StringBuilder()).append(exception.getMessage())
					.append("can't   read   the   file").toString());
		}
		user = properties.getProperty("DataSource.user");
		pass = properties.getProperty("DataSource.pass");
		database = properties.getProperty("DataSource.database");
		sConnStr = properties.getProperty("DataSource.sConnStr");
		sDBDriver = properties.getProperty("DataSource.sDBDriver");
	}

	public SDatabase() {
		getDBdriver();
		conn = null;
		rs = null;
		stmt = null;
		transactionFlag = true;
		try {
			Class.forName(sDBDriver);
			setConnection();
			conn.setCatalog(database);
			stmt = conn.createStatement();
		} catch (ClassNotFoundException classnotfoundexception) {
			logger.error("ConnDatabase(): "
					+ classnotfoundexception.getLocalizedMessage());
		} catch (SQLException sqlexception) {
			logger.error("ConnDatabase(): "
					+ sqlexception.getLocalizedMessage());
		}
	}

	public int executeUpdate(String s) throws SQLException {
		logger.debug("USQL:" + s);
		int i = stmt.executeUpdate(s);
		return i;
	}

	public ResultSet executeQuery(String s) throws SQLException {
		rs = null;
		logger.debug("QSQL:" + s);
		rs = stmt.executeQuery(s);
		return rs;
	}

	public void setConnection() throws SQLException {
		conn = DriverManager.getConnection(sConnStr, user, pass);
		logger.debug("get Connection:" + conn);
	}

	public void startTransaction() throws SQLException {
		transactionFlag = false;
		conn.setAutoCommit(transactionFlag);
	}

	public void endTransaction() throws SQLException {
		transactionFlag = true;
		conn.setAutoCommit(transactionFlag);
	}

	public boolean isAutocommit() {
		return transactionFlag;
	}

	public void commit() throws SQLException {
		if (!isAutocommit()) {
			logger.debug("commit connection:" + conn);
			conn.commit();

		}
	}

	public void rollback() throws SQLException {
		if (!isAutocommit()) {
			logger.debug("rollback connection:" + conn);
			conn.rollback();
		}

	}

	public void sendtomaill(String s) {
		MailHandler mailhandler = new MailHandler(
				"zlsale@vip.163.com",
				new String[] { "zlsale@vip.163.com" },
				"\u5DF2\u6709\u5BA2\u6237\u589E\u52A0\u697C\u76D8\uFF0C\u8BF7\u6838\u5BF9\u662F\u5426\u4E3A\u5408\u6CD5\u7528\u6237",
				s);
		mailhandler.send();
	}

	public void closeConn() {
		if (conn == null) {
			return;
		} else {
			logger.debug("close connection:" + conn);
			try {
				conn.close();
			} catch (SQLException e) {
			}
			conn = null;
			stmt = null;
			return;
		}
	}

	public static void closeConn(ResultSet rs, Statement st, Connection conn) {
		if (rs != null) {
			try {
				if (!rs.isClosed()) {
					rs.close();
				}
			} catch (SQLException e) {
			}
		}

		if (st != null) {
			try {
				if (!st.isClosed()) {
					st.close();
				}
			} catch (SQLException e) {
			}
		}

		if (conn != null) {
			try {
				logger.debug("close connection:" + conn);
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
			}
		}

		conn = null;
		st = null;
		rs = null;
	}

	String sDBDriver;
	String sConnStr;
	String user;
	String pass;
	String database;
	public Connection conn;
	ResultSet rs;
	Statement stmt;
	boolean transactionFlag;
}
