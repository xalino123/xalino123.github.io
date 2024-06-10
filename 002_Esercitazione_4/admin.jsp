<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true"%>
<%@ page import="it.Servlet"%>
<%@ page import="java.util.*"%>
<%@ page import="beans.Utente" %>
<%@ page import="java.time.Instant" %>
<%@ page import="beans.Paper" %>

<html>
<head>
    <title>Admin Page</title>

</head>

<%
	HashSet<Paper> papers = (HashSet<Paper>)application.getAttribute("papers");
	if(papers==null)
		papers = new HashSet<Paper>();
	
	String removeAccess = request.getParameter("removeAccess");
	if(removeAccess!=null){
		//System.out.println("Accesso da rimuovere: "+removeAccess);
		for(Paper paper : papers){
			if(paper.getFileName().equals(removeAccess)){
				//System.out.println("Accesso rimosso a file: "+removeAccess);
				paper.setAvailable(true);
				paper.setIdSessionUser("");
				papers.add(paper);
				break;
			}
		}
	}
	
	application.setAttribute("papers", papers);
%>

<body>
<h2>Pagina di amministrazione</h2>
<a href="<%=request.getContextPath()%>/admin.jsp?username=admin&password=admin">Reload</a>

<%//Eseguo nuovamente il controllo di username e pass
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    if (username.equals("admin") && password.equals("admin")) {
    	%> <h2>Lista pagine aperte in scrittura:</h2> 
    	<form action="<%=request.getContextPath()%>/admin.jsp?username=admin&password=admin" method="post"><%
    	for(Paper paper : papers){
    		if(!paper.isAvailable()){%>
    			- Nome file: <%=paper.getFileName() %> <button type="submit" name="removeAccess" value="<%=paper.getFileName() %>">Rimuovi accesso</button> </br>
    		<%}
    	}%>
    	</form>
    <%}
%>


</body>
</html>
