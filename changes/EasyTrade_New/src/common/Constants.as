package common
{
	import mx.styles.StyleManager;

	public class Constants
	{
		public static const MARKET_WATCH_WINDOW_TITLE:String="Market Watch";
		public static const MARKET_WATCH_WINDOW_ID:String="view.MarketWatch";
		public static const EXCHANGE_STATS_WINDOW_TITLE:String="Exchange Stats";
		public static const EXCHANGE_STATS_WINDOW_ID:String="view.ExchangeStats";
		public static const SYMBOL_BROWSER_WINDOW_TITLE:String="Symbol Browser";
		public static const SYMBOL_BROWSER_WINDOW_ID:String="view.SymbolBrowser";
		public static const SYMBOL_SUMMARY_WINDOW_TITLE:String="Symbol Summary";
		public static const SYMBOL_SUMMARY_WINDOW_ID:String="view.SymbolSummary";
		public static const MARKET_SUMMARY_WINDOW_TITLE:String="Market Summary";
		public static const MARKET_SUMMARY_WINDOW_ID:String="view.MarketSummary";
		public static const EXECUTED_ORDERS_WINDOW_TITLE:String="Executed Orders";
		public static const EXECUTED_ORDERS_WINDOW_ID:String="view.ExecutedOrders";
		public static const WORKING_ORDERS_WINDOW_TITLE:String="Working Orders";
		public static const WORKING_ORDERS_WINDOW_ID:String="view.WorkingOrders";
		public static const LAST_DAY_REMAINING_ORDERS_WINDOW_TITLE:String="Last Day Remaining Orders";
		public static const LAST_DAY_REMAINING_ORDERS_WINDOW_ID:String="view.LastDayRemainingOrders";
		public static const EVENT_LOG_WINDOW_TITLE:String="Event Log";
		public static const EVENT_LOG_WINDOW_ID:String="view.EventLog";
		public static const BEST_ORDERS_WINDOW_TITLE:String="Best Orders";
		public static const BEST_ORDERS_WINDOW_ID:String="view.BestOrders";
		public static const BEST_PRICES_WINDOW_TITLE:String="Best Prices";
		public static const BEST_PRICES_WINDOW_ID:String="view.BestPrices";
		public static const BEST_MARKET_WINDOW_TITLE:String="Best Market";
		public static const BEST_MARKET_WINDOW_ID:String="view.BestMarket";
		public static const BUY_ORDER_WINDOW_TITLE:String="Buy";
		public static const BUY_ORDER_WINDOW_ID:String="view.BuyOrder";
		public static const SELL_ORDER_WINDOW_TITLE:String="Sell";
		public static const SELL_ORDER_WINDOW_ID:String="view.SellOrder";
		public static const CHANGE_ORDER_WINDOW_TITLE:String="Change";
		public static const CHANGE_ORDER_WINDOW_ID:String="view.ChangeOrder";
		public static const CANCEL_ORDER_WINDOW_TITLE:String="Cancel";
		public static const CANCEL_ORDER_WINDOW_ID:String="view.CancelOrder";
		public static const CANCEL_ALL_ORDERS_WINDOW_TITLE:String="Cancel All Orders";
		public static const CANCEL_ALL_ORDERS_WINDOW_ID:String="view.CancelAllOrders";
		public static const YIELD_CALCULATOR_WINDOW_TITLE:String="Yield Calculator";
		public static const YIELD_CALCULATOR_WINDOW_ID:String="view.YieldCalculator";
		public static const CHANGE_PASSWORD_WINDOW_TITLE:String="Change Password";
		public static const CHANGE_PASSWORD_WINDOW_ID:String="view.ChangePassword";
		public static const MARKET_SCHEDULE_WINDOW_TITLE:String="Market Schedule";
		public static const MARKET_SCHEDULE_WINDOW_ID:String="view.MarketSchedule";
		public static const MARKET_SCHEDULE_CONTROL_WINDOW_TITLE:String="Change Market State";
		public static const MARKET_SCHEDULE_CONTROL_WINDOW_ID:String="view.MarketScheduleControl";
		public static const SYMBOL_STATE_CONTROL_WINDOW_TITLE:String="Change Symbol State";
		public static const SYMBOL_STATE_CONTROL_WINDOW_ID:String="view.SymbolStateControl";
		public static const BULLETIN_CONTROL_WINDOW_TITLE:String="Send Bulletin";
		public static const BULLETIN_CONTROL_WINDOW_ID:String="view.BulletinControl";
		public static const ORDER_LIMIT_CONTROL_WINDOW_TITLE:String="Change Order Limit";
		public static const ORDER_LIMIT_CONTROL_WINDOW_ID:String="view.OrderLimitControl";
		public static const HIST_SYMBOL_CHART_WINDOW_TITLE:String="Live Symbol Chart";
		public static const HIST_SYMBOL_CHART_WINDOW_ID:String="view.LiveSymbolChart";
		public static const PROFILE_WINDOW_TITLE:String="Profile Settings";
		public static const PROFILE_WINDOW_ID:String="view.ProfileSettings";
		public static const TOOLBAR_ID:String="toolbar";
		public static const BTN_TEXT_REFRESH:String="Refresh";
		public static const BTN_TEXT_EXPAND_ALL:String="Expand All";
		public static const BTN_TEXT_COLLAPSE_ALL:String="Collapse All";
		public static const QUICK_ORDERS_WINDOW_TITLE:String="Quick Orders";
		public static const QUICK_ORDERS_WINDOW_ID:String="view.QuickOrders";
		public static const LIVE_MESSAGES_WINDOW_TITLE:String="Messages";
		public static const LIVE_MESSAGES_WINDOW_WINDOW_ID:String="view.Messages";
		public static const RISK_INFORMATION_WINDOW_TITLE:String="Risk Information";
		public static const RISK_INFORMATION_WINDOW_ID:String="view.RiskInformation";

		public static const REJ_COLOR:String="#FF0000";
		public static const REJ_COLOR_INT:uint=0xFF0000;
		public static const BUY_COLOR:String="#3dbeff";
		public static const BUY_COLOR_INT:uint=0x0c70a2;
		public static const BUY_BG_COLOR:String="#000000";
		public static const BUY_BG_COLOR_INT:uint=0x000000;
		public static const SELL_COLOR:String="#e65cd4";
		public static const SELL_COLOR_INT:uint=0xbe3267;
		public static const SELL_BG_COLOR:String="#222222";
		public static const SELL_BG_COLOR_INT:uint=0x222222;
		public static const CHANGE_COLOR:String="#F5B63D";
		public static const CHANGE_COLOR_INT:uint=0xF5B63D;
		public static const CANCEL_COLOR:String="#7E22D4";
		public static const CANCEL_COLOR_INT:uint=0x7E22D4;
		public static const NEWS_WINDOW_TEXT_COLOR_INT:uint=0xF2FF24;
		public static const NEWS_WINDOW_BG_COLOR_INT:uint=0xFFFFFF;
		public static const TICKER_COLOR_NO_CHANGE_INT:uint=0xFFFFFF;
		public static const TICKER_COLOR_UP_INT:uint=0x00FF2A;
		public static const TICKER_COLOR_DOWN_INT:uint=0xFF0000;
		public static const MARKET_WATCH_TITLE_BACKGROUND:String="#000000";
		public static const MARKET_WATCH_TITLE_BACKGROUND_INT:uint=0x909090;
		public static const MARKET_WATCH_TITLE_BORDER_INT:uint=0xCCCCCE;
		public static const BORDER_TOP:int=2;
		public static const TITLE_COLOR:int=0x000000;


		public static var SERVICE_URL:String="";
		public static var SECURE_SERVICE_URL:String="";
//		public static const SERVICE_URL:String						= "http://192.168.36.62:8080/QWService/";
//		public static const SECURE_SERVICE_URL:String				= "https://192.168.12.83:8443/QWService/";
//		public static const SERVICE_URL:String						= "http://192.168.36.117:8080/QWService/";
//		public static const SECURE_SERVICE_URL:String				= "https://192.168.36.117:8443/QWService/";
		//public static var QW_WSDL_END_POINT:String				= SERVICE_URL + "QueryWaitress?wsdl";
		public static var QW_WSDL_END_POINT:String="QueryWaitress?wsdl";
		// modified on 7/1/2011 after discussion with Hashim
		//public static const ORDERER_WSDL_END_POINT:String			= SECURE_SERVICE_URL + "Orderer?wsdl";
//		public static var  ORDERER_WSDL_END_POINT:String			= SERVICE_URL + "Orderer?wsdl";
//		public static var  ANNOUNCER_WSDL_END_POINT:String			= SERVICE_URL + "Announcer?wsdl";
//		public static var LOGIN_MANAGER_WSDL_END_POINT:String		= SERVICE_URL + "LoginManager?wsdl";

		public static var ORDERER_WSDL_END_POINT:String="Orderer?wsdl";
		public static var ANNOUNCER_WSDL_END_POINT:String="Announcer?wsdl";
		public static var LOGIN_MANAGER_WSDL_END_POINT:String="LoginManager?wsdl";
		public static var LIGHTSTREAMER_SERVER:String="";
		public static var LIGHTSTREAMER_PORT:Number=8085;
		public static var RS_WSDL_END_POINT:String="RiskSieve?wsdl";

		public static const ORDER_CONFIRMATION_DATA_ADAPTER:String="ORDER_CONFIRMATION";
		public static const SYMBOL_STAT_DATA_ADAPTER:String="SYMBOL_STAT";
		public static const BEST_MARKET_DATA_ADAPTER:String="BEST_MARKET";
		public static const ANNOUNCEMENT_FEED_DATA_ADAPTER:String="ANNOUNCEMENT_FEED";

		public static const ROW_COUNT_BEST_ORDERS:uint=10;
		public static const ROW_COUNT_BEST_PRICES:uint=10;
		public static const PAGE_COUNT_MARKET_WATCH:uint=6;
		public static const ROW_COUNT_MARKET_WATCH:uint=360;

		public static const EVENT_MENU_CLOSE:String="menuClose";
 
		public static const TICKER_PAUSE_REASON_MOUSE_OVER:int=1;

		public static const EXCHANGE_STATS_ADVANCED:String="Advanced";
		public static const EXCHANGE_STATS_DECLINED:String="Declined";
		public static const EXCHANGE_STATS_UNCHANGED:String="Unchanged";
		public static const EXCHANGE_STATS_ZERO_VOLUME:String="Zero-Volume";

		public static const ADMIN_ROLE:String="Admin";
		public static const USER_LOGIN_PREFERENCES:String="USER_LOGIN_PREFERENCES";
		public static const APPLICATION_TITLE:String="Easy Trade";
		public static const APPLICATION_VERSION:String="Version #\t\t\t\t\t  2.0.6 \nRelease Date\t\t	     13-7-2012 \nBuild Date\t\t\t 		13-7-2012 \n      Copyright © Easy Trade™ 2012";
		public static const BOND_ENABLED:Boolean=true;

		public static const QUICK_ORDERS_DROP_DOWN_LIMIT:int=1000;
		public static const QUICK_ORDERS_MAX_SEGMENTS:int=4;
	}
}
