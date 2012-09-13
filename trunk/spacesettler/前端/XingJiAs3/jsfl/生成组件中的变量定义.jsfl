fl.outputPanel.clear();

var doc=fl.getDocumentDOM();
doc.selectAll();

var selection=doc.selection;

for(var i=0;i<selection.length;i++)
{
	var name=selection[i].name;
	if(name!="")
	{
		var outStr="public var "+name+":UIComponent;";
		fl.trace(outStr);
	}
}