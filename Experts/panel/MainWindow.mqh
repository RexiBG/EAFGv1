﻿//+------------------------------------------------------------------+
//|                                                   MainWindow.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Program.mqh"
//+------------------------------------------------------------------+
//| Creates a form for controls                                      |
//+------------------------------------------------------------------+
bool CProgram::CreateWindow(const string caption_text)
  {
//--- Add the window pointer to the window array
   CWndContainer::AddWindow(m_window);
//--- Size
   int x_size=600;
   int y_size=308;
//--- Coordinates
   int x=1;
   int y=1;
//--- Properties
   m_window.XSize(x_size);
   m_window.YSize(y_size);
   m_window.Movable(true);
   m_window.UseRollButton();
   m_window.AutoXResizeMode(false);
//--- Creating the form
   if(!m_window.CreateWindow(m_chart_id,m_subwin,caption_text,x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates the main menu                                            |
//+------------------------------------------------------------------+
bool CProgram::CreateMenuBar(const int x_gap,const int y_gap)
  {
//--- Three items in the main menu
#define MENUBAR_TOTAL 3
//--- Store the window pointer
   m_menubar.WindowPointer(m_window);
//--- Coordinates
   int x=m_window.X()+x_gap;
   int y=m_window.Y()+y_gap;
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
#resource "\\Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_black.bmp"
//---
bool CProgram::CreateMBContextMenu1(void)
  {
//--- Six items in a context menu
#define CONTEXTMENU_ITEMS1 3
//--- Store the window pointer
   m_mb_contextmenu1.WindowPointer(m_window);
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
   m_mb_contextmenu2.WindowPointer(m_window);
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
//--- Six items in a context menu
#define CONTEXTMENU_ITEMS3 5
//--- Store the window pointer
   m_mb_contextmenu3.WindowPointer(m_window);
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
   m_mb_contextmenu4.WindowPointer(m_window);
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
//| Creates the status bar                                           |
//+------------------------------------------------------------------+
bool CProgram::CreateStatusBar(const int x_gap,const int y_gap)
  {
#define STATUS_LABELS_TOTAL 3
//--- Store the window pointer
   m_status_bar.WindowPointer(m_window);
//--- Coordinates
   int x=m_window.X()+x_gap;
   int y=m_window.Y()+y_gap;
//--- Width
   int width[]={0,110,110};
//--- Set properties before creation
   m_status_bar.YSize(22);
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
   m_status_bar.ValueToItem(2,"Loading...");
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_status_bar);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create area with tabs                                            |
//+------------------------------------------------------------------+
bool CProgram::CreateTabs(const int x_gap,const int y_gap)
  {
#define TABS1_TOTAL 8
//--- Store the window pointer
   m_tabs.WindowPointer(m_window);
//--- Coordinates
   int x=m_window.X()+x_gap;
   int y=m_window.Y()+y_gap;
//--- Arrays with text and width for tabs
   string tabs_text[TABS1_TOTAL];
   for(int i=0; i<TABS1_TOTAL; i++)
     tabs_text[i]="Tab "+string(i+1);
//---
   int tabs_width[TABS1_TOTAL];
   ArrayInitialize(tabs_width,60);
//--- Set properties before creation
   m_tabs.YSize(243);
   m_tabs.TabYSize(20);
   m_tabs.PositionMode(TABS_TOP);
   m_tabs.AutoXResizeMode(true);
   m_tabs.AutoXResizeRightOffset(0);
   m_tabs.TabBorderColor(clrLightSteelBlue);
   m_tabs.SelectedTab((m_tabs.SelectedTab()==WRONG_VALUE) ? 0 : m_tabs.SelectedTab());
//--- Add tabs with the specified properties
   for(int i=0; i<TABS1_TOTAL; i++)
      m_tabs.AddTab(tabs_text[i],tabs_width[i]);
//--- Create control
   if(!m_tabs.CreateTabs(m_chart_id,m_subwin,x,y))
      return(false);
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_tabs);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates simple button 1                                          |
//+------------------------------------------------------------------+
bool CProgram::CreateSimpleButton1(const int x_gap,const int y_gap,string button_text)
  {
//--- Store the window pointer
   m_simple_button1.WindowPointer(m_window);
//--- Attach to the first tab
   m_tabs.AddToElementsArray(0,m_simple_button1);
//--- Coordinates
   int x=m_window.X()+x_gap;
   int y=m_window.Y()+y_gap;
//--- Set properties before creation
   m_simple_button1.ButtonXSize(140);
   m_simple_button1.BackColor(C'255,140,140');
   m_simple_button1.BackColorHover(C'255,180,180');
   m_simple_button1.BackColorPressed(C'255,120,120');
//--- Creating a button
   if(!m_simple_button1.CreateSimpleButton(m_chart_id,m_subwin,button_text,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_simple_button1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates simple button 2                                          |
//+------------------------------------------------------------------+
bool CProgram::CreateSimpleButton2(const int x_gap,const int y_gap,string button_text)
  {
//--- Store the window pointer
   m_simple_button2.WindowPointer(m_window);
//--- Attach to the first tab
   m_tabs.AddToElementsArray(0,m_simple_button2);
//--- Coordinates
   int x=m_window.X()+x_gap;
   int y=m_window.Y()+y_gap;
//--- Set properties before creation
   m_simple_button2.ButtonXSize(140);
   m_simple_button2.BackColor(C'140,200,240');
   m_simple_button2.BackColorHover(C'180,220,255');
   m_simple_button2.BackColorPressed(C'130,180,210');
//--- Creating a button
   if(!m_simple_button2.CreateSimpleButton(m_chart_id,m_subwin,button_text,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_simple_button2);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates simple button 3                                          |
//+------------------------------------------------------------------+
bool CProgram::CreateSimpleButton3(const int x_gap,const int y_gap,string button_text)
  {
//--- Store the window pointer
   m_simple_button3.WindowPointer(m_window);
//--- Attach to the first tab
   m_tabs.AddToElementsArray(0,m_simple_button3);
//--- Coordinates
   int x=m_window.X()+x_gap;
   int y=m_window.Y()+y_gap;
//--- Set properties before creation
   m_simple_button3.TwoState(true);
   m_simple_button3.ButtonXSize(283);
//--- Creating a button
   if(!m_simple_button3.CreateSimpleButton(m_chart_id,m_subwin,button_text,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_simple_button3);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates icon button 1                                            |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\coins_gray.bmp"
//---
bool CProgram::CreateIconButton1(const int x_gap,const int y_gap,const string button_text)
  {
//--- Store the window pointer
   m_icon_button1.WindowPointer(m_window);
//--- Attach to the first tab
   m_tabs.AddToElementsArray(0,m_icon_button1);
//--- Coordinates
   int x=m_window.X()+x_gap;
   int y=m_window.Y()+y_gap;
//--- Set properties before creation
   m_icon_button1.TwoState(false);
   m_icon_button1.ButtonXSize(140);
   m_icon_button1.ButtonYSize(22);
   m_icon_button1.IconFileOn("Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp");
   m_icon_button1.IconFileOff("Images\\EasyAndFastGUI\\Icons\\bmp16\\coins_gray.bmp");
//--- Create control
   if(!m_icon_button1.CreateIconButton(m_chart_id,m_subwin,button_text,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_icon_button1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates split button 1                                           |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\script.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\script_gray.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart_gray.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart_gray.bmp"
//---
bool CProgram::CreateSplitButton1(const int x_gap,const int y_gap,const string button_text)
  {
//--- Three items in the context menu
#define CONTEXTMENU_ITEMS5 3
//--- Pass the panel object
   m_split_button1.WindowPointer(m_window);
//--- Attach to the first tab
   m_tabs.AddToElementsArray(0,m_split_button1);
//--- Coordinates
   int x=m_window.X()+x_gap;
   int y=m_window.Y()+y_gap;
//--- Array of the menu item names
   string items_text[]=
     {
      "Item 1",
      "Item 2",
      "Item 3"
     };
//--- Array of icons for the available mode
   string items_bmp_on[]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart.bmp"
     };
//--- Array of icon for the blocked mode 
   string items_bmp_off[]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins_gray.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart_gray.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart_gray.bmp"
     };
//--- Set properties before creation
   m_split_button1.ButtonXSize(140);
   m_split_button1.ButtonYSize(22);
   m_split_button1.DropButtonXSize(16);
   m_split_button1.IconFileOn("Images\\EasyAndFastGUI\\Icons\\bmp16\\script.bmp");
   m_split_button1.IconFileOff("Images\\EasyAndFastGUI\\Icons\\bmp16\\script_gray.bmp");
//--- Get the pointer to the context menu of the button
   CContextMenu *cm=m_split_button1.GetContextMenuPointer();
//--- Add items to the context menu
   for(int i=0; i<CONTEXTMENU_ITEMS5; i++)
      m_split_button1.AddItem(items_text[i],items_bmp_on[i],items_bmp_off[i]);
//--- Separation line after the first menu item
   m_split_button1.AddSeparateLine(1);
//--- Create control
   if(!m_split_button1.CreateSplitButton(m_chart_id,m_subwin,button_text,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_split_button1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates a group of simple buttons                                |
//+------------------------------------------------------------------+
bool CProgram::CreateButtonsGroup1(const int x_gap,const int y_gap)
  {
//--- Store the window pointer
   m_buttons_group1.WindowPointer(m_window);
//--- Attach to the first tab
   m_tabs.AddToElementsArray(0,m_buttons_group1);
//--- Coordinates
   int x =m_window.X()+x_gap;
   int y =m_window.Y()+y_gap;
//--- Properties
   int    buttons_x_gap[] ={0,94,188};
   string buttons_text[]  ={"Button 1","Button 2","Button 3"};
   int    buttons_width[] ={96,96,95};
//--- Add three buttons to the group
   for(int i=0; i<3; i++)
      m_buttons_group1.AddButton(buttons_x_gap[i],0,buttons_text[i],buttons_width[i]);
//--- Create a group of buttons
   if(!m_buttons_group1.CreateButtonsGroup(m_chart_id,m_subwin,x,y))
      return(false);
//--- Highlight the second button in the group
   m_buttons_group1.SelectionButton(1);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_buttons_group1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates group of radio buttons 1                                 |
//+------------------------------------------------------------------+
bool CProgram::CreateRadioButtons1(const int x_gap,const int y_gap)
  {
//--- Store the window pointer
   m_radio_buttons1.WindowPointer(m_window);
//--- Attach to the first tab
   m_tabs.AddToElementsArray(0,m_radio_buttons1);
//--- Coordinates
   int x =m_window.X()+x_gap;
   int y =m_window.Y()+y_gap;
//--- Properties
   int    buttons_x_offset[] ={0,96,192};
   int    buttons_y_offset[] ={0,0,0};
   string buttons_text[]     ={"Radio Button 1","Radio Button 2","Radio Button 3"};
   int    buttons_width[]    ={92,92,92};
//---
   m_radio_buttons1.AreaColor(clrWhite);
//--- Add three buttons to the group
   for(int i=0; i<3; i++)
      m_radio_buttons1.AddButton(buttons_x_offset[i],buttons_y_offset[i],buttons_text[i],buttons_width[i]);
//--- Create a group of buttons
   if(!m_radio_buttons1.CreateRadioButtons(m_chart_id,m_subwin,x,y))
      return(false);
//--- Highlight the second button in the group
   m_radio_buttons1.SelectionRadioButton(2);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_radio_buttons1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates a group of icon buttons 1                                |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp64\\pie_chart.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp64\\pie_chart_gray.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp64\\safe.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp64\\safe_gray.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp64\\gold.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp64\\gold_gray.bmp"
//---
bool CProgram::CreateIconButtonsGroup1(const int x_gap,const int y_gap)
  {
//--- Store the window pointer
   m_icon_buttons_group1.WindowPointer(m_window);
//--- Attach to the first tab
   m_tabs.AddToElementsArray(0,m_icon_buttons_group1);
//--- Coordinates
   int x =m_window.X()+x_gap;
   int y =m_window.Y()+y_gap;
//--- Properties
   int    buttons_x_gap[] ={0,94,188};
   int    buttons_y_gap[] ={0,0,0};
   string buttons_text[]  ={"Icon button 1","Icon button 2","Icon button 3"};
   int    buttons_width[] ={96,96,95};
//--- Array of icons for the available mode
   string items_bmp_on[]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp64\\pie_chart.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp64\\safe.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp64\\gold.bmp"
     };
//--- Array of icon for the blocked mode 
   string items_bmp_off[]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp64\\pie_chart_gray.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp64\\safe_gray.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp64\\gold_gray.bmp"
     };
//--- Add three buttons to the group
   m_icon_buttons_group1.ButtonsYSize(84);
   m_icon_buttons_group1.IconXGap(16);
   m_icon_buttons_group1.IconYGap(5);
   m_icon_buttons_group1.LabelXGap(17);
   m_icon_buttons_group1.LabelYGap(69);
//--- Add three buttons to the group
   for(int i=0; i<3; i++)
      m_icon_buttons_group1.AddButton(buttons_x_gap[i],buttons_y_gap[i],buttons_text[i],
                                      buttons_width[i],items_bmp_on[i],items_bmp_off[i]);
//--- Create a group of buttons
   if(!m_icon_buttons_group1.CreateIconButtonsGroup(m_chart_id,m_subwin,x,y))
      return(false);
//--- Highlight the second button in the group
   m_icon_buttons_group1.SelectedRadioButton(0);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_icon_buttons_group1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates list view 1                                              |
//+------------------------------------------------------------------+
bool CProgram::CreateListView1(const int x_gap,const int y_gap)
  {
//--- Size of the list view
#define ITEMS_TOTAL5 50
//--- Store the window pointer
   m_listview1.WindowPointer(m_window);
//--- Attach to the first tab
   m_tabs.AddToElementsArray(0,m_listview1);
//--- Coordinates
   int x=m_window.X()+x_gap;
   int y=m_window.Y()+y_gap;
//--- Set properties before creation
   m_listview1.XSize(100);
   m_listview1.LightsHover(true);
   m_listview1.ListSize(ITEMS_TOTAL5);
   m_listview1.VisibleListSize(12);
   m_listview1.AreaBorderColor(C'150,170,180');
   m_listview1.SelectedItemByIndex(5);
//--- Get the scrollbar pointer
   CScrollV *sv=m_listview1.GetScrollVPointer();
//--- Properties of the scrollbar
   sv.ThumbBorderColor(C'190,190,190');
   sv.ThumbBorderColorHover(C'180,180,180');
   sv.ThumbBorderColorPressed(C'160,160,160');
//--- Filling the list view with data
   for(int r=0; r<ITEMS_TOTAL5; r++)
      m_listview1.ValueToList(r,"SYMBOL "+string(r));
//--- Create the list view
   if(!m_listview1.CreateListView(m_chart_id,m_subwin,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_listview1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create progress bar                                              |
//+------------------------------------------------------------------+
bool CProgram::CreateProgressBar(const int x_gap,const int y_gap)
  {
//--- Store pointer to the form
   m_progress_bar.WindowPointer(m_window);
//--- Coordinates
   int x=m_window.X()+x_gap;
   int y=m_window.Y()+y_gap;
//--- Set properties before creation
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
   m_progress_bar.AutoXResizeMode(true);
   m_progress_bar.AutoXResizeRightOffset(230);
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
//| Create text label table                                          |
//+------------------------------------------------------------------+
bool CProgram::CreateLabelsTable(const int x_gap,const int y_gap)
  {
#define COLUMNS1_TOTAL (21)
#define ROWS1_TOTAL    (100)
//--- Store pointer to the form
   m_labels_table.WindowPointer(m_window);
//--- Attach to the second tab
   m_tabs.AddToElementsArray(1,m_labels_table);
//--- Coordinates
   int x=m_window.X()+x_gap;
   int y=m_window.Y()+y_gap;
//--- The number of visible rows and columns
   int visible_columns_total =7;
   int visible_rows_total    =12;
//--- set properties
   m_labels_table.XOffset(45);
   m_labels_table.AreaColor(clrWhite);
   m_labels_table.ColumnXOffset(80);
   m_labels_table.FixFirstRow(true);
   m_labels_table.FixFirstColumn(true);
   m_labels_table.AutoXResizeMode(true);
   m_labels_table.AutoXResizeRightOffset(1);
   m_labels_table.TableSize(COLUMNS1_TOTAL,ROWS1_TOTAL);
   m_labels_table.VisibleTableSize(visible_columns_total,visible_rows_total);
//--- Create table
   if(!m_labels_table.CreateLabelsTable(m_chart_id,m_subwin,x,y))
      return(false);
//--- Populate the table:
//    The first cell is empty
   m_labels_table.SetValue(0,0,"-");
//--- Headers for columns
   for(int c=1; c<COLUMNS1_TOTAL; c++)
     {
      for(int r=0; r<1; r++)
         m_labels_table.SetValue(c,r,"SYMBOL "+string(c));
     }
//--- Headers for rows, text alignment mode - right
   for(int c=0; c<1; c++)
     {
      for(int r=1; r<ROWS1_TOTAL; r++)
         m_labels_table.SetValue(c,r,"PARAMETER "+string(r));
     }
//--- Data and formatting of the table (background color and cell color)
   for(int c=1; c<COLUMNS1_TOTAL; c++)
     {
      for(int r=1; r<ROWS1_TOTAL; r++)
         m_labels_table.SetValue(c,r,string(::rand()%1000-::rand()%1000));
     }
//--- Set the color of text in table cells
   for(int c=1; c<m_labels_table.ColumnsTotal(); c++)
      for(int r=1; r<m_labels_table.RowsTotal(); r++)
         m_labels_table.TextColor(c,r,((double)m_labels_table.GetValue(c,r)>=0) ? clrGreen : clrRed);
//--- Update the table
   m_labels_table.UpdateTable();
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_labels_table);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create a table                                                   |
//+------------------------------------------------------------------+
bool CProgram::CreateTable(const int x_gap,const int y_gap)
  {
#define COLUMNS2_TOTAL (100)
#define ROWS2_TOTAL    (1000)
//--- Store pointer to the form
   m_table.WindowPointer(m_window);
//--- Attach to the third tab
   m_tabs.AddToElementsArray(2,m_table);
//--- Coordinates
   int x=m_window.X()+x_gap;
   int y=m_window.Y()+y_gap;
//--- The number of visible rows and columns
   int visible_columns_total =10;
   int visible_rows_total    =12;
//--- Set properties before creation
   m_table.RowYSize(18);
   m_table.FixFirstRow(true);
   m_table.FixFirstColumn(true);
   m_table.LightsHover(true);
   m_table.SelectableRow(true);
   m_table.TextAlign(ALIGN_CENTER);
   m_table.HeadersColor(C'255,244,213');
   m_table.HeadersTextColor(clrBlack);
   m_table.CellColorHover(C'255,244,213');
   m_table.AutoXResizeMode(true);
   m_table.AutoXResizeRightOffset(1);
   m_table.TableSize(COLUMNS1_TOTAL,ROWS1_TOTAL);
   m_table.VisibleTableSize(visible_columns_total,visible_rows_total);
//--- Create control
   if(!m_table.CreateTable(m_chart_id,m_subwin,x,y))
      return(false);
//--- Populate the table:
//    The first cell is empty
   m_table.SetValue(0,0,"-");
//--- Headers for columns
   for(int c=1; c<COLUMNS1_TOTAL; c++)
     {
      for(int r=0; r<1; r++)
         m_table.SetValue(c,r,"SYMBOL "+string(c));
     }
//--- Headers for rows, text alignment mode - right
   for(int c=0; c<1; c++)
     {
      for(int r=1; r<ROWS1_TOTAL; r++)
        {
         m_table.SetValue(c,r,"PARAM. "+string(r));
         m_table.TextAlign(c,r,ALIGN_RIGHT);
        }
     }
//--- Data and formatting of the table (background color and cell color)
   for(int c=1; c<COLUMNS1_TOTAL; c++)
     {
      for(int r=1; r<ROWS1_TOTAL; r++)
        {
         m_table.SetValue(c,r,string(c)+":"+string(r));
         m_table.TextColor(c,r,(c%2==0)? clrRed : clrRoyalBlue);
         m_table.CellColor(c,r,(r%2==0)? clrWhiteSmoke : clrWhite);
        }
     }
//--- Update the table to display changes
   m_table.UpdateTable();
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_table);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create a rendered table                                          |
//+------------------------------------------------------------------+
bool CProgram::CreateCanvasTable(const int x_gap,const int y_gap)
  {
#define COLUMNS3_TOTAL 15
#define ROWS3_TOTAL    100
//--- Store pointer to the form
   m_canvas_table.WindowPointer(m_window);
//--- Attach to the fourth tab
   m_tabs.AddToElementsArray(3,m_canvas_table);
//--- Coordinates
   int x=m_window.X()+x_gap;
   int y=m_window.Y()+y_gap;
//--- The number of visible rows
   int visible_rows_total=9;
//--- Array of column widths
   int width[COLUMNS3_TOTAL];
   ::ArrayInitialize(width,70);
   width[0]=100;
   width[1]=90;
//--- Array of text alignment in columns
   ENUM_ALIGN_MODE align[COLUMNS3_TOTAL];
   ::ArrayInitialize(align,ALIGN_CENTER);
   align[0]=ALIGN_RIGHT;
   align[1]=ALIGN_RIGHT;
   align[2]=ALIGN_LEFT;
//--- Set properties before creation
   m_canvas_table.YSize(221);
   m_canvas_table.TableSize(COLUMNS3_TOTAL,ROWS3_TOTAL);
   m_canvas_table.TextAlign(align);
   m_canvas_table.ColumnsWidth(width);
   m_canvas_table.GridColor(clrLightGray);
   m_canvas_table.AutoXResizeMode(true);
   m_canvas_table.AutoXResizeRightOffset(1);
//--- Populate the table with data
   for(int c=0; c<COLUMNS3_TOTAL; c++)
      for(int r=0; r<ROWS3_TOTAL; r++)
         m_canvas_table.SetValue(c,r,string(c)+":"+string(r));
//--- Create control
   if(!m_canvas_table.CreateTable(m_chart_id,m_subwin,x,y))
      return(false);
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_canvas_table);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create a line chart                                              |
//+------------------------------------------------------------------+
bool CProgram::CreateLineChart(const int x_gap,const int y_gap)
  {
//--- Store the window pointer
   m_line_chart.WindowPointer(m_window);
//--- Attach to the fifth tab
   m_tabs.AddToElementsArray(4,m_line_chart);
//--- Coordinates
   int x=m_window.X()+x_gap;
   int y=m_window.Y()+y_gap;
//--- Set properties before creation
   m_line_chart.YSize(219);
   m_line_chart.BorderColor(clrSilver);
   m_line_chart.VScaleParams(2,-2,4);
   m_line_chart.MaxData(SERIES_TOTAL);
   m_line_chart.AutoXResizeMode(true);
   m_line_chart.AutoXResizeRightOffset(2);
//--- Create control
   if(!m_line_chart.CreateLineGraph(m_chart_id,m_subwin,x,y))
      return(false);
//--- (1) Set the sizes of arrays and (2) initialize them
   ResizeDataArrays();
   InitArrays();
//--- (1) Calculate and (2) add the series to the chart
   CalculateSeries();
   AddSeries();
//--- Calculate offsets from the chart borders
   CalculateYOffset();
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_line_chart);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates edit 1                                                   |
//+------------------------------------------------------------------+
bool CProgram::CreateSpinEdit1(const int x_gap,const int y_gap,string text)
  {
//--- Store the window pointer
   m_spin_edit1.WindowPointer(m_window);
//--- Attach to the sixth tab
   m_tabs.AddToElementsArray(5,m_spin_edit1);
//--- Coordinates
   int x=m_window.X()+x_gap;
   int y=m_window.Y()+y_gap;
//--- Value
   double v=(m_spin_edit1.GetValue()==WRONG_VALUE) ? 4 : m_spin_edit1.GetValue();
//--- Set properties before creation
   m_spin_edit1.XSize(115);
   m_spin_edit1.YSize(18);
   m_spin_edit1.EditXSize(40);
   m_spin_edit1.MaxValue(1000);
   m_spin_edit1.MinValue(-1000);
   m_spin_edit1.StepValue(1);
   m_spin_edit1.SetDigits(0);
   m_spin_edit1.SetValue(v);
   m_spin_edit1.ResetMode(true);
   m_spin_edit1.AreaColor(clrWhite);
//--- Create control
   if(!m_spin_edit1.CreateSpinEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_spin_edit1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates combobox 1                                               |
//+------------------------------------------------------------------+
bool CProgram::CreateComboBox1(const int x_gap,const int y_gap,const string text)
  {
//--- Total number of the list view items
#define ITEMS_TOTAL1 8
//--- Pass the panel object
   m_combobox1.WindowPointer(m_window);
//--- Attach to the sixth tab
   m_tabs.AddToElementsArray(5,m_combobox1);
//--- Coordinates
   int x=m_window.X()+x_gap;
   int y=m_window.Y()+y_gap;
//--- Array of the item values in the list view
   string items_text[ITEMS_TOTAL1]={"FALSE","item 1","item 2","item 3","item 4","item 5","item 6","item 7"};
//--- Set properties before creation
   m_combobox1.XSize(140);
   m_combobox1.YSize(18);
   m_combobox1.LabelText(text);
   m_combobox1.ButtonXSize(70);
   m_combobox1.ItemsTotal(ITEMS_TOTAL1);
   m_combobox1.VisibleItemsTotal(5);
   m_combobox1.AreaColor(clrWhite);
//--- Store the item values in the combobox list view
   for(int i=0; i<ITEMS_TOTAL1; i++)
      m_combobox1.ValueToList(i,items_text[i]);
//--- Get the list view pointer
   CListView *lv=m_combobox1.GetListViewPointer();
//--- Set the list view properties
   lv.LightsHover(true);
   lv.SelectedItemByIndex(lv.SelectedItemIndex()==WRONG_VALUE ? 2 : lv.SelectedItemIndex());
//--- Create control
   if(!m_combobox1.CreateComboBox(m_chart_id,m_subwin,x,y))
      return(false);
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_combobox1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates the tree view                                            |
//+------------------------------------------------------------------+
bool CProgram::CreateTreeView(const int x_gap,const int y_gap)
  {
//--- The number of items in the tree view
#define TREEVIEW_ITEMS 25
//--- Store the window pointer
   m_treeview.WindowPointer(m_window);
//--- Attach to the sixth tab
   m_tabs.AddToElementsArray(5,m_treeview);
//--- Coordinates
   int x=m_window.X()+x_gap;
   int y=m_window.Y()+y_gap;
//--- Form arrays for the tree view:
//    Item icons
#define A "Images\\EasyAndFastGUI\\Icons\\bmp16\\advisor.bmp"   // Expert
#define I "Images\\EasyAndFastGUI\\Icons\\bmp16\\indicator.bmp" // Indicator
#define S "Images\\EasyAndFastGUI\\Icons\\bmp16\\script.bmp"    // Script
   string path_bmp[TREEVIEW_ITEMS]=
     {A,I,I,I,I,I,I,I,I,S,S,S,S,S,S,S,S,S,S,S,S,S,S,A,A};
//--- Item description (displayed text)
   string item_text[TREEVIEW_ITEMS]=
     {"Advisor01","Indicators","01","02","03","04","05","06","07",
      "Scripts","01","02","03","04","05","06","07","08","09","10","11","12","13",
      "Advisor02","Advisor03"};
//--- Indices of the general list of the previous nodes
   int prev_node_list_index[TREEVIEW_ITEMS]=
     {-1,0,1,1,1,1,1,1,1,0,9,9,9,9,9,9,9,9,9,9,9,9,9,-1,-1};
//--- Indices of items in the local lists
   int item_index[TREEVIEW_ITEMS]=
     {0,0,0,1,2,3,4,5,6,1,0,1,2,3,4,5,6,7,8,9,10,11,12,1,2};
//--- Node level number
   int node_level[TREEVIEW_ITEMS]=
     {0,1,2,2,2,2,2,2,2,1,2,2,2,2,2,2,2,2,2,2,2,2,2,0,0};
//--- Local indices of items of the previous nodes
   int prev_node_item_index[TREEVIEW_ITEMS]=
     {-1,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,-1,-1};
//--- The number of items in the local lists
   int items_total[TREEVIEW_ITEMS]=
     {2,7,0,0,0,0,0,0,0,13,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
//--- State of the item list
   bool item_state[TREEVIEW_ITEMS]=
     {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
//--- Set properties before creation
   m_treeview.TreeViewAreaWidth(180);
   m_treeview.ContentAreaWidth(0);
   m_treeview.VisibleItemsTotal(10);
   m_treeview.LightsHover(true);
   m_treeview.ShowItemContent(true);
   m_treeview.ResizeListAreaMode(true);
   m_treeview.AutoXResizeMode(true);
   m_treeview.AutoXResizeRightOffset(2);
   m_treeview.SelectedItemIndex((m_treeview.SelectedItemIndex()==WRONG_VALUE) ? 4 : m_treeview.SelectedItemIndex());
//--- The properties of scrollbars
   m_treeview.GetScrollVPointer().AreaBorderColor(clrLightGray);
   m_treeview.GetContentScrollVPointer().AreaBorderColor(clrLightGray);
//--- Add items
   for(int i=0; i<TREEVIEW_ITEMS; i++)
      m_treeview.AddItem(i,prev_node_list_index[i],item_text[i],path_bmp[i],
                         item_index[i],node_level[i],prev_node_item_index[i],items_total[i],0,item_state[i],true);
//--- Create the tree view
   if(!m_treeview.CreateTreeView(m_chart_id,m_subwin,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_treeview);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates checkbox 1                                               |
//+------------------------------------------------------------------+
bool CProgram::CreateCheckBox1(const int x_gap,const int y_gap,string text)
  {
//--- Store the window pointer
   m_checkbox1.WindowPointer(m_window);
//--- Attach to the seventh tab
   m_tabs.AddToElementsArray(6,m_checkbox1);
//--- Coordinates
   int x=m_window.X()+x_gap;
   int y=m_window.Y()+y_gap;
//--- Set properties before creation
   m_checkbox1.XSize(90);
   m_checkbox1.YSize(18);
   m_checkbox1.AreaColor(clrWhite);
//--- Create control
   if(!m_checkbox1.CreateCheckBox(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_checkbox1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates checkbox 1                                               |
//+------------------------------------------------------------------+
bool CProgram::CreateCheckBoxEdit1(const int x_gap,const int y_gap,string text)
  {
//--- Store the window pointer
   m_checkboxedit1.WindowPointer(m_window);
//--- Attach to the seventh tab
   m_tabs.AddToElementsArray(6,m_checkboxedit1);
//--- Coordinates
   int x=m_window.X()+x_gap;
   int y=m_window.Y()+y_gap;
//--- Value
   double v=(m_checkboxedit1.GetValue()<0) ? ::rand()%1000 : m_checkboxedit1.GetValue();
//--- Set properties before creation
   m_checkboxedit1.XSize(170);
   m_checkboxedit1.YSize(18);
   m_checkboxedit1.EditXSize(45);
   m_checkboxedit1.MaxValue(1000);
   m_checkboxedit1.MinValue(1);
   m_checkboxedit1.StepValue(1);
   m_checkboxedit1.SetDigits(0);
   m_checkboxedit1.SetValue(v);
   m_checkboxedit1.AreaColor(clrWhite);
//--- Create control
   if(!m_checkboxedit1.CreateCheckBoxEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_checkboxedit1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates check-combo box 1                                        |
//+------------------------------------------------------------------+
bool CProgram::CreateCheckComboBox1(const int x_gap,const int y_gap,const string text)
  {
//--- Store the window pointer
   m_checkcombobox1.WindowPointer(m_window);
//--- Attach to the seventh tab
   m_tabs.AddToElementsArray(6,m_checkcombobox1);
//--- Coordinates
   int x=m_window.X()+x_gap;
   int y=m_window.Y()+y_gap;
//--- List view contents
   string m_tf[21];
   for(int i=0; i<21; i++)
     m_tf[i]="item "+string(i+1);
//--- Set properties before creation
   m_checkcombobox1.XSize(210);
   m_checkcombobox1.YSize(18);
   m_checkcombobox1.ButtonXSize(87);
   m_checkcombobox1.ItemsTotal(21);
   m_checkcombobox1.VisibleItemsTotal(5);
   m_checkcombobox1.AreaColor(clrWhite);
//--- List properties
   CListView *lv=m_checkcombobox1.GetListViewPointer();
   lv.LightsHover(true);
   lv.SelectedItemByIndex(lv.SelectedItemIndex()==WRONG_VALUE ? 4 : lv.SelectedItemIndex());
//--- Save the values to the list
   for(int i=0; i<21; i++)
      m_checkcombobox1.ValueToList(i,m_tf[i]);
//--- Create control
   if(!m_checkcombobox1.CreateCheckComboBox(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_checkcombobox1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create file navigator                                            |
//+------------------------------------------------------------------+
bool CProgram::CreateFileNavigator(const int x_gap,const int y_gap)
  {
//--- Store pointer to the form
   m_navigator.WindowPointer(m_window);
//--- Attach to the seventh tab
   m_tabs.AddToElementsArray(6,m_navigator);
//--- Coordinates
   int x=m_window.X()+x_gap;
   int y=m_window.Y()+y_gap;
//--- Set properties before creation
   m_navigator.TreeViewPointer().VisibleItemsTotal(9);
   m_navigator.NavigatorMode(FN_ONLY_FOLDERS);
   m_navigator.NavigatorContent(FN_ONLY_MQL);
   m_navigator.TreeViewAreaWidth(250);
   m_navigator.ContentAreaWidth(0);
   m_navigator.AddressBarYSize(19);
   m_navigator.AddressBarBackColor(clrWhite);
   m_navigator.AddressBarTextColor(clrSteelBlue);
   m_navigator.AutoXResizeMode(true);
   m_navigator.AutoXResizeRightOffset(2);
   m_navigator.TreeViewPointer().LightsHover(true);
//--- The properties of scrollbars
   m_navigator.TreeViewPointer().GetScrollVPointer().AreaBorderColor(clrLightGray);
   m_navigator.TreeViewPointer().GetContentScrollVPointer().AreaBorderColor(clrLightGray);
//--- Creating an element
   if(!m_navigator.CreateFileNavigator(m_chart_id,m_subwin,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_navigator);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create calendar 1                                                |
//+------------------------------------------------------------------+
bool CProgram::CreateCalendar1(const int x_gap,const int y_gap)
  {
//--- Pass the panel object
   m_calendar1.WindowPointer(m_window);
//--- Attach to the eighth tab
   m_tabs.AddToElementsArray(7,m_calendar1);
//--- Coordinates
   int x=m_window.X()+x_gap;
   int y=m_window.Y()+y_gap;
//--- Create control
   if(!m_calendar1.CreateCalendar(m_chart_id,m_subwin,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_calendar1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create drop down calendar 1                                      |
//+------------------------------------------------------------------+
bool CProgram::CreateDropCalendar1(const int x_gap,const int y_gap,const string text)
  {
//--- Pass the panel object
   m_drop_calendar1.WindowPointer(m_window);
//--- Attach to the eighth tab
   m_tabs.AddToElementsArray(7,m_drop_calendar1);
//--- Coordinates
   int x=m_window.X()+x_gap;
   int y=m_window.Y()+y_gap;
//--- Set properties before creation
   m_drop_calendar1.XSize(191);
   m_drop_calendar1.YSize(20);
   m_drop_calendar1.AreaBackColor(clrWhite);
//--- Create control
   if(!m_drop_calendar1.CreateDropCalendar(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_drop_calendar1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates slider 1                                                 |
//+------------------------------------------------------------------+
bool CProgram::CreateSlider1(const int x_gap,const int y_gap,const string text)
  {
//--- Store the window pointer
   m_slider1.WindowPointer(m_window);
//--- Attach to the eighth tab
   m_tabs.AddToElementsArray(7,m_slider1);
//--- Coordinates
   int x=m_window.X()+x_gap;
   int y=m_window.Y()+y_gap;
//--- Value
   double v=(m_slider1.GetValue()==WRONG_VALUE) ? -0.5 : m_slider1.GetValue();
//--- Set properties before creation
   m_slider1.XSize(190);
   m_slider1.YSize(40);
   m_slider1.EditXSize(87);
   m_slider1.MaxValue(1);
   m_slider1.StepValue(0.00001);
   m_slider1.MinValue(-1);
   m_slider1.SetDigits(5);
   m_slider1.SetValue(v);
   m_slider1.AreaColor(clrWhite);
   m_slider1.SlotLineLightColor(C'230,230,230');
//--- Create control
   if(!m_slider1.CreateSlider(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_slider1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates dual slider 1                                            |
//+------------------------------------------------------------------+
bool CProgram::CreateDualSlider1(const int x_gap,const int y_gap,const string text)
  {
//--- Store the window pointer
   m_dual_slider1.WindowPointer(m_window);
//--- Attach to the eighth tab
   m_tabs.AddToElementsArray(7,m_dual_slider1);
//--- Coordinates
   int x=m_window.X()+x_gap;
   int y=m_window.Y()+y_gap;
//--- Values
   double v1=(m_dual_slider1.GetLeftValue()==WRONG_VALUE) ? -1500 : m_dual_slider1.GetLeftValue();
   double v2=(m_dual_slider1.GetRightValue()==WRONG_VALUE) ? 50 : m_dual_slider1.GetRightValue();
//--- Set properties before creation
   m_dual_slider1.XSize(369);
   m_dual_slider1.YSize(40);
   m_dual_slider1.EditXSize(87);
   m_dual_slider1.MaxValue(1000);
   m_dual_slider1.StepValue(1);
   m_dual_slider1.MinValue(-2000);
   m_dual_slider1.SetDigits(0);
   m_dual_slider1.SetLeftValue(v1);
   m_dual_slider1.SetRightValue(v2);
   m_dual_slider1.AreaColor(clrWhite);
   m_dual_slider1.SlotLineLightColor(C'230,230,230');
//--- Create control
   if(!m_dual_slider1.CreateSlider(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_dual_slider1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates a separation line                                        |
//+------------------------------------------------------------------+
bool CProgram::CreateSepLine(const int x_gap,const int y_gap)
  {
//--- Store the window pointer
   m_sep_line.WindowPointer(m_window);
//--- Attach to the eighth tab
   m_tabs.AddToElementsArray(7,m_sep_line);
//--- Coordinates  
   int x=m_window.X()+x_gap;
   int y=m_window.Y()+y_gap;
//--- Size
   int x_size=190;
   int y_size=2;
//--- Set properties before creation
   m_sep_line.DarkColor(C'213,223,229');
   m_sep_line.LightColor(clrWhite);
   m_sep_line.TypeSepLine(H_SEP_LINE);
//--- Creating an element
   if(!m_sep_line.CreateSeparateLine(m_chart_id,m_subwin,0,x,y,x_size,y_size))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_sep_line);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create button to call the color picker 1                         |
//+------------------------------------------------------------------+
bool CProgram::CreateColorButton1(const int x_gap,const int y_gap,const string text)
  {
//--- Store the window pointer
   m_color_button1.WindowPointer(m_window);
//--- Attach to the eighth tab
   m_tabs.AddToElementsArray(7,m_color_button1);
//--- Coordinates
   int x=m_window.X()+x_gap;
   int y=m_window.Y()+y_gap;
//--- Set properties before creation
   m_color_button1.XSize(190);
   m_color_button1.YSize(18);
   m_color_button1.ButtonXSize(100);
   m_color_button1.ButtonYSize(18);
   m_color_button1.AreaColor(clrWhite);
   m_color_button1.CurrentColor(C'148,169,237');
//--- Create control
   if(!m_color_button1.CreateColorButton(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_color_button1);
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
   int x=(m_window2.X()>0) ? m_window2.X() : 1;
   int y=(m_window2.Y()>0) ? m_window2.Y() : 1;
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
bool CProgram::CreateColorPicker(const int x_gap,const int y_gap)
  {
//--- Store the window pointer
   m_color_picker.WindowPointer(m_window2);
//--- Coordinates
   int x=m_window2.X()+x_gap;
   int y=m_window2.Y()+y_gap;
//--- Creating an element
   if(!m_color_picker.CreateColorPicker(m_chart_id,m_subwin,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(1,m_color_picker);
   return(true);
  }
//+------------------------------------------------------------------+
