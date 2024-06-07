///A MERS IN SFARSIT
window.onload=function(){
    var userLoggedIn="Nimeni";
    if(localStorage.getItem("bgcolor")!=null){///deoarece a trimite formularul reincarca pagina, rezultatul parolei e in localStorage 
        var subsol=document.getElementsByTagName("footer");
        subsol[0].style.backgroundColor=localStorage.getItem("bgcolor");///asa ca luam de acolo si coloram in consecinta pagina
        var culoareForm=localStorage.getItem("bgcolor");
        const messageNode=document.createElement("p");///pe langa asta, cream si un element care sa anunte um a fost
        messageNode.setAttribute("id", "rezultat-parola");///ca sa stim de el cand bagam 
        var message;///si sa il puna acolo
        if(culoareForm=="red"){
            message=document.createTextNode("Parola nu e sigura");
        }
        else{
            message=document.createTextNode("Parola e sigura");
        }
        messageNode.appendChild(message);
        var x=document.getElementsByTagName("footer");
        x[0].appendChild(messageNode);///il stergem dupa cateva secunde, si setTimeout accepta si lambda 
        setTimeout(() =>{
            var mess=document.getElementById("rezultat-parola");
            mess.parentNode.removeChild(mess);
        }, 4000);
        if(userLoggedIn!="Nimeni"){
          user=document.createTextNode(userLoggedIn);
          var topRight=document.getElementsByTagName("nav");
          topRight.appendChild(user);
        }
    }
    
    document.getElementById("signup").addEventListener("click", validareParola);
    function validareParola(event){
        let email=document.getElementById("email-user").value;
        let parola=document.getElementById("parola-user").value;
        const regularEx=new RegExp(/[a-zA-Z]/, "i"); ///TODO baga un regex mai serios
        if(regularEx.test(parola)&& localStorage.getItem(email)==parola){
            localStorage.setItem("bgcolor", "green");
            alert("Login successful");
            userLoggedIn=email;
        }
        else if(regularEx.test(parola)){
            localStorage.setItem("bgcolor", "yellow");
            localStorage.setItem(email, parola);
        }
        else{
            localStorage.setItem("bgcolor", "red");
        }
    }
    document.getElementById("logout").addEventListener("click", logout);
    function logout(event){
        subsol[0].style.backgroundColor="black";
        userLoggedIn=null;
    }
}