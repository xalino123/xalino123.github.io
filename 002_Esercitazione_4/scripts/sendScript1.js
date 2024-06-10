//risposta da servlet
function substituteInnerHTML4(ajax, theElement) {

    // designiamo la formattazione della zona dell'output
    theElement.class = "content";

    // verifica dello stato
    if (ajax.readyState === 2) {
        theElement.innerHTML = "Richiesta inviata...";
    }

    else if (ajax.readyState === 3) {
        theElement.innerHTML = "Ricezione della risposta...";
    }

    else if (ajax.readyState === 4) {

        // verifica della risposta da parte del server
        if (ajax.status === 200) {
            // operazione avvenuta con successo

            // per i campi di testo
            //theElement.value = ajax.responseText;

            // per il formato JSON
            //theElement.innerHTML = JSON.parse(ajax.responseText);

			document.cookie="fetchedMatrix="+ajax.responseText;
			
			
            //per i div
            //theElement.innerHTML = ajax.responseText;
        }

        else {
            // errore di caricamento
            theElement.innerHTML = "Impossibile effettuare l'operazione richiesta.<br />";
            theElement.innerHTML += "Errore riscontrato: " + ajax.statusText;
        }

    }

}

function prefetchIframe() {
    alert("Non supportiamo iframe");
}

function prefetchAJAX4(e,theElement, theXhr) {

    // impostazione della funzione di callback
    theXhr.onreadystatechange = function () {

        substituteInnerHTML4(theXhr, theElement);
    };

    console.log("Invio a Servlet :"+e);
    uri = "Servlet" + "?cogn=" + e;

    // impostazione richiesta asincrona in GET
    try {
        theXhr.open("get", uri, true);
    } catch (e) {
        // Exceptions are raised when trying to access cross-domain URIs
        alert(e);
    }

    // sostituzione dell'header "connection" (default = "keep alive")
    theXhr.setRequestHeader("connection", "close");

    // invio richiesta
    theXhr.send(null);

    /* POST
    theXhr.setRequestHeader("Content-type","application/x-www-form-urlencoded");
    theXhr.setRequestHeader("connection", "close");

    theXhr.send("p1=json&p2="+JSON.stringify(e));
     */
}

function scaricaTennisti(elem) {

        console.log("Ricevuto elemento : " + elem);

        //elemento su cui stampo(div)
        theElem = myGetElementById("risultato");

    // variabili di funzione xhr
    var xhr = myGetXmlHttpRequest();

    if (xhr) prefetchAJAX4(elem,theElem, xhr);

    else prefetchIframe();
}

