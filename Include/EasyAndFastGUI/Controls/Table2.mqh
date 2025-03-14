//+------------------------------------------------------------------+
//|                                                        Table.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Element.mqh"
#include "Window.mqh"
#include "Scrolls.mqh"


//+------------------------------------------------------------------+
//|                                                        Table.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
//#include "..\Element.mqh"
//#include "Pointer.mqh"
//#include "Scrolls.mqh"
//#include "TextEdit.mqh"
//#include "ComboBox.mqh"
//+------------------------------------------------------------------+
//| Класс для создания нарисованной таблицы                          |
//+------------------------------------------------------------------+
class CTable : public CElement
  {
private:
   //--- Объекты для создания таблицы
   CRectCanvas       m_headers;
   CRectCanvas       m_table;
   CScrollV          m_scrollv;
   CScrollH          m_scrollh;
   CTextEdit         m_edit;
   CComboBox         m_combobox;
   CPointer          m_column_resize;
   //--- Свойства ячеек таблицы
   struct CTCell
     {
      ENUM_TYPE_CELL    m_type;           // Тип ячейки
      CImage            m_images[];       // Массив изображений
      int               m_selected_image; // Индекс выбранной (отображаемой) картинки
      string            m_full_text;      // Полный текст
      string            m_short_text;     // Сокращённый текст
      string            m_value_list[];   // Массив значений (для ячеек с комбо-боксами)
      int               m_selected_item;  // Выбранный пункт в списке комбо-бокса
      color             m_text_color;     // Цвет текста
      color             m_back_color;     // Цвет фона
      uint              m_digits;         // Количество знаков после запятой
     };
   //--- Массив строк и свойства столбцов таблицы
   struct CTOptions
     {
      int               m_x;              // X-координата левого края столбца
      int               m_x2;             // X-координата правого края столбца
      int               m_width;          // Ширина столбца
      ENUM_DATATYPE     m_data_type;      // Тип данных в столбце
      ENUM_ALIGN_MODE   m_text_align;     // Способ выравнивания текста в ячейках столбца
      int               m_text_x_offset;  // Отступ текста
      int               m_image_x_offset; // Отступ картинки от X-края ячейки
      int               m_image_y_offset; // Отступ картинки от Y-края ячейки
      string            m_header_text;    // Текст заголовка столбца
      CTCell            m_rows[];         // Массив строк таблицы
     };
   CTOptions         m_columns[];
   //--- Массив свойств строк таблицы
   struct CTRowOptions
     {
      int               m_y;  // Y-координата верхнего края строки
      int               m_y2; // Y-координата нижнего края строки
     };
   CTRowOptions      m_rows[];
   //--- Количество строк и столбцов
   uint              m_rows_total;
   uint              m_columns_total;
   //--- Общий размер и размер видимой части таблицы
   int               m_table_x_size;
   int               m_table_y_size;
   int               m_table_visible_x_size;
   int               m_table_visible_y_size;
   //--- Наличие ячеек с полями ввода и комбо-боксами
   bool              m_edit_state;
   bool              m_combobox_state;
   //--- Индексы столбца и ряда последней редактированной ячейки
   int               m_last_edit_row_index;
   int               m_last_edit_column_index;
   //--- Минимальная ширина для столбцов
   int               m_min_column_width;
   //--- Значения по умолчанию: (1) ширина, (2) тип данных, (3) выравнивание текста
   int               m_default_width;
   ENUM_DATATYPE     m_default_type_data;
   ENUM_ALIGN_MODE   m_default_text_align;
   //--- Цвет сетки
   color             m_grid_color;
   //--- Режим показа заголовков таблицы
   bool              m_show_headers;
   //--- Размер (высота) заголовков
   int               m_header_y_size;
   //--- Цвет заголовков (фон) в разных состояниях
   color             m_headers_color;
   color             m_headers_color_hover;
   color             m_headers_color_pressed;
   //--- Цвет текста заголовков
   color             m_headers_text_color;
   //--- Ярлыки для признака отсортированных данных
   CImage            m_sort_arrows[];
   //--- Отступы для ярлыка-признака отсортированных данных
   int               m_sort_arrow_x_gap;
   int               m_sort_arrow_y_gap;
   //--- Размер (высота) ячеек
   int               m_cell_y_size;
   //--- Цвет ячеек в разных состояниях
   color             m_cell_color;
   color             m_cell_color_hover;
   //--- Цвет (1) фона и (2) текста выделенной строки
   color             m_selected_row_color;
   color             m_selected_row_text_color;
   //--- (1) Индекс и (2) текст выделенной строки
   int               m_selected_item;
   string            m_selected_item_text;
   //--- Индекс предыдущего выделенной строки
   int               m_prev_selected_item;
   //--- Отступ от границ разделительных линий для показа указателя мыши в режиме изменения ширины столбцов
   int               m_sep_x_offset;
   //--- Режим подсветки строки при наведении курсора мыши
   bool              m_lights_hover;
   //--- Режим сортируемых данных по столбцам
   bool              m_is_sort_mode;
   //--- Индекс отсортированного столбца (WRONG_VALUE - таблица не отсортирована)
   int               m_is_sorted_column_index;
   //--- Последнее направление сортировки
   ENUM_SORT_MODE    m_last_sort_direction;
   //--- Режим выделяемой строки
   bool              m_selectable_row;
   //--- Без отмены выделения строки при повторном нажатии
   bool              m_is_without_deselect;
   //--- Режим форматирования в стиле "Зебра"
   color             m_is_zebra_format_rows;
   //--- Состояние левой кнопки мыши (зажата/отжата)
   bool              m_mouse_state;
   //--- Счётчик таймера для перемотки списка
   int               m_timer_counter;
   //--- Для определения фокуса строки
   int               m_item_index_focus;
   //--- Для определение момента перехода курсора мыши с одной строки на другую
   int               m_prev_item_index_focus;
   //--- Для определение момента перехода курсора мыши с одного заголовка на другой
   int               m_prev_header_index_focus;
   //--- Авторазмер столбцов
   bool              m_autoresize_columns;
   //--- Режим изменения ширины столбцов
   bool              m_column_resize_mode;
   //--- Состояние захвата границы заголовка для изменения ширины столбца
   int               m_column_resize_control;
   //--- Вспомогательные поля для расчётов в изменении ширины столбцов
   int               m_column_resize_x_fixed;
   int               m_column_resize_prev_width;
   int               m_column_resize_prev_thumb;
   //--- Для определения индексов видимой части таблицы
   uint              m_visible_table_from_index;
   uint              m_visible_table_to_index;
   //--- Размер шага для смещения по горизонтали
   int               m_shift_x_step;
   //--- Ограничения на смещение
   int               m_shift_x2_limit;
   int               m_shift_y2_limit;
   //--- Отключение показа полос прокрутки
   bool              m_is_disabled_scrolls;
   //---
public:
                     CTable(void);
                    ~CTable(void);
   //--- Методы для создания таблицы
   bool              CreateTable(const int x_gap,const int y_gap);
   //---
private:
   void              InitializeProperties(const int x_gap,const int y_gap);
   bool              CreateCanvas(void);
   bool              CreateHeaders(void);
   bool              CreateTable(void);
   bool              CreateScrollV(void);
   bool              CreateScrollH(void);
   bool              CreateEdit(void);
   bool              CreateCombobox(void);
   bool              CreateColumnResizePointer(void);
   //---
public:
   //--- Возвращает указатели на элементы
   CScrollV         *GetScrollVPointer(void)                 { return(::GetPointer(m_scrollv));  }
   CScrollH         *GetScrollHPointer(void)                 { return(::GetPointer(m_scrollh));  }
   CTextEdit        *GetTextEditPointer(void)                { return(::GetPointer(m_edit));     }
   CComboBox        *GetComboboxPointer(void)                { return(::GetPointer(m_combobox)); }
   //--- Возвращает наличие элементов (поле ввода, комбо-бокс) в ячейках таблицы
   bool              HasEditElements(void)             const { return(m_edit_state);             }
   bool              HasComboboxElements(void)         const { return(m_combobox_state);         }
   //--- Цвет (1) сетки и (2) ячеек таблицы
   void              GridColor(const color clr)              { m_grid_color=clr;                 }
   void              CellColor(const color clr)              { m_cell_color=clr;                 }
   void              CellColorHover(const color clr)         { m_cell_color_hover=clr;           }
   //--- (1) Режим показа заголовков, высота (2) заголовков и (3) ячеек, (4) отключение полос прокрутки
   void              ShowHeaders(const bool flag)            { m_show_headers=flag;              }
   void              HeaderYSize(const int y_size)           { m_header_y_size=y_size;           }
   void              CellYSize(const int y_size)             { m_cell_y_size=y_size;             }
   void              IsDisabledScrolls(const bool flag)      { m_is_disabled_scrolls=flag;       }
   //--- Цвета (1) фона и (2) текста заголовков
   void              HeadersColor(const color clr)           { m_headers_color=clr;              }
   void              HeadersColorHover(const color clr)      { m_headers_color_hover=clr;        }
   void              HeadersColorPressed(const color clr)    { m_headers_color_pressed=clr;      }
   void              HeadersTextColor(const color clr)       { m_headers_text_color=clr;         }
   //--- Отступы для признака отсортированной таблицы
   void              SortArrowXGap(const int x_gap)          { m_sort_arrow_x_gap=x_gap;         }
   void              SortArrowYGap(const int y_gap)          { m_sort_arrow_y_gap=y_gap;         }
   //--- Установка картинок для признака отсортированных данных
   void              SortArrowFileAscend(const string path)  { m_sort_arrows[0].BmpPath(path);   }
   void              SortArrowFileDescend(const string path) { m_sort_arrows[1].BmpPath(path);   }
   //--- Возвращает общее количество (1) рядов и (2) столбцов, (3) количество строк видимой части таблицы
   uint              RowsTotal(void)                   const { return(m_rows_total);             }
   uint              ColumnsTotal(void)                const { return(m_columns_total);          }
   int               VisibleRowsTotal(void);
   //--- Возвращает (1) индекс и (2) текст выделенного ряда в таблице
   int               SelectedItem(void)                const { return(m_selected_item);          }
   string            SelectedItemText(void)            const { return(m_selected_item_text);     }
   //--- Режимы (1) подсветка строк при наведении курсора мыши, (2) режим сортируемых данных
   void              LightsHover(const bool flag)            { m_lights_hover=flag;              }
   void              IsSortMode(const bool flag)             { m_is_sort_mode=flag;              }
   //--- Режимы (1) выделение строки, (2) без отмены выделения при повторном нажатии
   void              SelectableRow(const bool flag)          { m_selectable_row=flag;            }
   void              IsWithoutDeselect(const bool flag)      { m_is_without_deselect=flag;       }
   //--- (1) Формат строк типа "Зебра", (2) режим изменения ширины столбцов, (3) режим "Авторазмер столбцов"
   void              IsZebraFormatRows(const color clr)      { m_is_zebra_format_rows=clr;       }
   void              ColumnResizeMode(const bool flag)       { m_column_resize_mode=flag;        }
   void              AutoResizeColumnsMode(const bool flag)  { m_autoresize_columns=flag;        }
   //--- Авторазмер столбцов
   void              AutoResizeColumns(void);
   //--- Процесс изменения ширины столбцов
   bool              ColumnResizeControl(void) const { return(m_column_resize_control!=WRONG_VALUE); }

   //--- Возвращает количество картинок в указанной ячейке
   int               ImagesTotal(const uint column_index,const uint row_index);
   //--- Минимальная ширина столбцов
   void              MinColumnWidth(const int width);
   //--- Значения по умолчанию: (1) ширина, (2) тип данных, (3) выравнивание текста
   void              DefaultWidth(const int width)                 { m_default_width      =width; }
   void              DefaultTypeData(const ENUM_DATATYPE type)     { m_default_type_data  =type;  }
   void              DefaultTextAlign(const ENUM_ALIGN_MODE align) { m_default_text_align =align; }
   //--- Устанавливает основной размер таблицы
   void              TableSize(const int columns_total,const int rows_total,const bool init=true);

   //--- Реконструкция таблицы
   void              Rebuilding(const int columns_total,const int rows_total,const bool redraw=false);
   //--- Добавляет столбец в таблицу по указанному индексу
   void              AddColumn(const int column_index,const bool redraw=false);
   //--- Удаляет столбец в таблице по указанному индексу
   void              DeleteColumn(const int column_index,const bool redraw=false);
   //--- Добавляет строку в таблицу по указанному индексу
   void              AddRow(const int row_index,const bool redraw=false);
   //--- Удаляет строку в таблице по указанному индексу
   void              DeleteRow(const int row_index,const bool redraw=false);
   //--- Удаляет все строки
   void              DeleteAllRows(const bool redraw=false);
   //--- Очищает таблицу. Остаётся только один столбец и одна строка.
   void              Clear(const bool redraw=false);

   //--- Установка текста в указанный заголовок
   void              SetHeaderText(const uint column_index,const string value);
   //--- Установка (1) режима выравнивания текста, (2) отступ текста в ячейке по оси X и (3) ширины для каждого столбца
   void              TextAlign(const ENUM_ALIGN_MODE &array[]);
   void              TextXOffset(const int &array[]);
   void              ColumnsWidth(const int &array[]);
   //--- Смещение картинок по X- и Y-осям
   void              ImageXOffset(const int &array[]);
   void              ImageYOffset(const int &array[]);
   //--- Установка/получение типа данных
   void              DataType(const uint column_index,const ENUM_DATATYPE type);
   ENUM_DATATYPE     DataType(const uint column_index);
   //--- Установка/получение типа ячейки
   void              CellType(const uint column_index,const uint row_index,const ENUM_TYPE_CELL type);
   ENUM_TYPE_CELL    CellType(const uint column_index,const uint row_index);
   //--- Устанавливает картинки в указанную ячейку
   void              SetImages(const uint column_index,const uint row_index,const string &bmp_file_path[]);
   //--- (1) Изменяет/получает (индекс) картинку в указанной ячейке, (2) возвращает индекс текущей картинки, (3) возвращает индекс выбранного пункта в списке комбо-бокса
   void              ChangeImage(const uint column_index,const uint row_index,const uint image_index,const bool redraw=false);
   int               SelectedImageIndex(const uint column_index,const uint row_index);
   int               SelectedComboboxItemIndex(const uint column_index,const uint row_index);
   //--- Устанавливает цвет текста в указанную ячейку таблицы
   void              TextColor(const uint column_index,const uint row_index,const color clr,const bool redraw=false);
   //--- Устанавливает цвет фона в указанную ячейку таблицы
   void              BackColor(const uint column_index,const uint row_index,const color clr,const bool redraw=false);
   //--- Устанавливает/получает значение в указанной ячейке таблицы
   void              SetValue(const uint column_index,const uint row_index,const string value="",const uint digits=0,const bool redraw=false);
   string            GetValue(const uint column_index,const uint row_index);
   //--- Выделение строки в таблице
   void              SelectRow(const int row_index);
   //--- Снятие выделения
   void              DeselectRow(void) { m_selected_item=WRONG_VALUE; }
   //--- Добавить список значений в комбо-бокс
   void              AddValueList(const uint column_index,const uint row_index,const string &array[],const uint selected_item=0);

   //--- Прокрутка таблицы: (1) вертикальная и (2) горизонтальная
   void              VerticalScrolling(const int pos=WRONG_VALUE);
   void              HorizontalScrolling(const int pos=WRONG_VALUE);
   //--- Смещение таблицы относительно позиций полос прокрутки
   void              ShiftTable(void);
   //--- Сортировать данные по указанному столбцу
   void              SortData(const uint column_index=0,const int direction=WRONG_VALUE);
   //--- (1) Текущее направление сортировки, (2) индекс отсортированного массива
   int               IsSortDirection(void)             const { return(m_last_sort_direction);    }
   int               IsSortedColumnIndex(void)         const { return(m_is_sorted_column_index); }
   //---
public:
   //--- Изменение положения таблицы по оси X
   void              MovingX(const int x_gap);
   //---
public:
   //--- Обработчик событий графика
   virtual void      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
   //--- Таймер
   virtual void      OnEventTimer(void);
   //--- Перемещение элемента
   virtual void      Moving(const bool only_visible=true);
   //--- Управление
   virtual void      Show(void);
   virtual void      Hide(void);
   virtual void      Delete(void);
   //--- (1) Установка, (2) сброс приоритетов на нажатие левой кнопки мыши
   virtual void      SetZorders(void);
   virtual void      ResetZorders(void);
   //--- Обновление элемента
   virtual void      Update(const bool redraw=false);
   //---
private:
   //--- Обработка нажатия на заголовке
   bool              OnClickHeaders(const string clicked_object);
   //--- Обработка нажатия на таблице
   bool              OnClickTable(const string clicked_object);
   //--- Обработка двойного нажатия на таблице
   bool              OnDoubleClickTable(const string clicked_object);
   //--- Обработка окончания ввода значения в ячейку
   bool              OnEndEditCell(const int id);
   //--- Обработка выбора пункта в выпадающем списке ячейки
   bool              OnClickComboboxItem(const int id);
   //--- Обработка выделения ряда
   bool              OnSelectRow(const int row_index);

   //--- Проверка элементов в ячейках на скрытие
   void              CheckAndHideEdit(void);
   void              CheckAndHideCombobox(void);

   //--- Возвращает индекс нажатой строки
   int               PressedRowIndex(void);
   //--- Возвращает индекс столбца нажатой ячейки
   int               PressedCellColumnIndex(void);

   //--- Проверяет, был ли задействован элемент в ячейке при нажатии
   bool              CheckCellElement(const int column_index,const int row_index,const bool double_click=false);
   //--- Проверяет, было ли нажатие на кнопке в ячейке
   bool              CheckPressedButton(const int column_index,const int row_index,const bool double_click=false);
   //--- Проверяет, было ли нажатие на чекбоксе в ячейке
   bool              CheckPressedCheckBox(const int column_index,const int row_index,const bool double_click=false);
   //--- Проверяет, было ли нажатие на ячейке с полем ввода
   bool              CheckPressedEdit(const int column_index,const int row_index,const bool double_click=false);
   //--- Проверяет, было ли нажатие на ячейке с комбо-боксом
   bool              CheckPressedCombobox(const int column_index,const int row_index,const bool double_click=false);
   //---
private:
   //--- Метод быстрой сортировки
   void              QuickSort(uint beg,uint end,uint column,const ENUM_SORT_MODE mode= SORT_ASCENDING);
   //--- Проверка условия сортировки
   bool              CheckSortCondition(uint column_index,uint row_index,const string check_value,const bool direction);
   //--- Поменять значения в указанных ячейках местами
   void              Swap(uint r1,uint r2);

   //--- Рассчитывает размеры таблицы
   void              CalculateTableSize(void);
   //--- Рассчитывают полный размер таблицы по оси X и Y
   void              CalculateTableXSize(void);
   void              CalculateTableYSize(void);
   //--- Рассчитывают видимый размер таблицы по оси X и Y
   void              CalculateTableVisibleXSize(void);
   void              CalculateTableVisibleYSize(void);

   //--- Изменить основные размеры таблицы
   void              ChangeMainSize(const int x_size,const int y_size);
   //--- Изменить размеры таблицы
   void              ChangeTableSize(void);
   //--- Изменить размеры полос прокрутки
   void              ChangeScrollsSize(void);
   //--- Определение индексов видимой области таблицы
   void              VisibleTableIndexes(void);
   //---
private:
   //--- Возвращает текст
   string            Text(const int column_index,const int row_index);
   //--- Возвращает X-координату текста в указанном столбце
   int               TextX(const int column_index,const bool headers=false);
   //--- Возвращает способ выравнивания текста в указанном столбце
   uint              TextAlign(const int column_index,const uint anchor);
   //--- Возвращает цвет текста ячейки
   uint              TextColor(const int column_index,const int row_index);
   //--- Возвращает цвет фона ячейки
   uint              BackColor(const int column_index,const int row_index);

   //--- Возвращает текущий цвет фона заголовка
   uint              HeaderColorCurrent(const bool is_header_focus);
   //--- Возвращает текущий цвет фона строки
   uint              RowColorCurrent(const int column_index,const int row_index,const bool is_row_focus);

   //--- Рисует элемент
   void              Draw(void);
   //--- Рисует таблицу с учётом последних внесённых изменений
   void              DrawTable(const bool only_visible=false);
   //--- Рисует заголовки таблицы
   void              DrawTableHeaders(void);
   //--- Рисует заголовки
   void              DrawHeaders(void);
   //--- Рисует сетку заголовков таблицы
   void              DrawHeadersGrid(void);
   //--- Рисует признак возможности сортировки таблицы
   void              DrawSignSortedData(void);
   //--- Рисует текст заголовков таблицы
   void              DrawHeadersText(void);

   //--- Рисует фон строк таблицы
   void              DrawRows(void);
   //--- Рисует выделенную строку
   void              DrawSelectedRow(void);
   //--- Рисует сетку
   void              DrawGrid(void);
   //--- Рисует все изображения таблицы
   void              DrawImages(void);
   //--- Рисует изображение в указанной ячейке
   void              DrawImage(const int column_index,const int row_index);
   //--- Рисует текст
   void              DrawText(void);

   //--- Перерисовывает указанную ячейку таблицы
   void              RedrawCell(const int column_index,const int row_index);
   //--- Рисует указанный ряд таблицы по указанному режиму
   void              DrawRow(int &indexes[],const int item_index,const int prev_item_index,const bool is_user=true);
   //--- Перерисовывает указанный ряд таблицы по указанному режиму
   void              RedrawRow(const bool is_selected_row=false);
   //---
private:
   //--- Проверка фокуса на заголовках
   void              CheckHeaderFocus(void);
   //--- Проверка фокуса на строках таблицы
   int               CheckRowFocus(void);
   //--- Проверка фокуса на границах заголовков для изменения их ширины
   void              CheckColumnResizeFocus(void);
   //--- Изменяет ширину захваченного столбца
   void              ChangeColumnWidth(void);

   //--- Проверяет размер переданного массива и возвращает скорректированное значение
   template<typename T>
   int               CheckArraySize(const T &array[]);
   //--- Проверить выход из диапазона столбцов
   bool              CheckOutOfColumnRange(const uint column_index);
   //--- Проверить выход из диапазона столбцов и строк
   virtual bool      CheckOutOfRange(const uint column_index,const uint row_index);
   //--- Расчёт с учётом последних изменений и изменение размеров таблицы
   void              RecalculateAndResizeTable(const bool redraw=false);

   //--- Инициализация указанного столбца значениями по умолчанию
   void              ColumnInitialize(const uint column_index);
   //--- Инициализация указанной ячейки значениями по умолчанию
   void              CellInitialize(const uint column_index,const uint row_index);

   //--- Делает копию указанного столбца (source) в новое место (dest.)
   void              ColumnCopy(const uint destination,const uint source);
   //--- Делает копию указанной ячейки (source) в новое место (dest.)
   void              CellCopy(const uint column_dest,const uint row_dest,const uint column_source,const uint row_source);
   //--- Копирует данные изображения из одного массива в другой
   void              ImageCopy(CImage &destination[],CImage &source[],const int index);
   //---
private:
   //--- Изменяет цвет объектов таблицы
   void              ChangeObjectsColor(void);
   //--- Изменяет цвет заголовков при наведении курсора мыши
   void              ChangeHeadersColor(void);
   //--- Изменение цвета строк при наведении курсора мыши
   void              ChangeRowsColor(void);

   //--- Возвращает откорректированный текст по ширине столбца
   string            CorrectingText(const int column_index,const int row_index,const bool headers=false);

   //--- Ускоренная перемотка таблицы
   void              FastSwitching(void);

   //--- Изменить ширину по правому краю окна
   virtual void      ChangeWidthByRightWindowSide(void);
   //--- Изменить высоту по нижнему краю окна
   virtual void      ChangeHeightByBottomWindowSide(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CTable::CTable(void) : m_rows_total(1),
                       m_columns_total(1),
                       m_edit_state(false),
                       m_combobox_state(false),
                       m_last_edit_row_index(WRONG_VALUE),
                       m_last_edit_column_index(WRONG_VALUE),
                       m_shift_x_step(10),
                       m_shift_x2_limit(0),
                       m_shift_y2_limit(0),
                       m_show_headers(false),
                       m_header_y_size(20),
                       m_cell_y_size(20),
                       m_default_text_align(ALIGN_CENTER),
                       m_default_width(100),
                       m_default_type_data(TYPE_STRING),
                       m_min_column_width(30),
                       m_grid_color(clrLightGray),
                       m_headers_color(C'255,244,213'),
                       m_headers_color_hover(C'229,241,251'),
                       m_headers_color_pressed(C'204,228,247'),
                       m_headers_text_color(clrBlack),
                       m_is_disabled_scrolls(false),
                       m_is_sort_mode(false),
                       m_last_sort_direction(SORT_ASCENDING),
                       m_is_sorted_column_index(WRONG_VALUE),
                       m_sort_arrow_x_gap(10),
                       m_sort_arrow_y_gap(8),
                       m_cell_color(clrWhite),
                       m_cell_color_hover(C'229,243,255'),
                       m_prev_selected_item(WRONG_VALUE),
                       m_selected_item(WRONG_VALUE),
                       m_selected_item_text(""),
                       m_sep_x_offset(5),
                       m_lights_hover(false),
                       m_selectable_row(false),
                       m_is_without_deselect(false),
                       m_autoresize_columns(false),
                       m_column_resize_mode(false),
                       m_column_resize_control(WRONG_VALUE),
                       m_column_resize_x_fixed(0),
                       m_column_resize_prev_width(0),
                       m_column_resize_prev_thumb(0),
                       m_item_index_focus(WRONG_VALUE),
                       m_prev_item_index_focus(WRONG_VALUE),
                       m_prev_header_index_focus(WRONG_VALUE),
                       m_selected_row_color(C'51,153,255'),
                       m_selected_row_text_color(clrWhite),
                       m_is_zebra_format_rows(clrNONE),
                       m_visible_table_from_index(WRONG_VALUE),
                       m_visible_table_to_index(WRONG_VALUE)
  {
//--- Сохраним имя класса элемента в базовом классе
   CElementBase::ClassName(CLASS_NAME);
//--- Цвет текста по умолчанию
   m_label_color=clrBlack;
//--- Установим размер таблицы
   TableSize(m_columns_total,m_rows_total);
//--- Инициализация структуры признака сортировки
   ::ArrayResize(m_sort_arrows,2);
   m_sort_arrows[0].BmpPath("");
   m_sort_arrows[1].BmpPath("");
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CTable::~CTable(void)
  {
  }
//+------------------------------------------------------------------+
//| Обработчик событий                                               |
//+------------------------------------------------------------------+
void CTable::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- Обработка события перемещения курсора
   if(id==CHARTEVENT_MOUSE_MOVE)
     {
      //--- Если полоса прокрутки в действии
      if(m_scrollv.ScrollBarControl())
        {
         ShiftTable();
         m_scrollv.Update(true);
         return;
        }
      //--- Если полоса прокрутки в действии
      if(m_scrollh.ScrollBarControl())
        {
         ShiftTable();
         m_scrollh.Update(true);
         return;
        }
      //--- Выйти, если полоса прокрутки активирована
      if(m_scrollh.State() || m_scrollv.State())
         return;
      //--- Проверка фокуса над элементами
      m_headers.MouseFocus(m_mouse.X()>m_headers.X() && m_mouse.X()<m_headers.X2() && 
                           m_mouse.Y()>m_headers.Y() && m_mouse.Y()<m_headers.Y2());
      m_table.MouseFocus(m_mouse.X()>m_table.X() && m_mouse.X()<m_table.X2() && 
                         m_mouse.Y()>m_table.Y() && m_mouse.Y()<m_table.Y2());
      //--- Изменение цвета объектов
      ChangeObjectsColor();
      //--- Изменить ширину захваченного столбца
      ChangeColumnWidth();
      return;
     }
//--- Обработка события колёсика мыши
   if(id==CHARTEVENT_MOUSE_WHEEL)
     {
      //--- Если курсор в таблице
      if(m_table.MouseFocus())
        {
         //--- Получим текущую позицию полосы прокрутки
         int pos=(m_scrollv.CurrentPos()-1<0)? 1 : m_scrollv.CurrentPos();
         //--- Если колёсико мыши сместилось вниз
         if(dparam<0)
            VerticalScrolling(pos+1);
         //--- Если колёсико мыши сместилось вверх
         else if(dparam>0)
            VerticalScrolling(pos-1);
         //--- Обновить полосу прокрутки
         m_scrollv.Update(true);
        }
      return;
     }
//--- Обработка нажатия на объектах
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      //--- Нажатие на заголовке
      if(OnClickHeaders(sparam))
         return;
      //--- Нажатие на таблице
      if(OnClickTable(sparam))
         return;
      //---
      return;
     }
//--- Обработка события окончания ввода
   if(id==CHARTEVENT_CUSTOM+ON_END_EDIT)
     {
      if(OnEndEditCell((int)lparam))
         return;
      //---
      return;
     }
//--- Обработка события выбора пункта в списке
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_COMBOBOX_ITEM)
     {
      if(OnClickComboboxItem((int)lparam))
         return;
      //---
      return;
     }
//--- Обработка события нажатия на кнопках полосы прокрутки
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_BUTTON)
     {
      //--- Выйти, если это нажатие на кнопке комбо-бокса
      if(m_combobox.CheckElementName(sparam))
         return;
      //--- Выйти, если это нажатие не на кнопке полосы прокрутки
      if(!m_scrollv.GetIncButtonPointer().CheckElementName(sparam))
         return;
      //--- Если было нажатие на кнопках вертикальной полосы прокрутки
      if(m_scrollv.OnClickScrollInc((uint)lparam,(uint)dparam) ||
         m_scrollv.OnClickScrollDec((uint)lparam,(uint)dparam))
        {
         //--- Сдвигает данные
         ShiftTable();
         m_scrollv.Update(true);
         return;
        }
      //--- Если было нажатие на кнопках горизонтальной полосы прокрутки списка
      if(m_scrollh.OnClickScrollInc((uint)lparam,(uint)dparam) ||
         m_scrollh.OnClickScrollDec((uint)lparam,(uint)dparam))
        {
         //--- Сдвигает данные
         ShiftTable();
         m_scrollh.Update(true);
         return;
        }
     }
//--- Изменение состояния левой кнопки мыши
   if(id==CHARTEVENT_CUSTOM+ON_CHANGE_MOUSE_LEFT_BUTTON)
     {
      //--- Проверка поля ввода  в ячейках на скрытие
      CheckAndHideEdit();
      //--- Проверка комбо-бокса в ячейках на скрытие
      CheckAndHideCombobox();
      //--- Выйти, если заголовки отключены
      if(!m_show_headers)
         return;
      //--- Если левая кнопка мыши отжата
      if(m_column_resize_control!=WRONG_VALUE && !m_mouse.LeftButtonState())
        {
         //--- Сбросить режим изменения ширины
         m_column_resize_control=WRONG_VALUE;
         //--- Перерисовать таблицу
         DrawTable();
         Update();
         //--- Скрыть указатель
         m_column_resize.Hide();
         //--- Отправим сообщение на определение доступных элементов
         ::EventChartCustom(m_chart_id,ON_SET_AVAILABLE,CElementBase::Id(),1,"");
         //--- Отправим сообщение об изменении в графическом интерфейсе
         ::EventChartCustom(m_chart_id,ON_CHANGE_GUI,CElementBase::Id(),0,"");
        }
      //--- Сбросить индекс последнего фокуса заголовка
      m_prev_header_index_focus=WRONG_VALUE;
      //--- Изменение цвета объектов
      ChangeObjectsColor();
      return;
     }
//--- Обработка двойного нажатия левой кнопки мыши
   if(id==CHARTEVENT_CUSTOM+ON_DOUBLE_CLICK)
     {
      //--- Выйти, если комбо-бокс есть и показан
      if(m_combobox_state && m_combobox.IsVisible())
         return;
      //--- Нажатие на таблице
      if(OnDoubleClickTable(sparam))
         return;
      //---
      return;
     }
  }
//+------------------------------------------------------------------+
//| Таймер                                                           |
//+------------------------------------------------------------------+
void CTable::OnEventTimer(void)
  {
//--- Ускоренная перемотка значений
   FastSwitching();
  }
//+------------------------------------------------------------------+
//| Создаёт нарисованную таблицу                                     |
//+------------------------------------------------------------------+
bool CTable::CreateTable(const int x_gap,const int y_gap)
  {
//--- Выйти, если нет указателя на главный элемент
   if(!CElement::CheckMainPointer())
      return(false);
//--- Инициализация свойств
   InitializeProperties(x_gap,y_gap);
//--- Рассчитаем размеры таблицы
   CalculateTableSize();
//--- Создание элемента
   if(!CreateCanvas())
      return(false);
   if(!CreateTable())
      return(false);
   if(!CreateHeaders())
      return(false);
   if(!CreateScrollV())
      return(false);
   if(!CreateScrollH())
      return(false);
   if(!CreateEdit())
      return(false);
   if(!CreateCombobox())
      return(false);
   if(!CreateColumnResizePointer())
      return(false);
//--- Изменить размеры таблицы
   ChangeTableSize();
   return(true);
  }
//+------------------------------------------------------------------+
//| Изменение положения таблицы по оси X                             |
//+------------------------------------------------------------------+
void CTable::MovingX(const int x_gap)
  {
   m_x=CElement::CalculateX(x_gap);
   CElementBase::XGap(x_gap);
//---
   m_canvas.X(m_x);
   m_canvas.XGap(CElement::CalculateXGap(m_x));
//---
   int x=m_x+1;
   m_table.X(x);
   m_table.XGap(CElement::CalculateXGap(x));
//---
   m_headers.X(x);
   m_headers.XGap(CElement::CalculateXGap(x));
//---
   CElement::Moving();
  }
//+------------------------------------------------------------------+
//| Инициализация свойств                                            |
//+------------------------------------------------------------------+
void CTable::InitializeProperties(const int x_gap,const int y_gap)
  {
   m_x        =CElement::CalculateX(x_gap);
   m_y        =CElement::CalculateY(y_gap);
   m_x_size   =(m_x_size<1 || m_auto_xresize_mode)? (m_anchor_right_window_side)? m_main.X2()-m_x-m_auto_xresize_right_offset : m_main.X2()-m_x-m_auto_xresize_right_offset : m_x_size;
   m_y_size   =(m_y_size<1 || m_auto_yresize_mode)? (m_anchor_bottom_window_side)? m_main.Y2()-m_y-m_auto_yresize_bottom_offset : m_main.Y2()-m_y-m_auto_yresize_bottom_offset : m_y_size;
//--- Свойства по умолчанию
   m_back_color          =(m_back_color!=clrNONE)? m_back_color : clrWhite;
   m_label_color         =(m_label_color!=clrNONE)? m_label_color : clrBlack;
   m_label_color_hover   =(m_label_color_hover!=clrNONE)? m_label_color_hover : clrBlack;
   m_label_color_pressed =(m_label_color_pressed!=clrNONE)? m_label_color_pressed : clrWhite;
   m_border_color        =(m_border_color!=clrNONE)? m_border_color : C'150,170,180';
   m_icon_x_gap          =(m_icon_x_gap>0)? m_icon_x_gap : 3;
   m_icon_y_gap          =(m_icon_y_gap>0)? m_icon_y_gap : 2;
   m_label_x_gap         =(m_label_x_gap>0)? m_label_x_gap : 5;
   m_label_y_gap         =(m_label_y_gap>0)? m_label_y_gap : 4;
//--- Отступы от крайней точки
   CElementBase::XGap(x_gap);
   CElementBase::YGap(y_gap);
  }
//+------------------------------------------------------------------+
//| Создаёт фон для таблицы                                          |
//+------------------------------------------------------------------+
bool CTable::CreateCanvas(void)
  {
//--- Формирование имени объекта
   string name=CElementBase::ElementName("table");
//--- Создание объекта
   if(!CElement::CreateCanvas(name,m_x,m_y,m_x_size,m_y_size))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт таблицу                                                  |
//+------------------------------------------------------------------+
bool CTable::CreateTable(void)
  {
//--- Формирование имени объекта
   string name=CElementBase::ProgramName()+"_"+"table_grid"+"_"+(string)CElementBase::Id();
//--- Координаты
   int x =m_x+1;
   int y =m_y+((m_show_headers)? m_header_y_size : 1);
//--- Создание объекта
   ::ResetLastError();
   if(!m_table.CreateBitmapLabel(m_chart_id,m_subwin,name,x,y,m_table_x_size,m_header_y_size,COLOR_FORMAT_ARGB_NORMALIZE))
     {
      ::Print(__FUNCTION__," > Не удалось создать холст для рисования таблицы: ",::GetLastError());
      return(false);
     }
//--- Получим указатель на базовый класс
   if(!m_table.Attach(m_chart_id,name,COLOR_FORMAT_ARGB_NORMALIZE))
     {
      ::Print(__FUNCTION__," > Не удалось присоединить холст для рисования к графику: ",::GetLastError());
      return(false);
     }
//--- Свойства
   ::ObjectSetInteger(m_chart_id,m_table.ChartObjectName(),OBJPROP_ZORDER,m_zorder+1);
   ::ObjectSetString(m_chart_id,m_table.ChartObjectName(),OBJPROP_TOOLTIP,"\n");
//--- Координаты
   m_table.X(x);
   m_table.Y(y);
//--- Сохраним размеры
   m_table.XSize(m_table_visible_x_size);
   m_table.YSize(m_table_visible_y_size);
//--- Отступы от крайней точки панели
   m_table.XGap(CElement::CalculateXGap(x));
   m_table.YGap(CElement::CalculateYGap(y));
//--- Установим размеры видимой области
   ::ObjectSetInteger(m_chart_id,m_table.ChartObjectName(),OBJPROP_XSIZE,m_table_visible_x_size);
   ::ObjectSetInteger(m_chart_id,m_table.ChartObjectName(),OBJPROP_YSIZE,m_table_visible_y_size);
//--- Зададим смещение фрейма внутри изображения по осям X и Y
   ::ObjectSetInteger(m_chart_id,m_table.ChartObjectName(),OBJPROP_XOFFSET,0);
   ::ObjectSetInteger(m_chart_id,m_table.ChartObjectName(),OBJPROP_YOFFSET,0);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт заголовки таблицы                                        |
//+------------------------------------------------------------------+
bool CTable::CreateHeaders(void)
  {
//--- Выйти, если заголовки отключены
   if(!m_show_headers)
      return(true);
//--- Формирование имени объекта
   string name=CElementBase::ProgramName()+"_"+"table_headers"+"_"+(string)CElementBase::Id();
//--- Координаты
   int x =m_x+1;
   int y =m_y+1;
//--- Определим картинки, как признак возможности сортировки таблицы
   ::ArrayResize(m_sort_arrows,2);
   if(m_sort_arrows[0].BmpPath()=="")
      m_sort_arrows[0].BmpPath("Images\\EasyAndFastGUI\\Controls\\spin_inc.bmp");
   if(m_sort_arrows[1].BmpPath()=="")
      m_sort_arrows[1].BmpPath("Images\\EasyAndFastGUI\\Controls\\spin_dec.bmp");
//--- Сохранить картинки в массивы
   for(int i=0; i<2; i++)
      m_sort_arrows[i].ReadImageData(m_sort_arrows[i].BmpPath());
//--- Создание объекта
   ::ResetLastError();
   if(!m_headers.CreateBitmapLabel(m_chart_id,m_subwin,name,x,y,m_table_x_size,m_header_y_size,COLOR_FORMAT_ARGB_NORMALIZE))
     {
      ::Print(__FUNCTION__," > Не удалось создать холст для рисования заголовков таблицы: ",::GetLastError());
      return(false);
     }
//--- Получим указатель на базовый класс
   if(!m_headers.Attach(m_chart_id,name,COLOR_FORMAT_ARGB_NORMALIZE))
     {
      ::Print(__FUNCTION__," > Не удалось присоединить холст для рисования к графику: ",::GetLastError());
      return(false);
     }
//--- Свойства
   ::ObjectSetInteger(m_chart_id,m_headers.ChartObjectName(),OBJPROP_ZORDER,m_zorder+1);
   ::ObjectSetString(m_chart_id,m_headers.ChartObjectName(),OBJPROP_TOOLTIP,"\n");
//--- Координаты
   m_headers.X(x);
   m_headers.Y(y);
//--- Сохраним размеры
   m_headers.XSize(m_table_visible_x_size);
   m_headers.YSize(m_header_y_size);
//--- Отступы от крайней точки панели
   m_headers.XGap(CElement::CalculateXGap(x));
   m_headers.YGap(CElement::CalculateYGap(y));
//--- Установим размеры видимой области
   ::ObjectSetInteger(m_chart_id,m_headers.ChartObjectName(),OBJPROP_XSIZE,m_table_visible_x_size);
   ::ObjectSetInteger(m_chart_id,m_headers.ChartObjectName(),OBJPROP_YSIZE,m_header_y_size);
//--- Зададим смещение фрейма внутри изображения по осям X и Y
   ::ObjectSetInteger(m_chart_id,m_headers.ChartObjectName(),OBJPROP_XOFFSET,0);
   ::ObjectSetInteger(m_chart_id,m_headers.ChartObjectName(),OBJPROP_YOFFSET,0);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт вертикальный скролл                                      |
//+------------------------------------------------------------------+
bool CTable::CreateScrollV(void)
  {
//--- Сохранить указатель родителя
   m_scrollv.MainPointer(this);
//--- Координаты
   int x=16,y=1;
//--- Свойства
   m_scrollv.Index(0);
   m_scrollv.XSize(15);
   m_scrollv.YSize(CElementBase::YSize()-2);
   m_scrollv.AnchorRightWindowSide(true);
   m_scrollv.Alpha(m_alpha);
//--- Расчёт количества шагов для смещения
   uint rows_total         =RowsTotal();
   uint visible_rows_total =VisibleRowsTotal();
//--- Создание полосы прокрутки
   if(!m_scrollv.CreateScroll(x,y,rows_total,visible_rows_total))
      return(false);
//--- Скрыть, если сейчас не нужна
   if(!m_scrollv.IsScroll() || m_is_disabled_scrolls)
      m_scrollv.Hide();
//--- Добавить элемент в массив
   CElement::AddToArray(m_scrollv);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт горизонтальный скролл                                    |
//+------------------------------------------------------------------+
bool CTable::CreateScrollH(void)
  {
//--- Сохранить указатель на главный элемент
   m_scrollh.MainPointer(this);
//--- Координаты
   int x=1,y=16;
//--- Свойства
   m_scrollh.Index(1);
   m_scrollh.XSize(CElementBase::XSize()-2);
   m_scrollh.YSize(15);
   m_scrollh.AnchorBottomWindowSide(true);
   m_scrollh.Alpha(m_alpha);
//--- Расчёт количества шагов для смещения
   uint x_size_total         =m_table_x_size/m_shift_x_step;
   uint visible_x_size_total =m_table_visible_x_size/m_shift_x_step;
//--- Создание полосы прокрутки
   if(!m_scrollh.CreateScroll(x,y,x_size_total,visible_x_size_total))
      return(false);
//--- Скрыть, если сейчас не нужна
   if(!m_scrollh.IsScroll() || m_is_disabled_scrolls)
      m_scrollh.Hide();
//--- Добавить элемент в массив
   CElement::AddToArray(m_scrollh);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт поле ввода                                               |
//+------------------------------------------------------------------+
bool CTable::CreateEdit(void)
  {
//--- Если нет ячеек с полем ввода
   if(!m_edit_state)
      return(true);
//--- Сохраним указатель на главный элемент
   m_edit.MainPointer(this);
//--- Координаты
   int x=-1,y=0;
//--- Свойства
   m_edit.Alpha(0);
   m_edit.XSize(50);
   m_edit.YSize(21);
   m_edit.SetValue("");
   m_edit.GetTextBoxPointer().XGap(1);
   m_edit.GetTextBoxPointer().XSize(50);
   m_edit.GetTextBoxPointer().TextYOffset(4);
   m_edit.GetTextBoxPointer().AutoSelectionMode(true);
//--- Создадим элемент управления
   if(!m_edit.CreateTextEdit("",x,y))
      return(false);
//--- Скрыть
   m_edit.Hide();
//--- Добавить элемент в массив
   CElement::AddToArray(m_edit);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт комбо-бокс                                               |
//+------------------------------------------------------------------+
bool CTable::CreateCombobox(void)
  {
//--- Если нет ячеек с комбо-боксом
   if(!m_combobox_state)
      return(true);
//--- Сохраним указатель на главный элемент
   m_combobox.MainPointer(this);
//--- Координаты
   int x=-1,y=0;
//--- Свойства
   m_combobox.Alpha(0);
   m_combobox.XSize(50);
   m_combobox.YSize(21);
   m_combobox.ItemsTotal(5);
   m_combobox.GetButtonPointer().XGap(1);
   m_combobox.GetButtonPointer().LabelYGap(4);
   m_combobox.GetButtonPointer().IconYGap(3);
   m_combobox.IsDropdown(CElementBase::IsDropdown());
//--- Получим указатель на список
   CListView *lv=m_combobox.GetListViewPointer();
//--- Установим свойства списка
   lv.YSize(93);
   lv.LightsHover(true);
   lv.GetScrollVPointer().Index(2);
//--- Занесём значения в список
   for(int i=0; i<5; i++)
      m_combobox.SetValue(i,(string)i);
//--- Выделим в списке первый пункт
   m_combobox.SelectItem(0);
//--- Создадим элемент управления
   if(!m_combobox.CreateComboBox("",x,y))
      return(false);
//--- Скрыть
   m_combobox.Hide();
//--- Добавить элемент в массив
   CElement::AddToArray(m_combobox);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт указатель курсора изменения ширины столбцов              |
//+------------------------------------------------------------------+
bool CTable::CreateColumnResizePointer(void)
  {
//--- Выйти, если режим изменения ширины столбцов отключен
   if(!m_column_resize_mode)
     {
      m_column_resize.State(false);
      m_column_resize.IsVisible(false);
      return(true);
     }
//--- Свойства
   m_column_resize.XGap(13);
   m_column_resize.YGap(14);
   m_column_resize.XSize(20);
   m_column_resize.YSize(20);
   m_column_resize.Id(CElementBase::Id());
   m_column_resize.Type(MP_X_RESIZE_RELATIVE);
//--- Создание элемента
   if(!m_column_resize.CreatePointer(m_chart_id,m_subwin))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Возвращает количество видимых строк                              |
//+------------------------------------------------------------------+
int CTable::VisibleRowsTotal(void)
  {
   double visible_rows_total =m_table_visible_y_size/m_cell_y_size;
   double check_y_size       =visible_rows_total*m_cell_y_size;
   visible_rows_total=(check_y_size<m_table_visible_y_size-1)? visible_rows_total-1 : visible_rows_total;
   return((int)visible_rows_total);
  }
//+------------------------------------------------------------------+
//| Возвращает количество картинок в указанной ячейке                |
//+------------------------------------------------------------------+
int CTable::ImagesTotal(const uint column_index,const uint row_index)
  {
//--- Проверка на выход из диапазона
   if(!CheckOutOfRange(column_index,row_index))
      return(WRONG_VALUE);
//--- Вернём размер массива картинок
   return(::ArraySize(m_columns[column_index].m_rows[row_index].m_images));
  }
//+------------------------------------------------------------------+
//| Минимальная ширина столбцов                                      |
//+------------------------------------------------------------------+
void CTable::MinColumnWidth(const int width)
  {
//--- Ширина столбца не менее 3-ёх пикселей
   m_min_column_width=(width>3)? width : 3;
  }
//+------------------------------------------------------------------+
//| Устанавливает размер таблицы                                     |
//+------------------------------------------------------------------+
void CTable::TableSize(const int columns_total,const int rows_total,const bool init=true)
  {
//--- Должно быть не менее одного столбца
   m_columns_total=(columns_total<1)? 1 : columns_total;
//--- Должно быть не менее двух рядов
   m_rows_total=(rows_total<1)? 1 : rows_total;
//--- Установить размер массивам рядов, столбцов и заголовков
   ::ArrayResize(m_rows,m_rows_total);
   ::ArrayResize(m_columns,m_columns_total);
//--- Выйти, если не нужна инициализация по умолчанию
   if(!init)
      return;
//--- Установить размер массивам таблицы
   for(uint c=0; c<m_columns_total; c++)
     {
      ::ArrayResize(m_columns[c].m_rows,m_rows_total);
      //--- Инициализация свойств столбцов значениями по умолчанию
      ColumnInitialize(c);
      //--- Инициализация свойств ячеек
      for(uint r=0; r<m_rows_total; r++)
         CellInitialize(c,r);
     }
  }
//+------------------------------------------------------------------+
//| Реконструкция таблицы                                            |
//+------------------------------------------------------------------+
void CTable::Rebuilding(const int columns_total,const int rows_total,const bool redraw=false)
  {
//--- Установить новый размер
   TableSize(columns_total,rows_total);
//--- Рассчитать и установить новые размеры таблицы
   RecalculateAndResizeTable(redraw);
  }
//+------------------------------------------------------------------+
//| Добавляет столбец в таблицу по указанному индексу                |
//+------------------------------------------------------------------+
void CTable::AddColumn(const int column_index,const bool redraw=false)
  {
//--- Увеличим размер массива на один элемент
   int array_size=(int)ColumnsTotal();
   m_columns_total=array_size+1;
   ::ArrayResize(m_columns,m_columns_total);
//--- Установить размер массивам рядов
   ::ArrayResize(m_columns[array_size].m_rows,m_rows_total);
//--- Корректировка индекса в случае выхода из диапазона
   int checked_column_index=(column_index>=(int)m_columns_total)?(int)m_columns_total-1 : column_index;
//--- Сместить другие столбцы (двигаемся от конца массива к индексу добавляемого столбца)
   for(int c=array_size; c>=checked_column_index; c--)
     {
      //--- Сместить признак отсортированного массива
      if(c==m_is_sorted_column_index && m_is_sorted_column_index!=WRONG_VALUE)
         m_is_sorted_column_index++;
      //--- Индекс предыдущего столбца
      int prev_c=c-1;
      //--- В новом столбце инициализация значениями по умолчанию
      if(c==checked_column_index)
         ColumnInitialize(c);
      //--- Перемещаем данные из предыдущего столбца в текущий
      else
         ColumnCopy(c,prev_c);
      //---
      for(uint r=0; r<m_rows_total; r++)
        {
         //--- Инициализация ячеек нового столбца значениями по умолчанию
         if(c==checked_column_index)
           {
            CellInitialize(c,r);
            continue;
           }
         //--- Перемещаем данные из ячейки предыдущего столбца в ячейку текущего
         CellCopy(c,r,prev_c,r);
        }
     }
//--- Рассчитать и установить новые размеры таблицы
   RecalculateAndResizeTable(redraw);
  }
//+------------------------------------------------------------------+
//| Удаляет столбец в таблице по указанному индексу                  |
//+------------------------------------------------------------------+
void CTable::DeleteColumn(const int column_index,const bool redraw=false)
  {
//--- Получим размер массива столбцов
   int array_size=(int)ColumnsTotal();
//--- Выйти, если остался только один столбец
   if(array_size<2)
      return;
//--- Корректировка индекса в случае выхода из диапазона
   int checked_column_index=(column_index>=array_size)? array_size-1 : column_index;
//--- Сместить другие столбцы (двигаемся от указанного индекса до последнего столбца)
   for(int c=checked_column_index; c<array_size-1; c++)
     {
      //--- Сместить признак отсортированного массива
      if(c!=checked_column_index)
        {
         if(c==m_is_sorted_column_index && m_is_sorted_column_index!=WRONG_VALUE)
            m_is_sorted_column_index--;
        }
      //--- Обнулить, если удалён отсортированный столбец
      else
         m_is_sorted_column_index=WRONG_VALUE;
      //--- Индекс следующего столбца
      int next_c=c+1;
      //--- Перемещаем данные из следующего столбца в текущий
      ColumnCopy(c,next_c);
      //--- Перемещаем данные из ячеек следующего столбца в ячейки текущего
      for(uint r=0; r<m_rows_total; r++)
         CellCopy(c,r,next_c,r);
     }
//--- Уменьшим массив столбцов на один элемент
   m_columns_total=array_size-1;
   ::ArrayResize(m_columns,m_columns_total);
//--- Рассчитать и установить новые размеры таблицы
   RecalculateAndResizeTable(redraw);
  }
//+------------------------------------------------------------------+
//| Добавляет строку в таблицу по указанному индексу                 |
//+------------------------------------------------------------------+
void CTable::AddRow(const int row_index,const bool redraw=false)
  {
//--- Увеличим размер массива на один элемент
   int array_size=(int)RowsTotal();
   m_rows_total=array_size+1;
//--- Установить размер массивам рядов
   for(uint i=0; i<m_columns_total; i++)
     {
      ::ArrayResize(m_rows,m_rows_total,100000);
      ::ArrayResize(m_columns[i].m_rows,m_rows_total,100000);
     }
//--- Корректировка индекса в случае выхода из диапазона
   int checked_row_index=(row_index>=(int)m_rows_total)?(int)m_rows_total-1 : row_index;
//--- Сместить другие строки (двигаемся от конца массива к индексу добавляемой строки)
   for(int c=0; c<(int)m_columns_total; c++)
     {
      for(int r=array_size; r>=checked_row_index; r--)
        {
         //--- Инициализация ячейки новой строки значениями по умолчанию
         if(r==checked_row_index)
           {
            CellInitialize(c,r);
            continue;
           }
         //--- Индекс предыдущей строки
         uint prev_r=r-1;
         //--- Перемещаем данные из ячейки предыдущей строки в ячейку текущей
         CellCopy(c,r,c,prev_r);
        }
     }
//--- Рассчитать и установить новые размеры таблицы
   if(redraw)
      RecalculateAndResizeTable(redraw);
  }
//+------------------------------------------------------------------+
//| Удаляет строку в таблице по указанному индексу                   |
//+------------------------------------------------------------------+
void CTable::DeleteRow(const int row_index,const bool redraw=false)
  {
//--- Получим размер массива строк
   int array_size=(int)RowsTotal();
//--- Выйти, если осталась только одна строка
   if(array_size<2)
      return;
//--- Корректировка индекса в случае выхода из диапазона
   int checked_row_index=(row_index>=(int)m_rows_total)?(int)m_rows_total-1 : row_index;
//--- Сместить другие строки (двигаемся от указанного индекса к последней строке)
   for(int c=0; c<(int)m_columns_total; c++)
     {
      for(int r=checked_row_index; r<array_size-1; r++)
        {
         //--- Индекс следующей строки
         uint next_r=r+1;
         //--- Перемещаем данные из ячейки следующей строки в ячейку текущей
         CellCopy(c,r,c,next_r);
        }
     }
//--- Уменьшим размер массива строк на один элемент
   m_rows_total=array_size-1;
//--- Установить размер массивам рядов
   for(uint i=0; i<m_columns_total; i++)
     {
      ::ArrayResize(m_rows,m_rows_total);
      ::ArrayResize(m_columns[i].m_rows,m_rows_total);
     }
//--- Рассчитать и установить новые размеры таблицы
   RecalculateAndResizeTable(redraw);
  }
//+------------------------------------------------------------------+
//| Удаляет все строки                                               |
//+------------------------------------------------------------------+
void CTable::DeleteAllRows(const bool redraw=false)
  {
//--- Установить размерность
   TableSize(m_columns_total,1,false);
//--- Очистить ячейки
   for(uint i=0; i<m_columns_total; i++)
     {
      m_columns[i].m_data_type=TYPE_STRING;
      SetValue(i,0,"");
      BackColor(i,0,clrWhite);
     }
//--- Установить значения по умолчанию
   m_selected_item_text     ="";
   m_selected_item          =WRONG_VALUE;
   m_last_sort_direction    =SORT_ASCENDING;
   m_is_sorted_column_index =WRONG_VALUE;
//--- Рассчитать и установить новые размеры таблицы
   RecalculateAndResizeTable(redraw);
  }
//+------------------------------------------------------------------+
//| Очищает таблицу. Остаётся только один столбец и одна строка.     |
//+------------------------------------------------------------------+
void CTable::Clear(const bool redraw=false)
  {
//--- Установить минимальный размер 1x1
   TableSize(1,1);
//--- Установить значения по умолчанию
   m_selected_item_text     ="";
   m_selected_item          =WRONG_VALUE;
   m_last_sort_direction    =SORT_ASCENDING;
   m_is_sorted_column_index =WRONG_VALUE;
//--- Рассчитать и установить новые размеры таблицы
   RecalculateAndResizeTable(redraw);
  }
//+------------------------------------------------------------------+
//| Заполняет массив заголовков по указанному индексу                |
//+------------------------------------------------------------------+
void CTable::SetHeaderText(const uint column_index,const string value)
  {
//--- Проверка на выход из диапазона столбцов
   if(!CheckOutOfColumnRange(column_index))
      return;
//--- Установить значение в массив
   m_columns[column_index].m_header_text=value;
  }
//+------------------------------------------------------------------+
//| Заполняет массив режимом выравнивания текста                     |
//+------------------------------------------------------------------+
void CTable::TextAlign(const ENUM_ALIGN_MODE &array[])
  {
   int total=0;
//--- Выйти, если передан массив нулевого размера
   if((total=CheckArraySize(array))==WRONG_VALUE)
      return;
//--- Сохранить значения в структуре
   for(int c=0; c<total; c++)
      m_columns[c].m_text_align=array[c];
  }
//+------------------------------------------------------------------+
//| Заполняет массив отступа текста в ячейке по оси X                |
//+------------------------------------------------------------------+
void CTable::TextXOffset(const int &array[])
  {
   int total=0;
//--- Выйти, если передан массив нулевого размера
   if((total=CheckArraySize(array))==WRONG_VALUE)
      return;
//--- Сохранить значения в структуре
   for(int c=0; c<total; c++)
      m_columns[c].m_text_x_offset=array[c];
  }
//+------------------------------------------------------------------+
//| Заполняет массив ширины столбцов                                 |
//+------------------------------------------------------------------+
void CTable::ColumnsWidth(const int &array[])
  {
   int total=0;
//--- Выйти, если передан массив нулевого размера
   if((total=CheckArraySize(array))==WRONG_VALUE)
      return;
//--- Сохранить значения в структуре
   for(int c=0; c<total; c++)
      m_columns[c].m_width=array[c];
  }
//+------------------------------------------------------------------+
//| Отступы картинок от краёв ячеек по оси X                         |
//+------------------------------------------------------------------+
void CTable::ImageXOffset(const int &array[])
  {
   int total=0;
//--- Выйти, если передан массив нулевого размера
   if((total=CheckArraySize(array))==WRONG_VALUE)
      return;
//--- Сохранить значения в структуре
   for(int c=0; c<total; c++)
      m_columns[c].m_image_x_offset=array[c];
  }
//+------------------------------------------------------------------+
//| Отступы картинок от краёв ячеек по оси Y                         |
//+------------------------------------------------------------------+
void CTable::ImageYOffset(const int &array[])
  {
   int total=0;
//--- Выйти, если передан массив нулевого размера
   if((total=CheckArraySize(array))==WRONG_VALUE)
      return;
//--- Сохранить значения в структуре
   for(int c=0; c<total; c++)
      m_columns[c].m_image_y_offset=array[c];
  }
//+------------------------------------------------------------------+
//| Установка типа данных в указанном столбце                        |
//+------------------------------------------------------------------+
void CTable::DataType(const uint column_index,const ENUM_DATATYPE type)
  {
//--- Проверка на выход из диапазона столбцов
   if(!CheckOutOfColumnRange(column_index))
      return;
//--- Установить тип данных для указанного столбца
   m_columns[column_index].m_data_type=type;
  }
//+------------------------------------------------------------------+
//| Получение типа данных в указанном столбце                        |
//+------------------------------------------------------------------+
ENUM_DATATYPE CTable::DataType(const uint column_index)
  {
//--- Проверка на выход из диапазона столбцов
   if(!CheckOutOfColumnRange(column_index))
      return(WRONG_VALUE);
//--- Вернуть тип данных для указанного столбца
   return(m_columns[column_index].m_data_type);
  }
//+------------------------------------------------------------------+
//| Устанавливает тип ячейки                                         |
//+------------------------------------------------------------------+
void CTable::CellType(const uint column_index,const uint row_index,const ENUM_TYPE_CELL type)
  {
//--- Проверка на выход из диапазона
   if(!CheckOutOfRange(column_index,row_index))
      return;
//--- Установить тип ячейки
   m_columns[column_index].m_rows[row_index].m_type=type;
//--- Признак наличия поля ввода
   if(type==CELL_EDIT && !m_edit_state)
      m_edit_state=true;
//--- Признак наличия комбо-бокса
   else if(type==CELL_COMBOBOX && !m_combobox_state)
      m_combobox_state=true;
  }
//+------------------------------------------------------------------+
//| Получение типа ячейки                                            |
//+------------------------------------------------------------------+
ENUM_TYPE_CELL CTable::CellType(const uint column_index,const uint row_index)
  {
//--- Проверка на выход из диапазона
   if(!CheckOutOfRange(column_index,row_index))
      return(WRONG_VALUE);
//--- Вернуть тип данных для указанного столбца
   return(m_columns[column_index].m_rows[row_index].m_type);
  }
//+------------------------------------------------------------------+
//| Устанавливает картинки в указанную ячейку                        |
//+------------------------------------------------------------------+
void CTable::SetImages(const uint column_index,const uint row_index,const string &bmp_file_path[])
  {
//--- Проверка на выход из диапазона
   if(!CheckOutOfRange(column_index,row_index))
      return;
//--- Выйти, если передан массив нулевого размера
   int total=0;
   if((total=::ArraySize(bmp_file_path))<1)
      return;
//--- Установить новый размер массивам
   ::ArrayResize(m_columns[column_index].m_rows[row_index].m_images,total);
//---
   for(int i=0; i<total; i++)
     {
      //--- По умолчанию выбрана первая картинка массива
      m_columns[column_index].m_rows[row_index].m_selected_image=0;
      //--- Записать переданную картинку в массив и запомнить её размеры
      if(!m_columns[column_index].m_rows[row_index].m_images[i].ReadImageData(bmp_file_path[i]))
         return;
     }
  }
//+------------------------------------------------------------------+
//| Изменяет картинку в указанной ячейке                             |
//+------------------------------------------------------------------+
void CTable::ChangeImage(const uint column_index,const uint row_index,const uint image_index,const bool redraw=false)
  {
//--- Проверка на выход из диапазона
   if(!CheckOutOfRange(column_index,row_index))
      return;
//--- Получим количество картинок ячейки
   int images_total=ImagesTotal(column_index,row_index);
//--- Выйти, если (1) картинок нет или (2) выходим из диапазона
   if(images_total==WRONG_VALUE || image_index>=(uint)images_total)
      return;
//--- Выйти, если указанная картинка совпадает с выбранной
   if(image_index==m_columns[column_index].m_rows[row_index].m_selected_image)
      return;
//--- Сохранить индекс выбранной картинки ячейки
   m_columns[column_index].m_rows[row_index].m_selected_image=(int)image_index;
//--- Перерисовать ячейку, если указано
   if(redraw)
      RedrawCell(column_index,row_index);
  }
//+------------------------------------------------------------------+
//| Возвращает индекс картинки в указанной ячейке                    |
//+------------------------------------------------------------------+
int CTable::SelectedImageIndex(const uint column_index,const uint row_index)
  {
//--- Проверка на выход из диапазона
   if(!CheckOutOfRange(column_index,row_index))
      return(WRONG_VALUE);
//--- Вернуть значение
   return(m_columns[column_index].m_rows[row_index].m_selected_image);
  }
//+------------------------------------------------------------------+
//| Возвращает индекс выбранного пункта                              |
//| в списке комбо-бокса в указанной ячейке                          |
//+------------------------------------------------------------------+
int CTable::SelectedComboboxItemIndex(const uint column_index,const uint row_index)
  {
//--- Проверка на выход из диапазона
   if(!CheckOutOfRange(column_index,row_index))
      return(WRONG_VALUE);
//--- Вернуть значение
   return(m_columns[column_index].m_rows[row_index].m_selected_item);
  }
//+------------------------------------------------------------------+
//| Устанавливает цвет текста в указанную ячейку таблицы             |
//+------------------------------------------------------------------+
void CTable::TextColor(const uint column_index,const uint row_index,const color clr,const bool redraw=false)
  {
//--- Проверка на выход из диапазона
   if(!CheckOutOfRange(column_index,row_index))
      return;
//--- Установить цвет текста в общий массив
   m_columns[column_index].m_rows[row_index].m_text_color=clr;
//--- Перерисовать ячейку, если указано
   if(redraw)
      RedrawCell(column_index,row_index);
  }
//+------------------------------------------------------------------+
//| Устанавливает цвет фона в указанную ячейку таблицы               |
//+------------------------------------------------------------------+
void CTable::BackColor(const uint column_index,const uint row_index,const color clr,const bool redraw=false)
  {
//--- Проверка на выход из диапазона
   if(!CheckOutOfRange(column_index,row_index))
      return;
//--- Установить цвет текста в общий массив
   m_columns[column_index].m_rows[row_index].m_back_color=clr;
//--- Перерисовать ячейку, если указано
   if(redraw)
      RedrawCell(column_index,row_index);
  }
//+------------------------------------------------------------------+
//| Заполняет массив по указанным индексам                           |
//+------------------------------------------------------------------+
void CTable::SetValue(const uint column_index,const uint row_index,const string value="",const uint digits=0,const bool redraw=false)
  {
//--- Проверка на выход из диапазона
   if(!CheckOutOfRange(column_index,row_index))
      return;
//--- Установить значение в массив:
//    Строковое
   if(m_columns[column_index].m_data_type==TYPE_STRING)
      m_columns[column_index].m_rows[row_index].m_full_text=value;
//--- Вещественное
   else if(m_columns[column_index].m_data_type==TYPE_DOUBLE)
     {
      m_columns[column_index].m_rows[row_index].m_digits=digits;
      double type_value=::StringToDouble(value);
      m_columns[column_index].m_rows[row_index].m_full_text=::DoubleToString(type_value,digits);
     }
//--- Время
   else if(m_columns[column_index].m_data_type==TYPE_DATETIME)
     {
      datetime type_value=::StringToTime(value);
      m_columns[column_index].m_rows[row_index].m_full_text=::TimeToString(type_value);
     }
//--- Любой другой тип будет установлен, как строка
   else
      m_columns[column_index].m_rows[row_index].m_full_text=value;
//--- Скорректировать и сохранить текст, если не помещается в ячейке
   m_columns[column_index].m_rows[row_index].m_short_text=CorrectingText(column_index,row_index);
//--- Перерисовать ячейку, если указано
   if(redraw)
      RedrawCell(column_index,row_index);
  }
//+------------------------------------------------------------------+
//| Возвращает значение по указанным индексам                        |
//+------------------------------------------------------------------+
string CTable::GetValue(const uint column_index,const uint row_index)
  {
//--- Проверка на выход из диапазона
   if(!CheckOutOfRange(column_index,row_index))
      return("");
//--- Вернуть значение
   return(m_columns[column_index].m_rows[row_index].m_full_text);
  }
//+------------------------------------------------------------------+
//| Выделение указанной строки в таблице                             |
//+------------------------------------------------------------------+
void CTable::SelectRow(const int row_index)
  {
//--- Проверка на выход из диапазона
   if(!CheckOutOfRange(0,(uint)row_index))
      return;
//--- Если такая строка уже выделена
   if(m_selected_item==row_index)
      return;
//--- Текущий и предыдущий индексы строк
   m_prev_selected_item =(m_selected_item==WRONG_VALUE)? row_index : m_selected_item;
   m_selected_item      =row_index;
//--- Массив для значений в определённой последовательности
   int indexes[2];
//--- Если здесь в первый раз
   if(m_prev_selected_item==WRONG_VALUE)
      indexes[0]=m_selected_item;
   else
     {
      indexes[0] =(m_selected_item>m_prev_selected_item)? m_prev_selected_item : m_selected_item;
      indexes[1] =(m_selected_item>m_prev_selected_item)? m_selected_item : m_prev_selected_item;
     }
//--- Рисует указанный ряд таблицы по указанному режиму
   DrawRow(indexes,m_selected_item,m_prev_selected_item,false);
//--- Получить индексы на границах видимой области
   VisibleTableIndexes();
//--- Переместить полосу прокрутки на указанную строку
   if(row_index==0)
     {
      VerticalScrolling(0);
     }
   else if((uint)row_index>=m_rows_total-1)
     {
      VerticalScrolling(WRONG_VALUE);
     }
   else if(row_index<(int)m_visible_table_from_index)
     {
      VerticalScrolling(m_scrollv.CurrentPos()-1);
     }
   else if(row_index>=(int)m_visible_table_to_index-1)
     {
      VerticalScrolling(m_scrollv.CurrentPos()+1);
     }
  }
//+------------------------------------------------------------------+
//| Добавить список значений в комбо-бокс                            |
//+------------------------------------------------------------------+
void CTable::AddValueList(const uint column_index,const uint row_index,const string &array[],const uint selected_item=0)
  {
//--- Проверка на выход из диапазона
   if(!CheckOutOfRange(column_index,row_index))
      return;
//--- Установим размер списку указанной ячейки
   uint total=::ArraySize(array);
   ::ArrayResize(m_columns[column_index].m_rows[row_index].m_value_list,total);
//--- Сохраним переданные значения
   ::ArrayCopy(m_columns[column_index].m_rows[row_index].m_value_list,array);
//--- Проверка индекса выбранного пункта в списке
   uint check_item_index=(selected_item>=total)? total-1 : selected_item;
//--- Сохранить выбранный пункт в списке
   m_columns[column_index].m_rows[row_index].m_selected_item=(int)check_item_index;
//--- Сохранить текст выбранного пункта в ячейке
   m_columns[column_index].m_rows[row_index].m_full_text=array[check_item_index];
  }
//+------------------------------------------------------------------+
//| Горизонтальная прокрутка поля ввода                              |
//+------------------------------------------------------------------+
void CTable::HorizontalScrolling(const int pos=WRONG_VALUE)
  {
//--- Для определения позиции ползунка
   int index=0;
//--- Индекс последней позиции
   int last_pos_index=int(m_table_x_size-m_table_visible_x_size);
//--- Корректировка в случае выхода из диапазона
   if(pos<0)
      index=last_pos_index;
   else
      index=(pos>last_pos_index)? last_pos_index : pos;
//--- Сдвигаем ползунок полосы прокрутки
   m_scrollh.MovingThumb(index);
//--- Сдвигаем поле ввода
   ShiftTable();
  }
//+------------------------------------------------------------------+
//| Вертикальная прокрутка поля ввода                                |
//+------------------------------------------------------------------+
void CTable::VerticalScrolling(const int pos=WRONG_VALUE)
  {
//--- Для определения позиции ползунка
   int index=0;
//--- Индекс последней позиции
   int last_pos_index=int(m_table_y_size-m_table_visible_y_size);
//--- Корректировка в случае выхода из диапазона
   if(pos<0)
      index=last_pos_index;
   else
      index=(pos>last_pos_index)? last_pos_index : pos;
//--- Сдвигаем ползунок полосы прокрутки
   m_scrollv.MovingThumb(index);
//--- Сдвигаем поле ввода
   ShiftTable();
  }
//+------------------------------------------------------------------+
//| Сдвигает таблицу относительно полос прокрутки                    |
//+------------------------------------------------------------------+
void CTable::ShiftTable(void)
  {
//--- Получим текущие позиции ползунков горизонтальной и вертикальной полос прокрутки
   int h_offset =m_scrollh.CurrentPos()*m_shift_x_step;
   int v_offset =m_scrollv.CurrentPos()*m_cell_y_size;
//--- Рассчитаем отступы для смещения
   int x_offset =(h_offset<1)? 0 : (h_offset>=m_shift_x2_limit)? m_shift_x2_limit-2 : h_offset;
   int y_offset =(v_offset<1)? 0 : (v_offset>=m_shift_y2_limit)? m_shift_y2_limit : v_offset;
//--- Расчёт положения данных относительно ползунков полос прокрутки
   long x =(m_table_x_size>m_table_visible_x_size)? x_offset : 0;
   long y =(m_table_y_size>m_table_visible_y_size)? y_offset : 0;
//--- Смещение таблицы
   ::ObjectSetInteger(m_chart_id,m_table.ChartObjectName(),OBJPROP_XOFFSET,x);
   ::ObjectSetInteger(m_chart_id,m_table.ChartObjectName(),OBJPROP_YOFFSET,y);
   ::ObjectSetInteger(m_chart_id,m_headers.ChartObjectName(),OBJPROP_XOFFSET,x);
  }
//+------------------------------------------------------------------+
//| Сортировать данные по указанному столбцу                         |
//+------------------------------------------------------------------+
void CTable::SortData(const uint column_index=0,const int direction=WRONG_VALUE)
  {
//--- Выйти, если выходим за пределы таблицы
   if(column_index>=m_columns_total)
      return;
//--- Индекс, с которого нужно начать сортировку
   uint first_index=0;
//--- Последний индекс
   uint last_index=m_rows_total-1;
//--- Без контроля направления пользователем
   if(direction==WRONG_VALUE)
     {
      //--- В первый раз будет отсортировано по возрастанию, а затем каждый раз в противоположном направлении
      if(m_is_sorted_column_index==WRONG_VALUE || column_index!=m_is_sorted_column_index || m_last_sort_direction==SORT_DESCEND)
         m_last_sort_direction=SORT_ASCENDING;
      else
         m_last_sort_direction=SORT_DESCEND;
     }
   else
     {
      m_last_sort_direction=(ENUM_SORT_MODE)direction;
     }
//--- Запомним индекс последнего отсортированного столбца данных
   m_is_sorted_column_index=(int)column_index;
//--- Сортировка
   QuickSort(first_index,last_index,column_index,m_last_sort_direction);
  }
//+------------------------------------------------------------------+
//| Обновление таблицы                                               |
//+------------------------------------------------------------------+
void CTable::AutoResizeColumns(void)
  {
   if(!m_autoresize_columns)
      return;
//---
   int  table_x_size      =m_x_size-2;
   uint last_column_index =m_columns_total-1;
//--- Сумма ширины всех столбцов
   int sum_width=0;
   for(uint c=0; c<m_columns_total; c++)
      sum_width+=m_columns[c].m_width;
//--- Корректируем ширину последнего столбца
   if(m_rows_total>(uint)VisibleRowsTotal())
     {
      if(sum_width==table_x_size)
         m_columns[last_column_index].m_width=m_columns[last_column_index].m_width-m_scrollv.XSize();
     }
   else
     {
      if(sum_width!=table_x_size)
        {
         if(sum_width<table_x_size)
           {
            int difference=table_x_size-sum_width;
            m_columns[last_column_index].m_width=m_columns[last_column_index].m_width+difference;
           }
         else
           {
            int difference=sum_width-(table_x_size);
            m_columns[last_column_index].m_width=m_columns[last_column_index].m_width-difference;
           }
        }
     }
  }
//+------------------------------------------------------------------+
//| Обновление таблицы                                               |
//+------------------------------------------------------------------+
void CTable::Update(const bool redraw=false)
  {
//--- Перерисовать таблицу, если указано
   if(redraw)
     {
      //--- Авторазмер столбцов
      AutoResizeColumns();
      //--- Установить новый размер фона таблицы
      ChangeMainSize(m_x_size,m_y_size);
      //--- Рассчитать размеры таблицы
      CalculateTableSize();
      //--- Установить новый размер таблице
      ChangeTableSize();
      //--- Перерисовать таблицу
      DrawTable();
      //--- Обновить таблицу
      m_canvas.Update();
      m_table.Update();
      //--- Обновить заголовки, если они включены
      if(m_show_headers)
         m_headers.Update();
      //--- Обновить полосы прокрутки
      m_scrollv.Update(true);
      m_scrollh.Update(true);
      return;
     }
//--- Авторазмер столбцов
   AutoResizeColumns();
//--- Обновить таблицу
   m_canvas.Update();
   m_table.Update();
//--- Обновить заголовки, если они включены
   if(m_show_headers)
      m_headers.Update();
  }
//+------------------------------------------------------------------+
//| Обработка нажатия на заголовке                                   |
//+------------------------------------------------------------------+
bool CTable::OnClickHeaders(const string clicked_object)
  {
//--- Выйти, если (1) режим сортировки отключен или (2) в процессе изменения ширины столбца
   if(!m_is_sort_mode || m_column_resize_control!=WRONG_VALUE)
      return(false);
//--- Выйти, если в ячейках есть поля ввода или комбо-боксы в ячейках
   if(m_edit_state && m_combobox_state)
      return(false);
//--- Выйдем, если полоса прокрутки в активном режиме
   if(m_scrollv.State() || m_scrollh.State())
      return(false);
//--- Выйдем, если чужое имя объекта
   if(m_headers.ChartObjectName()!=clicked_object)
      return(false);
//--- Для определения индекса столбца
   uint column_index=0;
//--- Получим относительную X-координату под курсором мыши
   int x=m_mouse.RelativeX(m_headers);
//--- Определим заголовок, на котором нажали
   for(uint c=0; c<m_columns_total; c++)
     {
      //--- Если нашли заголовок, запомним его индекс
      if(x>=m_columns[c].m_x && x<=m_columns[c].m_x2)
        {
         column_index=c;
         break;
        }
     }
//--- Сортировка данных по указанному столбцу
   SortData(column_index);
//--- Отправим сообщение об этом
   ::EventChartCustom(m_chart_id,ON_SORT_DATA,CElementBase::Id(),m_is_sorted_column_index,::EnumToString(DataType(column_index)));
   return(true);
  }
//+------------------------------------------------------------------+
//| Обработка выделения ряда                                         |
//+------------------------------------------------------------------+
bool CTable::OnSelectRow(const int row_index)
  {
//--- Если нажали на уже выделенном ряде
   if(row_index==m_selected_item)
     {
      //--- Снять выделение, если нет запрета
      if(!m_is_without_deselect)
        {
         m_prev_selected_item =m_selected_item;
         m_selected_item      =WRONG_VALUE;
         m_selected_item_text ="";
        }
      return(true);
     }
//--- Сохраним индекс ряда и строку первой ячейки
   m_prev_selected_item =(m_selected_item==WRONG_VALUE)? row_index : m_selected_item;
   m_selected_item      =row_index;
   m_selected_item_text =m_columns[0].m_rows[row_index].m_full_text;
   return(true);
  }
//+------------------------------------------------------------------+
//| Обработка нажатия на таблице                                     |
//+------------------------------------------------------------------+
bool CTable::OnClickTable(const string clicked_object)
  {
//--- Выйти, если в процессе изменения ширины столбца
   if(m_column_resize_control!=WRONG_VALUE)
      return(false);
//--- Выйдем, если полоса прокрутки в активном режиме
   if(m_scrollv.State() || m_scrollh.State())
      return(false);
//--- Выйдем, если чужое имя объекта
   if(m_table.ChartObjectName()!=clicked_object)
      return(false);
//--- Определим ряд, на котором нажали
   int r=PressedRowIndex();
//--- Определим ячейку, на которой нажали
   int c=PressedCellColumnIndex();
//--- Проверим был ли задействован элемент в ячейке
   bool is_cell_element=CheckCellElement(c,r);
//--- Если (1) включен режим выделения строки и (2) не задействован элемент в ячейке
   if(m_selectable_row && !is_cell_element)
     {
      OnSelectRow(r);
      //--- Изменить цвет
      RedrawRow(true);
      m_table.Update();
      //--- Отправим сообщение об этом
      ::EventChartCustom(m_chart_id,ON_CLICK_LIST_ITEM,CElementBase::Id(),m_selected_item,string(c)+"_"+string(r));
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Обработка двойного нажатия на таблице                            |
//+------------------------------------------------------------------+
bool CTable::OnDoubleClickTable(const string clicked_object)
  {
//--- Выйти, если таблица вне фокуса
   if(!m_table.MouseFocus())
      return(false);
//--- Определим ряд, на котором нажали
   int r=PressedRowIndex();
//--- Определим ячейку, на которой нажали
   int c=PressedCellColumnIndex();
//--- Проверим был ли задействован элемент в ячейке и вернём результат
   return(CheckCellElement(c,r,true));
  }
//+------------------------------------------------------------------+
//| Обработка окончания ввода значения в ячейку                      |
//+------------------------------------------------------------------+
bool CTable::OnEndEditCell(const int id)
  {
//--- Выйти, если (1) идентификаторы не совпадают или (2) ячеек с полями ввода нет
   if(id!=CElementBase::Id() || !m_edit_state)
      return(false);
//--- Установить новое значение в ячейку таблицы
   SetValue(m_last_edit_column_index,m_last_edit_row_index,m_edit.GetValue(),0,true);
   Update();
//--- Деактивировать и скрыть поле ввода
   m_edit.GetTextBoxPointer().DeactivateTextBox();
   m_edit.Hide();
   m_chart.Redraw();
   return(true);
  }
//+------------------------------------------------------------------+
//| Обработка выбора пункта в комбо-боксе ячейки                     |
//+------------------------------------------------------------------+
bool CTable::OnClickComboboxItem(const int id)
  {
//--- Выйти, если (1) идентификаторы не совпадают или (2) ячеек с комбо-боксом нет
   if(id!=CElementBase::Id() || !m_combobox_state)
      return(false);
//--- Индексы последней редактируемой ячейки
   int c=m_last_edit_column_index;
   int r=m_last_edit_row_index;
//--- Запомним в ячейке индекс выбранного пункта
   m_columns[c].m_rows[r].m_selected_item=m_combobox.GetListViewPointer().SelectedItemIndex();
//--- Установить новое значение в ячейку таблицы
   SetValue(c,r,m_combobox.GetValue(),0,true);
   Update();
   return(true);
  }
//+------------------------------------------------------------------+
//| Проверка поля ввода в ячейках на скрытие                         |
//+------------------------------------------------------------------+
void CTable::CheckAndHideEdit(void)
  {
//--- Выйти, если (1) поля ввода нет или (2) оно скрыто
   if(!m_edit_state || !m_edit.IsVisible())
      return;
//--- Проверим фокус
   m_edit.GetTextBoxPointer().CheckMouseFocus();
//--- Деактивировать и скрыть поле ввода, если оно (1) вне фокуса и (2) кнопка мыши нажата
   if(!m_edit.GetTextBoxPointer().MouseFocus() && m_mouse.LeftButtonState())
     {
      m_edit.GetTextBoxPointer().DeactivateTextBox();
      m_edit.Hide();
      m_chart.Redraw();
     }
  }
//+------------------------------------------------------------------+
//| Проверка комбо-бокса в ячейках на скрытие                        |
//+------------------------------------------------------------------+
void CTable::CheckAndHideCombobox(void)
  {
//--- Выйти, если (1) комбо-бокса нет или (2) оно скрыто
   if(!m_combobox_state || !m_combobox.IsVisible())
      return;
//--- Скрыть комбо-бокс, если он вне фокуса и кнопка мыши нажата
   if(!m_combobox.GetButtonPointer().MouseFocus() && m_mouse.LeftButtonState())
     {
      m_combobox.Hide();
      m_chart.Redraw();
     }
  }
//+------------------------------------------------------------------+
//| Возвращает индекс нажатой строки                                 |
//+------------------------------------------------------------------+
int CTable::PressedRowIndex(void)
  {
   int index=0;
//--- Получим относительную Y-координату под курсором мыши
   int y=m_mouse.RelativeY(m_table);
//--- Определим ряд, на котором нажали
   for(uint r=0; r<m_rows_total; r++)
     {
      //--- Если нажатие было не на этом ряде, перейти к следующему
      if(!(y>=m_rows[r].m_y && y<=m_rows[r].m_y2))
         continue;
      //---
      index=(int)r;
      break;
     }
//--- Вернуть индекс
   return(index);
  }
//+------------------------------------------------------------------+
//| Возвращает индекс столбца нажатой ячейки                         |
//+------------------------------------------------------------------+
int CTable::PressedCellColumnIndex(void)
  {
   int index=0;
//--- Получим относительную X-координату под курсором мыши
   int x=m_mouse.RelativeX(m_table);
//--- Определим ячейку, на которой нажали
   for(uint c=0; c<m_columns_total; c++)
     {
      //--- Если на этой ячейке нажали, запомним индекс столбца
      if(x>=m_columns[c].m_x && x<=m_columns[c].m_x2)
        {
         index=(int)c;
         break;
        }
     }
//--- Вернуть индекс столбца
   return(index);
  }
//+------------------------------------------------------------------+
//| Проверяет, был ли при нажатии задействован элемент в ячейке      |
//+------------------------------------------------------------------+
bool CTable::CheckCellElement(const int column_index,const int row_index,const bool double_click=false)
  {
//--- Выйти, если в ячейке нет элемента управления
   if(m_columns[column_index].m_rows[row_index].m_type==CELL_SIMPLE)
      return(false);
//---
   switch(m_columns[column_index].m_rows[row_index].m_type)
     {
      //--- Если это ячейка-кнопка
      case CELL_BUTTON :
        {
         if(!CheckPressedButton(column_index,row_index,double_click))
            return(false);
         //---
         break;
        }
      //--- Если это ячейка-чекбокс
      case CELL_CHECKBOX :
        {
         if(!CheckPressedCheckBox(column_index,row_index,double_click))
            return(false);
         //---
         break;
        }
      //--- Если это ячейка с полем ввода
      case CELL_EDIT :
        {
         if(!CheckPressedEdit(column_index,row_index,double_click))
            return(false);
         //---
         break;
        }
      //--- Если это ячейка с комбо-боксом
      case CELL_COMBOBOX :
        {
         if(!CheckPressedCombobox(column_index,row_index,double_click))
            return(false);
         //---
         break;
        }
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Проверяет, было ли нажатие на кнопке в ячейке                    |
//+------------------------------------------------------------------+
bool CTable::CheckPressedButton(const int column_index,const int row_index,const bool double_click=false)
  {
//--- Выйти, если нет картинок в ячейке
   if(ImagesTotal(column_index,row_index)<1)
     {
      ::Print(__FUNCTION__," > Установите минимум одну картинку для ячейки-кнопки!");
      return(false);
     }
//--- Получим относительные координаты под курсором мыши
   int x=m_mouse.RelativeX(m_table);
//--- Получим правую границу картинки
   int image_x  =int(m_columns[column_index].m_x+m_columns[column_index].m_image_x_offset);
   int image_x2 =int(image_x+m_columns[column_index].m_rows[row_index].m_images[0].Width());
//--- Выйти, если нажали не на картинке
   if(x>image_x2)
      return(false);
   else
     {
      //--- Если это не двойной клик, отправим сообщение
      if(!double_click)
        {
         int image_index=m_columns[column_index].m_rows[row_index].m_selected_image;
         ::EventChartCustom(m_chart_id,ON_CLICK_BUTTON,CElementBase::Id(),image_index,string(column_index)+"_"+string(row_index));
        }
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Проверяет, было ли нажатие на чекбоксе в ячейке                  |
//+------------------------------------------------------------------+
bool CTable::CheckPressedCheckBox(const int column_index,const int row_index,const bool double_click=false)
  {
//--- Выйти, если нет картинок в ячейке
   if(ImagesTotal(column_index,row_index)<2)
     {
      ::Print(__FUNCTION__," > Установите минимум две картинки для ячейки-чекбокса!");
      return(false);
     }
//--- Получим относительные координаты под курсором мыши
   int x=m_mouse.RelativeX(m_table);
//--- Получим правую границу картинки
   int image_x  =int(m_columns[column_index].m_x+m_icon_x_gap);
   int image_x2 =int(image_x+m_columns[column_index].m_rows[row_index].m_images[0].Width());
//--- Выйти, если (1) нажали не на картинке и (2) это не двойной клик
   if(x>image_x2 && !double_click)
      return(false);
   else
     {
      //--- Текущий индекс выбранной картинки
      int image_i=m_columns[column_index].m_rows[row_index].m_selected_image;
      //--- Определим следующий индекс для картинки
      int next_i=(image_i<ImagesTotal(column_index,row_index)-1)?++image_i : 0;
      //--- Выбрать следующую картинку
      //if(m_selectable_row)
      //  {
      //   ChangeImage(column_index,row_index,next_i);
      //   RedrawRow(true);
      //  }
      //else
      ChangeImage(column_index,row_index,next_i,true);
      //--- Обновить таблицу
      m_table.Update();
      //--- Отправим сообщение об этом
      ::EventChartCustom(m_chart_id,ON_CLICK_CHECKBOX,CElementBase::Id(),next_i,string(column_index)+"_"+string(row_index));
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Проверяет, было ли нажатие на поле ввода в ячейке                |
//+------------------------------------------------------------------+
bool CTable::CheckPressedEdit(const int column_index,const int row_index,const bool double_click=false)
  {
//--- Выйти, если это не двойной клик
   if(!double_click)
      return(false);
//--- Сохранить индексы
   m_last_edit_row_index    =row_index;
   m_last_edit_column_index =column_index;
//--- Сдвиг по двум осям
   int x_offset =(int)::ObjectGetInteger(m_chart_id,m_table.ChartObjectName(),OBJPROP_XOFFSET);
   int y_offset =(int)::ObjectGetInteger(m_chart_id,m_table.ChartObjectName(),OBJPROP_YOFFSET);
//--- Установить новые координаты
   m_edit.XGap(m_columns[column_index].m_x-x_offset);
   m_edit.YGap(m_rows[row_index].m_y+((m_show_headers)? m_header_y_size : 0)-y_offset);
//--- Размеры
   int x_size =m_columns[column_index].m_x2-m_columns[column_index].m_x+1;
   int y_size =m_cell_y_size+1;
//--- Установить размер
   m_edit.GetTextBoxPointer().ChangeSize(x_size,y_size);
//--- Установить значение из ячейки таблицы
   m_edit.SetValue(m_columns[column_index].m_rows[row_index].m_full_text);
//--- Активировать поле ввода
   m_edit.GetTextBoxPointer().ActivateTextBox();
//--- Установить фокус
   m_edit.GetTextBoxPointer().MouseFocus(true);
//--- Показать поле ввода
   m_edit.Reset();
//--- Перерисовать график
   m_chart.Redraw();
   return(true);
  }
//+------------------------------------------------------------------+
//| Проверяет, было ли нажатие на комбо-боксе в ячейке               |
//+------------------------------------------------------------------+
bool CTable::CheckPressedCombobox(const int column_index,const int row_index,const bool double_click=false)
  {
//--- Выйти, если это не двойной клик
   if(!double_click)
      return(false);
//--- Сохранить индексы
   m_last_edit_row_index    =row_index;
   m_last_edit_column_index =column_index;
//--- Сдвиг по двум осям
   int x_offset =(int)::ObjectGetInteger(m_chart_id,m_table.ChartObjectName(),OBJPROP_XOFFSET);
   int y_offset =(int)::ObjectGetInteger(m_chart_id,m_table.ChartObjectName(),OBJPROP_YOFFSET);
//--- Установить новые координаты
   m_combobox.XGap(m_columns[column_index].m_x-x_offset);
   m_combobox.YGap(m_rows[row_index].m_y+((m_show_headers)? m_header_y_size : 0)-y_offset);
//--- Установить размер кнопке
   int x_size =m_columns[column_index].m_x2-m_columns[column_index].m_x+1;
   int y_size =m_cell_y_size+1;
   m_combobox.GetButtonPointer().ChangeSize(x_size,y_size);
//--- Установить размер списку
   y_size=m_combobox.GetListViewPointer().YSize();
   m_combobox.GetListViewPointer().ChangeSize(x_size,y_size);
//--- Установить размер списка ячейки
   int total=::ArraySize(m_columns[column_index].m_rows[row_index].m_value_list);
   m_combobox.GetListViewPointer().Rebuilding(total);
//--- Установить список из ячейки
   for(int i=0; i<total; i++)
      m_combobox.GetListViewPointer().SetValue(i,m_columns[column_index].m_rows[row_index].m_value_list[i]);
//--- Установить пункт из ячейки
   int index=m_columns[column_index].m_rows[row_index].m_selected_item;
   m_combobox.SelectItem(index);
//--- Обновить элемент
   m_combobox.GetButtonPointer().MouseFocus(true);
   m_combobox.GetButtonPointer().Update(true);
   m_combobox.GetListViewPointer().Update(true);
//--- Показать поле ввода
   m_combobox.Reset();
//--- Перерисовать график
   m_chart.Redraw();
//--- Отправим сообщение об изменении в графическом интерфейсе
   ::EventChartCustom(m_chart_id,ON_CHANGE_GUI,CElementBase::Id(),0,"");
   return(true);
  }
//+------------------------------------------------------------------+
//| Алгоритм быстрой сортировки                                      |
//+------------------------------------------------------------------+
void CTable::QuickSort(uint beg,uint end,uint column,const ENUM_SORT_MODE mode=SORT_ASCENDING)
  {
   uint   r1         =beg;
   uint   r2         =end;
   uint   c          =column;
   string temp       =NULL;
   string value      =NULL;
   uint   data_total =m_rows_total-1;
//--- Выполнять алгоритм, пока левый индекс меньше самого крайнего правого индекса
   while(r1<end)
     {
      //--- Получим значение из середины ряда
      value=m_columns[c].m_rows[(beg+end)>>1].m_full_text;
      //--- Выполнять алгоритм, пока левый индекс меньше найденного правого индекса
      while(r1<r2)
        {
         //--- Смещать индекс вправо, пока находим значение по указанному условию
         while(CheckSortCondition(c,r1,value,(mode==SORT_ASCENDING)? false : true))
           {
            //--- Контроль выхода за границы массива
            if(r1==data_total)
               break;
            r1++;
           }
         //--- Смещать индекс влево, пока находим значение по указанному условию
         while(CheckSortCondition(c,r2,value,(mode==SORT_ASCENDING)? true : false))
           {
            //--- Контроль выхода за границы массива
            if(r2==0)
               break;
            r2--;
           }
         //--- Если левый индекс ещё не больше правого
         if(r1<=r2)
           {
            //--- Поменять значения местами
            Swap(r1,r2);
            //--- Если дошли до предела слева
            if(r2==0)
              {
               r1++;
               break;
              }
            //---
            r1++;
            r2--;
           }
        }
      //--- Рекурсивное продолжение алгоритма, пока не дойдём до начала диапазона
      if(beg<r2)
         QuickSort(beg,r2,c,mode);
      //--- Cужение диапазона для следующей итерации
      beg=r1;
      r2=end;
     }
  }
//+------------------------------------------------------------------+
//| Сравнение значений по указанному условию сортировки              |
//+------------------------------------------------------------------+
//| direction: true (>), false (<)                                   |
//+------------------------------------------------------------------+
bool CTable::CheckSortCondition(uint column_index,uint row_index,const string check_value,const bool direction)
  {
   bool condition=false;
//---
   switch(m_columns[column_index].m_data_type)
     {
      case TYPE_STRING :
        {
         string v1=m_columns[column_index].m_rows[row_index].m_full_text;
         string v2=check_value;
         condition=(direction)? v1>v2 : v1<v2;
         break;
        }
      //---
      case TYPE_DOUBLE :
        {
         double v1=double(m_columns[column_index].m_rows[row_index].m_full_text);
         double v2=double(check_value);
         condition=(direction)? v1>v2 : v1<v2;
         break;
        }
      //---
      case TYPE_DATETIME :
        {
         datetime v1=::StringToTime(m_columns[column_index].m_rows[row_index].m_full_text);
         datetime v2=::StringToTime(check_value);
         condition=(direction)? v1>v2 : v1<v2;
         break;
        }
      //---
      default :
        {
         long v1=(long)m_columns[column_index].m_rows[row_index].m_full_text;
         long v2=(long)check_value;
         condition=(direction)? v1>v2 : v1<v2;
         break;
        }
     }
//---
   return(condition);
  }
//+------------------------------------------------------------------+
//| Меняет элементы местами                                          |
//+------------------------------------------------------------------+
void CTable::Swap(uint r1,uint r2)
  {
//--- Пройдёмся в цикле по всем столбцам
   for(uint c=0; c<m_columns_total; c++)
     {
      //--- Меняем местами полный текст
      string temp_text                    =m_columns[c].m_rows[r1].m_full_text;
      m_columns[c].m_rows[r1].m_full_text =m_columns[c].m_rows[r2].m_full_text;
      m_columns[c].m_rows[r2].m_full_text =temp_text;
      //--- Меняем местами краткий текст
      temp_text                            =m_columns[c].m_rows[r1].m_short_text;
      m_columns[c].m_rows[r1].m_short_text =m_columns[c].m_rows[r2].m_short_text;
      m_columns[c].m_rows[r2].m_short_text =temp_text;
      //--- Меняем местами кол-во знаков после запятой
      uint temp_digits                 =m_columns[c].m_rows[r1].m_digits;
      m_columns[c].m_rows[r1].m_digits =m_columns[c].m_rows[r2].m_digits;
      m_columns[c].m_rows[r2].m_digits =temp_digits;
      //--- Меняем местами цвет текста
      color temp_text_color                =m_columns[c].m_rows[r1].m_text_color;
      m_columns[c].m_rows[r1].m_text_color =m_columns[c].m_rows[r2].m_text_color;
      m_columns[c].m_rows[r2].m_text_color =temp_text_color;
      //--- Меняем местами цвет фона
      color temp_back_color                =m_columns[c].m_rows[r1].m_back_color;
      m_columns[c].m_rows[r1].m_back_color =m_columns[c].m_rows[r2].m_back_color;
      m_columns[c].m_rows[r2].m_back_color =temp_back_color;
      //--- Меняем местами индекс выбранной картинки
      int temp_selected_image                  =m_columns[c].m_rows[r1].m_selected_image;
      m_columns[c].m_rows[r1].m_selected_image =m_columns[c].m_rows[r2].m_selected_image;
      m_columns[c].m_rows[r2].m_selected_image =temp_selected_image;
      //--- Проверим, есть ли картинки в ячейках
      int r1_images_total=::ArraySize(m_columns[c].m_rows[r1].m_images);
      int r2_images_total=::ArraySize(m_columns[c].m_rows[r2].m_images);
      //--- Переходим к следующему столбцу, если в обеих ячейках нет картинок
      if(r1_images_total<1 && r2_images_total<1)
         continue;
      //--- Меняем местами картинки
      CImage r1_temp_images[];
      //---
      ::ArrayResize(r1_temp_images,r1_images_total);
      for(int i=0; i<r1_images_total; i++)
         ImageCopy(r1_temp_images,m_columns[c].m_rows[r1].m_images,i);
      //---
      ::ArrayResize(m_columns[c].m_rows[r1].m_images,r2_images_total);
      for(int i=0; i<r2_images_total; i++)
         ImageCopy(m_columns[c].m_rows[r1].m_images,m_columns[c].m_rows[r2].m_images,i);
      //---
      ::ArrayResize(m_columns[c].m_rows[r2].m_images,r1_images_total);
      for(int i=0; i<r1_images_total; i++)
         ImageCopy(m_columns[c].m_rows[r2].m_images,r1_temp_images,i);
     }
  }
//+------------------------------------------------------------------+
//| Рисует элемент                                                   |
//+------------------------------------------------------------------+
void CTable::Draw(void)
  {
   DrawTable();
  }
//+------------------------------------------------------------------+
//| Рисует таблицу                                                   |
//+------------------------------------------------------------------+
void CTable::DrawTable(const bool only_visible=false)
  {
//--- Если не указано перерисовать только видимую часть таблицы
   if(!only_visible)
     {
      //--- Установим индексы строк всей таблицы от самого начала и до конца
      m_visible_table_from_index =0;
      m_visible_table_to_index   =m_rows_total;
     }
//--- Получим индексы строк видимой части таблицы
   else
      VisibleTableIndexes();
//--- Нарисовать фон
   CElement::DrawBackground();
//--- Нарисовать рамку
   CElement::DrawBorder();
//--- Нарисовать сетку
   DrawGrid();
//--- Нарисовать фон строк таблицы
   DrawRows();
//--- Нарисовать выделенную строку
   DrawSelectedRow();
//--- Нарисовать картинку
   DrawImages();
//--- Нарисовать текст
   DrawText();
//--- Обновить заголовки, если они включены
   if(m_show_headers)
      DrawTableHeaders();
  }
//+------------------------------------------------------------------+
//| Перерисовывает указанную ячейку таблицы                          |
//+------------------------------------------------------------------+
void CTable::RedrawCell(const int column_index,const int row_index)
  {
//--- Координаты
   int x1=m_columns[column_index].m_x+1;
   int x2=m_columns[column_index].m_x2-1;
   int y1=m_rows[row_index].m_y+1;
   int y2=m_rows[row_index].m_y2-1;
//--- Для расчёта координат
   int  x=0,y=0;
//--- Для проверки фокуса
   bool is_row_focus=false;
//--- Если включен режим подсветки строк таблицы
   if(m_lights_hover)
     {
      //--- (1) Получим относительную Y-координату курсора мыши и (2) фокус на указанной строке таблицы
      y=m_mouse.RelativeY(m_table);
      is_row_focus=(y>m_rows[row_index].m_y && y<=m_rows[row_index].m_y2);
     }
//--- Нарисовать фон ячейки
   m_table.FillRectangle(x1,y1,x2,y2,RowColorCurrent(column_index,row_index,is_row_focus));
//--- Рисуем картинку, если (1) она есть в этой ячейке и (2) в этом столбце выравнивание текста по левому краю
   if(ImagesTotal(column_index,row_index)>0 && m_columns[column_index].m_text_align==ALIGN_LEFT)
      CTable::DrawImage(column_index,row_index);
//--- Получим способ выравнивания текста
   uint text_align=TextAlign(column_index,TA_TOP);
//--- Рисуем текст
   for(uint c=0; c<m_columns_total; c++)
     {
      //--- Получим X-координату текста
      x=TextX(c);
      //--- Остановим цикл
      if(c==column_index)
         break;
     }
//--- (1) Рассчитать Y-координату и (2) нарисовать текст
   y=y1+m_label_y_gap-1;
   m_table.TextOut(x,y,m_columns[column_index].m_rows[row_index].m_short_text,TextColor(column_index,row_index),text_align);
  }
//+------------------------------------------------------------------+
//| Рисует указанный ряд таблицы по указанному режиму                |
//+------------------------------------------------------------------+
void CTable::DrawRow(int &indexes[],const int item_index,const int prev_item_index,const bool is_user=true)
  {
   int x1=0,x2=m_table_x_size-2;
   int y1[2]={0},y2[2]={0};
//--- Количество строк и столбцов для рисования
   uint rows_total    =0;
   uint columns_total =m_columns_total-1;
//--- Если это программный метод выделения строки
   if(!is_user)
      rows_total=(prev_item_index!=WRONG_VALUE && item_index!=prev_item_index)? 2 : 1;
   else
      rows_total=(item_index!=WRONG_VALUE && prev_item_index!=WRONG_VALUE && item_index!=prev_item_index)? 2 : 1;
//--- Рисуем фон строк
   for(uint r=0; r<rows_total; r++)
     {
      //--- Расчёт координат верхней и нижней границ строки
      y1[r] =m_rows[indexes[r]].m_y+1;
      y2[r] =m_rows[indexes[r]].m_y2-1;
      //--- Определим фокус на строке относительно режима подсветки
      bool is_item_focus=false;
      if(!m_lights_hover)
         is_item_focus=(indexes[r]==item_index && item_index!=WRONG_VALUE);
      else
         is_item_focus=(item_index==WRONG_VALUE)?(indexes[r]==prev_item_index) :(indexes[r]==item_index);
      //--- Нарисовать фон ячейки
      for(uint c=0; c<m_columns_total; c++)
        {
         x1=m_columns[c].m_x+((c>0)? 1 : 0);
         x2=m_columns[c].m_x2-1;
         m_table.FillRectangle(x1,y1[r],x2,y2[r],RowColorCurrent(c,indexes[r],(is_user)? is_item_focus : false));
        }
     }
//--- Рисуем границы
   for(uint r=0; r<rows_total; r++)
     {
      for(uint c=0; c<columns_total; c++)
         m_table.Line(m_columns[c].m_x2,y1[r],m_columns[c].m_x2,y2[r],::ColorToARGB(m_grid_color));
     }
//--- Рисуем картинки
   for(uint r=0; r<rows_total; r++)
     {
      for(uint c=0; c<m_columns_total; c++)
        {
         //--- Рисуем картинку, если (1) она есть в этой ячейке и (2) в этом столбце выравнивание текста по левому краю
         if(ImagesTotal(c,indexes[r])>0 && m_columns[c].m_text_align==ALIGN_LEFT)
            CTable::DrawImage(c,indexes[r]);
        }
     }
//--- Для расчёта координат
   int x=0,y=0;
//--- Способ выравнивания текста
   uint text_align=0;
//--- Рисуем текст
   for(uint c=0; c<m_columns_total; c++)
     {
      //--- Получим (1) X-координату текста и (2) способ выравнивания текста
      x          =TextX(c);
      text_align =TextAlign(c,TA_TOP);
      //---
      for(uint r=0; r<rows_total; r++)
        {
         //--- (1) Рассчитать координату и (2) нарисовать текст
         y=m_rows[indexes[r]].m_y+m_label_y_gap;
         m_table.TextOut(x,y,m_columns[c].m_rows[indexes[r]].m_short_text,TextColor(c,indexes[r]),text_align);
        }
     }
  }
//+------------------------------------------------------------------+
//| Перерисовывает указанный ряд таблицы по указанному режиму        |
//+------------------------------------------------------------------+
void CTable::RedrawRow(const bool is_selected_row=false)
  {
//--- Текущий и предыдущий индексы строк
   int item_index      =WRONG_VALUE;
   int prev_item_index =WRONG_VALUE;
//--- Инициализиция индексов строк относительного указанного режима
   if(is_selected_row)
     {
      item_index      =m_selected_item;
      prev_item_index =m_prev_selected_item;
     }
   else
     {
      item_index      =m_item_index_focus;
      prev_item_index =m_prev_item_index_focus;
     }
//--- Выйти, если индексы не определены
   if(prev_item_index==WRONG_VALUE && item_index==WRONG_VALUE)
      return;
//--- Массив для значений в определённой последовательности
   int indexes[2];
//--- Если (1) курсор мыши сдвинулся вниз или (2) в первый раз здесь
   if(item_index>m_prev_item_index_focus || item_index==WRONG_VALUE)
     {
      indexes[0] =(item_index==WRONG_VALUE || prev_item_index!=WRONG_VALUE)? prev_item_index : item_index;
      indexes[1] =item_index;
     }
//--- Если курсор мыши сдвинулся вверх
   else
     {
      indexes[0] =item_index;
      indexes[1] =prev_item_index;
     }
//--- Рисует указанный ряд таблицы по указанному режиму
   DrawRow(indexes,item_index,prev_item_index);
  }
//+------------------------------------------------------------------+
//| Рисует фон рядов таблицы                                         |
//+------------------------------------------------------------------+
void CTable::DrawRows(void)
  {
//--- Координаты курсора мыши
   int y=0;
//--- Координаты заголовков
   int x1=0,x2=m_table_x_size-2;
   int y1=0,y2=0;
   bool is_row_focus=false;
//--- Получим относительную X-координату под курсором мыши
   y=m_mouse.RelativeY(m_table);
//--- Рисование рядов
   for(uint r=m_visible_table_from_index; r<m_visible_table_to_index; r++)
     {
      //--- Расчёт координат границ ряда с сохранением значений
      m_rows[r].m_y  =(int)(r*m_cell_y_size);
      m_rows[r].m_y2 =m_rows[r].m_y+m_cell_y_size;
      y1 =m_rows[r].m_y+((r>0)? 1 : 0);
      y2 =m_rows[r].m_y2-1;
      //--- Проверим фокус
      is_row_focus=(m_lights_hover)?(y>y1 && y<y2) : false;
      //--- Нарисовать фон ячейки
      for(uint c=0; c<m_columns_total; c++)
        {
         x1 =m_columns[c].m_x+((c>0)? 1 : 0);
         x2 =m_columns[c].m_x2-1;
         m_table.FillRectangle(x1,y1,x2,y2,RowColorCurrent(c,r,is_row_focus));
        }
     }
  }
//+------------------------------------------------------------------+
//| Рисует выделенный ряд                                            |
//+------------------------------------------------------------------+
void CTable::DrawSelectedRow(void)
  {
//--- Выйти, если нет выделенного ряда
   if(m_selected_item==WRONG_VALUE)
      return;
//--- Зададим начальные координаты для проверки условия
   int y_offset=m_selected_item*m_cell_y_size;
//--- Координаты
   int x1=0;
   int x2=0;
   int y1=y_offset+1;
   int y2=y_offset+m_cell_y_size-1;
//--- Нарисовать фон ячеек
   for(uint c=0; c<m_columns_total; c++)
     {
      x1 =m_columns[c].m_x+((c>0)? 1 : 0);
      x2 =m_columns[c].m_x2-1;
      m_table.FillRectangle(x1,y1,x2,y2,::ColorToARGB(m_selected_row_color,m_alpha));
     }
  }
//+------------------------------------------------------------------+
//| Рисует сетку                                                     |
//+------------------------------------------------------------------+
void CTable::DrawGrid(void)
  {
//--- Цвет сетки
   uint clr=::ColorToARGB(m_grid_color);
//--- Размер холста для рисования
   int x_size=m_table_x_size;
   int y_size=m_table_y_size-1;
//--- Координаты
   int x1=0,x2=0,y1=0,y2=0;
//--- Горизонтальные линии
   uint first_index=(m_show_headers)? 0 : 1;
   x1=0; y1=0; x2=x_size; y2=0;
   for(uint r=first_index; r<m_rows_total; r++)
     {
      //--- Расчёт координат границ ряда с сохранением значений
      m_rows[r].m_y  =y1 =(int)(r*m_cell_y_size);
      m_rows[r].m_y2 =y2 =y1+m_cell_y_size;
      m_table.Line(x1,m_rows[r].m_y,x2,m_rows[r].m_y,clr);
     }
//--- Вертикальные линии
   x1=0; y1=0; x2=0; y2=y_size;
   for(uint i=0; i<m_columns_total; i++)
     {
      m_columns[i].m_x2=x2=x1+=m_columns[i].m_width;
      m_table.Line(x1,y1,x2,y2,clr);
      //--- Сохраним X-координату столбца
      if(i>0)
        {
         uint prev_i=i-1;
         m_columns[i].m_x=m_columns[prev_i].m_x+m_columns[prev_i].m_width;
        }
     }
  }
//+------------------------------------------------------------------+
//| Рисует все изображения таблицы                                   |
//+------------------------------------------------------------------+
void CTable::DrawImages(void)
  {
//--- Для расчёта координат
   int x=0,y=0;
//--- Столбцы
   for(int c=0; c<(int)m_columns_total; c++)
     {
      //--- Если выравнивание текста не по левому краю, перейти к следующему столбцу
      if(m_columns[c].m_text_align!=ALIGN_LEFT)
         continue;
      //--- Строки
      for(int r=(int)m_visible_table_from_index; r<(int)m_visible_table_to_index; r++)
        {
         //--- Перейти к следующему, если в этой ячейке нет картинок
         if(ImagesTotal(c,r)<1)
            continue;
         //--- Выбранная картинка в ячейке (по умолчанию выбрана первая [0])
         int selected_image=m_columns[c].m_rows[r].m_selected_image;
         //--- Перейти к следующему, если массив пикселей пуст
         if(m_columns[c].m_rows[r].m_images[selected_image].DataTotal()<1)
            continue;
         //--- Нарисовать картинку
         CTable::DrawImage(c,r);
        }
     }
  }
//+------------------------------------------------------------------+
//| Рисует изображение в указанной ячейке                            |
//+------------------------------------------------------------------+
void CTable::DrawImage(const int column_index,const int row_index)
  {
//--- Расчёт координат
   int x =m_columns[column_index].m_x+m_columns[column_index].m_image_x_offset;
   int y =m_rows[row_index].m_y+m_columns[column_index].m_image_y_offset;
//--- Выбранная картинка в ячейке и её размеры
   int  selected_image =m_columns[column_index].m_rows[row_index].m_selected_image;
   uint image_height   =m_columns[column_index].m_rows[row_index].m_images[selected_image].Height();
   uint image_width    =m_columns[column_index].m_rows[row_index].m_images[selected_image].Width();
//--- Рисуем
   for(uint ly=0,i=0; ly<image_height; ly++)
     {
      for(uint lx=0; lx<image_width; lx++,i++)
        {
         //--- Если нет цвета, перейти к следующему пикселю
         if(m_columns[column_index].m_rows[row_index].m_images[selected_image].Data(i)<1)
            continue;
         //--- Получаем цвет нижнего слоя (фона ячейки) и цвет указанного пикселя картинки
         uint background  =(row_index==m_selected_item)? m_selected_row_color : m_canvas.PixelGet(x+lx,y+ly);
         uint pixel_color =m_columns[column_index].m_rows[row_index].m_images[selected_image].Data(i);
         //--- Смешиваем цвета
         uint foreground=::ColorToARGB(m_clr.BlendColors(background,pixel_color));
         //--- Рисуем пиксель наслаиваемого изображения
         m_table.PixelSet(x+lx,y+ly,foreground);
        }
     }
  }
//+------------------------------------------------------------------+
//| Рисует текст                                                     |
//+------------------------------------------------------------------+
void CTable::DrawText(void)
  {
//--- Для расчёта координат и отступов
   int  x=0,y=0;
   uint text_align=0;
//--- Свойства шрифта
   m_table.FontSet(CElement::Font(),-CElement::FontSize()*10,FW_NORMAL);
//--- Столбцы
   for(uint c=0; c<m_columns_total; c++)
     {
      //--- Получим X-координату текста
      x=TextX(c);
      //--- Получим способ выравнивания текста
      text_align=TextAlign(c,TA_TOP);
      //--- Ряды
      for(uint r=m_visible_table_from_index; r<m_visible_table_to_index; r++)
        {
         //--- Рассчитаем Y-координату
         y=m_rows[r].m_y+m_label_y_gap;
         //--- Нарисовать текст
         m_table.TextOut(x,y,Text(c,r),TextColor(c,r),text_align);
        }
      //--- Обнулить координату Y для следующего цикла
      y=0;
     }
  }
//+------------------------------------------------------------------+
//| Рисует заголовки таблицы                                         |
//+------------------------------------------------------------------+
void CTable::DrawTableHeaders(void)
  {
//--- Нарисовать заголовки
   DrawHeaders();
//--- Нарисовать сетку
   DrawHeadersGrid();
//--- Нарисовать текст заголовков
   DrawHeadersText();
//--- Нарисовать признак возможности сортировки таблицы
   DrawSignSortedData();
  }
//+------------------------------------------------------------------+
//| Рисует фон заголовков                                            |
//+------------------------------------------------------------------+
void CTable::DrawHeaders(void)
  {
//--- Если не в фокусе, сбросить цвет заголовков
   if(!m_headers.MouseFocus() && m_column_resize_control==WRONG_VALUE)
     {
      m_headers.Erase(::ColorToARGB(m_headers_color,m_alpha));
      return;
     }
//--- Для проверки фокуса над заголовками
   bool is_header_focus=false;
//--- Координаты курсора мыши
   int x=0;
//--- Координаты
   int y1=0,y2=m_header_y_size;
//--- Получим относительную X-координату под курсором мыши
   if(::CheckPointer(m_mouse)!=POINTER_INVALID)
      x=m_mouse.RelativeX(m_headers);
//--- Очистить фон заголовков
   m_headers.Erase(::ColorToARGB(clrNONE,m_alpha));
//--- Отступ с учётом режима изменения ширины столбцов
   int sep_x_offset=(m_column_resize_mode)? m_sep_x_offset : 0;
//--- Рисуем фон заголовков
   for(uint i=0; i<m_columns_total; i++)
     {
      //--- Проверим фокус
      if(is_header_focus=x>m_columns[i].m_x+((i!=0)? sep_x_offset : 0) && x<=m_columns[i].m_x2+sep_x_offset)
         m_prev_header_index_focus=(int)i;
      //--- Определим цвет заголовка
      uint clr=(i==m_column_resize_control)? ::ColorToARGB(m_headers_color_hover,m_alpha) : HeaderColorCurrent(is_header_focus);
      //--- Нарисовать фон заголовка
      m_headers.FillRectangle(m_columns[i].m_x,y1,m_columns[i].m_x2,y2,clr);
     }
  }
//+------------------------------------------------------------------+
//| Рисует сетку заголовков таблицы                                  |
//+------------------------------------------------------------------+
void CTable::DrawHeadersGrid(void)
  {
//--- Цвет сетки
   uint clr=::ColorToARGB(m_grid_color);
//--- Координаты
   int x1=0,x2=0,y1=0,y2=0;
   x2=m_table_x_size-1;
   y2=m_header_y_size-1;
//--- Нарисовать рамку
   m_headers.Line(x1,y2,x2,y2,clr);
//--- Разделительные линии
   x2=x1=m_columns[0].m_width;
   for(uint i=1; i<m_columns_total; i++)
      m_headers.Line(m_columns[i].m_x,y1,m_columns[i].m_x,y2,clr);
  }
//+------------------------------------------------------------------+
//| Рисует признак возможности сортировки таблицы                    |
//+------------------------------------------------------------------+
void CTable::DrawSignSortedData(void)
  {
//--- Выйти, если (1) сортировка отключена или (2) ещё не была осуществлена
   if(!m_is_sort_mode || m_is_sorted_column_index==WRONG_VALUE)
      return;
//--- Выйти, если в ячейках есть поля ввода или комбо-боксы в ячейках
   if(m_edit_state && m_combobox_state)
      return;
//--- Расчёт координат
   int x =m_columns[m_is_sorted_column_index].m_x2-m_sort_arrow_x_gap;
   int y =m_sort_arrow_y_gap;
//--- Выбранная картинка по направлению сортировки
   int image_index=(m_last_sort_direction==SORT_ASCENDING)? 0 : 1;
//--- Рисуем
   for(uint ly=0,i=0; ly<m_sort_arrows[image_index].Height(); ly++)
     {
      for(uint lx=0; lx<m_sort_arrows[image_index].Width(); lx++,i++)
        {
         //--- Если нет цвета, перейти к следующему пикселю
         if(m_sort_arrows[image_index].Data(i)<1)
            continue;
         //--- Получаем цвет нижнего слоя (фона заголовка) и цвет указанного пикселя картинки
         uint background  =m_headers.PixelGet(x+lx,y+ly);
         uint pixel_color =m_sort_arrows[image_index].Data(i);
         //--- Смешиваем цвета
         uint foreground=::ColorToARGB(m_clr.BlendColors(background,pixel_color));
         //--- Рисуем пиксель наслаиваемого изображения
         m_headers.PixelSet(x+lx,y+ly,foreground);
        }
     }
  }
//+------------------------------------------------------------------+
//| Рисует текст заголовков таблицы                                  |
//+------------------------------------------------------------------+
void CTable::DrawHeadersText(void)
  {
//--- Для расчёта координат и отступов
   int x=0,y=m_header_y_size/2;
   int column_offset =0;
   uint text_align   =0;
//--- Цвет текста
   uint clr=::ColorToARGB(m_headers_text_color);
//--- Свойства шрифта
   m_headers.FontSet(CElement::Font(),-CElement::FontSize()*10,FW_NORMAL);
//--- Нарисовать текст
   for(uint c=0; c<m_columns_total; c++)
     {
      //--- Получим X-координату текста
      x=TextX(c,true);
      //--- Получим способ выравнивания текста
      text_align=TextAlign(c,TA_VCENTER);
      //--- Нарисовать название столбца
      m_headers.TextOut(x,y,CorrectingText(c,0,true),clr,text_align);
     }
  }
//+------------------------------------------------------------------+
//| Изменение цвета объектов таблицы                                 |
//+------------------------------------------------------------------+
void CTable::ChangeObjectsColor(void)
  {
//--- Отслеживаем изменение цвета, только если не в режиме изменения ширины столбца
   if(m_column_resize_control!=WRONG_VALUE)
      return;
//--- Изменение цвета заголовков
   ChangeHeadersColor();
//--- Изменение цвета рядов при наведении курсора мыши
   ChangeRowsColor();
  }
//+------------------------------------------------------------------+
//| Изменение цвета заголовков при наведении курсора мыши            |
//+------------------------------------------------------------------+
void CTable::ChangeHeadersColor(void)
  {
//--- Выйти, если заголовки отключены
   if(!m_show_headers)
      return;
//--- Если указатель курсора активирован
   if(m_column_resize_control==WRONG_VALUE && 
      m_column_resize.IsVisible() && m_mouse.LeftButtonState())
     {
      //--- Запомним индекс захваченного столбца
      m_column_resize_control=m_prev_header_index_focus;
      //--- Отправим сообщение на определение доступных элементов
      ::EventChartCustom(m_chart_id,ON_SET_AVAILABLE,CElementBase::Id(),0,"");
      //--- Отправим сообщение об изменении в графическом интерфейсе
      ::EventChartCustom(m_chart_id,ON_CHANGE_GUI,CElementBase::Id(),0,"");
      return;
     }
//--- Если не в фокусе
   if(!m_headers.MouseFocus())
     {
      //--- Если ещё не отмечено, что не в фокусе
      if(m_prev_header_index_focus!=WRONG_VALUE)
        {
         //--- Сбросить фокус
         m_prev_header_index_focus=WRONG_VALUE;
         //--- Изменить цвет
         DrawTableHeaders();
         m_headers.Update();
        }
     }
//--- Если в фокусе
   else
     {
      //--- Проверить фокус над заголовками
      CheckHeaderFocus();
      //--- Если нет фокуса
      if(m_prev_header_index_focus==WRONG_VALUE)
        {
         //--- Изменить цвет
         DrawTableHeaders();
         m_headers.Update();
        }
     }
  }
//+------------------------------------------------------------------+
//| Изменение цвета рядов при наведении курсора мыши                 |
//+------------------------------------------------------------------+
void CTable::ChangeRowsColor(void)
  {
//--- Выйти, если отключена подсветка строк при наведении
   if(!m_lights_hover)
      return;
//--- Если не в фокусе
   if(!m_table.MouseFocus())
     {
      //--- Если ещё не отмечено, что не в фокусе
      if(m_prev_item_index_focus!=WRONG_VALUE)
        {
         m_item_index_focus=WRONG_VALUE;
         //--- Изменить цвет
         RedrawRow();
         m_table.Update();
         //--- Сбросить фокус
         m_prev_item_index_focus=WRONG_VALUE;
        }
     }
//--- Если в фокусе
   else
     {
      //--- Проверить фокус над строками
      if(m_item_index_focus==WRONG_VALUE)
        {
         //--- Получим индекс строки в фокусе
         m_item_index_focus=CheckRowFocus();
         //--- Изменить цвет строки
         RedrawRow();
         m_table.Update();
         //--- Сохранить как предыдущий индекс в фокусе
         m_prev_item_index_focus=m_item_index_focus;
         return;
        }
      //--- Получим относительную Y-координату под курсором мыши
      int y=m_mouse.RelativeY(m_table);
      //--- Проверка фокуса
      bool condition=(y>m_rows[m_item_index_focus].m_y && y<=m_rows[m_item_index_focus].m_y2);
      //--- Если фокус изменился
      if(!condition)
        {
         //--- Получим индекс строки в фокусе
         m_item_index_focus=CheckRowFocus();
         //--- Изменить цвет строки
         RedrawRow();
         m_table.Update();
         //--- Сохранить как предыдущий индекс в фокусе
         m_prev_item_index_focus=m_item_index_focus;
        }
     }
  }
//+------------------------------------------------------------------+
//| Проверка фокуса на заголовке                                     |
//+------------------------------------------------------------------+
void CTable::CheckHeaderFocus(void)
  {
//--- Выйти, если (1) заголовки отключены или (2) начали изменение ширины столбца
   if(!m_show_headers || m_column_resize_control!=WRONG_VALUE)
      return;
//--- Получим относительную X-координату под курсором мыши
   int x=m_mouse.RelativeX(m_headers);
//--- Отступ с учётом режима изменения ширины столбцов
   int sep_x_offset=(m_column_resize_mode)? m_sep_x_offset : 0;
//--- Ищем фокус
   for(uint i=0; i<m_columns_total; i++)
     {
      //--- Если фокус заголовка изменился
      if((x>m_columns[i].m_x+sep_x_offset && x<=m_columns[i].m_x2+sep_x_offset) && m_prev_header_index_focus!=i)
        {
         m_prev_header_index_focus=WRONG_VALUE;
         break;
        }
     }
  }
//+------------------------------------------------------------------+
//| Определение индексов видимой области таблицы                     |
//+------------------------------------------------------------------+
void CTable::VisibleTableIndexes(void)
  {
//--- Определяем границы с учётом смещения видимой области таблицы
   int yoffset1 =(int)::ObjectGetInteger(m_chart_id,m_table.ChartObjectName(),OBJPROP_YOFFSET);
   int yoffset2 =yoffset1+m_table_visible_y_size;
//--- Определяем первый и последний индексы видимой области таблицы
   m_visible_table_from_index =int(double(yoffset1/m_cell_y_size));
   m_visible_table_to_index   =int(double(yoffset2/m_cell_y_size));
//--- Нижний индекс на один больше, если не выходим из диапазона
   m_visible_table_to_index=(m_visible_table_to_index+1>m_rows_total)? m_rows_total : m_visible_table_to_index+1;
  }
//+------------------------------------------------------------------+
//| Проверка фокуса на рядах таблицы                                 |
//+------------------------------------------------------------------+
int CTable::CheckRowFocus(void)
  {
   int item_index_focus=WRONG_VALUE;
//--- Получим относительную Y-координату под курсором мыши
   int y=m_mouse.RelativeY(m_table);
///--- Получим индексы локальной области таблицы
   VisibleTableIndexes();
//--- Ищем фокус
   for(uint i=m_visible_table_from_index; i<m_visible_table_to_index; i++)
     {
      //--- Если фокус строки изменился
      if(y>m_rows[i].m_y && y<=m_rows[i].m_y2)
        {
         item_index_focus=(int)i;
         break;
        }
     }
//--- Вернём индекс строки в фокусе
   return(item_index_focus);
  }
//+------------------------------------------------------------------+
//| Проверка фокуса на границах заголовков для изменения их ширины   |
//+------------------------------------------------------------------+
void CTable::CheckColumnResizeFocus(void)
  {
//--- Выйти, если режим изменения ширины столбцов отключен
   if(!m_column_resize_mode)
      return;
//--- Выйти, если начали изменение ширины столбца
   if(m_column_resize_control!=WRONG_VALUE)
     {
      //--- Обновить координаты указателя
      m_column_resize.Moving(m_mouse.X(),m_mouse.Y());
      return;
     }
//--- Для проверки фокуса над границами заголовков
   bool is_focus=false;
//--- Если курсор мыши в области заголовков
   if(m_headers.MouseFocus())
     {
      //--- Получим относительную X-координату под курсором мыши    
      int x=m_mouse.RelativeX(m_headers);
      //--- Ищем фокус
      for(uint i=0; i<m_columns_total; i++)
        {
         if(is_focus=x>m_columns[i].m_x2-m_sep_x_offset && x<=m_columns[i].m_x2+m_sep_x_offset)
            break;
        }
      //--- Если есть фокус
      if(is_focus)
        {
         //--- Обновить координаты указателя и сделать его видимым
         m_column_resize.Moving(m_mouse.X(),m_mouse.Y());
         m_column_resize.Reset();
         m_chart.Redraw();
        }
      else
        {
         m_column_resize.Hide();
        }
     }
//--- Скрыть указатель, если нет фокуса
   else if(!is_focus)
      m_column_resize.Hide();
  }
//+------------------------------------------------------------------+
//| Изменяет ширину захваченного столбца                             |
//+------------------------------------------------------------------+
void CTable::ChangeColumnWidth(void)
  {
//--- Выйти, если заголовки отключены
   if(!m_show_headers)
      return;
//--- Проверка фокуса на границах заголовков
   CheckColumnResizeFocus();
//--- Если закончили, сбросим значения
   if(m_column_resize_control==WRONG_VALUE)
     {
      m_column_resize_x_fixed    =0;
      m_column_resize_prev_width =0;
      m_column_resize_prev_thumb =0;
      return;
     }
//--- Получим относительную X-координату под курсором мыши
   int x=m_mouse.RelativeX(m_headers);
//--- Если только начали изменение ширины столбца
   if(m_column_resize_x_fixed<1)
     {
      //--- Запомним текущую X-координату и ширину столбца
      m_column_resize_x_fixed    =x;
      m_column_resize_prev_width =m_columns[m_column_resize_control].m_width;
      m_column_resize_prev_thumb =m_scrollh.CurrentPos();
     }
//--- Рассчитаем новую ширину для столбца
   int new_width=m_column_resize_prev_width+(x-m_column_resize_x_fixed);
//--- Оставить без изменений, если меньше установленного ограничения
   if(new_width<m_min_column_width)
      return;
//--- Сохраним новую ширину столбца
   m_columns[m_column_resize_control].m_width=new_width;
//--- Рассчитать размеры таблицы
   CalculateTableSize();
//--- Установить новый размер таблице
   ChangeTableSize();
//--- Корректируем ползунок полосы прокрутки, если его позиция изменилась
   if(m_scrollh.CurrentPos()!=m_column_resize_prev_thumb)
     {
      m_scrollh.MovingThumb(m_column_resize_prev_thumb);
      //--- Корректировка таблицы относительно полос прокрутки
      ShiftTable();
     }
//--- Нарисуем таблицу
   DrawTable(true);
   Update();
   if(m_scrollh.IsScroll())
      m_scrollh.Update(true);
   if(m_scrollv.IsScroll())
      m_scrollv.Update(true);
  }
//+------------------------------------------------------------------+
//| Проверить выход из диапазона столбцов                            |
//+------------------------------------------------------------------+
template<typename T>
int CTable::CheckArraySize(const T &array[])
  {
   int total=0;
   int array_size=::ArraySize(array);
//--- Выйти, если передан массив нулевого размера
   if(array_size<1)
      return(WRONG_VALUE);
//--- Скорректировать значение для предотвращения выхода из диапазона массива 
   total=(array_size<(int)m_columns_total)? array_size :(int)m_columns_total;
//--- Вернуть скорректированный размер массива
   return(total);
  }
//+------------------------------------------------------------------+
//| Проверить выход из диапазона столбцов                            |
//+------------------------------------------------------------------+
bool CTable::CheckOutOfColumnRange(const uint column_index)
  {
//--- Проверка на выход из диапазона столбцов
   uint csize=::ArraySize(m_columns);
   if(csize<1 || column_index>=csize)
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Проверить выход из диапазона столбцов и рядов                    |
//+------------------------------------------------------------------+
bool CTable::CheckOutOfRange(const uint column_index,const uint row_index)
  {
//--- Проверка на выход из диапазона столбцов
   uint csize=::ArraySize(m_columns);
   if(csize<1 || column_index>=csize)
      return(false);
//--- Проверка на выход из диапазона рядов
   uint rsize=::ArraySize(m_columns[column_index].m_rows);
   if(rsize<1 || row_index>=rsize)
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Расчёт с учётом последних изменений и изменение размеров таблицы |
//+------------------------------------------------------------------+
void CTable::RecalculateAndResizeTable(const bool redraw=false)
  {
//--- Рассчитать размеры таблицы
   CalculateTableSize();
//--- Установить новый размер таблице
   ChangeTableSize();
//--- Обновить таблицу
   Update(redraw);
//---
   if(RowsTotal()>(uint)VisibleRowsTotal())
      ::EventChartCustom(m_chart_id,ON_CHANGE_GUI,0,0.0,"");
  }
//+------------------------------------------------------------------+
//| Инициализация указанного столбца значениями по умолчанию         |
//+------------------------------------------------------------------+
void CTable::ColumnInitialize(const uint column_index)
  {
//--- Инициализация свойств столбцов значениями по умолчанию
   m_columns[column_index].m_x              =0;
   m_columns[column_index].m_x2             =0;
   m_columns[column_index].m_width          =m_default_width;
   m_columns[column_index].m_data_type      =m_default_type_data;
   m_columns[column_index].m_text_align     =m_default_text_align;
   m_columns[column_index].m_text_x_offset  =m_label_x_gap;
   m_columns[column_index].m_image_x_offset =m_icon_x_gap;
   m_columns[column_index].m_image_y_offset =m_icon_y_gap;
   m_columns[column_index].m_header_text    ="";
  }
//+------------------------------------------------------------------+
//| Инициализация указанной ячейки значениями по умолчанию           |
//+------------------------------------------------------------------+
void CTable::CellInitialize(const uint column_index,const uint row_index)
  {
   m_columns[column_index].m_rows[row_index].m_full_text      ="";
   m_columns[column_index].m_rows[row_index].m_short_text     ="";
   m_columns[column_index].m_rows[row_index].m_selected_image =0;
   m_columns[column_index].m_rows[row_index].m_text_color     =m_label_color;
   m_columns[column_index].m_rows[row_index].m_back_color     =m_back_color;
   m_columns[column_index].m_rows[row_index].m_digits         =0;
   m_columns[column_index].m_rows[row_index].m_type           =CELL_SIMPLE;
//--- По умолчанию у ячейки нет картинок
   ::ArrayFree(m_columns[column_index].m_rows[row_index].m_images);
  }
//+------------------------------------------------------------------+
//| Делает копию указанного столбца (source) в новое место (dest.)   |
//+------------------------------------------------------------------+
void CTable::ColumnCopy(const uint destination,const uint source)
  {
   m_columns[destination].m_header_text    =m_columns[source].m_header_text;
   m_columns[destination].m_width          =m_columns[source].m_width;
   m_columns[destination].m_data_type      =m_columns[source].m_data_type;
   m_columns[destination].m_text_align     =m_columns[source].m_text_align;
   m_columns[destination].m_text_x_offset  =m_columns[source].m_text_x_offset;
   m_columns[destination].m_image_x_offset =m_columns[source].m_image_x_offset;
   m_columns[destination].m_image_y_offset =m_columns[source].m_image_y_offset;
  }
//+------------------------------------------------------------------+
//| Делает копию указанной ячейки (source) в новое место (dest.)     |
//+------------------------------------------------------------------+
void CTable::CellCopy(const uint column_dest,const uint row_dest,const uint column_source,const uint row_source)
  {
   m_columns[column_dest].m_rows[row_dest].m_type           =m_columns[column_source].m_rows[row_source].m_type;
   m_columns[column_dest].m_rows[row_dest].m_digits         =m_columns[column_source].m_rows[row_source].m_digits;
   m_columns[column_dest].m_rows[row_dest].m_full_text      =m_columns[column_source].m_rows[row_source].m_full_text;
   m_columns[column_dest].m_rows[row_dest].m_short_text     =m_columns[column_source].m_rows[row_source].m_short_text;
   m_columns[column_dest].m_rows[row_dest].m_text_color     =m_columns[column_source].m_rows[row_source].m_text_color;
   m_columns[column_dest].m_rows[row_dest].m_back_color     =m_columns[column_source].m_rows[row_source].m_back_color;
   m_columns[column_dest].m_rows[row_dest].m_selected_image =m_columns[column_source].m_rows[row_source].m_selected_image;
//--- Копируем размер массива из источника в приёмник
   int images_total=::ArraySize(m_columns[column_source].m_rows[row_source].m_images);
   ::ArrayResize(m_columns[column_dest].m_rows[row_dest].m_images,images_total);
//---
   for(int i=0; i<images_total; i++)
     {
      //--- Копировать, если есть картинки
      if(m_columns[column_source].m_rows[row_source].m_images[i].DataTotal()<1)
         continue;
      //--- Делаем копию картинки
      ImageCopy(m_columns[column_dest].m_rows[row_dest].m_images,m_columns[column_source].m_rows[row_source].m_images,i);
     }
  }
//+------------------------------------------------------------------+
//| Копирует данные изображения из одного массива в другой           |
//+------------------------------------------------------------------+
void CTable::ImageCopy(CImage &destination[],CImage &source[],const int index)
  {
//--- Копируем пиксели картинки
   destination[index].CopyImageData(source[index]);
//--- Копируем свойства картинки
   destination[index].Width(source[index].Width());
   destination[index].Height(source[index].Height());
   destination[index].BmpPath(source[index].BmpPath());
  }
//+------------------------------------------------------------------+
//| Возвращает текст                                                 |
//+------------------------------------------------------------------+
string CTable::Text(const int column_index,const int row_index)
  {
   string text="";
//--- Корректируем текст, если не в режиме изменения ширины столбца
   if(m_column_resize_control==WRONG_VALUE)
      text=CorrectingText(column_index,row_index);
//--- Если же в режиме изменения ширины столбца, то...
   else
     {
      //--- ...корректируем текст только для того столбца, ширину которого изменяем
      if(column_index==m_column_resize_control)
         text=CorrectingText(column_index,row_index);
      //--- Для всех остальных используем уже ранее откорректированный текст
      else
         text=m_columns[column_index].m_rows[row_index].m_short_text;
     }
//--- Вернём текст
   return(text);
  }
//+------------------------------------------------------------------+
//| Возвращает X-координату текста в указанном столбце               |
//+------------------------------------------------------------------+
int CTable::TextX(const int column_index,const bool headers=false)
  {
   int x=0;
//--- Выравнивание текста в ячейках по установленному режиму для каждого столбца
   switch(m_columns[column_index].m_text_align)
     {
      //--- По центру
      case ALIGN_CENTER :
         x=m_columns[column_index].m_x+(m_columns[column_index].m_width/2);
         break;
         //--- Cправа
      case ALIGN_RIGHT :
        {
         int x_offset=0;
         //---
         if(headers)
           {
            bool condition=(m_is_sorted_column_index!=WRONG_VALUE && m_is_sorted_column_index==column_index);
            x_offset=(condition)? m_label_x_gap+m_sort_arrow_x_gap : m_label_x_gap;
           }
         else
            x_offset=m_columns[column_index].m_text_x_offset;
         //---
         x=m_columns[column_index].m_x2-x_offset;
         break;
        }
      //--- Слева
      case ALIGN_LEFT :
         x=m_columns[column_index].m_x+((headers)? m_label_x_gap : m_columns[column_index].m_text_x_offset);
         break;
     }
//--- Вернуть способ выравнивания
   return(x);
  }
//+------------------------------------------------------------------+
//| Возвращает способ выравнивания текста в указанном столбце        |
//+------------------------------------------------------------------+
uint CTable::TextAlign(const int column_index,const uint anchor)
  {
   uint text_align=0;
//--- Выравнивание текста для текущего столбца
   switch(m_columns[column_index].m_text_align)
     {
      case ALIGN_CENTER :
         text_align=TA_CENTER|anchor;
         break;
      case ALIGN_RIGHT :
         text_align=TA_RIGHT|anchor;
         break;
      case ALIGN_LEFT :
         text_align=TA_LEFT|anchor;
         break;
     }
//--- Вернуть способ выравнивания
   return(text_align);
  }
//+------------------------------------------------------------------+
//| Возвращает цвет текста ячейки                                    |
//+------------------------------------------------------------------+
uint CTable::TextColor(const int column_index,const int row_index)
  {
   uint clr=(row_index==m_selected_item)? m_selected_row_text_color : m_columns[column_index].m_rows[row_index].m_text_color;
//--- Вернуть цвет заголовка
   return(::ColorToARGB(clr));
  }
//+------------------------------------------------------------------+
//| Возвращает цвет фона ячейки                                      |
//+------------------------------------------------------------------+
uint CTable::BackColor(const int column_index,const int row_index)
  {
   uint clr=(row_index==m_selected_item)? m_selected_row_color : m_columns[column_index].m_rows[row_index].m_back_color;
//--- Вернуть цвет заголовка
   return(::ColorToARGB(clr));
  }
//+------------------------------------------------------------------+
//| Возвращает текущий цвет фона заголовка                           |
//+------------------------------------------------------------------+
uint CTable::HeaderColorCurrent(const bool is_header_focus)
  {
   uint clr=clrNONE;
//--- Если нет фокуса
   if(!is_header_focus || !m_headers.MouseFocus())
      clr=m_headers_color;
   else
     {
      //--- Если левая кнопка мыши нажата и не в процессе изменения ширины столбца
      bool condition=(m_mouse.LeftButtonState() && m_column_resize_control==WRONG_VALUE);
      clr=(condition)? m_headers_color_pressed : m_headers_color_hover;
     }
//--- Вернуть цвет заголовка
   return(::ColorToARGB(clr,m_alpha));
  }
//+------------------------------------------------------------------+
//| Возвращает текущий цвет фона строки                              |
//+------------------------------------------------------------------+
uint CTable::RowColorCurrent(const int column_index,const int row_index,const bool is_row_focus)
  {
//--- Если выделенная строка
   if(row_index==m_selected_item)
      return(::ColorToARGB(m_selected_row_color,m_alpha));
//--- Цвет ряда
   uint clr=m_cell_color;
//--- Если (1) нет фокуса или (2) в процессе изменения ширины столбца или (3) форма заблокирована
   bool condition=(!is_row_focus || !m_table.MouseFocus() || m_column_resize_control!=WRONG_VALUE || m_main.CElementBase::IsLocked());
//--- Если включен режим форматирования в стиле "Зебра"
   if(m_is_zebra_format_rows!=clrNONE)
     {
      if(condition)
         clr=(row_index%2!=0)? m_is_zebra_format_rows : m_cell_color;
      else
         clr=m_cell_color_hover;
     }
   else
     {
      clr=(condition)? m_columns[column_index].m_rows[row_index].m_back_color : m_cell_color_hover;
     }
//--- Вернуть цвет
   return(::ColorToARGB(clr,m_alpha));
  }
//+------------------------------------------------------------------+
//| Возвращает откорректированный текст по ширине столбца            |
//+------------------------------------------------------------------+
string CTable::CorrectingText(const int column_index,const int row_index,const bool headers=false)
  {
//--- Получим текущий текст
   string corrected_text=(headers)? m_columns[column_index].m_header_text : m_columns[column_index].m_rows[row_index].m_full_text;
//--- Отступы от краёв ячейки по оси X
   int x_offset=0;
//---
   if(headers)
      x_offset=(m_is_sorted_column_index==WRONG_VALUE)? m_label_x_gap*2 : m_label_x_gap+m_sort_arrow_x_gap;
   else
      x_offset=m_label_x_gap+m_columns[column_index].m_text_x_offset;
//--- Получим указатель на объект холста
   CRectCanvas *obj=(headers)? ::GetPointer(m_headers) : ::GetPointer(m_table);
//--- Получим ширину текста
   int full_text_width=obj.TextWidth(corrected_text);
//--- Пространство для строки
   int space_width=m_columns[column_index].m_width-x_offset;
//--- Если помещаемся в ячейку, сохраним скорректированный текст в отдельный массив и вернём его
   if(full_text_width<=space_width)
     {
      //--- Если это не заголовки, сохраним откорректированный текст
      if(!headers)
         m_columns[column_index].m_rows[row_index].m_short_text=corrected_text;
      //---
      return(corrected_text);
     }
//--- Если текст не помещается в ячейку, нужно скорректировать его (обрезать лишние символы и добавить многоточие)
   else
     {
      //--- Для работы со строкой
      string temp_text="";
      //--- Получим длину строки
      int total=::StringLen(corrected_text);
      //--- Будем удалять у строки по одному символу, пока не достигнем нужной ширины текста
      for(int i=total-1; i>=0; i--)
        {
         //--- Удалим один символ
         temp_text=::StringSubstr(corrected_text,0,i);
         //--- Если ничего не осталось, оставим пустую строку
         if(temp_text=="")
           {
            corrected_text="";
            break;
           }
         //--- Добавим многоточие перед проверкой
         int text_width=obj.TextWidth(temp_text+"...");
         //--- Если помещаемся в ячейку
         if(text_width<space_width)
           {
            //--- Сохраняем текст и останавливаем цикл
            corrected_text=temp_text+"...";
            break;
           }
        }
     }
//--- Если это не заголовки, сохраним откорректированный текст
   if(!headers)
      m_columns[column_index].m_rows[row_index].m_short_text=corrected_text;
//--- Вернём скорректированный текст
   return(corrected_text);
  }
//+------------------------------------------------------------------+
//| Перемещение элемента                                             |
//+------------------------------------------------------------------+
void CTable::Moving(const bool only_visible=true)
  {
//--- Выйти, если элемент скрыт
   if(only_visible)
      if(!CElementBase::IsVisible())
         return;
//--- Если привязка справа
   if(m_anchor_right_window_side)
     {
      //--- Сохранение координат в полях элемента
      CElementBase::X(m_main.X2()-XGap());
      //--- Сохранение координат в полях объектов
      m_table.X(m_main.X2()-m_table.XGap());
      m_headers.X(m_main.X2()-m_headers.XGap());
     }
   else
     {
      CElementBase::X(m_main.X()+XGap());
      m_table.X(m_main.X()+m_table.XGap());
      m_headers.X(m_main.X()+m_headers.XGap());
     }
//--- Если привязка снизу
   if(m_anchor_bottom_window_side)
     {
      CElementBase::Y(m_main.Y2()-YGap());
      m_table.Y(m_main.Y2()-m_table.YGap());
      m_headers.Y(m_main.Y2()-m_headers.YGap());
     }
   else
     {
      CElementBase::Y(m_main.Y()+YGap());
      m_table.Y(m_main.Y()+m_table.YGap());
      m_headers.Y(m_main.Y()+m_headers.YGap());
     }
//--- Обновление координат графических объектов
   ::ObjectSetInteger(m_chart_id,m_table.ChartObjectName(),OBJPROP_XDISTANCE,m_table.X());
   ::ObjectSetInteger(m_chart_id,m_table.ChartObjectName(),OBJPROP_YDISTANCE,m_table.Y());
   ::ObjectSetInteger(m_chart_id,m_headers.ChartObjectName(),OBJPROP_XDISTANCE,m_headers.X());
   ::ObjectSetInteger(m_chart_id,m_headers.ChartObjectName(),OBJPROP_YDISTANCE,m_headers.Y());
//--- Переместить остальные элементы
   CElement::Moving(only_visible);
  }
//+------------------------------------------------------------------+
//| Показывает элемент                                               |
//+------------------------------------------------------------------+
void CTable::Show(void)
  {
//--- Выйти, если элемент уже видим
   if(CElementBase::IsVisible())
      return;
//--- Состояние видимости
   CElementBase::IsVisible(true);
//--- Перемещение элемента
   Moving();
//--- Сделать видимыми все объекты
   ::ObjectSetInteger(m_chart_id,m_canvas.ChartObjectName(),OBJPROP_TIMEFRAMES,OBJ_ALL_PERIODS);
   ::ObjectSetInteger(m_chart_id,m_table.ChartObjectName(),OBJPROP_TIMEFRAMES,OBJ_ALL_PERIODS);
   ::ObjectSetInteger(m_chart_id,m_headers.ChartObjectName(),OBJPROP_TIMEFRAMES,OBJ_ALL_PERIODS);
//---
   if(!m_is_disabled_scrolls)
     {
      if(m_scrollv.IsScroll())
         m_scrollv.Show();
      if(m_scrollh.IsScroll())
         m_scrollh.Show();
     }
  }
//+------------------------------------------------------------------+
//| Скрывает элемент                                                 |
//+------------------------------------------------------------------+
void CTable::Hide(void)
  {
//--- Выйти, если элемент уже скрыт
   if(!CElementBase::IsVisible())
      return;
//--- Скрыть все объекты
   ::ObjectSetInteger(m_chart_id,m_canvas.ChartObjectName(),OBJPROP_TIMEFRAMES,OBJ_NO_PERIODS);
   ::ObjectSetInteger(m_chart_id,m_table.ChartObjectName(),OBJPROP_TIMEFRAMES,OBJ_NO_PERIODS);
   ::ObjectSetInteger(m_chart_id,m_headers.ChartObjectName(),OBJPROP_TIMEFRAMES,OBJ_NO_PERIODS);
   m_scrollv.Hide();
   m_scrollh.Hide();
//--- Состояние видимости
   CElementBase::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| Удаление                                                         |
//+------------------------------------------------------------------+
void CTable::Delete(void)
  {
//--- Удаление графических объектов
   m_table.Destroy();
   m_canvas.Destroy();
   m_headers.Destroy();
   m_column_resize.Delete();
//--- Освобождение массивов элемента
   for(uint c=0; c<m_columns_total; c++)
     {
      for(uint r=0; r<m_rows_total; r++)
        {
         for(int i=0; i<ImagesTotal(c,r); i++)
            m_columns[c].m_rows[r].m_images[i].DeleteImageData();
         //---
         ::ArrayFree(m_columns[c].m_rows[r].m_images);
        }
     }
//---
   for(uint c=0; c<m_columns_total; c++)
      ::ArrayFree(m_columns[c].m_rows);
//---
   uint total=ArraySize(m_sort_arrows);
   for(uint i=0; i<total; i++)
      m_sort_arrows[i].DeleteImageData();
//---
   ::ArrayFree(m_rows);
   ::ArrayFree(m_columns);
   ::ArrayFree(m_sort_arrows);
//--- Инициализация переменных значениями по умолчанию
   CElementBase::IsVisible(true);
   m_is_sorted_column_index=WRONG_VALUE;
  }
//+------------------------------------------------------------------+
//| Установка приоритетов                                            |
//+------------------------------------------------------------------+
void CTable::SetZorders(void)
  {
   CElement::SetZorders();
   ::ObjectSetInteger(m_chart_id,m_table.ChartObjectName(),OBJPROP_ZORDER,m_zorder+1);
   ::ObjectSetInteger(m_chart_id,m_headers.ChartObjectName(),OBJPROP_ZORDER,m_zorder+1);
  }
//+------------------------------------------------------------------+
//| Сброс приоритетов                                                |
//+------------------------------------------------------------------+
void CTable::ResetZorders(void)
  {
   CElement::ResetZorders();
   ::ObjectSetInteger(m_chart_id,m_table.ChartObjectName(),OBJPROP_ZORDER,WRONG_VALUE);
   ::ObjectSetInteger(m_chart_id,m_headers.ChartObjectName(),OBJPROP_ZORDER,WRONG_VALUE);
  }
//+------------------------------------------------------------------+
//| Ускоренная промотка полосы прокрутки                             |
//+------------------------------------------------------------------+
void CTable::FastSwitching(void)
  {
//--- Выйдем, если нет фокуса на списке
   if(!CElementBase::MouseFocus())
      return;
//--- Вернём счётчик к первоначальному значению, если кнопка мыши отжата
   if(!m_mouse.LeftButtonState() || m_scrollv.State() || m_scrollh.State())
      m_timer_counter=SPIN_DELAY_MSC;
//--- Если же кнопка мыши нажата
   else
     {
      //--- Увеличим счётчик на установленный интервал
      m_timer_counter+=TIMER_STEP_MSC;
      //--- Выйдем, если меньше нуля
      if(m_timer_counter<0)
         return;
      //---
      bool scroll_v=false,scroll_h=false;
      //--- Если прокрутка вверх
      if(m_scrollv.GetIncButtonPointer().MouseFocus())
        {
         m_scrollv.OnClickScrollInc((uint)Id(),0);
         scroll_v=true;
        }
      //--- Если прокрутка вниз
      else if(m_scrollv.GetDecButtonPointer().MouseFocus())
        {
         m_scrollv.OnClickScrollDec((uint)Id(),1);
         scroll_v=true;
        }
      //--- Если прокрутка влево
      else if(m_scrollh.GetIncButtonPointer().MouseFocus())
        {
         m_scrollh.OnClickScrollInc((uint)Id(),2);
         scroll_h=true;
        }
      //--- Если прокрутка вправо
      else if(m_scrollh.GetDecButtonPointer().MouseFocus())
        {
         m_scrollh.OnClickScrollDec((uint)Id(),3);
         scroll_h=true;
        }
      //--- Выйти, если ни одна кнопка не нажата
      if(!scroll_v && !scroll_h)
         return;
      //--- Смещает таблицу
      ShiftTable();
      //--- Обновить полосы прокрутки
      if(scroll_v) m_scrollv.Update(true);
      if(scroll_h) m_scrollh.Update(true);
     }
  }
//+------------------------------------------------------------------+
//| Рассчитывает размеры таблицы                                     |
//+------------------------------------------------------------------+
void CTable::CalculateTableSize(void)
  {
//--- Рассчитаем общую ширину и высоту таблицы
   CalculateTableXSize();
   CalculateTableYSize();
//--- Рассчитывает видимые размеры таблицы (два раза на случай, когда нужно отобразить обе полосы прокрутки)
   for(int i=0; i<2; i++)
     {
      CalculateTableVisibleXSize();
      CalculateTableVisibleYSize();
     }
  }
//+------------------------------------------------------------------+
//| Рассчитывает полный размер таблицы по оси X                      |
//+------------------------------------------------------------------+
void CTable::CalculateTableXSize(void)
  {
//--- Рассчитаем общую ширину таблицы
   m_table_x_size=0;
   for(uint c=0; c<m_columns_total; c++)
      m_table_x_size=m_table_x_size+m_columns[c].m_width;
  }
//+------------------------------------------------------------------+
//| Рассчитывает полный размер таблицы по оси Y                      |
//+------------------------------------------------------------------+
void CTable::CalculateTableYSize(void)
  {
//--- Рассчитаем общую высоту таблицы
   m_table_y_size=(int)(m_cell_y_size*m_rows_total)+1;
  }
//+------------------------------------------------------------------+
//| Рассчитывает видимый размер таблицы по оси X                     |
//+------------------------------------------------------------------+
void CTable::CalculateTableVisibleXSize(void)
  {
   if(m_is_disabled_scrolls)
     {
      m_table_visible_x_size=m_table_x_size-1;
      return;
     }
//--- Ширина таблицы с учётом наличия вертикальной полосы прокрутки
   int x_size=(m_table_y_size>m_table_visible_y_size) ? m_x_size-m_scrollh.ScrollWidth()-2 : m_x_size-2;
//--- Зададим ширину фрейма для показа фрагмента изображения (видимой части таблицы таблицы)
   m_table_visible_x_size=x_size;
//--- Корректировка размера видимой части по оси X
   m_table_visible_x_size=(m_table_visible_x_size>=m_table_x_size)? m_table_x_size : m_table_visible_x_size;
//--- Сохраним ограничение по смещению
   m_shift_x2_limit=m_table_x_size-m_table_visible_x_size;
  }
//+------------------------------------------------------------------+
//| Рассчитывает видимый размер таблицы по оси Y                     |
//+------------------------------------------------------------------+
void CTable::CalculateTableVisibleYSize(void)
  {
   if(m_is_disabled_scrolls)
     {
      m_table_visible_y_size=m_table_y_size-1;
      return;
     }
//--- Расчёт количества шагов для смещения
   uint x_size_total         =m_table_x_size/m_shift_x_step;
   uint visible_x_size_total =m_table_visible_x_size/m_shift_x_step;
//--- Если есть заголовки и гориз. полоса прокрутки, то скорректировать размер элемента по оси Y
   int header_y_size=(m_show_headers)? m_header_y_size : 2;
   int y_size=(x_size_total>visible_x_size_total) ? m_y_size-header_y_size-m_scrollv.ScrollWidth()-2 : m_y_size-header_y_size-2;
//--- Зададим высоту фрейма для показа фрагмента изображения (видимой части таблицы таблицы)
   m_table_visible_y_size=y_size;
//--- Корректировка размера видимой части по оси Y
   m_table_visible_y_size=(m_table_visible_y_size>=m_table_y_size)? m_table_y_size : m_table_visible_y_size;
//--- Сохраним ограничение по смещению
   m_shift_y2_limit=m_table_y_size-m_table_visible_y_size;
  }
//+------------------------------------------------------------------+
//| Изменить основные размеры таблицы                                |
//+------------------------------------------------------------------+
void CTable::ChangeMainSize(const int x_size,const int y_size)
  {
//--- Установить новый размер фону таблицы
   CElementBase::XSize(x_size);
   CElementBase::YSize(y_size);
   m_canvas.XSize(x_size);
   m_canvas.YSize(y_size);
   m_canvas.Resize(x_size,y_size);
  }
//+------------------------------------------------------------------+
//| Изменить размеры таблицы                                         |
//+------------------------------------------------------------------+
void CTable::ChangeTableSize(void)
  {
//--- Установить новый размер таблице
   m_table.XSize(m_table_visible_x_size);
   m_table.YSize(m_table_visible_y_size);
   m_headers.XSize(m_table_visible_x_size);
   m_headers.YSize(m_header_y_size);
   m_table.Resize(m_table_x_size,m_table_y_size);
   m_headers.Resize(m_table_x_size,m_header_y_size);
//--- Установим размеры видимой области
   ::ObjectSetInteger(m_chart_id,m_table.ChartObjectName(),OBJPROP_XSIZE,m_table_visible_x_size);
   ::ObjectSetInteger(m_chart_id,m_table.ChartObjectName(),OBJPROP_YSIZE,m_table_visible_y_size);
   ::ObjectSetInteger(m_chart_id,m_headers.ChartObjectName(),OBJPROP_XSIZE,m_table_visible_x_size);
   ::ObjectSetInteger(m_chart_id,m_headers.ChartObjectName(),OBJPROP_YSIZE,m_header_y_size);
//--- Изменить размеры полос прокрутки
   ChangeScrollsSize();
//--- Корректировка данных
   ShiftTable();
  }
//+------------------------------------------------------------------+
//| Изменить размеры полос прокрутки                                 |
//+------------------------------------------------------------------+
void CTable::ChangeScrollsSize(void)
  {
//--- Расчёт количества шагов для смещения
   uint x_size_total         =m_table_x_size/m_shift_x_step;
   uint visible_x_size_total =m_table_visible_x_size/m_shift_x_step;
   uint y_size_total         =RowsTotal();
   uint visible_y_size_total =VisibleRowsTotal();
//--- Рассчитать размеры полос прокрутки
   m_scrollh.Reinit(x_size_total,visible_x_size_total);
   m_scrollv.Reinit(y_size_total,visible_y_size_total);
//--- Если горизонтальная полоса прокрутки не нужна
   if(!m_scrollh.IsScroll())
     {
      //--- Скрыть горизонтальную полосу прокрутки
      m_scrollh.Hide();
      //--- Рассчитать и изменить высоту вертикальной полосы прокрутки
      int y_size=CElementBase::YSize()-2;
      m_scrollv.ChangeYSize(y_size);
     }
   else
     {
      //--- Показать горизонтальную полосу прокрутки
      if(CElementBase::IsVisible() && !m_is_disabled_scrolls)
         m_scrollh.Show();
      //--- Рассчитать и изменить высоту вертикальной полосы прокрутки
      int y_size=CElementBase::YSize()-m_scrollh.ScrollWidth()-2;
      m_scrollv.ChangeYSize(y_size);
     }
//--- Если вертикальная полоса прокрутки не нужна
   if(!m_scrollv.IsScroll())
     {
      //--- Скрыть вертикальную полосу прокрутки
      m_scrollv.Hide();
      //--- Изменить ширину горизонтальной полосы прокрутки
      int x_size=CElementBase::XSize()-1;
      m_scrollh.ChangeXSize(x_size);
     }
   else
     {
      //--- Показать вертикальную полосу прокрутки
      if(CElementBase::IsVisible() && !m_is_disabled_scrolls)
         m_scrollv.Show();
      //--- Рассчитать и изменить ширину горизонтальной полосы прокрутки
      int x_size=CElementBase::XSize()-m_scrollv.ScrollWidth()-1;
      m_scrollh.ChangeXSize(x_size);
     }
  }
//+------------------------------------------------------------------+
//| Изменить ширину по правому краю формы                            |
//+------------------------------------------------------------------+
void CTable::ChangeWidthByRightWindowSide(void)
  {
//--- Выйти, если включен режим фиксации к правому краю формы
   if(m_anchor_right_window_side)
      return;
//--- Размеры
   int x_size =m_main.X2()-m_canvas.X()-m_auto_xresize_right_offset;
   int y_size =(m_auto_yresize_mode)? m_main.Y2()-m_canvas.Y()-m_auto_yresize_bottom_offset : m_y_size;
//--- Выйти, если размер меньше указанного
   if(x_size<100)
      return;
//--- Установить новый размер фона таблицы
   ChangeMainSize(x_size,y_size);
//--- Рассчитать размеры таблицы
   CalculateTableSize();
//--- Установить новый размер таблице
   ChangeTableSize();
//--- Нарисуем таблицу
   DrawTable();
   if(m_scrollh.IsScroll())
      m_scrollh.Update(true);
   if(m_scrollv.IsScroll())
      m_scrollv.Update(true);
  }
//+------------------------------------------------------------------+
//| Изменить высоту по нижнему краю окна                             |
//+------------------------------------------------------------------+
void CTable::ChangeHeightByBottomWindowSide(void)
  {
//--- Выйти, если включен режим фиксации к нижнему краю формы  
   if(m_anchor_bottom_window_side)
      return;
//--- Размеры
   int x_size =(m_auto_xresize_mode)? m_main.X2()-m_canvas.X()-m_auto_xresize_right_offset : m_x_size;
   int y_size =m_main.Y2()-m_canvas.Y()-m_auto_yresize_bottom_offset;
//--- Выйти, если размер меньше указанного
   if(y_size<60)
      return;
//--- Установить новый размер фона таблицы
   ChangeMainSize(x_size,y_size);
//--- Рассчитать размеры таблицы
   CalculateTableSize();
//--- Установить новый размер таблице
   ChangeTableSize();
//--- Нарисуем таблицу
   DrawTable();
   if(m_scrollh.IsScroll())
      m_scrollh.Update(true);
   if(m_scrollv.IsScroll())
      m_scrollv.Update(true);
//--- Обновить
   Update(true);
  }
//+------------------------------------------------------------------+
