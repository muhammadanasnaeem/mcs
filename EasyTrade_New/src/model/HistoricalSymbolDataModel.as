package model
{
	import businessobjects.HistoricalSymbolDataBO;
	
	import controller.WindowManager;
	
	import filters.Filters;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.managers.CursorManager;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import services.QWClient;
	
	public class HistoricalSymbolDataModel implements IModel
	{
		private var isDirty_:Boolean=true;
		
		public function HistoricalSymbolDataModel()
		{
			historicalSymbolDataLog_.filterFunction=Filters.historicalSymbolDataFilter;
		}
		
		public function execute():void
		{
			
			var wndoMangr:WindowManager = WindowManager.getInstance();
			var symExchange:String =  wndoMangr.viewManager.historicalSymbolDataInfo.txtExchange.text;
			var symMarket:String = wndoMangr.viewManager.historicalSymbolDataInfo.txtMarket.text;
			var symName:String = wndoMangr.viewManager.historicalSymbolDataInfo.txtSymbol.text;
			var sDate:Date = wndoMangr.viewManager.historicalSymbolDataInfo.startDate.selectedDate;
			var eDate:Date = wndoMangr.viewManager.historicalSymbolDataInfo.endDate.selectedDate;
			if(symExchange!= null && symMarket != null && symName != null && sDate != null && eDate != null && eDate >= sDate)
			{
				CursorManager.setBusyCursor();
				QWClient.getInstance().getSymbolHistoricalReport(symExchange,symMarket,symName,sDate,eDate);
			}
			else
			{
				wndoMangr.viewManager.historicalSymbolDataInfo.startDate.text = '';
				wndoMangr.viewManager.historicalSymbolDataInfo.endDate.text = '';
				Alert.show('Please Correct the Input','Error');
			}
		}
		
		public function onResult(event:ResultEvent):void
		{
//			CursorManager.removeBusyCursor();
//			var hisSymbData:HistoricalSymbolDataBO = new HistoricalSymbolDataBO();
			Alert.show(''+event.toString());
			Alert.show('Success','Success Message');
			
		}
		
		public function onFault(event:FaultEvent):void
		{
			CursorManager.removeBusyCursor();
			Alert.show('Unable to retrive record','Information');
		}
		
		public function set isDirty(value:Boolean):void
		{
			isDirty_=value;
		}
		
		public function get isDirty():Boolean
		{
			return isDirty_;
		}
		
		private var historicalSymbolDataLog_:ArrayCollection=new ArrayCollection(); // EventLogBO
		
		[Bindable]
		public function get historicalSymbolDataLog():ArrayCollection
		{
			return historicalSymbolDataLog_;
		}
		
		public function set historicalSymbolDataLog(value:ArrayCollection):void
		{
			historicalSymbolDataLog_=value;
		}
	}
}