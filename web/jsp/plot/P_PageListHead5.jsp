<!-- 翻页-->
	<%!
		String sPageNo ,
				sIsChange ;
		boolean isHasPrev ,
				isHasNext ;
		int iPageNo ,
			iSkip ,       // 向前数
			iPageCount ,  // 每页记录数
			iTotalRecord , // 总记录数
			iTotalPage ;	// 总页数   	
		
	%>
	<%
		
		// 每页记录数
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
		// 改变每页记录数
		sIsChange = China.getParameter(request, "IsChange") ;
		
		if (sIsChange == "")     // 改记录后返回
			sIsChange = "N" ;
		
		// 当前页号
		sPageNo = China.getParameter(request, "PageNo") ;
		//out.print("a" + sPageNo + "b") ;
		if (sIsChange.equals("Y"))   // 改变record count per page
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
		
		// 第一次进list page 或　每页记录数改变
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
		
		// 计算总页数和总计录数　
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
		// 得到　resultset
		session.setAttribute("S_CurrentSelectStr" + sListName, sAmisStr) ;
		amisRs = amisDb.executeQuery(sAmisStr) ;
		
	%>
<!-- 翻页2 -->