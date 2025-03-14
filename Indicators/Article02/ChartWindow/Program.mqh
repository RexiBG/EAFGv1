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
   //--- Independent menu item 1 and its context menus
   CMenuItem         m_menu_item1;
   CContextMenu      m_mi1_contextmenu1;
   CContextMenu      m_mi1_contextmenu2;
   //--- Independent menu item 2 and its context menus
   CMenuItem         m_menu_item2;
   CContextMenu      m_mi2_contextmenu1;
   //--- Independent menu item 3 and its context menus
   CMenuItem         m_menu_item3;
   CContextMenu      m_mi3_contextmenu1;
   //--- Independent menu item 4 and its context menus
   CMenuItem         m_menu_item4;
   CContextMenu      m_mi4_contextmenu1;
   //--- Independent menu item 5 and its context menus
   CMenuItem         m_menu_item5;
   CContextMenu      m_mi5_contextmenu1;
   //--- Separation line
   CSeparateLine     m_sep_line;
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
   bool              CreateWindow(const string text);
   //---
#define MENUBAR_GAP_X    (1)
#define MENUBAR_GAP_Y    (20)
   bool              CreateMenuBar(void);
   bool              CreateMBContextMenu1(void);
   bool              CreateMBContextMenu2(void);
   bool              CreateMBContextMenu3(void);
   bool              CreateMBContextMenu4(void);
   //---
#define MENU_ITEM1_GAP_X (6)
#define MENU_ITEM1_GAP_Y (45)
   bool              CreateMenuItem1(const string item_text);
   bool              CreateMI1ContextMenu1(void);
   bool              CreateMI1ContextMenu2(void);
   //---
#define MENU_ITEM2_GAP_X (6)
#define MENU_ITEM2_GAP_Y (70)
   bool              CreateMenuItem2(const string item_text);
   bool              CreateMI2ContextMenu1(void);
   //---
#define SEP_LINE_GAP_X   (6)
#define SEP_LINE_GAP_Y   (100)
   bool              CreateSepLine(void);
   //---
#define MENU_ITEM3_GAP_X (6)
#define MENU_ITEM3_GAP_Y (110)
   bool              CreateMenuItem3(const string item_text);
   bool              CreateMI3ContextMenu1(void);
   //---
#define MENU_ITEM4_GAP_X (6)
#define MENU_ITEM4_GAP_Y (135)
   bool              CreateMenuItem4(const string item_text);
   bool              CreateMI4ContextMenu1(void);
   //---
#define MENU_ITEM5_GAP_X (6)
#define MENU_ITEM5_GAP_Y (160)
   bool              CreateMenuItem5(const string item_text);
   bool              CreateMI5ContextMenu1(void);
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
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_CONTEXTMENU_ITEM)
     {
      ::Print(__FUNCTION__," > id: ",id,"; lparam: ",lparam,"; dparam: ",dparam,"; sparam: ",sparam);
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
//--- Menu item 1
   if(!CreateMenuItem1("Menu item 1"))
      return(false);
//--- Context menus
   if(!CreateMI1ContextMenu1())
      return(false);
   if(!CreateMI1ContextMenu2())
      return(false);
//--- Menu item 2
   if(!CreateMenuItem2("Menu item 2"))
      return(false);
//--- Context menus
   if(!CreateMI2ContextMenu1())
      return(false);
//--- Separation line
   if(!CreateSepLine())
      return(false);
//--- Menu item 3
   if(!CreateMenuItem3("Menu item 3"))
      return(false);
//--- Context menus
   if(!CreateMI3ContextMenu1())
      return(false);
//--- Menu item 4
   if(!CreateMenuItem4("Menu item 4"))
      return(false);
//--- Context menus
   if(!CreateMI4ContextMenu1())
      return(false);
//--- Menu item 5
   if(!CreateMenuItem5("Menu item 5"))
      return(false);
//--- Context menus
   if(!CreateMI5ContextMenu1())
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
   m_window.XSize(205);
   m_window.YSize(190);
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
//--- Six items in a context menu
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
//| Creates menu item 1                                              |
//+------------------------------------------------------------------+
bool CProgram::CreateMenuItem1(string item_text)
  {
//--- Store the window pointer
   m_menu_item1.WindowPointer(m_window);
//--- Coordinates  
   int x=m_window.X()+MENU_ITEM1_GAP_X;
   int y=m_window.Y()+MENU_ITEM1_GAP_Y;
//--- Set properties before creation
   m_menu_item1.XSize(193);
   m_menu_item1.YSize(24);
   m_menu_item1.TypeMenuItem(MI_HAS_CONTEXT_MENU);
   m_menu_item1.IconFileOn("Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart.bmp");
   m_menu_item1.IconFileOff("Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart_gray.bmp");
   m_menu_item1.RightArrowFileOff("Images\\EasyAndFastGUI\\Controls\\RArrow_black.bmp");
//--- Creating a menu item
   if(!m_menu_item1.CreateMenuItem(m_chart_id,m_subwin,0,item_text,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_menu_item1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates a context menu                                           |
//+------------------------------------------------------------------+
bool CProgram::CreateMI1ContextMenu1(void)
  {
//--- Five items in the context menu
#define CONTEXTMENU_ITEMS5 5
//--- Store the window pointer
   m_mi1_contextmenu1.WindowPointer(m_window);
//--- Store the pointer to the previous node
   m_mi1_contextmenu1.PrevNodePointer(m_menu_item1);
//--- Array of the menu item names
   string items_text[CONTEXTMENU_ITEMS5]=
     {
      "ContextMenu 5 Item 1",
      "ContextMenu 5 Item 2",
      "ContextMenu 5 Item 3",
      "ContextMenu 5 Item 4",
      "ContextMenu 5 Item 5"
     };
//--- Array of icons for the available mode
   string items_bmp_on[CONTEXTMENU_ITEMS5]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\safe.bmp",
      "",""
     };
//--- Array of icon for the blocked mode
   string items_bmp_off[CONTEXTMENU_ITEMS5]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins_gray.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart_gray.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\safe_gray.bmp",
      "Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_black.bmp",
      "Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_black.bmp"
     };
//--- Array of item types
   ENUM_TYPE_MENU_ITEM items_type[CONTEXTMENU_ITEMS5]=
     {
      MI_SIMPLE,
      MI_SIMPLE,
      MI_HAS_CONTEXT_MENU,
      MI_CHECKBOX,
      MI_CHECKBOX
     };
//--- Set properties before creation
   m_mi1_contextmenu1.XSize(160);
   m_mi1_contextmenu1.RightArrowFileOff("Images\\EasyAndFastGUI\\Controls\\RArrow_black.bmp");
//--- Add items to the context menu
   for(int i=0; i<CONTEXTMENU_ITEMS5; i++)
      m_mi1_contextmenu1.AddItem(items_text[i],items_bmp_on[i],items_bmp_off[i],items_type[i]);
//--- Separation line after the second item
   m_mi1_contextmenu1.AddSeparateLine(1);
//--- Deactivate the second item
   m_mi1_contextmenu1.ItemPointerByIndex(1).ItemState(false);
//--- Initialize the first checkbox
   m_mi1_contextmenu1.CheckBoxStateByIndex(3,false);
//--- Create a context menu
   if(!m_mi1_contextmenu1.CreateContextMenu(m_chart_id,m_subwin))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_mi1_contextmenu1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates a context menu                                           |
//+------------------------------------------------------------------+
bool CProgram::CreateMI1ContextMenu2(void)
  {
//--- Six items in a context menu
#define CONTEXTMENU_ITEMS6 6
//--- Store the window pointer
   m_mi1_contextmenu2.WindowPointer(m_window);
//--- Store the pointer to the previous node
   m_mi1_contextmenu2.PrevNodePointer(m_mi1_contextmenu1.ItemPointerByIndex(2));
//--- Array of the menu item names
   string items_text[CONTEXTMENU_ITEMS6]=
     {
      "ContextMenu 6 Item 1",
      "ContextMenu 6 Item 2",
      "ContextMenu 6 Item 3",
      "ContextMenu 6 Item 4",
      "ContextMenu 6 Item 5",
      "ContextMenu 6 Item 6"
     };
//--- Set properties before creation
   m_mi1_contextmenu2.XSize(160);
//--- Add items to the context menu
   for(int i=0; i<CONTEXTMENU_ITEMS6; i++)
      m_mi1_contextmenu2.AddItem(items_text[i],"","Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_black.bmp",MI_RADIOBUTTON);
//--- Separation line after the second item
   m_mi1_contextmenu2.AddSeparateLine(2);
//--- Set a unique identifier (1) for the second group
   for(int i=3; i<6; i++)
      m_mi1_contextmenu2.RadioItemIdByIndex(i,1);
//--- Selecting radio items in both groups
   m_mi1_contextmenu2.SelectedRadioItem(1,0);
   m_mi1_contextmenu2.SelectedRadioItem(2,1);
//--- Create a context menu
   if(!m_mi1_contextmenu2.CreateContextMenu(m_chart_id,m_subwin))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_mi1_contextmenu2);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates menu item  2                                             |
//+------------------------------------------------------------------+
bool CProgram::CreateMenuItem2(string item_text)
  {
//--- Store the window pointer
   m_menu_item2.WindowPointer(m_window);
//--- Coordinates  
   int x=m_window.X()+MENU_ITEM2_GAP_X;
   int y=m_window.Y()+MENU_ITEM2_GAP_Y;
//--- Set properties before creation
   m_menu_item2.XSize(193);
   m_menu_item2.YSize(24);
   m_menu_item2.TypeMenuItem(MI_HAS_CONTEXT_MENU);
   m_menu_item2.IconFileOn("Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp");
   m_menu_item2.IconFileOff("Images\\EasyAndFastGUI\\Icons\\bmp16\\coins_gray.bmp");
   m_menu_item2.RightArrowFileOff("Images\\EasyAndFastGUI\\Controls\\RArrow_black.bmp");
//--- Creating a menu item
   if(!m_menu_item2.CreateMenuItem(m_chart_id,m_subwin,0,item_text,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_menu_item2);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates a context menu                                           |
//+------------------------------------------------------------------+
bool CProgram::CreateMI2ContextMenu1(void)
  {
//--- Five items in the context menu
#define CONTEXTMENU_ITEMS7 5
//--- Store the window pointer
   m_mi2_contextmenu1.WindowPointer(m_window);
//--- Store the pointer to the previous node
   m_mi2_contextmenu1.PrevNodePointer(m_menu_item2);
//--- Array of the menu item names
   string items_text[CONTEXTMENU_ITEMS5]=
     {
      "ContextMenu 7 Item 1",
      "ContextMenu 7 Item 2",
      "ContextMenu 7 Item 3",
      "ContextMenu 7 Item 4",
      "ContextMenu 7 Item 5"
     };
//--- Array of icons for the available mode
   string items_bmp_on[CONTEXTMENU_ITEMS7]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\safe.bmp",
      "",""
     };
//--- Array of icon for the blocked mode
   string items_bmp_off[CONTEXTMENU_ITEMS7]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins_gray.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart_gray.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\safe_gray.bmp",
      "Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_black.bmp",
      "Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_black.bmp"
     };
//--- Array of item types
   ENUM_TYPE_MENU_ITEM items_type[CONTEXTMENU_ITEMS7]=
     {
      MI_SIMPLE,
      MI_SIMPLE,
      MI_SIMPLE,
      MI_CHECKBOX,
      MI_CHECKBOX
     };
//--- Set properties before creation
   m_mi2_contextmenu1.XSize(160);
//--- Add items to the context menu
   for(int i=0; i<CONTEXTMENU_ITEMS7; i++)
      m_mi2_contextmenu1.AddItem(items_text[i],items_bmp_on[i],items_bmp_off[i],items_type[i]);
//--- Separation line after the second item
   m_mi2_contextmenu1.AddSeparateLine(1);
//--- Create a context menu
   if(!m_mi2_contextmenu1.CreateContextMenu(m_chart_id,m_subwin))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_mi2_contextmenu1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates a separation line                                        |
//+------------------------------------------------------------------+
bool CProgram::CreateSepLine(void)
  {
//--- Store the window pointer
   m_sep_line.WindowPointer(m_window);
//--- Coordinates  
   int x=m_window.X()+SEP_LINE_GAP_X;
   int y=m_window.Y()+SEP_LINE_GAP_Y;
//--- Creating an element
   if(!m_sep_line.CreateSeparateLine(m_chart_id,m_subwin,0,x,y,193,2))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_sep_line);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates menu item 3                                              |
//+------------------------------------------------------------------+
bool CProgram::CreateMenuItem3(string item_text)
  {
//--- Store the window pointer
   m_menu_item3.WindowPointer(m_window);
//--- Coordinates  
   int x=m_window.X()+MENU_ITEM3_GAP_X;
   int y=m_window.Y()+MENU_ITEM3_GAP_Y;
//--- Set properties before creation
   m_menu_item3.XSize(193);
   m_menu_item3.YSize(24);
   m_menu_item3.TypeMenuItem(MI_HAS_CONTEXT_MENU);
   m_menu_item3.IconFileOn("Images\\EasyAndFastGUI\\Icons\\bmp16\\safe.bmp");
   m_menu_item3.IconFileOff("Images\\EasyAndFastGUI\\Icons\\bmp16\\safe_gray.bmp");
   m_menu_item3.RightArrowFileOff("Images\\EasyAndFastGUI\\Controls\\RArrow_black.bmp");
//--- Creating a menu item
   if(!m_menu_item3.CreateMenuItem(m_chart_id,m_subwin,0,item_text,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_menu_item3);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates a context menu                                           |
//+------------------------------------------------------------------+
bool CProgram::CreateMI3ContextMenu1(void)
  {
//--- Five items in the context menu
#define CONTEXTMENU_ITEMS8 5
//--- Store the window pointer
   m_mi3_contextmenu1.WindowPointer(m_window);
//--- Store the pointer to the previous node
   m_mi3_contextmenu1.PrevNodePointer(m_menu_item3);
//--- Array of the menu item names
   string items_text[CONTEXTMENU_ITEMS8]=
     {
      "ContextMenu 8 Item 1",
      "ContextMenu 8 Item 2",
      "ContextMenu 8 Item 3",
      "ContextMenu 8 Item 4",
      "ContextMenu 8 Item 5"
     };
//--- Array of icons for the available mode
   string items_bmp_on[CONTEXTMENU_ITEMS8]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\safe.bmp",
      "",""
     };
//--- Array of icon for the blocked mode
   string items_bmp_off[CONTEXTMENU_ITEMS8]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins_gray.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart_gray.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\safe_gray.bmp",
      "Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_black.bmp",
      "Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_black.bmp"
     };
//--- Array of item types
   ENUM_TYPE_MENU_ITEM items_type[CONTEXTMENU_ITEMS8]=
     {
      MI_SIMPLE,
      MI_SIMPLE,
      MI_SIMPLE,
      MI_CHECKBOX,
      MI_CHECKBOX
     };
//--- Set properties before creation
   m_mi3_contextmenu1.XSize(160);
//--- Add items to the context menu
   for(int i=0; i<CONTEXTMENU_ITEMS8; i++)
      m_mi3_contextmenu1.AddItem(items_text[i],items_bmp_on[i],items_bmp_off[i],items_type[i]);
//--- Separation line after the second item
   m_mi3_contextmenu1.AddSeparateLine(1);
//--- Create a context menu
   if(!m_mi3_contextmenu1.CreateContextMenu(m_chart_id,m_subwin))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_mi3_contextmenu1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates menu item 4                                              |
//+------------------------------------------------------------------+
bool CProgram::CreateMenuItem4(string item_text)
  {
//--- Store the window pointer
   m_menu_item4.WindowPointer(m_window);
//--- Coordinates  
   int x=m_window.X()+MENU_ITEM4_GAP_X;
   int y=m_window.Y()+MENU_ITEM4_GAP_Y;
//--- Set properties before creation
   m_menu_item4.XSize(193);
   m_menu_item4.YSize(24);
   m_menu_item4.TypeMenuItem(MI_HAS_CONTEXT_MENU);
   m_menu_item4.IconFileOn("Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp");
   m_menu_item4.IconFileOff("Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart_gray.bmp");
   m_menu_item4.RightArrowFileOff("Images\\EasyAndFastGUI\\Controls\\RArrow_black.bmp");
//--- Creating a menu item
   if(!m_menu_item4.CreateMenuItem(m_chart_id,m_subwin,0,item_text,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_menu_item4);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates a context menu                                           |
//+------------------------------------------------------------------+
bool CProgram::CreateMI4ContextMenu1(void)
  {
//--- Five items in the context menu
#define CONTEXTMENU_ITEMS9 5
//--- Store the window pointer
   m_mi4_contextmenu1.WindowPointer(m_window);
//--- Store the pointer to the previous node
   m_mi4_contextmenu1.PrevNodePointer(m_menu_item4);
//--- Array of the menu item names
   string items_text[CONTEXTMENU_ITEMS9]=
     {
      "ContextMenu 9 Item 1",
      "ContextMenu 9 Item 2",
      "ContextMenu 9 Item 3",
      "ContextMenu 9 Item 4",
      "ContextMenu 9 Item 5"
     };
//--- Array of icons for the available mode
   string items_bmp_on[CONTEXTMENU_ITEMS9]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\safe.bmp",
      "",""
     };
//--- Array of icon for the blocked mode
   string items_bmp_off[CONTEXTMENU_ITEMS9]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins_gray.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart_gray.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\safe_gray.bmp",
      "Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_black.bmp",
      "Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_black.bmp"
     };
//--- Array of item types
   ENUM_TYPE_MENU_ITEM items_type[CONTEXTMENU_ITEMS9]=
     {
      MI_SIMPLE,
      MI_SIMPLE,
      MI_SIMPLE,
      MI_CHECKBOX,
      MI_CHECKBOX
     };
//--- Set properties before creation
   m_mi4_contextmenu1.XSize(160);
//--- Add items to the context menu
   for(int i=0; i<CONTEXTMENU_ITEMS9; i++)
      m_mi4_contextmenu1.AddItem(items_text[i],items_bmp_on[i],items_bmp_off[i],items_type[i]);
//--- Separation line after the second item
   m_mi4_contextmenu1.AddSeparateLine(1);
//--- Create a context menu
   if(!m_mi4_contextmenu1.CreateContextMenu(m_chart_id,m_subwin))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_mi4_contextmenu1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates menu item 5                                              |
//+------------------------------------------------------------------+
bool CProgram::CreateMenuItem5(string item_text)
  {
//--- Store the window pointer
   m_menu_item5.WindowPointer(m_window);
//--- Coordinates  
   int x=m_window.X()+MENU_ITEM5_GAP_X;
   int y=m_window.Y()+MENU_ITEM5_GAP_Y;
//--- Set properties before creation
   m_menu_item5.XSize(193);
   m_menu_item5.YSize(24);
   m_menu_item5.TypeMenuItem(MI_HAS_CONTEXT_MENU);
   m_menu_item5.IconFileOn("Images\\EasyAndFastGUI\\Icons\\bmp16\\pie_chart.bmp");
   m_menu_item5.IconFileOff("Images\\EasyAndFastGUI\\Icons\\bmp16\\pie_chart_gray.bmp");
   m_menu_item5.RightArrowFileOff("Images\\EasyAndFastGUI\\Controls\\RArrow_black.bmp");
//--- Creating a menu item
   if(!m_menu_item5.CreateMenuItem(m_chart_id,m_subwin,0,item_text,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_menu_item5);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates a context menu                                           |
//+------------------------------------------------------------------+
bool CProgram::CreateMI5ContextMenu1(void)
  {
//--- Five items in the context menu
#define CONTEXTMENU_ITEMS10 5
//--- Store the window pointer
   m_mi5_contextmenu1.WindowPointer(m_window);
//--- Store the pointer to the previous node
   m_mi5_contextmenu1.PrevNodePointer(m_menu_item5);
//--- Array of the menu item names
   string items_text[CONTEXTMENU_ITEMS10]=
     {
      "ContextMenu 10 Item 1",
      "ContextMenu 10 Item 2",
      "ContextMenu 10 Item 3",
      "ContextMenu 10 Item 4",
      "ContextMenu 10 Item 5"
     };
//--- Array of icons for the available mode
   string items_bmp_on[CONTEXTMENU_ITEMS10]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\safe.bmp",
      "",""
     };
//--- Array of icon for the blocked mode
   string items_bmp_off[CONTEXTMENU_ITEMS10]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins_gray.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart_gray.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\safe_gray.bmp",
      "Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_black.bmp",
      "Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_black.bmp"
     };
//--- Array of item types
   ENUM_TYPE_MENU_ITEM items_type[CONTEXTMENU_ITEMS10]=
     {
      MI_SIMPLE,
      MI_SIMPLE,
      MI_SIMPLE,
      MI_CHECKBOX,
      MI_CHECKBOX
     };
//--- Set properties before creation
   m_mi5_contextmenu1.XSize(160);
//--- Add items to the context menu
   for(int i=0; i<CONTEXTMENU_ITEMS10; i++)
      m_mi5_contextmenu1.AddItem(items_text[i],items_bmp_on[i],items_bmp_off[i],items_type[i]);
//--- Separation line after the second item
   m_mi5_contextmenu1.AddSeparateLine(1);
//--- Create a context menu
   if(!m_mi5_contextmenu1.CreateContextMenu(m_chart_id,m_subwin))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_mi5_contextmenu1);
   return(true);
  }
//+------------------------------------------------------------------+
