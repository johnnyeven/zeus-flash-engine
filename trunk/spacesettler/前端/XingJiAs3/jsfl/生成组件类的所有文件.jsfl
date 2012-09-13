fl.outputPanel.clear();

var fileURL="file:///D|/工作文档/星际/svn/前端/XingJiAs3/jsfl/createFile/";

var doc=fl.getDocumentDOM();
var lib = doc.library;
var item=lib.getSelectedItems()[0];

//获取类名称
var linkageClassName=item.linkageClassName;
var className=linkageClassName;
var index=className.lastIndexOf(".");
className=className.substr(index+1).replace("Skin","")+"Component";

createComponetClass(className,linkageClassName);
createComponetMediatorClass(className);
createShowMediatorCommandClass(className);

/*
生成组件类文件
*/
function createComponetClass(className,linkageClassName)
{
	var url =getPathURL()+"demoFile/DemoComponent.as";
	
	var code = FLfile.read(url);
	
	if(code!="")
	{
		code=replaceIndexStr(code,className,linkageClassName);	
		
		var varDefine=getChildrenNameDefine();
		code=code.replace("public var :;",varDefine);
		
		var fileName=fileURL+className+".as";	
		fl.trace(fileName);
		FLfile.write(fileName, code);
	}
	
}


function getChildrenNameDefine()
{
	var doc=fl.getDocumentDOM();
	doc.selectAll();

	var selection=doc.selection;
	var outStr="";
	
	for(var i=0;i<selection.length;i++)
	{
		var name=selection[i].name;
		if(name!="")
		{
			outStr+="public var "+name+":Component;\n";
		}
	}
	
	return outStr;
}

/*
生成组件Mediator类文件
*/
function createComponetMediatorClass(className)
{
	var url =getPathURL()+"demoFile/DemoMediator.as";
	
	var code = FLfile.read(url);
	if(code!="")
	{
		code=replaceIndexStr(code,className+"Mediator",className);	
	
		var fileName=fileURL+className+"Mediator.as";	
		fl.trace(fileName);
		FLfile.write(fileName, code);
	}
}

/*
生成组件ShowMediatorCommand类文件
*/
function createShowMediatorCommandClass(className)
{
	var url =getPathURL()+"demoFile/ShowDemoMediatorCommand.as";
	
	var code = FLfile.read(url);
	if(code!="")
	{
		var profileXML=fl.getDocumentDOM().exportPublishProfileString();
		profileXML=new XML(profileXML);
		var swfName=profileXML.PublishFormatProperties.flashFileName;
		
		code=replaceIndexStr(code,"Show"+className+"MediatorCommand",className+"Mediator",swfName);	
	
		var fileName=fileURL+"Show"+className+"MediatorCommand.as";	
		fl.trace(fileName);
		FLfile.write(fileName, code);
	}
}

/*
替换类中的参数
*/
function replaceIndexStr(str)
{
	var args = arguments;	
	var index=0;
	
	for(var i=1;i<args.length;i++)
	{
		str=str.replace(new RegExp("\\{"+index+"\\}", "g"),args[i]);
		index++;
	}
	return str;
}

/*
得到脚本目录URL
*/
function getPathURL()
{
	var path=fl.scriptURI;
	var index=path.lastIndexOf("/");
	path=path.substr(0,index+1);
	return path;
}