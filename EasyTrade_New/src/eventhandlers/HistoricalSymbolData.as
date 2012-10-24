import components.ComboBoxItem;

import controller.ModelManager;
import controller.WindowManager;

import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.net.FileReference;

import mx.events.FlexEvent;


public var fr:FileReference = new FileReference();

[Bindable]
public var modelManager:ModelManager=ModelManager.getInstance();



var wndoMangr:WindowManager = WindowManager.getInstance();

protected function txtSymbol_keyDownHandler(event:KeyboardEvent):void
{
	if (event.keyCode == 9 || event.keyCode == 13)
	{
		//		txtSymbol.text=txtSymbol.text.toUpperCase();
		internalSymbolID=ModelManager.getInstance().exchangeModel.getInternalSymbolIDByCode(internalExchangeID, internalMarketID, txtSymbol.text);
		if(wndoMangr.viewManager.historicalSymbolDataInfo.txtExchange.text)
		{
			modelManager.historicalSymbolDataModel.execute();
		}
		
//		applyFilter();
	}
}



protected function btnRefresh_clickHandler(event:MouseEvent):void
{
	modelManager.updateSymbolHistoryReport();
}

protected function group1_initializeHandler(event:FlexEvent):void
{
	for (var i:int=0; i < ModelManager.getInstance().exchangeModel.exchanges.length; ++i)
	{
		var obj:Object=ModelManager.getInstance().exchangeModel.exchanges.getItemAt(i);
		var cbi:ComboBoxItem=new ComboBoxItem(obj.INTERNAL_EXCHANGE_ID.toString(), obj.EXCHANGE_CODE);
		exchangeList.addItem(cbi);
	}
	internalExchangeID=-1;
	internalMarketID=-1;
	internalSymbolID=-1;
	symbolID=-1;
	
	// added on 16/3/2011
//	tradersList=modelManager.userProfileModel.getTraders("EventLog");
}

public function applyFilter():void
{
//	modelManager.remainingOrdersModel.remainingOrders.refresh();
//	modelManager.updateEventLog();
}