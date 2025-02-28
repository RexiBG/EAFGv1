//+------------------------------------------------------------------+
//|                                                 RadioButtons.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
//+------------------------------------------------------------------+
//| Class for creating groups of radio buttons                       |
//+------------------------------------------------------------------+
class CRadioButtons : public CElement
  {
private:
   //--- Pointer to the form to which the element is attached
   CWindow          *m_wnd;
   //--- Object for creating a button
   CRectLabel        m_area[];
   CBmpLabel         m_icon[];
   CLabel            m_label[];
   //--- Gradients of text labels
   struct LabelsGradients
     {
      color             m_labels_color_array[];
     };
   LabelsGradients   m_labels_total[];
   //--- Button properties:
   //    (1) Color and (2) priority of the background of the left mouse click
   color             m_area_color;
   int               m_area_zorder;
   //--- Arrays for unique properties of buttons
   bool              m_buttons_state[];
   int               m_buttons_x_gap[];
   int               m_buttons_y_gap[];
   int               m_buttons_width[];
   string            m_buttons_text[];
   //--- Height of buttons
   int               m_button_y_size;
   //--- Icons for buttons in the active, disabled and blocked state
   string            m_icon_file_on;
   string            m_icon_file_off;
   string            m_icon_file_on_locked;
   string            m_icon_file_off_locked;
   //--- Text margins
   int               m_label_x_gap;
   int               m_label_y_gap;
   //--- Text color
   color             m_text_color;
   color             m_text_color_off;
   color             m_text_color_hover;
   color             m_text_color_locked;
   //--- (1) Text and (2) index of the highlighted button
   string            m_selected_button_text;
   int               m_selected_button_index;
   //--- Priority of left mouse click
   int               m_buttons_zorder;
   //--- Available/blocked
   bool              m_radio_buttons_state;
   //---
public:
                     CRadioButtons(void);
                    ~CRadioButtons(void);
   //--- Methods for creating a button
   bool              CreateRadioButtons(const long chart_id,const int window,const int x,const int y);
   //---
private:
   bool              CreateArea(const int index);
   bool              CreateRadio(const int index);
   bool              CreateLabel(const int index);
   //---
public:
   //--- (1) Stores the form pointer, (2) number of buttons,
   //    (3) general state of the button (available/blocked)
   void              WindowPointer(CWindow &object)               { m_wnd=::GetPointer(object);       }
   int               RadioButtonsTotal(void)                const { return(::ArraySize(m_icon));      }
   bool              RadioButtonsState(void)                const { return(m_radio_buttons_state);    }
   void              RadioButtonsState(const bool state);
   //--- Setting up icons for the button in the active, disabled and blocked state
   void              IconFileOn(const string file_path)           { m_icon_file_on=file_path;         }
   void              IconFileOff(const string file_path)          { m_icon_file_off=file_path;        }
   void              IconFileOnLocked(const string file_path)     { m_icon_file_on_locked=file_path;  }
   void              IconFileOffLocked(const string file_path)    { m_icon_file_off_locked=file_path; }
   //--- Text margins
   void              LabelXGap(const int x_gap)                   { m_label_x_gap=x_gap;              }
   void              LabelYGap(const int y_gap)                   { m_label_y_gap=y_gap;              }
   //--- (1) Background color, (2) text color
   void              AreaColor(const color clr)                   { m_area_color=clr;                 }
   void              TextColor(const color clr)                   { m_text_color=clr;                 }
   void              TextColorOff(const color clr)                { m_text_color_off=clr;             }
   void              TextColorHover(const color clr)              { m_text_color_hover=clr;           }
   //--- Returns (1) the text and (2) index of the highlighted button
   string            SelectedButtonText(void)               const { return(m_selected_button_text);   }
   int               SelectedButtonIndex(void)              const { return(m_selected_button_index);  }
   //--- Toggles the state of a radio button by the specified index
   void              SelectionRadioButton(const int index);

   //--- Adds a button with specified properties before creation
   void              AddButton(const int x_gap,const int y_gap,const string text,const int width);
   //--- Changing the color
   void              ChangeObjectsColor(void);
   //---
public:
   //--- Chart event handler
   virtual void      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
   //--- Timer
   virtual void      OnEventTimer(void);
   //--- Moving the element
   virtual void      Moving(const int x,const int y);
   //--- (1) Show, (2) hide, (3) reset, (4) delete
   virtual void      Show(void);
   virtual void      Hide(void);
   virtual void      Reset(void);
   virtual void      Delete(void);
   //--- (1) Set, (2) reset priorities of the left mouse button press
   virtual void      SetZorders(void);
   virtual void      ResetZorders(void);
   //---
private:
   //--- Handling of pressing the button
   bool              OnClickButton(const string pressed_object);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CRadioButtons::CRadioButtons(void) : m_radio_buttons_state(true),
                                     m_button_y_size(18),
                                     m_area_color(clrNONE),
                                     m_icon_file_on(""),
                                     m_icon_file_off(""),
                                     m_icon_file_on_locked(""),
                                     m_icon_file_off_locked(""),
                                     m_selected_button_text(""),
                                     m_selected_button_index(0),
                                     m_label_x_gap(20),
                                     m_label_y_gap(3),
                                     m_text_color(clrBlack),
                                     m_text_color_off(clrGray),
                                     m_text_color_hover(C'85,170,255'),
                                     m_text_color_locked(clrSilver)
  {
//--- Store the name of the element class in the base class
   CElement::ClassName(CLASS_NAME);
//--- Set priorities of the left mouse button click
   m_area_zorder    =1;
   m_buttons_zorder =0;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CRadioButtons::~CRadioButtons(void)
  {
  }
//+------------------------------------------------------------------+
//| Chart event handler                                              |
//+------------------------------------------------------------------+
void CRadioButtons::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- Handling of the cursor movement event
   if(id==CHARTEVENT_MOUSE_MOVE)
     {
      //--- Leave, if the element is hidden
      if(!CElement::IsVisible())
         return;
      //--- Leave, if numbers of subwindows do not match
      if(CElement::m_subwin!=CElement::m_mouse.SubWindowNumber())
         return;
      //--- Leave, if the buttons are blocked
      if(!m_radio_buttons_state)
         return;
      //--- Define the focus
      int radio_buttons_total=RadioButtonsTotal();
      for(int i=0; i<radio_buttons_total; i++)
         m_area[i].MouseFocus(m_mouse.X()>m_area[i].X() && m_mouse.X()<m_area[i].X2() && m_mouse.Y()>m_area[i].Y() && m_mouse.Y()<m_area[i].Y2());
      //---
      return;
     }
//--- Handling the left mouse button click on the object
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      //--- Toggle the button state
      if(OnClickButton(sparam))
         return;
     }
  }
//+------------------------------------------------------------------+
//| Timer                                                            |
//+------------------------------------------------------------------+
void CRadioButtons::OnEventTimer(void)
  {
//--- Change the color, if the form is not blocked
   if(!m_wnd.IsLocked())
      ChangeObjectsColor();
  }
//+------------------------------------------------------------------+
//| Creates a group of the button objects                            |
//+------------------------------------------------------------------+
bool CRadioButtons::CreateRadioButtons(const long chart_id,const int subwin,const int x,const int y)
  {
//--- Leave, if there is no form pointer
   if(!CElement::CheckWindowPointer(::CheckPointer(m_wnd)))
      return(false);
//--- Initializing variables
   m_id         =m_wnd.LastId()+1;
   m_chart_id   =chart_id;
   m_subwin     =subwin;
   m_x          =x;
   m_y          =y;
   m_area_color =(m_area_color!=clrNONE)? m_area_color : m_wnd.WindowBgColor();
//--- Get the number of buttons in the group
   int radio_buttons_total=RadioButtonsTotal();
//--- If there is no button in a group, report
   if(radio_buttons_total<1)
     {
      ::Print(__FUNCTION__," > This method is to be called, "
              "if a group contains at least one button! Use the CRadioButtons::AddButton() method");
      return(false);
     }
//--- Set up a group of buttons
   for(int i=0; i<radio_buttons_total; i++)
     {
      CreateArea(i);
      CreateRadio(i);
      CreateLabel(i);
      //--- Zeroing the focus
      m_area[i].MouseFocus(false);
     }
//--- Hide the element if the window is a dialog one or is minimized
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Create radio button area                                         |
//+------------------------------------------------------------------+
bool CRadioButtons::CreateArea(const int index)
  {
//--- Forming the object name
   string name=CElement::ProgramName()+"_radio_area_"+(string)index+"__"+(string)CElement::Id();
//--- Calculating coordinates
   int x=m_x+m_buttons_x_gap[index];
   int y=m_y+m_buttons_y_gap[index];
//--- Set the background
   if(!m_area[index].Create(m_chart_id,name,m_subwin,x,y,m_buttons_width[index],m_button_y_size))
      return(false);
//--- Setting the properties
   m_area[index].BackColor(m_area_color);
   m_area[index].Color(m_area_color);
   m_area[index].BorderType(BORDER_FLAT);
   m_area[index].Corner(m_corner);
   m_area[index].Selectable(false);
   m_area[index].Z_Order(m_area_zorder);
   m_area[index].Tooltip("\n");
//--- Coordinates
   m_area[index].X(x);
   m_area[index].Y(y);
//--- Size
   m_area[index].XSize(m_buttons_width[index]);
   m_area[index].YSize(m_button_y_size);
//--- Margins from the edge
   m_area[index].XGap(x-m_wnd.X());
   m_area[index].YGap(y-m_wnd.Y());
//--- Store the object pointer
   CElement::AddToArray(m_area[index]);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates icon                                                     |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\radio_button_on.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\radio_button_off.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\radio_button_on_locked.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\radio_button_off_locked.bmp"
//---
bool CRadioButtons::CreateRadio(const int index)
  {
//--- Forming the object name
   string name=CElement::ProgramName()+"_radio_bmp_"+(string)index+"__"+(string)CElement::Id();
//--- Calculating coordinates
   int x=m_x+m_buttons_x_gap[index];
   int y=m_y+m_buttons_y_gap[index]+3;
//--- If the icon for the radio button is not specified, then set the default one
   if(m_icon_file_on=="")
      m_icon_file_on="Images\\EasyAndFastGUI\\Controls\\radio_button_on.bmp";
   if(m_icon_file_off=="")
      m_icon_file_off="Images\\EasyAndFastGUI\\Controls\\radio_button_off.bmp";
   if(m_icon_file_on_locked=="")
      m_icon_file_on_locked="Images\\EasyAndFastGUI\\Controls\\radio_button_on_locked.bmp";
   if(m_icon_file_off_locked=="")
      m_icon_file_off_locked="Images\\EasyAndFastGUI\\Controls\\radio_button_off_locked.bmp";
//--- Set the icon
   if(!m_icon[index].Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Setting the properties
   m_icon[index].BmpFileOn("::"+m_icon_file_on);
   m_icon[index].BmpFileOff("::"+m_icon_file_off);
   m_icon[index].State((index==m_selected_button_index) ? true : false);
   m_icon[index].Corner(m_corner);
   m_icon[index].GetInteger(OBJPROP_ANCHOR,m_anchor);
   m_icon[index].Selectable(false);
   m_icon[index].Z_Order(m_buttons_zorder);
   m_icon[index].Tooltip("\n");
//--- Margins from the edge
   m_icon[index].XGap(x-m_wnd.X());
   m_icon[index].YGap(y-m_wnd.Y());
//--- Store the object pointer
   CElement::AddToArray(m_icon[index]);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates the text label                                           |
//+------------------------------------------------------------------+
bool CRadioButtons::CreateLabel(const int index)
  {
//--- Forming the object name
   string name=CElement::ProgramName()+"_radio_lable_"+(string)index+"__"+(string)CElement::Id();
//--- Calculating coordinates
   int x =CElement::X()+m_buttons_x_gap[index]+m_label_x_gap;
   int y =CElement::Y()+m_buttons_y_gap[index]+m_label_y_gap;
//--- Set the text label
   if(!m_label[index].Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//---
   color label_color=(index==m_selected_button_index) ? m_text_color : m_text_color_off;
//--- Setting the properties
   m_label[index].Description(m_buttons_text[index]);
   m_label[index].Font(FONT);
   m_label[index].FontSize(FONT_SIZE);
   m_label[index].Color(label_color);
   m_label[index].Corner(m_corner);
   m_label[index].Anchor(m_anchor);
   m_label[index].Selectable(false);
   m_label[index].Z_Order(m_buttons_zorder);
   m_label[index].Tooltip("\n");
//--- Margins from the edge
   m_label[index].XGap(x-m_wnd.X());
   m_label[index].YGap(y-m_wnd.Y());
//--- Initializing gradient array
   CElement::InitColorArray(label_color,m_text_color_hover,m_labels_total[index].m_labels_color_array);
//--- Store the object pointer
   CElement::AddToArray(m_label[index]);
   return(true);
  }
//+------------------------------------------------------------------+
//| Adds a button                                                    |
//+------------------------------------------------------------------+
void CRadioButtons::AddButton(const int x_gap,const int y_gap,const string text,const int width)
  {
//--- Increase the array size by one element
   int array_size=::ArraySize(m_buttons_text);
   int new_size=array_size+1;
   ::ArrayResize(m_area,new_size);
   ::ArrayResize(m_icon,new_size);
   ::ArrayResize(m_label,new_size);
   ::ArrayResize(m_labels_total,new_size);
   ::ArrayResize(m_buttons_x_gap,new_size);
   ::ArrayResize(m_buttons_y_gap,new_size);
   ::ArrayResize(m_buttons_state,new_size);
   ::ArrayResize(m_buttons_text,new_size);
   ::ArrayResize(m_buttons_width,new_size);
//--- Store the value of passed parameters
   m_buttons_x_gap[array_size] =x_gap;
   m_buttons_y_gap[array_size] =y_gap;
   m_buttons_text[array_size]  =text;
   m_buttons_width[array_size] =width;
   m_buttons_state[array_size] =false;
  }
//+------------------------------------------------------------------+
//| Changing the object color when the cursor is hovering over it    |
//+------------------------------------------------------------------+
void CRadioButtons::ChangeObjectsColor(void)
  {
//--- Leave, if the element is blocked
   if(!m_radio_buttons_state)
      return;
//---
   int radio_buttons_total=RadioButtonsTotal();
   for(int i=0; i<radio_buttons_total; i++)
     {
      color label_color=(m_buttons_state[i]) ? m_text_color : m_text_color_off;
      ChangeObjectColor(m_label[i].Name(),m_area[i].MouseFocus(),
                        OBJPROP_COLOR,label_color,m_text_color_hover,m_labels_total[i].m_labels_color_array);
     }
  }
//+------------------------------------------------------------------+
//| Moving elements                                                  |
//+------------------------------------------------------------------+
void CRadioButtons::Moving(const int x,const int y)
  {
//--- Leave, if the element is hidden
   if(!CElement::IsVisible())
     return;
//--- Storing coordinates in the element fields
   CElement::X(x+XGap());
   CElement::Y(y+YGap());
//--- Storing coordinates in the fields of the objects
   int radio_buttons_total=RadioButtonsTotal();
   for(int i=0; i<radio_buttons_total; i++)
     {
      m_area[i].X(x+m_area[i].XGap());
      m_area[i].Y(y+m_area[i].YGap());
      m_icon[i].X(x+m_icon[i].XGap());
      m_icon[i].Y(y+m_icon[i].YGap());
      m_label[i].X(x+m_label[i].XGap());
      m_label[i].Y(y+m_label[i].YGap());
     }
//--- Updating coordinates of graphical objects
   for(int i=0; i<radio_buttons_total; i++)
     {
      m_area[i].X_Distance(m_area[i].X());
      m_area[i].Y_Distance(m_area[i].Y());
      m_icon[i].X_Distance(m_icon[i].X());
      m_icon[i].Y_Distance(m_icon[i].Y());
      m_label[i].X_Distance(m_label[i].X());
      m_label[i].Y_Distance(m_label[i].Y());
     }
  }
//+------------------------------------------------------------------+
//| Shows the button                                                 |
//+------------------------------------------------------------------+
void CRadioButtons::Show(void)
  {
//--- Leave, if the element is already visible
   if(CElement::IsVisible())
      return;
//--- Make all objects visible
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_ALL_PERIODS);
//--- State of visibility
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Hides the button                                                 |
//+------------------------------------------------------------------+
void CRadioButtons::Hide(void)
  {
//--- Leave, if the element is hidden
   if(!CElement::IsVisible())
      return;
//--- Hide all objects
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_NO_PERIODS);
//--- State of visibility
   CElement::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| Redrawing                                                        |
//+------------------------------------------------------------------+
void CRadioButtons::Reset(void)
  {
//--- Leave, if this is a drop-down control 
   if(CElement::IsDropdown())
      return;
//--- Hide and show
   Hide();
   Show();
  }
//+------------------------------------------------------------------+
//| Deletion                                                         |
//+------------------------------------------------------------------+
void CRadioButtons::Delete(void)
  {
//--- Removing objects
   int radio_buttons_total=RadioButtonsTotal();
   for(int i=0; i<radio_buttons_total; i++)
     {
      m_area[i].Delete();
      m_icon[i].Delete();
      m_label[i].Delete();
     }
//--- Emptying the control arrays
   ::ArrayFree(m_labels_total);
   ::ArrayFree(m_buttons_x_gap);
   ::ArrayFree(m_buttons_y_gap);
   ::ArrayFree(m_buttons_width);
   ::ArrayFree(m_buttons_state);
   ::ArrayFree(m_buttons_text);
//--- Emptying the array of the objects
   CElement::FreeObjectsArray();
//--- Initializing of variables by default values
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Seth the priorities                                              |
//+------------------------------------------------------------------+
void CRadioButtons::SetZorders(void)
  {
   int radio_buttons_total=RadioButtonsTotal();
   for(int i=0; i<radio_buttons_total; i++)
     {
      m_area[i].Z_Order(m_area_zorder);
      m_icon[i].Z_Order(m_buttons_zorder);
      m_label[i].Z_Order(m_buttons_zorder);
     }
  }
//+------------------------------------------------------------------+
//| Reset the priorities                                             |
//+------------------------------------------------------------------+
void CRadioButtons::ResetZorders(void)
  {
   int radio_buttons_total=RadioButtonsTotal();
   for(int i=0; i<radio_buttons_total; i++)
     {
      m_area[i].Z_Order(-1);
      m_icon[i].Z_Order(-1);
      m_label[i].Z_Order(-1);
     }
  }
//+------------------------------------------------------------------+
//| Changing the state of buttons                                    |
//+------------------------------------------------------------------+
void CRadioButtons::RadioButtonsState(const bool state)
  {
   m_radio_buttons_state=state;
//---
   int radio_buttons_total=RadioButtonsTotal();
   for(int i=0; i<radio_buttons_total; i++)
     {
      m_icon[i].BmpFileOn((state)? "::"+m_icon_file_on : "::"+m_icon_file_on_locked);
      m_icon[i].BmpFileOff((state)? "::"+m_icon_file_off : "::"+m_icon_file_off_locked);
      m_label[i].Color((state && i==m_selected_button_index)? m_text_color : m_text_color_locked);
     }
//---
   if(state)
      SelectionRadioButton(m_selected_button_index);
  }
//+------------------------------------------------------------------+
//| Indicates the radio button to be selected                        |
//+------------------------------------------------------------------+
void CRadioButtons::SelectionRadioButton(const int index)
  {
//--- Get the number of buttons
   int radio_buttons_total=RadioButtonsTotal();
//--- If there is no radio button in the group, report
   if(radio_buttons_total<1)
     {
      ::Print(__FUNCTION__," > This method is to be called, "
              "if a group contains at least one radio button! Use the CRadioButtons::AddButton() method");
     }
//--- Adjust the index value if the array range is exceeded
   int correct_index=(index>=radio_buttons_total)? radio_buttons_total-1 :(index<0)? 0 : index;
//--- Toggle the button state
   for(int i=0; i<radio_buttons_total; i++)
     {
      if(i==correct_index)
        {
         m_buttons_state[i]=true;
         m_icon[i].State(true);
         m_label[i].Color(m_text_color_hover);
         CElement::InitColorArray(m_text_color,m_text_color_hover,m_labels_total[i].m_labels_color_array);
        }
      else
        {
         m_buttons_state[i]=false;
         m_icon[i].State(false);
         m_label[i].Color(m_text_color_off);
         CElement::InitColorArray(m_text_color_off,m_text_color_hover,m_labels_total[i].m_labels_color_array);
        }
     }
//--- Store its text and index
   m_selected_button_index =correct_index;
   m_selected_button_text  =m_buttons_text[correct_index];
  }
//+------------------------------------------------------------------+
//| Pressing of a radio button                                       |
//+------------------------------------------------------------------+
bool CRadioButtons::OnClickButton(const string pressed_object)
  {
//--- Leave, if the pressing was not on the menu item
   if(::StringFind(pressed_object,CElement::ProgramName()+"_radio_area_",0)<0)
      return(false);
//--- Get the identifier and index from the object name
   int id=CElement::IdFromObjectName(pressed_object);
//--- Leave, if identifiers do not match
   if(id!=CElement::Id())
      return(false);
//--- For checking the index
   int check_index=WRONG_VALUE;
//--- Leave, if the buttons are blocked
   if(!m_radio_buttons_state)
      return(false);
//--- If the pressing took place, store the index
   int radio_buttons_total=RadioButtonsTotal();
   for(int i=0; i<radio_buttons_total; i++)
     {
      if(m_area[i].Name()==pressed_object)
        {
         check_index=i;
         break;
        }
     }
//--- Leave, if there was no pressing of a button in this group or
//    if it is an already selected radio button
   if(check_index==WRONG_VALUE || check_index==m_selected_button_index)
      return(false);
//--- Toggle the button state
   SelectionRadioButton(check_index);
//--- Send a signal about it
   ::EventChartCustom(m_chart_id,ON_CLICK_LABEL,CElement::Id(),check_index,m_selected_button_text);
   return(true);
  }
//+------------------------------------------------------------------+
