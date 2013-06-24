package com.excenon.sms.moduleUtil;

import com.excenon.sms.DBHelper;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public final class SMSEchoUtil
{
  public static boolean insertSMSEcho(String sc_ucnum, String sc_cee, int sc_msgId, int sc_res, String sc_vt)
  {
    boolean result = false;
    Connection con = null;
    try
    {
      con = DBHelper.getConnection();
      PreparedStatement ps = con
        .prepareStatement("insert into sms_echo(sc_ucnum,sc_cee,sc_msgid,sc_res,sc_vt) values(?,?,?,?,?)");
      ps.setString(1, sc_ucnum);
      ps.setString(2, sc_cee);
      ps.setInt(3, sc_msgId);
      ps.setInt(4, sc_res);
      ps.setString(5, sc_vt);
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