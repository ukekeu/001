package com.excenon.sms.servlet;

import com.excenon.sms.Config;
import com.excenon.sms.ThreadLocalHelper;
import com.excenon.sms.moduleUtil.SMSSendUtil;
import com.sztelecom.vabd.zytx.SMSHelper;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class SendSMSServlet extends HttpServlet {
	private static final Logger logger = LoggerFactory
			.getLogger(SendSMSServlet.class);
	private static final long serialVersionUID = -2294943898569923630L;

	protected void service(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("GBK");
		String[] ids = new String[0];
		String smsinfo = "";
		if (request.getParameter("smsinfo") != null) {
			smsinfo = request.getParameter("smsinfo");
		}
		if (request.getParameter("ids") != null) {
			ids = request.getParameter("ids").split(",");
		}
		logger.info(smsinfo);

		if (ids.length == 0) {
			sendInfo(response, "请填写完整信息");
			return;
		}
		ThreadLocalHelper.init();
		boolean success = false;
		int ingore = 0;
		int msgid = 0;
		try {
			success = SMSHelper.SendSMS(ids, msgid, smsinfo).equals("0");

			if (success)
				SMSSendUtil.insertSMSSend(smsinfo, request.getParameter("ids"));
			sendInfo(response, (success ? "发送成功" : "发送失败") + ",忽略:" + ingore);
		} finally {
			ThreadLocalHelper.cleanup();
		}
	}

	protected void sendInfo(HttpServletResponse response, String Info)
			throws ServletException, IOException {
		response.setCharacterEncoding("utf-8");
		response.getWriter().println(Info);
	}
}