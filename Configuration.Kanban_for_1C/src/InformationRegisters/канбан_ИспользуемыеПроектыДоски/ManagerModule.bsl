// @strict-types


#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

// Записать.
// 
// Параметры:
//  ИспользуемыеПроектыДоски - см. канбан_КанбанДоска.НовыйПроектыДоски
//  Отказ - Булево
//
Процедура Записать(ИспользуемыеПроектыДоски, Отказ) Экспорт
	
	ТекущийПользователь = Пользователи.ТекущийПользователь();
	
	НачатьТранзакцию();
	
	Попытка
		
		Для Каждого ДанныеПроекта Из ИспользуемыеПроектыДоски Цикл
			
			НаборЗаписей = СоздатьНаборЗаписей();
			НаборЗаписей.Отбор.Пользователь.Установить(ТекущийПользователь);
			НаборЗаписей.Отбор.Проект.Установить(ДанныеПроекта.Проект);
			НаборЗаписей.Прочитать();
			
			Если НаборЗаписей.Количество() > 0 Тогда
				СтрокаЗаписи = НаборЗаписей[0];
			Иначе
				СтрокаЗаписи = НаборЗаписей.Добавить();
			КонецЕсли;
			
			СтрокаЗаписи.Пользователь = ТекущийПользователь;
			СТрокаЗаписи.Проект = ДанныеПроекта.Проект;
			СтрокаЗаписи.ИдентификаторПроектаСтрока = Строка(ДанныеПроекта.Проект.УникальныйИдентификатор());
			СтрокаЗаписи.Цвет = ДанныеПроекта.Цвет;
			
			НаборЗаписей.Записать();
			
		КонецЦикла;
		
		ЗафиксироватьТранзакцию();
		
	Исключение
		
		Если ТранзакцияАктивна() Тогда
			ОтменитьТранзакцию();
		КонецЕсли;
		
		Отказ = Истина;
		
		ЗаписьЖурналаРегистрации(
			"Запись регистра сведений канбан_ИспользуемыеСтатусыДоски для проекта: ", 
			УровеньЖурналаРегистрации.Ошибка,, 
			ДанныеПроекта.Проект, 
			ОбработкаОшибок.ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
		
		ВызватьИсключение;
		
	КонецПопытки;
	
КонецПроцедуры

// Загрузить.
// 
// Параметры:
//  ПроектыДоски - см. канбан_КанбанДоска.НовыйПроектыДоски
//
Процедура Загрузить(ПроектыДоски) Экспорт
	
	ТекущийПользователь = Пользователи.ТекущийПользователь();
	
	НаборЗаписей = СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.Пользователь.Установить(ТекущийПользователь);
	НаборЗаписей.Прочитать();
	
	Для Каждого СтрокаНабора Из НаборЗаписей Цикл
		
		СтрокаПроектыДоски = ПроектыДоски.Добавить();
		ЗаполнитьЗначенияСвойств(СтрокаПроектыДоски, СтрокаНабора);
		
	КонецЦикла;
	
КонецПроцедуры

// Используемые статусы.
// 
// Параметры:
//  ТекстЗапросаСтатусы - см. канбан_КанбанДоскаПереопределяемый.ТекстЗапросаСтатусы
//  ДанныеДляКанбанДоски - см. канбан_КанбанДоска.ДанныеДляКанбанДоски
//
//Процедура Статусы(ТекстЗапросаСтатусы, ДанныеДляКанбанДоски) Экспорт
//	
//	Выборка = ДополнитьЗапросСтатусы(ТекстЗапросаСтатусы);
//	
//	Пока Выборка.Следующий() Цикл
//		
//		СтрокаСтатусов = ДанныеДляКанбанДоски.Статусы.Добавить();
//		СтрокаСтатусов.Статус = Выборка.Статус;
//		СтрокаСтатусов.Представление = Выборка.Представление;
//		СтрокаСтатусов.УникальныйИдентификатор = Выборка.УникальныйИдентификатор;
//		
//	КонецЦикла;
//	
//КонецПроцедуры

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
//
//Функция ДополнитьЗапросСтатусы(ТекстЗапросаСтатусы)
//	
//	СхемаЗапроса = Новый СхемаЗапроса();
//	СхемаЗапроса.УстановитьТекстЗапроса(ТекстЗапросаСтатусы);
//	ПервыйПакет = СхемаЗапроса.ПакетЗапросов.Получить(0);
//	Оператор = ПервыйПакет.Операторы[0];
//	
//	ТаблицаИспользуемыеСтатусыДоски = Оператор.Источники.Добавить(
//		"РегистрСведений.канбан_ИспользуемыеСтатусыДоски", "ИспользуемыеСтатусыДоски");
//	
//	// Если к единственному источнику добавляется один источник, то соединение создается автоматически.
//	ТаблицаИспользуемыеСтатусыДоски.Соединения[0].ТипСоединения = ТипСоединенияСхемыЗапроса.Внутреннее;
//	
//	ДоступноеПолеНомер = ТаблицаИспользуемыеСтатусыДоски.Источник.ДоступныеПоля.Найти("НомерПоПорядку");
//	ПолеНомер = Оператор.ВыбираемыеПоля.Добавить(ДоступноеПолеНомер);
//	
//	ПервыйПакет.Порядок.Добавить(ПолеНомер);
//	
//	Запрос = Новый Запрос;
//	Запрос.Текст = СхемаЗапроса.ПолучитьТекстЗапроса();
//	РезультатЗапроса = Запрос.Выполнить();
//	Выборка = РезультатЗапроса.Выбрать();
//	
//	Возврат Выборка;
//	
//КонецФункции

#КонецОбласти

#КонецЕсли
