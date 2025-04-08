// @strict-types


#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

// Записать.
// 
// Параметры:
//  ИспользуемыеСтатусыДоски - см. канбан_КанбанДоска.НовыйСтатусыДоски
//  Отказ - Булево
//
Процедура Записать(ИспользуемыеСтатусыДоски, Отказ) Экспорт
	
	ТекущийПользователь = Пользователи.ТекущийПользователь();
	
	УстановитьПривилегированныйРежим(Истина);
	
	НачатьТранзакцию();
	
	Попытка
		
		Блокировка = Новый БлокировкаДанных;
		ЭлементБлокировки = Блокировка.Добавить("РегистрСведений.канбан_ИспользуемыеСтатусыДоски");
		ЭлементБлокировки.УстановитьЗначение("Пользователь", ТекущийПользователь);
		Блокировка.Заблокировать();
		
		НаборЗаписей = СоздатьНаборЗаписей();
		НаборЗаписей.Отбор.Пользователь.Установить(ТекущийПользователь);
		
		Для Каждого ДанныеСтатуса Из ИспользуемыеСтатусыДоски Цикл
			
			СтрокаЗаписи = НаборЗаписей.Добавить();
			ЗаполнитьЗначенияСвойств(СтрокаЗаписи, ДанныеСтатуса);
			СтрокаЗаписи.Пользователь = ТекущийПользователь;
			
		КонецЦикла;
		
		НаборЗаписей.Записать();
		
		УстановитьПривилегированныйРежим(Ложь);
		
		ЗафиксироватьТранзакцию();
		
	Исключение
		
		Если ТранзакцияАктивна() Тогда
			ОтменитьТранзакцию();
		КонецЕсли;
		
		Отказ = Истина;
		
		ЗаписьЖурналаРегистрации(
			"Запись регистра сведений канбан_ИспользуемыеСтатусыДоски для проекта: ", 
			УровеньЖурналаРегистрации.Ошибка,, 
			ДанныеСтатуса.СтатусЗадачи, 
			ОбработкаОшибок.ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
		
		ВызватьИсключение;
		
	КонецПопытки;
	
КонецПроцедуры

// Загрузить.
// 
// Параметры:
//  СтатусыДоски - см. канбан_КанбанДоска.НовыйСтатусыДоски
//
Процедура Загрузить(СтатусыДоски) Экспорт
	
	ТекущийПользователь = Пользователи.ТекущийПользователь();
	
	УстановитьПривилегированныйРежим(Истина);
	
	НаборЗаписей = СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.Пользователь.Установить(ТекущийПользователь);
	НаборЗаписей.Прочитать();
	
	Для Каждого СтрокаНабора Из НаборЗаписей Цикл
		
		СтрокаСтатуса = СтатусыДоски.Добавить();
		ЗаполнитьЗначенияСвойств(СтрокаСтатуса, СтрокаНабора);
		
	КонецЦикла;
	
	УстановитьПривилегированныйРежим(Ложь);
	
КонецПроцедуры

// Используемые статусы.
// 
// Параметры:
//  ТекстЗапросаСтатусы - см. канбан_КанбанДоскаПереопределяемый.ТекстЗапросаСтатусы
//  ДанныеДляКанбанДоски - см. канбан_КанбанДоска.ДанныеДляКанбанДоски
//
Процедура Статусы(ТекстЗапросаСтатусы, ДанныеДляКанбанДоски) Экспорт
	
	Выборка = ДополнитьЗапросСтатусы(ТекстЗапросаСтатусы);
	
	Пока Выборка.Следующий() Цикл
		
		СтрокаСтатусов = ДанныеДляКанбанДоски.Статусы.Добавить();
		ЗаполнитьЗначенияСвойств(СтрокаСтатусов, Выборка);
		СтрокаСтатусов.СтатусЗадачи = Выборка.Статус;
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Дополнить запрос статусы.
// 
// Параметры:
//  ТекстЗапросаСтатусы - Строка - Текст запроса статусы
// 
// Возвращаемое значение:
//  ВыборкаИзРезультатаЗапроса:
// * Статус - ОпределяемыйТип.канбан_СтатусыЗадач
// * Представление - Строка - представление статуса для канбан доски
// * УникальныйИдентификатор - Строка
// * КнопкаДобавить - Булево
//
Функция ДополнитьЗапросСтатусы(ТекстЗапросаСтатусы)
	
	СхемаЗапроса = Новый СхемаЗапроса();
	СхемаЗапроса.УстановитьТекстЗапроса(ТекстЗапросаСтатусы);
	ПервыйПакет = СхемаЗапроса.ПакетЗапросов.Получить(0);
	Оператор = ПервыйПакет.Операторы[0];
	
	ТаблицаИспользуемыеСтатусыДоски = Оператор.Источники.Добавить(
		"РегистрСведений.канбан_ИспользуемыеСтатусыДоски", "ИспользуемыеСтатусыДоски");
	
	// Если к единственному источнику добавляется один источник, то соединение создается автоматически.
	Оператор.Источники[1].Соединения.Очистить();
	
	Оператор.Источники[0].Соединения.Добавить( 
		ТаблицаИспользуемыеСтатусыДоски, 
		"ИспользуемыеСтатусыДоски.СтатусЗадачи = узСтатусыЗадачи.Ссылка И ИспользуемыеСтатусыДоски.Пользователь = &ТекущийПользователь");
	
	Оператор.Источники[0].Соединения[0].ТипСоединения = ТипСоединенияСхемыЗапроса.Внутреннее;
	
	ДоступноеПолеНомер = ТаблицаИспользуемыеСтатусыДоски.Источник.ДоступныеПоля.Найти("НомерПоПорядку");
	ПолеНомер = Оператор.ВыбираемыеПоля.Добавить(ДоступноеПолеНомер);
	
	ПервыйПакет.Порядок.Добавить(ПолеНомер);
	
	Оператор.ВыбираемыеПоля.Добавить("ИспользуемыеСтатусыДоски.КнопкаДобавить");
//	ПервыйПакет.Колонки[7].Псевдоним = "КнопкаДобавить";
	
	Запрос = Новый Запрос;
	Запрос.Текст = СхемаЗапроса.ПолучитьТекстЗапроса();
	
	Запрос.УстановитьПараметр("ТекущийПользователь", Пользователи.ТекущийПользователь());
	
	РезультатЗапроса = Запрос.Выполнить();
	Выборка = РезультатЗапроса.Выбрать();
	
	Возврат Выборка;
	
КонецФункции

#КонецОбласти

#КонецЕсли
