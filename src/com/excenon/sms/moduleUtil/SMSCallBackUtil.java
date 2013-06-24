package com.excenon.sms.moduleUtil;

import com.excenon.sms.DBHelper;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Date;

public final class SMSCallBackUtil
{
  public static boolean insertSMSCallBack(int scb_event, String scb_session, String scb_res, String para1)
  {
    boolean result = false;
    Connection con = null;
    try {
      con = DBHelper.getConnection();
      PreparedStatement ps = con
        .prepareStatement("insert into sms_callback(scb_time,scb_event,scb_session,scb_res,scb_para1) values(?,?,?,?,?)");

      ps.setLong(1, new Date().getTime());
      ps.setInt(2, scb_event);
      ps.setString(3, scb_session);
      ps.setString(4, scb_res);
      ps.setString(5, para1);
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