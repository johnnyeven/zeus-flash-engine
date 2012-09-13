fl.outputPanel.clear();

var path=fl.scriptURI;
var index=path.lastIndexOf("/");
path=path.substr(0,index);
publishFolder(path);

function publishFolder(path)
{
	path+="/";

	var fileList=FLfile.listFolder(path +"*.swf","files");
	publishFile(path,fileList);	
}

function publishFile(path,fileList)
{
	var str="";
	
	for(var i in fileList)
	{
		var fileName=fileList[i];
		var filePath=path+fileList[i];
		
		str+='<SWFLoader name="'+fileName+'" url="'+fileName+'" domain="own" version="1" noCache="true"/>\n';		
	}
	
	fl.trace(str);
}