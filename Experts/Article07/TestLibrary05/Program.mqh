//+------------------------------------------------------------------+
//|                                                      Program.mqh |
//|                        Copyright 2016, MetaQuotes Software Corp. |
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
   //--- Tabs
   CTabs             m_tabs;
   //--- Text label table
   CLabelsTable      m_labels_table;
   //--- Edit box table
   CTable            m_table;
   //--- Rendered table
   CCanvasTable      m_canvas_table;
   //--- Checkboxes
   CCheckBox         m_checkbox1;
   CCheckBox         m_checkbox2;
   CCheckBox         m_checkbox3;
   CCheckBox         m_checkbox4;
   //--- Check boxes with edits
   CCheckBoxEdit     m_checkboxedit1;
   CCheckBoxEdit     m_checkboxedit2;
   CCheckBoxEdit     m_checkboxedit3;
   CCheckBoxEdit     m_checkboxedit4;
   //--- Comboboxes with checkboxes
   CCheckComboBox    m_checkcombobox1;
   CCheckComboBox    m_checkcombobox2;
   CCheckComboBox    m_checkcombobox3;
   CCheckComboBox    m_checkcombobox4;
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
   //--- Create an expert panel
   bool              CreateExpertPanel(void);
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
#define STATUSBAR1_GAP_Y      (290)
   bool              CreateStatusBar(void);
   //--- Tabs
#define TABS1_GAP_X           (4)
#define TABS1_GAP_Y           (45)
   bool              CreateTabs(void);
   //--- Text label table
#define TABLE1_GAP_X          (5)
#define TABLE1_GAP_Y          (65)
   bool              CreateLabelsTable(void);
   //--- Edit box table
#define TABLE2_GAP_X          (5)
#define TABLE2_GAP_Y          (65)
   bool              CreateTable(void);
   //--- Rendered table
#define TABLE3_GAP_X          (5)
#define TABLE3_GAP_Y          (65)
   bool              CreateCanvasTable(void);
   //--- Separation line
#define SEP_LINE_GAP_X        (300)
#define SEP_LINE_GAP_Y        (70)
   bool              CreateSepLine(void);
   //--- Checkboxes
#define CHECKBOX1_GAP_X       (18)
#define CHECKBOX1_GAP_Y       (75)
   bool              CreateCheckBox1(const string text);
#define CHECKBOX2_GAP_X       (18)
#define CHECKBOX2_GAP_Y       (175)
   bool              CreateCheckBox2(const string text);
#define CHECKBOX3_GAP_X       (315)
#define CHECKBOX3_GAP_Y       (75)
   bool              CreateCheckBox3(const string text);
#define CHECKBOX4_GAP_X       (315)
#define CHECKBOX4_GAP_Y       (175)
   bool              CreateCheckBox4(const string text);
   //--- Check boxes with edits
#define CHECKBOXEDIT1_GAP_X   (40)
#define CHECKBOXEDIT1_GAP_Y   (105)
   bool              CreateCheckBoxEdit1(const string text);
#define CHECKBOXEDIT2_GAP_X   (40)
#define CHECKBOXEDIT2_GAP_Y   (135)
   bool              CreateCheckBoxEdit2(const string text);
#define CHECKBOXEDIT3_GAP_X   (337)
#define CHECKBOXEDIT3_GAP_Y   (105)
   bool              CreateCheckBoxEdit3(const string text);
#define CHECKBOXEDIT4_GAP_X   (337)
#define CHECKBOXEDIT4_GAP_Y   (135)
   bool              CreateCheckBoxEdit4(const string text);
   //--- Comboboxes with checkboxes
#define CHECKCOMBOBOX1_GAP_X  (40)
#define CHECKCOMBOBOX1_GAP_Y  (205)
   bool              CreateCheckComboBox1(const string text);
#define CHECKCOMBOBOX2_GAP_X  (40)
#define CHECKCOMBOBOX2_GAP_Y  (235)
   bool              CreateCheckComboBox2(const string text);
#define CHECKCOMBOBOX3_GAP_X  (337)
#define CHECKCOMBOBOX3_GAP_Y  (205)
   bool              CreateCheckComboBox3(const string text);
#define CHECKCOMBOBOX4_GAP_X  (337)
#define CHECKCOMBOBOX4_GAP_Y  (235)
   bool              CreateCheckComboBox4(const string text);
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
   m_status_bar.ValueToItem(1,::TimeToString(TimeLocal(),TIME_DATE|TIME_SECONDS));
//--- Redraw the chart
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
//--- The text label press event
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_LABEL)
     {
      ::Print(__FUNCTION__," > id: ",id,"; lparam: ",lparam,"; dparam: ",dparam,"; sparam: ",sparam);
      //--- If the press was on the first checkbox
      if(lparam==m_checkbox1.Id())
        {
         m_checkboxedit1.CheckBoxEditState(m_checkbox1.CheckButtonState());
         m_checkboxedit2.CheckBoxEditState(m_checkbox1.CheckButtonState());
        }
      //--- If the press was on the second checkbox
      if(lparam==m_checkbox2.Id())
        {
         m_checkcombobox1.CheckComboBoxState(m_checkbox2.CheckButtonState());
         m_checkcombobox2.CheckComboBoxState(m_checkbox2.CheckButtonState());
        }
      //--- If the press was on the third checkbox
      if(lparam==m_checkbox3.Id())
        {
         m_checkboxedit3.CheckBoxEditState(m_checkbox3.CheckButtonState());
         m_checkboxedit4.CheckBoxEditState(m_checkbox3.CheckButtonState());
        }
      //--- If the press was on the fourth checkbox
      if(lparam==m_checkbox4.Id())
        {
         m_checkcombobox3.CheckComboBoxState(m_checkbox4.CheckButtonState());
         m_checkcombobox4.CheckComboBoxState(m_checkbox4.CheckButtonState());
        }
     }
//--- The end of value entry in edit event
   if(id==CHARTEVENT_CUSTOM+ON_END_EDIT)
     {
      ::Print(__FUNCTION__," > id: ",id,"; lparam: ",lparam,"; dparam: ",dparam,"; sparam: ",sparam);
     }
//--- Switching buttons of the edit press event
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_INC || id==CHARTEVENT_CUSTOM+ON_CLICK_DEC)
     {
      ::Print(__FUNCTION__," > id: ",id,"; lparam: ",lparam,"; dparam: ",dparam,"; sparam: ",sparam);
     }
//--- Selection of item in combobox event
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_COMBOBOX_ITEM)
     {
      ::Print(__FUNCTION__," > id: ",id,"; lparam: ",lparam,"; dparam: ",dparam,"; sparam: ",sparam);
     }
  }
//+------------------------------------------------------------------+
//| Create an expert panel                                           |
//+------------------------------------------------------------------+
bool CProgram::CreateExpertPanel(void)
  {
//--- Creating form 1 for controls
   if(!CreateWindow1("EXPERT PANEL"))
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
//--- Status Bar
   if(!CreateStatusBar())
      return(false);
//--- Tabs
   if(!CreateTabs())
      return(false);
//--- Text label table
   if(!CreateLabelsTable())
      return(false);
//--- Edit box table
   if(!CreateTable())
      return(false);
//--- Create rendered table
   if(!CreateCanvasTable())
      return(false);
//--- Separation line
   if(!CreateSepLine())
      return(false);
//--- Checkboxes
   if(!CreateCheckBox1("Checkbox 1"))
      return(false);
   if(!CreateCheckBox2("Checkbox 2"))
      return(false);
   if(!CreateCheckBox3("Checkbox 3"))
      return(false);
   if(!CreateCheckBox4("Checkbox 4"))
      return(false);
//--- Check boxes with edits
   if(!CreateCheckBoxEdit1("Checkbox Edit 1:"))
      return(false);
   if(!CreateCheckBoxEdit2("Checkbox Edit 2:"))
      return(false);
   if(!CreateCheckBoxEdit3("Checkbox Edit 3:"))
      return(false);
   if(!CreateCheckBoxEdit4("Checkbox Edit 4:"))
      return(false);
//--- Comboboxes with checkboxes
   if(!CreateCheckComboBox1("CheckCombobox 1:"))
      return(false);
   if(!CreateCheckComboBox2("CheckCombobox 2:"))
      return(false);
   if(!CreateCheckComboBox3("CheckCombobox 3:"))
      return(false);
   if(!CreateCheckComboBox4("CheckCombobox 4:"))
      return(false);
//--- Display controls of the active tab only
   m_tabs.ShowTabElements();
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
   m_window1.XSize(604);
   m_window1.YSize(315);
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
//| Create area with tabs                                            |
//+------------------------------------------------------------------+
bool CProgram::CreateTabs(void)
  {
#define TABS1_TOTAL 4
//--- Pass the panel object
   m_tabs.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+TABS1_GAP_X;
   int y=m_window1.Y()+TABS1_GAP_Y;
//--- Arrays with text and width for tabs
   string tabs_text[]={"Tab 1","Tab 2","Tab 3","Tab 4"};
   int tabs_width[]={90,90,90,90};
//--- Set properties before creation
   m_tabs.XSize(596);
   m_tabs.YSize(243);
   m_tabs.TabYSize(20);
   m_tabs.PositionMode(TABS_TOP);
   m_tabs.SelectedTab((m_tabs.SelectedTab()==WRONG_VALUE) ? 0 : m_tabs.SelectedTab());
//--- Add tabs with the specified properties
   for(int i=0; i<TABS1_TOTAL; i++)
      m_tabs.AddTab(tabs_text[i],tabs_width[i]);
//--- Create control
   if(!m_tabs.CreateTabs(m_chart_id,m_subwin,x,y))
      return(false);
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_tabs);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create text label table                                          |
//+------------------------------------------------------------------+
bool CProgram::CreateLabelsTable(void)
  {
#define COLUMNS1_TOTAL (21)
#define ROWS1_TOTAL    (100)
//--- Store pointer to the form
   m_labels_table.WindowPointer(m_window1);
//--- Attach to the first tab of the first group of tabs
   m_tabs.AddToElementsArray(0,m_labels_table);
//--- Coordinates
   int x=m_window1.X()+TABLE1_GAP_X;
   int y=m_window1.Y()+TABLE1_GAP_Y;
//--- The number of visible rows and columns
   int visible_columns_total =7;
   int visible_rows_total    =12;
//--- set properties
   m_labels_table.XSize(594);
   m_labels_table.XOffset(45);
   m_labels_table.ColumnXOffset(83);
   m_labels_table.FixFirstRow(true);
   m_labels_table.FixFirstColumn(true);
   m_labels_table.AreaColor(clrWhite);
   m_labels_table.TableSize(COLUMNS1_TOTAL,ROWS1_TOTAL);
   m_labels_table.VisibleTableSize(visible_columns_total,visible_rows_total);
//--- Create table
   if(!m_labels_table.CreateLabelsTable(m_chart_id,m_subwin,x,y))
      return(false);
//--- Populate the table:
//    The first cell is empty
   m_labels_table.SetValue(0,0,"-");
//--- Headers for columns
   for(int c=1; c<COLUMNS1_TOTAL; c++)
     {
      for(int r=0; r<1; r++)
         m_labels_table.SetValue(c,r,"SYMBOL "+string(c));
     }
//--- Headers for rows, text alignment mode - right
   for(int c=0; c<1; c++)
     {
      for(int r=1; r<ROWS1_TOTAL; r++)
        m_labels_table.SetValue(c,r,"PARAMETER "+string(r));
     }
//--- Data and formatting of the table (background color and cell color)
   for(int c=1; c<COLUMNS1_TOTAL; c++)
     {
      for(int r=1; r<ROWS1_TOTAL; r++)
         m_labels_table.SetValue(c,r,string(::rand()%1000-::rand()%1000));
     }
//--- Set the color of text in table cells
   for(int c=1; c<m_labels_table.ColumnsTotal(); c++)
      for(int r=1; r<m_labels_table.RowsTotal(); r++)
         m_labels_table.TextColor(c,r,((double)m_labels_table.GetValue(c,r)>=0) ? clrGreen : clrRed);
//--- Update the table
   m_labels_table.UpdateTable();
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_labels_table);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create a table                                                   |
//+------------------------------------------------------------------+
bool CProgram::CreateTable(void)
  {
#define COLUMNS2_TOTAL (100)
#define ROWS2_TOTAL    (1000)
//--- Store pointer to the form
   m_table.WindowPointer(m_window1);
//--- Attach to the second tab of the first group of tabs
   m_tabs.AddToElementsArray(1,m_table);
//--- Coordinates
   int x=m_window1.X()+TABLE2_GAP_X;
   int y=m_window1.Y()+TABLE2_GAP_Y;
//--- The number of visible rows and columns
   int visible_columns_total =6;
   int visible_rows_total    =12;
//--- Set properties before creation
   m_table.XSize(594);
   m_table.RowYSize(18);
   m_table.FixFirstRow(true);
   m_table.FixFirstColumn(true);
   m_table.LightsHover(true);
   m_table.SelectableRow(true);
   m_table.BorderColor(clrWhite);
   m_table.TextAlign(ALIGN_CENTER);
   m_table.HeadersColor(C'255,244,213');
   m_table.HeadersTextColor(clrBlack);
   m_table.CellColorHover(clrGold);
   m_table.TableSize(COLUMNS2_TOTAL,ROWS2_TOTAL);
   m_table.VisibleTableSize(visible_columns_total,visible_rows_total);
//--- Create control
   if(!m_table.CreateTable(m_chart_id,m_subwin,x,y))
      return(false);
//--- Populate the table:
//    The first cell is empty
   m_table.SetValue(0,0,"-");
//--- Headers for columns
   for(int c=1; c<COLUMNS2_TOTAL; c++)
     {
      for(int r=0; r<1; r++)
         m_table.SetValue(c,r,"SYMBOL "+string(c));
     }
//--- Headers for rows, text alignment mode - right
   for(int c=0; c<1; c++)
     {
      for(int r=1; r<ROWS2_TOTAL; r++)
        {
         m_table.SetValue(c,r,"PARAMETER "+string(r));
         m_table.TextAlign(c,r,ALIGN_RIGHT);
        }
     }
//--- Data and formatting of the table (background color and cell color)
   for(int c=1; c<COLUMNS2_TOTAL; c++)
     {
      for(int r=1; r<ROWS2_TOTAL; r++)
        {
         m_table.SetValue(c,r,string(c)+":"+string(r));
         m_table.TextColor(c,r,(c%2==0)? clrRed : clrRoyalBlue);
         m_table.CellColor(c,r,(r%2==0)? clrWhiteSmoke : clrWhite);
        }
     }
//--- Update the table to display changes
   m_table.UpdateTable();
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_table);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create a rendered table                                          |
//+------------------------------------------------------------------+
bool CProgram::CreateCanvasTable(void)
  {
#define COLUMNS3_TOTAL 10
#define ROWS3_TOTAL    1000
//--- Store pointer to the form
   m_canvas_table.WindowPointer(m_window1);
//--- Attach to the third tab of the first group of tabs
   m_tabs.AddToElementsArray(2,m_canvas_table);
//--- Coordinates
   int x=m_window1.X()+TABLE3_GAP_X;
   int y=m_window1.Y()+TABLE3_GAP_Y;
//--- The number of visible rows
   int visible_rows_total=12;
//--- Array of column widths
   int width[COLUMNS3_TOTAL];
   ::ArrayInitialize(width,70);
   width[0]=100;
   width[1]=90;
//--- Array of text alignment in columns
   ENUM_ALIGN_MODE align[COLUMNS3_TOTAL];
   ::ArrayInitialize(align,ALIGN_CENTER);
   align[0]=ALIGN_RIGHT;
   align[1]=ALIGN_RIGHT;
   align[2]=ALIGN_RIGHT;
//--- Set properties before creation
   m_canvas_table.YSize(221);
   m_canvas_table.TableSize(COLUMNS3_TOTAL,ROWS3_TOTAL);
   m_canvas_table.TextAlign(align);
   m_canvas_table.ColumnsWidth(width);
   m_canvas_table.GridColor(clrLightGray);
   m_canvas_table.AutoXResizeMode(true);
   m_canvas_table.AutoXResizeRightOffset(5);
//--- Populate the table with data
   for(int c=0; c<COLUMNS3_TOTAL; c++)
      for(int r=0; r<ROWS3_TOTAL; r++)
         m_canvas_table.SetValue(c,r,string(c)+":"+string(r));
//--- Create control
   if(!m_canvas_table.CreateTable(m_chart_id,m_subwin,x,y))
      return(false);
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_canvas_table);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates a separation line                                        |
//+------------------------------------------------------------------+
bool CProgram::CreateSepLine(void)
  {
//--- Store the window pointer
   m_sep_line.WindowPointer(m_window1);
//--- Attach to the fourth tab of the first group of tabs
   m_tabs.AddToElementsArray(3,m_sep_line);
//--- Coordinates  
   int x=m_window1.X()+SEP_LINE_GAP_X;
   int y=m_window1.Y()+SEP_LINE_GAP_Y;
//--- Size
   int x_size=2;
   int y_size=210;
//--- Set properties before creation
   m_sep_line.DarkColor(C'213,223,229');
   m_sep_line.LightColor(clrWhite);
   m_sep_line.TypeSepLine(V_SEP_LINE);
//--- Creating an element
   if(!m_sep_line.CreateSeparateLine(m_chart_id,m_subwin,0,x,y,x_size,y_size))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_sep_line);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates checkbox 1                                               |
//+------------------------------------------------------------------+
bool CProgram::CreateCheckBox1(string text)
  {
//--- Store the window pointer
   m_checkbox1.WindowPointer(m_window1);
//--- Attach to the fourth tab of the first group of tabs
   m_tabs.AddToElementsArray(3,m_checkbox1);
//--- Coordinates
   int x=m_window1.X()+CHECKBOX1_GAP_X;
   int y=m_window1.Y()+CHECKBOX1_GAP_Y;
//--- Set properties before creation
   m_checkbox1.XSize(90);
   m_checkbox1.YSize(18);
   m_checkbox1.AreaColor(clrWhite);
//--- Create control
   if(!m_checkbox1.CreateCheckBox(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_checkbox1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates checkbox 2                                               |
//+------------------------------------------------------------------+
bool CProgram::CreateCheckBox2(string text)
  {
//--- Store the window pointer
   m_checkbox2.WindowPointer(m_window1);
//--- Attach to the fourth tab of the first group of tabs
   m_tabs.AddToElementsArray(3,m_checkbox2);
//--- Coordinates
   int x=m_window1.X()+CHECKBOX2_GAP_X;
   int y=m_window1.Y()+CHECKBOX2_GAP_Y;
//--- Set properties before creation
   m_checkbox2.XSize(90);
   m_checkbox2.YSize(18);
   m_checkbox2.AreaColor(clrWhite);
//--- Create control
   if(!m_checkbox2.CreateCheckBox(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_checkbox2);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates checkbox 3                                               |
//+------------------------------------------------------------------+
bool CProgram::CreateCheckBox3(string text)
  {
//--- Store the window pointer
   m_checkbox3.WindowPointer(m_window1);
//--- Attach to the fourth tab of the first group of tabs
   m_tabs.AddToElementsArray(3,m_checkbox3);
//--- Coordinates
   int x=m_window1.X()+CHECKBOX3_GAP_X;
   int y=m_window1.Y()+CHECKBOX3_GAP_Y;
//--- Set properties before creation
   m_checkbox3.XSize(90);
   m_checkbox3.YSize(18);
   m_checkbox3.AreaColor(clrWhite);
//--- Create control
   if(!m_checkbox3.CreateCheckBox(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_checkbox3);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates checkbox 4                                               |
//+------------------------------------------------------------------+
bool CProgram::CreateCheckBox4(string text)
  {
//--- Store the window pointer
   m_checkbox4.WindowPointer(m_window1);
//--- Attach to the fourth tab of the first group of tabs
   m_tabs.AddToElementsArray(3,m_checkbox4);
//--- Coordinates
   int x=m_window1.X()+CHECKBOX4_GAP_X;
   int y=m_window1.Y()+CHECKBOX4_GAP_Y;
//--- Set properties before creation
   m_checkbox4.XSize(90);
   m_checkbox4.YSize(18);
   m_checkbox4.AreaColor(clrWhite);
//--- Create control
   if(!m_checkbox4.CreateCheckBox(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_checkbox4);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create checkbox with edit control 1                              |
//+------------------------------------------------------------------+
bool CProgram::CreateCheckBoxEdit1(string text)
  {
//--- Store the window pointer
   m_checkboxedit1.WindowPointer(m_window1);
//--- Attach to the fourth tab of the first group of tabs
   m_tabs.AddToElementsArray(3,m_checkboxedit1);
//--- Coordinates
   int x=m_window1.X()+CHECKBOXEDIT1_GAP_X;
   int y=m_window1.Y()+CHECKBOXEDIT1_GAP_Y;
//--- Value
   double v=(m_checkboxedit1.GetValue()<0) ? ::rand()%1000 : m_checkboxedit1.GetValue();
//--- Set properties before creation
   m_checkboxedit1.XSize(250);
   m_checkboxedit1.YSize(18);
   m_checkboxedit1.EditXSize(75);
   m_checkboxedit1.MaxValue(1000);
   m_checkboxedit1.MinValue(1);
   m_checkboxedit1.StepValue(1);
   m_checkboxedit1.SetDigits(0);
   m_checkboxedit1.SetValue(v);
   m_checkboxedit1.AreaColor(clrWhite);
//--- Create control
   if(!m_checkboxedit1.CreateCheckBoxEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- The availability will depend on the current state of the third checkbox
   m_checkboxedit1.CheckBoxEditState(m_checkbox1.CheckButtonState());
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_checkboxedit1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create checkbox with edit control 2                              |
//+------------------------------------------------------------------+
bool CProgram::CreateCheckBoxEdit2(string text)
  {
//--- Store the window pointer
   m_checkboxedit2.WindowPointer(m_window1);
//--- Attach to the fourth tab of the first group of tabs
   m_tabs.AddToElementsArray(3,m_checkboxedit2);
//--- Coordinates
   int x=m_window1.X()+CHECKBOXEDIT2_GAP_X;
   int y=m_window1.Y()+CHECKBOXEDIT2_GAP_Y;
//--- Value
   double v=(m_checkboxedit2.GetValue()<0) ? ::rand()%1000 : m_checkboxedit2.GetValue();
//--- Set properties before creation
   m_checkboxedit2.XSize(250);
   m_checkboxedit2.YSize(18);
   m_checkboxedit2.EditXSize(75);
   m_checkboxedit2.MaxValue(1000);
   m_checkboxedit2.MinValue(1);
   m_checkboxedit2.StepValue(1);
   m_checkboxedit2.SetDigits(0);
   m_checkboxedit2.SetValue(v);
   m_checkboxedit2.AreaColor(clrWhite);
//--- Create control
   if(!m_checkboxedit2.CreateCheckBoxEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- The availability will depend on the current state of the third checkbox
   m_checkboxedit2.CheckBoxEditState(m_checkbox1.CheckButtonState());
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_checkboxedit2);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create checkbox with edit control 3                              |
//+------------------------------------------------------------------+
bool CProgram::CreateCheckBoxEdit3(string text)
  {
//--- Store the window pointer
   m_checkboxedit3.WindowPointer(m_window1);
//--- Attach to the fourth tab of the first group of tabs
   m_tabs.AddToElementsArray(3,m_checkboxedit3);
//--- Coordinates
   int x=m_window1.X()+CHECKBOXEDIT3_GAP_X;
   int y=m_window1.Y()+CHECKBOXEDIT3_GAP_Y;
//--- Value
   double v=(m_checkboxedit3.GetValue()<0) ? ::rand()%1000 : m_checkboxedit3.GetValue();
//--- Set properties before creation
   m_checkboxedit3.XSize(250);
   m_checkboxedit3.YSize(18);
   m_checkboxedit3.EditXSize(75);
   m_checkboxedit3.MaxValue(1000);
   m_checkboxedit3.MinValue(1);
   m_checkboxedit3.StepValue(1);
   m_checkboxedit3.SetDigits(0);
   m_checkboxedit3.SetValue(v);
   m_checkboxedit3.AreaColor(clrWhite);
//--- Create control
   if(!m_checkboxedit3.CreateCheckBoxEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- The availability will depend on the current state of the third checkbox
   m_checkboxedit3.CheckBoxEditState(m_checkbox2.CheckButtonState());
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_checkboxedit3);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create checkbox with edit control 4                              |
//+------------------------------------------------------------------+
bool CProgram::CreateCheckBoxEdit4(string text)
  {
//--- Store the window pointer
   m_checkboxedit4.WindowPointer(m_window1);
//--- Attach to the fourth tab of the first group of tabs
   m_tabs.AddToElementsArray(3,m_checkboxedit4);
//--- Coordinates
   int x=m_window1.X()+CHECKBOXEDIT4_GAP_X;
   int y=m_window1.Y()+CHECKBOXEDIT4_GAP_Y;
//--- Value
   double v=(m_checkboxedit4.GetValue()<0) ? ::rand()%1000 : m_checkboxedit4.GetValue();
//--- Set properties before creation
   m_checkboxedit4.XSize(250);
   m_checkboxedit4.YSize(18);
   m_checkboxedit4.EditXSize(75);
   m_checkboxedit4.MaxValue(1000);
   m_checkboxedit4.MinValue(1);
   m_checkboxedit4.StepValue(1);
   m_checkboxedit4.SetDigits(0);
   m_checkboxedit4.SetValue(v);
   m_checkboxedit4.AreaColor(clrWhite);
//--- Create control
   if(!m_checkboxedit4.CreateCheckBoxEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- The availability will depend on the current state of the third checkbox
   m_checkboxedit4.CheckBoxEditState(m_checkbox2.CheckButtonState());
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_checkboxedit4);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates check-combo box 1                                        |
//+------------------------------------------------------------------+
bool CProgram::CreateCheckComboBox1(const string text)
  {
//--- Store the window pointer
   m_checkcombobox1.WindowPointer(m_window1);
//--- Attach to the fourth tab of the first group of tabs
   m_tabs.AddToElementsArray(3,m_checkcombobox1);
//--- Coordinates
   int x=m_window1.X()+CHECKCOMBOBOX1_GAP_X;
   int y=m_window1.Y()+CHECKCOMBOBOX1_GAP_Y;
//--- List view contents
   string m_tf[21]=
     {
      "item 1","item 2","item 3","item 4","item 5","item 6","item 7","item 8","item 9","item 10",
      "item 11","item 12","item 13","item 14","item 15","item 16","item 17","item 18","item 19","item 20","item 21"
     };
//--- Set properties before creation
   m_checkcombobox1.XSize(246);
   m_checkcombobox1.YSize(18);
   m_checkcombobox1.ButtonXSize(87);
   m_checkcombobox1.ItemsTotal(21);
   m_checkcombobox1.VisibleItemsTotal(5);
   m_checkcombobox1.AreaColor(clrWhite);
//--- List properties
   CListView *lv=m_checkcombobox1.GetListViewPointer();
   lv.LightsHover(true);
   lv.SelectedItemByIndex(lv.SelectedItemIndex()==WRONG_VALUE ? 4 : lv.SelectedItemIndex());
//--- Save the values to the list
   for(int i=0; i<21; i++)
      m_checkcombobox1.ValueToList(i,m_tf[i]);
//--- Create control
   if(!m_checkcombobox1.CreateCheckComboBox(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- The availability will depend on the current state of the fourth checkbox
   m_checkcombobox1.CheckComboBoxState(m_checkbox2.CheckButtonState());
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_checkcombobox1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates check-combo box 2                                        |
//+------------------------------------------------------------------+
bool CProgram::CreateCheckComboBox2(const string text)
  {
//--- Store the window pointer
   m_checkcombobox2.WindowPointer(m_window1);
//--- Attach to the fourth tab of the first group of tabs
   m_tabs.AddToElementsArray(3,m_checkcombobox2);
//--- Coordinates
   int x=m_window1.X()+CHECKCOMBOBOX2_GAP_X;
   int y=m_window1.Y()+CHECKCOMBOBOX2_GAP_Y;
//--- List view contents
   string m_tf[21]=
     {
      "item 1","item 2","item 3","item 4","item 5","item 6","item 7","item 8","item 9","item 10",
      "item 11","item 12","item 13","item 14","item 15","item 16","item 17","item 18","item 19","item 20","item 21"
     };
//--- Set properties before creation
   m_checkcombobox2.XSize(246);
   m_checkcombobox2.YSize(18);
   m_checkcombobox2.ButtonXSize(87);
   m_checkcombobox2.ItemsTotal(21);
   m_checkcombobox2.VisibleItemsTotal(5);
   m_checkcombobox2.AreaColor(clrWhite);
//--- List properties
   CListView *lv=m_checkcombobox2.GetListViewPointer();
   lv.LightsHover(true);
   lv.SelectedItemByIndex(lv.SelectedItemIndex()==WRONG_VALUE ? 8 : lv.SelectedItemIndex());
//--- Save the values to the list
   for(int i=0; i<21; i++)
      m_checkcombobox2.ValueToList(i,m_tf[i]);
//--- Create control
   if(!m_checkcombobox2.CreateCheckComboBox(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- The availability will depend on the current state of the fourth checkbox
   m_checkcombobox2.CheckComboBoxState(m_checkbox2.CheckButtonState());
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_checkcombobox2);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates check-combo box 3                                        |
//+------------------------------------------------------------------+
bool CProgram::CreateCheckComboBox3(const string text)
  {
//--- Store the window pointer
   m_checkcombobox3.WindowPointer(m_window1);
//--- Attach to the fourth tab of the first group of tabs
   m_tabs.AddToElementsArray(3,m_checkcombobox3);
//--- Coordinates
   int x=m_window1.X()+CHECKCOMBOBOX3_GAP_X;
   int y=m_window1.Y()+CHECKCOMBOBOX3_GAP_Y;
//--- List view contents
   string m_tf[21]=
     {
      "item 1","item 2","item 3","item 4","item 5","item 6","item 7","item 8","item 9","item 10",
      "item 11","item 12","item 13","item 14","item 15","item 16","item 17","item 18","item 19","item 20","item 21"
     };
//--- Set properties before creation
   m_checkcombobox3.XSize(246);
   m_checkcombobox3.YSize(18);
   m_checkcombobox3.ButtonXSize(87);
   m_checkcombobox3.ItemsTotal(21);
   m_checkcombobox3.VisibleItemsTotal(5);
   m_checkcombobox3.AreaColor(clrWhite);
//--- List properties
   CListView *lv=m_checkcombobox3.GetListViewPointer();
   lv.LightsHover(true);
   lv.SelectedItemByIndex(lv.SelectedItemIndex()==WRONG_VALUE ? 20 : lv.SelectedItemIndex());
//--- Save the values to the list
   for(int i=0; i<21; i++)
      m_checkcombobox3.ValueToList(i,m_tf[i]);
//--- Create control
   if(!m_checkcombobox3.CreateCheckComboBox(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- The availability will depend on the current state of the fourth checkbox
   m_checkcombobox3.CheckComboBoxState(m_checkbox4.CheckButtonState());
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_checkcombobox3);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates check-combo box 4                                        |
//+------------------------------------------------------------------+
bool CProgram::CreateCheckComboBox4(const string text)
  {
//--- Store the window pointer
   m_checkcombobox4.WindowPointer(m_window1);
//--- Attach to the fourth tab of the first group of tabs
   m_tabs.AddToElementsArray(3,m_checkcombobox4);
//--- Coordinates
   int x=m_window1.X()+CHECKCOMBOBOX4_GAP_X;
   int y=m_window1.Y()+CHECKCOMBOBOX4_GAP_Y;
//--- List view contents
   string m_tf[21]=
     {
      "item 1","item 2","item 3","item 4","item 5","item 6","item 7","item 8","item 9","item 10",
      "item 11","item 12","item 13","item 14","item 15","item 16","item 17","item 18","item 19","item 20","item 21"
     };
//--- Set properties before creation
   m_checkcombobox4.XSize(246);
   m_checkcombobox4.YSize(18);
   m_checkcombobox4.ButtonXSize(87);
   m_checkcombobox4.ItemsTotal(21);
   m_checkcombobox4.VisibleItemsTotal(5);
   m_checkcombobox4.AreaColor(clrWhite);
//--- List properties
   CListView *lv=m_checkcombobox4.GetListViewPointer();
   lv.LightsHover(true);
   lv.SelectedItemByIndex(lv.SelectedItemIndex()==WRONG_VALUE ? 18 : lv.SelectedItemIndex());
//--- Save the values to the list
   for(int i=0; i<21; i++)
      m_checkcombobox4.ValueToList(i,m_tf[i]);
//--- Create control
   if(!m_checkcombobox4.CreateCheckComboBox(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- The availability will depend on the current state of the fourth checkbox
   m_checkcombobox4.CheckComboBoxState(m_checkbox4.CheckButtonState());
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_checkcombobox4);
   return(true);
  }
//+------------------------------------------------------------------+
