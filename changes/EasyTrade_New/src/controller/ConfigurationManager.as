package controller
{
	import configuration.ExchangeStatsConf;
	import configuration.ScreenConf;

	public class ConfigurationManager
	{
		private static var instance:ConfigurationManager=new ConfigurationManager();

		///////////////////////////////////////////////////////////////

		public function ConfigurationManager()
		{
			if (instance)
			{
				throw new Error("ConfigurationManager can only be accessed through ModelManager.getInstance()");
			}
		}

		///////////////////////////////////////////////////////////////

		public static function getInstance():ConfigurationManager
		{
			return instance;
		}
		///////////////////////////////////////////////////////////////

		private var screenConf_:ScreenConf=new ScreenConf();

		[Bindable]
		public function get screenConf():ScreenConf
		{
			return screenConf_;
		}

		public function set screenConf(value:ScreenConf):void
		{
			screenConf_=value;
		}
		///////////////////////////////////////////////////////////////


		private var exchangeStatsConf_:ExchangeStatsConf=new ExchangeStatsConf();

		[Bindable]
		public function get exchangeStatsConf():ExchangeStatsConf
		{
			return exchangeStatsConf_;
		}

		public function set exchangeStatsConf(value:ExchangeStatsConf):void
		{
			exchangeStatsConf_=value;
		}
		///////////////////////////////////////////////////////////////
	}
}
