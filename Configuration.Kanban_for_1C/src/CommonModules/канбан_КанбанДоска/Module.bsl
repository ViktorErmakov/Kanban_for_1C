// @strict-types


#Область ПрограммныйИнтерфейс

// Получить текст HTML.
// 
// Возвращаемое значение:
//  Строка
//
Функция ТекстHTMLКанбанДоски() Экспорт
	
	ТекстHTML = Обработки.Канбан_Доска_HTML.ТекстHTMLКанбанДоски();
	Возврат ТекстHTML;
	
КонецФункции

// Канбан доска HTMLВключена.
// 
// Возвращаемое значение:
//   Булево - Канбан доска HTMLВключена
//
Функция КанбанДоскаHTMLВключена() Экспорт
	
	КлючОбъекта = КлючОбъекта();
	КлючНастроек = КлючНастроек();
	Результат = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить(КлючОбъекта, КлючНастроек, Ложь);
	
	Возврат Результат;
	
КонецФункции

// Канбан доска HTMLПри изменении.
// 
// Параметры:
//  Значение - Булево
//
Процедура КанбанДоскаHTMLПриИзменении(Значение) Экспорт
	
	КлючОбъекта = КлючОбъекта();
	КлючНастроек = КлючНастроек();
	ОбщегоНазначения.ХранилищеОбщихНастроекСохранить(КлючОбъекта, КлючНастроек, Значение);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Данные для канбан доски.
// 
// Возвращаемое значение:
//  см. НовыйДанныеДляКанбанДоски
//
Функция ДанныеДляКанбанДоски() Экспорт
	
	ДанныеДляКанбанДоски = НовыйДанныеДляКанбанДоски();
	
	ПараметрыОтбора = НовыйПараметрыОтбораЗадач(); // заготовка для будущих отборов доски
	
	канбан_КанбанДоскаПереопределяемый.ДанныеДляКанбанДоски(ПараметрыОтбора, ДанныеДляКанбанДоски);
	
	Возврат ДанныеДляКанбанДоски;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Новый параметры отбора задач.
// 
// Возвращаемое значение:
//  Структура - Новый параметры отбора задач
//
Функция НовыйПараметрыОтбораЗадач() Экспорт
	
	Результат = Новый Структура;
	
	Возврат Результат;
	
КонецФункции

// Новый данные для канбан доски.
// 
// Возвращаемое значение:
//  Структура:
// * Статусы - Массив из ОпределяемыйТип.канбан_СтатусыЗадач
// * ЗадачиИСтатусы - см. НовыйЗадачиИСтатусы
//
Функция НовыйДанныеДляКанбанДоски() Экспорт
	
	СтатусыДоски = Новый Массив; // Массив из ОпределяемыйТип.канбан_СтатусыЗадач
	
	ЗадачиИСтатусы = НовыйЗадачиИСтатусы();
	
	ДанныеДляКанбанДоски = Новый Структура;
	ДанныеДляКанбанДоски.Вставить("Статусы", СтатусыДоски);
	ДанныеДляКанбанДоски.Вставить("ЗадачиИСтатусы", ЗадачиИСтатусы);
	
	Возврат ДанныеДляКанбанДоски;
	
КонецФункции

// Новый задачи и статусы.
// 
// Возвращаемое значение:
//  ТаблицаЗначений - Новый задачи и статусы:
// * Задача - ОпределяемыйТип.канбан_Задачи
// * Наименование - Строка
// * Код - Строка
// * Статус - ОпределяемыйТип.канбан_СтатусыЗадач
// * ФотографияИсполнителя - Строка
// * НавигационнаяСсылка - Строка
//
Функция НовыйЗадачиИСтатусы()
	
	ЗадачиИСтатусы = Новый ТаблицаЗначений;
	ЗадачиИСтатусы.Колонки.Добавить("Задача", Метаданные.ОпределяемыеТипы.канбан_Задачи.Тип);
	ЗадачиИСтатусы.Колонки.Добавить("Наименование", Новый ОписаниеТипов("Строка"));
	ЗадачиИСтатусы.Колонки.Добавить("Код", Новый ОписаниеТипов("Строка"));
	ЗадачиИСтатусы.Колонки.Добавить("Статус", Метаданные.ОпределяемыеТипы.канбан_СтатусыЗадач.Тип);
	ЗадачиИСтатусы.Колонки.Добавить("ФотографияИсполнителя", Новый ОписаниеТипов("Строка"));
	ЗадачиИСтатусы.Колонки.Добавить("НавигационнаяСсылка", Новый ОписаниеТипов("Строка"));
	
	Возврат ЗадачиИСтатусы;
	
КонецФункции

Функция КлючОбъекта()
	Возврат "КанбанДоскаHTML";
КонецФункции

Функция КлючНастроек()
	Возврат "КанбанДоскаHTMLВключена";
КонецФункции

#КонецОбласти
