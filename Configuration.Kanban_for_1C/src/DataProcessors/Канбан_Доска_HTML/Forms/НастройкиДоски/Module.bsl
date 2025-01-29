// @strict-types


#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	КанбанДоскаHTML = канбан_КанбанДоска.КанбанДоскаHTMLВключена();
	
	НаборЗаписей = РеквизитФормыВЗначение("СтатусыЗадач");
	НаборЗаписей.Прочитать();
	ЗначениеВРеквизитФормы(НаборЗаписей, "СтатусыЗадач");
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура КанбанДоскаHTMLПриИзменении(Элемент)
	
	КанбанДоскаHTMLПриИзмененииНаСервере(КанбанДоскаHTML);
	
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

&НаСервереБезКонтекста
Процедура КанбанДоскаHTMLПриИзмененииНаСервере(Знач Значение)
	
	канбан_КанбанДоска.КанбанДоскаHTMLПриИзменении(Значение);
	
КонецПроцедуры

&НаСервере
Процедура ЗаписатьНаСервере()
	
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
#КонецОбласти
