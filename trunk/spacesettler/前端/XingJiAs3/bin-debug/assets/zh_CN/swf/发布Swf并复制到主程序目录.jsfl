fl.outputPanel.clear();

var doc=fl.getDocumentDOM();
doc.publish();

//copy swf
publishCopy(".swf","bin-debug/zh_CN/");

//copy swc
//publishCopy(".swc","libs/");


function publishCopy(postfix,path)
{
	var orgFileURL=doc.pathURI;
	orgFileURL=orgFileURL.replace(".fla",postfix);

	var name=doc.name;
	
	name=name.replace(".fla",postfix);
	var targetFileURL="file:///E|/星际移民/前端/XingJiAs3/"+path+name;	
	//var targetFileURL="file:///MAC LION/Users/niko/Documents/Adobe Flash Builder 4.6/ProjectTempletAs3/"+path+name+postfix;
	FLfile.remove(targetFileURL);
	
	FLfile.copy(orgFileURL, targetFileURL);
	fl.trace(orgFileURL);
	fl.trace(targetFileURL);
	
	if(postfix==".swc")
		FLfile.remove(orgFileURL);
}

