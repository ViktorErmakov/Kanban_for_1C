// @strict-types


#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ТекстHTMLКанбанДоскиНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	События = Новый Массив; // Массив из Строка
	События.Добавить("ОбновитьКанбанДоскуHTML");
	
	канбан_КанбанДоскаКлиентПереопределяемый.СобытияОбработкиОповещения(События);
	
	ДопустимоеСобытие = События.Найти(ИмяСобытия);
	Если ДопустимоеСобытие <> Неопределено Тогда
		
		ТекстHTMLКанбанДоски();
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

// Канбан доска при нажатии.
// 
// Параметры:
//  Элемент - ПолеФормы - Элемент
//  ДанныеСобытия - Структура:
//  * Button - Структура:
//  ** type - Строка
//  ** id - Строка
//  ** className - Строка
//  ** parentElement - Структура:
//  *** id - Строка
//  *** parentElement - Структура:
//  **** id - Строка
//  * Element - Структура:
//  ** className - Строка
//      
//  СтандартнаяОбработка - Булево - Стандартная обработка
//
&НаКлиенте
Процедура КанбанДоскаПриНажатии(Элемент, ДанныеСобытия, СтандартнаяОбработка)
	
	Кнопка = ДанныеСобытия.Button;
	
	Если ЗначениеЗаполнено(Кнопка) Тогда
		
		// Пропускаем обработку для быстрого фильтра проектов
		Если Кнопка.type = "INPUT" Тогда
			
			// TODO тут возводим флаг что фильтры менялись. При любом обновлении доски, кроме как при создани на сервере, обновлять только задачи с учетом быстрых фильтров.
			
			Возврат;
			
		ИначеЕсли Кнопка.id = "update_svg" Тогда
			
			СтандартнаяОбработка = Ложь;
			КанбанДоска = "";
			ПодключитьОбработчикОжидания("ТекстHTMLКанбанДоски", 0.1, Истина);
			
		ИначеЕсли Кнопка.id = "setup_svg" Тогда
			
			СтандартнаяОбработка = Ложь;
			ОткрытьФорму("Обработка.Канбан_Доска_HTML.Форма.НастройкиДоски");
			
		ИначеЕсли Не ПустаяСтрока(Кнопка.className) Тогда
			
			СписокКлассовКнопки = Кнопка.className;
			ОсновноеИмяКлассаКнопки = СтрРазделить(СписокКлассовКнопки, " ")[0];
			
			Если ОсновноеИмяКлассаКнопки = "changeStatus" Тогда // Изменение статуса задаче
				
				СтандартнаяОбработка = Ложь;
				
				ИдентификаторЗадача = СтрЗаменить(Кнопка.parentElement.id, "task", "");
				ИдентификаторСтатуса = Кнопка.parentElement.parentElement.id;
				
				КанбанДоскаПриНажатииНаСервере(
					ИдентификаторЗадача, 
					ИдентификаторСтатуса);
				
				ОповеститьОбИзменении(ЗадачаСсылка);
				
			КонецЕсли
			
		КонецЕсли;
		
	ИначеЕсли СтрРазделить(ДанныеСобытия.Element.className, " ")[0] = "my_tasks" Тогда
		
		СтандартнаяОбработка = Ложь;
		
	ИначеЕсли СтрРазделить(ДанныеСобытия.Element.className, " ")[0] = "add_task" Тогда
		
		СтандартнаяОбработка = Ложь;
		КлассыЭлемента = СтрРазделить(ДанныеСобытия.Element.className, " ");
		ИдентификаторСтатусаСтрока = СтрЗаменить(КлассыЭлемента[1], "status", "");
		СтатусаЗадачиСсылка = СтатусаЗадачиСсылка(ИдентификаторСтатусаСтрока);
		
		ПараметрыОткрытия = Новый Структура;
		ПараметрыОткрытия.Вставить("Статус", СтатусаЗадачиСсылка); // Управление задач не заполняет параметры, но может другая конфигурация будет.
		ФормаЗадачи = ОткрытьФорму("Справочник.узЗадачи.ФормаОбъекта", ПараметрыОткрытия);
		ФормаЗадачи.Открыть();
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ТекстHTMLКанбанДоски()
	
	ТекстHTMLКанбанДоскиНаСервере();
	
КонецПроцедуры

&НаСервере
Процедура ТекстHTMLКанбанДоскиНаСервере()
	
	КанбанДоска = канбан_КанбанДоска.ТекстHTMLКанбанДоски();
	
КонецПроцедуры

// Канбан доска при нажатии на сервере.
// 
// Параметры:
//  ИдентификаторЗадача - Строка
//  ИдентификаторСтатуса - Строка
//
&НаСервере
Процедура КанбанДоскаПриНажатииНаСервере(Знач ИдентификаторЗадача, Знач ИдентификаторСтатуса)
	
	Отказ = Ложь;
	ЗадачаСсылка = канбан_КанбанДоска.ИзменитьСтатусЗадаче(ИдентификаторЗадача, ИдентификаторСтатуса, Отказ);
	
	Если Не Отказ Тогда
		ТекстHTMLКанбанДоскиНаСервере();
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция СтатусаЗадачиСсылка(ИдентификаторСтатусаСтрока)
	
	ТипОбъектаСтатус = Метаданные.ОпределяемыеТипы.канбан_СтатусыЗадач.Тип.Типы()[0];
	ОбъектМетаданных = Метаданные.НайтиПоТипу(ТипОбъектаСтатус);
	МенеджерОбъектаСтатусы = ОбщегоНазначения.МенеджерОбъектаПоПолномуИмени(ОбъектМетаданных.ПолноеИмя());
	
	ИдентификаторСтатуса = Новый УникальныйИдентификатор(ИдентификаторСтатусаСтрока);
	СтатусСсылка = МенеджерОбъектаСтатусы.ПолучитьСсылку(ИдентификаторСтатуса);
	
	Возврат СтатусСсылка;
	
КонецФункции

#КонецОбласти