fl.outputPanel.clear();

var doc=fl.getDocumentDOM();
doc.selectAll();
doc.breakApart();

var rect=doc.getSelectionRect();

var lib = doc.library;
var item=lib.getSelectedItems()[0];

var sgLeft=item.scalingGridRect.left;
var sgRight=item.scalingGridRect.right;
var sgTop=item.scalingGridRect.top;
var sgBottom=item.scalingGridRect.bottom;

//left top 
copyItem(doc,rect.left,rect.top,sgLeft,sgTop);
//right top
copyItem(doc,sgRight,rect.top,rect.right,sgTop);

//left bottom 
copyItem(doc,rect.left,sgBottom,sgLeft,rect.bottom);

//left middle
copyItem(doc,rect.left,sgTop,sgLeft,sgBottom);
//top middle
copyItem(doc,sgLeft,rect.top,sgRight,sgTop);
//right middle
copyItem(doc,sgRight,sgTop,rect.right,sgBottom);
//bottom middle 
copyItem(doc,sgLeft,sgBottom,sgRight,rect.bottom);

//right bottom
copyItem(doc,sgRight,sgBottom,rect.right,rect.bottom);

function copyItem(doc,cLeft,cTop,cRight,cBottom)
{
	fl.trace(cLeft+','+cTop+','+cRight+','+cBottom);
	doc.setSelectionRect({left:cLeft, top:cTop, right:cRight, bottom:cBottom}, true);
	doc.clipCut();
	doc.getTimeline().addNewLayer();
	doc.clipPaste(true);
	doc.getTimeline().setLayerProperty('locked', true);
}


