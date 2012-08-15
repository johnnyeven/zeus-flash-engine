///////////////////////////////////////////////////////////
//  CXYArray.as
//  Macromedia ActionScript Implementation of the Class CXYArray
//  Generated by Enterprise Architect
//  Created on:      15-����-2012 10:17:55
//  Original author: Administrator
///////////////////////////////////////////////////////////

package apollo.utils
{


	/**
	 * @author Administrator
	 * @version 1.0
	 * @created 15-����-2012 10:17:55
	 */

	public class CXYArray
	{
		private var _x: Number = 0;
		private var _y: Number = 0;

		/**
		 * 
		 * @param _x
		 */
		public function set x(_x:Number): void
		{
			this._x = _x;
		}

		public function get x(): Number
		{
			return this._x;
		}

		/**
		 * 
		 * @param _y
		 */
		public function set y(_y:Number): void
		{
			this._y = _y;
		}

		public function get y(): Number
		{
			return this._y;
		}

		/**
		 * 
		 * @param _y
		 * @param _x
		 */
		public function CXYArray(_x:Number = 0, _y:Number = 0)
		{
			this._x = _x;
			this._y = _y;
		}

		public function toString(): String
		{
			return this._x + "_" + this._y;
		}

	} //end CXYArray

}