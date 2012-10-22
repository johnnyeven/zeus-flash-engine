package view.friendList
{
	import ui.core.Component;
	import com.zn.utils.ClassUtil;
	
	/**
	 *显示敌人列表
	 * @param lw
	 *
	 */
    public class EnemyListComponent extends Component
    {
		
		
        public function EnemyListComponent()
        {
            super(ClassUtil.getObject("view.friendList.EnemyListSkin"));
        }
    }
}