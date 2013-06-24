<%
String user=(String)session.getAttribute("loginid");
String Cortrol="";
String PubPra="";
String section="";
 
   String SqlParam="select Cortrol,state,section from ManModuleCortrol ";//where SellerId='"+user+"' and ManModule='"+param+"'";

   ResultSet RsPopedom=ViewBean.executeQuery(SqlParam);
   if (RsPopedom.next()){
     Cortrol=RsPopedom.getString("Cortrol");
	 PubPra=RsPopedom.getString("state");
	 section=RsPopedom.getString("section");
   }
   RsPopedom.close();
 
if (section==null)section="";
	StringTokenizer st22 = new StringTokenizer(section,"/") ;
	int count22 = st22.countTokens() ;
	String[] SectionStr = new String[count22] ;
	int j22 = 0 ;
   while (st22.hasMoreElements()) {
		SectionStr[j22] = (String)st22.nextElement() ;
		j22 ++ ;
	}
		
		String Section = "" ;
		if (SectionStr.length > 1)  {
				for (int i2 = 0 ; i2 < SectionStr.length ; i2 ++ ) {
					if (i2 == 0) {
						Section += "'" + SectionStr[i2].trim() + "" ;
					}	
					else {
						Section += "," + SectionStr[i2].trim() + "" ;
					}		
				}
				if (!Section.equals(""))Section += "'" ;
			} else {
				Section = "'" + section + "'" ;
			}
session.setAttribute("popedomStr",Cortrol);
session.setAttribute("Attribute",PubPra);
session.setAttribute("Section",Section);
 %>