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
   //--- Icon buttons
   CIconButton       m_icon_button1;
   CTooltip          m_tooltip1;
   //---
   CIconButton       m_icon_button2;
   CTooltip          m_tooltip2;
   //---
   CIconButton       m_icon_button3;
   CTooltip          m_tooltip3;
   //---
   CIconButton       m_icon_button4;
   CTooltip          m_tooltip4;
   //---
   CIconButton       m_icon_button5;
   CTooltip          m_tooltip5;
   //--- Status Bar
   CStatusBar        m_status_bar;

   //--- Form 2
   CWindow           m_window2;
   //--- Icon buttons
   CIconButton       m_icon_button6;
   CIconButton       m_icon_button7;
   CIconButton       m_icon_button8;

   //--- Form 3
   CWindow           m_window3;
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
#define MENUBAR_GAP_X    (1)
#define MENUBAR_GAP_Y    (20)
   bool              CreateMenuBar(void);
   bool              CreateMBContextMenu1(void);
   bool              CreateMBContextMenu2(void);
   bool              CreateMBContextMenu3(void);
   bool              CreateMBContextMenu4(void);
   //--- Status Bar
#define STATUSBAR1_GAP_X         (1)
#define STATUSBAR1_GAP_Y         (175)
   bool              CreateStatusBar(void);
   //--- Icon buttons
#define ICONBUTTON1_GAP_X        (7)
#define ICONBUTTON1_GAP_Y        (50)
   bool              CreateIconButton1(const string text);
   bool              CreateTooltip1(void);
   //---
#define ICONBUTTON2_GAP_X        (128)
#define ICONBUTTON2_GAP_Y        (50)
   bool              CreateIconButton2(const string text);
   bool              CreateTooltip2(void);
   //---
#define ICONBUTTON3_GAP_X        (7)
#define ICONBUTTON3_GAP_Y        (75)
   bool              CreateIconButton3(const string text);
   bool              CreateTooltip3(void);
   //---
#define ICONBUTTON4_GAP_X        (87)
#define ICONBUTTON4_GAP_Y        (75)
   bool              CreateIconButton4(const string text);
   bool              CreateTooltip4(void);
   //---
#define ICONBUTTON5_GAP_X        (168)
#define ICONBUTTON5_GAP_Y        (75)
   bool              CreateIconButton5(const string text);
   bool              CreateTooltip5(void);

   //--- Form 2
   bool              CreateWindow2(const string text);
   //--- Icon buttons
#define ICONBUTTON6_GAP_X        (7)
#define ICONBUTTON6_GAP_Y        (25)
   bool              CreateIconButton6(const string text);
#define ICONBUTTON7_GAP_X        (7)
#define ICONBUTTON7_GAP_Y        (50)
   bool              CreateIconButton7(const string text);
#define ICONBUTTON8_GAP_X        (7)
#define ICONBUTTON8_GAP_Y        (75)
   bool              CreateIconButton8(const string text);

   //--- Form 3
   bool              CreateWindow3(const string text);
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
//---
   count=0;
   m_status_bar.ValueToItem(1,TimeToString(TimeLocal(),TIME_DATE|TIME_SECONDS));
   m_chart.Redraw();
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
//--- The button press event
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_BUTTON)
     {
      ::Print(__FUNCTION__," > id: ",id,"; lparam: ",lparam,"; dparam: ",dparam,"; sparam: ",sparam);
      //--- If the text matches
      if(sparam==m_icon_button1.Text())
        {
         //--- Show window 2
         m_window2.Show();
        }
      //--- If the text matches
      if(sparam==m_icon_button2.Text())
        {
         if(m_icon_button2.IsPressed())
           {
            m_icon_button1.ButtonState(true);
            m_icon_button4.ButtonState(true);
           }
         else
           {
            m_icon_button1.ButtonState(false);
            m_icon_button4.ButtonState(false);
           }
        }
      //--- If the text matches
      if(sparam==m_icon_button6.Text())
        {
         //--- Show window 3
         m_window3.Show();
        }
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
//--- Icon buttons
   if(!CreateIconButton1("Icon Button 1..."))
      return(false);
   if(!CreateIconButton2("Icon Button 2"))
      return(false);
   if(!CreateIconButton3("Icon Button 3"))
      return(false);
   if(!CreateIconButton4("Icon Button 4"))
      return(false);
   if(!CreateIconButton5("Icon Button 5"))
      return(false);

//--- Creating form 2 for controls
   if(!CreateWindow2("Icon Button 1"))
      return(false);
//--- Icon buttons
   if(!CreateIconButton6("Icon Button 6..."))
      return(false);
   if(!CreateIconButton7("Icon Button 7"))
      return(false);
   if(!CreateIconButton8("Icon Button 8"))
      return(false);

//--- Creating form 3 for controls
   if(!CreateWindow3("Icon Button 6"))
      return(false);

//--- Tooltips
   if(!CreateTooltip1())
      return(false);
   if(!CreateTooltip2())
      return(false);
   if(!CreateTooltip3())
      return(false);
   if(!CreateTooltip4())
      return(false);
   if(!CreateTooltip5())
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
   m_window1.XSize(251);
   m_window1.YSize(200);
   m_window1.Movable(true);
   m_window1.UseRollButton();
   m_window1.UseTooltipsButton();
//--- Creating the form
   if(!m_window1.CreateWindow(m_chart_id,m_subwin,caption_text,x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates form 2 for controls                                      |
//+------------------------------------------------------------------+
bool CProgram::CreateWindow2(const string caption_text)
  {
//--- Add the window pointer to the window array
   CWndContainer::AddWindow(m_window2);
//--- Coordinates
   int x=(m_window2.X()>0) ? m_window2.X() : 1;
   int y=(m_window2.Y()>0) ? m_window2.Y() : 20;
//--- Properties
   m_window2.Movable(true);
   m_window2.WindowType(W_DIALOG);
   m_window2.XSize(160);
   m_window2.YSize(160);
   m_window2.IconFile("Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp");
//--- Creating the form
   if(!m_window2.CreateWindow(m_chart_id,m_subwin,caption_text,x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates form 3 for controls                                      |
//+------------------------------------------------------------------+
bool CProgram::CreateWindow3(const string caption_text)
  {
//--- Add the window pointer to the window array
   CWndContainer::AddWindow(m_window3);
//--- Coordinates
   int x=(m_window3.X()>0) ? m_window3.X() : 1;
   int y=(m_window3.Y()>0) ? m_window3.Y() : 20;
//--- Properties
   m_window3.Movable(true);
   m_window3.WindowType(W_DIALOG);
   m_window3.XSize(160);
   m_window3.YSize(200);
   m_window3.IconFile("Images\\EasyAndFastGUI\\Icons\\bmp16\\script.bmp");
//--- Creating the form
   if(!m_window3.CreateWindow(m_chart_id,m_subwin,caption_text,x,y))
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
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_status_bar);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates icon button 1                                            |
//+------------------------------------------------------------------+
bool CProgram::CreateIconButton1(const string button_text)
  {
//--- Store the window pointer
   m_icon_button1.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+ICONBUTTON1_GAP_X;
   int y=m_window1.Y()+ICONBUTTON1_GAP_Y;
//--- Set properties before creation
   m_icon_button1.TwoState(false);
   m_icon_button1.ButtonXSize(116);
   m_icon_button1.ButtonYSize(22);
   m_icon_button1.IconFileOn("Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp");
   m_icon_button1.IconFileOff("Images\\EasyAndFastGUI\\Icons\\bmp16\\coins_gray.bmp");
//--- Create control
   if(!m_icon_button1.CreateIconButton(m_chart_id,m_subwin,button_text,x,y))
      return(false);
//--- Block the button
   m_icon_button1.ButtonState(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_icon_button1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates tooltip 1                                                |
//+------------------------------------------------------------------+
bool CProgram::CreateTooltip1(void)
  {
#define TOOLTIP1_LINES_TOTAL 2
//--- Store the window pointer
   m_tooltip1.WindowPointer(m_window1);
//--- Store the element pointer
   m_tooltip1.ElementPointer(m_icon_button1);
//--- Array with the tooltip text
   string text[]=
     {
      "Control \"Icon button\" (1).",
      "Opens dialog box (2)."
     };
//--- Set properties before creation
   m_tooltip1.Header("Icon Button 1");
   m_tooltip1.XSize(250);
   m_tooltip1.YSize(70);
//--- Add text line by line
   for(int i=0; i<TOOLTIP1_LINES_TOTAL; i++)
      m_tooltip1.AddString(text[i]);
//--- Create control
   if(!m_tooltip1.CreateTooltip(m_chart_id,m_subwin))
      return(false);
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_tooltip1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates icon button 2                                            |
//+------------------------------------------------------------------+
bool CProgram::CreateIconButton2(const string button_text)
  {
//--- Store the window pointer
   m_icon_button2.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+ICONBUTTON2_GAP_X;
   int y=m_window1.Y()+ICONBUTTON2_GAP_Y;
//--- Set properties before creation
   m_icon_button2.TwoState(true);
   m_icon_button2.ButtonXSize(116);
   m_icon_button2.ButtonYSize(22);
   m_icon_button2.IconFileOn("Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp");
   m_icon_button2.IconFileOff("Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart_gray.bmp");
//--- Create control
   if(!m_icon_button2.CreateIconButton(m_chart_id,m_subwin,button_text,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_icon_button2);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates tooltip 2                                                |
//+------------------------------------------------------------------+
bool CProgram::CreateTooltip2(void)
  {
#define TOOLTIP2_LINES_TOTAL 1
//--- Store the window pointer
   m_tooltip2.WindowPointer(m_window1);
//--- Store the element pointer
   m_tooltip2.ElementPointer(m_icon_button2);
//--- Array with the tooltip text
   string text[]=
     {
      "Control \"Icon button\" (2)"
     };
//--- Set properties before creation
   m_tooltip2.Header("Icon Button 2");
   m_tooltip2.XSize(250);
   m_tooltip2.YSize(50);
//--- Add text line by line
   for(int i=0; i<TOOLTIP2_LINES_TOTAL; i++)
      m_tooltip2.AddString(text[i]);
//--- Create control
   if(!m_tooltip2.CreateTooltip(m_chart_id,m_subwin))
      return(false);
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_tooltip2);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates icon button 3                                            |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp64\\pie_chart.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp64\\pie_chart_gray.bmp"
//---
bool CProgram::CreateIconButton3(const string button_text)
  {
//--- Store the window pointer
   m_icon_button3.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+ICONBUTTON3_GAP_X;
   int y=m_window1.Y()+ICONBUTTON3_GAP_Y;
//--- Set properties before creation
   m_icon_button3.TwoState(true);
   m_icon_button3.ButtonXSize(75);
   m_icon_button3.ButtonYSize(87);
   m_icon_button3.LabelXGap(6);
   m_icon_button3.LabelYGap(69);
   m_icon_button3.IconXGap(6);
   m_icon_button3.IconYGap(3);
   m_icon_button3.IconFileOn("Images\\EasyAndFastGUI\\Icons\\bmp64\\pie_chart.bmp");
   m_icon_button3.IconFileOff("Images\\EasyAndFastGUI\\Icons\\bmp64\\pie_chart_gray.bmp");
//--- Create control
   if(!m_icon_button3.CreateIconButton(m_chart_id,m_subwin,button_text,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_icon_button3);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates tooltip 3                                                |
//+------------------------------------------------------------------+
bool CProgram::CreateTooltip3(void)
  {
#define TOOLTIP3_LINES_TOTAL 1
//--- Store the window pointer
   m_tooltip3.WindowPointer(m_window1);
//--- Store the element pointer
   m_tooltip3.ElementPointer(m_icon_button3);
//--- Array with the tooltip text
   string text[]=
     {
      "Control \"Icon button\" (3)"
     };
//--- Set properties before creation
   m_tooltip3.Header("Icon Button 3");
   m_tooltip3.XSize(250);
   m_tooltip3.YSize(50);
//--- Add text line by line
   for(int i=0; i<TOOLTIP3_LINES_TOTAL; i++)
      m_tooltip3.AddString(text[i]);
//--- Create control
   if(!m_tooltip3.CreateTooltip(m_chart_id,m_subwin))
      return(false);
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_tooltip3);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates icon button 4                                            |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp64\\safe.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp64\\safe_gray.bmp"
//---
bool CProgram::CreateIconButton4(const string button_text)
  {
//--- Store the window pointer
   m_icon_button4.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+ICONBUTTON4_GAP_X;
   int y=m_window1.Y()+ICONBUTTON4_GAP_Y;
//--- Set properties before creation
   m_icon_button4.ButtonXSize(76);
   m_icon_button4.ButtonYSize(87);
   m_icon_button4.LabelXGap(6);
   m_icon_button4.LabelYGap(69);
   m_icon_button4.IconXGap(6);
   m_icon_button4.IconYGap(3);
   m_icon_button4.IconFileOn("Images\\EasyAndFastGUI\\Icons\\bmp64\\safe.bmp");
   m_icon_button4.IconFileOff("Images\\EasyAndFastGUI\\Icons\\bmp64\\safe_gray.bmp");
//--- Create control
   if(!m_icon_button4.CreateIconButton(m_chart_id,m_subwin,button_text,x,y))
      return(false);
//--- Block the button
   m_icon_button4.ButtonState(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_icon_button4);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates tooltip 4                                                |
//+------------------------------------------------------------------+
bool CProgram::CreateTooltip4(void)
  {
#define TOOLTIP4_LINES_TOTAL 1
//--- Store the window pointer
   m_tooltip4.WindowPointer(m_window1);
//--- Store the element pointer
   m_tooltip4.ElementPointer(m_icon_button4);
//--- Array with the tooltip text
   string text[]=
     {
      "Control \"Icon button\" (4)"
     };
//--- Set properties before creation
   m_tooltip4.Header("Icon Button 4");
   m_tooltip4.XSize(250);
   m_tooltip4.YSize(50);
//--- Add text line by line
   for(int i=0; i<TOOLTIP4_LINES_TOTAL; i++)
      m_tooltip4.AddString(text[i]);
//--- Create control
   if(!m_tooltip4.CreateTooltip(m_chart_id,m_subwin))
      return(false);
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_tooltip4);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates icon button 5                                            |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp64\\gold.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp64\\gold_gray.bmp"
//---
bool CProgram::CreateIconButton5(const string button_text)
  {
//--- Store the window pointer
   m_icon_button5.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+ICONBUTTON5_GAP_X;
   int y=m_window1.Y()+ICONBUTTON5_GAP_Y;
//--- Set properties before creation
   m_icon_button5.ButtonXSize(76);
   m_icon_button5.ButtonYSize(87);
   m_icon_button5.LabelXGap(6);
   m_icon_button5.LabelYGap(69);
   m_icon_button5.IconXGap(6);
   m_icon_button5.IconYGap(3);
   m_icon_button5.IconFileOn("Images\\EasyAndFastGUI\\Icons\\bmp64\\gold.bmp");
   m_icon_button5.IconFileOff("Images\\EasyAndFastGUI\\Icons\\bmp64\\gold_gray.bmp");
//--- Create control
   if(!m_icon_button5.CreateIconButton(m_chart_id,m_subwin,button_text,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_icon_button5);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates tooltip 5                                                |
//+------------------------------------------------------------------+
bool CProgram::CreateTooltip5(void)
  {
#define TOOLTIP5_LINES_TOTAL 3
//--- Store the window pointer
   m_tooltip5.WindowPointer(m_window1);
//--- Store the element pointer
   m_tooltip5.ElementPointer(m_icon_button5);
//--- Array with the tooltip text
   string text[]=
     {
      "Control \"Icon button\" (5).",
      "This is the second line of the tooltip.",
      "This is the third line of the tooltip."
     };
//--- Set properties before creation
   m_tooltip5.Header("Icon Button 5");
   m_tooltip5.XSize(250);
   m_tooltip5.YSize(80);
//--- Add text line by line
   for(int i=0; i<TOOLTIP5_LINES_TOTAL; i++)
      m_tooltip5.AddString(text[i]);
//--- Create control
   if(!m_tooltip5.CreateTooltip(m_chart_id,m_subwin))
      return(false);
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_tooltip5);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates icon button 6                                            |
//+------------------------------------------------------------------+
bool CProgram::CreateIconButton6(const string button_text)
  {
//--- Store the window pointer
   m_icon_button6.WindowPointer(m_window2);
//--- Coordinates
   int x=m_window2.X()+ICONBUTTON6_GAP_X;
   int y=m_window2.Y()+ICONBUTTON6_GAP_Y;
//--- Set properties before creation
   m_icon_button6.TwoState(false);
   m_icon_button6.ButtonXSize(146);
   m_icon_button6.ButtonYSize(22);
   m_icon_button6.IconFileOn("Images\\EasyAndFastGUI\\Icons\\bmp16\\script.bmp");
   m_icon_button6.IconFileOff("Images\\EasyAndFastGUI\\Icons\\bmp16\\script_gray.bmp");
//--- Create control
   if(!m_icon_button6.CreateIconButton(m_chart_id,m_subwin,button_text,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(1,m_icon_button6);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates icon button 7                                            |
//+------------------------------------------------------------------+
bool CProgram::CreateIconButton7(const string button_text)
  {
//--- Store the window pointer
   m_icon_button7.WindowPointer(m_window2);
//--- Coordinates
   int x=m_window2.X()+ICONBUTTON7_GAP_X;
   int y=m_window2.Y()+ICONBUTTON7_GAP_Y;
//--- Set properties before creation
   m_icon_button7.TwoState(false);
   m_icon_button7.ButtonXSize(146);
   m_icon_button7.ButtonYSize(22);
   m_icon_button7.IconFileOn("Images\\EasyAndFastGUI\\Icons\\bmp16\\pie_chart.bmp");
   m_icon_button7.IconFileOff("Images\\EasyAndFastGUI\\Icons\\bmp16\\pie_chart_gray.bmp");
//--- Create control
   if(!m_icon_button7.CreateIconButton(m_chart_id,m_subwin,button_text,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(1,m_icon_button7);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates icon button 8                                            |
//+------------------------------------------------------------------+
bool CProgram::CreateIconButton8(const string button_text)
  {
//--- Store the window pointer
   m_icon_button8.WindowPointer(m_window2);
//--- Coordinates
   int x=m_window2.X()+ICONBUTTON8_GAP_X;
   int y=m_window2.Y()+ICONBUTTON8_GAP_Y;
//--- Set properties before creation
   m_icon_button8.TwoState(false);
   m_icon_button8.ButtonXSize(146);
   m_icon_button8.ButtonYSize(22);
   m_icon_button8.IconFileOn("Images\\EasyAndFastGUI\\Icons\\bmp16\\calculator.bmp");
   m_icon_button8.IconFileOff("Images\\EasyAndFastGUI\\Icons\\bmp16\\calculator_gray.bmp");
//--- Create control
   if(!m_icon_button8.CreateIconButton(m_chart_id,m_subwin,button_text,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(1,m_icon_button8);
   return(true);
  }
//+------------------------------------------------------------------+
