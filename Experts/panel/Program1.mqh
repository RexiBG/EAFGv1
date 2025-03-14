//+------------------------------------------------------------------+
//|                                                      Program1.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+

#ifndef _PROGRAM1_MQH_
#define _PROGRAM1_MQH_


#include <EasyAndFastGUI\Controls\WndEvents.mqh>
//+------------------------------------------------------------------+
//| Class for creating an application                                |
//+------------------------------------------------------------------+
class CProgram : public CWndEvents
  {
protected:
   //--- Window
   CWindow           m_window;
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
   //--- Simple buttons
   CSimpleButton     m_simple_button1;
   CSimpleButton     m_simple_button2;
   CSimpleButton     m_simple_button3;
   //--- Icon buttons
   CIconButton       m_icon_button1;
   //--- Split buttons
   CSplitButton      m_split_button1;
   //--- Group of simple buttons 1
   CButtonsGroup     m_buttons_group1;
   //--- Group of radio buttons 1
   CRadioButtons     m_radio_buttons1;
   //--- Group of icon buttons 1
   CIconButtonsGroup m_icon_buttons_group1;
   //--- List views
   CListView         m_listview1;
   //--- Progress bar
   CProgressBar      m_progress_bar;

   //--- Text label table
   CLabelsTable      m_labels_table;

   //--- Edit box table
   CTable            m_table;

   //--- Rendered table
   CCanvasTable      m_canvas_table;

   //--- Line chart
   CLineGraph        m_line_chart;

   //--- Edits
   CSpinEdit         m_spin_edit1;
   //--- Comboboxes
   CComboBox         m_combobox1;
   //--- Tree view
   CTreeView         m_treeview;

   //--- Checkboxes
   CCheckBox         m_checkbox1;
   //--- Check boxes with edits
   CCheckBoxEdit     m_checkboxedit1;
   //--- Comboboxes with checkboxes
   CCheckComboBox    m_checkcombobox1;
   //--- File navigator
   CFileNavigator    m_navigator;

   //--- Calendars
   CCalendar         m_calendar1;
   //--- Drop down calendars
   CDropCalendar     m_drop_calendar1;
   //--- Sliders
   CSlider           m_slider1;
   CDualSlider       m_dual_slider1;
   //--- Separation line
   CSeparateLine     m_sep_line;
   //--- Buttons to call the window with the color picker
   CColorButton      m_color_button1;

   //--- Form 2
   CWindow           m_window2;
   //--- Color picker
   CColorPicker      m_color_picker;

#define SERIES_TOTAL 2
   //--- Structure of the series on the chart
   struct Series
     {
      double            data[];      // array of displayed data
      double            data_temp[]; // auxiliary array for calculations
     };
   Series            m_series[];

   //--- (1) Names and (2) colors of the series
   string            m_series_name[];
   color             m_series_color[];
   //---
public:
                     CProgram(void);
                    ~CProgram(void);
   //--- Initialization/deinitialization
   void              OnInitEvent(void);
   void              OnDeinitEvent(const int reason);
   //--- Timer
   void              OnTimerEvent(void);
   //--- Chart event handler
   virtual void      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);

   //--- Create the graphical interface of the program
   bool              CreateGUI(void);
   //---
protected:
   //--- Form
   bool              CreateWindow(const string text);
   //--- Main menu
   bool              CreateMenuBar(const int x_gap,const int y_gap);
   bool              CreateMBContextMenu1(void);
   bool              CreateMBContextMenu2(void);
   bool              CreateMBContextMenu3(void);
   bool              CreateMBContextMenu4(void);
   //--- Status Bar
   bool              CreateStatusBar(const int x_gap,const int y_gap);
   //--- Tabs
   bool              CreateTabs(const int x_gap,const int y_gap);
   //--- Simple buttons
   bool              CreateSimpleButton1(const int x_gap,const int y_gap,const string text);
   bool              CreateSimpleButton2(const int x_gap,const int y_gap,const string text);
   bool              CreateSimpleButton3(const int x_gap,const int y_gap,const string text);
   //--- Icon buttons
   bool              CreateIconButton1(const int x_gap,const int y_gap,const string text);
   //--- Split buttons
   bool              CreateSplitButton1(const int x_gap,const int y_gap,const string text);
   //--- Group of simple buttons 1
   bool              CreateButtonsGroup1(const int x_gap,const int y_gap);
   //--- Group of radio buttons 1
   bool              CreateRadioButtons1(const int x_gap,const int y_gap);
   //--- Group of icon buttons 1
   bool              CreateIconButtonsGroup1(const int x_gap,const int y_gap);
   //--- List view 1
   bool              CreateListView1(const int x_gap,const int y_gap);
   //--- Progress bar
   bool              CreateProgressBar(const int x_gap,const int y_gap);
   //--- Text label table
   bool              CreateLabelsTable(const int x_gap,const int y_gap);
   //--- Edit box table
   bool              CreateTable(const int x_gap,const int y_gap);
   //--- Rendered table
   bool              CreateCanvasTable(const int x_gap,const int y_gap);
   //--- Line chart
   bool              CreateLineChart(const int x_gap,const int y_gap);
   //--- Edits
   bool              CreateSpinEdit1(const int x_gap,const int y_gap,const string text);
   //--- Combobox 1
   bool              CreateComboBox1(const int x_gap,const int y_gap,const string text);
   //--- Tree view
   bool              CreateTreeView(const int x_gap,const int y_gap);

   //--- Checkboxes
   bool              CreateCheckBox1(const int x_gap,const int y_gap,const string text);
   //--- Check boxes with edits
   bool              CreateCheckBoxEdit1(const int x_gap,const int y_gap,const string text);
   //--- Comboboxes with checkboxes
   bool              CreateCheckComboBox1(const int x_gap,const int y_gap,const string text);
   //--- File navigator
   bool              CreateFileNavigator(const int x_gap,const int y_gap);
   //--- Calendars
   bool              CreateCalendar1(const int x_gap,const int y_gap);
   //--- Drop down calendars
   bool              CreateDropCalendar1(const int x_gap,const int y_gap,const string text);
   //--- Sliders
   bool              CreateSlider1(const int x_gap,const int y_gap,const string text);
   bool              CreateDualSlider1(const int x_gap,const int y_gap,const string text);
   //--- Separation line
   bool              CreateSepLine(const int x_gap,const int y_gap);
   //--- Buttons to call the color picker
   bool              CreateColorButton1(const int x_gap,const int y_gap,const string text);

   //--- Form 2
   bool              CreateWindow2(const string text);
   //--- Color picker
   bool              CreateColorPicker(const int x_gap,const int y_gap);
   //---
protected:
   //--- Resize the series
   void              ResizeDataArrays(void);
   //--- Initialization of the auxiliary arrays for calculations
   void              InitArrays(void);
   //--- Calculate the series
   void              CalculateSeries(void);
   //--- Add the series to the chart
   void              AddSeries(void);
   //--- Update the series on the chart
   void              UpdateSeries(void);
   //--- Calculate offsets from the chart borders
   void              CalculateYOffset(void);
  };
//+------------------------------------------------------------------+
//| Creating controls                                                |
//+------------------------------------------------------------------+
#include "MainWindow.mqh"
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CProgram::CProgram(void)
  {
//--- Set the size of the series arrays
   ::ArrayResize(m_series,SERIES_TOTAL);
   ::ArrayResize(m_series_name,SERIES_TOTAL);
   ::ArrayResize(m_series_color,SERIES_TOTAL);
//--- Initialize the array of series names
   for(int i=0; i<SERIES_TOTAL; i++)
      m_series_name[i]="Series "+string(i+1);
//--- Initialize the arrays of series color
   m_series_color[0]=clrCornflowerBlue;
   m_series_color[1]=clrRed;
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
//--- Progress bar
   static int count1=0;
   if(m_simple_button3.IsPressed())
     {
      int total=1000;
      count1=(count1>=total) ? 0 : count1+=5;
      m_progress_bar.Update(count1,total);
     }
   else
      count1=0;
//--- Pause between updates of the controls
   static int count2=0;
   if(count2<300)
     {
      count2+=TIMER_STEP_MSC;
      return;
     }
//--- Zero the counter
   count2=0;
//--- Updating the second item of the status bar
   m_status_bar.ValueToItem(1,TimeToString(TimeLocal(),TIME_DATE|TIME_SECONDS));
//--- Calculate the series
   CalculateSeries();
//--- Calculate offsets from the chart borders
   CalculateYOffset();
//--- Update the line chart
   UpdateSeries();
  }
//+------------------------------------------------------------------+
//| Chart event handler                                              |
//+------------------------------------------------------------------+
void CProgram::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- Window maximization event
   if(id==CHARTEVENT_CUSTOM+ON_WINDOW_UNROLL)
     {
      //--- Show the progress bar if the third button is pressed
      if(m_simple_button3.IsPressed())
         m_progress_bar.Show();
      //---
      return;
     }
//--- Event of changing color using the color picker
   if(id==CHARTEVENT_CUSTOM+ON_CHANGE_COLOR)
     {
      //---If control identifiers match
      if(lparam==m_color_picker.Id())
        {
         //--- If the response is from the first button
         if(sparam==m_color_button1.LabelText())
           {
            //--- Change color of the object which refers to the first button (for practice)
            return;
           }
        }
      return;
     }
//--- The button press event
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_BUTTON)
     {
      //--- If the third button was clicked
      if(lparam==m_simple_button3.Id())
        {
         //--- Show or hide the progress bar depending on the state of the third button
         if(m_simple_button3.IsPressed())
            m_progress_bar.Show();
         else
            m_progress_bar.Hide();
         //---
         return;
        }
      //--- If the first button for calling the color picker was pressed
      if(sparam==m_color_button1.LabelText())
        {
         //--- Pass the button pointer, which automatically opens the window with the color picker
         m_color_picker.ColorButtonPointer(m_color_button1);
         return;
        }
      //---
      return;
     }
//--- If the chart properties have changed
   if(id==CHARTEVENT_CUSTOM+ON_WINDOW_CHANGE_SIZE)
     {
      //--- Update the line chart
      UpdateSeries();
      return;
     }
  }
//+------------------------------------------------------------------+
//| Create the graphical interface of the program                    |
//+------------------------------------------------------------------+
bool CProgram::CreateGUI(void)
  {
//--- Creating a panel
   if(!CreateWindow("EXPERT PANEL"))
      return(false);
//--- Main menu
   if(!CreateMenuBar(1,20))
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
   if(!CreateStatusBar(1,285))
      return(false);
//--- Tabs
   if(!CreateTabs(0,43))
      return(false);
//--- Simple buttons
   if(!CreateSimpleButton1(7,70,"Simple Button 1"))
      return(false);
   if(!CreateSimpleButton2(150,70,"Simple Button 2"))
      return(false);
   if(!CreateSimpleButton3(7,95,"Simple Button 3"))
      return(false);
//--- Icon buttons
   if(!CreateIconButton1(7,120,"Icon Button 1"))
      return(false);
//--- Split buttons
   if(!CreateSplitButton1(150,120,"Split Button 1"))
      return(false);
//--- Group of simple buttons 1
   if(!CreateButtonsGroup1(7,145))
      return(false);
//--- Group of radio buttons 1
   if(!CreateRadioButtons1(7,170))
      return(false);
//--- Group of icon buttons 1
   if(!CreateIconButtonsGroup1(7,193))
      return(false);
//--- List views
   if(!CreateListView1(300,70))
      return(false);

//--- Progress bar
   if(!CreateProgressBar(5,289))
      return(false);
//--- Text label table
   if(!CreateLabelsTable(1,63))
      return(false);
//--- Edit box table
   if(!CreateTable(1,63))
      return(false);
//--- Create rendered table
   if(!CreateCanvasTable(1,63))
      return(false);
//--- Line chart
   if(!CreateLineChart(2,64))
      return(false);

//--- Edits
   if(!CreateSpinEdit1(7,68,"Spin Edit 1:"))
      return(false);
//--- Comboboxes
   if(!CreateComboBox1(140,68,"Combobox 1:"))
      return(false);
//--- Create the tree view
   if(!CreateTreeView(2,90))
      return(false);

//--- Checkboxes
   if(!CreateCheckBox1(7,68,"Checkbox 1"))
      return(false);
//--- Check boxes with edits
   if(!CreateCheckBoxEdit1(105,68,"Checkbox Edit 1:"))
      return(false);
//--- Comboboxes with checkboxes
   if(!CreateCheckComboBox1(295,68,"CheckCombobox 1:"))
      return(false);
//--- Create file navigator
   if(!CreateFileNavigator(2,90))
      return(false);

//--- Calendars
   if(!CreateCalendar1(10,71))
      return(false);
//--- Drop down calendars
   if(!CreateDropCalendar1(188,72,"Drop calendar 1: "))
      return(false);
//--- Sliders
   if(!CreateSlider1(189,108,"Slider 1:"))
      return(false);
   if(!CreateDualSlider1(10,238,"Dual Slider 1:"))
      return(false);
//--- Separation line
   if(!CreateSepLine(189,170))
      return(false);
//--- Button to call the color picker
   if(!CreateColorButton1(188,200,"Color button 1:"))
      return(false);

//--- Creating form 2 for the color picker
   if(!CreateWindow2("Color picker"))
      return(false);
//--- Color picker
   if(!CreateColorPicker(1,20))
      return(false);

//--- Display controls of the active tab
   m_tabs.ShowTabElements();
   return(true);
  }
//+------------------------------------------------------------------+
//| Resize the arrays                                                |
//+------------------------------------------------------------------+
void CProgram::ResizeDataArrays(void)
  {
   int size_of_series=1000;
//---
   for(int s=0; s<SERIES_TOTAL; s++)
     {
      //--- Resize the arrays
      ::ArrayResize(m_series[s].data,size_of_series);
      ::ArrayResize(m_series[s].data_temp,size_of_series);
     }
  }
//+------------------------------------------------------------------+
//| Initialization of the auxiliary arrays for calculations          |
//+------------------------------------------------------------------+
void CProgram::InitArrays(void)
  {
   for(int s=0; s<SERIES_TOTAL; s++)
     {
      int size_of_series=::ArraySize(m_series[s].data_temp);
      //---
      for(int i=0; i<size_of_series; i++)
        {
         if(i==0)
           {
            if(s>0)
               m_series[s].data_temp[i]=m_series[s-1].data_temp[i]+1;
            else
               m_series[s].data_temp[i]=1;
           }
         else
            m_series[s].data_temp[i]=m_series[s].data_temp[i-1]+1;
        }
     }
  }
//+------------------------------------------------------------------+
//| Calculate the series                                             |
//+------------------------------------------------------------------+
void CProgram::CalculateSeries(void)
  {
   for(int s=0; s<SERIES_TOTAL; s++)
     {
      int size_of_series=::ArraySize(m_series[s].data_temp);
      //---
      for(int i=0; i<size_of_series; i++)
        {
         m_series[s].data_temp[i]+=1;
         //---
         int rand_value =rand()%1000;
         int max_or_min =(bool(rand()%2))? rand_value : -rand_value;
         //---
         if(i==0)
            m_series[s].data[i]=0;
         else
            m_series[s].data[i]=m_series[s].data[i-1]+max_or_min;
        }
     }
  }
//+------------------------------------------------------------------+
//| Calculate and place the series on the chart                      |
//+------------------------------------------------------------------+
void CProgram::AddSeries(void)
  {
   for(int s=0; s<SERIES_TOTAL; s++)
      m_line_chart.SeriesAdd(m_series[s].data,m_series_name[s],m_series_color[s]);
  }
//+------------------------------------------------------------------+
//| Calculate and update the series on the chart                     |
//+------------------------------------------------------------------+
void CProgram::UpdateSeries(void)
  {
   for(int s=0; s<SERIES_TOTAL; s++)
      m_line_chart.SeriesUpdate(s,m_series[s].data,m_series_name[s],m_series_color[s]);
  }
//+------------------------------------------------------------------+
//| Calculate offsets from the top and bottom borders of the chart   |
//+------------------------------------------------------------------+
void CProgram::CalculateYOffset(void)
  {
   double max_value =0.0;
   double min_value =0.0;
//--- Find the maximum and minimum of all series
   for(int s=0; s<SERIES_TOTAL; s++)
     {
      max_value=fmax(max_value,m_series[s].data[ArrayMaximum(m_series[s].data)]);
      min_value=fmin(min_value,m_series[s].data[ArrayMinimum(m_series[s].data)]);
     }
//--- Calculate the offset
   double range    =max_value-min_value;
   double y_offset =range*0.05;
//--- Change the chart parameters
   m_line_chart.VScaleParams(max_value+y_offset,min_value-y_offset,4);
  }
//+------------------------------------------------------------------+


#endif _PROGRAM1_MQH_