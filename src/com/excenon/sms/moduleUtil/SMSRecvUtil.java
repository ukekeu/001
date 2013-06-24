package com.excenon.sms.moduleUtil;

import com.excenon.sms.DBHelper;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public final class SMSRecvUtil
{
  public static boolean insertSMSRecv(String sr_time, String sr_caller, String sr_content, String sr_ucnum)
  {
    boolean result = false;
    Connection con = null;
    try {
      con = DBHelper.getConnection();
      PreparedStatement ps = con
        .prepareStatement("insert into sms_recv(sr_time,sr_caller,sr_content,sr_ucnum) values(?,?,?,?)");
      ps.setString(1, sr_time);
      ps.setString(2, sr_caller);
      ps.setString(3, sr_content);
      ps.setString(4, sr_ucnum);
      ps.execute();
      result = true;
    }
    catch (Exception e) {
      e.printStackTrace();
      try {
        if (!con.getAutoCommit())
          con.rollback();
      } catch (SQLException localSQLException) {
      }
    }
    finally {
      DBHelper.close(con);
    }
    return result;
  }
}