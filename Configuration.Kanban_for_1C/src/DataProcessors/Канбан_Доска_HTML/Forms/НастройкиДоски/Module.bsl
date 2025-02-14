// @strict-types


#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	КанбанДоскаHTML = канбан_КанбанДоска.КанбанДоскаHTMLВключенаЗагрузить();
	
	НаборЗаписей = РеквизитФормыВЗначение("СтатусыЗадач");
	НаборЗаписей.Прочитать();
	ЗначениеВРеквизитФормы(НаборЗаписей, "СтатусыЗадач");
	
	ИспользуемыеПроектыДоски = канбан_КанбанДоска.ИспользуемыеПроектыДоскиЗагрузить();
	Если ЗначениеЗаполнено(ИспользуемыеПроектыДоски) Тогда
		Объект.ИспользуемыеПроектыДоски.Загрузить(ИспользуемыеПроектыДоски);
	КонецЕсли;
	
	УстановитьВидимостьДоступность();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура КанбанДоскаHTMLПриИзменении(Элемент)
	
	КанбанДоскаHTMLПриИзмененииНаСервере();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСтатусыЗадач

&НаКлиенте
Процедура СтатусыЗадачПриИзменении(Элемент)
	
	Номер = 1;
	Для Каждого СтрокаСтатуса Из СтатусыЗадач Цикл
		СтрокаСтатуса.НомерПоПорядку = Номер;
		Номер = Номер + 1;
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗаписатьИЗакрыть(Команда)
	
	ЗаписатьНаСервере();
	Оповестить("ОбновитьКанбанДоскуHTML");
	Закрыть();
	
КонецПроцедуры

&НаКлиенте
Процедура Записать(Команда)
	
	ЗаписатьНаСервере();
	Оповестить("ОбновитьКанбанДоскуHTML");
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьВидимостьДоступность()
	
	Элементы.ГруппаСтатусыЗадач.ТолькоПросмотр = Не КанбанДоскаHTML;
	Элементы.ГруппаПроекты.ТолькоПросмотр = Не КанбанДоскаHTML;
	
КонецПроцедуры

&НаСервере
Процедура КанбанДоскаHTMLПриИзмененииНаСервере()
	
	УстановитьВидимостьДоступность();
	
КонецПроцедуры

&НаСервере
Процедура ЗаписатьНаСервере()
	
	канбан_КанбанДоска.КанбанДоскаHTMLВключенаСохранить(КанбанДоскаHTML);
	ЗаписатьСтатусыЗадач();
	ЗаписатьИспользуемыеПроектыДоски();
	
КонецПроцедуры

&НаСервере
Процедура ЗаписатьСтатусыЗадач()
	
	Попытка
		
		НаборЗаписей = РеквизитФормыВЗначение("СтатусыЗадач");
		НаборЗаписей.Записать();
		Модифицированность = Ложь;
		
	Исключение
		
		ЗаписьЖурналаРегистрации(
			"Запись регистра сведений канбан_ИспользуемыеСтатусыДоски", 
			УровеньЖурналаРегистрации.Ошибка, , 
			"Не удалось записать набор записей", 
			ОбработкаОшибок.ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
			
		ВызватьИсключение;
		
	КонецПопытки;
	
КонецПроцедуры

&НаСервере
Процедура ЗаписатьИспользуемыеПроектыДоски()
	
	канбан_КанбанДоска.ИспользуемыеПроектыДоскиСохранить(Объект.ИспользуемыеПроектыДоски.Выгрузить());
	
КонецПроцедуры

#КонецОбласти
