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

&НаКлиенте
Процедура КанбанДоскаПриНажатии(Элемент, ДанныеСобытия, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	Кнопка = ДанныеСобытия.Button; // TODO вынес и в отдельную функци описав свойства к которым обращаюсь
	
	Если ЗначениеЗаполнено(Кнопка) Тогда
		
		Если Кнопка.id = "update_svg" Тогда
			
			КанбанДоска = "";
			ПодключитьОбработчикОжидания("ТекстHTMLКанбанДоски", 0.1, Истина);
//			ТекстHTMLКанбанДоски();
			
		ИначеЕсли Кнопка.id = "setup_svg" Тогда
			
			ОткрытьФорму("Обработка.Канбан_Доска_HTML.Форма.НастройкиДоски");
			
		ИначеЕсли Не ПустаяСтрока(Кнопка.className) Тогда
			
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
		
	ИначеЕсли ДанныеСобытия.Element.className = "my_tasks" 
		Или ДанныеСобытия.Element.className = "my_tasks_active" Тогда
		
		Сообщить("Пока не сделал фильтр");
		
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

#КонецОбласти