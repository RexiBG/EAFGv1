//+------------------------------------------------------------------+
//|                                                      Program.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include <EasyAndFastGUI\Controls\WndEvents.mqh>
//+------------------------------------------------------------------+
//| Class for creating an application                                |
//+------------------------------------------------------------------+
class CProgram : public CWndEvents
  {
private:
   //--- Form 1
   CWindow           m_window1;
   //--- Main menu and its context menus
   CMenuBar          m_menubar;
   CContextMenu      m_mb_contextmenu1;
   CContextMenu      m_mb_contextmenu2;
   CContextMenu      m_mb_contextmenu3;
   CContextMenu      m_mb_contextmenu4;
   //--- Calendars
   CCalendar         m_calendar1;
   CCalendar         m_calendar2;
   //--- Drop down calendars
   CDropCalendar     m_drop_calendar1;
   CDropCalendar     m_drop_calendar2;
   //--- Status Bar
   CStatusBar        m_status_bar;
   //---
public:
                     CProgram(void);
                    ~CProgram(void);
   //--- Initialization/deinitialization
   void              OnInitEvent(void);
   void              OnDeinitEvent(const int reason);
   //--- Timer
   void              OnTimerEvent(void);
   //---
protected:
   //--- Chart event handler
   virtual void      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
   //---
public:
   //--- Create the indicator panel
   bool              CreateIndicatorPanel(void);
   //---
private:
   //--- Form 1
   bool              CreateWindow1(const string text);

   //--- Main menu and its context menus
#define MENUBAR_GAP_X         (1)
#define MENUBAR_GAP_Y         (20)
   bool              CreateMenuBar(void);
   bool              CreateMBContextMenu1(void);
   bool              CreateMBContextMenu2(void);
   bool              CreateMBContextMenu3(void);
   bool              CreateMBContextMenu4(void);
   //--- Status Bar
#define STATUSBAR1_GAP_X      (1)
#define STATUSBAR1_GAP_Y      (232)
   bool              CreateStatusBar(void);
   //--- Calendars
#define CALENDAR1_GAP_X       (2)
#define CALENDAR1_GAP_Y       (43)
   bool              CreateCalendar1(void);
#define CALENDAR2_GAP_X       (164)
#define CALENDAR2_GAP_Y       (43)
   bool              CreateCalendar2(void);
   //--- Drop down calendars
#define DROPCALENDAR1_GAP_X   (7)
#define DROPCALENDAR1_GAP_Y   (207)
   bool              CreateDropCalendar1(const string text);
#define DROPCALENDAR2_GAP_X   (170)
#define DROPCALENDAR2_GAP_Y   (207)
   bool              CreateDropCalendar2(const string text);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CProgram::CProgram(void)
  {
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CProgram::~CProgram(void)
  {
  }
//+------------------------------------------------------------------+
//| Initialization                                                   |
//+------------------------------------------------------------------+
void CProgram::OnInitEvent(void)
  {
  }
//+------------------------------------------------------------------+
//| Uninitialization                                                 |
//+------------------------------------------------------------------+
void CProgram::OnDeinitEvent(const int reason)
  {
//--- Removing the interface
   CWndEvents::Destroy();
  }
//+------------------------------------------------------------------+
//| Timer                                                            |
//+------------------------------------------------------------------+
void CProgram::OnTimerEvent(void)
  {
   CWndEvents::OnTimerEvent();
//--- Updating the second item of the status bar every 500 milliseconds
   static int count=0;
   if(count<500)
     {
      count+=TIMER_STEP_MSC;
      return;
     }
//--- Zero the counter
   count=0;
//--- Change the value in the second item of the status bar
   m_status_bar.ValueToItem(1,::TimeToString(::TimeLocal(),TIME_DATE|TIME_SECONDS));
//--- 
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CProgram::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- Clicking on the menu item event
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_CONTEXTMENU_ITEM)
     {
      ::Print(__FUNCTION__," > id: ",id,"; lparam: ",lparam,"; dparam: ",dparam,"; sparam: ",sparam);
     }
//--- Event of changing the date in the calendar
   if(id==CHARTEVENT_CUSTOM+ON_CHANGE_DATE)
     {
      ::Print(__FUNCTION__," > id: ",id,"; lparam: ",lparam,"; dparam: ",datetime(dparam),"; sparam: ",sparam);
     }
  }
//+------------------------------------------------------------------+
//| Create indicator panel                                           |
//+------------------------------------------------------------------+
bool CProgram::CreateIndicatorPanel(void)
  {
//--- Creating form 1 for controls
   if(!CreateWindow1("INDICATOR PANEL"))
      return(false);
//--- Creating controls:
//    Main menu
   if(!CreateMenuBar())
      return(false);
//--- Context menus
   if(!CreateMBContextMenu1())
      return(false);
   if(!CreateMBContextMenu2())
      return(false);
   if(!CreateMBContextMenu3())
      return(false);
   if(!CreateMBContextMenu4())
      return(false);
//--- Creating the status bar
   if(!CreateStatusBar())
      return(false);
//--- Calendars
   if(!CreateCalendar1())
      return(false);
   if(!CreateCalendar2())
      return(false);
//--- Drop down calendars
   if(!CreateDropCalendar1("Begin: "))
      return(false);
   if(!CreateDropCalendar2("End: "))
      return(false);
//--- Redrawing the chart
   m_chart.Redraw();
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates form 1 for controls                                      |
//+------------------------------------------------------------------+
bool CProgram::CreateWindow1(const string caption_text)
  {
//--- Add the window pointer to the window array
   CWndContainer::AddWindow(m_window1);
//--- Coordinates
   int x=(m_window1.X()>0) ? m_window1.X() : 1;
   int y=(m_window1.Y()>0) ? m_window1.Y() : 20;
//--- Properties
   m_window1.XSize(327);
   m_window1.YSize(257);
   m_window1.Movable(true);
   m_window1.UseRollButton();
//--- Creating the form
   if(!m_window1.CreateWindow(m_chart_id,m_subwin,caption_text,x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates the main menu                                            |
//+------------------------------------------------------------------+
bool CProgram::CreateMenuBar(void)
  {
//--- Three items in the main menu
#define MENUBAR_TOTAL 3
//--- Store the window pointer
   m_menubar.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+MENUBAR_GAP_X;
   int y=m_window1.Y()+MENUBAR_GAP_Y;
//--- Arrays with unique properties of each item
   int    width[MENUBAR_TOTAL] ={50,55,53};
   string text[MENUBAR_TOTAL]  ={"File","View","Help"};
//--- Set properties before creation
   m_menubar.AutoXResizeMode(true);
   m_menubar.AutoXResizeRightOffset(1);
//--- Add items to the main menu
   for(int i=0; i<MENUBAR_TOTAL; i++)
      m_menubar.AddItem(width[i],text[i]);
//--- Create control
   if(!m_menubar.CreateMenuBar(m_chart_id,m_subwin,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_menubar);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates a context menu                                           |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\script.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\script_gray.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart_gray.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\coins_gray.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart_gray.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\safe.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\safe_gray.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\pie_chart.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\pie_chart_gray.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\calculator.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\calculator_gray.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\invoice.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\invoice_gray.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_black.bmp"
//---
bool CProgram::CreateMBContextMenu1(void)
  {
//--- Six items in a context menu
#define CONTEXTMENU_ITEMS1 3
//--- Store the window pointer
   m_mb_contextmenu1.WindowPointer(m_window1);
//--- Store the pointer to the previous node
   m_mb_contextmenu1.PrevNodePointer(m_menubar.ItemPointerByIndex(0));
//--- Attach the context menu to the specified menu item
   m_menubar.AddContextMenuPointer(0,m_mb_contextmenu1);
//--- Array of the menu item names
   string items_text[CONTEXTMENU_ITEMS1]=
     {
      "ContextMenu 1 Item 1",
      "ContextMenu 1 Item 2",
      "ContextMenu 1 Item 3..."
     };
//--- Array of icons for the available mode
   string items_bmp_on[CONTEXTMENU_ITEMS1]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart.bmp"
     };
//--- Array of icon for the blocked mode
   string items_bmp_off[CONTEXTMENU_ITEMS1]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins_gray.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart_gray.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart_gray.bmp"
     };
//--- Array of item types
   ENUM_TYPE_MENU_ITEM items_type[]=
     {
      MI_SIMPLE,
      MI_SIMPLE,
      MI_SIMPLE
     };
//--- Set properties before creation
   m_mb_contextmenu1.FixSide(FIX_BOTTOM);
   m_mb_contextmenu1.XSize(160);
//--- Add items to the context menu
   for(int i=0; i<CONTEXTMENU_ITEMS1; i++)
      m_mb_contextmenu1.AddItem(items_text[i],items_bmp_on[i],items_bmp_off[i],items_type[i]);
//--- Separation line after the second item
   m_mb_contextmenu1.AddSeparateLine(1);
//--- Deactivate the second item
   m_mb_contextmenu1.ItemPointerByIndex(1).ItemState(false);
//--- Create a context menu
   if(!m_mb_contextmenu1.CreateContextMenu(m_chart_id,m_subwin))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_mb_contextmenu1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates a context menu                                           |
//+------------------------------------------------------------------+
bool CProgram::CreateMBContextMenu2(void)
  {
//--- Six items in a context menu
#define CONTEXTMENU_ITEMS2 3
//--- Store the window pointer
   m_mb_contextmenu2.WindowPointer(m_window1);
//--- Store the pointer to the previous node
   m_mb_contextmenu2.PrevNodePointer(m_menubar.ItemPointerByIndex(1));
//--- Attach the context menu to the specified menu item
   m_menubar.AddContextMenuPointer(1,m_mb_contextmenu2);
//--- Array of the menu item names
   string items_text[CONTEXTMENU_ITEMS2]=
     {
      "ContextMenu 2 Item 1",
      "ContextMenu 2 Item 2",
      "ContextMenu 2 Item 3"
     };
//--- Array of icons for the available mode
   string items_bmp_on[CONTEXTMENU_ITEMS2]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp",
      ""
     };
//--- Array of icon for the blocked mode
   string items_bmp_off[CONTEXTMENU_ITEMS2]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins_gray.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart_gray.bmp",
      "Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_black.bmp"
     };
//--- Array of item types
   ENUM_TYPE_MENU_ITEM items_type[CONTEXTMENU_ITEMS2]=
     {
      MI_SIMPLE,
      MI_SIMPLE,
      MI_CHECKBOX
     };
//--- Set properties before creation
   m_mb_contextmenu2.FixSide(FIX_BOTTOM);
   m_mb_contextmenu2.XSize(160);
//--- Add items to the context menu
   for(int i=0; i<CONTEXTMENU_ITEMS2; i++)
      m_mb_contextmenu2.AddItem(items_text[i],items_bmp_on[i],items_bmp_off[i],items_type[i]);
//--- Separation line after the second item
   m_mb_contextmenu2.AddSeparateLine(1);
//--- Create a context menu
   if(!m_mb_contextmenu2.CreateContextMenu(m_chart_id,m_subwin))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_mb_contextmenu2);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates a context menu                                           |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\RArrow_black.bmp"
//---
bool CProgram::CreateMBContextMenu3(void)
  {
//--- Five items in the context menu
#define CONTEXTMENU_ITEMS3 5
//--- Store the window pointer
   m_mb_contextmenu3.WindowPointer(m_window1);
//--- Store the pointer to the previous node
   m_mb_contextmenu3.PrevNodePointer(m_menubar.ItemPointerByIndex(2));
//--- Attach the context menu to the specified menu item
   m_menubar.AddContextMenuPointer(2,m_mb_contextmenu3);
//--- Array of the menu item names
   string items_text[CONTEXTMENU_ITEMS3]=
     {
      "ContextMenu 3 Item 1",
      "ContextMenu 3 Item 2",
      "ContextMenu 3 Item 3...",
      "ContextMenu 3 Item 4",
      "ContextMenu 3 Item 5"
     };
//--- Array of icons for the available mode
   string items_bmp_on[CONTEXTMENU_ITEMS3]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart.bmp",
      "",""
     };
//--- Array of icon for the blocked mode 
   string items_bmp_off[CONTEXTMENU_ITEMS3]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins_gray.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart_gray.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart_gray.bmp",
      "Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_black.bmp",
      "Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_black.bmp"
     };
//--- Array of item types
   ENUM_TYPE_MENU_ITEM items_type[CONTEXTMENU_ITEMS3]=
     {
      MI_SIMPLE,
      MI_HAS_CONTEXT_MENU,
      MI_SIMPLE,
      MI_CHECKBOX,
      MI_CHECKBOX
     };
//--- Set properties before creation
   m_mb_contextmenu3.FixSide(FIX_BOTTOM);
   m_mb_contextmenu3.XSize(160);
   m_mb_contextmenu3.RightArrowFileOff("Images\\EasyAndFastGUI\\Controls\\RArrow_black.bmp");
//--- Add items to the context menu
   for(int i=0; i<CONTEXTMENU_ITEMS3; i++)
      m_mb_contextmenu3.AddItem(items_text[i],items_bmp_on[i],items_bmp_off[i],items_type[i]);
//--- Separation line after the third item
   m_mb_contextmenu3.AddSeparateLine(2);
//--- Create a context menu
   if(!m_mb_contextmenu3.CreateContextMenu(m_chart_id,m_subwin))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_mb_contextmenu3);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates a context menu                                           |
//+------------------------------------------------------------------+
bool CProgram::CreateMBContextMenu4(void)
  {
//--- Six items in a context menu
#define CONTEXTMENU_ITEMS4 3
//--- Store the window pointer
   m_mb_contextmenu4.WindowPointer(m_window1);
//--- Store the pointer to the previous node
   m_mb_contextmenu4.PrevNodePointer(m_mb_contextmenu3.ItemPointerByIndex(1));
//--- Array of the menu item names
   string items_text[CONTEXTMENU_ITEMS4]=
     {
      "ContextMenu 4 Item 1",
      "ContextMenu 4 Item 2",
      "ContextMenu 4 Item 3"
     };
//--- Array of icons for the available mode
   string items_bmp_on[CONTEXTMENU_ITEMS4]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp",
      ""
     };
//--- Array of icon for the blocked mode
   string items_bmp_off[CONTEXTMENU_ITEMS4]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins_gray.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart_gray.bmp",
      "Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_black.bmp"
     };
//--- Array of item types
   ENUM_TYPE_MENU_ITEM items_type[CONTEXTMENU_ITEMS4]=
     {
      MI_SIMPLE,
      MI_SIMPLE,
      MI_CHECKBOX
     };
//--- Set properties before creation
   m_mb_contextmenu4.XSize(160);
//--- Add items to the context menu
   for(int i=0; i<CONTEXTMENU_ITEMS4; i++)
      m_mb_contextmenu4.AddItem(items_text[i],items_bmp_on[i],items_bmp_off[i],items_type[i]);
//--- Separation line after the second item
   m_mb_contextmenu4.AddSeparateLine(1);
//--- Create a context menu
   if(!m_mb_contextmenu4.CreateContextMenu(m_chart_id,m_subwin))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_mb_contextmenu4);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates the status bar                                           |
//+------------------------------------------------------------------+
bool CProgram::CreateStatusBar(void)
  {
#define STATUS_LABELS_TOTAL 2
//--- Store the window pointer
   m_status_bar.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+STATUSBAR1_GAP_X;
   int y=m_window1.Y()+STATUSBAR1_GAP_Y;
//--- Width
   int width[]={0,110};
//--- Set properties before creation
   m_status_bar.YSize(24);
   m_status_bar.AutoXResizeMode(true);
   m_status_bar.AutoXResizeRightOffset(1);
//--- Specify the number of parts and set their properties
   for(int i=0; i<STATUS_LABELS_TOTAL; i++)
      m_status_bar.AddItem(width[i]);
//--- Create control
   if(!m_status_bar.CreateStatusBar(m_chart_id,m_subwin,x,y))
      return(false);
//--- Set text in the first item of the status bar
   m_status_bar.ValueToItem(0,"For Help, press F1");
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_status_bar);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create calendar 1                                                |
//+------------------------------------------------------------------+
bool CProgram::CreateCalendar1(void)
  {
//--- Pass the panel object
   m_calendar1.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+CALENDAR1_GAP_X;
   int y=m_window1.Y()+CALENDAR1_GAP_Y;
//--- Create control
   if(!m_calendar1.CreateCalendar(m_chart_id,m_subwin,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_calendar1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create calendar 2                                                |
//+------------------------------------------------------------------+
bool CProgram::CreateCalendar2(void)
  {
//--- Pass the panel object
   m_calendar2.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+CALENDAR2_GAP_X;
   int y=m_window1.Y()+CALENDAR2_GAP_Y;
//--- Create control
   if(!m_calendar2.CreateCalendar(m_chart_id,m_subwin,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_calendar2);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create drop down calendar 1                                      |
//+------------------------------------------------------------------+
bool CProgram::CreateDropCalendar1(const string text)
  {
//--- Pass the panel object
   m_drop_calendar1.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+DROPCALENDAR1_GAP_X;
   int y=m_window1.Y()+DROPCALENDAR1_GAP_Y;
//--- Set properties before creation
   m_drop_calendar1.XSize(145);
   m_drop_calendar1.YSize(20);
//--- Create control
   if(!m_drop_calendar1.CreateDropCalendar(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_drop_calendar1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create drop down calendar 2                                      |
//+------------------------------------------------------------------+
bool CProgram::CreateDropCalendar2(const string text)
  {
//--- Pass the panel object
   m_drop_calendar2.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+DROPCALENDAR2_GAP_X;
   int y=m_window1.Y()+DROPCALENDAR2_GAP_Y;
//--- Set properties before creation
   m_drop_calendar2.XSize(150);
   m_drop_calendar2.YSize(20);
//--- Create control
   if(!m_drop_calendar2.CreateDropCalendar(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_drop_calendar2);
   return(true);
  }
//+------------------------------------------------------------------+
