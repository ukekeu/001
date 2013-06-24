package com.excenon.sms.moduleUtil;

import com.excenon.sms.DBHelper;
import com.excenon.sms.module.SMSSend;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;

public final class SMSSendUtil
{
  public static SMSSend getSMSSendById(int sms_sendid)
  {
    SMSSend smsSend = new SMSSend();
    Connection con = null;
    try {
      con = DBHelper.getConnection();
      PreparedStatement ps = con
        .prepareStatement("select * from sms_send where sms_sendid=?");
      ps.setInt(1, sms_sendid);
      ResultSet rs = ps.executeQuery();
      if (rs.next()) {
        smsSend.setSms_sendId(rs.getInt("sms_sendid"));
        smsSend.setSs_content(rs.getString("ss_content"));
        smsSend.setSs_mid(rs.getInt("ss_mid"));
        smsSend.setSs_module(rs.getInt("ss_module"));
        smsSend.setSs_msgId(rs.getInt("ss_msgid"));
        smsSend.setSs_receiver(rs.getString("ss_receiver"));
        smsSend.setSs_sender(rs.getString("ss_sender"));
        smsSend.setSs_status(rs.getInt("ss_status"));
        smsSend.setSs_time(rs.getInt("ss_time"));
      }
    } catch (Exception e) {
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
    return smsSend;
  }

  public static boolean insertSMSSend(String info, String tomodule) {
    boolean result = false;
    Connection con = null;
    try {
      con = DBHelper.getConnection();
      PreparedStatement ps = con
        .prepareStatement("insert into sms_send(ss_time,ss_content,ss_msgid,ss_receiver) values(?,?,?,?)");
      Calendar calendar = Calendar.getInstance();
      Long time = Long.valueOf(calendar.getTimeInMillis());
      ps.setLong(1, time.longValue());
      ps.setString(2, info);
      ps.setLong(3, time.longValue());
      ps.setString(4, tomodule);
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