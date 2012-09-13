fl.outputPanel.clear();

var path=fl.scriptURI;
var index=path.lastIndexOf("/");
path=path.substr(0,index);

publishFolder(path);

function publishFolder(path)
{
	path+="/";

	var fileList=FLfile.listFolder(path +"*.fla","files");
	publishFile(path,fileList);
	
	var directories=FLfile.listFolder(path,"directories");
	
	for(var i in directories)
	{
		var pathName=directories[i];
		if(pathName==".settings" || pathName==".svn")
			continue;
		
		publishFolder(path+pathName);
	}
}

function publishFile(path,fileList)
{
	for(var i in fileList)
	{
		var fileName=fileList[i];
		if(fileName=="skin.fla"|| fileName=="demo.fla")
			continue;
		
		var filePath=path+fileList[i];
		fl.trace(filePath);
		var doc=fl.openDocument(filePath);
		doc.publish();
		doc.save();
		doc.close();
	}
}




