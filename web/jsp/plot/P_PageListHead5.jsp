<!-- ��ҳ-->
	<%!
		String sPageNo ,
				sIsChange ;
		boolean isHasPrev ,
				isHasNext ;
		int iPageNo ,
			iSkip ,       // ��ǰ��
			iPageCount ,  // ÿҳ��¼��
			iTotalRecord , // �ܼ�¼��
			iTotalPage ;	// ��ҳ��   	
		
	%>
	<%
		
		// ÿҳ��¼��
		String sPageCountTemp = China.getParameter(request, "PageCount") ;
		
		if (sPageCountTemp.equals("")) {
			//iPageCount = 1 ;
			String s_currentPage = (String) session.getAttribute("S_CurrentPageCount" + sListName) ;
			try {
				iPageCount = Integer.parseInt(s_currentPage) ;
				//out.print("<br>1"+iPageCount);
			} catch (Exception e) {
				iPageCount = 10 ;
			}
		} else {
			iPageCount = Integer.parseInt(sPageCountTemp) ;	
			session.setAttribute("S_CurrentPageCount" + sListName, sPageCountTemp) ;
		}	
		// �ı�ÿҳ��¼��
		sIsChange = China.getParameter(request, "IsChange") ;
		
		if (sIsChange == "")     // �ļ�¼�󷵻�
			sIsChange = "N" ;
		
		// ��ǰҳ��
		sPageNo = China.getParameter(request, "PageNo") ;
		//out.print("a" + sPageNo + "b") ;
		if (sIsChange.equals("Y"))   // �ı�record count per page
			sPageNo = "1" ;
		
		if (sPageNo.equals("")) {
			sPageNo = (String) session.getAttribute("S_CurrentPageNo" + sListName) ;
			try {
				iPageNo = Integer.parseInt(sPageNo) ;
			} catch (Exception e) {
				iPageNo = 1 ;
				sPageNo = "1" ;
			}
		} else {
			session.setAttribute("S_CurrentPageNo" + sListName, sPageNo) ;
		}
		
		// ��һ�ν�list page ��ÿҳ��¼���ı�
		//out.print("a" + sIsChange + "a") ;
		
		if (sPageNo == null || sPageNo.equals("") || sIsChange.equals("Y"))
			sPageNo = "1" ;
		try {	
			iPageNo = Integer.parseInt(sPageNo) ;
		} catch (Exception e) {
			iPageNo = 1 ;
		}	
		
		//out.close() ;		
		iSkip = (iPageNo - 1) * iPageCount ;	
		
		// ������ҳ�����ܼ�¼����
		ConnDatabase.SDatabase amisDb = new ConnDatabase.SDatabase() ;
		ResultSet amisRs = amisDb.executeQuery(sCountStr) ;
		if (amisRs.next())
			iTotalRecord = amisRs.getInt("counts") ;
		else 
			iTotalRecord = 0 ;
		int iLost = iTotalRecord % iPageCount ;
		int iTotalPage  = iTotalRecord / iPageCount ;
		if (iLost > 0)
			iTotalPage++ ;
		//out.print(iTotalPage) ;
		// �õ���resultset
		session.setAttribute("S_CurrentSelectStr" + sListName, sAmisStr) ;
		amisRs = amisDb.executeQuery(sAmisStr) ;
		
	%>
<!-- ��ҳ2 -->