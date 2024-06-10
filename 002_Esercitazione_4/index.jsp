<%@ page session="true" %>
<%@ page import="it.Login" %>
<%@ page import="beans.Tennista" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>User Area TEST</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="scripts/utils.js"></script>
    <script type="text/javascript" src="scripts/sendScript1.js"></script>
</head>

<%
	Tennista[] tabellone = (Tennista[])application.getAttribute("tabellone");

	if(tabellone==null){
		tabellone = new Tennista[128];

		for(int i=0;i<tabellone.length;i++) {
			tabellone[i] = new Tennista();
			tabellone[i].setCognome("cogn"+i);
			tabellone[i].setNumeroPartitePerse(i);
			tabellone[i].setNumeroPartiteVinte(i+10);
			tabellone[i].setRankingATP(2);
			tabellone[i].setTitoliVinti("gran premio, turismo 3");
		}
		application.setAttribute("tabellone", tabellone);
	}
	
	
	Tennista tennista = null;
	String cognome = request.getParameter("surname");
	if(cognome!=null){
		for(Tennista t : tabellone){
			if(t.getCognome().equals(cognome)){
				tennista=t;
				break;
			}
		}
	}else
		cognome="nullo";
	
%>

<script>

	function checkMat(element){
		var matrix = getCookie('fetchedMatrix');
		if(matrix!=""){
			var sottoTabellone = JSON.parse(matrix);
			for(var i=0; l=sottoTabellone.length;i<l;i++){
				if(sottoTabellone[i].cognome === element.value){
					myGetElementById("risultato").innerHTML = "Cognome: "+sottoTabellone[i].cognome+"<br/>Partite vinte: "+sottoTabellone[i].numeroPartiteVinte+"<br/>Partite perse: "+sottoTabellone[i].numeroPartitePerse;
					return;
				}
			}
		} else {
			myGetElementById("mainForm").submit();
			scaricaTennisti(element.value);
		}
	}
	
</script>

<body>
	<a href="<%=request.getContextPath()%>/login.jsp">Log in</a>
	</br></br></br>
	
<form id="mainForm" action="./index.jsp" method="post">
	<input type="text" id="surname" name="surname" size="30"  onchange="checkMat(myGetElementById('surname'))">
</form>

<div id="result">
<%
	if(tennista!=null){
		%>Cognome: <%=tennista.getCognome()%><br/>Partite vinte: <%=tennista.getNumeroPartiteVinte() %><br/>Partite perse: <%=tennista.getNumeroPartitePerse() %><%		
	}else{
		%>Il tennista non è iscritto!<%
	}
%>
</div>
<div id="risultato"></div>

</body>
</html>