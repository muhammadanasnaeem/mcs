//import common.Messages;

import businessobjects.MarketWatchBO;

import common.Constants;
import common.Messages;

import controller.EasyTradeApp;
import controller.ModelManager;
import controller.ViewManager;
import controller.WindowManager;

import flash.events.MouseEvent;

import flexlib.mdi.containers.MDIWindow;
import flexlib.mdi.containers.MDIWindowState;
import flexlib.mdi.events.MDIWindowEvent;

import mx.collections.ArrayCollection;
import mx.controls.Alert;
import mx.controls.Menu;
import mx.controls.menuClasses.MenuBarItem;
import mx.events.MenuEvent;
import mx.printing.FlexPrintJob;
import mx.resources.IResourceManager;
import mx.resources.ResourceManager;
import mx.rpc.AsyncToken;

import services.QWClient;

public function menubarMain_itemClickHandler(event:MenuEvent):void
{
	if (event.menu == menubarMain.menus[0]) // File
	{
		menuItemFile_itemClickHandler(event);
	}
	else if (event.menu == menubarMain.menus[1]) // Order
	{
		menuItemOrder_itemClickHandler(event);
	}
	else if (event.menu == menubarMain.menus[2]) // Watch
	{
		menuItemWatch_itemClickHandler(event);
	}
	else if (event.menu == menubarMain.menus[3]) // Reports
	{
		menuItemReports_itemClickHandler(event);
	}
	else if (event.menu == menubarMain.menus[4]) // Control
	{
		menuItemControl_itemClickHandler(event);
	}
	else if (event.menu == menubarMain.menus[6]) // Settings
	{
		menuItemSetting_itemClickHandler(event);
	}
	//added on 21/12/2010
	else if (event.item.@id == "liveSym") // Charts event.item.@id == "liveSym"  historicalSymbolDataCharts
	{
		menuitemLiveSymbolChart_itemClickHandler(event);
	}
	else if (event.item.@id == "historicalSymbolDataCharts") // Charts event.item.@id == "liveSym"  historicalSymbolDataCharts
	{
		menuitemhistoricalSymbolDataChart_itemClickHandler(event);
	}
	//added on 17/1/2011
	else if (event.item.@id == "about") // About
	{
		menuitemAbout_itemClickHandler(event);
	}
	else if (event.item.@id == "changeLang") // About
	{
		menuitemChange_itemClickHandler(event);
	}
	else if (event.item.@submenu_id == "PrintMessages") // File -> Printing -> PrintMessages
	{
		menuItemFilePrinting_itemClickHandler(event);
	}
}

////////////////////////////////////File Menu Handlers/////////////////////////////////////////

public function menuItemFile_itemClickHandler(event:MenuEvent):void
{
	switch (event.index)
	{
		case 0:
			menuitemLogoff_itemClickHandler(event);
			break;
		case 11:
			//exit();
			break;
	}
}

/*
* Print menu item handler
*/
public function menuItemFilePrinting_itemClickHandler(event:MenuEvent):void
{
	var printJob:FlexPrintJob=new FlexPrintJob();
	if (printJob.start())
	{
		printJob.addObject(WindowManager.getInstance().viewManager.liveMessages.txaMessages);
//				printJob.send();
	}
}

/*
* Logoff menu item handler
*/
public function menuitemLogoff_itemClickHandler(event:MenuEvent):void
{
	var theApp:EasyTradeApp=EasyTradeApp.getInstance();
	var modelManager:ModelManager=ModelManager.getInstance();
	var viewManager:ViewManager=ViewManager.getInstance();
	var windowManager:WindowManager=WindowManager.getInstance();
	theApp.logOffUser();
}

////////////////////////////////////Order Menu Handlers/////////////////////////////////////////

public function menuItemOrder_itemClickHandler(event:MenuEvent):void
{
	switch (event.index)
	{
		case 0: // Sell Order
			menuitemSellOrder_itemClickHandler(event);
			break;
		case 1: //  Buy Order
			menuitemBuyOrder_itemClickHandler(event);
			break;
		case 2: // Change Order
			menuitemChangeOrder_itemClickHandler(event);
			break;
		case 3: // Cancel Order
			menuitemCancelOrder_itemClickHandler(event);
			break;
		case 4: // Yield Calculator
			menuitemYieldCalculator_itemClickHandler(event);
			break;
		case 5: // Quick Orders Window
			menuitemQuickOrder_itemClickHandler(event);
			break;
	}
}

/*
* Buy Order item handler
*/
public function menuitemQuickOrder_itemClickHandler(event:MenuEvent):void
{
	var theApp:EasyTradeApp=EasyTradeApp.getInstance();
	var modelManager:ModelManager=ModelManager.getInstance();
	var viewManager:ViewManager=ViewManager.getInstance();
	var windowManager:WindowManager=WindowManager.getInstance();

	if (windowManager.quickOrdersWindow && windowManager.canvas.windowManager.container.contains(windowManager.quickOrdersWindow))
	{
		windowManager.canvas.windowManager.bringToFront(windowManager.quickOrdersWindow);
		return;
	}
	windowManager.initQuickOrderWindow();
	windowManager.canvas.windowManager.add(windowManager.quickOrdersWindow);
}

/*
* Buy Order item handler
*/
public function menuitemBuyOrder_itemClickHandler(event:MenuEvent):void
{
	var theApp:EasyTradeApp=EasyTradeApp.getInstance();
	var modelManager:ModelManager=ModelManager.getInstance();
	var viewManager:ViewManager=ViewManager.getInstance();
	var windowManager:WindowManager=WindowManager.getInstance();

	if (windowManager.buyOrderWindow && windowManager.canvas.windowManager.container.contains(windowManager.buyOrderWindow))
	{
		// added on 11/1/2010
		windowManager.viewManager.buyOrder.clearForm();
		windowManager.canvas.windowManager.bringToFront(windowManager.buyOrderWindow);
			//return;
	}
	else
	{
		windowManager.initBuyOrderWindow();
		// added on 11/1/2010
		windowManager.viewManager.buyOrder.clearForm();
		windowManager.canvas.windowManager.add(windowManager.buyOrderWindow);
	}
	if (windowManager.marketWatchWindow && windowManager.canvas.windowManager.container.contains(windowManager.marketWatchWindow) && windowManager.viewManager.marketWatch.adgMarketWatch.selectedItem && windowManager.viewManager.marketWatch.adgMarketWatch.selectedIndex > -1)
	{
		var marketWatchView:ArrayCollection=modelManager.marketWatchModel.marketWatch[windowManager.viewManager.marketWatch.currentPage] as ArrayCollection;

		var mwbo:MarketWatchBO=windowManager.viewManager.marketWatch.adgMarketWatch.selectedItem as MarketWatchBO;
		windowManager.viewManager.buyOrder.internalExchangeID=mwbo.internalExchangeID;
		windowManager.viewManager.buyOrder.txtExchange.text=mwbo.EXCHANGE;

		windowManager.viewManager.buyOrder.internalMarketID=mwbo.internalMarketID;
		windowManager.viewManager.buyOrder.txtMarket.text=mwbo.MARKET;

		var symbol:Object=modelManager.exchangeModel.getSymbolByCode(mwbo.internalExchangeID, mwbo.internalMarketID, mwbo.SYMBOL);
		if (symbol)
		{
			windowManager.viewManager.buyOrder.internalSymbolID=symbol.INTERNAL_SYMBOL_ID;
			// added on 11/1/2011
			windowManager.viewManager.buyOrder.txtSymbol.text=mwbo.SYMBOL;
			windowManager.viewManager.buyOrder.txtSymbol_focusOutHandler(null);
			windowManager.viewManager.buyOrder.focusManager.setFocus(windowManager.viewManager.buyOrder.txtVolume);
		}
		else
		{
			windowManager.viewManager.buyOrder.txtSymbol.text="";
			if (windowManager.viewManager.buyOrder.internalExchangeID > -1 && windowManager.viewManager.buyOrder.internalMarketID > -1)
			{
				windowManager.viewManager.buyOrder.focusManager.setFocus(windowManager.viewManager.buyOrder.txtSymbol);
			}
		}
			// modified on 11/1/2011
//				windowManager.viewManager.buyOrder.txtSymbol.text = mwbo.SYMBOL;
//				windowManager.viewManager.buyOrder.txtSymbol_focusOutHandler(null);
	}
}

/*
* Sell Order item handler
*/
public function menuitemSellOrder_itemClickHandler(event:MenuEvent):void
{
	var theApp:EasyTradeApp=EasyTradeApp.getInstance();
	var modelManager:ModelManager=ModelManager.getInstance();
	var viewManager:ViewManager=ViewManager.getInstance();
	var windowManager:WindowManager=WindowManager.getInstance();

	if (windowManager.sellOrderWindow && windowManager.canvas.windowManager.container.contains(windowManager.sellOrderWindow))
	{
		// added on 10/1/2010
		windowManager.viewManager.sellOrder.clearForm();
		windowManager.canvas.windowManager.bringToFront(windowManager.sellOrderWindow);
			//return;
	}
	else
	{
		windowManager.initSellOrderWindow();
		// added on 10/1/2010
		windowManager.viewManager.sellOrder.clearForm();
		windowManager.canvas.windowManager.add(windowManager.sellOrderWindow);
	}
	if (windowManager.marketWatchWindow && windowManager.canvas.windowManager.container.contains(windowManager.marketWatchWindow) && windowManager.viewManager.marketWatch.adgMarketWatch.selectedItem && windowManager.viewManager.marketWatch.adgMarketWatch.selectedIndex > -1)
	{
		var marketWatchView:ArrayCollection=modelManager.marketWatchModel.marketWatch[windowManager.viewManager.marketWatch.currentPage] as ArrayCollection;

		var mwbo:MarketWatchBO=windowManager.viewManager.marketWatch.adgMarketWatch.selectedItem as MarketWatchBO;
		windowManager.viewManager.sellOrder.internalExchangeID=mwbo.internalExchangeID;
		windowManager.viewManager.sellOrder.txtExchange.text=mwbo.EXCHANGE;

		windowManager.viewManager.sellOrder.internalMarketID=mwbo.internalMarketID;
		windowManager.viewManager.sellOrder.txtMarket.text=mwbo.MARKET;

		var symbol:Object=modelManager.exchangeModel.getSymbolByCode(mwbo.internalExchangeID, mwbo.internalMarketID, mwbo.SYMBOL);
		if (symbol)
		{
			windowManager.viewManager.sellOrder.internalSymbolID=symbol.INTERNAL_SYMBOL_ID;
			// added on 11/1/2011
			windowManager.viewManager.sellOrder.txtSymbol.text=mwbo.SYMBOL;
			windowManager.viewManager.sellOrder.txtSymbol_focusOutHandler(null);

			this.stage.focus=windowManager.viewManager.sellOrder.txtVolume;

		}
		else
		{
			windowManager.viewManager.sellOrder.txtSymbol.text="";
			if (windowManager.viewManager.sellOrder.internalExchangeID > -1 && windowManager.viewManager.sellOrder.internalMarketID > -1)
			{
				this.stage.focus=windowManager.viewManager.sellOrder.txtSymbol;
			}
		}
			// modified on 11/1/2011
//				windowManager.viewManager.sellOrder.txtSymbol.text = mwbo.SYMBOL;
//				windowManager.viewManager.sellOrder.txtSymbol_focusOutHandler(null);
	}
}

/*
* Change Order item handler
*/
public function menuitemChangeOrder_itemClickHandler(event:MenuEvent):void
{
	var theApp:EasyTradeApp=EasyTradeApp.getInstance();
	var modelManager:ModelManager=ModelManager.getInstance();
	var viewManager:ViewManager=ViewManager.getInstance();
	var windowManager:WindowManager=WindowManager.getInstance();

	windowManager.viewManager.changeOrder.isFromMenu=true;
	windowManager.viewManager.changeOrder.isFirstSubmission=true;
	windowManager.viewManager.changeOrder.reset();
	windowManager.viewManager.changeOrder.disableFields(false);
	if (windowManager.changeOrderWindow && windowManager.canvas.windowManager.container.contains(windowManager.changeOrderWindow))
	{
		windowManager.canvas.windowManager.bringToFront(windowManager.changeOrderWindow);
		return;
	}
	windowManager.initChangeOrderWindow();
	windowManager.canvas.windowManager.add(windowManager.changeOrderWindow);
}

/*
* Cancel Order item handler
*/
public function menuitemCancelOrder_itemClickHandler(event:MenuEvent):void
{
	var theApp:EasyTradeApp=EasyTradeApp.getInstance();
	var modelManager:ModelManager=ModelManager.getInstance();
	var viewManager:ViewManager=ViewManager.getInstance();
	var windowManager:WindowManager=WindowManager.getInstance();

	windowManager.viewManager.changeOrder.isFromMenu=true;
	windowManager.viewManager.changeOrder.isFirstSubmission=true;
	windowManager.viewManager.cancelOrder.reset();
	windowManager.viewManager.cancelOrder.disableFields(true);
	if (windowManager.cancelOrderWindow && windowManager.canvas.windowManager.container.contains(windowManager.cancelOrderWindow))
	{
		windowManager.canvas.windowManager.bringToFront(windowManager.cancelOrderWindow);
		return;
	}
	windowManager.initCancelOrderWindow();
	windowManager.canvas.windowManager.add(windowManager.cancelOrderWindow);
}

/*
* Yield Calculator item handler
*/
public function menuitemYieldCalculator_itemClickHandler(event:MenuEvent):void
{
	var theApp:EasyTradeApp=EasyTradeApp.getInstance();
	var modelManager:ModelManager=ModelManager.getInstance();
	var viewManager:ViewManager=ViewManager.getInstance();
	var windowManager:WindowManager=WindowManager.getInstance();

	if (windowManager.yieldCalculatorWindow && windowManager.canvas.windowManager.container.contains(windowManager.yieldCalculatorWindow))
	{
		windowManager.canvas.windowManager.bringToFront(windowManager.yieldCalculatorWindow);
		return;
	}
	windowManager.initYieldCalculatorWindow();
	windowManager.canvas.windowManager.add(windowManager.yieldCalculatorWindow);
}

/*
* Cancel All Orders item handler
*/
public function menuitemCancelAllOrders_itemClickHandler(event:MenuEvent):void
{
	var theApp:EasyTradeApp=EasyTradeApp.getInstance();
	var modelManager:ModelManager=ModelManager.getInstance();
	var viewManager:ViewManager=ViewManager.getInstance();
	var windowManager:WindowManager=WindowManager.getInstance();

	if (windowManager.cancelAllOrdersWindow && windowManager.canvas.windowManager.container.contains(windowManager.cancelAllOrdersWindow))
	{
		windowManager.canvas.windowManager.bringToFront(windowManager.cancelAllOrdersWindow);
		return;
	}
	windowManager.initCancelAllOrdersWindow();
	windowManager.canvas.windowManager.add(windowManager.cancelAllOrdersWindow);
}

////////////////////////////////////Watch Menu Handlers/////////////////////////////////////////

public function menuItemWatch_itemClickHandler(event:MenuEvent):void
{
	switch (event.index)
	{
		case 0: // Market Watch
			menuitemMarketWatch_itemClickHandler(event);
			break;
		case 1: // Best Orders
			menuitemBestOrders_itemClickHandler(event);
			break;
		case 2: // Best Prices
			menuitemBestPrices_itemClickHandler(event);
			break;
		case 4: // Exchange Stats
			menuitemExchangeStats_itemClickHandler(event);
			break;
		case 5: // Market States
			menuitemMarketStates_itemClickHandler(event);
			break;
		case 3: // Market Messages
			menuitemMarketMessages_itemClickHandler(event);
			break;
	}
}

/*
* Market watch item handler
*/
public function menuitemMarketWatch_itemClickHandler(event:MenuEvent):void
{
	var theApp:EasyTradeApp=EasyTradeApp.getInstance();
	var modelManager:ModelManager=ModelManager.getInstance();
	var viewManager:ViewManager=ViewManager.getInstance();
	var windowManager:WindowManager=WindowManager.getInstance();

	if (windowManager.marketWatchWindow && windowManager.canvas.windowManager.container.contains(windowManager.marketWatchWindow))
	{
		windowManager.canvas.windowManager.bringToFront(windowManager.marketWatchWindow);
		return;
	}

	windowManager.initMarketWatchWindow();
	windowManager.canvas.windowManager.add(windowManager.marketWatchWindow);
}

/*
* Best orders item handler
*/
public function menuitemBestOrders_itemClickHandler(event:MenuEvent):void
{
	var theApp:EasyTradeApp=EasyTradeApp.getInstance();
	var modelManager:ModelManager=ModelManager.getInstance();
	var viewManager:ViewManager=ViewManager.getInstance();
	var windowManager:WindowManager=WindowManager.getInstance();

	if (windowManager.bestOrdersWindow && windowManager.canvas.windowManager.container.contains(windowManager.bestOrdersWindow))
	{
		windowManager.canvas.windowManager.bringToFront(windowManager.bestOrdersWindow);
		return;
	}

	windowManager.initBestOrdersWindow();
	windowManager.canvas.windowManager.add(windowManager.bestOrdersWindow);
}

/*
* Best prices item handler
*/
public function menuitemBestPrices_itemClickHandler(event:MenuEvent):void
{
	var theApp:EasyTradeApp=EasyTradeApp.getInstance();
	var modelManager:ModelManager=ModelManager.getInstance();
	var viewManager:ViewManager=ViewManager.getInstance();
	var windowManager:WindowManager=WindowManager.getInstance();

	if (windowManager.bestPricesWindow && windowManager.canvas.windowManager.container.contains(windowManager.bestPricesWindow))
	{
		windowManager.canvas.windowManager.bringToFront(windowManager.bestPricesWindow);
		return;
	}

	windowManager.initBestPricesWindow();
	windowManager.canvas.windowManager.add(windowManager.bestPricesWindow);
}

/*
* Exchange Stats item handler
*/
public function menuitemExchangeStats_itemClickHandler(event:MenuEvent):void
{
	var theApp:EasyTradeApp=EasyTradeApp.getInstance();
	var modelManager:ModelManager=ModelManager.getInstance();
	var viewManager:ViewManager=ViewManager.getInstance();
	var windowManager:WindowManager=WindowManager.getInstance();

	if (windowManager.exchangeStatsWindow && windowManager.canvas.windowManager.container.contains(windowManager.exchangeStatsWindow))
	{
		windowManager.canvas.windowManager.bringToFront(windowManager.exchangeStatsWindow);
		return;
	}

	windowManager.initExchangeStatsWindow();
	windowManager.canvas.windowManager.add(windowManager.exchangeStatsWindow);
}

/*
* Market States item handler
*/
public function menuitemMarketStates_itemClickHandler(event:MenuEvent):void
{
	var theApp:EasyTradeApp=EasyTradeApp.getInstance();
	var modelManager:ModelManager=ModelManager.getInstance();
	var viewManager:ViewManager=ViewManager.getInstance();
	var windowManager:WindowManager=WindowManager.getInstance();

	if (windowManager.marketScheduleWindow && windowManager.canvas.windowManager.container.contains(windowManager.marketScheduleWindow))
	{
		windowManager.canvas.windowManager.bringToFront(windowManager.marketScheduleWindow);
		return;
	}

	windowManager.initMarketScheduleWindow();
	windowManager.canvas.windowManager.add(windowManager.marketScheduleWindow);
}

////////////////////////////////////Reports Menu Handlers/////////////////////////////////////////

public function menuItemReports_itemClickHandler(event:MenuEvent):void
{
	switch (event.index)
	{
		case 0:
			menuitemReminingOrders_itemClickHandler(event);
			break;
		case 1:
			menuitemUserTradeHistory_itemClickHandler(event);
			break;
		case 2:
			menuitemEventLog_itemClickHandler(event);
			break;
		case 3:
			menuitemSymbolBrowser_itemClickHandler(event);
			break;
		case 4:
			menuitemSymbolSumm_itemClickHandler(event);
			break;
		case 5:
			menuitemMarketSummary_itemClickHandler(event);
			break;
		case 6:
			menuItemRiskInformation_itemClickHandler(event);
			break;
		case 7:
			menuItemHistoricalSymbolData_itemClickHandler(event);
			break;
	}
}

/*
* Remaining orders item handler
*/
public function menuitemReminingOrders_itemClickHandler(event:MenuEvent):void
{
	var theApp:EasyTradeApp=EasyTradeApp.getInstance();
	var modelManager:ModelManager=ModelManager.getInstance();
	var viewManager:ViewManager=ViewManager.getInstance();
	var windowManager:WindowManager=WindowManager.getInstance();
	//This shouldn't be called when the user isn't logged in but just in case... 
	if (!theApp.isUserLoggedin())
	{
		Alert.show(ResourceManager.getInstance().getString('marketwatch','usrNotLoggedIn'), ResourceManager.getInstance().getString('marketwatch','error'));
		return;
	}
	if (windowManager.remainingOrdersWindow && windowManager.canvas.windowManager.container.contains(windowManager.remainingOrdersWindow))
	{
		windowManager.canvas.windowManager.bringToFront(windowManager.remainingOrdersWindow);
		return;
	}

	windowManager.initRemainingOrdersWindow();
	windowManager.canvas.windowManager.add(windowManager.remainingOrdersWindow);
	modelManager.updateRemainingOrders();
}

/*
* Last Day Remaining orders item handler
*/
public function menuitemLastDayReminingOrders_itemClickHandler(event:MenuEvent):void
{
	var theApp:EasyTradeApp=EasyTradeApp.getInstance();
	var modelManager:ModelManager=ModelManager.getInstance();
	var viewManager:ViewManager=ViewManager.getInstance();
	var windowManager:WindowManager=WindowManager.getInstance();
	//This shouldn't be called when the user isn't logged in but just in case... 
	if (!theApp.isUserLoggedin())
	{
		Alert.show(ResourceManager.getInstance().getString('marketwatch','usrNotLoggedIn'), ResourceManager.getInstance().getString('marketwatch','error'));
		return;
	}
	if (windowManager.lastDayRemainingOrdersWindow && windowManager.canvas.windowManager.container.contains(windowManager.lastDayRemainingOrdersWindow))
	{
		windowManager.canvas.windowManager.bringToFront(windowManager.lastDayRemainingOrdersWindow);
		return;
	}

	windowManager.initLastDayRemainingOrdersWindow();
	windowManager.canvas.windowManager.add(windowManager.lastDayRemainingOrdersWindow);
	modelManager.updateLastDayRemainingOrders();
}

/*
* User Trade History menu item handler
*/
public function menuitemUserTradeHistory_itemClickHandler(event:MenuEvent):void
{
	var theApp:EasyTradeApp=EasyTradeApp.getInstance();
	var modelManager:ModelManager=ModelManager.getInstance();
	var viewManager:ViewManager=ViewManager.getInstance();
	var windowManager:WindowManager=WindowManager.getInstance();
	//This shouldn't be called when the user isn't logged in but just in case... 
	if (!theApp.isUserLoggedin())
	{
		Alert.show(ResourceManager.getInstance().getString('marketwatch','usrNotLoggedIn'), ResourceManager.getInstance().getString('marketwatch','error'));
		return;
	}

	if (windowManager.userTradeHistoryWindow && windowManager.canvas.windowManager.container.contains(windowManager.userTradeHistoryWindow))
	{
		windowManager.canvas.windowManager.bringToFront(windowManager.userTradeHistoryWindow);
		return;
	}

	windowManager.initUserTradeHistoryWindow();
	windowManager.canvas.windowManager.add(windowManager.userTradeHistoryWindow);
	modelManager.updateUserTradeHistory();
}

/*
* Event Log menu item handler
*/
public function menuitemEventLog_itemClickHandler(event:MenuEvent):void
{
	var theApp:EasyTradeApp=EasyTradeApp.getInstance();
	var modelManager:ModelManager=ModelManager.getInstance();
	var viewManager:ViewManager=ViewManager.getInstance();
	var windowManager:WindowManager=WindowManager.getInstance();
	//This shouldn't be called when the user isn't logged in but just in case... 
	if (!theApp.isUserLoggedin())
	{
		Alert.show(ResourceManager.getInstance().getString('marketwatch','usrNotLoggedIn'), ResourceManager.getInstance().getString('marketwatch','error'));
		return;
	}

	if (windowManager.eventLogWindow && windowManager.canvas.windowManager.container.contains(windowManager.eventLogWindow))
	{
		windowManager.canvas.windowManager.bringToFront(windowManager.eventLogWindow);
		return;
	}

	windowManager.initEventLogWindow();
	windowManager.canvas.windowManager.add(windowManager.eventLogWindow);
	modelManager.updateEventLog();
}

/*
* Symbol Browser menu item handler
*/
public function menuitemSymbolBrowser_itemClickHandler(event:MenuEvent):void
{
	var theApp:EasyTradeApp=EasyTradeApp.getInstance();
	var modelManager:ModelManager=ModelManager.getInstance();
	var viewManager:ViewManager=ViewManager.getInstance();
	var windowManager:WindowManager=WindowManager.getInstance();
	//This shouldn't be called when the user isn't logged in but just in case... 
	if (!theApp.isUserLoggedin())
	{
		Alert.show(ResourceManager.getInstance().getString('marketwatch','usrNotLoggedIn'), ResourceManager.getInstance().getString('marketwatch','error'));
		return;
	}

	if (windowManager.symbolBrowserWindow && windowManager.canvas.windowManager.container.contains(windowManager.symbolBrowserWindow))
	{
		windowManager.canvas.windowManager.bringToFront(windowManager.symbolBrowserWindow);
		return;
	}
	//ModelManager.getInstance().symbolModel.internalExchangeID = 101;
	//ModelManager.getInstance().symbolModel.internalMarketID = 1;
	ModelManager.getInstance().updateSymbolBrowser();
	windowManager.initSymbolBrowserWindow();
	windowManager.canvas.windowManager.add(windowManager.symbolBrowserWindow);
}

/*
* Symbol Summary menu item handler
*/
public function menuitemSymbolSumm_itemClickHandler(event:MenuEvent):void
{
	var theApp:EasyTradeApp=EasyTradeApp.getInstance();
	var modelManager:ModelManager=ModelManager.getInstance();
	var viewManager:ViewManager=ViewManager.getInstance();
	var windowManager:WindowManager=WindowManager.getInstance();
	//This shouldn't be called when the user isn't logged in but just in case... 
	if (!theApp.isUserLoggedin())
	{
		Alert.show(ResourceManager.getInstance().getString('marketwatch','usrNotLoggedIn'), ResourceManager.getInstance().getString('marketwatch','error'));
		return;
	}

	if (windowManager.symbolSummWindow && windowManager.canvas.windowManager.container.contains(windowManager.symbolSummWindow))
	{
		windowManager.canvas.windowManager.bringToFront(windowManager.symbolSummWindow);
		return;
	}
	//ModelManager.getInstance().symbolModel.internalExchangeID = 101;
	//ModelManager.getInstance().symbolModel.internalMarketID = 1;

	windowManager.initSymbolSummWindow();

	windowManager.canvas.windowManager.add(windowManager.symbolSummWindow);
}

/*
* Market Summary menu item handler
*/
public function menuitemMarketSummary_itemClickHandler(event:MenuEvent):void
{
	var theApp:EasyTradeApp=EasyTradeApp.getInstance();
	var modelManager:ModelManager=ModelManager.getInstance();
	var viewManager:ViewManager=ViewManager.getInstance();
	var windowManager:WindowManager=WindowManager.getInstance();
	//This shouldn't be called when the user isn't logged in but just in case... 
	if (!theApp.isUserLoggedin())
	{
		Alert.show(ResourceManager.getInstance().getString('marketwatch','usrNotLoggedIn'), ResourceManager.getInstance().getString('marketwatch','error'));
		return;
	}

	if (windowManager.marketSummaryWindow && windowManager.canvas.windowManager.container.contains(windowManager.marketSummaryWindow))
	{
		windowManager.canvas.windowManager.bringToFront(windowManager.marketSummaryWindow);
		return;
	}
	//ModelManager.getInstance().symbolModel.internalExchangeID = 101;
	//ModelManager.getInstance().symbolModel.internalMarketID = 1;

	windowManager.initMarketSummaryWindow();

	windowManager.canvas.windowManager.add(windowManager.marketSummaryWindow);
}

/////////////////////////////////////
public function menuItemRiskInformation_itemClickHandler(event:MenuEvent):void
{
	var theApp:EasyTradeApp=EasyTradeApp.getInstance();
	var modelManager:ModelManager=ModelManager.getInstance();
	var viewManager:ViewManager=ViewManager.getInstance();
	var windowManager:WindowManager=WindowManager.getInstance();
	if (!theApp.isUserLoggedin())
	{
		Alert.show(ResourceManager.getInstance().getString('marketwatch','usrNotLoggedIn'), ResourceManager.getInstance().getString('marketwatch','error'));
		return;
	}
	
	if (windowManager.riskInformationWindow && windowManager.canvas.windowManager.container.contains(windowManager.riskInformationWindow))
	{
		windowManager.canvas.windowManager.bringToFront(windowManager.riskInformationWindow);
		return;
	}
	
	windowManager.initRiskInformationWindow();
	
	windowManager.canvas.windowManager.add(windowManager.riskInformationWindow);
}

/////////////////////////////////////Historical Symbol Data////////////////////////////
public function menuItemHistoricalSymbolData_itemClickHandler(event:MenuEvent):void
{
	var theApp:EasyTradeApp=EasyTradeApp.getInstance();
	var modelManager:ModelManager=ModelManager.getInstance();
	var viewManager:ViewManager=ViewManager.getInstance();
	var windowManager:WindowManager=WindowManager.getInstance();
	if (!theApp.isUserLoggedin())
	{
		Alert.show(ResourceManager.getInstance().getString('marketwatch','usrNotLoggedIn'), ResourceManager.getInstance().getString('marketwatch','error'));
		return;
	}
	
	if (windowManager.historicalSymbolWindow && windowManager.canvas.windowManager.container.contains(windowManager.historicalSymbolWindow))
	{
		windowManager.canvas.windowManager.bringToFront(windowManager.historicalSymbolWindow);
		return;
	}
	
	windowManager.inithistoricalSymbolWindow();
	
	windowManager.canvas.windowManager.add(windowManager.historicalSymbolWindow);
}

////////////////////////////////////System Menu Handlers/////////////////////////////////////////

public function menuItemControl_itemClickHandler(event:MenuEvent):void
{
	switch (event.index)
	{
		case 0: // Market States
			menuitemMarketScheduleControl_itemClickHandler(event);
			break;
		case 1: // Symbol States
			menuitemSymbolStateControl_itemClickHandler(event);
			break;
		case 2: // Bulletin
			menuitemBulletinControl_itemClickHandler(event);
			break;
		case 3: // Bulletin
			menuitemOrderLimitControl_itemClickHandler(event);
			break;
		case 4: // Last Day Remaining Orders 
			menuitemLastDayReminingOrders_itemClickHandler(event);
			break;
		case 5: // Cancel All Orders
			menuitemCancelAllOrders_itemClickHandler(event);
			break;
	}
}

////////////////////////////////////Setting Menu Handlers/////////////////////////////////////////

public function menuItemSetting_itemClickHandler(event:MenuEvent):void
{
	switch (event.index)
	{
		case 0: // Profile
			menuitemProfileSettings_itemClickHandler(event);
			break;
		case 1: // Change Password
			menuitemChangePassword_itemClickHandler(event);
			break;
	}
}

//	// added on 21/12/2010
//
//	public function menuItemCharts_itemClickHandler(event:MenuEvent):void
//	{
//		trace("charrt index : "+event.index);
//		switch (event.index)
//		{
//			case 0: // Live Symbol
//				menuitemLiveSymbolChart_itemClickHandler(event);
//				break;		
//		}
//	}

/*
* Profile item handler
*/
public function menuitemProfileSettings_itemClickHandler(event:MenuEvent):void
{
	var theApp:EasyTradeApp=EasyTradeApp.getInstance();
	var modelManager:ModelManager=ModelManager.getInstance();
	var viewManager:ViewManager=ViewManager.getInstance();
	var windowManager:WindowManager=WindowManager.getInstance();

	if (windowManager.profileSettingsWindow && windowManager.canvas.windowManager.container.contains(windowManager.profileSettingsWindow))
	{
		windowManager.canvas.windowManager.bringToFront(windowManager.profileSettingsWindow);
		return;
	}

	windowManager.initProfileSettingsWindow();
	windowManager.canvas.windowManager.add(windowManager.profileSettingsWindow);
}

/*
* Change Password item handler
*/
public function menuitemChangePassword_itemClickHandler(event:MenuEvent):void
{
	var theApp:EasyTradeApp=EasyTradeApp.getInstance();
	var modelManager:ModelManager=ModelManager.getInstance();
	var viewManager:ViewManager=ViewManager.getInstance();
	var windowManager:WindowManager=WindowManager.getInstance();

	if (windowManager.changePasswordWindow && windowManager.canvas.windowManager.container.contains(windowManager.changePasswordWindow))
	{
		windowManager.canvas.windowManager.bringToFront(windowManager.changePasswordWindow);
		return;
	}

	windowManager.initChangePasswordWindow();
	windowManager.canvas.windowManager.add(windowManager.changePasswordWindow);
}

/*
* Market Schedule item handler
*/
public function menuitemMarketScheduleControl_itemClickHandler(event:MenuEvent):void
{
	var theApp:EasyTradeApp=EasyTradeApp.getInstance();
	var modelManager:ModelManager=ModelManager.getInstance();
	var viewManager:ViewManager=ViewManager.getInstance();
	var windowManager:WindowManager=WindowManager.getInstance();

	if (windowManager.marketScheduleControlWindow && windowManager.canvas.windowManager.container.contains(windowManager.marketScheduleControlWindow))
	{
		windowManager.canvas.windowManager.bringToFront(windowManager.marketScheduleControlWindow);
		return;
	}

	windowManager.initMarketScheduleControlWindow();
	windowManager.canvas.windowManager.add(windowManager.marketScheduleControlWindow);
}

/*
* Symbol State item handler
*/
public function menuitemSymbolStateControl_itemClickHandler(event:MenuEvent):void
{
	var theApp:EasyTradeApp=EasyTradeApp.getInstance();
	var modelManager:ModelManager=ModelManager.getInstance();
	var viewManager:ViewManager=ViewManager.getInstance();
	var windowManager:WindowManager=WindowManager.getInstance();

	if (windowManager.symbolStateControlWindow && windowManager.canvas.windowManager.container.contains(windowManager.symbolStateControlWindow))
	{
		windowManager.canvas.windowManager.bringToFront(windowManager.symbolStateControlWindow);
		return;
	}

	windowManager.initSymbolStateControlWindow();
	windowManager.canvas.windowManager.add(windowManager.symbolStateControlWindow);
}

/*
* Bulletin Control item handler
*/
public function menuitemBulletinControl_itemClickHandler(event:MenuEvent):void
{
	var theApp:EasyTradeApp=EasyTradeApp.getInstance();
	var modelManager:ModelManager=ModelManager.getInstance();
	var viewManager:ViewManager=ViewManager.getInstance();
	var windowManager:WindowManager=WindowManager.getInstance();

	if (windowManager.bulletinControlWindow && windowManager.canvas.windowManager.container.contains(windowManager.bulletinControlWindow))
	{
		windowManager.canvas.windowManager.bringToFront(windowManager.bulletinControlWindow);
		return;
	}

	windowManager.initBulletinControlWindow();
	windowManager.canvas.windowManager.add(windowManager.bulletinControlWindow);
}

/*
* Bulletin Control item handler
*/
public function menuitemOrderLimitControl_itemClickHandler(event:MenuEvent):void
{
	var theApp:EasyTradeApp=EasyTradeApp.getInstance();
	var modelManager:ModelManager=ModelManager.getInstance();
	var viewManager:ViewManager=ViewManager.getInstance();
	var windowManager:WindowManager=WindowManager.getInstance();

	if (windowManager.orderLimitControlWindow && windowManager.canvas.windowManager.container.contains(windowManager.orderLimitControlWindow))
	{
		windowManager.canvas.windowManager.bringToFront(windowManager.orderLimitControlWindow);
		return;
	}

	windowManager.initOrderLimitControlWindow();
	windowManager.canvas.windowManager.add(windowManager.orderLimitControlWindow);
}

/*
* Live symbol chart
*/
public function menuitemLiveSymbolChart_itemClickHandler(event:MenuEvent):void
{
//	(event.item.@id == "liveSym").@label = ResourceManager.getInstance().getString('marketwatch','file');
	var theApp:EasyTradeApp=EasyTradeApp.getInstance();
	var modelManager:ModelManager=ModelManager.getInstance();
	var viewManager:ViewManager=ViewManager.getInstance();
	var windowManager:WindowManager=WindowManager.getInstance();

	if (windowManager.liveSymbolChartWindow && windowManager.canvas.windowManager.container.contains(windowManager.liveSymbolChartWindow))
	{
		windowManager.canvas.windowManager.bringToFront(windowManager.liveSymbolChartWindow);
		return;
	}
	windowManager.initLiveSymbolChartWindow();
	windowManager.canvas.windowManager.add(windowManager.liveSymbolChartWindow);
}

public function menuitemhistoricalSymbolDataChart_itemClickHandler(event:MenuEvent):void
{
	//	(event.item.@id == "liveSym").@label = ResourceManager.getInstance().getString('marketwatch','file');
	var theApp:EasyTradeApp=EasyTradeApp.getInstance();
	var modelManager:ModelManager=ModelManager.getInstance();
	var viewManager:ViewManager=ViewManager.getInstance();
	var windowManager:WindowManager=WindowManager.getInstance();
	
	if (windowManager.historicalSymbolDataCharts && windowManager.canvas.windowManager.container.contains(windowManager.historicalSymbolDataCharts))
	{
		windowManager.canvas.windowManager.bringToFront(windowManager.historicalSymbolDataCharts);
		return;
	}
	windowManager.inithistoricalSymbolDataChartsWindow();
	windowManager.canvas.windowManager.add(windowManager.historicalSymbolDataCharts);
}

/*
* About menu
*/
public function menuitemAbout_itemClickHandler(event:MenuEvent):void
{
	Alert.show(Constants.APPLICATION_VERSION, Constants.APPLICATION_TITLE);
}

public function menuitemChange_itemClickHandler(event:MenuEvent):void
{
	try
	{
		
	}catch(e:Error)
	{
		trace(e.message);
	}
}

public function menuitemMarketMessages_itemClickHandler(event:MenuEvent):void
{
	var theApp:EasyTradeApp=EasyTradeApp.getInstance();
	var modelManager:ModelManager=ModelManager.getInstance();
	var viewManager:ViewManager=ViewManager.getInstance();
	var windowManager:WindowManager=WindowManager.getInstance();

	if (windowManager.liveMessages && windowManager.canvas.windowManager.container.contains(windowManager.liveMessages))
	{
		windowManager.canvas.windowManager.bringToFront(windowManager.liveMessages);
		return;
	}
	windowManager.initLiveMessagesWindow();
	windowManager.canvas.windowManager.add(windowManager.liveMessages);
}
