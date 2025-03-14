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
   //--- Form
   CWindow           m_window;
   //--- Main menu and its context menus
   CMenuBar          m_menubar;
   CContextMenu      m_mb_contextmenu1;
   CContextMenu      m_mb_contextmenu2;
   CContextMenu      m_mb_contextmenu3;
   CContextMenu      m_mb_contextmenu4;
   //--- Simple buttons
   CSimpleButton     m_simple_button1;
   CSimpleButton     m_simple_button2;
   CSimpleButton     m_simple_button3;
   //--- Icon buttons
   CIconButton       m_icon_button1;
   CIconButton       m_icon_button2;
   CIconButton       m_icon_button3;
   CIconButton       m_icon_button4;
   CIconButton       m_icon_button5;
   //--- Split buttons
   CSplitButton      m_split_button1;
   CSplitButton      m_split_button2;
   CSplitButton      m_split_button3;
   CSplitButton      m_split_button4;
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
   //--- Form
   bool              CreateWindow(const string text);
   //--- Main menu and its context menus
#define MENUBAR_GAP_X    (1)
#define MENUBAR_GAP_Y    (20)
   bool              CreateMenuBar(void);
   bool              CreateMBContextMenu1(void);
   bool              CreateMBContextMenu2(void);
   bool              CreateMBContextMenu3(void);
   bool              CreateMBContextMenu4(void);
   //--- Simple buttons
#define BUTTON1_GAP_X            (7)
#define BUTTON1_GAP_Y            (50)
   bool              CreateSimpleButton1(const string text);
#define BUTTON2_GAP_X            (128)
#define BUTTON2_GAP_Y            (50)
   bool              CreateSimpleButton2(const string text);
#define BUTTON3_GAP_X            (7)
#define BUTTON3_GAP_Y            (75)
   bool              CreateSimpleButton3(const string text);
   //--- Icon buttons
#define ICONBUTTON1_GAP_X        (7)
#define ICONBUTTON1_GAP_Y        (105)
   bool              CreateIconButton1(const string text);
#define ICONBUTTON2_GAP_X        (128)
#define ICONBUTTON2_GAP_Y        (105)
   bool              CreateIconButton2(const string text);
#define ICONBUTTON3_GAP_X        (7)
#define ICONBUTTON3_GAP_Y        (130)
   bool              CreateIconButton3(const string text);
#define ICONBUTTON4_GAP_X        (87)
#define ICONBUTTON4_GAP_Y        (130)
   bool              CreateIconButton4(const string text);
#define ICONBUTTON5_GAP_X        (168)
#define ICONBUTTON5_GAP_Y        (130)
   bool              CreateIconButton5(const string text);
   //--- Split buttons
#define SPLITBUTTON1_GAP_X       (7)
#define SPLITBUTTON1_GAP_Y       (225)
   bool              CreateSplitButton1(const string text);
#define SPLITBUTTON2_GAP_X       (128)
#define SPLITBUTTON2_GAP_Y       (225)
   bool              CreateSplitButton2(const string text);
#define SPLITBUTTON3_GAP_X       (7)
#define SPLITBUTTON3_GAP_Y       (250)
   bool              CreateSplitButton3(const string text);
#define SPLITBUTTON4_GAP_X       (128)
#define SPLITBUTTON4_GAP_Y       (250)
   bool              CreateSplitButton4(const string text);
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
      //---
      if(sparam==m_simple_button3.Text())
        {
         if(m_simple_button3.IsPressed())
            m_simple_button1.ButtonState(false);
         else
            m_simple_button1.ButtonState(true);
        }
      //---
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
     }
  }
//+------------------------------------------------------------------+
//| Create indicator panel                                           |
//+------------------------------------------------------------------+
bool CProgram::CreateIndicatorPanel(void)
  {
//--- Creating form 1 for controls
   if(!CreateWindow("INDICATOR PANEL"))
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
//--- Simple buttons
   if(!CreateSimpleButton1("Simple Button 1"))
      return(false);
   if(!CreateSimpleButton2("Simple Button 2"))
      return(false);
   if(!CreateSimpleButton3("Simple Button 3"))
      return(false);
//--- Icon buttons
   if(!CreateIconButton1("Icon Button 1"))
      return(false);
   if(!CreateIconButton2("Icon Button 2"))
      return(false);
   if(!CreateIconButton3("Icon Button 3"))
      return(false);
   if(!CreateIconButton4("Icon Button 4"))
      return(false);
   if(!CreateIconButton5("Icon Button 5"))
      return(false);
//--- Split buttons
   if(!CreateSplitButton1("Split Button 1"))
      return(false);
   if(!CreateSplitButton2("Split Button 2"))
      return(false);
   if(!CreateSplitButton3("Split Button 3"))
      return(false);
   if(!CreateSplitButton4("Split Button 4"))
      return(false);
//--- Redrawing the chart
   m_chart.Redraw();
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates a form for controls                                      |
//+------------------------------------------------------------------+
bool CProgram::CreateWindow(const string caption_text)
  {
//--- Add the window pointer to the window array
   CWndContainer::AddWindow(m_window);
//--- Coordinates
   int x=1;
   int y=20;
//--- Properties
   m_window.XSize(251);
   m_window.YSize(285);
   m_window.Movable(true);
   m_window.UseRollButton();
//--- Creating the form
   if(!m_window.CreateWindow(m_chart_id,m_subwin,caption_text,x,y))
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
   m_menubar.WindowPointer(m_window);
//--- Coordinates
   int x=m_window.X()+MENUBAR_GAP_X;
   int y=m_window.Y()+MENUBAR_GAP_Y;
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
   m_mb_contextmenu1.WindowPointer(m_window);
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
   m_mb_contextmenu2.WindowPointer(m_window);
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
   m_mb_contextmenu3.WindowPointer(m_window);
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
   m_mb_contextmenu4.WindowPointer(m_window);
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
//| Creates simple button 1                                          |
//+------------------------------------------------------------------+
bool CProgram::CreateSimpleButton1(string button_text)
  {
//--- Pass the panel object
   m_simple_button1.WindowPointer(m_window);
//--- Coordinates
   int x=m_window.X()+BUTTON1_GAP_X;
   int y=m_window.Y()+BUTTON1_GAP_Y;
//--- Set properties before creation
   m_simple_button1.ButtonXSize(116);
   m_simple_button1.BackColor(C'255,140,140');
   m_simple_button1.BackColorHover(C'255,180,180');
   m_simple_button1.BackColorPressed(C'255,120,120');
//--- Creating a button
   if(!m_simple_button1.CreateSimpleButton(m_chart_id,m_subwin,button_text,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_simple_button1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates simple button 2                                          |
//+------------------------------------------------------------------+
bool CProgram::CreateSimpleButton2(string button_text)
  {
//--- Pass the panel object
   m_simple_button2.WindowPointer(m_window);
//--- Coordinates
   int x=m_window.X()+BUTTON2_GAP_X;
   int y=m_window.Y()+BUTTON2_GAP_Y;
//--- Set properties before creation
   m_simple_button2.ButtonXSize(116);
   m_simple_button2.BackColor(C'140,200,240');
   m_simple_button2.BackColorHover(C'180,220,255');
   m_simple_button2.BackColorPressed(C'130,180,210');
//--- Creating a button
   if(!m_simple_button2.CreateSimpleButton(m_chart_id,m_subwin,button_text,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_simple_button2);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates simple button 3                                          |
//+------------------------------------------------------------------+
bool CProgram::CreateSimpleButton3(string button_text)
  {
//--- Pass the panel object
   m_simple_button3.WindowPointer(m_window);
//--- Coordinates
   int x=m_window.X()+BUTTON3_GAP_X;
   int y=m_window.Y()+BUTTON3_GAP_Y;
//--- Set properties before creation
   m_simple_button3.TwoState(true);
   m_simple_button3.ButtonXSize(237);
//--- Creating a button
   if(!m_simple_button3.CreateSimpleButton(m_chart_id,m_subwin,button_text,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_simple_button3);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates icon button 1                                            |
//+------------------------------------------------------------------+
bool CProgram::CreateIconButton1(const string button_text)
  {
//--- Pass the panel object
   m_icon_button1.WindowPointer(m_window);
//--- Coordinates
   int x=m_window.X()+ICONBUTTON1_GAP_X;
   int y=m_window.Y()+ICONBUTTON1_GAP_Y;
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
//| Creates icon button 2                                            |
//+------------------------------------------------------------------+
bool CProgram::CreateIconButton2(const string button_text)
  {
//--- Pass the panel object
   m_icon_button2.WindowPointer(m_window);
//--- Coordinates
   int x=m_window.X()+ICONBUTTON2_GAP_X;
   int y=m_window.Y()+ICONBUTTON2_GAP_Y;
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
//| Creates icon button 3                                            |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp64\\pie_chart.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp64\\pie_chart_gray.bmp"
//---
bool CProgram::CreateIconButton3(const string button_text)
  {
//--- Pass the panel object
   m_icon_button3.WindowPointer(m_window);
//--- Coordinates
   int x=m_window.X()+ICONBUTTON3_GAP_X;
   int y=m_window.Y()+ICONBUTTON3_GAP_Y;
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
//| Creates icon button 4                                            |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp64\\safe.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp64\\safe_gray.bmp"
//---
bool CProgram::CreateIconButton4(const string button_text)
  {
//--- Pass the panel object
   m_icon_button4.WindowPointer(m_window);
//--- Coordinates
   int x=m_window.X()+ICONBUTTON4_GAP_X;
   int y=m_window.Y()+ICONBUTTON4_GAP_Y;
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
//| Creates icon button 5                                            |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp64\\gold.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp64\\gold_gray.bmp"
//---
bool CProgram::CreateIconButton5(const string button_text)
  {
//--- Pass the panel object
   m_icon_button5.WindowPointer(m_window);
//--- Coordinates
   int x=m_window.X()+ICONBUTTON5_GAP_X;
   int y=m_window.Y()+ICONBUTTON5_GAP_Y;
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
//| Creates split button 1                                           |
//+------------------------------------------------------------------+
bool CProgram::CreateSplitButton1(const string button_text)
  {
//--- Three items in the context menu
#define CONTEXTMENU_ITEMS5 3
//--- Pass the panel object
   m_split_button1.WindowPointer(m_window);
//--- Coordinates
   int x=m_window.X()+SPLITBUTTON1_GAP_X;
   int y=m_window.Y()+SPLITBUTTON1_GAP_Y;
//--- Array of the menu item names
   string items_text[]=
     {
      "Item 1",
      "Item 2",
      "Item 3"
     };
//--- Array of icons for the available mode
   string items_bmp_on[]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart.bmp"
     };
//--- Array of icon for the blocked mode 
   string items_bmp_off[]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins_gray.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart_gray.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart_gray.bmp"
     };
//--- Set properties before creation
   m_split_button1.ButtonXSize(116);
   m_split_button1.ButtonYSize(22);
   m_split_button1.DropButtonXSize(16);
   m_split_button1.IconFileOn("Images\\EasyAndFastGUI\\Icons\\bmp16\\script.bmp");
   m_split_button1.IconFileOff("Images\\EasyAndFastGUI\\Icons\\bmp16\\script_gray.bmp");
//--- Get the pointer to the context menu of the button
   CContextMenu *cm=m_split_button1.GetContextMenuPointer();
//--- Add items to the context menu
   for(int i=0; i<CONTEXTMENU_ITEMS5; i++)
      m_split_button1.AddItem(items_text[i],items_bmp_on[i],items_bmp_off[i]);
//--- Separation line after the first menu item
   m_split_button1.AddSeparateLine(1);
//--- Create control
   if(!m_split_button1.CreateSplitButton(m_chart_id,m_subwin,button_text,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_split_button1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates split button 2                                           |
//+------------------------------------------------------------------+
bool CProgram::CreateSplitButton2(const string button_text)
  {
#define CONTEXTMENU_ITEMS6 3
//--- Pass the panel object
   m_split_button2.WindowPointer(m_window);
//--- Coordinates
   int x=m_window.X()+SPLITBUTTON2_GAP_X;
   int y=m_window.Y()+SPLITBUTTON2_GAP_Y;
//---
   string items_text[]=
     {
      "Item 1",
      "Item 2",
      "Item 3"
     };
   string items_bmp_on[]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart.bmp"
     };
   string items_bmp_off[]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins_gray.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart_gray.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart_gray.bmp"
     };
//--- Set properties before creation
   m_split_button2.ButtonXSize(116);
   m_split_button2.ButtonYSize(22);
   m_split_button2.DropButtonXSize(16);
   m_split_button2.IconFileOn("Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart.bmp");
   m_split_button2.IconFileOff("Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart_gray.bmp");
//--- Get the pointer to the context menu of the button
   CContextMenu *cm=m_split_button2.GetContextMenuPointer();
//---
   for(int i=0; i<CONTEXTMENU_ITEMS6; i++)
      m_split_button2.AddItem(items_text[i],items_bmp_on[i],items_bmp_off[i]);
//---
   m_split_button2.AddSeparateLine(1);
//--- Create control
   if(!m_split_button2.CreateSplitButton(m_chart_id,m_subwin,button_text,x,y))
      return(false);
//--- Block the button
   m_split_button2.ButtonState(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_split_button2);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates split button 3                                           |
//+------------------------------------------------------------------+
bool CProgram::CreateSplitButton3(const string button_text)
  {
#define CONTEXTMENU_ITEMS7 3
//--- Pass the panel object
   m_split_button3.WindowPointer(m_window);
//--- Coordinates
   int x=m_window.X()+SPLITBUTTON3_GAP_X;
   int y=m_window.Y()+SPLITBUTTON3_GAP_Y;
//---
   string items_text[]=
     {
      "Item 1",
      "Item 2",
      "Item 3"
     };
   string items_bmp_on[]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart.bmp"
     };
   string items_bmp_off[]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins_gray.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart_gray.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart_gray.bmp"
     };
//--- Set properties before creation
   m_split_button3.ButtonXSize(116);
   m_split_button3.ButtonYSize(22);
   m_split_button3.DropButtonXSize(16);
   m_split_button3.IconFileOn("Images\\EasyAndFastGUI\\Icons\\bmp16\\invoice.bmp");
   m_split_button3.IconFileOff("Images\\EasyAndFastGUI\\Icons\\bmp16\\invoice_gray.bmp");
//--- Get the pointer to the context menu of the button
   CContextMenu *cm=m_split_button3.GetContextMenuPointer();
//---
   for(int i=0; i<CONTEXTMENU_ITEMS7; i++)
      m_split_button3.AddItem(items_text[i],items_bmp_on[i],items_bmp_off[i]);
//---
   m_split_button3.AddSeparateLine(1);
//--- Create control
   if(!m_split_button3.CreateSplitButton(m_chart_id,m_subwin,button_text,x,y))
      return(false);
//--- Block the button
   m_split_button3.ButtonState(true);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_split_button3);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates split button 4                                           |
//+------------------------------------------------------------------+
bool CProgram::CreateSplitButton4(const string button_text)
  {
#define CONTEXTMENU_ITEMS8 3
//--- Pass the panel object
   m_split_button4.WindowPointer(m_window);
//--- Coordinates
   int x=m_window.X()+SPLITBUTTON4_GAP_X;
   int y=m_window.Y()+SPLITBUTTON4_GAP_Y;
//---
   string items_text[]=
     {
      "Item 1",
      "Item 2",
      "Item 3"
     };
   string items_bmp_on[]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart.bmp"
     };
   string items_bmp_off[]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins_gray.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart_gray.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart_gray.bmp"
     };
//--- Set properties before creation
   m_split_button4.ButtonXSize(116);
   m_split_button4.ButtonYSize(22);
   m_split_button4.DropButtonXSize(16);
   m_split_button4.IconFileOn("Images\\EasyAndFastGUI\\Icons\\bmp16\\calculator.bmp");
   m_split_button4.IconFileOff("Images\\EasyAndFastGUI\\Icons\\bmp16\\calculator_gray.bmp");
//--- Get the pointer to the context menu of the button
   CContextMenu *cm=m_split_button4.GetContextMenuPointer();
//--- Set up properties of the context menu
   cm.AreaBackColor(C'240,240,240');
   cm.AreaBorderColor(clrSilver);
   cm.ItemBackColor(C'240,240,240');
   cm.ItemBorderColor(C'240,240,240');
   cm.LabelColor(clrBlack);
   cm.LabelColorHover(clrWhite);
   cm.SeparateLineDarkColor(C'160,160,160');
   cm.SeparateLineLightColor(clrWhite);
//---
   for(int i=0; i<CONTEXTMENU_ITEMS8; i++)
      m_split_button4.AddItem(items_text[i],items_bmp_on[i],items_bmp_off[i]);
//---
   m_split_button4.AddSeparateLine(1);
//--- Create control
   if(!m_split_button4.CreateSplitButton(m_chart_id,m_subwin,button_text,x,y))
      return(false);
//--- Block the button
   m_split_button4.ButtonState(true);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_split_button4);
   return(true);
  }
//+------------------------------------------------------------------+
