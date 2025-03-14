//+------------------------------------------------------------------+
//|                                                        Enums.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Enumeration of the window types                                  |
//+------------------------------------------------------------------+
enum ENUM_WINDOW_TYPE
  {
   W_MAIN   =0,
   W_DIALOG =1
  };
//+------------------------------------------------------------------+
//| Enumeration of the pointer types                                 |
//+------------------------------------------------------------------+
enum ENUM_MOUSE_POINTER
  {
   MP_CUSTOM     =0,
   MP_X_RESIZE   =1,
   MP_Y_RESIZE   =2,
   MP_XY1_RESIZE =3,
   MP_XY2_RESIZE =4
  };
//+------------------------------------------------------------------+
//| Enumeration of left mouse button holding areas                   |
//+------------------------------------------------------------------+
enum ENUM_MOUSE_STATE
  {
   NOT_PRESSED           =0,
   PRESSED_INSIDE        =1,
   PRESSED_OUTSIDE       =2,
   PRESSED_INSIDE_HEADER =3
  };
//+------------------------------------------------------------------+
//| Enumeration of the menu item types                               |
//+------------------------------------------------------------------+
enum ENUM_TYPE_MENU_ITEM
  {
   MI_SIMPLE           =0,
   MI_CHECKBOX         =1,
   MI_RADIOBUTTON      =2,
   MI_HAS_CONTEXT_MENU =3
  };
//+------------------------------------------------------------------+
//| Enumeration of the separation line types                         |
//+------------------------------------------------------------------+
enum ENUM_TYPE_SEP_LINE
  {
   H_SEP_LINE =0,
   V_SEP_LINE =1
  };
//+------------------------------------------------------------------+
//| Enumeration of the menu attachment sides                         |
//+------------------------------------------------------------------+
enum ENUM_FIX_CONTEXT_MENU
  {
   FIX_RIGHT  =0,
   FIX_BOTTOM =1
  };
//+------------------------------------------------------------------+
//| Enumeration of the tabs positioning                              |
//+------------------------------------------------------------------+
enum ENUM_TABS_POSITION
  {
   TABS_TOP    =0, // Top
   TABS_BOTTOM =1, // Bottom
   TABS_LEFT   =2, // Left
   TABS_RIGHT  =3  // Right
  };
//+------------------------------------------------------------------+
//| Enumeration of the tree view item types                          |
//+------------------------------------------------------------------+
enum ENUM_TYPE_TREE_ITEM
  {
   TI_SIMPLE    =0,
   TI_HAS_ITEMS =1
  };
//+------------------------------------------------------------------+
//| Enumeration of the file navigator modes                          |
//+------------------------------------------------------------------+
enum ENUM_FILE_NAVIGATOR_MODE
  {
   FN_ALL          =0,
   FN_ONLY_FOLDERS =1
  };
//+------------------------------------------------------------------+
//| Enumeration of the file navigator content                        |
//+------------------------------------------------------------------+
enum ENUM_FILE_NAVIGATOR_CONTENT
  {
   FN_BOTH        =0,
   FN_ONLY_MQL    =1,
   FN_ONLY_COMMON =2
  };
//+------------------------------------------------------------------+
