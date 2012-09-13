fl.outputPanel.clear();

var selItems = fl.getDocumentDOM().library.getSelectedItems(); 

for(var i=0;i<selItems.length;i++)
{ 
	var sb=selItems[i];
	var num;
	
	if(i<10)
		num="00"+i;
	else if(i<100)
		num="0"+i;
	else 
		num=i;
	
	sb.name="Face_"+num;
	sb.linkageClassName="chatExp.Face_"+num;
	fl.trace(sb.name); 
} 