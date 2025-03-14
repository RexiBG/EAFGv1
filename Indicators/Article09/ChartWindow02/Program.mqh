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
   CWindow           m_window1;
   //--- Main menu and its context menus
   CMenuBar          m_menubar;
   CContextMenu      m_mb_contextmenu1;
   CContextMenu      m_mb_contextmenu2;
   CContextMenu      m_mb_contextmenu3;
   CContextMenu      m_mb_contextmenu4;
   //--- Status Bar
   CStatusBar        m_status_bar;
   //--- Sliders
   CSlider           m_slider1;
   //--- Progress bars
   CProgressBar      m_progress_bar1;
   CProgressBar      m_progress_bar2;
   CProgressBar      m_progress_bar3;
   CProgressBar      m_progress_bar4;
   CProgressBar      m_progress_bar5;
   CProgressBar      m_progress_bar6;
   CProgressBar      m_progress_bar7;
   CProgressBar      m_progress_bar8;
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
#define STATUSBAR1_GAP_Y      (300)
   bool              CreateStatusBar(void);
   //--- Sliders
#define SLIDER1_GAP_X         (7)
#define SLIDER1_GAP_Y         (50)
   bool              CreateSlider1(const string text);
//---
#define PROGRESSBAR1_GAP_X    (7)
#define PROGRESSBAR1_GAP_Y    (100)
   bool              CreateProgressBar1(void);
//---
#define PROGRESSBAR2_GAP_X    (7)
#define PROGRESSBAR2_GAP_Y    (125)
   bool              CreateProgressBar2(void);
//---
#define PROGRESSBAR3_GAP_X    (7)
#define PROGRESSBAR3_GAP_Y    (150)
   bool              CreateProgressBar3(void);
//---
#define PROGRESSBAR4_GAP_X    (7)
#define PROGRESSBAR4_GAP_Y    (175)
   bool              CreateProgressBar4(void);
//---
#define PROGRESSBAR5_GAP_X    (7)
#define PROGRESSBAR5_GAP_Y    (200)
   bool              CreateProgressBar5(void);
//---
#define PROGRESSBAR6_GAP_X    (7)
#define PROGRESSBAR6_GAP_Y    (225)
   bool              CreateProgressBar6(void);
//---
#define PROGRESSBAR7_GAP_X    (7)
#define PROGRESSBAR7_GAP_Y    (250)
   bool              CreateProgressBar7(void);
//---
#define PROGRESSBAR8_GAP_X    (7)
#define PROGRESSBAR8_GAP_Y    (275)
   bool              CreateProgressBar8(void);
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
//--- Number of iterations
   int total=(int)m_slider1.GetValue();
//--- Eight progress bars
   static int count1=0;
   count1=(count1>=total) ? 0 : count1+=8;
   m_progress_bar1.Update(count1,total);
//---
   static int count2=0;
   count2=(count2>=total) ? 0 : count2+=3;
   m_progress_bar2.Update(count2,total);
//---
   static int count3=0;
   count3=(count3>=total) ? 0 : count3+=12;
   m_progress_bar3.Update(count3,total);
//---
   static int count4=0;
   count4=(count4>=total) ? 0 : count4+=6;
   m_progress_bar4.Update(count4,total);
//---
   static int count5=0;
   count5=(count5>=total) ? 0 : count5+=18;
   m_progress_bar5.Update(count5,total);
//---
   static int count6=0;
   count6=(count6>=total) ? 0 : count6+=10;
   m_progress_bar6.Update(count6,total);
//---
   static int count7=0;
   count7=(count7>=total) ? 0 : count7+=1;
   m_progress_bar7.Update(count7,total);
//---
   static int count8=0;
   count8=(count8>=total) ? 0 : count8+=15;
   m_progress_bar8.Update(count8,total);
   
//--- Timer for the status bar
   static int count9=0;
   if(count9<TIMER_STEP_MSC*10)
     {
      count9+=TIMER_STEP_MSC;
      return;
     }
   count9=0;
   m_status_bar.ValueToItem(1,::TimeToString(::TimeLocal(),TIME_DATE|TIME_SECONDS));
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
//--- Status Bar
   if(!CreateStatusBar())
      return(false);

//--- Sliders
   if(!CreateSlider1("Iterations total:"))
      return(false);
//---
   if(!CreateProgressBar1())
      return(false);
   if(!CreateProgressBar2())
      return(false);
   if(!CreateProgressBar3())
      return(false);
   if(!CreateProgressBar4())
      return(false);
   if(!CreateProgressBar5())
      return(false);
   if(!CreateProgressBar6())
      return(false);
   if(!CreateProgressBar7())
      return(false);
   if(!CreateProgressBar8())
      return(false);
      
//--- Redrawing the chart
   m_chart.Redraw();
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates a form for controls                                      |
//+------------------------------------------------------------------+
bool CProgram::CreateWindow1(const string caption_text)
  {
//--- Add the window pointer to the window array
   CWndContainer::AddWindow(m_window1);
//--- Coordinates
   int x=(m_window1.X()>0) ? m_window1.X() : 1;
   int y=(m_window1.Y()>0) ? m_window1.Y() : 1;
//--- Properties
   m_window1.XSize(237);
   m_window1.YSize(325);
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
//| Creates slider 1                                                 |
//+------------------------------------------------------------------+
bool CProgram::CreateSlider1(const string text)
  {
//--- Store the window pointer
   m_slider1.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+SLIDER1_GAP_X;
   int y=m_window1.Y()+SLIDER1_GAP_Y;
//--- Value
   double v=(m_slider1.GetValue()==WRONG_VALUE) ? 1000 : m_slider1.GetValue();
//--- Set properties before creation
   m_slider1.XSize(223);
   m_slider1.YSize(40);
   m_slider1.EditXSize(87);
   m_slider1.MaxValue(5000);
   m_slider1.StepValue(1);
   m_slider1.MinValue(100);
   m_slider1.SetDigits(0);
   m_slider1.SetValue(v);
//--- Creating an element
   if(!m_slider1.CreateSlider(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_slider1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create progress bar 1                                            |
//+------------------------------------------------------------------+
bool CProgram::CreateProgressBar1(void)
  {
//--- Store pointer to the form
   m_progress_bar1.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+PROGRESSBAR1_GAP_X;
   int y=m_window1.Y()+PROGRESSBAR1_GAP_Y;
//--- Set properties before creation
   m_progress_bar1.XSize(220);
   m_progress_bar1.YSize(15);
   m_progress_bar1.BarYSize(11);
   m_progress_bar1.BarXOffset(65);
   m_progress_bar1.BarYOffset(2);
   m_progress_bar1.LabelText("Progress 01:");
//--- Creating an element
   if(!m_progress_bar1.CreateProgressBar(m_chart_id,m_subwin,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_progress_bar1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create progress bar 2                                            |
//+------------------------------------------------------------------+
bool CProgram::CreateProgressBar2(void)
  {
//--- Store pointer to the form
   m_progress_bar2.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+PROGRESSBAR2_GAP_X;
   int y=m_window1.Y()+PROGRESSBAR2_GAP_Y;
//--- Set properties before creation
   m_progress_bar2.XSize(220);
   m_progress_bar2.YSize(15);
   m_progress_bar2.BarYSize(11);
   m_progress_bar2.BarXOffset(65);
   m_progress_bar2.BarYOffset(2);
   m_progress_bar2.BarBorderWidth(0);
   m_progress_bar2.LabelText("Progress 02:");
//--- Creating an element
   if(!m_progress_bar2.CreateProgressBar(m_chart_id,m_subwin,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_progress_bar2);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create progress bar 3                                            |
//+------------------------------------------------------------------+
bool CProgram::CreateProgressBar3(void)
  {
//--- Store pointer to the form
   m_progress_bar3.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+PROGRESSBAR3_GAP_X;
   int y=m_window1.Y()+PROGRESSBAR3_GAP_Y;
//--- Set properties before creation
   m_progress_bar3.XSize(220);
   m_progress_bar3.YSize(15);
   m_progress_bar3.BarYSize(11);
   m_progress_bar3.BarXOffset(65);
   m_progress_bar3.BarYOffset(2);
   m_progress_bar3.BarBorderWidth(0);
   m_progress_bar3.LabelText("Progress 03:");
//--- Creating an element
   if(!m_progress_bar3.CreateProgressBar(m_chart_id,m_subwin,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_progress_bar3);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create progress bar 4                                            |
//+------------------------------------------------------------------+
bool CProgram::CreateProgressBar4(void)
  {
//--- Store pointer to the form
   m_progress_bar4.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+PROGRESSBAR4_GAP_X;
   int y=m_window1.Y()+PROGRESSBAR4_GAP_Y;
//--- Set properties before creation
   m_progress_bar4.XSize(220);
   m_progress_bar4.YSize(15);
   m_progress_bar4.BarYSize(11);
   m_progress_bar4.BarXOffset(65);
   m_progress_bar4.BarYOffset(2);
   m_progress_bar4.BarBorderWidth(0);
   m_progress_bar4.LabelText("Progress 04:");
//--- Creating an element
   if(!m_progress_bar4.CreateProgressBar(m_chart_id,m_subwin,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_progress_bar4);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create progress bar 5                                            |
//+------------------------------------------------------------------+
bool CProgram::CreateProgressBar5(void)
  {
//--- Store pointer to the form
   m_progress_bar5.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+PROGRESSBAR5_GAP_X;
   int y=m_window1.Y()+PROGRESSBAR5_GAP_Y;
//--- Set properties before creation
   m_progress_bar5.XSize(220);
   m_progress_bar5.YSize(15);
   m_progress_bar5.BarYSize(11);
   m_progress_bar5.BarXOffset(65);
   m_progress_bar5.BarYOffset(2);
   m_progress_bar5.BarBorderWidth(0);
   m_progress_bar5.LabelText("Progress 05:");
//--- Creating an element
   if(!m_progress_bar5.CreateProgressBar(m_chart_id,m_subwin,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_progress_bar5);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create progress bar 6                                            |
//+------------------------------------------------------------------+
bool CProgram::CreateProgressBar6(void)
  {
//--- Store pointer to the form
   m_progress_bar6.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+PROGRESSBAR6_GAP_X;
   int y=m_window1.Y()+PROGRESSBAR6_GAP_Y;
//--- Set properties before creation
   m_progress_bar6.XSize(220);
   m_progress_bar6.YSize(15);
   m_progress_bar6.BarYSize(11);
   m_progress_bar6.BarXOffset(65);
   m_progress_bar6.BarYOffset(2);
   m_progress_bar6.BarBorderWidth(0);
   m_progress_bar6.LabelText("Progress 06:");
//--- Creating an element
   if(!m_progress_bar6.CreateProgressBar(m_chart_id,m_subwin,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_progress_bar6);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create progress bar 7                                            |
//+------------------------------------------------------------------+
bool CProgram::CreateProgressBar7(void)
  {
//--- Store pointer to the form
   m_progress_bar7.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+PROGRESSBAR7_GAP_X;
   int y=m_window1.Y()+PROGRESSBAR7_GAP_Y;
//--- Set properties before creation
   m_progress_bar7.XSize(220);
   m_progress_bar7.YSize(15);
   m_progress_bar7.BarYSize(11);
   m_progress_bar7.BarXOffset(65);
   m_progress_bar7.BarYOffset(2);
   m_progress_bar7.BarBorderWidth(0);
   m_progress_bar7.LabelText("Progress 07:");
//--- Creating an element
   if(!m_progress_bar7.CreateProgressBar(m_chart_id,m_subwin,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_progress_bar7);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create progress bar 8                                            |
//+------------------------------------------------------------------+
bool CProgram::CreateProgressBar8(void)
  {
//--- Store pointer to the form
   m_progress_bar8.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+PROGRESSBAR8_GAP_X;
   int y=m_window1.Y()+PROGRESSBAR8_GAP_Y;
//--- Set properties before creation
   m_progress_bar8.XSize(220);
   m_progress_bar8.YSize(15);
   m_progress_bar8.BarYSize(11);
   m_progress_bar8.BarXOffset(65);
   m_progress_bar8.BarYOffset(2);
   m_progress_bar8.BarBorderWidth(0);
   m_progress_bar8.LabelText("Progress 08:");
//--- Creating an element
   if(!m_progress_bar8.CreateProgressBar(m_chart_id,m_subwin,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_progress_bar8);
   return(true);
  }
//+------------------------------------------------------------------+
