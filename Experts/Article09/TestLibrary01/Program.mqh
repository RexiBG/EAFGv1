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
   //--- Form 1 - main window
   CWindow           m_window1;
   //--- Form 2 - window with color picker to select a color
   CWindow           m_window2;
   //--- Main menu and its context menus
   CMenuBar          m_menubar;
   CContextMenu      m_mb_contextmenu1;
   CContextMenu      m_mb_contextmenu2;
   CContextMenu      m_mb_contextmenu3;
   CContextMenu      m_mb_contextmenu4;
   //--- Status Bar
   CStatusBar        m_status_bar;

   //--- Buttons to call the window with the color picker
   CColorButton      m_color_button1;
   CColorButton      m_color_button2;
   CColorButton      m_color_button3;
   CColorButton      m_color_button4;
   CColorButton      m_color_button5;
   //--- Color picker
   CColorPicker      m_color_picker;
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
   //--- Form 2
   bool              CreateWindow2(const string text);

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
#define STATUSBAR1_GAP_Y      (175)
   bool              CreateStatusBar(void);
   //--- Buttons to call the color picker
#define COLORBUTTON1_GAP_X    (7)
#define COLORBUTTON1_GAP_Y    (50)
   bool              CreateColorButton1(const string text);
#define COLORBUTTON2_GAP_X    (7)
#define COLORBUTTON2_GAP_Y    (75)
   bool              CreateColorButton2(const string text);
#define COLORBUTTON3_GAP_X    (7)
#define COLORBUTTON3_GAP_Y    (100)
   bool              CreateColorButton3(const string text);
#define COLORBUTTON4_GAP_X    (7)
#define COLORBUTTON4_GAP_Y    (125)
   bool              CreateColorButton4(const string text);
#define COLORBUTTON5_GAP_X    (7)
#define COLORBUTTON5_GAP_Y    (150)
   bool              CreateColorButton5(const string text);
   //--- Color picker
#define COLORPICKER_GAP_X     (1)
#define COLORPICKER_GAP_Y     (20)
   bool              CreateColorPicker(void);
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
      return;
     }
//--- Event of changing color using the color picker
   if(id==CHARTEVENT_CUSTOM+ON_CHANGE_COLOR)
     {
      ::Print(__FUNCTION__," > id: ",id,"; lparam: ",lparam,"; dparam: ",dparam,"; sparam: ",sparam);

      //---If control identifiers match
      if(lparam==m_color_picker.Id())
        {
         //--- If the response is from the first button
         if(sparam==m_color_button1.LabelText())
           {
            //--- Change color of the object which refers to the first button...
            return;
           }
         //--- If the response is from the second button
         if(sparam==m_color_button2.LabelText())
           {
            //--- Change color of the object which refers to the second button...
            return;
           }
         //--- If the response is from the third button
         if(sparam==m_color_button3.LabelText())
           {
            //--- Change color of the object which refers to the third button...
            return;
           }
         //--- If the response is from the fourth button
         if(sparam==m_color_button4.LabelText())
           {
            //--- Change color of the object which refers to the fourth button...
            return;
           }
         //--- If the response is from the fifth button
         if(sparam==m_color_button5.LabelText())
           {
            //--- Change color of the object which refers to the fifth button...
            return;
           }
        }
      return;
     }
//--- The button press event
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_BUTTON)
     {
      ::Print(__FUNCTION__," > id: ",id,"; lparam: ",lparam,"; dparam: ",dparam,"; sparam: ",sparam);

      //--- If the first button was clicked
      if(sparam==m_color_button1.LabelText())
        {
         m_color_picker.ColorButtonPointer(m_color_button1);
         return;
        }
      //--- If the second button was clicked
      if(sparam==m_color_button2.LabelText())
        {
         m_color_picker.ColorButtonPointer(m_color_button2);
         return;
        }
      //--- If the third button was clicked
      if(sparam==m_color_button3.LabelText())
        {
         m_color_picker.ColorButtonPointer(m_color_button3);
         return;
        }
      //--- If the fourth button was clicked
      if(sparam==m_color_button4.LabelText())
        {
         m_color_picker.ColorButtonPointer(m_color_button4);
         return;
        }
      //--- If the fifth button was clicked
      if(sparam==m_color_button5.LabelText())
        {
         m_color_picker.ColorButtonPointer(m_color_button5);
         return;
        }
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

//--- Button to call the color picker
   if(!CreateColorButton1("Color button 1:"))
      return(false);
   if(!CreateColorButton2("Color button 2:"))
      return(false);
   if(!CreateColorButton3("Color button 3:"))
      return(false);
   if(!CreateColorButton4("Color button 4:"))
      return(false);
   if(!CreateColorButton5("Color button 5:"))
      return(false);

//--- Creating form 2 for the color picker
   if(!CreateWindow2("COLOR PICKER"))
      return(false);
//--- Color picker
   if(!CreateColorPicker())
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
   int y=(m_window1.Y()>0) ? m_window1.Y() : 1;
//--- Properties
   m_window1.XSize(210);
   m_window1.YSize(200);
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
//| Create button to call the color picker 1                         |
//+------------------------------------------------------------------+
bool CProgram::CreateColorButton1(const string text)
  {
//--- Store the window pointer
   m_color_button1.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+COLORBUTTON1_GAP_X;
   int y=m_window1.Y()+COLORBUTTON1_GAP_Y;
//--- Set properties before creation
   m_color_button1.XSize(195);
   m_color_button1.YSize(18);
   m_color_button1.ButtonXSize(100);
   m_color_button1.ButtonYSize(18);
   m_color_button1.CurrentColor(clrRed);
//--- Create control
   if(!m_color_button1.CreateColorButton(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_color_button1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create button to call the color picker 2                         |
//+------------------------------------------------------------------+
bool CProgram::CreateColorButton2(const string text)
  {
//--- Store the window pointer
   m_color_button2.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+COLORBUTTON2_GAP_X;
   int y=m_window1.Y()+COLORBUTTON2_GAP_Y;
//--- Set properties before creation
   m_color_button2.XSize(195);
   m_color_button2.YSize(18);
   m_color_button2.ButtonXSize(100);
   m_color_button2.ButtonYSize(18);
   m_color_button2.CurrentColor(clrGold);
//--- Create control
   if(!m_color_button2.CreateColorButton(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_color_button2);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create button to call the color picker 3                         |
//+------------------------------------------------------------------+
bool CProgram::CreateColorButton3(const string text)
  {
//--- Store the window pointer
   m_color_button3.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+COLORBUTTON3_GAP_X;
   int y=m_window1.Y()+COLORBUTTON3_GAP_Y;
//--- Set properties before creation
   m_color_button3.XSize(195);
   m_color_button3.YSize(18);
   m_color_button3.ButtonXSize(100);
   m_color_button3.ButtonYSize(18);
   m_color_button3.CurrentColor(clrCornflowerBlue);
//--- Create control
   if(!m_color_button3.CreateColorButton(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_color_button3);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create button to call the color picker 4                         |
//+------------------------------------------------------------------+
bool CProgram::CreateColorButton4(const string text)
  {
//--- Store the window pointer
   m_color_button4.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+COLORBUTTON4_GAP_X;
   int y=m_window1.Y()+COLORBUTTON4_GAP_Y;
//--- Set properties before creation
   m_color_button4.XSize(195);
   m_color_button4.YSize(18);
   m_color_button4.ButtonXSize(100);
   m_color_button4.ButtonYSize(18);
   m_color_button4.CurrentColor(clrGreen);
//--- Create control
   if(!m_color_button4.CreateColorButton(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_color_button4);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create button to call the color picker 5                         |
//+------------------------------------------------------------------+
bool CProgram::CreateColorButton5(const string text)
  {
//--- Store the window pointer
   m_color_button5.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+COLORBUTTON5_GAP_X;
   int y=m_window1.Y()+COLORBUTTON5_GAP_Y;
//--- Set properties before creation
   m_color_button5.XSize(195);
   m_color_button5.YSize(18);
   m_color_button5.ButtonXSize(100);
   m_color_button5.ButtonYSize(18);
   m_color_button5.CurrentColor(clrBrown);
//--- Create control
   if(!m_color_button5.CreateColorButton(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_color_button5);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create form 2 for the color picker                               |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\color_picker.bmp"
//---
bool CProgram::CreateWindow2(const string caption_text)
  {
//--- Store the window pointer
   CWndContainer::AddWindow(m_window2);
//--- Coordinates
   int x=(m_window2.X()>0) ? m_window2.X() : 30;
   int y=(m_window2.Y()>0) ? m_window2.Y() : 30;
//--- Properties
   m_window2.Movable(true);
   m_window2.XSize(350);
   m_window2.YSize(286);
   m_window2.WindowType(W_DIALOG);
   m_window2.IconFile("Images\\EasyAndFastGUI\\Icons\\bmp16\\color_picker.bmp");
//--- Creating the form
   if(!m_window2.CreateWindow(m_chart_id,m_subwin,caption_text,x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Create color picker to select a color                            |
//+------------------------------------------------------------------+
bool CProgram::CreateColorPicker(void)
  {
//--- Store the window pointer
   m_color_picker.WindowPointer(m_window2);
//--- Coordinates
   int x=m_window2.X()+COLORPICKER_GAP_X;
   int y=m_window2.Y()+COLORPICKER_GAP_Y;
//--- Creating an element
   if(!m_color_picker.CreateColorPicker(m_chart_id,m_subwin,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(1,m_color_picker);
   return(true);
  }
//+------------------------------------------------------------------+
