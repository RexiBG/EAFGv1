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
   //--- Status Bar
   CStatusBar        m_status_bar;
   //--- Tree view
   CTreeView         m_treeview;
   //--- Checkboxes
   CCheckBox         m_checkbox1;
   CCheckBox         m_checkbox2;
   CCheckBox         m_checkbox3;
   CCheckBox         m_checkbox4;
   //--- Tables
   CTable            m_table1;
   CTable            m_table2;
   CTable            m_table3;
   CTable            m_table4;
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
#define STATUSBAR1_GAP_Y      (237)
   bool              CreateStatusBar(void);
   //--- Tree view
#define TREEVIEW1_GAP_X       (2)
#define TREEVIEW1_GAP_Y       (43)
   bool              CreateTreeView(void);
   //--- Checkboxes
#define CHECKBOX1_GAP_X       (190)
#define CHECKBOX1_GAP_Y       (53)
   bool              CreateCheckBox1(const string text);
#define CHECKBOX2_GAP_X       (190)
#define CHECKBOX2_GAP_Y       (53)
   bool              CreateCheckBox2(const string text);
#define CHECKBOX3_GAP_X       (190)
#define CHECKBOX3_GAP_Y       (53)
   bool              CreateCheckBox3(const string text);
#define CHECKBOX4_GAP_X       (190)
#define CHECKBOX4_GAP_Y       (53)
   bool              CreateCheckBox4(const string text);
   //--- Tables
#define TABLE1_GAP_X          (182)
#define TABLE1_GAP_Y          (81)
   bool              CreateTable1(void);
#define TABLE2_GAP_X          (182)
#define TABLE2_GAP_Y          (81)
   bool              CreateTable2(void);
#define TABLE3_GAP_X          (182)
#define TABLE3_GAP_Y          (81)
   bool              CreateTable3(void);
#define TABLE4_GAP_X          (182)
#define TABLE4_GAP_Y          (81)
   bool              CreateTable4(void);
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
//--- The text label press event
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_LABEL)
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
//--- Create the tree view
   if(!CreateTreeView())
      return(false);
//--- Checkboxes
   if(!CreateCheckBox1("Advisors > 01: Checkbox 1"))
      return(false);
   if(!CreateCheckBox2("Advisors > 02: Checkbox 2"))
      return(false);
   if(!CreateCheckBox3("Indicators > 01: Checkbox 3"))
      return(false);
   if(!CreateCheckBox4("Indicators > 02: Checkbox 4"))
      return(false);
//--- Tables
   if(!CreateTable1())
      return(false);
   if(!CreateTable2())
      return(false);
   if(!CreateTable3())
      return(false);
   if(!CreateTable4())
      return(false);
//--- Display controls of the active tab only
   m_treeview.ShowTabElements();
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
   m_window1.XSize(450);
   m_window1.YSize(262);
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
//| Creates the tree view                                            |
//+------------------------------------------------------------------+
bool CProgram::CreateTreeView(void)
  {
//--- The number of items in the tree view
#define TREEVIEW_ITEMS 12
//--- Store the window pointer
   m_treeview.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+TREEVIEW1_GAP_X;
   int y=m_window1.Y()+TREEVIEW1_GAP_Y;
//--- Form arrays for the tree view:
//    Item icons
#define A "Images\\EasyAndFastGUI\\Icons\\bmp16\\advisor.bmp"   // Expert
#define I "Images\\EasyAndFastGUI\\Icons\\bmp16\\indicator.bmp" // Indicator
#define S "Images\\EasyAndFastGUI\\Icons\\bmp16\\script.bmp"    // Script
   string path_bmp[TREEVIEW_ITEMS]=
     {A,A,A,I,I,I,S,S,S,S,S,S};
//--- Item description (displayed text)
   string item_text[TREEVIEW_ITEMS]=
     {"Advisors","01","02","Indicators","01","02","Scripts","01","02","03","04","05"};
//--- Indices of the general list of the previous nodes
   int prev_node_list_index[TREEVIEW_ITEMS]=
     {-1,0,0,-1,3,3,-1,6,6,6,6,6};
//--- Indices of items in the local lists
   int item_index[TREEVIEW_ITEMS]=
     {0,0,1,1,0,1,2,0,1,2,3,4};
//--- Node level number
   int node_level[TREEVIEW_ITEMS]=
     {0,1,1,0,1,1,0,1,1,1,1,1};
//--- Local indices of items of the previous nodes
   int prev_node_item_index[TREEVIEW_ITEMS]=
     {-1,0,0,-1,1,1,-1,2,2,2,2,2};
//--- The number of items in the local lists
   int items_total[TREEVIEW_ITEMS]=
     {2,0,0,2,0,0,5,0,0,0,0,0};
//--- State of the item list
   bool item_state[TREEVIEW_ITEMS]=
     {true,false,false,true,false,false,false,false,false,false,false,false};
//--- Set properties before creation
   m_treeview.TreeViewAreaWidth(180);
   m_treeview.VisibleItemsTotal(10);
   m_treeview.TabItemsMode(true);
   m_treeview.LightsHover(true);
   m_treeview.ShowItemContent(false);
   m_treeview.SelectedItemIndex((m_treeview.SelectedItemIndex()==WRONG_VALUE) ? 3 : m_treeview.SelectedItemIndex());
//--- The properties of scrollbars
   m_treeview.GetScrollVPointer().AreaBorderColor(clrLightGray);
   m_treeview.GetContentScrollVPointer().AreaBorderColor(clrLightGray);
//--- Add items
   for(int i=0; i<TREEVIEW_ITEMS; i++)
      m_treeview.AddItem(i,prev_node_list_index[i],item_text[i],path_bmp[i],
                         item_index[i],node_level[i],prev_node_item_index[i],items_total[i],0,item_state[i]);
//--- Create the tree view
   if(!m_treeview.CreateTreeView(m_chart_id,m_subwin,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_treeview);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates checkbox 1                                               |
//+------------------------------------------------------------------+
bool CProgram::CreateCheckBox1(string text)
  {
//--- Store the window pointer
   m_checkbox1.WindowPointer(m_window1);
//--- Attach to the first tab item
   m_treeview.AddToElementsArray(0,m_checkbox1);
//--- Coordinates
   int x=m_window1.X()+CHECKBOX1_GAP_X;
   int y=m_window1.Y()+CHECKBOX1_GAP_Y;
//--- Set properties before creation
   m_checkbox1.XSize(200);
   m_checkbox1.YSize(18);
//--- Create control
   if(!m_checkbox1.CreateCheckBox(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_checkbox1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create table 1                                                   |
//+------------------------------------------------------------------+
bool CProgram::CreateTable1(void)
  {
#define COLUMNS1_TOTAL (3)
#define ROWS1_TOTAL    (100)
//--- Store pointer to the form
   m_table1.WindowPointer(m_window1);
//--- Attach to the first tab item
   m_treeview.AddToElementsArray(0,m_table1);
//--- Coordinates
   int x=m_window1.X()+TABLE1_GAP_X;
   int y=m_window1.Y()+TABLE1_GAP_Y;
//--- The number of visible rows and columns
   int visible_columns_total =3;
   int visible_rows_total    =9;
//--- Set properties before creation
   m_table1.XSize(267);
   m_table1.RowYSize(18);
   m_table1.FixFirstRow(true);
   m_table1.LightsHover(true);
   m_table1.SelectableRow(true);
   m_table1.TextAlign(ALIGN_CENTER);
   m_table1.HeadersColor(C'255,244,213');
   m_table1.HeadersTextColor(clrBlack);
   m_table1.TableSize(COLUMNS1_TOTAL,ROWS1_TOTAL);
   m_table1.VisibleTableSize(visible_columns_total,visible_rows_total);
//--- Create control
   if(!m_table1.CreateTable(m_chart_id,m_subwin,x,y))
      return(false);
//--- Populate the table:
//    Headers for columns
   for(int c=0; c<COLUMNS1_TOTAL; c++)
     {
      for(int r=0; r<1; r++)
         m_table1.SetValue(c,r,"SYMBOL "+string(c));
     }
//--- Data and formatting of the table (background color and cell color)
   for(int c=0; c<COLUMNS1_TOTAL; c++)
     {
      for(int r=1; r<ROWS1_TOTAL; r++)
         m_table1.SetValue(c,r,string(c)+":"+string(r));
     }
//--- Update the table to display changes
   m_table1.UpdateTable();
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_table1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates checkbox 2                                               |
//+------------------------------------------------------------------+
bool CProgram::CreateCheckBox2(string text)
  {
//--- Store the window pointer
   m_checkbox2.WindowPointer(m_window1);
//--- Attach to the second tab item
   m_treeview.AddToElementsArray(1,m_checkbox2);
//--- Coordinates
   int x=m_window1.X()+CHECKBOX2_GAP_X;
   int y=m_window1.Y()+CHECKBOX2_GAP_Y;
//--- Set properties before creation
   m_checkbox2.XSize(200);
   m_checkbox2.YSize(18);
//--- Create control
   if(!m_checkbox2.CreateCheckBox(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_checkbox2);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create table 2                                                   |
//+------------------------------------------------------------------+
bool CProgram::CreateTable2(void)
  {
#define COLUMNS2_TOTAL (3)
#define ROWS2_TOTAL    (70)
//--- Store pointer to the form
   m_table2.WindowPointer(m_window1);
//--- Attach to the first tab item
   m_treeview.AddToElementsArray(1,m_table2);
//--- Coordinates
   int x=m_window1.X()+TABLE2_GAP_X;
   int y=m_window1.Y()+TABLE2_GAP_Y;
//--- The number of visible rows and columns
   int visible_columns_total =3;
   int visible_rows_total    =9;
//--- Set properties before creation
   m_table2.XSize(267);
   m_table2.RowYSize(18);
   m_table2.FixFirstRow(true);
   m_table2.LightsHover(true);
   m_table2.SelectableRow(true);
   m_table2.TextAlign(ALIGN_CENTER);
   m_table2.HeadersColor(C'255,244,213');
   m_table2.HeadersTextColor(clrBlack);
   m_table2.TableSize(COLUMNS2_TOTAL,ROWS2_TOTAL);
   m_table2.VisibleTableSize(visible_columns_total,visible_rows_total);
//--- Create control
   if(!m_table2.CreateTable(m_chart_id,m_subwin,x,y))
      return(false);
//--- Populate the table:
//    Headers for columns
   for(int c=0; c<COLUMNS2_TOTAL; c++)
     {
      for(int r=0; r<1; r++)
         m_table2.SetValue(c,r,"SYMBOL "+string(c));
     }
//--- Data and formatting of the table (background color and cell color)
   for(int c=0; c<COLUMNS2_TOTAL; c++)
     {
      for(int r=1; r<ROWS2_TOTAL; r++)
         m_table2.SetValue(c,r,string(c)+":"+string(r));
     }
//--- Update the table to display changes
   m_table2.UpdateTable();
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_table2);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates checkbox 3                                               |
//+------------------------------------------------------------------+
bool CProgram::CreateCheckBox3(string text)
  {
//--- Store the window pointer
   m_checkbox3.WindowPointer(m_window1);
//--- Attach to the third tab item
   m_treeview.AddToElementsArray(2,m_checkbox3);
//--- Coordinates
   int x=m_window1.X()+CHECKBOX3_GAP_X;
   int y=m_window1.Y()+CHECKBOX3_GAP_Y;
//--- Set properties before creation
   m_checkbox3.XSize(200);
   m_checkbox3.YSize(18);
//--- Create control
   if(!m_checkbox3.CreateCheckBox(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_checkbox3);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create table 3                                                   |
//+------------------------------------------------------------------+
bool CProgram::CreateTable3(void)
  {
#define COLUMNS3_TOTAL (2)
#define ROWS3_TOTAL    (30)
//--- Store pointer to the form
   m_table3.WindowPointer(m_window1);
//--- Attach to the third tab item
   m_treeview.AddToElementsArray(2,m_table3);
//--- Coordinates
   int x=m_window1.X()+TABLE3_GAP_X;
   int y=m_window1.Y()+TABLE3_GAP_Y;
//--- The number of visible rows and columns
   int visible_columns_total =2;
   int visible_rows_total    =9;
//--- Set properties before creation
   m_table3.XSize(267);
   m_table3.RowYSize(18);
   m_table3.FixFirstRow(true);
   m_table3.LightsHover(true);
   m_table3.SelectableRow(true);
   m_table3.TextAlign(ALIGN_CENTER);
   m_table3.HeadersColor(C'255,244,213');
   m_table3.HeadersTextColor(clrBlack);
   m_table3.TableSize(COLUMNS3_TOTAL,ROWS3_TOTAL);
   m_table3.VisibleTableSize(visible_columns_total,visible_rows_total);
//--- Create control
   if(!m_table3.CreateTable(m_chart_id,m_subwin,x,y))
      return(false);
//--- Populate the table:
//    Headers for columns
   for(int c=0; c<COLUMNS3_TOTAL; c++)
     {
      for(int r=0; r<1; r++)
         m_table3.SetValue(c,r,"SYMBOL "+string(c));
     }
//--- Data and formatting of the table (background color and cell color)
   for(int c=0; c<COLUMNS3_TOTAL; c++)
     {
      for(int r=1; r<ROWS3_TOTAL; r++)
         m_table3.SetValue(c,r,string(c)+":"+string(r));
     }
//--- Update the table to display changes
   m_table3.UpdateTable();
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_table3);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates checkbox 4                                               |
//+------------------------------------------------------------------+
bool CProgram::CreateCheckBox4(string text)
  {
//--- Store the window pointer
   m_checkbox4.WindowPointer(m_window1);
//--- Attach to the fourth tab item
   m_treeview.AddToElementsArray(3,m_checkbox4);
//--- Coordinates
   int x=m_window1.X()+CHECKBOX4_GAP_X;
   int y=m_window1.Y()+CHECKBOX4_GAP_Y;
//--- Set properties before creation
   m_checkbox4.XSize(200);
   m_checkbox4.YSize(18);
//--- Create control
   if(!m_checkbox4.CreateCheckBox(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_checkbox4);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create table 4                                                   |
//+------------------------------------------------------------------+
bool CProgram::CreateTable4(void)
  {
#define COLUMNS4_TOTAL (2)
#define ROWS4_TOTAL    (20)
//--- Store pointer to the form
   m_table4.WindowPointer(m_window1);
//--- Attach to the fourth tab item
   m_treeview.AddToElementsArray(3,m_table4);
//--- Coordinates
   int x=m_window1.X()+TABLE4_GAP_X;
   int y=m_window1.Y()+TABLE4_GAP_Y;
//--- The number of visible rows and columns
   int visible_columns_total =2;
   int visible_rows_total    =9;
//--- Set properties before creation
   m_table4.XSize(267);
   m_table4.RowYSize(18);
   m_table4.FixFirstRow(true);
   m_table4.LightsHover(true);
   m_table4.SelectableRow(true);
   m_table4.TextAlign(ALIGN_CENTER);
   m_table4.HeadersColor(C'255,244,213');
   m_table4.HeadersTextColor(clrBlack);
   m_table4.TableSize(COLUMNS4_TOTAL,ROWS4_TOTAL);
   m_table4.VisibleTableSize(visible_columns_total,visible_rows_total);
//--- Create control
   if(!m_table4.CreateTable(m_chart_id,m_subwin,x,y))
      return(false);
//--- Populate the table:
//    Headers for columns
   for(int c=0; c<COLUMNS4_TOTAL; c++)
     {
      for(int r=0; r<1; r++)
         m_table4.SetValue(c,r,"SYMBOL "+string(c));
     }
//--- Data and formatting of the table (background color and cell color)
   for(int c=0; c<COLUMNS4_TOTAL; c++)
     {
      for(int r=1; r<ROWS4_TOTAL; r++)
         m_table4.SetValue(c,r,string(c)+":"+string(r));
     }
//--- Update the table to display changes
   m_table4.UpdateTable();
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_table4);
   return(true);
  }
//+------------------------------------------------------------------+
