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
Функция КанбанДоскаHTMLВключенаЗагрузить() Экспорт
	
	КлючОбъекта = КлючОбъекта();
	КлючНастроек = КлючНастроекДоскаВключена();
	Результат = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить(КлючОбъекта, КлючНастроек, Ложь);
	
	Возврат Результат;
	
КонецФункции

// Канбан доска HTMLПри изменении.
// 
// Параметры:
//  Значение - Булево
//
Процедура КанбанДоскаHTMLВключенаСохранить(Значение) Экспорт
	
	КлючОбъекта = КлючОбъекта();
	КлючНастроек = КлючНастроекДоскаВключена();
	ОбщегоНазначения.ХранилищеОбщихНастроекСохранить(КлючОбъекта, КлючНастроек, Значение);
	
КонецПроцедуры

// Используемые проекты доски сохранить.
// 
// Параметры:
//  ИспользуемыеПроектыДоски - см. ИспользуемыеПроектыДоскиЗагрузить 
//
Процедура ИспользуемыеПроектыДоскиСохранить(ИспользуемыеПроектыДоски) Экспорт
	
	КлючОбъекта = КлючОбъекта();
	КлючНастроек = КлючНастроекПроетыДоски();
	ОбщегоНазначения.ХранилищеОбщихНастроекСохранить(КлючОбъекта, КлючНастроек, ИспользуемыеПроектыДоски);
	
КонецПроцедуры

// Используемые проекты доски загрузить.
// 
// Возвращаемое значение:
//  ТаблицаЗначений:
//  * Проект - ОпределяемыйТип.канбан_Проекты
//
Функция ИспользуемыеПроектыДоскиЗагрузить() Экспорт
	
	КлючОбъекта = КлючОбъекта();
	КлючНастроек = КлючНастроекПроетыДоски();
	Результат = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить(КлючОбъекта, КлючНастроек);
	
	Возврат Результат;
	
КонецФункции

// Изменить статус задаче.
// 
// Параметры:
//  ИдентификаторЗадачаСтрока - Строка
//  ИдентификаторСтатусаСтрока - Строка
//  Отказ - Булево
//
// Возвращаемое значение:
//  ОпределяемыйТип.канбан_Задачи
//
Функция ИзменитьСтатусЗадаче(ИдентификаторЗадачаСтрока, ИдентификаторСтатусаСтрока, Отказ) Экспорт
	
	#Область Задача
	
	ИдентификаторЗадача = Новый УникальныйИдентификатор(ИдентификаторЗадачаСтрока);
	
	ТипыЗадачи = Метаданные.ОпределяемыеТипы.канбан_Задачи.Тип.Типы();
	ЗадачаСсылка = Новый(ТипыЗадачи[0]); // ОпределяемыйТип.канбан_Задачи
	ПолноеИмя = ЗадачаСсылка.Метаданные().ПолноеИмя();
	МенеджерОбъекта = ОбщегоНазначения.МенеджерОбъектаПоПолномуИмени(ПолноеИмя);
	
	ЗадачаСсылка = МенеджерОбъекта.ПолучитьСсылку(ИдентификаторЗадача); // ОпределяемыйТип.канбан_Задачи
	
	#КонецОбласти
	
	#Область Статус
	
	ИдентификаторСтатуса = Новый УникальныйИдентификатор(ИдентификаторСтатусаСтрока);
	
	ТипыЗадачи = Метаданные.ОпределяемыеТипы.канбан_СтатусыЗадач.Тип.Типы();
	СтатусСсылка = Новый(ТипыЗадачи[0]); // ОпределяемыйТип.канбан_СтатусыЗадач
	ПолноеИмя = СтатусСсылка.Метаданные().ПолноеИмя();
	МенеджерОбъекта = ОбщегоНазначения.МенеджерОбъектаПоПолномуИмени(ПолноеИмя);
	
	СтатусСсылка = МенеджерОбъекта.ПолучитьСсылку(ИдентификаторСтатуса); // ОпределяемыйТип.канбан_СтатусыЗадач
	
	#КонецОбласти
	
	канбан_КанбанДоскаПереопределяемый.ИзменитьСтатусЗадаче(ЗадачаСсылка, СтатусСсылка, Отказ);
	
	Возврат ЗадачаСсылка;
	
КонецФункции

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Данные для канбан доски.
// 
// Возвращаемое значение:
//  см. НовыйДанныеДляКанбанДоски
//
Функция ДанныеДляКанбанДоски() Экспорт
	
	ДанныеДляКанбанДоски = НовыйДанныеДляКанбанДоски();
	
	ПараметрыОтбора = НовыйПараметрыОтбораЗадач();
	
	ПараметрыОтбора.Проекты = ИспользуемыеПроектыДоскиЗагрузить().ВыгрузитьКолонку("Проект"); // Массив из ОпределяемыйТип.канбан_Проекты
	
	ТекстЗапросаДанныеЗадач = канбан_КанбанДоскаПереопределяемый.ТекстЗапросаДанныеЗадач();
	
	ТекстЗапросаСтатусы = канбан_КанбанДоскаПереопределяемый.ТекстЗапросаСтатусы();
	РегистрыСведений.канбан_ИспользуемыеСтатусыДоски.Статусы(ТекстЗапросаСтатусы, ДанныеДляКанбанДоски);
	
	Выборка = ДополнитьЗапросДанныеЗадач(ТекстЗапросаДанныеЗадач, ПараметрыОтбора);
	
	Пока Выборка.Следующий() Цикл
		
		НоваяСтрока = ДанныеДляКанбанДоски.ЗадачиИСтатусы.Добавить();
		НоваяСтрока.Задача = Выборка.Задача;
		НоваяСтрока.Статус = Выборка.СтатусЗадачи;
		
		ХранилищеФотографии = Выборка.ХранилищеФотографии;
		ДвоичныеДанныеФотографии = ХранилищеФотографии.Получить();
		Если ДвоичныеДанныеФотографии = Неопределено Тогда
			
			КартинкаПоУмолчанию = БиблиотекаКартинок.канбан_ФотоПоУмолчанию;
			ДвоичныеДанныеФотографии = КартинкаПоУмолчанию.ПолучитьДвоичныеДанные();
			
		КонецЕсли;
		ФотографияСтрокаBase64 = Base64Строка(ДвоичныеДанныеФотографии);
		НоваяСтрока.ФотографияИсполнителя = СтрШаблон("data:image/jpeg;base64,%1", ФотографияСтрокаBase64);
		
		НоваяСтрока.Наименование = Выборка.НаименованиеЗадачи;
		НоваяСтрока.Код = Выборка.КодЗадачи;
		
		СсылкаНаОбъект = ПолучитьНавигационнуюСсылку(Выборка.Задача);
		СсылкаНаИБ = ПолучитьНавигационнуюСсылкуИнформационнойБазы();
		НоваяСтрока.НавигационнаяСсылка = СтрШаблон("%1#%2", СсылкаНаИБ, СсылкаНаОбъект);
		НоваяСтрока.УникальныйИдентификаторЗадача = Выборка.УникальныйИдентификатор;
		
	КонецЦикла;
	
	Возврат ДанныеДляКанбанДоски;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Новый параметры отбора задач.
// 
// Возвращаемое значение:
//  Структура - Новый параметры отбора задач:
//  * Проекты - Массив из ОпределяемыйТип.канбан_Проекты
//
Функция НовыйПараметрыОтбораЗадач() Экспорт
	
	Результат = Новый Структура;
	Результат.Вставить("Проекты", Новый Массив);
	
	Возврат Результат;
	
КонецФункции

// Новый данные для канбан доски.
// 
// Возвращаемое значение:
//  Структура:
// * Статусы - см. НовыйСтатусыДоски
// * ЗадачиИСтатусы - см. НовыйЗадачиИСтатусы
//
Функция НовыйДанныеДляКанбанДоски() Экспорт
	
	СтатусыДоски = НовыйСтатусыДоски();
	
	ЗадачиИСтатусы = НовыйЗадачиИСтатусы();
	
	ДанныеДляКанбанДоски = Новый Структура;
	ДанныеДляКанбанДоски.Вставить("Статусы", СтатусыДоски);
	ДанныеДляКанбанДоски.Вставить("ЗадачиИСтатусы", ЗадачиИСтатусы);
	
	Возврат ДанныеДляКанбанДоски;
	
КонецФункции

// Новый статусы доски.
// 
// Возвращаемое значение:
//  ТаблицаЗначений - Новый статусы доски:
// * Статус - ОпределяемыйТип.канбан_СтатусыЗадач
// * Представление - Строка
// * УникальныйИдентификатор - Строка
//
Функция НовыйСтатусыДоски()
	
	СтатусыДоски = Новый ТаблицаЗначений;
	СтатусыДоски.Колонки.Добавить("Статус", Метаданные.ОпределяемыеТипы.канбан_СтатусыЗадач.Тип);
	СтатусыДоски.Колонки.Добавить("Представление", Новый ОписаниеТипов("Строка"));
	СтатусыДоски.Колонки.Добавить("УникальныйИдентификатор", Новый ОписаниеТипов("Строка"));
	
	Возврат СтатусыДоски;
	
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
// * УникальныйИдентификаторЗадача - Строка
//
Функция НовыйЗадачиИСтатусы()
	
	ЗадачиИСтатусы = Новый ТаблицаЗначений;
	ЗадачиИСтатусы.Колонки.Добавить("Задача", Метаданные.ОпределяемыеТипы.канбан_Задачи.Тип);
	ЗадачиИСтатусы.Колонки.Добавить("Наименование", Новый ОписаниеТипов("Строка"));
	ЗадачиИСтатусы.Колонки.Добавить("Код", Новый ОписаниеТипов("Строка"));
	ЗадачиИСтатусы.Колонки.Добавить("Статус", Метаданные.ОпределяемыеТипы.канбан_СтатусыЗадач.Тип);
	ЗадачиИСтатусы.Колонки.Добавить("ФотографияИсполнителя", Новый ОписаниеТипов("Строка"));
	ЗадачиИСтатусы.Колонки.Добавить("НавигационнаяСсылка", Новый ОписаниеТипов("Строка"));
	ЗадачиИСтатусы.Колонки.Добавить("УникальныйИдентификаторЗадача", Новый ОписаниеТипов("Строка"));
	
	Возврат ЗадачиИСтатусы;
	
КонецФункции

Функция КлючОбъекта()
	Возврат "КанбанДоскаHTML";
КонецФункции

Функция КлючНастроекДоскаВключена()
	Возврат "КанбанДоскаHTMLВключена";
КонецФункции

Функция КлючНастроекПроетыДоски()
	Возврат "КанбанДоскаПроектыДоски";
КонецФункции

// Дополнить запрос данные задач.
// 
// Параметры:
//  ТекстЗапросаДанныеЗадач - Строка - Текст запроса данные задач
//  ПараметрыОтбора - см. канбан_КанбанДоска.НовыйПараметрыОтбораЗадач
// 
// Возвращаемое значение:
//  ВыборкаИзРезультатаЗапроса:
// * Задача - ОпределяемыйТип.канбан_Задачи - ссылка на задачу
// * СтатусЗадачи - ОпределяемыйТип.канбан_СтатусыЗадач
// * ХранилищеФотографии - ХранилищеЗначения - содержит фотографию исполнителя задачи.
// * НаименованиеЗадачи - Строка - наименование задачи
// * КодЗадачи - Число, Строка - код задачи
// * УникальныйИдентификатор - Строка
//
Функция ДополнитьЗапросДанныеЗадач(ТекстЗапросаДанныеЗадач, ПараметрыОтбора)
	
	СхемаЗапроса = Новый СхемаЗапроса();
	СхемаЗапроса.УстановитьТекстЗапроса(ТекстЗапросаДанныеЗадач);
	ПервыйПакет = СхемаЗапроса.ПакетЗапросов.Получить(0);
	Оператор = ПервыйПакет.Операторы[0];
	
	ТаблицаИспользуемыеСтатусыДоски = Оператор.Источники.Добавить(
		"РегистрСведений.канбан_ИспользуемыеСтатусыДоски", "ИспользуемыеСтатусыДоски");
	
	Оператор.Источники[0].Соединения.Добавить(
		ТаблицаИспользуемыеСтатусыДоски, 
		"узЗадачи.Статус = ИспользуемыеСтатусыДоски.СтатусЗадачи");
	
	Оператор.Источники[0].Соединения[1].ТипСоединения = ТипСоединенияСхемыЗапроса.Внутреннее;
	
	Запрос = Новый Запрос;
	Запрос.Текст = СхемаЗапроса.ПолучитьТекстЗапроса();
	
	Запрос.УстановитьПараметр("Проекты", ПараметрыОтбора.Проекты);
	
	РезультатЗапроса = Запрос.Выполнить();
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Возврат ВыборкаДетальныеЗаписи;
	
КонецФункции

#КонецОбласти
