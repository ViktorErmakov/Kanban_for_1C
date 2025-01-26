// @strict-types


#Область ПрограммныйИнтерфейс

// Открыть канбан доску
//
Процедура ОткрытьКанбанДоску() Экспорт
	ОткрытьФорму("Обработка.Канбан_Доска_HTML.Форма.Доска");
КонецПроцедуры

// При открытии перед.
// 
// Параметры:
//  Отказ - Булево
//
Процедура ПриОткрытииПеред(Отказ) Экспорт
	
	Если канбан_КанбанДоскаВызовСервера.КанбанДоскаHTMLВключена() Тогда
		Отказ = Истина;
		ОткрытьКанбанДоску();
		Возврат;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Код процедур и функций

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Код процедур и функций

#КонецОбласти
