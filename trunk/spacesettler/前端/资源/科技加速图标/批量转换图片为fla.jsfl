fl.outputPanel.clear();

var path=fl.scriptURI;
var index=path.lastIndexOf("/");
path=path.substr(0,index);
publishFolder(path);

function publishFolder(path)
{
	path+="/";

	var fileList=FLfile.listFolder(path +"*.png","files");
	publishFile(path,fileList);	
}

function publishFile(path,fileList)
{
	for(var i in fileList)
	{
		var fileName=fileList[i];
				
		var filePath=path+fileList[i];
		fl.trace(fileName);
		fl.trace(filePath);
		var doc=fl.createDocument();
		doc.importFile(filePath);
		//var rect=doc.getSelectionRect();
//		fl.trace(rect.right+","+rect.bottom);
		//doc.width=rect.right;
//		doc.height=rect.bottom;
//		fl.trace(doc.width+","+doc.height);

		var profileXML=fl.getDocumentDOM().exportPublishProfileString();
		profileXML=profileXML.replace("<html>1</html>","<html>0</html>");
		fl.getDocumentDOM().importPublishProfileString(profileXML);

		filePath=filePath.replace(fileName,"");
		fileName=fileName.replace(".png","")+".fla";
		filePath+=fileName;
		fl.trace(fileName+", "+filePath);
		fl.saveDocument(doc,filePath);
		doc.publish();
		doc.close();
	}
}