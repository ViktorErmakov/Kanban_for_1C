// @strict-types


#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	МакетСтраницаРекламы = Обработки.Канбан_Доска_HTML.ПолучитьМакет("ШаблонКанбанДоскиHTML");
	ДокументHTML = МакетСтраницаРекламы.ПолучитьДокументHTML();
	
	ДанныеДляДоски = канбан_КанбанДоска.ДанныеДляКанбанДоски();
	
	УзелДоска = ДокументHTML.ПолучитьЭлементПоИдентификатору("kanban-board");
	
	//TODO нужно сделать в переопределении запрос один с группировками по статусу, второй уровень задачи
	Для Каждого Статус Из ДанныеДляДоски.Статусы Цикл
		
		УзелРазделаСтатуса = ДокументHTML.СоздатьЭлемент("Div");
		УзелРазделаСтатуса.УстановитьАтрибут("class", "kanban-block");
		УзелРазделаСтатуса.УстановитьАтрибут("ondragover", "allowDrop(event)");
		УзелРазделаСтатуса.УстановитьАтрибут("ondrop", "drop(event)");
		
		УзелРазделаИмяСтатуса = ДокументHTML.СоздатьЭлемент("Strong");
		УзелРазделаИмяСтатуса.УстановитьАтрибут("class", "kanban-block__name");
		УзелРазделаИмяСтатуса.ТекстовоеСодержимое = СтрШаблон("%1 ", Строка(Статус));
		
		УзелРазделаСтатуса.ДобавитьДочерний(УзелРазделаИмяСтатуса);
		
		ПараметрыОтбора = Новый Структура;
		ПараметрыОтбора.Вставить("Статус", Статус);
		ЗадачиСоСтатусом = ДанныеДляДоски.ЗадачиИСтатусы.НайтиСтроки(ПараметрыОтбора);
		
		УзелРазделаКоличествоЗадач = ДокументHTML.СоздатьЭлемент("Strong");
		УзелРазделаКоличествоЗадач.УстановитьАтрибут("class", "kanban-block__number");
		УзелРазделаКоличествоЗадач.ТекстовоеСодержимое = Строка(ЗадачиСоСтатусом.Количество());
		
		УзелРазделаСтатуса.ДобавитьДочерний(УзелРазделаКоличествоЗадач);
		УзелДоска.ДобавитьДочерний(УзелРазделаСтатуса);
		
		Для Каждого Задача Из ЗадачиСоСтатусом Цикл
			
			// Карточки
			УзелКарточка = ДокументHTML.СоздатьЭлемент("Div");
			УзелКарточка.УстановитьАтрибут("class", "card drive card__active");
			УзелКарточка.УстановитьАтрибут("draggable", "true");
			УзелКарточка.УстановитьАтрибут("ondragstart", "drag(event)");
			
			#Область ШапкаКарточки
			
			УзелШапкаКарточки = ДокументHTML.СоздатьЭлемент("card__header");
			
			УзелШапкаКарточкиСсылка = ДокументHTML.СоздатьЭлемент("a");
			УзелШапкаКарточкиСсылка.УстановитьАтрибут("class", "card__link");
			УзелШапкаКарточкиСсылка.УстановитьАтрибут("href", "https://ru.bem.info/methodology/quick-start/");
			УзелШапкаКарточкиСсылка.УстановитьАтрибут("target", "_blank");
			УзелШапкаКарточкиСсылка.ТекстовоеСодержимое = "Задача №1";
			
			УзелШапкаКарточки.ДобавитьДочерний(УзелШапкаКарточкиСсылка);
			
			УзелШапкаКарточкиИзображение = ДокументHTML.СоздатьЭлемент("img");
			УзелШапкаКарточкиИзображение.УстановитьАтрибут("class", "card__photo");
			УзелШапкаКарточкиИзображение.УстановитьАтрибут("alt", "foto");
			// data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMTEhUTExMWFhUXGBgaGBcXGBcXFxgXFxcXFxcXFxcYHSggGBolHRcVITEhJSkrLi4uFx8zODMtNygtLisBCgoKDg0OGhAQGi0lHyUtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLf/AABEIALcBEwMBIgACEQEDEQH/xAAbAAACAwEBAQAAAAAAAAAAAAAEBQIDBgABB//EADwQAAEDAgQDBgQEBQQCAwAAAAEAAhEDIQQSMUEFUWEicYGRBhMyobHB8ELR4fEUUmJyghUjkrIzQ1PC/8QAGgEAAwEBAQEAAAAAAAAAAAAAAAECAwQFBv/EACkRAAICAgIBBAIBBQEAAAAAAAABAhEDIRIxBEETIlEFMmFxgZGhsRT/2gAMAwEAAhEDEQA/APnKhCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoEIUCEKBCFAhCgQhQIQoE
			УзелШапкаКарточкиИзображение.УстановитьАтрибут("src", Задача.ФотографияИсполнителя);
			
			УзелШапкаКарточки.ДобавитьДочерний(УзелШапкаКарточкиИзображение);
			
			УзелКарточка.ДобавитьДочерний(УзелШапкаКарточки);
			
			#КонецОбласти
			
			#Область ТелоКарточки
			
			УзелТелоКарточки = ДокументHTML.СоздатьЭлемент("div");
			УзелТелоКарточки.УстановитьАтрибут("class", "card__text");
			
			УзелТелоКарточкиТекст = ДокументHTML.СоздатьЭлемент("span");
			УзелТелоКарточкиТекст.ТекстовоеСодержимое = "Поправить иконки в дизайн-системе";
			
			УзелТелоКарточки.ДобавитьДочерний(УзелТелоКарточкиТекст);
			УзелКарточка.ДобавитьДочерний(УзелТелоКарточки);
			
			#КонецОбласти
			
			#Область ТэгКарточки
			
			УзелТэгКарточки = ДокументHTML.СоздатьЭлемент("div");
			УзелТэгКарточки.УстановитьАтрибут("class", "tag");
			УзелТэгКарточки.ТекстовоеСодержимое = "1C:Drive";
			
			УзелКарточка.ДобавитьДочерний(УзелТэгКарточки);
			
			#КонецОбласти
			
			
			УзелРазделаСтатуса.ДобавитьДочерний(УзелКарточка);
		
		КонецЦикла;
		
//		Если Реклама.ПоказыватьМаркерРеклама Тогда
//			УзелDivAdvertisement = ДокументHTML.СоздатьЭлемент("Div");
//			УзелDivAdvertisement.УстановитьАтрибут("class", "advertisement");
//			УзелDivAdvertisement.ТекстовоеСодержимое = НСтр("ru = 'Реклама'", ОбщегоНазначения.КодОсновногоЯзыка());
//			УзелDivPic.ДобавитьДочерний(УзелDivAdvertisement);
//		КонецЕсли;
//		
//		ЦелевоеДействие = Реклама.ЦелевоеДействие;
//		УзелAImg = ДокументHTML.СоздатьЭлемент("a");
//		УзелAImg.УстановитьАтрибут("href", ЦелевоеДействие);
//		УзелAImg.УстановитьАтрибут("target", "_blank");
//		УзелDivPic.ДобавитьДочерний(УзелAImg);
//		
//		ИдентификаторРекламы = Реклама.ИдентификаторРекламы;
//		ДанныеИзображения = Реклама.Изображение;
//		Если ДанныеИзображения = Неопределено Тогда
//			Продолжить;
//		КонецЕсли;
//		УзелImg = ДокументHTML.СоздатьЭлемент("Img");
//		УзелImg.УстановитьАтрибут("class", "pic_img");
//		УзелImg.УстановитьАтрибут("id", ИдентификаторРекламы);
//		УзелImg.УстановитьАтрибут("src", ДанныеИзображения);
//		УзелAImg.ДобавитьДочерний(УзелImg);
//		
//		Если Реклама.ПоказыватьМаркерРеклама 
//			И Не ПустаяСтрока(Реклама.ЮридическоеЛицоРекламодателя) Тогда
//			
//			УзелDivAdvertiser = ДокументHTML.СоздатьЭлемент("Div");
//			УзелDivAdvertiser.УстановитьАтрибут("class", "advertiser");
//			ШаблонПредставления = НСтр("ru = 'Рекламодатель: %1'", ОбщегоНазначения.КодОсновногоЯзыка());
//			ПредставлениеРекламодателя = СтрШаблон(ШаблонПредставления, Реклама.ЮридическоеЛицоРекламодателя);
//			УзелDivAdvertiser.ТекстовоеСодержимое = ПредставлениеРекламодателя;
//			УзелDivPic.ДобавитьДочерний(УзелDivAdvertiser);
//			
//		КонецЕсли;
		
	КонецЦикла;
	
	
//	Документ = Новый ДокументHTML;
//	Документ.ТекстовоеСодержимое = КанбанДоска;
//	АтрибутыДокумента = Документ.Атрибуты;

	
//	УзелСтили = ДокументHTML.ПолучитьЭлементыПоИмени("Style")[0];
//	Стили = Обработки.канбан_Доска.ПолучитьМакет("Стили").ПолучитьТекст();
//	УзелСтили.ТекстовоеСодержимое = Стили;
//	
//	КанбанДоска = ТекстHTMLИзОбъектаДокументHTML(ДокументHTML);
	
	
	КанбанДоска = ТекстHTMLИзОбъектаДокументHTML(ДокументHTML);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

// Код процедур и функций

#КонецОбласти

#Область ОбработчикиКомандФормы

// Код процедур и функций

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Получает текст HTML из объекта ДокументHTML.
//
// Параметры:
//  ДокументHTML  - ДокументHTML - документ, из которого будет извлекаться текст.
//
// Возвращаемое значение:
//   Строка   - текст HTML
//
&НаСервере
Функция ТекстHTMLИзОбъектаДокументHTML(Знач ДокументHTML)
	
	ЗаписьDOM = Новый ЗаписьDOM;
	ЗаписьHTML = Новый ЗаписьHTML;
	ЗаписьHTML.УстановитьСтроку();
	ЗаписьDOM.Записать(ДокументHTML, ЗаписьHTML);
	
	Возврат ЗаписьHTML.Закрыть();
	
КонецФункции

#КонецОбласти
