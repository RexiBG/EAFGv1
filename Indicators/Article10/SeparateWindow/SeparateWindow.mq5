//+------------------------------------------------------------------+
//|                                               SeparateWindow.mq5 |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "2016, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#property indicator_separate_window
#property indicator_buffers 0
#property indicator_plots   0
//--- Including the application class
#include "Program.mqh"
CProgram program;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit(void)
  {
   program.OnInitEvent();  
//--- Creating the graphical interface
   if(!program.CreateGUI())
     {
      ::Print(__FUNCTION__," > Failed to create graphical interface!");
      return(INIT_FAILED);
     }
//--- Initialization successful
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   program.OnDeinitEvent(reason);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int    rates_total,     // size of the price[] array
                const int    prev_calculated, // bars processed on the previous call
                const int    begin,           // where significant data start
                const double &price[])        // array for calculation
  {
   return(rates_total);
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer(void)
  {
   program.OnTimerEvent();
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int    id,
                  const long   &lparam,
                  const double &dparam,
                  const string &sparam)
  {
   program.ChartEvent(id,lparam,dparam,sparam);
  }
//+------------------------------------------------------------------+
