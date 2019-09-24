//+------------------------------------------------------------------+
//|                                              IndieOutputTest.mq4 |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property indicator_chart_window

input bool waiting_for_buy_signal = false;
input bool waiting_for_sell_signal = false;
input bool position_open = false;
input int bar_num = 1;
int prev_bar = bar_num +1;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
enum Stoch_color{
   Color_Green =0,
   Color_Orange = 1,
   Color_Red = 2

};

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//---
     Stoch_color current_color;
     Stoch_color previous_color;
     bool value2_non_empty_bar1 = false;
     bool value3_non_empty_bar1 = false;
     bool value2_non_empty_bar2 = false;
     bool value3_non_empty_bar2 = false;
     ENUM_TIMEFRAMES current_tf = ChartPeriod();
     string pair = Symbol();
      
     double value2_bar1=iCustom(NULL,0,"SuperStoch",1,bar_num);
     double value3_bar1=iCustom(NULL,0,"SuperStoch",2,bar_num);
     double value2_bar2=iCustom(NULL,0,"SuperStoch",1,prev_bar);
     double value3_bar2=iCustom(NULL,0,"SuperStoch",2,prev_bar);
     
    
     
     if(value2_bar1 != EMPTY_VALUE){
      value2_non_empty_bar1 = true;
     }
     else if(value3_bar1 != EMPTY_VALUE){
      value3_non_empty_bar1 = true;
     }
     
     if(value2_bar2 != EMPTY_VALUE){
      value2_non_empty_bar2 = true;
     }
     else if(value3_bar2 != EMPTY_VALUE){
      value3_non_empty_bar2 = true;
     }
     
     if(value2_non_empty_bar1 && value2_non_empty_bar2){
      current_color = Color_Green;
      Print("Green");
     }
     else if(value2_non_empty_bar1 && value3_non_empty_bar2){
      current_color = Color_Orange;
      Print("Orange");
     }
     else if(value3_non_empty_bar1 && value2_non_empty_bar2 ){
      current_color = Color_Orange;
      Print("Orange");
     }
     else if(value3_non_empty_bar1 && value3_non_empty_bar2){
      current_color = Color_Red;
      Print("Red");
     }
     
     /*
     if(waiting_for_buy_signal && (current_color == Color_Green)){
      SendMail("Setup Alert!","Buy Setup on chart :"+pair+" ,Timeframe is :"+current_tf);
     }
     
     if(waiting_for_sell_signal && (current_color == Color_Green)){
      SendMail("Setup Alert!","Sell Setup on chart :"+pair+" ,Timeframe is :"+current_tf);
     }
     
     if(position_open && (current_color == Color_Orange)){
      SendMail("Exit Alert!","Close positions, the market owes you nothing");
     }
     
     if(waiting_for_buy_signal && waiting_for_sell_signal){
      SendMail("Bug Alert!","Both waiting for a buy and sell are true");
     }
     
     if(waiting_for_buy_signal && waiting_for_sell_signal && position_open){
      SendMail("Major bug Alert!","Both waiting for a buy and sell are true and there's a position open");
     }
     
     //Print(val);
     */


//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
