window.onload=function(){
    document.addEventListener("keydown", (event)=>{
        if(event.key=="+"){
            zoomIn();
        }
        if(event.key=="-"){
            zoomOut();
        }
    });
    function zoomIn(){
        var photos=document.getElementsByClassName("imagine-echipa");
        for(var i=0; i<photos.length; i++){
            var stilPoza=getComputedStyle(photos[i]);
            let photoWidth=parseInt(stilPoza.width), photoHeight=parseInt(stilPoza.height);
            let scaleFactor=(0.1*Math.random())+1;///sa avem si o chestie random
            photoWidth*=scaleFactor;
            photoHeight*=scaleFactor;
            photos[i].style.width=Math.floor(photoWidth)+"px";
            photos[i].style.height=Math.floor(photoHeight)+"px";
        }
    }
}