//+------------------------------------------------------------------+
//|                                                       Window.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
//--- Button margins from the right edge of the window
#define CLOSE_BUTTON_OFFSET   (20)
#define ROLL_BUTTON_OFFSET    (36)
#define TOOLTIP_BUTTON_OFFSET (53)
//+------------------------------------------------------------------+
//| Class for creating a form for controls                           |
//+------------------------------------------------------------------+
class CWindow : public CElement
  {
private:
   CChart            m_chart;
   //--- Objects for creating a form
   CRectLabel        m_bg;
   CRectLabel        m_caption_bg;
   CBmpLabel         m_icon;
   CLabel            m_label;
   CBmpLabel         m_button_tooltip;
   CBmpLabel         m_button_unroll;
   CBmpLabel         m_button_rollup;
   CBmpLabel         m_button_close;
   //--- Identifier of the last control
   int               m_last_id;
   //--- Identifier of the activated control
   int               m_id_activated_element;
   //--- Index of the previously active window
   int               m_prev_active_window_index;
   //--- Possibility to move a window over the chart
   bool              m_movable;
   //--- Status of a minimized window
   bool              m_is_minimized;
   //--- Status of a blocked window
   bool              m_is_locked;
   //--- Window type
   ENUM_WINDOW_TYPE  m_window_type;
   //--- Mode of sub-window set height (for indicators)
   bool              m_height_subwindow_mode;
   //--- Mode of the form minimization in the indicator sub-window
   bool              m_rollup_subwindow_mode;
   //--- Height of the indicator sub-window
   int               m_subwindow_height;
   //--- Background properties
   color             m_bg_color;
   int               m_bg_full_height;
   //--- Header properties
   string            m_caption_text;
   int               m_caption_height;
   color             m_caption_bg_color;
   color             m_caption_bg_color_off;
   color             m_caption_bg_color_hover;
   color             m_caption_color_bg_array[];
   //--- Color of the form frame (background, header)
   color             m_border_color;
   //--- Form label
   string            m_icon_file;
   //--- Margins of the header text label
   int               m_label_x_gap;
   int               m_label_y_gap;
   //--- Presence of the button for the tooltip display mode
   bool              m_tooltips_button;
   //--- Presence of the button for minimizing/maximizing the window
   bool              m_roll_button;

   //--- Chart size
   int               m_chart_width;
   int               m_chart_height;

   //--- For identifying the capture area boundaries in the window header
   int               m_right_limit;
   //--- Variables connected with the displacement
   int               m_prev_x;
   int               m_prev_y;
   int               m_size_fixing_x;
   int               m_size_fixing_y;
   //--- Priorities of the left mouse button press
   int               m_bg_zorder;
   int               m_caption_zorder;
   int               m_button_zorder;

   //--- State of the mouse button considering the position where it was clicked
   ENUM_MOUSE_STATE  m_clamping_area_mouse;
   //--- For managing the State of the Chart
   bool              m_custom_event_chart_state;
   //---
public:
                     CWindow(void);
                    ~CWindow(void);
   //--- Methods for creating a window
   bool              CreateWindow(const long chart_id,const int window,const string caption_text,const int x,const int y);
   //---
private:
   bool              CreateBackground(void);
   bool              CreateCaption(void);
   bool              CreateIcon(void);
   bool              CreateLabel(void);
   bool              CreateButtonClose(void);
   bool              CreateButtonRollUp(void);
   bool              CreateButtonUnroll(void);
   bool              CreateButtonTooltip(void);
   //--- Changing the color of the form objects
   void              ChangeObjectsColor(void);
   //---
public:
   //--- Methods for storing and getting the id of the last created element
   int               LastId(void)                                      const { return(m_last_id);                  }
   void              LastId(const int id)                                    { m_last_id=id;                       }
   //--- Methods for storing and getting the id of the activated element
   int               IdActivatedElement(void)                          const { return(m_id_activated_element);     }
   void              IdActivatedElement(const int id)                        { m_id_activated_element=id;          }
   //--- (1) Getting and storing the index of the previously active window
   int               PrevActiveWindowIndex(void)                       const { return(m_prev_active_window_index); }
   void              PrevActiveWindowIndex(const int index)                  { m_prev_active_window_index=index;   }
   //--- Window type
   ENUM_WINDOW_TYPE  WindowType(void)                                  const { return(m_window_type);              }
   void              WindowType(const ENUM_WINDOW_TYPE flag)                 { m_window_type=flag;                 }
   //--- Default label
   string            DefaultIcon(void);
   //--- (1) custom icon of the window, (2) limitation of the capture area of the header
   void              IconFile(const string file_path)                        { m_icon_file=file_path;              }
   void              RightLimit(const int value)                             { m_right_limit=value;                }
   //--- Header properties
   void              CaptionText(const string text);
   string            CaptionText(void)                                 const { return(m_caption_text);             }
   void              CaptionHeight(const int height)                         { m_caption_height=height;            }
   int               CaptionHeight(void)                               const { return(m_caption_height);           }
   void              CaptionBgColor(const color clr)                         { m_caption_bg_color=clr;             }
   color             CaptionBgColor(void)                              const { return(m_caption_bg_color);         }
   void              CaptionBgColorOff(const color clr)                      { m_caption_bg_color_off=clr;         }
   void              CaptionBgColorHover(const color clr)                    { m_caption_bg_color_hover=clr;       }
   color             CaptionBgColorHover(void)                         const { return(m_caption_bg_color_hover);   }
   //--- Window properties
   void              WindowBgColor(const color clr)                          { m_bg_color=clr;                     }
   color             WindowBgColor(void)                               const { return(m_bg_color);                 }
   void              WindowBorderColor(const color clr)                      { m_border_color=clr;                 }
   color             WindowBorderColor(void)                           const { return(m_border_color);             }
   //--- Text label margins
   void              LabelXGap(const int x_gap)                              { m_label_x_gap=x_gap;                }
   void              LabelYGap(const int y_gap)                              { m_label_y_gap=y_gap;                }
   //--- (1) Use the tooltip button, (2) use the button for minimizing/maximizing the window, (3) check of the tooltip display mode
   void              UseRollButton(void)                                     { m_roll_button=true;                 }
   void              UseTooltipsButton(void)                                 { m_tooltips_button=true;             }
   bool              TooltipButtonState(void)                          const { return(m_button_tooltip.State());   }
   //--- Possibility of moving the window
   bool              Movable(void)                                     const { return(m_movable);                  }
   void              Movable(const bool flag)                                { m_movable=flag;                     }
   //--- Status of a minimized window
   bool              IsMinimized(void)                                 const { return(m_is_minimized);             }
   void              IsMinimized(const bool flag)                            { m_is_minimized=flag;                }
   //--- Status of a blocked window
   bool              IsLocked(void)                                    const { return(m_is_locked);                }
   void              IsLocked(const bool flag)                               { m_is_locked=flag;                   }

   //--- Setting the state of the window
   void              State(const bool flag);
   //--- The indicator sub-window minimization mode
   void              RollUpSubwindowMode(const bool flag,const bool height_mode);
   //--- Managing the size
   void              ChangeWindowWidth(const int width);
   void              ChangeSubwindowHeight(const int height);

   //--- Getting the chart size
   void              SetWindowProperties(void);
   //--- Checking the cursor in the header area 
   bool              CursorInsideCaption(const int x,const int y);
   //--- Zeroing variables
   void              ZeroPanelVariables(void);

   //--- Verifying the state of the left mouse button
   void              CheckMouseButtonState(const int x,const int y,const bool state);
   //--- Verifying the mouse focus
   void              CheckMouseFocus(const int x,const int y,const int subwin);
   //--- Setting the chart mode
   void              SetChartState(const int subwindow_number);
   //--- Updating the form coordinates
   void              UpdateWindowXY(const int x,const int y);
   //--- Custom flag for managing the chart properties
   void              CustomEventChartState(const bool state) { m_custom_event_chart_state=state; }

   //--- Closing the main window
   bool              CloseWindow(const string pressed_object);
   //--- Closing a dialog window
   void              CloseDialogBox(void);

   //--- Changing the window state
   bool              ChangeWindowState(const string pressed_object);
   //--- Methods for (1) minimizing and (2) maximizing the window
   void              RollUp(void);
   void              Unroll(void);
   //---
public:
   //--- Chart event handler
   virtual void      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
   //--- Timer
   virtual void      OnEventTimer(void);
   //--- Moving the element
   virtual void      Moving(const int x,const int y);
   //--- Showing, hiding, resetting, deleting
   virtual void      Show(void);
   virtual void      Hide(void);
   virtual void      Reset(void);
   virtual void      Delete(void);
   //--- Setting, resetting of priorities for left clicking on mouse
   virtual void      SetZorders(void);
   virtual void      ResetZorders(void);
   //--- Reset the color
   virtual void      ResetColors(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CWindow::CWindow(void) : m_last_id(0),
                         m_id_activated_element(WRONG_VALUE),
                         m_prev_active_window_index(0),
                         m_subwindow_height(0),
                         m_rollup_subwindow_mode(false),
                         m_height_subwindow_mode(false),
                         m_movable(false),
                         m_is_locked(false),
                         m_is_minimized(false),
                         m_roll_button(false),
                         m_tooltips_button(false),
                         m_window_type(W_MAIN),
                         m_icon_file(""),
                         m_right_limit(0),
                         m_clamping_area_mouse(NOT_PRESSED),
                         m_caption_height(20),
                         m_caption_bg_color(clrLightSteelBlue),
                         m_caption_bg_color_off(clrSilver),
                         m_caption_bg_color_hover(clrLightSteelBlue),
                         m_bg_color(clrWhiteSmoke),
                         m_border_color(clrLightSteelBlue),
                         m_label_x_gap(24),
                         m_label_y_gap(4)

  {
//--- Store the name of the element class in the base class
   CElement::ClassName(CLASS_NAME);
//--- Set a strict sequence of priorities
   m_bg_zorder      =0;
   m_caption_zorder =1;
   m_button_zorder  =2;
//--- Get the ID of the current chart
   m_chart.Attach();
//--- Get the chart window size
   SetWindowProperties();
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CWindow::~CWindow(void)
  {
   m_chart.Detach();
  }
//+------------------------------------------------------------------+
//| Chart event handler                                              |
//+------------------------------------------------------------------+
void CWindow::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- Handling of the cursor movement event
   if(id==CHARTEVENT_MOUSE_MOVE)
     {
      //--- Check and store the state of the mouse button
      CheckMouseButtonState(m_mouse.X(),m_mouse.Y(),m_mouse.LeftButtonState());
      //--- Verifying the mouse focus
      CheckMouseFocus(m_mouse.X(),m_mouse.Y(),m_mouse.SubWindowNumber());
      //--- Set the chart state
      SetChartState(m_mouse.SubWindowNumber());
      //--- Leave, if the form is blocked
      if(m_is_locked)
         return;
      //--- If the management is delegated to the window, identify its location
      if(m_clamping_area_mouse==PRESSED_INSIDE_HEADER)
        {
         //--- Leave, if numbers of subwindows do not match
         if(CElement::m_subwin!=CElement::m_mouse.SubWindowNumber())
            return;
         //--- Updating window coordinates
         UpdateWindowXY(m_mouse.X(),m_mouse.Y());
        }
      //---
      return;
     }
//--- Handling the clicking on an object event
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      //--- Close window
      CloseWindow(sparam);
      //--- Minimize/Maximize the window
      ChangeWindowState(sparam);
      return;
     }
//--- The chart properties change event
   if(id==CHARTEVENT_CHART_CHANGE)
     {
      //--- If the button is unpressed
      if(m_clamping_area_mouse==NOT_PRESSED)
        {
         //--- Get the chart window size
         SetWindowProperties();
         //--- Adjustment of coordinates
         UpdateWindowXY(m_x,m_y);
        }
      //--- Resize, if the mode is enabled
      if(CElement::AutoXResizeMode())
         ChangeWindowWidth(m_chart.WidthInPixels()-2);
      //---
      return;
     }
  }
//+------------------------------------------------------------------+
//| Timer                                                            |
//+------------------------------------------------------------------+
void CWindow::OnEventTimer(void)
  {
//--- If the window is not blocked
   if(!m_is_locked)
     {
      //--- Changing the color of the form objects
      ChangeObjectsColor();
     }
  }
//+------------------------------------------------------------------+
//| Creates a form for controls                                      |
//+------------------------------------------------------------------+
bool CWindow::CreateWindow(const long chart_id,const int subwin,const string caption_text,const int x,const int y)
  {
   if(CElement::Id()==WRONG_VALUE)
     {
      ::Print(__FUNCTION__," > Before creating a window, its pointer has to be stored in the base: CWndContainer::AddWindow(CWindow &object)");
      return(false);
     }
//--- Initializing variables
   m_chart_id       =chart_id;
   m_subwin         =subwin;
   m_caption_text   =caption_text;
   m_x              =x;
   m_y              =y;
   m_bg_full_height =m_y_size;
//--- Creating all objects of the window
   if(!CreateBackground())
      return(false);
   if(!CreateCaption())
      return(false);
   if(!CreateLabel())
      return(false);
   if(!CreateIcon())
      return(false);
   if(!CreateButtonClose())
      return(false);
   if(!CreateButtonRollUp())
      return(false);
   if(!CreateButtonUnroll())
      return(false);
   if(!CreateButtonTooltip())
      return(false);
//--- If this program is an indicator
   if(CElement::ProgramType()==PROGRAM_INDICATOR)
     {
      //--- If the mode of the sub-window set height is set
      if(m_height_subwindow_mode)
        {
         m_subwindow_height=m_bg_full_height+3;
         ChangeSubwindowHeight(m_subwindow_height);
        }
     }
//--- Hide the window, if it is a dialog window
   if(m_window_type==W_DIALOG)
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates the window background                                    |
//+------------------------------------------------------------------+
bool CWindow::CreateBackground(void)
  {
//--- Forming the object name
   string name=CElement::ProgramName()+"_window_bg_"+(string)CElement::Id();
//--- Size of the window depends on its state (minimized/maximized)
   int y_size=0;
   if(m_is_minimized)
     {
      y_size=m_caption_height;
      CElement::YSize(m_caption_height);
     }
   else
     {
      y_size=m_bg_full_height;
      CElement::YSize(m_bg_full_height);
     }
//--- Set the window background
   if(!m_bg.Create(m_chart_id,name,m_subwin,m_x,m_y,m_x_size,y_size))
      return(false);
//--- set properties
   m_bg.BackColor(m_bg_color);
   m_bg.Color(m_border_color);
   m_bg.BorderType(BORDER_FLAT);
   m_bg.Corner(m_corner);
   m_bg.Selectable(false);
   m_bg.Z_Order(m_bg_zorder);
   m_bg.Tooltip("\n");
//--- Store the size (in the object)
   m_bg.XSize(m_bg.X_Size());
   m_bg.YSize(m_bg.Y_Size());
//--- Store the object pointer
   CElement::AddToArray(m_bg);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates the window header                                        |
//+------------------------------------------------------------------+
bool CWindow::CreateCaption(void)
  {
//--- Forming the object name  
   string name=CElement::ProgramName()+"_window_caption_"+(string)CElement::Id();
//--- Set the window header
   if(!m_caption_bg.Create(m_chart_id,name,m_subwin,m_x,m_y,m_x_size,m_caption_height))
      return(false);
//--- set properties
   m_caption_bg.BackColor(m_caption_bg_color);
   m_caption_bg.Color(m_border_color);
   m_caption_bg.BorderType(BORDER_FLAT);
   m_caption_bg.Corner(m_corner);
   m_caption_bg.Selectable(false);
   m_caption_bg.Z_Order(m_caption_zorder);
   m_caption_bg.Tooltip("\n");
//--- Store coordinates
   m_caption_bg.X(m_x);
   m_caption_bg.Y(m_y);
//--- Store the size (in the object)
   m_caption_bg.XSize(m_caption_bg.X_Size());
   m_caption_bg.YSize(m_caption_bg.Y_Size());
//--- Initializing gradient array
   CElement::InitColorArray(m_caption_bg_color,m_caption_bg_color_hover,m_caption_color_bg_array);
//--- Store the object pointer
   CElement::AddToArray(m_caption_bg);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates the program label                                        |
//+------------------------------------------------------------------+
//--- Icons (by default) symbolizing the program type
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\advisor.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\indicator.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\script.bmp"
//---
bool CWindow::CreateIcon(void)
  {
   string name=CElement::ProgramName()+"_window_icon_"+(string)CElement::Id();
//--- Object coordinates
   int x=m_x+5;
   int y=m_y+2;
//--- Set the window icon
   if(!m_icon.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Default icon, if not specified by the user
   if(m_icon_file=="")
      m_icon_file=DefaultIcon();
//--- set properties
   m_icon.BmpFileOn("::"+m_icon_file);
   m_icon.BmpFileOff("::"+m_icon_file);
   m_icon.Corner(m_corner);
   m_icon.Selectable(false);
   m_icon.Z_Order(m_button_zorder);
   m_icon.Tooltip("\n");
//--- Store coordinates
   m_icon.X(x);
   m_icon.Y(y);
//--- Margins from the edge
   m_icon.XGap(x-m_x);
   m_icon.YGap(y-m_y);
//--- Store the size
   m_icon.XSize(m_icon.X_Size());
   m_icon.YSize(m_icon.Y_Size());
//--- Store the object pointer
   CElement::AddToArray(m_icon);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates the text label of the header                             |
//+------------------------------------------------------------------+
bool CWindow::CreateLabel(void)
  {
   string name=CElement::ProgramName()+"_window_label_"+(string)CElement::Id();
//--- Object coordinates
   int x=CElement::X()+m_label_x_gap;
   int y=CElement::Y()+m_label_y_gap;
//--- Set the text label
   if(!m_label.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- set properties
   m_label.Description(m_caption_text);
   m_label.Font(FONT);
   m_label.FontSize(FONT_SIZE);
   m_label.Color(clrBlack);
   m_label.Corner(m_corner);
   m_label.Selectable(false);
   m_label.Z_Order(m_button_zorder);
   m_label.Tooltip("\n");
//--- Store coordinates
   m_label.X(x);
   m_label.Y(y);
//--- Margins from the edge
   m_label.XGap(x-m_x);
   m_label.YGap(y-m_y);
//--- Store the size
   m_label.XSize(m_label.X_Size());
   m_label.YSize(m_label.Y_Size());
//--- Store the object pointer
   CElement::AddToArray(m_label);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates the button for closing the program                       |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\Close_red.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\Close_black.bmp"
//---
bool CWindow::CreateButtonClose(void)
  {
//--- If the program type is script, leave
   if(CElement::ProgramType()==PROGRAM_SCRIPT)
      return(true);
//--- Forming the object name
   string name=CElement::ProgramName()+"_window_close_"+(string)CElement::Id();
//--- Object coordinates
   int x=m_x+m_x_size-CLOSE_BUTTON_OFFSET;
   int y=m_y+2;
//--- Increase the capture area
   m_right_limit+=20;
//--- Set up a button
   if(!m_button_close.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- set properties
   m_button_close.BmpFileOn("::Images\\EasyAndFastGUI\\Controls\\Close_red.bmp");
   m_button_close.BmpFileOff("::Images\\EasyAndFastGUI\\Controls\\Close_black.bmp");
   m_button_close.Corner(m_corner);
   m_button_close.Selectable(false);
   m_button_close.Z_Order(m_button_zorder);
   m_button_close.Tooltip("Close");
//--- Store coordinates
   m_button_close.X(x);
   m_button_close.Y(y);
//--- Margins from the edge
   m_button_close.XGap(x-m_x);
   m_button_close.YGap(y-m_y);
//--- Store the size
   m_button_close.XSize(m_button_close.X_Size());
   m_button_close.YSize(m_button_close.Y_Size());
//--- Store the object pointer
   CElement::AddToArray(m_button_close);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates the button for minimizing the window                     |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\DropOn_black.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\DropOn_white.bmp"
//---
bool CWindow::CreateButtonRollUp(void)
  {
//--- Leave, if the button is not enabled
   if(!m_roll_button)
      return(true);
//--- If the program type is script, leave
   if(CElement::ProgramType()==PROGRAM_SCRIPT)
      return(true);
//--- This button is not required, if the window is a dialog window
   if(m_window_type==W_DIALOG)
      return(true);
//--- Forming the object name
   string name=CElement::ProgramName()+"_window_rollup_"+(string)CElement::Id();
//--- Object coordinates
   int x=m_x+m_x_size-ROLL_BUTTON_OFFSET;
   int y=m_y+3;
//--- Increase the capture area, if the window is maximized
   if(!m_is_minimized)
      m_right_limit+=20;
//--- Set up a button
   if(!m_button_rollup.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- set properties
   m_button_rollup.BmpFileOn("::Images\\EasyAndFastGUI\\Controls\\DropOn_white.bmp");
   m_button_rollup.BmpFileOff("::Images\\EasyAndFastGUI\\Controls\\DropOn_black.bmp");
   m_button_rollup.Corner(m_corner);
   m_button_rollup.Selectable(false);
   m_button_rollup.Z_Order(m_button_zorder);
   m_button_rollup.Tooltip("Roll Up");
//--- Store coordinates
   m_button_rollup.X(x);
   m_button_rollup.Y(y);
//--- Margins from the edge
   m_button_rollup.XGap(x-m_x);
   m_button_rollup.YGap(y-m_y);
//--- Store the size (in the object)
   m_button_rollup.XSize(m_button_rollup.X_Size());
   m_button_rollup.YSize(m_button_rollup.Y_Size());
//--- Hide the object
   if(m_is_minimized)
      m_button_rollup.Timeframes(OBJ_NO_PERIODS);
//--- Add objects to the group array
   CElement::AddToArray(m_button_rollup);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates the button for maximizing the window                     |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\DropOff_black.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\DropOff_white.bmp"
//---
bool CWindow::CreateButtonUnroll(void)
  {
//--- Leave, if the button is not enabled
   if(!m_roll_button)
      return(true);
//--- If the program type is script, leave
   if(PROGRAM_TYPE==PROGRAM_SCRIPT)
      return(true);
//--- This button is not required, if the window is a dialog window
   if(m_window_type==W_DIALOG)
      return(true);
//--- Forming the object name
   string name=CElement::ProgramName()+"_window_unroll_"+(string)CElement::Id();
//--- Object coordinates
   int x=m_x+m_x_size-ROLL_BUTTON_OFFSET;
   int y=m_y+3;
//--- Increase the capture area, if the window is minimized
   if(m_is_minimized)
      m_right_limit+=20;
//--- Set up a button
   if(!m_button_unroll.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- set properties
   m_button_unroll.BmpFileOn("::Images\\EasyAndFastGUI\\Controls\\DropOff_white.bmp");
   m_button_unroll.BmpFileOff("::Images\\EasyAndFastGUI\\Controls\\DropOff_black.bmp");
   m_button_unroll.Corner(m_corner);
   m_button_unroll.Selectable(false);
   m_button_unroll.Z_Order(m_button_zorder);
   m_button_unroll.Tooltip("Unroll");
//--- Store coordinates
   m_button_unroll.X(x);
   m_button_unroll.Y(y);
//--- Margins from the edge
   m_button_unroll.XGap(x-m_x);
   m_button_unroll.YGap(y-m_y);
//--- Store the size (in the object)
   m_button_unroll.XSize(m_button_unroll.X_Size());
   m_button_unroll.YSize(m_button_unroll.Y_Size());
//--- Add objects to the group array
   CElement::AddToArray(m_button_unroll);
//--- Hide the object
   if(!m_is_minimized)
      m_button_unroll.Timeframes(OBJ_NO_PERIODS);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates the tooltip button                                       |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\Help_dark.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\Help_light.bmp"
//---
bool CWindow::CreateButtonTooltip(void)
  {
//--- If the program type is script, leave
   if(PROGRAM_TYPE==PROGRAM_SCRIPT)
      return(true);
//--- This button is not required, if the window is a dialog window
   if(m_window_type==W_DIALOG)
      return(true);
//--- Leave, if this button is not required
   if(!m_tooltips_button)
      return(true);
//--- Forming the object name
   string name=CElement::ProgramName()+"_window_tooltip_"+(string)CElement::Id();
//--- Object offset
   int offset=(!m_roll_button)? ROLL_BUTTON_OFFSET+2 : TOOLTIP_BUTTON_OFFSET;
//--- Object coordinates
   int x=m_x+m_x_size-offset;
   int y=m_y+2;
//--- Increase the capture area
   if(!m_roll_button)
      m_right_limit+=20;
//--- Set up a button
   if(!m_button_tooltip.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- set properties
   m_button_tooltip.BmpFileOn("::Images\\EasyAndFastGUI\\Controls\\Help_light.bmp");
   m_button_tooltip.BmpFileOff("::Images\\EasyAndFastGUI\\Controls\\Help_dark.bmp");
   m_button_tooltip.Corner(m_corner);
   m_button_tooltip.Selectable(false);
   m_button_tooltip.Z_Order(m_button_zorder);
   m_button_tooltip.Tooltip("Tooltips");
//--- Store coordinates
   m_button_tooltip.X(x);
   m_button_tooltip.Y(y);
//--- Margins from the edge
   m_button_tooltip.XGap(x-m_x);
   m_button_tooltip.YGap(y-m_y);
//--- Store the size (in the object)
   m_button_tooltip.XSize(m_button_tooltip.X_Size());
   m_button_tooltip.YSize(m_button_tooltip.Y_Size());
//--- Add objects to the group array
   CElement::AddToArray(m_button_tooltip);
   return(true);
  }
//+------------------------------------------------------------------+
//| Edits the header text                                            |
//+------------------------------------------------------------------+
void CWindow::CaptionText(const string text)
  {
   m_caption_text=text;
   m_label.Description(text);
  }
//+------------------------------------------------------------------+
//| Identifying the default icon                                     |
//+------------------------------------------------------------------+
string CWindow::DefaultIcon(void)
  {
   string path="Images\\EasyAndFastGUI\\Icons\\bmp16\\advisor.bmp";
//---
   switch(CElement::ProgramType())
     {
      case PROGRAM_SCRIPT:
        {
         path="Images\\EasyAndFastGUI\\Icons\\bmp16\\script.bmp";
         break;
        }
      case PROGRAM_EXPERT:
        {
         path="Images\\EasyAndFastGUI\\Icons\\bmp16\\advisor.bmp";
         break;
        }
      case PROGRAM_INDICATOR:
        {
         path="Images\\EasyAndFastGUI\\Icons\\bmp16\\indicator.bmp";
         break;
        }
     }
//---
   return(path);
  }
//+------------------------------------------------------------------+
//| Mode of indicator sub-window minimization                        |
//+------------------------------------------------------------------+
void CWindow::RollUpSubwindowMode(const bool rollup_mode=false,const bool height_mode=false)
  {
   if(CElement::m_program_type!=PROGRAM_INDICATOR)
      return;
//---
   m_rollup_subwindow_mode =rollup_mode;
   m_height_subwindow_mode =height_mode;
//---
   if(m_height_subwindow_mode)
      ChangeSubwindowHeight(m_subwindow_height);
  }
//+------------------------------------------------------------------+
//| Changes the height of the indicator sub-window                   |
//+------------------------------------------------------------------+
void CWindow::ChangeSubwindowHeight(const int height)
  {
   if(CElement::m_subwin<=0 || CElement::m_program_type!=PROGRAM_INDICATOR)
      return;
//---
   if(height>0)
      ::IndicatorSetInteger(INDICATOR_HEIGHT,height);
  }
//+------------------------------------------------------------------+
//| Changes the width of the window                                  |
//+------------------------------------------------------------------+
void CWindow::ChangeWindowWidth(const int width)
  {
//--- If the width has not changed, leave
   if(width==m_bg.XSize())
      return;
//--- Update the width for the background and the header
   CElement::XSize(width);
   m_bg.XSize(width);
   m_bg.X_Size(width);
   m_caption_bg.XSize(width);
   m_caption_bg.X_Size(width);
//--- Update coordinates and margins for all buttons:
//    Closing button
   int x=CElement::X2()-CLOSE_BUTTON_OFFSET;
   m_button_close.X(x);
   m_button_close.XGap(x-m_x);
   m_button_close.X_Distance(x);
//--- Maximizing button
   x=CElement::X2()-ROLL_BUTTON_OFFSET;
   m_button_unroll.X(x);
   m_button_unroll.XGap(x-m_x);
   m_button_unroll.X_Distance(x);
//--- Minimizing button
   m_button_rollup.X(x);
   m_button_rollup.XGap(x-m_x);
   m_button_rollup.X_Distance(x);
//--- Tooltip button (if enabled)
   if(m_tooltips_button)
     {
      x=CElement::X2()-TOOLTIP_BUTTON_OFFSET;
      m_button_tooltip.X(x);
      m_button_tooltip.XGap(x-m_x);
      m_button_tooltip.X_Distance(x);
     }
//--- A message that the window sizes have been changed
   ::EventChartCustom(m_chart_id,ON_WINDOW_CHANGE_SIZE,(long)CElement::Id(),0,"");
  }
//+------------------------------------------------------------------+
//| Getting the chart size                                           |
//+------------------------------------------------------------------+
void CWindow::SetWindowProperties(void)
  {
//--- Get the width and the height of the chart window
   m_chart_width  =m_chart.WidthInPixels();
   m_chart_height =m_chart.HeightInPixels(m_subwin);
  }
//+------------------------------------------------------------------+
//| Verifying the cursor location in the area of the window title    |
//+------------------------------------------------------------------+
bool CWindow::CursorInsideCaption(const int x,const int y)
  {
   return(x>m_x && x<X2()-m_right_limit && y>m_y && y<m_caption_bg.Y2());
  }
//+------------------------------------------------------------------+
//| Zeroing variables connected with displacement of the window and  |
//| the state of the left mouse button                               |
//+------------------------------------------------------------------+
void CWindow::ZeroPanelVariables(void)
  {
   m_prev_x              =0;
   m_prev_y              =0;
   m_size_fixing_x       =0;
   m_size_fixing_y       =0;
   m_clamping_area_mouse =NOT_PRESSED;
  }
//+------------------------------------------------------------------+
//| Verifies the state of the mouse button                           |
//+------------------------------------------------------------------+
void CWindow::CheckMouseButtonState(const int x,const int y,const bool state)
  {
//--- If the button is unpressed
   if(!state)
     {
      //--- Zero variables
      ZeroPanelVariables();
      return;
     }
//--- If pressed down
   if(state)
     {
      //--- Leave, if the state is already recorded
      if(m_clamping_area_mouse!=NOT_PRESSED)
         return;
      //--- Outside of the panel area
      if(!CElement::MouseFocus())
         m_clamping_area_mouse=PRESSED_OUTSIDE;
      //--- Inside the panel area
      else
        {
         //--- If inside the header
         if(CursorInsideCaption(x,y))
           {
            m_clamping_area_mouse=PRESSED_INSIDE_HEADER;
            return;
           }
         //--- If inside the window area
         m_clamping_area_mouse=PRESSED_INSIDE;
        }
     }
  }
//+------------------------------------------------------------------+
//| Verifying the mouse focus                                        |
//+------------------------------------------------------------------+
void CWindow::CheckMouseFocus(const int x,const int y,const int subwin)
  {
//--- If the cursor is in the program window area
   if(subwin==m_subwin)
     {
      //--- If currently not in the form displacement mode
      if(m_clamping_area_mouse!=PRESSED_INSIDE_HEADER)
        {
         //--- Verify the cursor location
         CElement::MouseFocus(x>m_x && x<X2() && y>m_y && y<Y2());
         //---
         m_button_close.MouseFocus(x>m_button_close.X() && x<m_button_close.X2() && 
                                   y>m_button_close.Y() && y<m_button_close.Y2());
         m_button_rollup.MouseFocus(x>m_button_rollup.X() && x<m_button_rollup.X2() && 
                                    y>m_button_rollup.Y() && y<m_button_rollup.Y2());
         m_button_unroll.MouseFocus(x>m_button_unroll.X() && x<m_button_unroll.X2() && 
                                    y>m_button_unroll.Y() && y<m_button_unroll.Y2());
        }
     }
   else
     {
      CElement::MouseFocus(false);
     }
  }
//+------------------------------------------------------------------+
//| Set the chart state                                              |
//+------------------------------------------------------------------+
void CWindow::SetChartState(const int subwindow_number)
  {
//--- If (the cursor is in the panel area and the mouse button is released) or
//    the mouse button was pressed inside the area of the form or header
   if((CElement::MouseFocus() && m_clamping_area_mouse==NOT_PRESSED) || 
      m_clamping_area_mouse==PRESSED_INSIDE_HEADER ||
      m_clamping_area_mouse==PRESSED_INSIDE ||
      m_custom_event_chart_state)
     {
      //--- Disable scroll and management of trading levels
      m_chart.MouseScroll(false);
      m_chart.SetInteger(CHART_DRAG_TRADE_LEVELS,false);
     }
//--- Enable management, if the cursor is outside of the window area
   else
     {
      m_chart.MouseScroll(true);
      m_chart.SetInteger(CHART_DRAG_TRADE_LEVELS,true);
     }
  }
//+------------------------------------------------------------------+
//| Updating window coordinates                                      |
//+------------------------------------------------------------------+
void CWindow::UpdateWindowXY(const int x,const int y)
  {
//--- If the fixed form mode is set
   if(!m_movable)
      return;
//---  
   int new_x_point =0; // New X coordinate
   int new_y_point =0; // New Y coordinate
//--- Limits
   int limit_top    =0;
   int limit_left   =0;
   int limit_bottom =0;
   int limit_right  =0;
//--- If the mouse button is pressed
   if((bool)m_clamping_area_mouse)
     {
      //--- Store current XY coordinates of the cursor
      if(m_prev_y==0 || m_prev_x==0)
        {
         m_prev_y=y;
         m_prev_x=x;
        }
      //--- Store the distance from the edge point of the form to the cursor
      if(m_size_fixing_y==0 || m_size_fixing_x==0)
        {
         m_size_fixing_y=m_y-m_prev_y;
         m_size_fixing_x=m_x-m_prev_x;
        }
     }
//--- Set limits
   limit_top    =y-::fabs(m_size_fixing_y);
   limit_left   =x-::fabs(m_size_fixing_x);
   limit_bottom =m_y+m_caption_height;
   limit_right  =m_x+m_x_size;
//--- If the boundaries of the chart are not exceeded downwards/upwards/right/left
   if(limit_bottom<m_chart_height && limit_top>=0 && 
      limit_right<m_chart_width && limit_left>=0)
     {
      new_y_point =y+m_size_fixing_y;
      new_x_point =x+m_size_fixing_x;
     }
//--- If the boundaries of the chart were exceeded
   else
     {
      if(limit_bottom>m_chart_height) // > downwards
        {
         new_y_point =m_chart_height-m_caption_height;
         new_x_point =x+m_size_fixing_x;
        }
      if(limit_top<0) // > upwards
        {
         new_y_point =0;
         new_x_point =x+m_size_fixing_x;
        }
      if(limit_right>m_chart_width) // > right
        {
         new_x_point =m_chart_width-m_x_size;
         new_y_point =y+m_size_fixing_y;
        }
      if(limit_left<0) // > left
        {
         new_x_point =0;
         new_y_point =y+m_size_fixing_y;
        }
     }
//--- Update coordinates, if there was a displacement
   if(new_x_point>0 || new_y_point>0)
     {
      //--- Adjust the form coordinates
      m_x =(new_x_point<=0)? 1 : new_x_point;
      m_y =(new_y_point<=0)? 1 : new_y_point;
      //---
      if(new_x_point>0)
         m_x=(m_x>m_chart_width-m_x_size-1) ? m_chart_width-m_x_size-1 : m_x;
      if(new_y_point>0)
         m_y=(m_y>m_chart_height-m_caption_height-1) ? m_chart_height-m_caption_height-2 : m_y;
      //--- Zero the fixed points
      m_prev_x=0;
      m_prev_y=0;
     }
  }
//+------------------------------------------------------------------+
//| Setting the state of the window                                  |
//+------------------------------------------------------------------+
void CWindow::State(const bool flag)
  {
//--- If the window is to be blocked
   if(!flag)
     {
      //--- Set the status
      m_is_locked=true;
      //--- Set the color of header and window borders
      m_bg.Color(m_caption_bg_color_off);
      m_caption_bg.Color(m_caption_bg_color_off);
      m_caption_bg.BackColor(m_caption_bg_color_off);
      //--- Signal to zero the color. The reset will be performed for other elements too.
      ::EventChartCustom(m_chart_id,ON_RESET_WINDOW_COLORS,(long)CElement::Id(),0,"");
     }
//--- If the window is to be unblocked
   else
     {
      //--- Set the status
      m_is_locked=false;
      //--- Set the color of the header
      m_bg.Color(m_border_color);
      m_caption_bg.Color(m_border_color);
      m_caption_bg.BackColor(m_caption_bg_color);
      //--- Zero the focus
      CElement::MouseFocus(false);
     }
  }
//+------------------------------------------------------------------+
//| Changing the object color when the cursor is hovering over it    |
//+------------------------------------------------------------------+
void CWindow::ChangeObjectsColor(void)
  {
//--- Changing icons in the buttons
   m_button_close.State(m_button_close.MouseFocus());
   m_button_rollup.State(m_button_rollup.MouseFocus());
   m_button_unroll.State(m_button_unroll.MouseFocus());
//--- Changing color in the header
   CElement::ChangeObjectColor(m_caption_bg.Name(),CElement::MouseFocus(),OBJPROP_BGCOLOR,
                               m_caption_bg_color,m_caption_bg_color_hover,m_caption_color_bg_array);
  }
//+------------------------------------------------------------------+
//| Moving the window                                                |
//+------------------------------------------------------------------+
void CWindow::Moving(const int x,const int y)
  {
//--- Storing coordinates in variables
   m_bg.X(x);
   m_bg.Y(y);
   m_caption_bg.X(x);
   m_caption_bg.Y(y);
   m_icon.X(x+m_icon.XGap());
   m_icon.Y(y+m_icon.YGap());
   m_label.X(x+m_label.XGap());
   m_label.Y(y+m_label.YGap());
   m_button_close.X(x+m_button_close.XGap());
   m_button_close.Y(y+m_button_close.YGap());
   m_button_unroll.X(x+m_button_unroll.XGap());
   m_button_unroll.Y(y+m_button_unroll.YGap());
   m_button_rollup.X(x+m_button_rollup.XGap());
   m_button_rollup.Y(y+m_button_rollup.YGap());
   m_button_tooltip.X(x+m_button_tooltip.XGap());
   m_button_tooltip.Y(y+m_button_tooltip.YGap());
//--- Updating coordinates of graphical objects
   m_bg.X_Distance(m_bg.X());
   m_bg.Y_Distance(m_bg.Y());
   m_caption_bg.X_Distance(m_caption_bg.X());
   m_caption_bg.Y_Distance(m_caption_bg.Y());
   m_icon.X_Distance(m_icon.X());
   m_icon.Y_Distance(m_icon.Y());
   m_label.X_Distance(m_label.X());
   m_label.Y_Distance(m_label.Y());
   m_button_close.X_Distance(m_button_close.X());
   m_button_close.Y_Distance(m_button_close.Y());
   m_button_unroll.X_Distance(m_button_unroll.X());
   m_button_unroll.Y_Distance(m_button_unroll.Y());
   m_button_rollup.X_Distance(m_button_rollup.X());
   m_button_rollup.Y_Distance(m_button_rollup.Y());
   m_button_tooltip.X_Distance(m_button_tooltip.X());
   m_button_tooltip.Y_Distance(m_button_tooltip.Y());
  }
//+------------------------------------------------------------------+
//| Deletion                                                         |
//+------------------------------------------------------------------+
void CWindow::Delete(void)
  {
//--- Zeroing variables
   m_right_limit=0;
//--- Removing objects
   m_bg.Delete();
   m_caption_bg.Delete();
   m_icon.Delete();
   m_label.Delete();
   m_button_close.Delete();
   m_button_rollup.Delete();
   m_button_unroll.Delete();
   m_button_tooltip.Delete();
//--- Emptying the array of the objects
   CElement::FreeObjectsArray();
//--- Zeroing the element focus
   CElement::MouseFocus(false);
  }
//+------------------------------------------------------------------+
//| Shows the window                                                 |
//+------------------------------------------------------------------+
void CWindow::Show(void)
  {
//--- Make all objects visible
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_ALL_PERIODS);
//--- State of visibility
   CElement::IsVisible(true);
//--- Zeroing the focus
   CElement::MouseFocus(false);
   m_button_close.MouseFocus(false);
   m_button_close.State(false);
//--- Get the chart window size
   SetWindowProperties();
//--- Send a message about it
   ::EventChartCustom(m_chart_id,ON_OPEN_DIALOG_BOX,(long)CElement::Id(),0,m_program_name);
  }
//+------------------------------------------------------------------+
//| Hides the window                                                 |
//+------------------------------------------------------------------+
void CWindow::Hide(void)
  {
//--- Hide all objects
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_NO_PERIODS);
//--- State of visibility
   CElement::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| Redrawing of all window objects                                  |
//+------------------------------------------------------------------+
void CWindow::Reset(void)
  {
//--- Hide all objects of the form
   Hide();
//--- Reflect in the sequence of their creation
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_ALL_PERIODS);
//--- Depending on the mode, display the required button
   if(m_is_minimized)
      m_button_rollup.Timeframes(OBJ_NO_PERIODS);
   else
      m_button_unroll.Timeframes(OBJ_NO_PERIODS);
//--- State of visibility
   CElement::IsVisible(true);
//--- Zero the focus
   CElement::MouseFocus(false);
  }
//+------------------------------------------------------------------+
//| Seth the priorities                                              |
//+------------------------------------------------------------------+
void CWindow::SetZorders(void)
  {
   m_bg.Z_Order(m_bg_zorder);
   m_caption_bg.Z_Order(m_bg_zorder);
   m_icon.Z_Order(m_button_zorder);
   m_label.Z_Order(m_button_zorder);
   m_button_tooltip.Z_Order(m_button_zorder);
   m_button_unroll.Z_Order(m_button_zorder);
   m_button_rollup.Z_Order(m_button_zorder);
   m_button_close.Z_Order(m_button_zorder);
  }
//+------------------------------------------------------------------+
//| Reset the priorities                                             |
//+------------------------------------------------------------------+
void CWindow::ResetZorders(void)
  {
   m_bg.Z_Order(0);
   m_caption_bg.Z_Order(0);
   m_icon.Z_Order(0);
   m_label.Z_Order(0);
   m_button_tooltip.Z_Order(-1);
   m_button_unroll.Z_Order(-1);
   m_button_rollup.Z_Order(-1);
   m_button_close.Z_Order(-1);
  }
//+------------------------------------------------------------------+
//| Reset window color                                               |
//+------------------------------------------------------------------+
void CWindow::ResetColors(void)
  {
   if(!m_is_locked)
     {
      m_is_locked=true;
      m_caption_bg.BackColor(m_caption_bg_color);
     }
  }
//+------------------------------------------------------------------+
//| Closing the dialog window or the program                         |
//+------------------------------------------------------------------+
bool CWindow::CloseWindow(const string pressed_object)
  {
//--- If the press was not on the close window button
   if(pressed_object!=m_button_close.Name())
      return(false);
//--- If this is the main window
   if(m_window_type==W_MAIN)
     {
      //--- If the program is of the EA type
      if(CElement::ProgramType()==PROGRAM_EXPERT)
        {
         string text="Do you want the program to be removed from the chart?";
         //--- Open a dialog window
         int mb_res=::MessageBox(text,NULL,MB_YESNO|MB_ICONQUESTION);
         //--- If the button "Yes" is pressed, remove the program from the chart
         if(mb_res==IDYES)
           {
            ::Print(__FUNCTION__," > The program was removed from the chart due to your decision!");
            //--- Removing the EA from the chart
            ::ExpertRemove();
            return(true);
           }
        }
      //--- If the program is of the indicator type
      else if(CElement::ProgramType()==PROGRAM_INDICATOR)
        {
         //--- Removing the indicator from the chart
         if(::ChartIndicatorDelete(m_chart_id,m_subwin,CElement::ProgramName()))
           {
            ::Print(__FUNCTION__," > The program was removed from the chart due to your decision!");
            return(true);
           }
        }
     }
//--- If this is a dialog window
   else if(m_window_type==W_DIALOG)
     {
      //--- Close it
      CloseDialogBox();
     }
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| Closing a dialog window                                          |
//+------------------------------------------------------------------+
void CWindow::CloseDialogBox(void)
  {
//--- State of visibility
   CElement::IsVisible(false);
//--- Send a message about it
   ::EventChartCustom(m_chart_id,ON_CLOSE_DIALOG_BOX,CElement::Id(),m_prev_active_window_index,m_caption_text);
  }
//+------------------------------------------------------------------+
//| Check for the window minimization/maximization event             |
//+------------------------------------------------------------------+
bool CWindow::ChangeWindowState(const string pressed_object)
  {
//--- If the window minimization button was pressed
   if(pressed_object==m_button_rollup.Name())
     {
      RollUp();
      return(true);
     }
//--- If the window maximization button was pressed
   if(pressed_object==m_button_unroll.Name())
     {
      Unroll();
      return(true);
     }
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| Minimizes the window                                             |
//+------------------------------------------------------------------+
void CWindow::RollUp(void)
  {
//--- Change the button
   m_button_rollup.Timeframes(OBJ_NO_PERIODS);
   m_button_unroll.Timeframes(OBJ_ALL_PERIODS);
//--- Set and store the size
   m_bg.Y_Size(m_caption_height);
   CElement::YSize(m_caption_height);
//--- Disable the button
   m_button_unroll.MouseFocus(false);
   m_button_unroll.State(false);
//--- Minimized state of the form
   m_is_minimized=true;
//--- If this is an indicator with a set height and with the sub-window minimization mode,
//    set the size of the indicator sub-window
   if(m_height_subwindow_mode)
      if(m_rollup_subwindow_mode)
         ChangeSubwindowHeight(m_caption_height+3);
//--- Send a message about it
   ::EventChartCustom(m_chart_id,ON_WINDOW_ROLLUP,CElement::Id(),m_subwin,"");
  }
//+------------------------------------------------------------------+
//| Maximizes the window                                             |
//+------------------------------------------------------------------+
void CWindow::Unroll(void)
  {
//--- Change the button
   m_button_unroll.Timeframes(OBJ_NO_PERIODS);
   m_button_rollup.Timeframes(OBJ_ALL_PERIODS);
//--- Set and store the size
   m_bg.Y_Size(m_bg_full_height);
   CElement::YSize(m_bg_full_height);
//--- Disable the button
   m_button_rollup.MouseFocus(false);
   m_button_rollup.State(false);
//--- Maximized state of the form
   m_is_minimized=false;
//--- If this is an indicator with a set height and with the sub-window minimization mode,
//    set the size of the indicator sub-window
   if(m_height_subwindow_mode)
      if(m_rollup_subwindow_mode)
         ChangeSubwindowHeight(m_subwindow_height);
//--- Send a message about it
   ::EventChartCustom(m_chart_id,ON_WINDOW_UNROLL,CElement::Id(),m_subwin,"");
  }
//+------------------------------------------------------------------+
