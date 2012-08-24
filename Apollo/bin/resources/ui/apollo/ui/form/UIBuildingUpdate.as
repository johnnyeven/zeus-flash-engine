package apollo.ui.form{

import org.aswing.*;
import org.aswing.border.*;
import org.aswing.geom.*;
import org.aswing.colorchooser.*;
import org.aswing.ext.*;

/**
 * UIBuildingUpdate
 */
public class UIBuildingUpdate extends JPanel
{
	
	//members define
	private var lblTitle:JLabel;
	private var label4:JLabel;
	private var progress:JProgressBar;
	private var btnSubmit:JButton;
	
	/**
	 * UIBuildingUpdate Constructor
	 */
	public function UIBuildingUpdate()
	{
		//component creation
		setSize(new IntDimension(594, 428));
		var layout0:EmptyLayout = new EmptyLayout();
		setLayout(layout0);
		
		lblTitle = new JLabel();
		lblTitle.setFont(new ASFont("微软雅黑", 24));
		lblTitle.setForeground(new ASColor(0xdaf4f5, 1));
		lblTitle.setLocation(new IntPoint(180, 5));
		lblTitle.setSize(new IntDimension(407, 36));
		lblTitle.setBorder(null);
		lblTitle.setText("名字");
		lblTitle.setSelectable(false);
		lblTitle.setHorizontalAlignment(AsWingConstants.CENTER);
		
		label4 = new JLabel();
		label4.setForeground(new ASColor(0x3399ff, 1));
		label4.setLocation(new IntPoint(180, 40));
		label4.setSize(new IntDimension(62, 22));
		label4.setText("所需资源");
		
		progress = new JProgressBar();
		progress.setLocation(new IntPoint(50, 300));
		progress.setSize(new IntDimension(495, 16));
		progress.setValue(0);
		progress.setMinimum(0);
		progress.setMaximum(100);
		
		btnSubmit = new JButton();
		btnSubmit.setLocation(new IntPoint(450, 350));
		btnSubmit.setSize(new IntDimension(100, 31));
		btnSubmit.setText("升级");
		
		//component layoution
		append(lblTitle);
		append(label4);
		append(progress);
		append(btnSubmit);
		
	}
	
	//_________getters_________
	
	public function getLblTitle():JLabel{
		return lblTitle;
	}
	
	
	public function getProgress():JProgressBar{
		return progress;
	}
	
	public function getBtnSubmit():JButton{
		return btnSubmit;
	}
	
	
}
}
