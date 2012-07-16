package components
{

	public class ComboBoxItem
	{
		private var value_:String;

		public function get value():String
		{
			return value_;
		}

		private var label_:String;

		public function get label():String
		{
			return label_;
		}

		public function ComboBoxItem(value:String, label:String)
		{
			value_=value;
			label_=label;
		}

	}
}
