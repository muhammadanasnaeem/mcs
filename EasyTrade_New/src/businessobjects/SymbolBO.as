package businessobjects
{

	[Bindable]
	public class SymbolBO
	{
		public var MARKET_ID:Number;
		public var SYMBOL_ID:Number;
		public var INTERNAL_SYMBOL_ID:Number;
		public var COMPANY_ID:Number;
		public var BOARD_LOT:Number;
		public var UPPER_ORDER_VOLUME_LIMIT:Number;
		public var LOWER_ORDER_VOLUME_LIMIT:Number;
		public var TICK_SIZE:Number;
		public var UPPER_CIRCUIT_BREAKER_LIMIT:Number;
		public var LOWER_CIRCUIT_BREAKER_LIMIT:Number;
		public var UPPER_ALERT_LIMIT:Number;
		public var LOWER_ALERT_LIMIT:Number;
		public var UPPER_ORDER_VALUE_LIMIT:Number;
		public var LOWER_ORDER_VALUE_LIMIT:Number;
		public var FIFTY_TWO_WEEK_HIGH:Number;
		public var FIFTY_TWO_WEEK_LOW:Number;
		public var EPS:Number;
		public var PE_RATIO:Number;

		public var ISPOSTED:Boolean;
		public var SYMBOL:String;
		public var SYMBOL_TYPE:String;

		public var STATE:String;
		public var STATUS:String;
	}
}
