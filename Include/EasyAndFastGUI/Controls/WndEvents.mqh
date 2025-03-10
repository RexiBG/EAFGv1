//+------------------------------------------------------------------+
//|                                                    WndEvents.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Defines.mqh"
#include "WndContainer.mqh"
//+------------------------------------------------------------------+
//| Class for event handling                                         |
//+------------------------------------------------------------------+
class CWndEvents : public CWndContainer
  {
protected:
   //--- Class instance for managing the chart
   CChart            m_chart;
   //--- Identifier and window number of the chart
   long              m_chart_id;
   int               m_subwin;
   //--- Program name
   string            m_program_name;
   //--- Short name of the indicator
   string            m_indicator_shortname;
   //--- Index of the active window
   int               m_active_window_index;
   //---
private:
   //--- Event parameters
   int               m_id;
   long              m_lparam;
   double            m_dparam;
   string            m_sparam;
   //---
protected:
                     CWndEvents(void);
                    ~CWndEvents(void);
   //--- Virtual chart event handler
   virtual void      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam) {}
   //--- Timer
   void              OnTimerEvent(void);
   //---
public:
   //--- Chart event handler
   void              ChartEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
   //---
private:
   void              ChartEventCustom(void);
   void              ChartEventClick(void);
   void              ChartEventMouseMove(void);
   void              ChartEventObjectClick(void);
   void              ChartEventEndEdit(void);
   void              ChartEventChartChange(void);
   //--- Checking events in controls
   void              CheckElementsEvents(void);
   //--- Identifying the sub-window number
   void              DetermineSubwindow(void);
   //--- Checking and updating the program window number
   void              CheckSubwindowNumber(void);
   //--- Initialization of event parameters
   void              InitChartEventsParams(const int id,const long lparam,const double dparam,const string sparam);
   //--- Moving the window
   void              MovingWindow(void);
   //--- Checking events of all elements by timer
   void              CheckElementsEventsTimer(void);
   //--- Setting the chart state
   void              SetChartState(void);
   //---
protected:
   //--- Redraw the window
   void              ResetWindow(void);
   //--- Removing the interface
   void              Destroy(void);
   //---
private:
   //--- Minimizing/maximizing the form
   bool              OnWindowRollUp(void);
   bool              OnWindowUnroll(void);
   //--- Handle changing the window sizes
   bool              OnWindowChangeSize(void);
   //--- Hiding all context menus below the initiating item
   bool              OnHideBackContextMenus(void);
   //--- Hiding all context menus
   bool              OnHideContextMenus(void);

   //--- Opening a dialog window
   bool              OnOpenDialogBox(void);
   //--- Closing a dialog window
   bool              OnCloseDialogBox(void);
   //--- Zeroing the color of the form and its elements
   bool              OnResetWindowColors(void);
   //--- Resetting priorities of the left mouse button click
   bool              OnZeroPriorities(void);
   //--- Restoring priorities of the left mouse click
   bool              OnSetPriorities(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CWndEvents::CWndEvents(void) : m_chart_id(0),
                               m_subwin(0),
                               m_active_window_index(0),
                               m_indicator_shortname(""),
                               m_program_name(PROGRAM_NAME)

  {
//--- Start the timer
   if(!::MQLInfoInteger(MQL_TESTER))
      ::EventSetMillisecondTimer(TIMER_STEP_MSC);
//--- Get the ID of the current chart
   m_chart.Attach();
//--- Enable tracking of mouse events
   m_chart.EventMouseMove(true);
//--- Identifying the sub-window number
   DetermineSubwindow();
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CWndEvents::~CWndEvents(void)
  {
//--- Delete the timer
   ::EventKillTimer();
//--- Enable management
   m_chart.MouseScroll(true);
   m_chart.SetInteger(CHART_DRAG_TRADE_LEVELS,true);
//--- Disable tracking of mouse events
   m_chart.EventMouseMove(false);
//--- Detach from the chart
   m_chart.Detach();
//--- Erase the comment   
   ::Comment("");
  }
//+------------------------------------------------------------------+
//| Initialization of event variables                                |
//+------------------------------------------------------------------+
void CWndEvents::InitChartEventsParams(const int id,const long lparam,const double dparam,const string sparam)
  {
   m_id     =id;
   m_lparam =lparam;
   m_dparam =dparam;
   m_sparam =sparam;
  }
//+------------------------------------------------------------------+
//| Handling program events                                          |
//+------------------------------------------------------------------+
void CWndEvents::ChartEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- Leave, if the array is empty
   if(CWndContainer::WindowsTotal()<1)
      return;
//--- Initialization of the event parameter fields
   InitChartEventsParams(id,lparam,dparam,sparam);
//--- Get the mouse parameters
   m_mouse.OnEvent(id,lparam,dparam,sparam);
//--- Custom event
   ChartEventCustom();
//--- Checking events of the interface elements
   CheckElementsEvents();
//--- Mouse movement event
   ChartEventMouseMove();
//--- The chart properties change event
   ChartEventChartChange();
  }
//+------------------------------------------------------------------+
//| Checking control events                                          |
//+------------------------------------------------------------------+
void CWndEvents::CheckElementsEvents(void)
  {
   int elements_total=CWndContainer::ElementsTotal(m_active_window_index);
   for(int e=0; e<elements_total; e++)
      m_wnd[m_active_window_index].m_elements[e].OnEvent(m_id,m_lparam,m_dparam,m_sparam);
//--- Forwarding the event to the application file
   OnEvent(m_id,m_lparam,m_dparam,m_sparam);
  }
//+------------------------------------------------------------------+
//| CHARTEVENT_CUSTOM event                                          |
//+------------------------------------------------------------------+
void CWndEvents::ChartEventCustom(void)
  {
//--- If the signal is to minimize the form
   if(OnWindowRollUp())
      return;
//--- If the signal is to maximize the form
   if(OnWindowUnroll())
      return;
//--- If the signal is to resize the controls
   if(OnWindowChangeSize())
      return;
//--- If the signal is to hide the context menus below the initiating menu item
   if(OnHideBackContextMenus())
      return;
//--- If the signal is to hide all context menus
   if(OnHideContextMenus())
      return;

//--- If the signal is to open a dialog window
   if(OnOpenDialogBox())
      return;
//--- If the signal is to close a dialog window
   if(OnCloseDialogBox())
      return;
//--- If the signal is to zero the colors of all elements on the specified form
   if(OnResetWindowColors())
      return;
//--- If the signal is to reset the priorities of the left mouse button click
   if(OnZeroPriorities())
      return;
//--- If the signal is to restore the priorities of the left mouse button click
   if(OnSetPriorities())
      return;
  }
//+------------------------------------------------------------------+
//| ON_WINDOW_ROLLUP event                                           |
//+------------------------------------------------------------------+
bool CWndEvents::OnWindowRollUp(void)
  {
//--- If the signal is to minimize the form
   if(m_id!=CHARTEVENT_CUSTOM+ON_WINDOW_ROLLUP)
      return(false);
//--- If the window identifier and the sub-window number match
   if(m_lparam==m_windows[0].Id() && (int)m_dparam==m_subwin)
     {
      int elements_total=CWndContainer::ElementsTotal(0);
      for(int e=0; e<elements_total; e++)
        {
         //--- Hide all elements except the form
         if(m_wnd[0].m_elements[e].ClassName()!="CWindow")
            m_wnd[0].m_elements[e].Hide();
        }
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ON_WINDOW_UNROLL event                                           |
//+------------------------------------------------------------------+
bool CWndEvents::OnWindowUnroll(void)
  {
//--- If the signal is to "Maximize the form"
   if(m_id!=CHARTEVENT_CUSTOM+ON_WINDOW_UNROLL)
      return(false);
//--- Index of the active window
   int awi=m_active_window_index;
//--- If the window identifier and the sub-window number match
   if(m_lparam==m_windows[awi].Id() && (int)m_dparam==m_subwin)
     {
      int elements_total=CWndContainer::ElementsTotal(awi);
      for(int e=0; e<elements_total; e++)
        {
         //--- Make all elements visible except the form and ...
         if(m_wnd[awi].m_elements[e].ClassName()!="CWindow")
           {
            //--- ... the drop down controls
            if(!m_wnd[awi].m_elements[e].IsDropdown())
               m_wnd[awi].m_elements[e].Show();
           }
        }
      //--- If there are tabs, show controls of the selected tab only
      int tabs_total=CWndContainer::TabsTotal(awi);
      for(int t=0; t<tabs_total; t++)
         m_wnd[awi].m_tabs[t].ShowTabElements();
      //--- If there are tree views, then show controls of the selected tab item only
      int treeview_total=CWndContainer::TreeViewListsTotal(awi);
      for(int tv=0; tv<treeview_total; tv++)
         m_wnd[awi].m_treeview_lists[tv].ShowTabElements();
     }
//--- Update location of all elements
   MovingWindow();
   m_chart.Redraw();
   return(true);
  }
//+------------------------------------------------------------------+
//| ON_WINDOW_CHANGE_SIZE event                                      |
//+------------------------------------------------------------------+
bool CWndEvents::OnWindowChangeSize(void)
  {
//--- If the signal is to "Resize the controls"
   if(m_id!=CHARTEVENT_CUSTOM+ON_WINDOW_CHANGE_SIZE)
      return(false);
//--- Index of the active window
   int awi=m_active_window_index;
//--- If the window identifiers match
   if(m_lparam!=m_windows[awi].Id())
      return(true);
//--- Change the width of all controls except the form
   int elements_total=CWndContainer::ElementsTotal(awi);
   for(int e=0; e<elements_total; e++)
     {
      if(m_wnd[awi].m_elements[e].ClassName()=="CWindow")
         continue;
      //---
      if(m_wnd[awi].m_elements[e].AutoXResizeMode())
         m_wnd[awi].m_elements[e].ChangeWidthByRightWindowSide();
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ON_HIDE_BACK_CONTEXTMENUS events                                 |
//+------------------------------------------------------------------+
bool CWndEvents::OnHideBackContextMenus(void)
  {
//--- If the signal is to hide the context menus below the initiating menu item
   if(m_id!=CHARTEVENT_CUSTOM+ON_HIDE_BACK_CONTEXTMENUS)
      return(false);
//--- Iterate over all menus from the last called
   int awi=m_active_window_index;
   int context_menus_total=CWndContainer::ContextMenusTotal(awi);
   for(int i=context_menus_total-1; i>=0; i--)
     {
      //--- Pointers to the context menu and its previous node
      CContextMenu *cm=m_wnd[awi].m_context_menus[i];
      CMenuItem    *mi=cm.PrevNodePointer();
      //--- If there is nothing after that point, then...
      if(::CheckPointer(mi)==POINTER_INVALID)
         continue;
      //--- If made it to the signal initiating item, then...
      if(mi.Id()==m_lparam)
        {
         //--- ...if its context menu has no focus, hide it
         if(!cm.MouseFocus())
            cm.Hide();
         //--- If there is nothing after that point, then...
         if(::CheckPointer(mi.PrevNodePointer())==POINTER_INVALID)
           {
            //--- ...unblock the window
            m_windows[awi].IsLocked(false);
           }
         //--- Stop the loop
         break;
        }
      else
        {
         //--- Hide the context menu
         cm.Hide();
        }
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ON_HIDE_CONTEXTMENUS event                                       |
//+------------------------------------------------------------------+
bool CWndEvents::OnHideContextMenus(void)
  {
//--- If the signal is to hide all context menus
   if(m_id!=CHARTEVENT_CUSTOM+ON_HIDE_CONTEXTMENUS)
      return(false);
//--- Hide all context menus
   int awi=m_active_window_index;
   int cm_total=CWndContainer::ContextMenusTotal(awi);
   for(int i=0; i<cm_total; i++)
      m_wnd[awi].m_context_menus[i].Hide();
//--- Disable main menus
   int menu_bars_total=CWndContainer::MenuBarsTotal(awi);
   for(int i=0; i<menu_bars_total; i++)
      m_wnd[awi].m_menu_bars[i].State(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ON_OPEN_DIALOG_BOX event                                         |
//+------------------------------------------------------------------+
bool CWndEvents::OnOpenDialogBox(void)
  {
//--- If the signal is to open a dialog window
   if(m_id!=CHARTEVENT_CUSTOM+ON_OPEN_DIALOG_BOX)
      return(false);
//--- Leave, if the message is from another program
   if(m_sparam!=m_program_name)
      return(true);
//--- Iterate over the window array
   int window_total=CWndContainer::WindowsTotal();
   for(int w=0; w<window_total; w++)
     {
      //--- If identifiers match
      if(m_windows[w].Id()==m_lparam)
        {
         //--- Store the index of the window in the form from which the form was brought up
         m_windows[w].PrevActiveWindowIndex(m_active_window_index);
         //--- Activate the form
         m_windows[w].State(true);
         //--- Restore priorities of the left mouse click to the form objects
         m_windows[w].SetZorders();
         //--- Store the index of the activated window
         m_active_window_index=w;
         //--- Make all elements of the activated window visible
         int elements_total=CWndContainer::ElementsTotal(w);
         for(int e=0; e<elements_total; e++)
           {
            //--- Skip the forms and drop-down elements
            if(m_wnd[w].m_elements[e].ClassName()=="CWindow" || 
               m_wnd[w].m_elements[e].IsDropdown())
               continue;
            //--- Make the element visible
            m_wnd[w].m_elements[e].Show();
            //--- Restore the priority of the left mouse click to the element
            m_wnd[w].m_elements[e].SetZorders();
           }
         //--- Hiding tooltips
         int tooltips_total=CWndContainer::TooltipsTotal(m_windows[w].PrevActiveWindowIndex());
         for(int t=0; t<tooltips_total; t++)
            m_wnd[m_windows[w].PrevActiveWindowIndex()].m_tooltips[t].FadeOutTooltip();
         //--- If there are tabs, show controls of the selected tab only
         int tabs_total=CWndContainer::TabsTotal(w);
         for(int t=0; t<tabs_total; t++)
            m_wnd[w].m_tabs[t].ShowTabElements();
         //--- If there are tree views, then show controls of the selected tab item only
         int treeview_total=CWndContainer::TreeViewListsTotal(w);
         for(int tv=0; tv<treeview_total; tv++)
            m_wnd[w].m_treeview_lists[tv].ShowTabElements();
        }
      //--- Other forms will be blocked until the activated window is closed
      else
        {
         //--- Block the form
         m_windows[w].State(false);
         //--- Zero priorities of the left mouse click for the form elements
         int elements_total=CWndContainer::ElementsTotal(w);
         for(int e=0; e<elements_total; e++)
            m_wnd[w].m_elements[e].ResetZorders();
        }
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ON_CLOSE_DIALOG_BOX event                                        |
//+------------------------------------------------------------------+
bool CWndEvents::OnCloseDialogBox(void)
  {
//--- If the signal is to close a dialog window
   if(m_id!=CHARTEVENT_CUSTOM+ON_CLOSE_DIALOG_BOX)
      return(false);
//--- Iterate over the window array
   int window_total=CWndContainer::WindowsTotal();
   for(int w=0; w<window_total; w++)
     {
      //--- If identifiers match
      if(m_windows[w].Id()==m_lparam)
        {
         //--- Block the form
         m_windows[w].State(false);
         //--- Hide the form
         int elements_total=CWndContainer::ElementsTotal(w);
         for(int e=0; e<elements_total; e++)
            m_wnd[w].m_elements[e].Hide();
         //--- Activate the previous form
         m_windows[int(m_dparam)].State(true);
         //--- Redrawing the chart
         m_chart.Redraw();
         break;
        }
     }
//--- Setting the index of the previous window
   m_active_window_index=int(m_dparam);
//--- Restoring priorities of the left mouse click to the activated window
   int elements_total=CWndContainer::ElementsTotal(m_active_window_index);
   for(int e=0; e<elements_total; e++)
      m_wnd[m_active_window_index].m_elements[e].SetZorders();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ON_RESET_WINDOW_COLORS event                                     |
//+------------------------------------------------------------------+
bool CWndEvents::OnResetWindowColors(void)
  {
//--- If the signal is to zero the window color
   if(m_id!=CHARTEVENT_CUSTOM+ON_RESET_WINDOW_COLORS)
      return(false);
//--- To identify the index of the form from which the message was received
   int index=WRONG_VALUE;
//--- Iterate over the window array
   int window_total=CWndContainer::WindowsTotal();
   for(int w=0; w<window_total; w++)
     {
      //--- If identifiers match
      if(m_windows[w].Id()==m_lparam)
        {
         //--- Store the index
         index=w;
         //--- Zero the color of the form
         m_windows[w].ResetColors();
         break;
        }
     }
//--- Leave, if the index was not identified
   if(index==WRONG_VALUE)
      return(true);
//--- Zero colors of all form elements
   int elements_total=CWndContainer::ElementsTotal(index);
   for(int e=0; e<elements_total; e++)
      m_wnd[index].m_elements[e].ResetColors();
//--- Redrawing the chart
   m_chart.Redraw();
   return(true);
  }
//+------------------------------------------------------------------+
//| ON_ZERO_PRIORITIES event                                         |
//+------------------------------------------------------------------+
bool CWndEvents::OnZeroPriorities(void)
  {
//--- If the signal is to zero priorities of the left mouse click
   if(m_id!=CHARTEVENT_CUSTOM+ON_ZERO_PRIORITIES)
      return(false);
//---
   int elements_total=CWndContainer::ElementsTotal(m_active_window_index);
   for(int e=0; e<elements_total; e++)
     {
      //--- Zero priorities of all elements except the one with the id passed in the event and ...
      if(m_lparam!=m_wnd[m_active_window_index].m_elements[e].Id())
        {
         //--- ... except context menus
         if(m_wnd[m_active_window_index].m_elements[e].ClassName()=="CMenuItem" ||
            m_wnd[m_active_window_index].m_elements[e].ClassName()=="CContextMenu")
            continue;
         //---
         m_wnd[m_active_window_index].m_elements[e].ResetZorders();
        }
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ON_SET_PRIORITIES event                                          |
//+------------------------------------------------------------------+
bool CWndEvents::OnSetPriorities(void)
  {
//--- If the signal is to restore the priorities of the left mouse button click
   if(m_id!=CHARTEVENT_CUSTOM+ON_SET_PRIORITIES)
      return(false);
//---
   int elements_total=CWndContainer::ElementsTotal(m_active_window_index);
   for(int e=0; e<elements_total; e++)
      m_wnd[m_active_window_index].m_elements[e].SetZorders();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| CHARTEVENT CLICK event                                           |
//+------------------------------------------------------------------+
void CWndEvents::ChartEventClick(void)
  {
  }
//+------------------------------------------------------------------+
//| CHARTEVENT MOUSE MOVE event                                      |
//+------------------------------------------------------------------+
void CWndEvents::ChartEventMouseMove(void)
  {
//--- Leave, if this is not a cursor displacement event
   if(m_id!=CHARTEVENT_MOUSE_MOVE)
      return;
//--- Moving the window
   MovingWindow();
//--- Setting the chart state
   SetChartState();
//--- Redraw chart
   m_chart.Redraw();
  }
//+------------------------------------------------------------------+
//| CHARTEVENT OBJECT CLICK event                                    |
//+------------------------------------------------------------------+
void CWndEvents::ChartEventObjectClick(void)
  {
  }
//+------------------------------------------------------------------+
//| CHARTEVENT OBJECT ENDEDIT event                                  |
//+------------------------------------------------------------------+
void CWndEvents::ChartEventEndEdit(void)
  {
  }
//+------------------------------------------------------------------+
//| CHARTEVENT CHART CHANGE event                                    |
//+------------------------------------------------------------------+
void CWndEvents::ChartEventChartChange(void)
  {
//--- The chart properties change event
   if(m_id!=CHARTEVENT_CHART_CHANGE)
      return;
//--- Checking and updating the program window number
   CheckSubwindowNumber();
//--- Moving the window
   MovingWindow();
//--- If the interface has been created
   if(CWndContainer::WindowsTotal()>0)
     {
      //--- Change the width of all controls of the blocked form, if the mode is enabled
      if(m_windows[0].IsLocked() && m_windows[0].AutoXResizeMode())
        {
         int elements_total=CWndContainer::ElementsTotal(0);
         for(int e=0; e<elements_total; e++)
           {
            //--- If this is a form
            if(m_wnd[0].m_elements[e].ClassName()=="CWindow")
              {
               m_wnd[0].m_elements[e].OnEvent(m_id,m_lparam,m_dparam,m_sparam);
               continue;
              }
            //--- Resize all controls with this mode enabled
            if(m_wnd[0].m_elements[e].AutoXResizeMode())
               m_wnd[0].m_elements[e].ChangeWidthByRightWindowSide();
           }
        }
     }
//--- Redraw chart
   m_chart.Redraw();
  }
//+------------------------------------------------------------------+
//| Timer                                                            |
//+------------------------------------------------------------------+
void CWndEvents::OnTimerEvent(void)
  {
//--- Leave, if the array is empty  
   if(CWndContainer::WindowsTotal()<1)
      return;
//--- Checking events of all elements by timer
   CheckElementsEventsTimer();
//--- Redraw chart
   m_chart.Redraw();
  }
//+------------------------------------------------------------------+
//| Moving the window                                                |
//+------------------------------------------------------------------+
void CWndEvents::MovingWindow(void)
  {
   int awi=m_active_window_index;
//--- Moving the window
   int x=m_windows[awi].X();
   int y=m_windows[awi].Y();
   m_windows[awi].Moving(x,y);
//--- Moving controls
   int elements_total=CWndContainer::ElementsTotal(awi);
   for(int e=0; e<elements_total; e++)
      m_wnd[awi].m_elements[e].Moving(x,y);
  }
//+------------------------------------------------------------------+
//| Checking all element events by the timer                         |
//+------------------------------------------------------------------+
void CWndEvents::CheckElementsEventsTimer(void)
  {
   int awi=m_active_window_index;
   int elements_total=CWndContainer::ElementsTotal(awi);
   for(int e=0; e<elements_total; e++)
      m_wnd[awi].m_elements[e].OnEventTimer();
  }
//+------------------------------------------------------------------+
//| Identifying the sub-window number                                |
//+------------------------------------------------------------------+
void CWndEvents::DetermineSubwindow(void)
  {
//--- If the program type is not an indicator, leave
   if(PROGRAM_TYPE!=PROGRAM_INDICATOR)
     {
      return;
     }
//--- Reset the last error
   ::ResetLastError();
//--- Identifying the indicator window
   m_subwin=::ChartWindowFind();
//--- Leave, if failed to identify the number
   if(m_subwin<0)
     {
      ::Print(__FUNCTION__," > Error when identifying the sub-window number: ",::GetLastError());
      return;
     }
//--- If this is not the main window of the chart
   if(m_subwin>0)
     {
      //--- Get the common number of indicators in the specified sub-window
      int total=::ChartIndicatorsTotal(m_chart_id,m_subwin);
      //--- Get the short name of the last indicator in the list
      string indicator_name=::ChartIndicatorName(m_chart_id,m_subwin,total-1);
      //--- If the sub-window already contains the indicator, remove the program from the chart
      if(total!=1)
        {
         ::Print(__FUNCTION__," > This window already contains an indicator.");
         ::ChartIndicatorDelete(m_chart_id,m_subwin,indicator_name);
         return;
        }
     }
  }
//+------------------------------------------------------------------+
//| Checking and updating the program window number                  |
//+------------------------------------------------------------------+
void CWndEvents::CheckSubwindowNumber(void)
  {
//--- If the program in the sub-window and numbers do not match
   if(m_subwin!=0 && m_subwin!=::ChartWindowFind())
     {
      //--- Identify the sub-window number
      DetermineSubwindow();
      //--- Store in all elements
      int windows_total=CWndContainer::WindowsTotal();
      for(int w=0; w<windows_total; w++)
        {
         int elements_total=CWndContainer::ElementsTotal(w);
         for(int e=0; e<elements_total; e++)
            m_wnd[w].m_elements[e].SubwindowNumber(m_subwin);
        }
     }
  }
//+------------------------------------------------------------------+
//| Redraw the window                                                |
//+------------------------------------------------------------------+
void CWndEvents::ResetWindow(void)
  {
   if(CWndContainer::WindowsTotal()<1)
      return;
//---
   int awi=m_active_window_index;
//---
   m_windows[awi].Reset();
//---
   int elements_total=CWndContainer::ElementsTotal(awi);
   for(int e=0; e<elements_total; e++)
     {
      if(m_wnd[awi].m_elements[e].IsVisible())
         m_wnd[awi].m_elements[e].Reset();
     }
//---
   int tabs_total=CWndContainer::TabsTotal(awi);
   for(int e=0; e<tabs_total; e++)
      m_wnd[awi].m_tabs[e].ShowTabElements();
  }
//+------------------------------------------------------------------+
//| Removing all objects                                             |
//+------------------------------------------------------------------+
void CWndEvents::Destroy(void)
  {
//--- Set the index of the main window
   m_active_window_index=0;
//--- Get the number of windows
   int window_total=CWndContainer::WindowsTotal();
//--- Iterate over the window array
   for(int w=0; w<window_total; w++)
     {
      //--- Activate the main window
      if(m_windows[w].WindowType()==W_MAIN)
         m_windows[w].State(true);
      //--- Block dialog windows
      else
         m_windows[w].State(false);
     }
//--- Empty element arrays
   for(int w=0; w<window_total; w++)
     {
      int elements_total=CWndContainer::ElementsTotal(w);
      for(int e=0; e<elements_total; e++)
        {
         //--- If the pointer is invalid, move to the following
         if(::CheckPointer(m_wnd[w].m_elements[e])==POINTER_INVALID)
            continue;
         //--- Delete element objects
         m_wnd[w].m_elements[e].Delete();
        }
      //--- Empty element arrays
      ::ArrayFree(m_wnd[w].m_objects);
      ::ArrayFree(m_wnd[w].m_elements);
      ::ArrayFree(m_wnd[w].m_menu_bars);
      ::ArrayFree(m_wnd[w].m_context_menus);
      ::ArrayFree(m_wnd[w].m_tooltips);
      ::ArrayFree(m_wnd[w].m_drop_lists);
      ::ArrayFree(m_wnd[w].m_scrolls);
      ::ArrayFree(m_wnd[w].m_labels_tables);
      ::ArrayFree(m_wnd[w].m_tables);
      ::ArrayFree(m_wnd[w].m_canvas_tables);
      ::ArrayFree(m_wnd[w].m_tabs);
      ::ArrayFree(m_wnd[w].m_calendars);
      ::ArrayFree(m_wnd[w].m_drop_calendars);
      ::ArrayFree(m_wnd[w].m_treeview_lists);
      ::ArrayFree(m_wnd[w].m_file_navigators);
     }
//--- Empty form arrays
   ::ArrayFree(m_wnd);
   ::ArrayFree(m_windows);
  }
//+------------------------------------------------------------------+
//| Sets the state of the chart                                      |
//+------------------------------------------------------------------+
void CWndEvents::SetChartState(void)
  {
   int awi=m_active_window_index;
//--- To identify the event when management must be disabled
   bool condition=false;
//--- Check windows
   int windows_total=CWndContainer::WindowsTotal();
   for(int i=0; i<windows_total; i++)
     {
      //--- Move to the next one, if this form is hidden
      if(!m_windows[i].IsVisible())
         continue;
      //--- Check conditions in the internal handler of the form
      m_windows[i].OnEvent(m_id,m_lparam,m_dparam,m_sparam);
      //--- If there is a focus, mark it
      if(m_windows[i].MouseFocus())
        {
         condition=true;
         break;
        }
     }
//--- Check drop-down list views
   if(!condition)
     {
      //--- Get the total of the drop-down list views
      int drop_lists_total=CWndContainer::DropListsTotal(awi);
      for(int i=0; i<drop_lists_total; i++)
        {
         //--- Get the pointer to the drop-down list view
         CListView *lv=m_wnd[awi].m_drop_lists[i];
         //--- If the list view is activated (visible)
         if(lv.IsVisible())
           {
            //--- Check the focus over the list view and the state of its scrollbar
            if(m_wnd[awi].m_drop_lists[i].MouseFocus() || lv.ScrollState())
              {
               condition=true;
               break;
              }
           }
        }
     }
//--- Check calendar
   if(!condition)
     {
      int drop_calendars_total=CWndContainer::DropCalendarsTotal(awi);
      for(int i=0; i<drop_calendars_total; i++)
        {
         if(m_wnd[awi].m_drop_calendars[i].GetCalendarPointer().MouseFocus())
           {
            condition=true;
            break;
           }
        }
     }
//--- Check the focus of context menus
   if(!condition)
     {
      //--- Check the total of drop-down context menus
      int context_menus_total=CWndContainer::ContextMenusTotal(awi);
      for(int i=0; i<context_menus_total; i++)
        {
         //--- If the focus is over the context menu
         if(m_wnd[awi].m_context_menus[i].MouseFocus())
           {
            condition=true;
            break;
           }
        }
     }
//--- Check the state of a scrollbar
   if(!condition)
     {
      int scrolls_total=CWndContainer::ScrollsTotal(awi);
      for(int i=0; i<scrolls_total; i++)
        {
         if(((CScroll*)m_wnd[awi].m_scrolls[i]).ScrollState())
           {
            condition=true;
            break;
           }
        }
     }
//--- Sets the chart state in all forms
   for(int i=0; i<windows_total; i++)
      m_windows[i].CustomEventChartState(condition);
  }
//+------------------------------------------------------------------+
