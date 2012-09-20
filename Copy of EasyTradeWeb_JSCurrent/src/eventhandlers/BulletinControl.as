import businessobjects.Bulletin;

import common.Type;

import components.ComboBoxItem;
import components.EZNumberFormatter;

import controller.ModelManager;

import flash.events.MouseEvent;

import mx.events.FlexEvent;

import spark.components.CheckBox;

import view.ExchangeStatsIndices;

protected function group1_initializeHandler(event:FlexEvent):void
{
	try
	{
		for (var i:int=0; i < ModelManager.getInstance().exchangeModel.exchanges.length; ++i)
		{
			var obj:Object=ModelManager.getInstance().exchangeModel.exchanges.getItemAt(i);
			var cbi:ComboBoxItem=new ComboBoxItem(obj.INTERNAL_EXCHANGE_ID.toString(), obj.EXCHANGE_CODE);
			exchangeList.addItem(cbi);
		}
		internalExchangeID=-1;
		txtExchange.addEventListener(MouseEvent.CLICK, txtExchange_clickHandler);
	}
	catch (e:Error)
	{
	}
}


protected function chckAll_clickHandler(event:MouseEvent):void
{
	if ((event.currentTarget as CheckBox).selected)
	{
		txtExchange.enabled=false;
		txtExchange.removeEventListener(MouseEvent.CLICK, txtExchange_clickHandler);
		txtExchange.text="";
		internalExchangeID=-1;
	}
	else
	{
		txtExchange.enabled=true;
		txtExchange.addEventListener(MouseEvent.CLICK, txtExchange_clickHandler);
	}
}

protected function btnSubmit_clickHandler(event:MouseEvent):void
{
	var modelManager:ModelManager=ModelManager.getInstance();
	var bulletin:Bulletin=new Bulletin();
	bulletin.AUD_TYPE=Type.Bulletin_Aud_Type.EXCHANGE;
	bulletin.toAllExchanges=chckAll.selected;
	bulletin.ID=internalExchangeID;
	bulletin.MESSAGE_TEXT=txaBulletin.text;

	modelManager.SubmitBulletin(bulletin);
}

protected function btnReset_clickHandler(event:MouseEvent):void
{
	resetView();
}

public function resetView():void
{
	internalExchangeID=-1;
	txtExchange.text="";
	txaBulletin.text="";
	chckAll.selected=false;
	txtExchange.enabled=true;
	txtExchange.addEventListener(MouseEvent.CLICK, txtExchange_clickHandler);
}

public function applyFilter():void
{
	
}
