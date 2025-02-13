//©///////////////////////////////////////////////////////////////////////////©//
//
//  Copyright 2021-2024 BIA-Technologies Limited Liability Company
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//©///////////////////////////////////////////////////////////////////////////©//

#Область ПрограммныйИнтерфейс

// Объединяет две строки с помощью указанного разделителя.
//
// Ограничения:
// - Метод не изменяет исходную и дополнительную строки, а создает новую строку на их основе.
//
// Параметры:
// ИсходнаяСтрока - Строка - Строка, к которой будет добавлена дополнительная строка.
// ДополнительнаяСтрока - Строка - Строка, которую нужно добавить к исходной строке.
// Разделитель - Строка - Символ или набор символов, используемых для разделения исходной и дополнительной строк. 
//                        По умолчанию используется точка с запятой (";").
//
// Возвращаемое значение:
// Строка - Новая строка, образованная объединением исходной и дополнительной строк с помощью указанного разделителя. 
//          Если дополнительная строка пустая, то возвращается исходная строка. 
//          Если исходная строка пустая, а дополнительная нет, то возвращается дополнительная строка.
//
// Пример:
// ИсходнаяСтрока = "Привет";
// ДополнительнаяСтрока = "Мир";
// Разделитель = " ";
// Результат = ДобавитьСтроку(ИсходнаяСтрока, ДополнительнаяСтрока, Разделитель); // Результат будет равен "Привет Мир".
Функция ДобавитьСтроку(ИсходнаяСтрока, ДополнительнаяСтрока, Разделитель = ";") Экспорт
	
	Если Не ПустаяСтрока(ДополнительнаяСтрока) Тогда
		
		Если Не ПустаяСтрока(ИсходнаяСтрока) Тогда
			Возврат Строка(ИсходнаяСтрока) + Разделитель + Строка(ДополнительнаяСтрока);
		Иначе
			Возврат Строка(ДополнительнаяСтрока);
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат Строка(ИсходнаяСтрока);
	
КонецФункции

// Разделяет строку на подстроки с помощью указанного разделителя.
//
// Ограничения:
// - Метод не изменяет исходную строку, а создает новый массив строк на ее основе.
// - В отличие от СтрРазделить, в качестве разделителя используется вся переданная строка, а не любой из символов, входящих в нее.
// - Отсекает незначащие символы, стоящие слева от первого значащего символа в строке,
//   и пробелы, стоящие справа от последнего значащего символа в строке.
//
// Параметры:
// Значение - Строка - Строка, которую нужно разделить на подстроки.
// Разделитель - Строка - Символ или набор символов, используемых для разделения строки на подстроки. По умолчанию используется точка с запятой (";").
//
// Возвращаемое значение:
// Массив из Строка - Массив строк, содержащий подстроки, полученные в результате разделения исходной строки. 
//                    Если исходная строка пустая, то возвращается пустой массив.
//
// Пример:
// Значение = "Привет; Мир; Как дела?";
// Разделитель = "; ";
// Результат = РазделитьСтроку(Значение, Разделитель); // Результат будет равен ["Привет", "Мир", "Как дела?"].
Функция РазделитьСтроку(Знач Значение, Разделитель = ";") Экспорт
	
	КодУниверсальногоРазделителя = 5855;
	УниверсальныйРазделитель = Символ(КодУниверсальногоРазделителя);
	МодифицированнаяСтрока = СтрЗаменить(Значение, Разделитель, УниверсальныйРазделитель);
	
	МассивСтрок = ?(МодифицированнаяСтрока = "", Новый Массив, СтрРазделить(МодифицированнаяСтрока, УниверсальныйРазделитель));
	
	Для Индекс = 0 По МассивСтрок.ВГраница() Цикл
		МассивСтрок[Индекс] = СокрЛП(МассивСтрок[Индекс]);
	КонецЦикла;
		
	Возврат МассивСтрок;
	
КонецФункции

// Создает строку, состоящую из указанного количества одинаковых символов.
//
// Параметры:
// Символ - Строка - Символ, из которого будет создана строка.
// Количество - Число - Количество символов в создаваемой строке.
//
// Возвращаемое значение:
// Строка - Новая строка, состоящая из указанного количества одинаковых символов.
//
// Пример:
// Символ = "a";
// Количество = 5;
// Результат = СтрокаСимволов(Символ, Количество); // Результат будет равен "aaaaa".
Функция СтрокаСимволов(Символ, Количество) Экспорт
	
	Возврат СтрСоединить(Новый Массив(Количество + 1), Символ);
	
КонецФункции

// Возвращает строку, содержащую все русские буквы в указанном регистре.
//
// Параметры:
// НижнийРегистр - Булево - Если значение равно `Истина`, то в создаваемой строке будут использованы буквы в нижнем регистре. 
//                          По умолчанию равно `Истина`.
// ВерхнийРегистр - Булево - Если значение равно `Истина`, то в создаваемой строке будут использованы буквы в верхнем регистре. 
//                           По умолчанию равно `Ложь`.
//
// Возвращаемое значение:
// Строка - Новая строка, содержащая все русские буквы в указанном регистре. 
//          Если оба параметра НижнийРегистр и ВерхнийРегистр равны ``Истина`, то в создаваемой строке будут использованы буквы в обоих регистрах.
//
// Пример:
// Результат = РусскиеБуквы(Истина, Ложь); // Результат будет равен "абвгдеёжзийклмнопрстуфхцчшщъыьэюя".
// Результат = РусскиеБуквы(Ложь, Истина); // Результат будет равен "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ".
// Результат = РусскиеБуквы(Истина, Истина); // Результат будет равен "абвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ".
Функция РусскиеБуквы(НижнийРегистр = Истина, ВерхнийРегистр = Ложь) Экспорт
	
	Возврат Буквы("абвгдеёжзийклмнопрстуфхцчшщъыьэюя", НижнийРегистр, ВерхнийРегистр);
	
КонецФункции

// Возвращает строку, содержащую все английские буквы в указанном регистре.
//
// Параметры:
// НижнийРегистр - Булево - Если значение равно `Истина`, то в создаваемой строке будут использованы буквы в нижнем регистре. 
//                          По умолчанию равно `Истина`.
// ВерхнийРегистр - Булево - Если значение равно `Истина`, то в создаваемой строке будут использованы буквы в верхнем регистре. 
//                           По умолчанию равно `Ложь`.
//
// Возвращаемое значение:
// Строка - Новая строка, содержащая все английские буквы в указанном регистре. 
//          Если оба параметра НижнийРегистр и ВерхнийРегистр равны `Истина`, то в создаваемой строке будут использованы буквы в обоих регистрах.
//
// Пример:
// Результат = АнглийскиеБуквы(Истина, Ложь); // Результат будет равен "abcdefghijklmnopqrstuvwxyz".
// Результат = АнглийскиеБуквы(Ложь, Истина); // Результат будет равен "ABCDEFGHIJKLMNOPQRSTUVWXYZ".
// Результат = АнглийскиеБуквы(Истина, Истина); // Результат будет равен "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".
Функция АнглийскиеБуквы(НижнийРегистр = Истина, ВерхнийРегистр = Ложь) Экспорт
	
	Возврат Буквы("abcdefghijklmnopqrstuvwxyz", НижнийРегистр, ВерхнийРегистр);
	
КонецФункции

// Возвращает строку, содержащую все цифры.
//
// Возвращаемое значение:
// Строка - Новая строка, содержащая все цифры "1234567890".
//
// Пример:
// Результат = Цифры(); // Результат будет равен "1234567890".
Функция Цифры() Экспорт
	
	Возврат "1234567890";
	
КонецФункции

// Сравнивает две версии программного обеспечения.
//
// Ограничения:
// - Версии должны быть представлены в формате "X.X.X.X", где X - целое число.
//
// Параметры:
// Версия1 - Строка - Первая версия для сравнения.
// Версия2 - Строка - Вторая версия для сравнения.
//
// Возвращаемое значение:
// Число - Результат сравнения версий.
//         1 - если Версия1 больше Версия2.
//         0 - если Версия1 равна Версия2;
//        -1 - если Версия1 меньше Версия2;
//
// Пример:
// Результат = СравнитьВерсии("1.0.0", "1.1.0"); // Результат будет равен -1.
// Результат = СравнитьВерсии("1.1.0", "1.0.0"); // Результат будет равен 1.
// Результат = СравнитьВерсии("1.0.0", "1.0.0"); // Результат будет равен 0.
// Результат = СравнитьВерсии("1.2.3.4", "1.2.3"); // Результат будет равен 1.
// Результат = СравнитьВерсии("1.2.3", "1.2.3.4"); // Результат будет равен -1.
Функция СравнитьВерсии(Версия1, Версия2) Экспорт
	
	ЧастиВерсия1 = СтрРазделить(Версия1, ".");
	ЧастиВерсия2 = СтрРазделить(Версия2, ".");
	
	КоличествоЧастейВерсия1 = ЧастиВерсия1.Количество();
	КоличествоЧастейВерсия2 = ЧастиВерсия2.Количество();
	
	КоличествоЧастей = Макс(КоличествоЧастейВерсия1, КоличествоЧастейВерсия2);
	
	Для Инд = КоличествоЧастейВерсия1 По КоличествоЧастей - 1 Цикл
		ЧастиВерсия1.Добавить("0");
	КонецЦикла;
	
	Для Инд = КоличествоЧастейВерсия2 По КоличествоЧастей - 1 Цикл
		ЧастиВерсия2.Добавить("0");
	КонецЦикла;
	
	Результат = 0;
	
	Для Разряд = 0 По КоличествоЧастей - 1 Цикл
		
		Результат = Число(ЧастиВерсия1[Разряд]) - Число(ЧастиВерсия2[Разряд]);
		Если Результат <> 0 Тогда
			Прервать;
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Макс(Мин(Результат, 1), -1);
	
КонецФункции

// Выполняет сравнение версий
// 
// Параметры:
//  ПроверяемаяВерсия - Строка - Проверяемая версия
//  БазоваяВерсия - Строка - Базовая версия, с которой происходит сравнение
// 
// Возвращаемое значение:
//  Булево - Проверяемая версия больше базовой
Функция ВерсияБольше(ПроверяемаяВерсия, БазоваяВерсия) Экспорт
	
	Возврат СравнитьВерсии(ПроверяемаяВерсия, БазоваяВерсия) > 0;
	
КонецФункции

// Проверяет, что переданное значение является строковым представлением уникального идентификатора
//
// Параметры:
//  Значение - Строка
//
// Возвращаемое значение:
//  Булево
Функция ЭтоУникальныйИдентификаторСтрокой(Значение) Экспорт
	
	Если ТипЗнч(Значение) <> Тип("Строка") Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Шаблон = "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX";
	
	Если СтрДлина(Шаблон) <> СтрДлина(Значение) Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Для Позиция = 1 По СтрДлина(Значение) Цикл
		КодСимволаШаблона = КодСимвола(Шаблон, Позиция);
		КодСимволаЗначения = КодСимвола(Значение, Позиция);
		
		Если КодСимволаШаблона = 88 // X
			И ((КодСимволаЗначения < 48 ИЛИ КодСимволаЗначения > 57) // 0..9
			И (КодСимволаЗначения < 97 ИЛИ КодСимволаЗначения > 102) // a..f
			И (КодСимволаЗначения < 65 ИЛИ КодСимволаЗначения > 70)) // A..F
			ИЛИ КодСимволаШаблона = 45 И КодСимволаЗначения <> 45 Тогда // -
				Возврат Ложь;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Истина;
	
КонецФункции

// Из набора строк формирует набор уникальных строк.
// Сравнение происходит без учета регистра.
// 
// Параметры:
//  НеУникальныеСтроки - Массив Из Строка
// 
// Возвращаемое значение:
//  Массив Из Строка - Уникальные строки
Функция УникальныеСтроки(НеУникальныеСтроки) Экспорт
	
	Если НЕ ЗначениеЗаполнено(НеУникальныеСтроки) Тогда
		Возврат НеУникальныеСтроки;
	КонецЕсли;
	
	Хэш = Новый Соответствие();
	
	Результат = Новый Массив;
	
	Для Каждого Строка Из НеУникальныеСтроки Цикл
		Ключ = НРег(Строка);
		Если Хэш[Ключ] = Неопределено Тогда
			Результат.Добавить(Строка);
			Хэш.Вставить(Ключ, 1);
		КонецЕсли;
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

// Проверяет переданную строку, является ли она подходщим именем переменной - должна соответствовать требованиям к именам переменных
// 
// Параметры:
//  ИмяПеременной - Строка
// 
// Возвращаемое значение:
//  Булево - Это валидное имя переменной
Функция ЭтоВалидноеИмяПеременной(ИмяПеременной) Экспорт
	
	Попытка
		Проверка = Новый Структура;
		Проверка.Вставить(ИмяПеременной);
		Возврат Истина;
	Исключение
		Возврат Ложь;
	КонецПопытки;
	
КонецФункции

// Получает строку на языке платформы из набора строк на разных языках платформы.
// 
// Параметры:
//  СтрокаНаРазныхЯзыках - Строка - Строки на разных языках, разделенные символом ";" (точка с запятой). 
//    Строка на одном языке состоит из кода языка, указанного в метаданных, символа "=" (равно) и собственно строки текста на данном языке
//    в одинарных кавычках, двойных кавычках или без кавычек (когда указывается только один язык).
// 
// Возвращаемое значение:
//  Строка - Локализованное сообщение платформы
Функция ЛокализованноеСообщениеПлатформы(СтрокаНаРазныхЯзыках) Экспорт
	
	//@skip-check bsl-nstr-string-literal-format
	Возврат НСтр(СтрокаНаРазныхЯзыках, ЮТОкружение.ЛокальПлатформы());
	
КонецФункции

// Проверяет что строк соответствует "простому" шаблону - тексту со звездочками.
// 
// Параметры:
//  Строка - Строка - Проверямая строка
//  Шаблон - Строка - Шаблон
// 
// Возвращаемое значение:
//  Булево - Соответствует шаблону
Функция СоответствуетШаблону(Строка, Шаблон) Экспорт
	
	Результат = Неопределено;
	
	Если ЭтоПростойШаблон(Строка, Шаблон, Результат) Тогда
		Возврат Результат;
	КонецЕсли;
	
	Длина = СтрДлина(Строка);
	Блоки = СтрРазделить(Шаблон, "*", Истина);
	
	Позиция = -1;
	ПервыйБлок = 0;
	ПоследнийБлок = Блоки.ВГраница();
	
	Если Блоки[0] <> "" Тогда
		Если НЕ СтрНачинаетсяС(Строка, Блоки[0]) Тогда
			Возврат Ложь;
		Иначе
			ПервыйБлок = 1;
			Позиция = Позиция + СтрДлина(Блоки[0]);
		КонецЕсли;
	КонецЕсли;
	
	Для Инд = ПервыйБлок По ПоследнийБлок Цикл
		
		Позиция = Позиция + 1;
		Блок = Блоки[Инд];
		Если Блок <> "" Тогда
			Позиция = СтрНайти(Строка, Блок, , Позиция + 1);
			Если Позиция = 0 Тогда
				Возврат Ложь;
			Иначе
				Позиция = Позиция + СтрДлина(Блок) - 1;
			КонецЕсли;
		КонецЕсли;
		
	КонецЦикла;
	
	Если Блок <> "" Тогда
		Возврат СтрЗаканчиваетсяНа(Строка, Блок);
	Иначе
		Возврат Позиция <= Длина;
	КонецЕсли;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция Буквы(Буквы, НижнийРегистр, ВерхнийРегистр)
	
	Если НижнийРегистр И ВерхнийРегистр Тогда
		Возврат Буквы + ВРег(Буквы);
	ИначеЕсли НижнийРегистр Тогда
		Возврат Буквы;
	ИначеЕсли ВерхнийРегистр Тогда
		Возврат ВРег(Буквы);
	Иначе
		Возврат "";
	КонецЕсли;
	
КонецФункции

Функция ЭтоПростойШаблон(Строка, Шаблон, Результат)
	
	Если Шаблон = "" Тогда
		Результат = Ложь;
	ИначеЕсли Шаблон = "*" Тогда
		Результат = ЗначениеЗаполнено(Строка);
	ИначеЕсли НЕ СтрНайти(Шаблон, "*") Тогда
		Результат = СтрСравнить(Строка, Шаблон) = 0;
	Иначе
		Возврат Ложь;
	КонецЕсли;
	
	Возврат Истина;
	
КонецФункции

#КонецОбласти
