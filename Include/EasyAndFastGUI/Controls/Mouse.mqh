//+------------------------------------------------------------------+
//|                                                        Mouse.mqh |
//|                        Copyright 2016, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include <Charts\Chart.mqh>
//+------------------------------------------------------------------+
//| Class for getting the mouse parameters                           |
//+------------------------------------------------------------------+
class CMouse
  {
private:
   //--- Class instance for managing the chart
   CChart            m_chart;
   //--- Coordinates
   int               m_x;
   int               m_y;
   //--- Window number, in which the cursor is located
   int               m_subwin;
   //--- Time corresponding to the X coordinate
   datetime          m_time;
   //--- Level (price) corresponding to the Y coordinate
   double            m_level;
   //--- State of the left mouse button (pressed down/released)
   bool              m_left_button_state;
   //---
public:
                     CMouse(void);
                    ~CMouse(void);
   //--- Event handler
   void              OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);

   //--- Returns coordinates
   int               X(void)               const { return(m_x);                 }
   int               Y(void)               const { return(m_y);                 }
   //--- (1) Returns the window number, in which the cursor is located, (2) the time corresponding to the X coordinate 
   //    (3) the level (price) corresponding to the Y coordinate
   int               SubWindowNumber(void) const { return(m_subwin);            }
   datetime          Time(void)            const { return(m_time);              }
   double            Level(void)           const { return(m_level);             }
   //--- Returns the state of the left mouse button (pressed down/released)
   bool              LeftButtonState(void) const { return(m_left_button_state); }
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CMouse::CMouse(void) : m_x(0),
                       m_y(0),
                       m_subwin(WRONG_VALUE),
                       m_time(NULL),
                       m_level(0.0),
                       m_left_button_state(false)
  {
//--- Get the ID of the current chart
   m_chart.Attach();
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CMouse::~CMouse(void)
  {
//--- Detach from the chart
   m_chart.Detach();
  }
//+------------------------------------------------------------------+
//| Handle events of moving the mouse cursor                         |
//+------------------------------------------------------------------+
void CMouse::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- Handling of the cursor movement event
   if(id==CHARTEVENT_MOUSE_MOVE)
     {
      //--- Coordinates and the state of the left mouse button
      m_x                 =(int)lparam;
      m_y                 =(int)dparam;
      m_left_button_state =(bool)int(sparam);
      //--- Get the cursor location
      if(!::ChartXYToTimePrice(0,m_x,m_y,m_subwin,m_time,m_level))
         return;
      //--- Get the relative Y coordinate
      if(m_subwin>0)
         m_y=m_y-m_chart.SubwindowY(m_subwin);
     }
  }
//+------------------------------------------------------------------+
