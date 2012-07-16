package businessobjects
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class MarketScheduleBO
	{
		public var INTERNAL_EXCHANGE_ID:Number;
		public var EXCHANGE_ID:Number;
		public var INTERNAL_MARKET_ID:Number;
		public var MARKET_ID:Number;
		public var CODE:String="";
		public var SCHEDULE:ArrayCollection=new ArrayCollection(); // of MarketStateInfo
	}
}
