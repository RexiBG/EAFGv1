//+------------------------------------------------------------------+
//|                                                      MenuBar.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
#include "MenuItem.mqh"
#include "ContextMenu.mqh"
//+------------------------------------------------------------------+
//| Class for creating the main menu                                 |
//+------------------------------------------------------------------+
class CMenuBar : public CElement
  {
private:
   //--- Pointer to the form to which the element is attached
   CWindow          *m_wnd;
   //--- Objects for creating a menu item
   CRectLabel        m_area;
   CMenuItem         m_items[];
   //--- Array of context menu pointers
   CContextMenu     *m_contextmenus[];

   //--- Background properties
   int               m_area_zorder;
   color             m_area_color;
   color             m_area_color_hover;
   color             m_area_border_color;
   //--- General properties of menu items
   int               m_item_y_size;
   color             m_item_color;
   color             m_item_color_hover;
   color             m_item_border_color;
   int               m_label_x_gap;
   int               m_label_y_gap;
   color             m_label_color;
   color             m_label_color_hover;

   //--- Arrays of unique properties of menu items:
   //    (1) Width, (2) text
   int               m_width[];
   string            m_label_text[];
   //--- State of the main menu
   bool              m_menubar_state;
   //---
public:
                     CMenuBar(void);
                    ~CMenuBar(void);
   //--- Methods for creating the main menu
   bool              CreateMenuBar(const long chart_id,const int subwin,const int x,const int y);
   //---
private:
   bool              CreateArea(void);
   bool              CreateItems(void);
   //---
public:
   //--- Stores the form pointer
   void              WindowPointer(CWindow &object) { m_wnd=::GetPointer(object); }

   //--- (1) Getting the pointer to the specified menu item, (2) getting the pointer to the specified context menu
   CMenuItem        *ItemPointerByIndex(const int index);
   CContextMenu     *ContextMenuPointerByIndex(const int index);

   //--- Quantity of (1) menu items and (2) context menus, (3) state of the main menu
   int               ItemsTotal(void)               const { return(::ArraySize(m_items));        }
   int               ContextMenusTotal(void)        const { return(::ArraySize(m_contextmenus)); }
   bool              State(void)                    const { return(m_menubar_state);             }
   void              State(const bool state);

   //--- Color of (1) the background and (2) the background frame of the main menu
   void              MenuBackColor(const color clr)       { m_area_color=clr;                    }
   void              MenuBorderColor(const color clr)     { m_area_border_color=clr;             }
   //--- (1) background color, (2) background color when the cursor is hovering over it and (3) frame color of the main menu items
   void              ItemBackColor(const color clr)       { m_item_color=clr;                    }
   void              ItemBackColorHover(const color clr)  { m_item_color_hover=clr;              }
   void              ItemBorderColor(const color clr)     { m_item_border_color=clr;             }
   //--- Margins of the text label from the edge point of the menu item background
   void              LabelXGap(const int x_gap)           { m_label_x_gap=x_gap;                 }
   void              LabelYGap(const int y_gap)           { m_label_y_gap=y_gap;                 }
   //--- (1) Standard and (2) in-focus text color
   void              LabelColor(const color clr)          { m_label_color=clr;                   }
   void              LabelColorHover(const color clr)     { m_label_color_hover=clr;             }

   //--- Adds a menu item with specified properties before creation of the main menu
   void              AddItem(const int width,const string text);
   //--- Attaches the passed context menu to the specified item of the main menu
   void              AddContextMenuPointer(const int index,CContextMenu &object);
   //--- Changes the color when the mouse cursor is hovering over it
   void              ChangeObjectsColor(void);
   //---
public:
   //--- Chart event handler
   virtual void      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
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
   virtual void      ResetColors(void);
   //---
private:
   //--- Handling clicking on the menu item
   bool              OnClickMenuItem(const string clicked_object);
   //--- Returns the active item of the main menu
   int               ActiveItemIndex(void);
   //--- Switches the context menus of the main menu by hovering the cursor over it
   void              SwitchContextMenuByFocus(const int active_item_index);
   
   //--- Change the width at the right edge of the window
   virtual void      ChangeWidthByRightWindowSide(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CMenuBar::CMenuBar(void) : m_menubar_state(false),
                           m_area_zorder(0),
                           m_area_color(C'225,225,225'),
                           m_area_border_color(C'225,225,225'),
                           m_item_y_size(22),
                           m_item_color(C'225,225,225'),
                           m_item_color_hover(C'51,153,255'),
                           m_item_border_color(C'225,225,225'),
                           m_label_x_gap(15),
                           m_label_y_gap(3),
                           m_label_color(clrBlack),
                           m_label_color_hover(clrWhite)
  {
//--- Store the name of the element class in the base class
   ClassName(CLASS_NAME);
//--- Default height of the main menu
   m_y_size=22;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CMenuBar::~CMenuBar(void)
  {
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CMenuBar::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
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
      //--- Leave, if the main menu has not been activated
      if(!m_menubar_state)
         return;
      //--- Get the index of the activated item of the main menu
      int active_item_index=ActiveItemIndex();
      if(active_item_index==WRONG_VALUE)
         return;
      //--- Change the color if the focus has changed
      ChangeObjectsColor();
      //--- Switch the context menu by the activated item of the main menu
      SwitchContextMenuByFocus(active_item_index);
      return;
     }
//--- Handling of the left mouse click event on the main menu item
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      if(OnClickMenuItem(sparam))
         return;
     }
  }
//+------------------------------------------------------------------+
//| Creates the main menu                                            |
//+------------------------------------------------------------------+
bool CMenuBar::CreateMenuBar(const long chart_id,const int subwin,const int x,const int y)
  {
//--- Leave, if there is no form pointer
   if(!CElement::CheckWindowPointer(::CheckPointer(m_wnd)))
      return(false);
//--- Initializing variables
   m_id       =m_wnd.LastId()+1;
   m_chart_id =chart_id;
   m_subwin   =subwin;
   m_x        =x;
   m_y        =y;
//--- Margins from the edge
   CElement::XGap(x-m_wnd.X());
   CElement::YGap(y-m_wnd.Y());
//--- Creating the main menu
   if(!CreateArea())
      return(false);
   if(!CreateItems())
      return(false);
//--- Initially, the main menu is disabled
   State(false);
//--- Hide the control if it is in the dialog window or the window is minimized
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates the common area of the main menu                         |
//+------------------------------------------------------------------+
bool CMenuBar::CreateArea(void)
  {
//--- Forming the object name
   string name=CElement::ProgramName()+"_menubar_bg_"+(string)CElement::Id();
//--- Coordinates and width
   int x=m_x;
   int y=m_y;
   m_x_size=(m_x_size<1)? m_wnd.X2()-x-m_auto_xresize_right_offset : m_x_size;
//--- Set the main menu background
   if(!m_area.Create(m_chart_id,name,m_subwin,x,y,m_x_size,m_y_size))
      return(false);
//--- set properties
   m_area.BackColor(m_area_color);
   m_area.Color(m_area_border_color);
   m_area.BorderType(BORDER_FLAT);
   m_area.Corner(m_corner);
   m_area.Selectable(false);
   m_area.Z_Order(m_area_zorder);
   m_area.Tooltip("\n");
//--- Margins from the edge
   m_area.XGap(XGap());
   m_area.YGap(YGap());
//--- Store the object pointer
   CElement::AddToArray(m_area);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates a list of menu items                                     |
//+------------------------------------------------------------------+
bool CMenuBar::CreateItems(void)
  {
   int x=m_x+1;
   int y=m_y+1;
//---
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
     {
      //--- Calculation of the X coordinate
      x=(i>0)? x+m_width[i-1]: x;
      //--- Pass the panel object
      m_items[i].WindowPointer(m_wnd);
      //--- Set properties before creation
      m_items[i].TypeMenuItem(MI_HAS_CONTEXT_MENU);
      m_items[i].ShowRightArrow(false);
      m_items[i].XSize(m_width[i]);
      m_items[i].YSize(m_y_size-2);
      m_items[i].AreaBorderColor(m_item_border_color);
      m_items[i].AreaBackColor(m_item_color);
      m_items[i].AreaBackColorHover(m_item_color_hover);
      m_items[i].LabelXGap(m_label_x_gap);
      m_items[i].LabelYGap(m_label_y_gap);
      m_items[i].LabelColor(m_label_color);
      m_items[i].LabelColorHover(m_label_color_hover);
      //--- Margins from the edge of the panel
      m_items[i].XGap(x-m_wnd.X());
      m_items[i].YGap(y-m_wnd.Y());
      //--- Creating a menu item
      if(!m_items[i].CreateMenuItem(m_chart_id,m_subwin,i,m_label_text[i],x,y))
         return(false);
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Setting the state of the main menu                               |
//+------------------------------------------------------------------+
void CMenuBar::State(const bool state)
  {
   if(state)
      m_menubar_state=true;
   else
     {
      m_menubar_state=false;
      //--- Iterate over all items of the main menu for
      //    setting the status of disabled context menus
      int items_total=ItemsTotal();
      for(int i=0; i<items_total; i++)
         m_items[i].ContextMenuState(false);
      //--- Unblock the form
      m_wnd.IsLocked(false);
     }
  }
//+------------------------------------------------------------------+
//| Returns a menu item pointer by the index                         |
//+------------------------------------------------------------------+
CMenuItem *CMenuBar::ItemPointerByIndex(const int index)
  {
   int array_size=::ArraySize(m_items);
//--- If the main menu does not contain any item, report
   if(array_size<1)
     {
      ::Print(__FUNCTION__," > This method is to be called, "
              "when the main menu contains at least one item!");
     }
//--- Adjustment in case the range has been exceeded
   int i=(index>=array_size)? array_size-1 :(index<0)? 0 : index;
//--- Return the pointer
   return(::GetPointer(m_items[i]));
  }
//+------------------------------------------------------------------+
//| Returns the context menu pointer by the index                    |
//+------------------------------------------------------------------+
CContextMenu *CMenuBar::ContextMenuPointerByIndex(const int index)
  {
   int array_size=::ArraySize(m_contextmenus);
//--- If the main menu does not contain any item, report
   if(array_size<1)
     {
      ::Print(__FUNCTION__," > This method is to be called, "
              "when the main menu contains at least one item!");
     }
//--- Adjustment in case the range has been exceeded
   int i=(index>=array_size)? array_size-1 :(index<0)? 0 : index;
//--- Return the pointer
   return(::GetPointer(m_contextmenus[i]));
  }
//+------------------------------------------------------------------+
//| Adds a menu item                                                 |
//+------------------------------------------------------------------+
void CMenuBar::AddItem(const int width,const string text)
  {
//--- Increase the array size by one element  
   int array_size=::ArraySize(m_items);
   ::ArrayResize(m_items,array_size+1);
   ::ArrayResize(m_contextmenus,array_size+1);
   ::ArrayResize(m_width,array_size+1);
   ::ArrayResize(m_label_text,array_size+1);
//--- Store the value of passed parameters
   m_width[array_size]      =width;
   m_label_text[array_size] =text;
  }
//+------------------------------------------------------------------+
//| Adds the context menu pointer                                    |
//+------------------------------------------------------------------+
void CMenuBar::AddContextMenuPointer(const int index,CContextMenu &object)
  {
//--- Checking for exceeding the array range
   int size=::ArraySize(m_contextmenus);
   if(size<1 || index<0 || index>=size)
      return;
//--- Store the pointer
   m_contextmenus[index]=::GetPointer(object);
  }
//+------------------------------------------------------------------+
//| Reset the item color                                             |
//+------------------------------------------------------------------+
void CMenuBar::ResetColors(void)
  {
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
      m_items[i].ResetColors();
  }
//+------------------------------------------------------------------+
//| Moving elements                                                  |
//+------------------------------------------------------------------+
void CMenuBar::Moving(const int x,const int y)
  {
//--- Leave, if the element is hidden
   if(!CElement::IsVisible())
      return;
//--- Storing coordinates in the element fields  
   CElement::X(x+XGap());
   CElement::Y(y+YGap());
//--- Storing coordinates in the fields of the objects
   m_area.X(x+m_area.XGap());
   m_area.Y(y+m_area.YGap());
//--- Updating coordinates of graphical objects
   m_area.X_Distance(m_area.X());
   m_area.Y_Distance(m_area.Y());
  }
//+------------------------------------------------------------------+
//| Shows a menu item                                                |
//+------------------------------------------------------------------+
void CMenuBar::Show(void)
  {
//--- Leave, if the element is already visible
   if(CElement::IsVisible())
      return;
//--- Make all objects visible  
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_ALL_PERIODS);
//--- Make all the menu items visible 
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
      m_items[i].Show();
//--- Initializing variables
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Hides a menu item                                                |
//+------------------------------------------------------------------+
void CMenuBar::Hide(void)
  {
//--- Leave, if the element is hidden
   if(!CElement::IsVisible())
      return;
//--- Hides the main menu objects
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_NO_PERIODS);
//--- Hide the menu items
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
      m_items[i].Hide();
//--- Assign the status of a hidden element
   CElement::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| Redrawing                                                        |
//+------------------------------------------------------------------+
void CMenuBar::Reset(void)
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
void CMenuBar::Delete(void)
  {
//--- Removing objects  
   m_area.Delete();
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
      m_items[i].Delete();
//--- Emptying the control arrays
   ::ArrayFree(m_items);
   ::ArrayFree(m_contextmenus);
   ::ArrayFree(m_width);
   ::ArrayFree(m_label_text);
//--- Emptying the array of the objects
   CElement::FreeObjectsArray();
//--- Initializing of variables by default values
   CElement::MouseFocus(false);
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Seth the priorities                                              |
//+------------------------------------------------------------------+
void CMenuBar::SetZorders(void)
  {
   m_area.Z_Order(m_area_zorder);
  }
//+------------------------------------------------------------------+
//| Reset the priorities                                             |
//+------------------------------------------------------------------+
void CMenuBar::ResetZorders(void)
  {
   m_area.Z_Order(0);
  }
//+------------------------------------------------------------------+
//| Changing the object color when the cursor is hovering over it    |
//+------------------------------------------------------------------+
void CMenuBar::ChangeObjectsColor(void)
  {
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
      m_items[i].ChangeObjectsColor();
  }
//+------------------------------------------------------------------+
//| Clicking on the main menu item                                   |
//+------------------------------------------------------------------+
bool CMenuBar::OnClickMenuItem(const string clicked_object)
  {
//--- Leave, if the pressing was not on the menu item
   if(::StringFind(clicked_object,CElement::ProgramName()+"_menuitem_",0)<0)
      return(false);
//--- Get the identifier and index from the object name
   int id    =CElement::IdFromObjectName(clicked_object);
   int index =CElement::IndexFromObjectName(clicked_object);
//--- Leave, if the identifier does not match
   if(id!=CElement::Id())
      return(false);
//--- If there is a context menu pointer
   if(::CheckPointer(m_contextmenus[index])!=POINTER_INVALID)
     {
      //--- Change the color of the item
      m_items[index].HighlightItemState(true);
      //--- The state of the main menu depends on the visibility of the context menu
      m_menubar_state=(m_contextmenus[index].ContextMenuState())? false : true;
      //--- Set the state of the form
      m_wnd.IsLocked(m_menubar_state);
      //--- If the main menu is disabled
      if(!m_menubar_state)
         //--- Send a signal for hiding all context menus
         ::EventChartCustom(m_chart_id,ON_HIDE_CONTEXTMENUS,0,0,"");
     }
//--- If there is no context menu pointer
   else
     {
      //--- Send a signal for hiding all context menus
      ::EventChartCustom(m_chart_id,ON_HIDE_CONTEXTMENUS,0,0,"");
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Returns the index of the activated menu item                     |
//+------------------------------------------------------------------+
int CMenuBar::ActiveItemIndex(void)
  {
   int active_item_index=WRONG_VALUE;
//---
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
     {
      //--- If the item is in focus
      if(m_items[i].MouseFocus())
        {
         //--- Store the index and stop the loop
         active_item_index=i;
         break;
        }
     }
//---
   return(active_item_index);
  }
//+------------------------------------------------------------------+
//| Switches context menus of the main menu by hovering cursor over  |
//+------------------------------------------------------------------+
void CMenuBar::SwitchContextMenuByFocus(const int active_item_index)
  {
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
     {
      //--- Move to the following item menu if this one does not have a context menu
      if(::CheckPointer(m_contextmenus[i])==POINTER_INVALID)
         continue;
      //--- If you make it to the specified menu item, make its context menu visible
      if(i==active_item_index)
         m_contextmenus[i].Show();
      //--- Hide the rest of context menus
      else
        {
         CContextMenu *cm=m_contextmenus[i];
         //--- Hide the context menus, which are open from other context menus.
         //    Iterate over the items of the current context menus to find out if there are any.
         int cm_items_total=cm.ItemsTotal();
         for(int c=0; c<cm_items_total; c++)
           {
            CMenuItem *mi=cm.ItemPointerByIndex(c);
            //--- Move to the following menu item if the pointer to this one is incorrect
            if(::CheckPointer(mi)==POINTER_INVALID)
               continue;
            //--- Move to the following menu item if this one does not contain a context menu
            if(mi.TypeMenuItem()!=MI_HAS_CONTEXT_MENU)
               continue;
            //--- If there is a context menu and it is activated
            if(mi.ContextMenuState())
              {
               //--- Send a signal for closing all context menus, which are open from this one
               ::EventChartCustom(m_chart_id,ON_HIDE_BACK_CONTEXTMENUS,CElement::Id(),0,"");
               break;
              }
           }
         //--- Hide the context menu of the main menu
         m_contextmenus[i].Hide();
         //--- Reset the color of the menu item
         m_items[i].ResetColors();
        }
     }
  }
//+------------------------------------------------------------------+
//| Change the width at the right edge of the form                   |
//+------------------------------------------------------------------+
void CMenuBar::ChangeWidthByRightWindowSide(void)
  {
//--- Coordinates
   int x=0;
//--- Size
   int x_size=0;
//--- Calculate and set the new size
   x_size=m_wnd.X2()-m_area.X()-m_auto_xresize_right_offset;
   m_area.XSize(x_size);
   m_area.X_Size(x_size);
//--- Update the position of objects
   Moving(m_wnd.X(),m_wnd.Y());
  }
//+------------------------------------------------------------------+
