///////////////////////////////////////////////////////////
//  CLoaderEx.as
//  Macromedia ActionScript Implementation of the Class CLoaderEx
//  Generated by Enterprise Architect
//  Created on:      15-����-2012 13:46:31
//  Original author: Administrator
///////////////////////////////////////////////////////////

package utils.loader
{
	import flash.display.Loader;

	/**
	 * @author Administrator
	 * @version 1.0
	 * @created 15-����-2012 13:46:31
	 */

	public class CLoaderEx extends Loader
	{
		private var _data: * ;

		public function CLoaderEx()
		{
			super();
		}

		/**
		 * 
		 * @param _data
		 */
		public function set data(_data:*): void
		{
			this._data = _data;
		}

		public function get data(): *
		{
			return this._data;
		}

	} //end CLoaderEx

}