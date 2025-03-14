//+------------------------------------------------------------------+
//|                                                  ContextMenu.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
#include "MenuItem.mqh"
#include "SeparateLine.mqh"
//+------------------------------------------------------------------+
//| Class for creating a context menu                                |
//+------------------------------------------------------------------+
class CContextMenu : public CElement
  {
private:
   //--- Pointer to the form to which the element is attached
   CWindow          *m_wnd;
   //--- Objects for creating a menu item
   CRectLabel        m_area;
   CMenuItem         m_items[];
   CSeparateLine     m_sep_line[];
   //--- Pointer to the previous node
   CMenuItem        *m_prev_node;
   //--- Background properties
   int               m_area_zorder;
   color             m_area_color;
   color             m_area_border_color;
   color             m_area_color_hover;
   color             m_area_color_array[];
   //--- Properties of menu items
   int               m_item_y_size;
   color             m_item_back_color;
   color             m_item_back_color_hover;
   color             m_item_back_color_hover_off;
   color             m_item_border_color;
   color             m_label_color;
   color             m_label_color_hover;
   string            m_right_arrow_file_on;
   string            m_right_arrow_file_off;
   //--- Separation line properties
   color             m_sepline_dark_color;
   color             m_sepline_light_color;
   //--- Arrays of the menu item properties:
   //    (1) Text, (2) label of the available item, (3) label of the blocked item
   string            m_label_text[];
   string            m_path_bmp_on[];
   string            m_path_bmp_off[];
   //--- Array of index numbers of menu items after which a separation line is to be set
   int               m_sep_line_index[];
   //--- State of the context menu
   bool              m_context_menu_state;
   //--- Attachment side of the context menu
   ENUM_FIX_CONTEXT_MENU m_fix_side;
   //--- The detached context menu mode. This means that there is no attachment to the previous node.
   bool              m_free_context_menu;
   //---
public:
                     CContextMenu(void);
                    ~CContextMenu(void);
   //--- Methods for creating a context menu
   bool              CreateContextMenu(const long chart_id,const int window,const int x=0,const int y=0);
   //---
private:
   bool              CreateArea(void);
   bool              CreateItems(void);
   bool              CreateSeparateLine(const int line_number,const int x,const int y);
   //---
public:
   //--- (1) Stores the form pointer,
   //    (2) get and (3) store the pointer of the previous node, (4) set the free context menu mode
   void              WindowPointer(CWindow &object)                 { m_wnd=::GetPointer(object);           }
   CMenuItem        *PrevNodePointer(void)                    const { return(m_prev_node);                  }
   void              PrevNodePointer(CMenuItem &object)             { m_prev_node=::GetPointer(object);     }
   void              FreeContextMenu(const bool flag)               { m_free_context_menu=flag;             }
   //--- Returns the item pointer from the context menu
   CMenuItem        *ItemPointerByIndex(const int index);

   //--- Methods for setting up the appearance of the context menu:
   //    Color of the context menu background
   void              AreaBackColor(const color clr)                 { m_area_color=clr;                     }
   void              AreaBorderColor(const color clr)               { m_area_border_color=clr;              }

   //--- (1) Number of menu items, (2) height, (3) background color and (4) color of the menu item frame 
   int               ItemsTotal(void)                         const { return(::ArraySize(m_items));         }
   void              ItemYSize(const int y_size)                    { m_item_y_size=y_size;                 }
   void              ItemBackColor(const color clr)                 { m_item_back_color=clr;                }
   void              ItemBorderColor(const color clr)               { m_item_border_color=clr;              }
   //--- Background color of (1) the available and (2) the blocked menu item when hovering the mouse cursor over it
   void              ItemBackColorHover(const color clr)            { m_item_back_color_hover=clr;          }
   void              ItemBackColorHoverOff(const color clr)         { m_item_back_color_hover_off=clr;      }
   //--- (1) Standard and (2) in-focus text color
   void              LabelColor(const color clr)                    { m_label_color=clr;                    }
   void              LabelColorHover(const color clr)               { m_label_color_hover=clr;              }
   //--- Defining an icon for indicating the presence of a context menu in the item
   void              RightArrowFileOn(const string file_path)       { m_right_arrow_file_on=file_path;      }
   void              RightArrowFileOff(const string file_path)      { m_right_arrow_file_off=file_path;     }
   //--- (1) Dark and (2) light color of the separation line
   void              SeparateLineDarkColor(const color clr)         { m_sepline_dark_color=clr;             }
   void              SeparateLineLightColor(const color clr)        { m_sepline_light_color=clr;            }

   //--- Adds a menu item with specified properties before the creation of the context menu
   void              AddItem(const string text,const string path_bmp_on,const string path_bmp_off,const ENUM_TYPE_MENU_ITEM type);
   //--- Adds a separation line after the specified menu item before the creation of the context menu
   void              AddSeparateLine(const int item_index);

   //--- Returns description (displayed text)
   string            DescriptionByIndex(const int index);
   //--- Returns a menu item type
   ENUM_TYPE_MENU_ITEM TypeMenuItemByIndex(const int index);

   //--- (1) Getting and (2) setting the checkbox state
   bool              CheckBoxStateByIndex(const int index);
   void              CheckBoxStateByIndex(const int index,const bool state);
   //--- (1) Returns and (2) sets the id of the radio item by the index
   int               RadioItemIdByIndex(const int index);
   void              RadioItemIdByIndex(const int item_index,const int radio_id);
   //--- (1) Returns selected radio item, (2) switches the radio item
   int               SelectedRadioItem(const int radio_id);
   void              SelectedRadioItem(const int radio_index,const int radio_id);

   //--- (1) Getting and (2) setting the context menu state, (3) setting the context menu attachment mode
   bool              ContextMenuState(void)                   const { return(m_context_menu_state);         }
   void              ContextMenuState(const bool flag)              { m_context_menu_state=flag;            }
   void              FixSide(const ENUM_FIX_CONTEXT_MENU side)      { m_fix_side=side;                      }

   //--- Changes the color of menu items when the cursor is hovering over them
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
   virtual void      ResetColors(void);
   //---
private:
   //--- Condition check for closing all context menus
   void              CheckHideContextMenus(void);
   //--- Condition check for closing all context menus which were open after this one
   void              CheckHideBackContextMenus(void);
   //--- Handling clicking on the item to which this context menu is attached
   bool              OnClickMenuItem(const string clicked_object);
   //--- Receiving the message from the menu item for handling
   void              ReceiveMessageFromMenuItem(const int id_item,const int index_item,const string message_item);
   //--- Getting (1) the identifier and (2) index from the radio item message
   int               RadioIdFromMessage(const string message);
   int               RadioIndexByItemIndex(const int index);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CContextMenu::CContextMenu(void) : m_context_menu_state(false),
                                   m_free_context_menu(false),
                                   m_fix_side(FIX_RIGHT),
                                   m_item_y_size(24),
                                   m_area_color(C'240,240,240'),
                                   m_area_color_hover(C'51,153,255'),
                                   m_area_border_color(clrSilver),
                                   m_item_back_color(clrNONE),
                                   m_item_back_color_hover(C'51,153,255'),
                                   m_item_back_color_hover_off(clrLightGray),
                                   m_item_border_color(clrNONE),
                                   m_label_color(clrBlack),
                                   m_label_color_hover(clrWhite),
                                   m_sepline_dark_color(C'160,160,160'),
                                   m_sepline_light_color(clrWhite),
                                   m_right_arrow_file_on(""),
                                   m_right_arrow_file_off("")
  {
//--- Store the name of the element class in the base class
   CElement::ClassName(CLASS_NAME);
//--- Set priorities of the left mouse button click
   m_area_zorder=0;
//--- Context menu is a drop-down element
   CElement::IsDropdown(true);
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CContextMenu::~CContextMenu(void)
  {
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CContextMenu::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- Handling the mouse cursor movement
   if(id==CHARTEVENT_MOUSE_MOVE)
     {
      //--- Leave, if the element is hidden
      if(!CElement::IsVisible())
         return;
      //--- Leave, if numbers of subwindows do not match
      if(CElement::m_subwin!=CElement::m_mouse.SubWindowNumber())
         return;
      //--- Get the focus
      CElement::MouseFocus(m_mouse.X()>X() && m_mouse.X()<X2() && m_mouse.Y()>Y() && m_mouse.Y()<Y2());
      //--- Leave, if this is a detached context menu
      if(m_free_context_menu)
         return;
      //--- If the context menu is enabled and the left mouse button is pressed
      if(m_context_menu_state && m_mouse.LeftButtonState())
        {
         //--- Check conditions for closing all context menus
         CheckHideContextMenus();
         return;
        }
      //--- Check the conditions for closing all context menus which were open below this one
      CheckHideBackContextMenus();
      return;
     }
//--- Handling the left mouse button click on the object
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      if(OnClickMenuItem(sparam))
         return;
     }
//--- Handling the ON_CLICK_MENU_ITEM event
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_MENU_ITEM)
     {
      //--- Leave, if this is a detached context menu
      if(m_free_context_menu)
         return;
      //---
      int    item_id      =int(lparam);
      int    item_index   =int(dparam);
      string item_message =sparam;
      //--- Receiving the message from the menu item for handling
      ReceiveMessageFromMenuItem(item_id,item_index,item_message);
      return;
     }
  }
//+------------------------------------------------------------------+
//| Timer                                                            |
//+------------------------------------------------------------------+
void CContextMenu::OnEventTimer(void)
  {
//--- Changing the color of menu items when the cursor is hovering over them
   ChangeObjectsColor();
  }
//+------------------------------------------------------------------+
//| Creates a context menu                                           |
//+------------------------------------------------------------------+
bool CContextMenu::CreateContextMenu(const long chart_id,const int subwin,const int x=0,const int y=0)
  {
//--- Leave, if there is no form pointer
   if(!CElement::CheckWindowPointer(::CheckPointer(m_wnd)))
      return(false);
//--- If this is an attached context menu
   if(!m_free_context_menu)
     {
      //--- Leave, if there is no pointer to the previous node 
      if(::CheckPointer(m_prev_node)==POINTER_INVALID)
        {
         ::Print(__FUNCTION__," > Before creating a context menu it must be passed "
                 "the pointer to the previous node using the CContextMenu::PrevNodePointer(CMenuItem &object) method.");
         return(false);
        }
     }
//--- Initializing variables
   m_id       =m_wnd.LastId()+1;
   m_chart_id =chart_id;
   m_subwin   =subwin;
//--- If coordinates have not been specified
   if(x==0 || y==0)
     {
      m_x =(m_fix_side==FIX_RIGHT)? m_prev_node.X2()-3 : m_prev_node.X()+1;
      m_y =(m_fix_side==FIX_RIGHT)? m_prev_node.Y()-1  : m_prev_node.Y2()-1;
     }
//--- If coordinates have been specified
   else
     {
      m_x =x;
      m_y =y;
     }
//--- Margins from the edge
   CElement::XGap(m_x-m_wnd.X());
   CElement::YGap(m_y-m_wnd.Y());
//--- Creating a context menu
   if(!CreateArea())
      return(false);
   if(!CreateItems())
      return(false);
//--- Hide the element
   Hide();
//--- Reset the color of objects
   ResetColors();
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates the common area of a context menu                        |
//+------------------------------------------------------------------+
bool CContextMenu::CreateArea(void)
  {
//--- Forming the object name
   string name=CElement::ProgramName()+"_contextmenu_bg_"+(string)CElement::Id();
//--- Calculation of the context menu height depends on the number of menu items and separation lines
   int items_total =ItemsTotal();
   int sep_y_size  =::ArraySize(m_sep_line)*9;
   m_y_size        =(m_item_y_size*items_total+2)+sep_y_size-(items_total-1);
//--- Set up the context menu background
   if(!m_area.Create(m_chart_id,name,m_subwin,m_x,m_y,m_x_size,m_y_size))
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
   m_area.XGap(m_x-m_wnd.X());
   m_area.YGap(m_y-m_wnd.Y());
//--- Background size
   m_area.XSize(m_x_size);
   m_area.YSize(m_y_size);
//--- Store the object pointer
   CElement::AddToArray(m_area);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates a list of menu items                                     |
//+------------------------------------------------------------------+
bool CContextMenu::CreateItems(void)
  {
   int s =0;     // For identification of the location of separation lines
   int x =m_x+1; // X coordinate
   int y =m_y+1; // Y coordinate. Will be calculated in a loop for every menu item.
//--- Number of separation lines
   int sep_lines_total=::ArraySize(m_sep_line_index);
//---
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
     {
      //--- Calculating the Y coordinate
      y=(i>0)? y+m_item_y_size-1 : y;
      //--- Store the form pointer
      m_items[i].WindowPointer(m_wnd);
      //--- If the context menu has an attachment, add the pointer to the previous node
      if(!m_free_context_menu)
         m_items[i].PrevNodePointer(m_prev_node);
      //--- set properties
      m_items[i].XSize(m_x_size-2);
      m_items[i].YSize(m_item_y_size);
      m_items[i].IconFileOn(m_path_bmp_on[i]);
      m_items[i].IconFileOff(m_path_bmp_off[i]);
      m_items[i].AreaBackColor(m_area_color);
      m_items[i].AreaBackColorHoverOff(m_item_back_color_hover_off);
      m_items[i].AreaBorderColor(m_area_color);
      m_items[i].LabelColor(m_label_color);
      m_items[i].LabelColorHover(m_label_color_hover);
      m_items[i].RightArrowFileOn(m_right_arrow_file_on);
      m_items[i].RightArrowFileOff(m_right_arrow_file_off);
      m_items[i].IsDropdown(m_is_dropdown);
      //--- Margins from the edge of the panel
      m_items[i].XGap(x-m_wnd.X());
      m_items[i].YGap(y-m_wnd.Y());
      //--- Creating a menu item
      if(!m_items[i].CreateMenuItem(m_chart_id,m_subwin,i,m_label_text[i],x,y))
         return(false);
      //--- Zero the focus
      CElement::MouseFocus(false);
      //--- Move to the following one if all separation lines have been set
      if(s>=sep_lines_total)
         continue;
      //--- If indices match, set a separation line after this menu item
      if(i==m_sep_line_index[s])
        {
         //--- Coordinates
         int l_x=x+5;
         y=y+m_item_y_size+2;
         //--- Setting up a separation line
         if(!CreateSeparateLine(s,l_x,y))
            return(false);
         //--- Adjustment of the Y coordinate for the following item
         y=y-m_item_y_size+7;
         //--- Increase the counter for separation lines
         s++;
        }
     }
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates a separation line                                        |
//+------------------------------------------------------------------+
bool CContextMenu::CreateSeparateLine(const int line_number,const int x,const int y)
  {
//--- Store the form pointer
   m_sep_line[line_number].WindowPointer(m_wnd);
//--- set properties
   m_sep_line[line_number].TypeSepLine(H_SEP_LINE);
   m_sep_line[line_number].DarkColor(m_sepline_dark_color);
   m_sep_line[line_number].LightColor(m_sepline_light_color);
//--- Creating a separation line
   if(!m_sep_line[line_number].CreateSeparateLine(m_chart_id,m_subwin,line_number,x,y,m_x_size-10,2))
      return(false);
//--- Store the object pointer
   CElement::AddToArray(m_sep_line[line_number].Object(0));
   return(true);
  }
//+------------------------------------------------------------------+
//| Returns a menu item pointer by the index                         |
//+------------------------------------------------------------------+
CMenuItem *CContextMenu::ItemPointerByIndex(const int index)
  {
   int array_size=::ArraySize(m_items);
//--- If there are no items in the context menu, report
   if(array_size<1)
     {
      ::Print(__FUNCTION__," > This method is to be called, "
              "if the context menu has at least one item!");
     }
//--- Adjustment in case the range has been exceeded
   int i=(index>=array_size)? array_size-1 :(index<0)? 0 : index;
//--- Return the pointer
   return(::GetPointer(m_items[i]));
  }
//+------------------------------------------------------------------+
//| Adds a menu item                                                 |
//+------------------------------------------------------------------+
void CContextMenu::AddItem(const string text,const string path_bmp_on,const string path_bmp_off,const ENUM_TYPE_MENU_ITEM type)
  {
//--- Increase the array size by one element
   int array_size=::ArraySize(m_items);
   ::ArrayResize(m_items,array_size+1);
   ::ArrayResize(m_label_text,array_size+1);
   ::ArrayResize(m_path_bmp_on,array_size+1);
   ::ArrayResize(m_path_bmp_off,array_size+1);
//--- Store the value of passed parameters
   m_label_text[array_size]   =text;
   m_path_bmp_on[array_size]  =path_bmp_on;
   m_path_bmp_off[array_size] =path_bmp_off;
//--- Setting the type of the menu item
   m_items[array_size].TypeMenuItem(type);
  }
//+------------------------------------------------------------------+
//| Adds a separation line                                           |
//+------------------------------------------------------------------+
void CContextMenu::AddSeparateLine(const int item_index)
  {
//--- Increase the array size by one element
   int array_size=::ArraySize(m_sep_line);
   ::ArrayResize(m_sep_line,array_size+1);
   ::ArrayResize(m_sep_line_index,array_size+1);
//--- Store the index number
   m_sep_line_index[array_size]=item_index;
  }
//+------------------------------------------------------------------+
//| Returns the item name by the index                               |
//+------------------------------------------------------------------+
string CContextMenu::DescriptionByIndex(const int index)
  {
   int array_size=::ArraySize(m_items);
//--- If there are no items in the context menu, report
   if(array_size<1)
     {
      ::Print(__FUNCTION__," > This method is to be called, "
              "if the context menu has at least one item!");
     }
//--- Adjustment in case the range has been exceeded
   int i=(index>=array_size)? array_size-1 :(index<0)? 0 : index;
//--- Return the item description
   return(m_items[i].LabelText());
  }
//+------------------------------------------------------------------+
//| Returns the item type by the index                               |
//+------------------------------------------------------------------+
ENUM_TYPE_MENU_ITEM CContextMenu::TypeMenuItemByIndex(const int index)
  {
   int array_size=::ArraySize(m_items);
//--- If there are no items in the context menu, report
   if(array_size<1)
     {
      ::Print(__FUNCTION__," > This method is to be called, "
              "if the context menu has at least one item!");
     }
//--- Adjustment in case the range has been exceeded
   int i=(index>=array_size)? array_size-1 :(index<0)? 0 : index;
//--- Return the item type
   return(m_items[i].TypeMenuItem());
  }
//+------------------------------------------------------------------+
//| Returns the checkbox state by the index                          |
//+------------------------------------------------------------------+
bool CContextMenu::CheckBoxStateByIndex(const int index)
  {
   int array_size=::ArraySize(m_items);
//--- If there are no items in the context menu, report
   if(array_size<1)
     {
      ::Print(__FUNCTION__," > This method is to be called, "
              "if the context menu has at least one item!");
     }
//--- Adjustment in case the range has been exceeded
   int i=(index>=array_size)? array_size-1 :(index<0)? 0 : index;
//--- Return the item state
   return(m_items[i].CheckBoxState());
  }
//+------------------------------------------------------------------+
//| Sets the checkbox state by the index                             |
//+------------------------------------------------------------------+
void CContextMenu::CheckBoxStateByIndex(const int index,const bool state)
  {
//--- Checking for exceeding the array range
   int size=::ArraySize(m_items);
   if(size<1 || index<0 || index>=size)
      return;
//--- Set the state
   m_items[index].CheckBoxState(state);
  }
//+------------------------------------------------------------------+
//| Returns the radio item id by the index                           |
//+------------------------------------------------------------------+
int CContextMenu::RadioItemIdByIndex(const int index)
  {
   int array_size=::ArraySize(m_items);
//--- If there are no items in the context menu, report
   if(array_size<1)
     {
      ::Print(__FUNCTION__," > This method is to be called, "
              "if the context menu has at least one item!");
     }
//--- Adjustment in case the range has been exceeded
   int i=(index>=array_size)? array_size-1 :(index<0)? 0 : index;
//--- Return the identifier
   return(m_items[i].RadioButtonID());
  }
//+------------------------------------------------------------------+
//| Sets the radio item id by the index                              |
//+------------------------------------------------------------------+
void CContextMenu::RadioItemIdByIndex(const int index,const int id)
  {
//--- Checking for exceeding the array range
   int array_size=::ArraySize(m_items);
   if(array_size<1 || index<0 || index>=array_size)
      return;
//--- Set the identifier
   m_items[index].RadioButtonID(id);
  }
//+------------------------------------------------------------------+
//| Returns the radio item index by the id                           |
//+------------------------------------------------------------------+
int CContextMenu::SelectedRadioItem(const int radio_id)
  {
//--- Radio item counter
   int count_radio_id=0;
//--- Iterate over the list of context menu items
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
     {
      //--- Move to the following if this is not a radio item
      if(m_items[i].TypeMenuItem()!=MI_RADIOBUTTON)
         continue;
      //--- If identifiers match
      if(m_items[i].RadioButtonID()==radio_id)
        {
         //--- If this is an active radio item, leave the loop
         if(m_items[i].RadioButtonState())
            break;
         //--- Increase the counter of radio items
         count_radio_id++;
        }
     }
//--- Return the index
   return(count_radio_id);
  }
//+------------------------------------------------------------------+
//| Switches the radio item by the index and id                      |
//+------------------------------------------------------------------+
void CContextMenu::SelectedRadioItem(const int radio_index,const int radio_id)
  {
//--- Radio item counter
   int count_radio_id=0;
//--- Iterate over the list of context menu items
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
     {
      //--- Move to the following if this is not a radio item
      if(m_items[i].TypeMenuItem()!=MI_RADIOBUTTON)
         continue;
      //--- If identifiers match
      if(m_items[i].RadioButtonID()==radio_id)
        {
         //--- Switch the radio item
         if(count_radio_id==radio_index)
            m_items[i].RadioButtonState(true);
         else
            m_items[i].RadioButtonState(false);
         //--- Increase the counter of radio items
         count_radio_id++;
        }
     }
  }
//+------------------------------------------------------------------+
//| Moving elements                                                  |
//+------------------------------------------------------------------+
void CContextMenu::Moving(const int x,const int y)
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
//--- Moving menu items
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
      m_items[i].Moving(x,y);
//--- Moving separation lines
   int sep_total=::ArraySize(m_sep_line);
   for(int i=0; i<sep_total; i++)
      m_sep_line[i].Moving(x,y);
  }
//+------------------------------------------------------------------+
//| Shows a context menu                                             |
//+------------------------------------------------------------------+
void CContextMenu::Show(void)
  {
//--- Leave, if the element is already visible
   if(CElement::IsVisible())
      return;
//--- Show the objects of the context menu
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_ALL_PERIODS);
//--- Show the menu items
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
      m_items[i].Show();
//--- Show the separation line
   int sep_total=::ArraySize(m_sep_line);
   for(int i=0; i<sep_total; i++)
      m_sep_line[i].Show();
//--- Reset the color of objects
   ResetColors();
//--- Assign the status of a visible element
   CElement::IsVisible(true);
//--- State of the context menu
   m_context_menu_state=true;
//--- Register the state in the previous node
   if(!m_free_context_menu)
      m_prev_node.ContextMenuState(true);
//--- Block the form
   m_wnd.IsLocked(true);
//--- Send a signal for zeroing priorities of the left mouse click
   ::EventChartCustom(m_chart_id,ON_ZERO_PRIORITIES,CElement::Id(),0.0,"");
  }
//+------------------------------------------------------------------+
//| Hides a context menu                                             |
//+------------------------------------------------------------------+
void CContextMenu::Hide(void)
  {
//--- Leave, if the element is hidden
   if(!CElement::IsVisible())
      return;
//--- Hide the objects of the context menu
   for(int i=0; i<CElement::ObjectsElementTotal(); i++)
      CElement::Object(i).Timeframes(OBJ_NO_PERIODS);
//--- Hide the menu items
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
      m_items[i].Hide();
//--- Hide the separation line
   int sep_total=::ArraySize(m_sep_line);
   for(int i=0; i<sep_total; i++)
      m_sep_line[i].Hide();
//--- Zero the focus
   CElement::MouseFocus(false);
//--- Assign the status of a hidden element
   CElement::IsVisible(false);
//--- State of the context menu
   m_context_menu_state=false;
//--- Register the state in the previous node
   if(!m_free_context_menu)
      m_prev_node.ContextMenuState(false);
//--- Send a signal to restore the priorities of the left mouse click
   ::EventChartCustom(m_chart_id,ON_SET_PRIORITIES,0,0.0,"");
  }
//+------------------------------------------------------------------+
//| Redrawing                                                        |
//+------------------------------------------------------------------+
void CContextMenu::Reset(void)
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
void CContextMenu::Delete(void)
  {
//--- Removing objects  
   m_area.Delete();
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
      m_items[i].Delete();
//--- Removing separation lines
   int sep_total=::ArraySize(m_sep_line);
   for(int i=0; i<sep_total; i++)
      m_sep_line[i].Delete();
//--- Emptying the control arrays
   ::ArrayFree(m_items);
   ::ArrayFree(m_sep_line);
   ::ArrayFree(m_sep_line_index);
   ::ArrayFree(m_label_text);
   ::ArrayFree(m_path_bmp_on);
   ::ArrayFree(m_path_bmp_off);
//--- Emptying the array of the objects
   CElement::FreeObjectsArray();
//--- Initializing of variables by default values
   m_context_menu_state=false;
   CElement::MouseFocus(false);
   CElement::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Seth the priorities                                              |
//+------------------------------------------------------------------+
void CContextMenu::SetZorders(void)
  {
   m_area.Z_Order(m_area_zorder);
  }
//+------------------------------------------------------------------+
//| Reset the priorities                                             |
//+------------------------------------------------------------------+
void CContextMenu::ResetZorders(void)
  {
   m_area.Z_Order(0);
  }
//+------------------------------------------------------------------+
//| Reset the color of the element objects                           |
//+------------------------------------------------------------------+
void CContextMenu::ResetColors(void)
  {
//--- Iterate over all menu items
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
     {
      //--- Reset the color of the menu item
      m_items[i].ResetColors();
     }
  }
//+------------------------------------------------------------------+
//| Checking conditions for closing all context menus                |
//+------------------------------------------------------------------+
void CContextMenu::CheckHideContextMenus(void)
  {
//--- Leave, if the cursor is in the context menu area or in the previous node area
   if(CElement::MouseFocus() || m_prev_node.MouseFocus())
      return;
//--- If the cursor is outside of the area of these elements, then ...
//    ... a check is required if there are open context menus which were activated after that
//--- For that iterate over the list of this context menu ...
//    ... for identification if there is a menu item containing a context menu
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
     {
      //--- If there is such an item, check if its context menu is open.
      //    It this is open, do not send a signal for closing all context menus from this element as...
      //    ... it is possible that the cursor is in the area of the following one and this has to be checked.
      if(m_items[i].TypeMenuItem()==MI_HAS_CONTEXT_MENU)
         if(m_items[i].ContextMenuState())
            return;
     }
//--- Unblock the form
   m_wnd.IsLocked(false);
//--- Send a signal for hiding all context menus
   ::EventChartCustom(m_chart_id,ON_HIDE_CONTEXTMENUS,0,0,"");
  }
//+------------------------------------------------------------------+
//| Checking conditions for closing all context menus,               |
//| which were open after this one                                   |
//+------------------------------------------------------------------+
void CContextMenu::CheckHideBackContextMenus(void)
  {
//--- Iterate over all menu items
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
     {
      //--- If the item contains a context menu and this is enabled
      if(m_items[i].TypeMenuItem()==MI_HAS_CONTEXT_MENU && m_items[i].ContextMenuState())
        {
         //--- If the focus is in the context menu but not in this item
         if(CElement::MouseFocus() && !m_items[i].MouseFocus())
           {
            //--- Send a signal to hide all context menus which were open after this one
            ::EventChartCustom(m_chart_id,ON_HIDE_BACK_CONTEXTMENUS,CElement::Id(),0,"");
           }
        }
     }
  }
//+------------------------------------------------------------------+
//| Changing the object color when the cursor is hovering over it    |
//+------------------------------------------------------------------+
void CContextMenu::ChangeObjectsColor(void)
  {
//--- Leave, if the context menu is disabled
   if(!m_context_menu_state)
      return;
//--- Iterate over all menu items
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
     {
      //--- Change the color of the menu item
      m_items[i].ChangeObjectsColor();
     }
  }
//+------------------------------------------------------------------+
//| Handling clicking on the menu item                               |
//+------------------------------------------------------------------+
bool CContextMenu::OnClickMenuItem(const string clicked_object)
  {
//--- Leave, if this context menu has a previous node and is already open
   if(!m_free_context_menu && m_context_menu_state)
      return(true);
//--- Leave, if the pressing was not on the menu item
   if(::StringFind(clicked_object,CElement::ProgramName()+"_menuitem_",0)<0)
      return(false);
//--- Get the identifier and index from the object name
   int id    =CElement::IdFromObjectName(clicked_object);
   int index =CElement::IndexFromObjectName(clicked_object);
//--- If the context menu has a previous node
   if(!m_free_context_menu)
     {
      //--- Leave, if the pressing was not of the item to which this context menu is attached
      if(id!=m_prev_node.Id() || index!=m_prev_node.Index())
         return(false);
      //--- Show the context menu
      Show();
     }
//--- If this is a detached context menu
   else
     {
      //--- Find in a loop the menu item which was pressed
      int total=ItemsTotal();
      for(int i=0; i<total; i++)
        {
         if(m_items[i].Object(0).Name()!=clicked_object)
            continue;
         //--- Send a message about it
         ::EventChartCustom(m_chart_id,ON_CLICK_FREEMENU_ITEM,CElement::Id(),i,DescriptionByIndex(i));
         break;
        }
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Receiving a message from the menu item for handling              |
//+------------------------------------------------------------------+
void CContextMenu::ReceiveMessageFromMenuItem(const int id_item,const int index_item,const string message_item)
  {
//--- If there is an indication that the message was received from this program and the element id matches
   if(::StringFind(message_item,CElement::ProgramName(),0)>-1 && id_item==CElement::Id())
     {
      //--- If clicking was on the radio item
      if(::StringFind(message_item,"radioitem",0)>-1)
        {
         //--- Get the radio item id from the passed message
         int radio_id=RadioIdFromMessage(message_item);
         //--- Get the radio item index by the general index
         int radio_index=RadioIndexByItemIndex(index_item);
         //--- Switch the radio item
         SelectedRadioItem(radio_index,radio_id);
        }
      //--- Send a message about it
      ::EventChartCustom(m_chart_id,ON_CLICK_CONTEXTMENU_ITEM,id_item,index_item,DescriptionByIndex(index_item));
     }
//--- Hide the context menu
   Hide();
//--- Unblock the form
   m_wnd.IsLocked(false);
//--- Send a signal for hiding all context menus
   ::EventChartCustom(m_chart_id,ON_HIDE_CONTEXTMENUS,0,0,"");
  }
//+------------------------------------------------------------------+
//| Extracts the identifier from the message for the radio item      |
//+------------------------------------------------------------------+
int CContextMenu::RadioIdFromMessage(const string message)
  {
   ushort u_sep=0;
   string result[];
   int    array_size=0;
//--- Get the code of the separator
   u_sep=::StringGetCharacter("_",0);
//--- Split the string
   ::StringSplit(message,u_sep,result);
   array_size=::ArraySize(result);
//--- If the message structure differs from the expected one
   if(array_size!=3)
     {
      ::Print(__FUNCTION__," > Wrong structure in the message for the radio item! message: ",message);
      return(WRONG_VALUE);
     }
//--- Prevention of exceeding the array size
   if(array_size<3)
     {
      ::Print(PREVENTING_OUT_OF_RANGE);
      return(WRONG_VALUE);
     }
//--- Return the radio item id
   return((int)result[2]);
  }
//+------------------------------------------------------------------+
//| Returns the radio item index by the general index                |
//+------------------------------------------------------------------+
int CContextMenu::RadioIndexByItemIndex(const int index)
  {
   int radio_index=0;
//--- Get the radio item id by the general index
   int radio_id=RadioItemIdByIndex(index);
//--- Item counter from the required group
   int count_radio_id=0;
//--- Iterate over the list
   int items_total=ItemsTotal();
   for(int i=0; i<items_total; i++)
     {
      //--- If this is not a radio item, move to the next one
      if(m_items[i].TypeMenuItem()!=MI_RADIOBUTTON)
         continue;
      //--- If identifiers match
      if(m_items[i].RadioButtonID()==radio_id)
        {
         //--- If the indices match 
         //    store the current counter value and complete the loop
         if(m_items[i].Index()==index)
           {
            radio_index=count_radio_id;
            break;
           }
         //--- Increase the counter
         count_radio_id++;
        }
     }
//--- Return the index
   return(radio_index);
  }
//+------------------------------------------------------------------+
