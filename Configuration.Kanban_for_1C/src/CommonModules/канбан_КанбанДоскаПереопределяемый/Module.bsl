// @strict-types


#Область СлужебныйПрограммныйИнтерфейс

// Текст запроса данные задач.
// Запрос должен вернуть поля:
// * Задача - ОпределяемыйТип.канбан_Задачи - ссылка на задачу
// * СтатусЗадачи - ОпределяемыйТип.канбан_СтатусыЗадач
// * ХранилищеФотографии - хранилище значений, содержащий фотографию исполнителя задачи.
// * НаименованиеЗадачи - Строка - наименование задачи
// * КодЗадачи - Число, Строка - код задачи
// * УникальныйИдентификатор - Строка
// 
// Возвращаемое значение:
//  Строка - Текст запроса данные задач
//
Функция ТекстЗапросаДанныеЗадач() Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|	узЗадачи.Ссылка КАК Задача,
		|	узЗадачи.Статус КАК СтатусЗадачи,
		|	ЕСТЬNULL(Пользователи.Фотография, """") КАК ХранилищеФотографии,
		|	узЗадачи.Наименование КАК НаименованиеЗадачи,
		|	узЗадачи.Код КАК КодЗадачи,
		|	УНИКАЛЬНЫЙИДЕНТИФИКАТОР(узЗадачи.Ссылка) КАК УникальныйИдентификатор
		|ИЗ
		|	Справочник.узЗадачи КАК узЗадачи
		|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Пользователи КАК Пользователи
		|		ПО узЗадачи.Исполнитель = Пользователи.Ссылка
		|ГДЕ
		|	НЕ узЗадачи.ПометкаУдаления";
	
	Возврат Запрос.Текст;
	
КонецФункции

// Текст запроса статусы.
// Запрос должен вернуть заполненные поля:
// * Статус - ОпределяемыйТип.канбан_СтатусыЗадач
// * Представление - Строка - представление статуса для канбан доски
// * УникальныйИдентификатор - Строка
// 
// Возвращаемое значение:
//  Строка - Текст запроса статусы
//
Функция ТекстЗапросаСтатусы() Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|	узСтатусыЗадачи.Ссылка КАК Статус,
		|	ВЫБОР
		|		КОГДА узСтатусыЗадачи.НаименованиеДляКанбанДоски = """"
		|			ТОГДА узСтатусыЗадачи.Наименование
		|		ИНАЧЕ узСтатусыЗадачи.НаименованиеДляКанбанДоски
		|	КОНЕЦ КАК Представление,
		|	УНИКАЛЬНЫЙИДЕНТИФИКАТОР(узСтатусыЗадачи.Ссылка) КАК УникальныйИдентификатор
		|ИЗ
		|	Справочник.узСтатусыЗадачи КАК узСтатусыЗадачи";
	
	Возврат Запрос.Текст;
	
КонецФункции

// Изменить статус задаче.
// 
// Параметры:
//  Задача - ОпределяемыйТип.канбан_Задачи
//  Статус - ОпределяемыйТип.канбан_СтатусыЗадач
//
Процедура ИзменитьСтатусЗадаче(Задача, Статус) Экспорт
	
	а=0;
	
КонецПроцедуры

#КонецОбласти