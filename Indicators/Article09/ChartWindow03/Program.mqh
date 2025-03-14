//+------------------------------------------------------------------+
//|                                                      Program.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include <EasyAndFastGUI\Controls\WndEvents.mqh>
//--- Enumeration of functions
enum ENUM_FORMULA
  {
   FORMULA_1=0, // Formula 1
   FORMULA_2=1, // Formula 2
   FORMULA_3=2  // Formula 3
  };
//--- External parameters
input ENUM_FORMULA Formula        =FORMULA_1;       // Formula
input color        ColorSeries_01 =clrRed;          // Color series 01
input color        ColorSeries_02 =clrDodgerBlue;   // Color series 02
input color        ColorSeries_03 =clrWhite;        // Color series 03
input color        ColorSeries_04 =clrYellow;       // Color series 04
input color        ColorSeries_05 =clrMediumPurple; // Color series 05
input color        ColorSeries_06 =clrMagenta;      // Color series 06
//+------------------------------------------------------------------+
//| Class for creating an application                                |
//+------------------------------------------------------------------+
class CProgram : public CWndEvents
  {
private:
   //--- Form
   CWindow           m_window1;
   //--- Status Bar
   CStatusBar        m_status_bar;
   //--- Controls
   CSpinEdit         m_delay_ms;
   CComboBox         m_series_total;
   CCheckBoxEdit     m_increment_ratio;
   CSpinEdit         m_offset_series;
   CSpinEdit         m_min_limit_size;
   CCheckBoxEdit     m_max_limit_size;
   CCheckBoxEdit     m_run_speed;
   CSpinEdit         m_series_size;
   CLineGraph        m_line_chart;
   //--- Progress bar
   CProgressBar      m_progress_bar;
   
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
   //--- Speed counter of the "running" series
   double            m_run_speed_counter;
   //---
public:
                     CProgram(void);
                    ~CProgram(void);
   //--- Initialization/deinitialization
   void              OnInitEvent(void);
   void              OnDeinitEvent(const int reason);
   //--- Chart event handler
   virtual void      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
   //--- Timer
   void              OnTimerEvent(void);
   //---
public:
   //--- Create the indicator panel
   bool              CreateIndicatorPanel(void);
   //---
private:
   //--- Form
   bool              CreateWindow(const string text);
   //--- Status Bar
#define STATUSBAR1_GAP_X      (1)
#define STATUSBAR1_GAP_Y      (359)
   bool              CreateStatusBar(void);
   //--- Controls for managing the line chart
#define SPINEDIT1_GAP_X       (7)
#define SPINEDIT1_GAP_Y       (25)
   bool              CreateSpinEditDelay(const string text);
#define COMBOBOX1_GAP_X       (7)
#define COMBOBOX1_GAP_Y       (50)
   bool              CreateComboBoxSeriesTotal(const string text);
#define CHECKBOX_EDIT1_GAP_X  (161)
#define CHECKBOX_EDIT1_GAP_Y  (25)
   bool              CreateCheckBoxEditIncrementRatio(const string text);
#define SPINEDIT2_GAP_X       (161)
#define SPINEDIT2_GAP_Y       (50)
   bool              CreateSpinEditOffsetSeries(const string text);
#define SPINEDIT3_GAP_X       (330)
#define SPINEDIT3_GAP_Y       (25)
   bool              CreateSpinEditMinLimitSize(const string text);
#define CHECKBOX_EDIT2_GAP_X  (330)
#define CHECKBOX_EDIT2_GAP_Y  (50)
   bool              CreateCheckBoxEditMaxLimitSize(const string text);
#define CHECKBOX_EDIT3_GAP_X  (501)
#define CHECKBOX_EDIT3_GAP_Y  (25)
   bool              CreateCheckBoxEditRunSpeed(const string text);
#define SPINEDIT4_GAP_X       (501)
#define SPINEDIT4_GAP_Y       (50)
   bool              CreateSpinEditSeriesSize(const string text);
   //--- Line chart
#define LINECHART1_GAP_X      (5)
#define LINECHART1_GAP_Y      (75)
   bool              CreateLineChart(void);
   //--- Progress bar
#define PROGRESSBAR1_GAP_X    (5)
#define PROGRESSBAR1_GAP_Y    (364)
   bool              CreateProgressBar(void);
   //---
private:
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
   //--- Recalculate the series on the chart
   void              RecalculatingSeries(void);

   //--- Update the line chart by timer
   void              UpdateLineChartByTimer(void);

   //--- Shift the line chart series ("running" chart)
   void              ShiftLineChartSeries(void);
   //--- Auto-resize the line chart series
   void              AutoResizeLineChartSeries(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CProgram::CProgram(void) : m_run_speed_counter(0.0)
  {
//--- Set the size of the series arrays
   int number_of_series=24;
   ::ArrayResize(m_series,number_of_series);
   ::ArrayResize(m_series_name,number_of_series);
   ::ArrayResize(m_series_color,number_of_series);
//--- Initialize the array of series names
   for(int i=0; i<number_of_series; i++)
      m_series_name[i]="Series "+string(i+1);
//--- Initialize the arrays of series color
   m_series_color[0] =m_series_color[6]  =m_series_color[12] =m_series_color[18] =ColorSeries_01;
   m_series_color[1] =m_series_color[7]  =m_series_color[13] =m_series_color[19] =ColorSeries_02;
   m_series_color[2] =m_series_color[8]  =m_series_color[14] =m_series_color[20] =ColorSeries_03;
   m_series_color[3] =m_series_color[9]  =m_series_color[15] =m_series_color[21] =ColorSeries_04;
   m_series_color[4] =m_series_color[10] =m_series_color[16] =m_series_color[22] =ColorSeries_05;
   m_series_color[5] =m_series_color[11] =m_series_color[17] =m_series_color[23] =ColorSeries_06;
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

//--- Update the line chart by timer
   UpdateLineChartByTimer();

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
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CProgram::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- Window maximization event
   if(id==CHARTEVENT_CUSTOM+ON_WINDOW_UNROLL)
     {
      //--- Show progress bar
      if(m_max_limit_size.CheckButtonState())
         m_progress_bar.Show();
      //---
      return;
     }
//--- Selection of item in combobox event
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_COMBOBOX_ITEM)
     {
      //--- Get the new number of series
      m_line_chart.MaxData((int)m_series_total.ButtonText());
      //--- (1) Set the sizes of arrays and (2) initialize them
      ResizeDataArrays();
      InitArrays();
      //--- (1) Calculate, (2) add to the chart and (3) update the series
      CalculateSeries();
      AddSeries();
      UpdateSeries();
      return;
     }
//--- The event of pressing the text label of the control
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_LABEL)
     {
      //--- If this message is from the 'Size of series' control
      if(sparam==m_series_size.LabelText())
        {
         //--- Recalculate the series on the chart
         RecalculatingSeries();
         return;
        }
      //--- If this message is from the 'Max. Limit Size' control
      if(sparam==m_max_limit_size.LabelText())
        {
         //--- Show or hide the progress bar depending on the state of the 'Max. limit size' control checkbox
         if(m_max_limit_size.CheckButtonState())
            m_progress_bar.Show();
         else
            m_progress_bar.Hide();
         //---
         return;
        }
     }
//--- Event of entering new value in the edit box
   if(id==CHARTEVENT_CUSTOM+ON_END_EDIT)
     {
      //--- If this message is from the 'Increment ratio' or 'Offset series' or 'Size of series' control
      if(sparam==m_increment_ratio.LabelText() ||
         sparam==m_offset_series.LabelText() ||
         sparam==m_series_size.LabelText())
        {
         //--- Recalculate the series on the chart
         RecalculatingSeries();
         return;
        }
      return;
     }
//--- Switching buttons of the edit press event
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_INC || id==CHARTEVENT_CUSTOM+ON_CLICK_DEC)
     {
      //--- If this message is from the 'Increment ratio' or 'Offset series' or 'Size of series' control
      if(sparam==m_increment_ratio.LabelText() ||
         sparam==m_offset_series.LabelText() ||
         sparam==m_series_size.LabelText())
        {
         //--- Recalculate the series on the chart
         RecalculatingSeries();
         return;
        }
      return;
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
//    Status Bar
   if(!CreateStatusBar())
      return(false);
//--- Controls for managing the line chart
   if(!CreateSpinEditDelay("Delay (ms):"))
      return(false);
   if(!CreateComboBoxSeriesTotal("Number of series:"))
      return(false);
   if(!CreateCheckBoxEditIncrementRatio("Increment ratio:"))
      return(false);
   if(!CreateSpinEditOffsetSeries("Offset series:"))
      return(false);
   if(!CreateSpinEditMinLimitSize("Min. limit size:"))
      return(false);
   if(!CreateCheckBoxEditMaxLimitSize("Max. limit size:"))
      return(false);
   if(!CreateCheckBoxEditRunSpeed("Run speed:"))
      return(false);
   if(!CreateSpinEditSeriesSize("Size of series:"))
      return(false);
//--- Line chart
   if(!CreateLineChart())
      return(false);
//--- Progress bar
   if(!CreateProgressBar())
      return(false);
//--- Redrawing the chart
   m_chart.Redraw();
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates a form for controls                                      |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp"
//---
bool CProgram::CreateWindow(const string caption_text)
  {
//--- Add the window pointer to the window array
   CWndContainer::AddWindow(m_window1);
//--- Coordinates
   int x=(m_window1.X()>0) ? m_window1.X() : 29;
   int y=(m_window1.Y()>0) ? m_window1.Y() : 30;
//--- Properties
   m_window1.XSize(640);
   m_window1.YSize(384);
   m_window1.UseRollButton();
   m_window1.Movable(true);
   m_window1.IconFile("Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp");
//--- Creating the form
   if(!m_window1.CreateWindow(m_chart_id,m_subwin,caption_text,x,y))
      return(false);
//---
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
//| Create the "Delay" edit box                                      |
//+------------------------------------------------------------------+
bool CProgram::CreateSpinEditDelay(string text)
  {
//--- Store the window pointer
   m_delay_ms.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+SPINEDIT1_GAP_X;
   int y=m_window1.Y()+SPINEDIT1_GAP_Y;
//--- Value
   double v=(m_delay_ms.GetValue()<0) ? 16 : m_delay_ms.GetValue();
//--- Set properties before creation
   m_delay_ms.XSize(144);
   m_delay_ms.YSize(18);
   m_delay_ms.EditXSize(40);
   m_delay_ms.MaxValue(1000);
   m_delay_ms.MinValue(1);
   m_delay_ms.StepValue(1);
   m_delay_ms.SetDigits(0);
   m_delay_ms.SetValue(v);
   m_delay_ms.ResetMode(true);
//--- Create control
   if(!m_delay_ms.CreateSpinEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_delay_ms);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "Series Total" combo box                              |
//+------------------------------------------------------------------+
bool CProgram::CreateComboBoxSeriesTotal(const string text)
  {
#define ROWS1_TOTAL 24
//--- Store the window pointer
   m_series_total.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+COMBOBOX1_GAP_X;
   int y=m_window1.Y()+COMBOBOX1_GAP_Y;
//--- Set properties before creation
   m_series_total.XSize(140);
   m_series_total.YSize(18);
   m_series_total.LabelText(text);
   m_series_total.ButtonXSize(51);
   m_series_total.ItemsTotal(ROWS1_TOTAL);
   m_series_total.VisibleItemsTotal(5);
//--- Populate the combo box list
   for(int i=0; i<ROWS1_TOTAL; i++)
      m_series_total.ValueToList(i,string(i+1));
//--- Get the list view pointer
   CListView *lv=m_series_total.GetListViewPointer();
//--- Set the list view properties
   lv.LightsHover(true);
//--- Create control
   if(!m_series_total.CreateComboBox(m_chart_id,m_subwin,x,y))
      return(false);
//--- Select an item in the combo box list
   m_series_total.SelectedItemByIndex(5);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_series_total);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "Increment Ratio" check box with edit control         |
//+------------------------------------------------------------------+
bool CProgram::CreateCheckBoxEditIncrementRatio(string text)
  {
//--- Store the window pointer
   m_increment_ratio.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+CHECKBOX_EDIT1_GAP_X;
   int y=m_window1.Y()+CHECKBOX_EDIT1_GAP_Y;
//--- Value
   double v=(m_increment_ratio.GetValue()<0) ? 35 : m_increment_ratio.GetValue();
//--- Set properties before creation
   m_increment_ratio.XSize(160);
   m_increment_ratio.YSize(18);
   m_increment_ratio.EditXSize(40);
   m_increment_ratio.MaxValue(100);
   m_increment_ratio.MinValue(1);
   m_increment_ratio.StepValue(1);
   m_increment_ratio.SetDigits(0);
   m_increment_ratio.SetValue(v);
   m_increment_ratio.CheckButtonState(false);
//--- Create control
   if(!m_increment_ratio.CreateCheckBoxEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_increment_ratio);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "Offset Series" edit box                              |
//+------------------------------------------------------------------+
bool CProgram::CreateSpinEditOffsetSeries(string text)
  {
//--- Store the window pointer
   m_offset_series.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+SPINEDIT2_GAP_X;
   int y=m_window1.Y()+SPINEDIT2_GAP_Y;
//--- Value
   double v=(m_offset_series.GetValue()<0) ? 1.00 : m_offset_series.GetValue();
//--- Set properties before creation
   m_offset_series.XSize(160);
   m_offset_series.YSize(18);
   m_offset_series.EditXSize(40);
   m_offset_series.MaxValue(1);
   m_offset_series.MinValue(0.01);
   m_offset_series.StepValue(0.01);
   m_offset_series.SetDigits(2);
   m_offset_series.SetValue(v);
   m_offset_series.ResetMode(true);
//--- Create control
   if(!m_offset_series.CreateSpinEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_offset_series);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "Min. Limit Size" control                             |
//+------------------------------------------------------------------+
bool CProgram::CreateSpinEditMinLimitSize(string text)
  {
//--- Store the window pointer
   m_min_limit_size.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+SPINEDIT3_GAP_X;
   int y=m_window1.Y()+SPINEDIT3_GAP_Y;
//--- Value
   double v=(m_min_limit_size.GetValue()<0) ? 2 : m_min_limit_size.GetValue();
//--- Set properties before creation
   m_min_limit_size.XSize(162);
   m_min_limit_size.YSize(18);
   m_min_limit_size.EditXSize(40);
   m_min_limit_size.MaxValue(100);
   m_min_limit_size.MinValue(2);
   m_min_limit_size.StepValue(1);
   m_min_limit_size.SetDigits(0);
   m_min_limit_size.SetValue(v);
   m_min_limit_size.ResetMode(true);
//--- Create control
   if(!m_min_limit_size.CreateSpinEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_min_limit_size);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "Max. Limit Size" check box with edit control       |
//+------------------------------------------------------------------+
bool CProgram::CreateCheckBoxEditMaxLimitSize(string text)
  {
//--- Store the window pointer
   m_max_limit_size.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+CHECKBOX_EDIT2_GAP_X;
   int y=m_window1.Y()+CHECKBOX_EDIT2_GAP_Y;
//--- Value
   double v=(m_max_limit_size.GetValue()<0) ? 50 : m_max_limit_size.GetValue();
//--- Set properties before creation
   m_max_limit_size.XSize(162);
   m_max_limit_size.YSize(18);
   m_max_limit_size.EditXSize(40);
   m_max_limit_size.MaxValue(10000);
   m_max_limit_size.MinValue(50);
   m_max_limit_size.StepValue(1);
   m_max_limit_size.SetDigits(0);
   m_max_limit_size.SetValue(v);
   m_max_limit_size.CheckButtonState(false);
//--- Create control
   if(!m_max_limit_size.CreateCheckBoxEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_max_limit_size);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "Run Speed" check box with edit control               |
//+------------------------------------------------------------------+
bool CProgram::CreateCheckBoxEditRunSpeed(string text)
  {
//--- Store the window pointer
   m_run_speed.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+CHECKBOX_EDIT3_GAP_X;
   int y=m_window1.Y()+CHECKBOX_EDIT3_GAP_Y;
//--- Value
   double v=(m_run_speed.GetValue()<0) ? 0.05 : m_run_speed.GetValue();
//--- Set properties before creation
   m_run_speed.XSize(134);
   m_run_speed.YSize(18);
   m_run_speed.EditXSize(40);
   m_run_speed.MaxValue(1);
   m_run_speed.MinValue(0.01);
   m_run_speed.StepValue(0.01);
   m_run_speed.SetDigits(2);
   m_run_speed.SetValue(v);
   m_run_speed.CheckButtonState(false);
//--- Create control
   if(!m_run_speed.CreateCheckBoxEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_run_speed);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "Series Size" edit box                                |
//+------------------------------------------------------------------+
bool CProgram::CreateSpinEditSeriesSize(string text)
  {
//--- Store the window pointer
   m_series_size.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+SPINEDIT4_GAP_X;
   int y=m_window1.Y()+SPINEDIT4_GAP_Y;
//--- Value
   double v=(m_series_size.GetValue()<0) ? 2 : m_series_size.GetValue();
//--- Set properties before creation
   m_series_size.XSize(134);
   m_series_size.YSize(18);
   m_series_size.EditXSize(40);
   m_series_size.MaxValue(m_max_limit_size.MaxValue());
   m_series_size.MinValue(m_min_limit_size.MinValue());
   m_series_size.StepValue(1);
   m_series_size.SetDigits(0);
   m_series_size.SetValue(v);
   m_series_size.ResetMode(true);
//--- Create control
   if(!m_series_size.CreateSpinEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_series_size);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create a line chart                                              |
//+------------------------------------------------------------------+
bool CProgram::CreateLineChart(void)
  {
//--- Store the window pointer
   m_line_chart.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+LINECHART1_GAP_X;
   int y=m_window1.Y()+LINECHART1_GAP_Y;
//--- Set properties before creation
   m_line_chart.XSize(630);
   m_line_chart.YSize(280);
   m_line_chart.BorderColor(clrSilver);
   m_line_chart.VScaleParams(2,-2,4);
   m_line_chart.MaxData(int(m_series_total.ButtonText()));
//--- Create control
   if(!m_line_chart.CreateLineGraph(m_chart_id,m_subwin,x,y))
      return(false);
//--- (1) Set the sizes of arrays and (2) initialize them
   ResizeDataArrays();
   InitArrays();
//--- (1) Calculate and (2) add the series to the chart
   CalculateSeries();
   AddSeries();
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_line_chart);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create progress bar                                              |
//+------------------------------------------------------------------+
bool CProgram::CreateProgressBar(void)
  {
//--- Store pointer to the form
   m_progress_bar.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+PROGRESSBAR1_GAP_X;
   int y=m_window1.Y()+PROGRESSBAR1_GAP_Y;
//--- Set properties before creation
   m_progress_bar.XSize(520);
   m_progress_bar.YSize(15);
   m_progress_bar.BarYSize(11);
   m_progress_bar.BarXOffset(65);
   m_progress_bar.BarYOffset(2);
   m_progress_bar.BarBorderWidth(1);
   m_progress_bar.LabelText("Processing:");
   m_progress_bar.AreaColor(C'225,225,225');
   m_progress_bar.BarAreaColor(clrWhiteSmoke);
   m_progress_bar.BarBorderColor(clrWhiteSmoke);
   m_progress_bar.IsDropdown(true);
//--- Creating an element
   if(!m_progress_bar.CreateProgressBar(m_chart_id,m_subwin,x,y))
      return(false);
//--- Hide the element
   m_progress_bar.Hide();
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_progress_bar);
   return(true);
  }
//+------------------------------------------------------------------+
//| Update by timer                                                  |
//+------------------------------------------------------------------+
void CProgram::UpdateLineChartByTimer(void)
  {
//--- Leave, if the form is minimized or is in the process of moving
   if(m_window1.IsMinimized())
      return;
//--- Leave, if the animation is disabled
   if(!m_max_limit_size.CheckButtonState() && !m_run_speed.CheckButtonState())
      return;
//--- Delay
   static int count=0;
   if(count<m_delay_ms.GetValue())
     {
      count+=TIMER_STEP_MSC;
      return;
     }
   count=0;
//--- If the "Running series" option is enabled, shift the first value of the series
   ShiftLineChartSeries();
//--- If the management of series array size by timer is enabled
   AutoResizeLineChartSeries();
//--- Initialize the arrays
   InitArrays();
//--- (1) Calculate and (2) update the series
   CalculateSeries();
   UpdateSeries();
  }
//+------------------------------------------------------------------+
//| Resize the arrays                                                |
//+------------------------------------------------------------------+
void CProgram::ResizeDataArrays(void)
  {
   int total          =(int)m_series_total.ButtonText();
   int size_of_series =(int)m_series_size.GetValue();
//---
   for(int s=0; s<total; s++)
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
   int total=(int)m_series_total.ButtonText();
//---
   for(int s=0; s<total; s++)
     {
      int size_of_series=::ArraySize(m_series[s].data_temp);
      //---
      for(int i=0; i<size_of_series; i++)
        {
         if(i==0)
           {
            if(s>0)
               m_series[s].data_temp[i]=m_series[s-1].data_temp[i]+m_offset_series.GetValue();
            else
               m_series[s].data_temp[i]=m_run_speed_counter;
           }
         else
            m_series[s].data_temp[i]=m_series[s].data_temp[i-1]+(int)m_increment_ratio.GetValue();
        }
     }
  }
//+------------------------------------------------------------------+
//| Calculate the series                                             |
//+------------------------------------------------------------------+
void CProgram::CalculateSeries(void)
  {
   int total=(int)m_series_total.ButtonText();
//---
   for(int s=0; s<total; s++)
     {
      int size_of_series=::ArraySize(m_series[s].data_temp);
      //---
      for(int i=0; i<size_of_series; i++)
        {
         m_series[s].data_temp[i]+=m_offset_series.GetValue();
         //---
         switch(Formula)
           {
            case FORMULA_1 :
               m_series[s].data[i]=::sin(m_series[s].data_temp[i])-::cos(m_series[s].data_temp[i]);
               break;
            case FORMULA_2 :
               m_series[s].data[i]=::sin(m_series[s].data_temp[i]-::cos(m_series[s].data_temp[i]));
               break;
            case FORMULA_3 :
               m_series[s].data[i]=::sin(m_series[s].data_temp[i]*10)-::cos(m_series[s].data_temp[i]);
               break;
           }

        }
     }
  }
//+------------------------------------------------------------------+
//| Calculate and place the series on the chart                      |
//+------------------------------------------------------------------+
void CProgram::AddSeries(void)
  {
   int total=(int)m_series_total.ButtonText();
   for(int s=0; s<total; s++)
      m_line_chart.SeriesAdd(m_series[s].data,m_series_name[s],m_series_color[s]);
  }
//+------------------------------------------------------------------+
//| Calculate and update the series on the chart                     |
//+------------------------------------------------------------------+
void CProgram::UpdateSeries(void)
  {
   int total=(int)m_series_total.ButtonText();
   for(int s=0; s<total; s++)
      m_line_chart.SeriesUpdate(s,m_series[s].data,m_series_name[s],m_series_color[s]);
  }
//+------------------------------------------------------------------+
//| Recalculate the series on the chart                              |
//+------------------------------------------------------------------+
void CProgram::RecalculatingSeries(void)
  {
//--- (1) Set the sizes of arrays and (2) initialize them
   ResizeDataArrays();
   InitArrays();
//--- (1) Calculate and (2) update the series
   CalculateSeries();
   UpdateSeries();
  }
//+------------------------------------------------------------------+
//| Shift the line chart series                                      |
//+------------------------------------------------------------------+
void CProgram::ShiftLineChartSeries(void)
  {
   if(m_run_speed.CheckButtonState())
      m_run_speed_counter+=m_run_speed.GetValue();
  }
//+------------------------------------------------------------------+
//| Auto-resize the line chart series                                |
//+------------------------------------------------------------------+
void CProgram::AutoResizeLineChartSeries(void)
  {
//--- Leave, if increasing the series array by timer is disabled
   if(!m_max_limit_size.CheckButtonState())
      return;
//--- To specify the direction to resize the arrays
   static bool resize_direction=false;
//--- If the minimum array size is reached
   if((int)m_series_size.GetValue()<=m_min_limit_size.GetValue())
     {
      //--- Switch the direction to increasing the array
      resize_direction=false;
      //--- If it is necessary to change the value of X
      if(m_increment_ratio.CheckButtonState())
        {
         //--- To specify the direction of the increment ratio counter
         static bool increment_ratio_direction=true;
         //--- If the counter is directed at increasing
         if(increment_ratio_direction)
           {
            //--- If the maximum limit is reached, change the counter direction to the opposite
            if(m_increment_ratio.GetValue()>=m_increment_ratio.MaxValue()-1)
               increment_ratio_direction=false;
           }
         //--- If the counter is directed at decreasing
         else
           {
            //--- If the minimum limit is reached, change the counter direction to the opposite
            if(m_increment_ratio.GetValue()<=m_increment_ratio.MinValue()+1)
               increment_ratio_direction=true;
           }
         //--- Get the current value of the "Increment ratio" parameter and change it in the specified direction
         int increase_value=(int)m_increment_ratio.GetValue();
         m_increment_ratio.ChangeValue((increment_ratio_direction)? ++increase_value : --increase_value);
        }
     }
//--- Switch the direction to decreasing the array if the maximum has been reached
   if((int)m_series_size.GetValue()>=m_max_limit_size.GetValue())
      resize_direction=true;

//--- If the progress bar is enabled, display the process
   if(m_progress_bar.IsVisible())
     {
      if(!resize_direction)
         m_progress_bar.Update((int)m_series_size.GetValue(),(int)m_max_limit_size.GetValue());
      else
         m_progress_bar.Update(int(m_max_limit_size.GetValue()-m_series_size.GetValue()),(int)m_max_limit_size.GetValue());
     }
//--- Resize the array in the specified direction
   int size_of_series=(int)m_series_size.GetValue();
   m_series_size.ChangeValue((!resize_direction)? ++size_of_series : --size_of_series);
//--- Resize the arrays
   ResizeDataArrays();
  }
//+------------------------------------------------------------------+
