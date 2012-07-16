package model
{
	import businessobjects.OrderBO;
	import businessobjects.SymbolBO;

	import common.Messages;

	import controller.ModelManager;
	import controller.WindowManager;

	import filters.Filters;

	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.controls.DataGrid;
	import mx.managers.CursorManager;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	import services.QWClient;

	public class LastDayRemainingOrdersModel implements IModel
	{
		public var isInit:Boolean=false;
		private var isDirty_:Boolean=true;

		public function get isDirty():Boolean
		{
			return isDirty_;
		}

		public function set isDirty(value:Boolean):void
		{
			isDirty_=value;
		}
		[Bindable]
		private var remainingOrders_:ArrayCollection=new ArrayCollection();

		[Bindable]
		public function get remainingOrders():ArrayCollection
		{
			return remainingOrders_;
		}

		public function set remainingOrders(value:ArrayCollection):void
		{
			remainingOrders_=value;
		}

		public function LastDayRemainingOrdersModel()
		{
			remainingOrders_.filterFunction=Filters.lastDayremainingOrdersFilter;
		}

		public function execute():void
		{
			QWClient.getInstance().getLastDayRemainingOrders(ModelManager.getInstance().userID);
		}

		public function onResult(event:ResultEvent):void
		{
			var adgro:DataGrid=WindowManager.getInstance().viewManager.lastDayRemainingOrders.adgRemainingOrders;
			remainingOrders_.removeAll();



			var lastDayRemainingOrdersMap:ArrayCollection=event.result.map;

			for (var p:String in lastDayRemainingOrdersMap)
			{
				var orderList:ArrayCollection=lastDayRemainingOrdersMap[p].value.list;
				var i:int=0;
				for (i; i < orderList.length; ++i)
				{
					var orderBO:OrderBO=new OrderBO();
					orderBO.ORDER_NO=orderList[i].ORDER_NO;
					orderBO.EXCHANGE_ID=orderList[i].EXCHANGE_ID;
					orderBO.MARKET_ID=orderList[i].MARKET_ID;
					orderBO.CLIENT_ID=orderList[i].CLIENT_ID;
					orderBO.REF_NO=orderList[i].REF_NO;
					//orderBO.SYMBOL = orderList[i].SYMBOL;
					orderBO.SYMBOL_ID=orderList[i].SYMBOL_ID;
					//orderBO.INTERNAL_SYMBOL_ID = orderList[i].INTERNAL_SYMBOL_ID;
					orderBO.DISCLOSED_VOLUME=orderList[i].DISCLOSED_VOLUME;
					orderBO.PRICE=orderList[i].PRICE;
					orderBO.SIDE=orderList[i].SIDE;
					orderBO.ENTRY_DATETIME=orderList[i].ENTRY_DATETIME;
					orderBO.TRIGGER_PRICE=orderList[i].TRIGGER_PRICE;
					orderBO.VOLUME=orderList[i].VOLUME;
					orderBO.PUBLIC_ORDER_STATE=orderList[i].PUBLIC_ORDER_STATE;
					orderBO.PRIVATE_ORDER_STATE=orderList[i].PRIVATE_ORDER_STATE;
					var symbolBO:SymbolBO=ModelManager.getInstance().exchangeModel.getSymbolDetail(orderBO.EXCHANGE_ID, orderBO.MARKET_ID, orderBO.SYMBOL_ID) as SymbolBO;
					orderBO.SYMBOL=symbolBO.SYMBOL;
					orderBO.INTERNAL_SYMBOL_ID=symbolBO.INTERNAL_SYMBOL_ID;
					orderBO.INTERNAL_EXCHANGE_ID=ModelManager.getInstance().exchangeModel.getInternalExchangeID(orderBO.EXCHANGE_ID);
					orderBO.INTERNAL_MARKET_ID=ModelManager.getInstance().exchangeModel.getInternalMarketId(orderBO.EXCHANGE_ID, orderBO.MARKET_ID);
					orderBO.USER_ID=orderList[i].USER_ID;
					orderBO.BROKER_ID=orderList[i].BROKER_ID;
					orderBO.CLIENT_CODE=orderList[i].CLIENT_CODE;
					//orderBO.CLIENT_CODE = "8888";
					orderBO.TYPE="limit";
					orderBO.TIF=orderList[i].TIF;
					remainingOrders_.addItem(orderBO);
				}
			}
			isDirty=false;
			CursorManager.removeBusyCursor();

			if (isInit)
			{
				isInit=false;
				var windowManager:WindowManager=WindowManager.getInstance()
				windowManager.initMarketWatchWindow();
				windowManager.canvas.windowManager.add(windowManager.marketWatchWindow);
				windowManager.marketWatchWindow.maximize();
			}
		}

		public function onFault(event:FaultEvent):void
		{
			isDirty=true;
			Alert.show(event.fault.faultDetail, Messages.TITLE_ERROR);
			CursorManager.removeBusyCursor();
		}

		public function getOrderBOByOrderNumber(orderNum:Number):OrderBO
		{
			var i:int=0;
			for (; i < remainingOrders.length; ++i)
			{
				var orderBO:OrderBO=remainingOrders[i] as OrderBO;
				if (orderBO.ORDER_NO == orderNum)
				{
					return orderBO;
				}
			}
			return null;
		}
	}
}
