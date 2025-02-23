// @strict-types


#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ТекстHTMLКанбанДоски();
	
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

&НаКлиенте
Процедура КанбанДоскаПриНажатии(Элемент, ДанныеСобытия, СтандартнаяОбработка)
	
	Кнопка = ДанныеСобытия.Button;
	
	Если ЗначениеЗаполнено(Кнопка)
		И Не ПустаяСтрока(Кнопка.className) Тогда
		
		СписокКлассовКнопки = Кнопка.className; // Строка
		ОсновноеИмяКлассаКнопки = СтрРазделить(СписокКлассовКнопки, " ")[0]; // Строка
		
		Если ОсновноеИмяКлассаКнопки = "changeStatus" Тогда
			
			ИдентификаторЗадача = СтрЗаменить(Кнопка.parentElement.id, "task", ""); // Строка
			ИдентификаторСтатуса = Кнопка.parentElement.parentElement.id; // Строка
			
			КанбанДоскаПриНажатииНаСервере(
				ИдентификаторЗадача, 
				ИдентификаторСтатуса);
			
			ОповеститьОбИзменении(ЗадачаСсылка);
			
		КонецЕсли
			
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ТекстHTMLКанбанДоски()
	
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
		ТекстHTMLКанбанДоски();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти