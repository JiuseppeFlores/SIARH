var boxyLoading;
var loadingImg = "images/loading/loading03.gif";
htmlLoading = "<center>Cargando Datos... <br/><img src='"+loadingImg+"'></center>";

function verWin(url,width,height){
	boxyWindows = new Boxy("<iframe scrolling='no' frameborder='0' border='no' marginwidth='0' marginheight='0' width='"+width+"px' height='"+height+"px' scroll='no' src='"+url+"'>",
					{title:"Windows", modal: true,fixed:false,
					draggable:false,show:false,afterShow: function() {
						//setTimeout("updateMapDataDealer()",2000);
						//loadingSideBar();
   					},closeable:true,unloadOnHide:true});
	boxyWindows.show();
}

function boxyLoadingShow(){
	html = "<center>&nbsp;&nbsp;&nbsp;&nbsp; Se est&aacute procesando su acci&oacute;n &nbsp;&nbsp;&nbsp;&nbsp;<br /><img src=\""+loadingImg+"\"/></center><br/>";
	boxyLoading = new Boxy(html,
					{title:"Procesando ... &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;", modal: true,fixed:false,
					draggable:false,show:false,afterShow: function() {
						//
   					},closeable:false,unloadOnHide:true});
	boxyLoading.show();
}

function iframeBox(url,w,h){
	
    frameFormIte =  "<iframe src=\""+url+"\" frameborder=\"0\" ";
    frameFormIte += "width=\""+w+"\" height=\""+h+"\" marginheight=\"0\" marginwidth=\"0\" ";
    frameFormIte += " name=\"cateFormBoxy\" scrolling=\"auto\" id=\"cateFormBoxy\"></iframe>";
    
    return frameFormIte
}
