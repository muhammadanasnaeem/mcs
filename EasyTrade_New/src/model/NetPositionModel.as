package model
{
	import businessobjects.SymbolStatBO;
	import businessobjects.SymbolSummary;
	import businessobjects.SymbolSummaryBO;

	import common.Messages;

	import components.ComboBoxItem;

	import controller.ModelManager;
	import controller.WindowManager;

	import filters.Filters;

	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.collections.Sort;
	import mx.controls.Alert;
	import mx.managers.CursorManager;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	import services.QWClient;

	public class NetPositionModel implements IModel
	{
		/////////////////////////////////////////////////////////
		private var isDirty_:Boolean=true;

		public function get isDirty():Boolean
		{
			return isDirty_;
		}

		public function set isDirty(value:Boolean):void
		{
			isDirty_=value;
		}
		/////////////////////////////////////////////////////////

		private var symbols_:ArrayCollection=new ArrayCollection(); // of SymbolSummaryBOs
		[Bindable]
		public function get symbols():ArrayCollection
		{
			return symbols_;
		}

		public function set symbols(value:ArrayCollection):void
		{
			symbols_=value;
		}
		/////////////////////////////////////////////////////////

		public var exchangeID:Number;
		public var marketID:Number;

		public var totalBuyVolume:Number=0;
		public var totalSellVolume:Number=0;
		public var totalGrossVolume:Number=0;
		public var totalNetVolume:Number=0;
		public var totalBuyValue:Number=0;
		public var totalSellValue:Number=0;
		public var totalGrossValue:Number=0;
		public var totalNetValue:Number=0;

		/////////////////////////////////////////////////////////
		public function NetPositionModel()
		{

		}

		/////////////////////////////////////////////////////////

		public function execute():void
		{
			CursorManager.setBusyCursor();
			QWClient.getInstance().getMarketSummary(WindowManager.getInstance().viewManager.marketSummary.internalExchangeID, WindowManager.getInstance().viewManager.marketSummary.internalMarketID);
		}

		/////////////////////////////////////////////////////////

		public function onResult(event:ResultEvent):void
		{
			symbols_.removeAll();
			totalBuyVolume=0;
			totalSellVolume=0;
			totalGrossVolume=0;
			totalNetVolume=0;

			totalBuyValue=0;
			totalSellValue=0;
			totalGrossValue=0;
			totalNetValue=0;

			var internalExchangeID:Number=event.result.exchangeID.internalID_;
			var internalMarketID:Number=event.result.marketID.internalID_;
//			if (event.result.length)
//			{
//				for each (var obj:Object in event.result.stats)
//				{
//					symbols.addItem( fillNetPosition( obj, new NetPositionBO(),internalExchangeID,internalMarketID ) );
//				}
//			}
//			else
//			{
//				symbols.addItem( fillNetPosition( event.result.stats, new NetPositionBO() ) );
//			}

//			var sort:Sort = new Sort();
//			sort.fields = [new SortField(dataFeild,true, decending), new SortField("SYMBOL_CODE",true, decending)];
//			
//			symbols.sort = sort;
//			// Apply the sort to the collection.
//			symbols.refresh();

			CursorManager.removeBusyCursor();
		}

		/////////////////////////////////////////////////////////

		public function onFault(event:FaultEvent):void
		{
			isDirty=true;
			Alert.show(event.fault.faultDetail, Messages.TITLE_ERROR);
			CursorManager.removeBusyCursor();
		}
		/////////////////////////////////////////////////////////


//		public function fillNetPosition(obj:Object, symbol:NetPositionBO,internalExchangeID:Number,internalMarketID:Number):NetPositionBO
//		{
//			symbol.SYMBOL = ModelManager.getInstance().exchangeModel.getSymbolCode(internalExchangeID,internalMarketID,obj.internalSymbolID);
//			symbol.symbolID = obj.symbolID;
//			symbol.HIGH = obj.high;
//			symbol.TRADES = obj.totalNoOfTrades;
//			symbol.LOW = obj.low;
//			//symbol.STATE = obj.STATE;
//			symbol.OPEN = obj.open;
//			//symbol.LAST = obj.LAST;
//			symbol.CHANGE = obj.netChange;
//			
//			//symbol.SECTOR = obj.SECTOR;
//			//symbol.LAST_VOLUME = obj.LAST_VOLUME;
//			symbol.CLOSE = obj.close;
//			symbol.LAST_DAY_CLOSE_PRICE = obj.lastDayClosePrice;
//			symbol.TOTAL_SIZE_TRADED = obj.totalSizeTraded;
//			symbol.AVERAGE = obj.averagePrice;
//			//symbol.SELL = obj.SELL;
//			
//			symbol.VALUE = obj.totalSizeTraded * obj.averagePrice; 
//			
//			totalBuyVolume = totalBuyVolume  + new Number(obj.totalNoOfTrades);
//			totalNetVolume = totalNetVolume + new Number(obj.totalNoOfTrades);			
//			totalSellVolume = totalSellVolume + new Number(obj.totalSizeTraded);
//			totalGrossVolume = totalGrossVolume  + new Number(symbol.VALUE);
//			
//			totalBuyValue = totalBuyValue  + new Number(obj.totalNoOfTrades);
//			totalNetValue = totalNetValue + new Number(obj.totalNoOfTrades);			
//			totalSellValue = totalSellValue + new Number(obj.totalSizeTraded);
//			totalGrossValue = totalGrossValue  + new Number(symbol.VALUE);
//		}
	}
}
