<%
 String StrSql="select type,codename,bak from CODE where child=0 order by type";
   ResultSet codeRS=null;
   String CodeName[]=new String[500];
   String CodeType[]=new String[500];
   String CodeBak[]=new String[500];
  codeRS=ViewBean.executeQuery(StrSql);
   int i=0;
   while (codeRS.next()){
     CodeType[i]=codeRS.getString("type");
     CodeName[i]=getbyte(codeRS.getString("codename"));
	 CodeBak[i]=getbyte(codeRS.getString("bak"));
	 i++;
   }
   codeRS.close();
 %>
