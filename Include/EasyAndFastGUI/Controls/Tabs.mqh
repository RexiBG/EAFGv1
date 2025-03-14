//+------------------------------------------------------------------+
//|                                                         Tabs.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
//+------------------------------------------------------------------+
//| Class for creating tabs                                          |
//+------------------------------------------------------------------+
class CTabs : public CElement
  {
private:
   //--- Pointer to the form to which the element is attached
   CWindow          *m_wnd;
   //--- Objects for creating the element
   CRectLabel        m_main_area;
   CRectLabel        m_tabs_area;
   CEdit             m_tabs[];
   CRectLabel        m_patch;
   //--- Structure of properties and arrays of the controls attached to each tab
   struct TElements
     {
      CElement         *elements[];
      string            text;
      int               width;
     };
   TElements         m_tab[];
   //--- The number of tabs
   int               m_tabs_total;
   //--- Positioning of tabs
   ENUM_TABS_POSITION m_position_mode;
   //--- Color of the common area background
   int               m_area_color;
   //--- Size of the tabs along the Y axis
   int               m_tab_y_size;
   //--- Colors of tabs in different states
   color             m_tab_color;
   color             m_tab_color_hover;
   color             m_tab_color_selected;
   color             m_tab_color_array[];
   //--- Color of tab texts in different states
   color             m_tab_text_color;
   color             m_tab_text_color_selected;
   //--- Color of tab borders
   color             m_tab_border_color;
   //--- Priorities of the left mouse button press
   int               m_zorder;
   int               m_tab_zorder;
   //--- Index of the selected tab
   int               m_selected_tab;
   //---
public:
                     CTabs(void);
                    ~CTabs(void);
   //--- Methods for creating the tabs
   bool              CreateTabs(const long chart_id,const int subwin,const int x,const int y);
   //---
private:
   bool              CreateMainArea(void);
   bool              CreateTabsArea(void);
   bool              CreateButtons(void);
   bool              CreatePatch(void);
   //---
public:
   //--- (1) Stores the form pointer, 
   //--- (2) Set/set the tab positions (top/bottom/left/right), (3) set the tab size along the Y axis
   void              WindowPointer(CWindow &object)                  { m_wnd=::GetPointer(object);         }
   void              PositionMode(const ENUM_TABS_POSITION mode)     { m_position_mode=mode;               }
   ENUM_TABS_POSITION PositionMode(void)                       const { return(m_position_mode);            }
   void              TabYSize(const int y_size)                      { m_tab_y_size=y_size;                }
   //--- Color (1) of the common background, (2) colors of tabs in different states, (3) color of tab borders
   void              AreaColor(const color clr)                      { m_area_color=clr;                   }
   void              TabBackColor(const color clr)                   { m_tab_color=clr;                    }
   void              TabBackColorHover(const color clr)              { m_tab_color_hover=clr;              }
   void              TabBackColorSelected(const color clr)           { m_tab_color_selected=clr;           }
   void              TabBorderColor(const color clr)                 { m_tab_border_color=clr;             }
   //--- Color of tab texts in different states
   void              TabTextColor(const color clr)                   { m_tab_text_color=clr;               }
   void              TabTextColorSelected(const color clr)           { m_tab_text_color_selected=clr;      }
   //--- (1) Store and (2) return index of the selected tab
   void              SelectedTab(const int index)                    { m_selected_tab=index;               }
   int               SelectedTab(void)                         const { return(m_selected_tab);             }
   //--- Select the specified tab
   void              SelectTab(const int index);

   //--- Adds a tab
   void              AddTab(const string tab_text="",const int tab_width=50);
   //--- Add control to the tab array
   void              AddToElementsArray(const int tab_index,CElement &object);
   //--- Show controls of the selected tab only
   void              ShowTabElements(void);
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
   //--- Reset the color
   virtual void      ResetColors(void) {}
   //---
private:
   //--- Handling the pressing on tab
   bool              OnClickTab(const string pressed_object);
   //--- Width of all tabs
   int               SumWidthTabs(void);
   //--- Check index of the selected tab
   void              CheckTabIndex();
   //--- Calculations for the patch
   void              CalculatingPatch(int &x,int &y,int &x_size,int &y_size);
   
   //--- Change the width at the right edge of the window
   virtual void      ChangeWidthByRightWindowSide(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CTabs::CTabs(void) : m_tab_y_size(20),
                     m_position_mode(TABS_TOP),
                     m_selected_tab(WRONG_VALUE),
                     m_area_color(clrWhite),
                     m_tab_color(C'225,225,225'),
                     m_tab_color_hover(C'240,240,240'),
                     m_tab_color_selected(clrWhite),
                     m_tab_text_color(clrGray),
                     m_tab_text_color_selected(clrBlack),
                     m_tab_border_color(clrSilver)
  {
//--- Store the name of the element class in the base class
   CElement::ClassName(CLASS_NAME);
//--- Set priorities of the left mouse button click
   m_zorder     =0;
   m_tab_zorder =1;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CTabs::~CTabs(void)
  {
  }
//+------------------------------------------------------------------+
//| Chart event handler                                              |
//+------------------------------------------------------------------+
void CTabs::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- Handling of the cursor movement event
   if(id==CHARTEVENT_MOUSE_MOVE)
     {
      //--- Leave, if the element is hidden
      if(!CElement::IsVisible())
         return;
      //--- Leave, if numbers of subwindows do not match
      if(CElement::m_subwin!=m_mouse.SubWindowNumber())
         return;
      //--- Verifying the focus
      for(int i=0; i<m_tabs_total; i++)
         m_tabs[i].MouseFocus(m_mouse.X()>m_tabs[i].X() && m_mouse.X()<m_tabs[i].X2() && m_mouse.Y()>m_tabs[i].Y() && m_mouse.Y()<m_tabs[i].Y2());
      //---
      return;
     }
//--- Handling the left mouse button click on the object
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      //--- Pressing a tab
      if(OnClickTab(sparam))
         return;
      //---
      return;
     }
  }
//+------------------------------------------------------------------+
//| Timer                                                            |
//+------------------------------------------------------------------+
void CTabs::OnEventTimer(void)
  {
//--- If this is a drop-down element
   if(CElement::IsDropdown())
      ChangeObjectsColor();
   else
     {
      //--- If the form is not blocked
      if(!m_wnd.IsLocked())
         ChangeObjectsColor();
     }
  }
//+------------------------------------------------------------------+
//| Create Tabs control                                              |
//+------------------------------------------------------------------+
bool CTabs::CreateTabs(const long chart_id,const int subwin,const int x,const int y)
  {
//--- Leave, if there is no form pointer
   if(!CElement::CheckWindowPointer(::CheckPointer(m_wnd)))
      return(false);
//--- If there is no tab in the group, report
   if(m_tabs_total<1)
     {
      ::Print(__FUNCTION__," > This method is to be called, "
              "if a group contains at least one tab! Use the CTabs::AddTab() method");
      return(false);
     }
//--- Initializing variables
   m_id       =m_wnd.LastId()+1;
   m_chart_id =chart_id;
   m_subwin   =subwin;
   m_x        =x;
   m_y        =y;
//--- Creating an element
   if(!CreateMainArea())
      return(false);
   if(!CreateTabsArea())
      return(false);
   if(!CreateButtons())
      return(false);
   if(!CreatePatch())
      return(false);
//--- Hide the element if the window is a dialog one or is minimized
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//--- 
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the common area background                                |
//+------------------------------------------------------------------+
bool CTabs::CreateMainArea(void)
  {
//--- Forming the object name
   string name=CElement::ProgramName()+"_tabs_main_area_"+(string)CElement::Id();
//--- Coordinates
   int x=0;
   int y=0;
//--- Size
   int x_size=0;
   int y_size=0;
//--- Calculating coordinates and sizes relative to positioning of tabs
   switch(m_position_mode)
     {
      case TABS_TOP :
         x      =CElement::X();
         y      =CElement::Y()+m_tab_y_size-1;
         x_size =(CElement::XSize()>0)? CElement::XSize() : m_wnd.X2()-x-m_auto_xresize_right_offset;
         y_size =CElement::YSize()-m_tab_y_size;
         break;
      case TABS_BOTTOM :
         x      =CElement::X();
         y      =CElement::Y();
         x_size =(CElement::XSize()>0)? CElement::XSize() : m_wnd.X2()-x-m_auto_xresize_right_offset;
         y_size =CElement::YSize()-m_tab_y_size;
         break;
      case TABS_RIGHT :
         x      =CElement::X();
         y      =CElement::Y();
         x_size =(CElement::XSize()>0)? CElement::XSize()-SumWidthTabs()+1 : m_wnd.X2()-x-SumWidthTabs()-1;
         y_size =CElement::YSize();
         break;
      case TABS_LEFT :
         x      =CElement::X()+SumWidthTabs()-1;
         y      =CElement::Y();
         x_size =(CElement::XSize()>0)? CElement::XSize()-SumWidthTabs()+1 : m_wnd.X2()-x-m_auto_xresize_right_offset;
         y_size =CElement::YSize();
         break;
     }
//--- Creating the object
   if(!m_main_area.Create(m_chart_id,name,m_subwin,x,y,x_size,y_size))
      return(false);
//--- Setting the properties
   m_main_area.BackColor(m_area_color);
   m_main_area.Color(m_tab_border_color);
   m_main_area.BorderType(BORDER_FLAT);
   m_main_area.Corner(m_corner);
   m_main_area.Selectable(false);
   m_main_area.Z_Order(m_zorder);
   m_main_area.Tooltip("\n");
//--- Margins from the edge
   m_main_area.XGap(x-m_wnd.X());
   m_main_area.YGap(y-m_wnd.Y());
//--- Store the size
   m_main_area.XSize(x_size);
   m_main_area.YSize(y_size);
//--- Store coordinates
   m_main_area.X(x);
   m_main_area.Y(y);
//--- Store the object pointer
   CElement::AddToArray(m_main_area);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the tab background                                        |
//+------------------------------------------------------------------+
bool CTabs::CreateTabsArea(void)
  {
//--- Forming the object name
   string name=CElement::ProgramName()+"_tabs_area_"+(string)CElement::Id();
//--- Coordinates
   int x=CElement::X();
   int y=CElement::Y();
//--- Size
   int x_size=SumWidthTabs();
   int y_size=0;
//--- Calculating sizes relative to positioning of tabs
   if(m_position_mode==TABS_TOP || m_position_mode==TABS_BOTTOM)
     {
      y_size=m_tab_y_size;
     }
   else
     {
      y_size=m_tab_y_size*m_tabs_total-(m_tabs_total-1);
     }
//--- Adjust the coordinates for positioning the tabs at the bottom and on the right
   if(m_position_mode==TABS_BOTTOM)
     {
      y=CElement::Y2()-m_tab_y_size-1;
     }
   else if(m_position_mode==TABS_RIGHT)
     {
      x=(CElement::XSize()>0)? CElement::X2()-x_size : m_main_area.X2()-1;
     }
//--- Creating the object
   if(!m_tabs_area.Create(m_chart_id,name,m_subwin,x,y,x_size,y_size))
      return(false);
//--- Setting the properties
   m_tabs_area.BackColor(m_tab_border_color);
   m_tabs_area.Color(m_tab_border_color);
   m_tabs_area.BorderType(BORDER_FLAT);
   m_tabs_area.Corner(m_corner);
   m_tabs_area.Selectable(false);
   m_tabs_area.Z_Order(m_zorder);
   m_tabs_area.Tooltip("\n");
//--- Margins from the edge
   m_tabs_area.XGap(x-m_wnd.X());
   m_tabs_area.YGap(y-m_wnd.Y());
//--- Store the size
   m_tabs_area.XSize(x_size);
   m_tabs_area.YSize(y_size);
//--- Store coordinates
   m_tabs_area.X(x);
   m_tabs_area.Y(y);
//--- Store the object pointer
   CElement::AddToArray(m_tabs_area);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create tabs                                                      |
//+------------------------------------------------------------------+
bool CTabs::CreateButtons(void)
  {
//--- Coordinates
   int x =CElement::X();
   int y =CElement::Y();
//--- Calculating coordinates relative to positioning of tabs
   if(m_position_mode==TABS_BOTTOM)
      y=CElement::Y2()-m_tab_y_size-1;
   else if(m_position_mode==TABS_RIGHT)
      x=m_tabs_area.X();
//--- Check index of the selected tab
   CheckTabIndex();
//--- Create tabs
   for(int i=0; i<m_tabs_total; i++)
     {
      //--- Forming the object name
      string name=CElement::ProgramName()+"_tabs_edit_"+(string)i+"__"+(string)CElement::Id();
      //--- Calculating coordinates relative to positioning of tabs for each individual tab
      if(m_position_mode==TABS_TOP || m_position_mode==TABS_BOTTOM)
         x=(i>0) ? x+m_tab[i-1].width-1 : CElement::X();
      else
         y=(i>0) ? y+m_tab_y_size-1 : CElement::Y();
      //--- Creating the object
      if(!m_tabs[i].Create(m_chart_id,name,m_subwin,x,y,m_tab[i].width,m_tab_y_size))
         return(false);
      //--- Setting the properties
      m_tabs[i].Font(FONT);
      m_tabs[i].FontSize(FONT_SIZE);
      m_tabs[i].Description(m_tab[i].text);
      m_tabs[i].BorderColor(m_tab_border_color);
      m_tabs[i].BackColor((SelectedTab()==i) ? m_tab_color_selected : m_tab_color);
      m_tabs[i].Color((SelectedTab()==i) ? m_tab_text_color_selected : m_tab_text_color);
      m_tabs[i].Corner(m_corner);
      m_tabs[i].Anchor(m_anchor);
      m_tabs[i].Selectable(false);
      m_tabs[i].TextAlign(ALIGN_CENTER);
      m_tabs[i].Z_Order(m_tab_zorder);
      m_tabs[i].ReadOnly(true);
      m_tabs[i].Tooltip("\n");
      //--- Margins from the edge of the panel
      m_tabs[i].XGap(x-m_wnd.X());
      m_tabs[i].YGap(y-m_wnd.Y());
      //--- Coordinates
      m_tabs[i].X(x);
      m_tabs[i].Y(y);
      //--- Size
      m_tabs[i].XSize(m_tab[i].width);
      m_tabs[i].YSize(m_tab_y_size);
      //--- Initializing gradient array
      CElement::InitColorArray(m_tab_color,m_tab_color_hover,m_tab_color_array);
      //--- Store the object pointer
      CElement::AddToArray(m_tabs[i]);
     }
//--- Store the total width of the control
   if(m_position_mode==TABS_TOP || m_position_mode==TABS_BOTTOM)
      CElement::XSize(m_main_area.XSize()-m_auto_xresize_right_offset);
   else
      CElement::XSize(m_main_area.XSize()-m_auto_xresize_right_offset+SumWidthTabs()-1);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Create a patch for the active tab                                |
//+------------------------------------------------------------------+
bool CTabs::CreatePatch(void)
  {
//--- Forming the object name
   string name=CElement::ProgramName()+"_tabs_patch_"+(string)CElement::Id();
//--- Coordinates
   int x=0;
   int y=0;
//--- Size
   int x_size=0;
   int y_size=0;
//--- Calculation relative to positioning of tabs
   CalculatingPatch(x,y,x_size,y_size);
//--- Creating the object
   if(!m_patch.Create(m_chart_id,name,m_subwin,x,y,x_size,y_size))
      return(false);
//--- Setting the properties
   m_patch.BackColor(m_tab_color_selected);
   m_patch.Color(m_tab_color_selected);
   m_patch.BorderType(BORDER_FLAT);
   m_patch.Corner(m_corner);
   m_patch.Selectable(false);
   m_patch.Z_Order(m_zorder);
   m_patch.Tooltip("\n");
//--- Margins from the edge
   m_patch.XGap(x-m_wnd.X());
   m_patch.YGap(y-m_wnd.Y());
//--- Store the size
   m_patch.XSize(x_size);
   m_patch.YSize(y_size);
//--- Store coordinates
   m_patch.X(x);
   m_patch.Y(y);
//--- Store the object pointer
   CElement::AddToArray(m_patch);
   return(true);
  }
//+------------------------------------------------------------------+
//| Select the tab                                                   |
//+------------------------------------------------------------------+
void CTabs::SelectTab(const int index)
  {
   for(int i=0; i<m_tabs_total; i++)
     {
      //--- If this tab is clicked
      if(index==i)
        {
         //--- Coordinates
         int x=0;
         int y=0;
         //--- Size
         int x_size=0;
         int y_size=0;
         //--- Store index of the selected tab
         SelectedTab(index);
         //--- Set colors
         m_tabs[i].Color(m_tab_text_color_selected);
         m_tabs[i].BackColor(m_tab_color_selected);
         //--- Calculation relative to positioning of tabs
         CalculatingPatch(x,y,x_size,y_size);
         //--- Update values
         m_patch.X_Size(x_size);
         m_patch.Y_Size(y_size);
         m_patch.XGap(x-m_wnd.X());
         m_patch.YGap(y-m_wnd.Y());
         //--- Update the position of objects
         Moving(m_wnd.X(),m_wnd.Y());
        }
      else
        {
         //--- Set the colors for the inactive tabs
         m_tabs[i].Color(m_tab_text_color);
         m_tabs[i].BackColor(m_tab_color);
        }
     }
//--- Show controls of the selected tab only
   ShowTabElements();
  }
//+------------------------------------------------------------------+
//| Add a tab                                                        |
//+------------------------------------------------------------------+
void CTabs::AddTab(const string tab_text,const int tab_width)
  {
//--- Set the size of tab arrays
   int array_size=::ArraySize(m_tabs);
   ::ArrayResize(m_tabs,array_size+1);
   ::ArrayResize(m_tab,array_size+1);
//--- Store the passed properties
   m_tab[array_size].text  =tab_text;
   m_tab[array_size].width =tab_width;
//--- Store the number of tabs
   m_tabs_total=array_size+1;
  }
//+------------------------------------------------------------------+
//| Add control to the array of the specified tab                    |
//+------------------------------------------------------------------+
void CTabs::AddToElementsArray(const int tab_index,CElement &object)
  {
//--- Checking for exceeding the array range
   int array_size=::ArraySize(m_tab);
   if(array_size<1 || tab_index<0 || tab_index>=array_size)
      return;
//--- Add pointer of the passed control to array of the specified tab
   int size=::ArraySize(m_tab[tab_index].elements);
   ::ArrayResize(m_tab[tab_index].elements,size+1);
   m_tab[tab_index].elements[size]=::GetPointer(object);
  }
//+------------------------------------------------------------------+
//| Show controls of the selected tab only                           |
//+------------------------------------------------------------------+
void CTabs::ShowTabElements(void)
  {
//--- Leave, if the tabs are hidden
   if(!CElement::IsVisible())
      return;
//--- Check index of the selected tab
   CheckTabIndex();
//---
   for(int i=0; i<m_tabs_total; i++)
     {
      //--- Get the number of controls attached to the tab
      int tab_elements_total=::ArraySize(m_tab[i].elements);
      //--- If this tab is selected
      if(i==m_selected_tab)
        {
         //--- Display the tab controls
         for(int j=0; j<tab_elements_total; j++)
            m_tab[i].elements[j].Show();
        }
      //--- Hide the controls of inactive tabs
      else
        {
         for(int j=0; j<tab_elements_total; j++)
            m_tab[i].elements[j].Hide();
        }
     }
  }
//+------------------------------------------------------------------+
//| Changing color of the list view item when the cursor is hovering |
//+------------------------------------------------------------------+
void CTabs::ChangeObjectsColor(void)
  {
   for(int i=0; i<m_tabs_total; i++)
      CElement::ChangeObjectColor(m_tabs[i].Name(),m_tabs[i].MouseFocus(),
                                  OBJPROP_BGCOLOR,m_tab_color,m_tab_color_hover,m_tab_color_array);
  }
//+------------------------------------------------------------------+
//| Moving elements                                                  |
//+------------------------------------------------------------------+
void CTabs::Moving(const int x,const int y)
  {
//--- Leave, if the element is hidden
   if(!CElement::IsVisible())
      return;
//--- Storing indents in the element fields
   CElement::X(x+CElement::XGap());
   CElement::Y(y+CElement::YGap());
//--- Storing coordinates in the fields of the objects
   m_main_area.X(x+m_main_area.XGap());
   m_main_area.Y(y+m_main_area.YGap());
   m_tabs_area.X(x+m_tabs_area.XGap());
   m_tabs_area.Y(y+m_tabs_area.YGap());
   m_patch.X(x+m_patch.XGap());
   m_patch.Y(y+m_patch.YGap());
//--- Updating coordinates of graphical objects
   m_main_area.X_Distance(m_main_area.X());
   m_main_area.Y_Distance(m_main_area.Y());
   m_tabs_area.X_Distance(m_tabs_area.X());
   m_tabs_area.Y_Distance(m_tabs_area.Y());
   m_patch.X_Distance(m_patch.X());
   m_patch.Y_Distance(m_patch.Y());
//---
   for(int i=0; i<m_tabs_total; i++)
     {
      //--- Storing coordinates in the fields of the objects
      m_tabs[i].X(x+m_tabs[i].XGap());
      m_tabs[i].Y(y+m_tabs[i].YGap());
      //--- Updating coordinates of graphical objects
      m_tabs[i].X_Distance(m_tabs[i].X());
      m_tabs[i].Y_Distance(m_tabs[i].Y());
     }
  }
//+------------------------------------------------------------------+
//| Shows a menu item                                                |
//+------------------------------------------------------------------+
void CTabs::Show(void)
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
//| Hides a menu item                                                |
//+------------------------------------------------------------------+
void CTabs::Hide(void)
  {
//--- Leave, if the element is already visible
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
void CTabs::Reset(void)
  {
//--- Leave, if this is a drop-down element
   if(CElement::IsDropdown())
      return;
//--- Hide and show
   Hide();
   Show();
  }
//+------------------------------------------------------------------+
//| Deletion                                                         |
//+------------------------------------------------------------------+
void CTabs::Delete(void)
  {
//--- Delete graphical objects of the control
   m_main_area.Delete();
   m_tabs_area.Delete();
   m_patch.Delete();
   for(int i=0; i<m_tabs_total; i++)
      m_tabs[i].Delete();
//--- Emptying the control arrays
   for(int i=0; i<m_tabs_total; i++)
      ::ArrayFree(m_tab[i].elements);
//--- 
   ::ArrayFree(m_tab);
   ::ArrayFree(m_tabs);
//--- Emptying the array of the objects
   CElement::FreeObjectsArray();
//--- Initializing of variables by default values
   m_tabs_total=0;
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Seth the priorities                                              |
//+------------------------------------------------------------------+
void CTabs::SetZorders(void)
  {
   m_main_area.Z_Order(m_zorder);
   m_tabs_area.Z_Order(m_zorder);
   for(int i=0; i<m_tabs_total; i++)
      m_tabs[i].Z_Order(m_tab_zorder);
  }
//+------------------------------------------------------------------+
//| Reset the priorities                                             |
//+------------------------------------------------------------------+
void CTabs::ResetZorders(void)
  {
   m_main_area.Z_Order(0);
   m_tabs_area.Z_Order(0);
   for(int i=0; i<m_tabs_total; i++)
      m_tabs[i].Z_Order(0);
  }
//+------------------------------------------------------------------+
//| Pressing a tab in a group                                        |
//+------------------------------------------------------------------+
bool CTabs::OnClickTab(const string clicked_object)
  {
//--- Leave, if the pressing was not on the table cell
   if(::StringFind(clicked_object,CElement::ProgramName()+"_tabs_edit_",0)<0)
      return(false);
//--- Get the identifier from the object name
   int id=CElement::IdFromObjectName(clicked_object);
//--- Leave, if the identifier does not match
   if(id!=CElement::Id())
      return(false);
//---
   for(int i=0; i<m_tabs_total; i++)
     {
      //--- If this tab is clicked
      if(m_tabs[i].Name()==clicked_object)
        {
         //--- Store index of the selected tab
         SelectedTab(i);
         //--- Set colors
         m_tabs[i].Color(m_tab_text_color_selected);
         m_tabs[i].BackColor(m_tab_color_selected);
         //--- Coordinates
         int x=0;
         int y=0;
         //--- Size
         int x_size=0;
         int y_size=0;
         //--- Calculation relative to positioning of tabs
         CalculatingPatch(x,y,x_size,y_size);
         //--- Update values
         m_patch.X_Size(x_size);
         m_patch.Y_Size(y_size);
         m_patch.XGap(x-m_wnd.X());
         m_patch.YGap(y-m_wnd.Y());
        }
      else
        {
         //--- Set the colors for the inactive tabs
         m_tabs[i].Color(m_tab_text_color);
         m_tabs[i].BackColor(m_tab_color);
        }
     }
//--- Show controls of the selected tab only
   ShowTabElements();
   return(true);
  }
//+------------------------------------------------------------------+
//| Total width of all tabs                                          |
//+------------------------------------------------------------------+
int CTabs::SumWidthTabs(void)
  {
   int width=0;
//--- If tabs are positioned right or left, return the width of the first tab
   if(m_position_mode==TABS_LEFT || m_position_mode==TABS_RIGHT)
      return(m_tab[0].width);
//--- Sum the width of all tabs
   for(int i=0; i<m_tabs_total; i++)
      width=width+m_tab[i].width;
//--- With consideration of one pixel overlay
   width=width-(m_tabs_total-1);
   return(width);
  }
//+------------------------------------------------------------------+
//| Check index of the selected tab                                  |
//+------------------------------------------------------------------+
void CTabs::CheckTabIndex(void)
  {
//--- Checking for exceeding the array range
   int array_size=::ArraySize(m_tab);
   if(m_selected_tab<0)
      m_selected_tab=0;
   if(m_selected_tab>=array_size)
      m_selected_tab=array_size-1;
  }
//+------------------------------------------------------------------+
//| Calculations for the patch                                       |
//+------------------------------------------------------------------+
void CTabs::CalculatingPatch(int &x,int &y,int &x_size,int &y_size)
  {
   if(m_position_mode==TABS_TOP)
     {
      x      =m_tabs[m_selected_tab].X()+1;
      y      =m_tabs[m_selected_tab].Y2()-1;
      x_size =m_tabs[m_selected_tab].XSize()-2;
      y_size =1;
     }
   else if(m_position_mode==TABS_BOTTOM)
     {
      x      =m_tabs[m_selected_tab].X()+1;
      y      =m_tabs[m_selected_tab].Y();
      x_size =m_tabs[m_selected_tab].XSize()-2;
      y_size =1;
     }
   else if(m_position_mode==TABS_LEFT)
     {
      x      =m_tabs[m_selected_tab].X2()-1;
      y      =m_tabs[m_selected_tab].Y()+1;
      x_size =1;
      y_size =m_tabs[m_selected_tab].YSize()-2;
     }
   else if(m_position_mode==TABS_RIGHT)
     {
      x      =m_tabs[m_selected_tab].X();
      y      =m_tabs[m_selected_tab].Y()+1;
      x_size =1;
      y_size =m_tabs[m_selected_tab].YSize()-2;
     }
  }
//+------------------------------------------------------------------+
//| Change the width at the right edge of the form                   |
//+------------------------------------------------------------------+
void CTabs::ChangeWidthByRightWindowSide(void)
  {
//--- Coordinates
   int x=0;
   int y=0;
//--- Size
   int x_size=0;
   int y_size=0;
//--- 
   if(m_position_mode!=TABS_RIGHT)
     {
      //--- Calculate and set the sizes
      if(m_position_mode!=TABS_LEFT)
         x_size=m_wnd.X2()-m_main_area.X()-m_auto_xresize_right_offset;
      else
         x_size=m_wnd.X2()-SumWidthTabs()-m_tabs[0].X()-m_auto_xresize_right_offset+1;
      //---
      m_main_area.XSize(x_size);
      m_main_area.X_Size(x_size);
     }
   else
     {
      //--- Calculate and set the sizes
      x_size=m_wnd.X2()-SumWidthTabs()-m_main_area.X()-m_auto_xresize_right_offset+1;
      m_main_area.XSize(x_size);
      m_main_area.X_Size(x_size);
      //--- Store the coordinates and offsets
      x=m_main_area.X2()-1;
      m_tabs_area.X(x);
      m_tabs_area.XGap(x-m_wnd.X());
      //---
      for(int i=0; i<m_tabs_total; i++)
        {
         x=m_main_area.X2()-1;
         m_tabs[i].X(x);
         m_tabs[i].XGap(x-m_wnd.X());
        }
     }
//--- Calculation relative to positioning of tabs
   CalculatingPatch(x,y,x_size,y_size);
//--- Update values
   m_patch.X_Size(x_size);
   m_patch.XGap(x-m_wnd.X());
//--- Update the position of objects
   Moving(m_wnd.X(),m_wnd.Y());
  }
//+------------------------------------------------------------------+
