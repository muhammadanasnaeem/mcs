package businessobjects
{
	import common.Type;

	public class SymbolOrderLimitBO
	{
		public var EXCHANGE_ID:Number=-1;
		public var MARKET_ID:Number=-1;
		public var SYMBOL_ID:Number=-1;
		public var INTERNAL_EXCHANGE_ID:Number=-1;
		public var INTERNAL_MARKET_ID:Number=-1;
		public var INTERNAL_SYMBOL_ID:Number=-1;

		public var LIMIT_TYPE:String;

		public var UPPER_LIMIT:Number=0;
		public var LOWER_LIMIT:Number=0;
		public var PERSISTENT:Boolean;
	}
}
