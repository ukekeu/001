package com.excenon.sms;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashSet;
import java.util.Properties;
import java.util.Set;
import java.util.StringTokenizer;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Config
{
  private static final Logger logger = LoggerFactory.getLogger(Config.class);
  public static final String PAY_PROPERTIES = "/sms.properties";
  public static final String PAY_PROP_DEBUG = "/sms.properties.debug";
  private static Properties s_properties;

  public static synchronized void loadConfig()
  {
    s_properties = new Properties();

    InputStream is = Config.class.getResourceAsStream("/sms.properties");
    if (is == null) {
      logger.warn("Can't load config from /sms.properties");
      return;
    }
    try {
      s_properties.load(is);
    } catch (IOException e) {
      throw new OREException("Can't load config", e);
    } finally {
      IOUtils.closeStream(new Object[] { is });
    }
    is = Config.class.getResourceAsStream("/sms.properties.debug");
    if (is != null) {
      logger.warn("**** Overriding config settings in /sms.properties.debug");
      try {
        s_properties.load(is);
      } catch (IOException e) {
        throw new OREException("Can't load config", e);
      } finally {
        IOUtils.closeStream(new Object[] { is });
      }
    }
    s_properties.putAll(System.getProperties());
  }

  public static synchronized void addProperty(Settings key, String value)
  {
    if (s_properties == null) {
      loadConfig();
    }
    logger.info("Add property, key = " + key.getPropertyName() + 
      ", value = " + value);
    s_properties.put(key.getPropertyName(), value);
  }

  public static String getProperty(Settings key)
  {
    if (s_properties == null) {
      loadConfig();
    }
    return (String)s_properties.get(key.getPropertyName());
  }

  public static String getProperty(String key) {
    if (s_properties == null) {
      loadConfig();
    }
    return (String)s_properties.get(key);
  }

  public static int getPropertyAsInt(Settings key)
  {
    String value = getProperty(key);
    if (value != null) {
      try {
        return Integer.parseInt(value);
      } catch (NumberFormatException nfex) {
        throw new RuntimeException("Not integer format for property " + 
          key.getPropertyName(), nfex);
      }
    }
    return 0;
  }

  public static boolean getPropertyAsBoolean(Settings key)
  {
    String value = getProperty(key);
    if (value != null) {
      return Boolean.parseBoolean(value);
    }
    return false;
  }

  public static Set<String> getPropertyAsStringSet(Settings key) {
    HashSet r = new HashSet();

    String value = getProperty(key);
    if (value != null) {
      StringTokenizer stk = new StringTokenizer(value, ",");
      while (stk.hasMoreTokens()) {
        r.add(stk.nextToken());
      }
    }

    return r;
  }

  public static boolean isTrue(Settings key)
  {
    if (s_properties == null) {
      loadConfig();
    }
    String value = (String)s_properties.get(key.getPropertyName());
    return StringUtils.equals(value, "true");
  }

  public static boolean isTrue(String key)
  {
    if (s_properties == null) {
      loadConfig();
    }
    String value = (String)s_properties.get(key);
    return StringUtils.equals(value, "true");
  }

  public static boolean isFalse(Settings key)
  {
    if (s_properties == null) {
      loadConfig();
    }
    String value = (String)s_properties.get(key.getPropertyName());
    return StringUtils.equals(value, "false");
  }

  public static boolean isFalse(String key)
  {
    if (s_properties == null) {
      loadConfig();
    }
    String value = (String)s_properties.get(key);
    return StringUtils.equals(value, "false");
  }

  public static enum Settings
  {
    DATABASE_NAME("database.name"), DATABASE_USER("database.user"), DATABASE_CONNSTR("database.connstr"), DATABASE_DBDRIVER("database.dbdriver"), DATABASE_PASSWD(
      "database.passwd"),  DATABASE_IP_PORT("database.ip.port"), SMS_USER(
      "sms.user"),  SMS_PASSWD("sms.passwd"), SMS_REGISTER_URL(
      "sms.registerurl"),  SMS_SENDSMS_URL("sms.sendsmsurl"), SMS_SENDFAX_URL(
      "sms.sendfaxurl"),  SMS_FINDFAX_URL("sms.findfaxurl"), SMS_CALLBACK_URL(
      "sms.callbackurl"),  SMS_CTDCALL_URL("sms.ctdcallurl"), SMS_CTCCALL_URL(
      "sms.ctccallurl");

    String m_propertyName;

    private Settings(String propertyName) {
      this.m_propertyName = propertyName;
    }

    public String getPropertyName() {
      return this.m_propertyName;
    }
  }
}