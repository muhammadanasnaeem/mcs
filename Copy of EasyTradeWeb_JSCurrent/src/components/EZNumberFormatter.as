package components
{
	import mx.formatters.NumberFormatter;

	public class EZNumberFormatter extends NumberFormatter
	{
		private var usePercentSign_:Boolean=false;

		public function get usePercentSign():Boolean
		{
			return usePercentSign_;
		}

		public function set usePercentSign(value:Boolean):void
		{
			usePercentSign_=value;
		}

		public function EZNumberFormatter()
		{
			thousandsSeparatorTo=",";
			thousandsSeparatorFrom=",";

			decimalSeparatorTo=".";   
			decimalSeparatorFrom=".";
//			precision=4;
			useThousandsSeparator=true;
		}

		public override function format(value:Object):String
		{
			var res:String=super.format(value);
			if (usePercentSign)
			{
				res+="%";
			}
			return res;
		}
	}
}
