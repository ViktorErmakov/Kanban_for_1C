//©///////////////////////////////////////////////////////////////////////////©//
//
//  Copyright 2021-2025 BIA-Technologies Limited Liability Company
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

#Область Перечисления
// КонтекстыВызова
//  Возвращает перечисление возможных контекстов вызова
// Возвращаемое значение:
//  ФиксированнаяСтруктура - Контексты вызова:
//  * КлиентОбычноеПриложение - Строка
//  * КлиентУправляемоеПриложение - Строка
//  * Сервер - Строка
//  * ВызовСервера - Строка
Функция КонтекстыВызова() Экспорт
	
	Контексты = Новый Структура();
	
	Контексты.Вставить("КлиентОбычноеПриложение", "КлиентОбычноеПриложение");
	Контексты.Вставить("КлиентУправляемоеПриложение", "КлиентУправляемоеПриложение");
	Контексты.Вставить("Сервер", "Сервер");
	Контексты.Вставить("ВызовСервера", "ВызовСервера");
	
	// TODO Подозреваю нужно добавить web клиент
	
	Возврат Новый ФиксированнаяСтруктура(Контексты);
	
КонецФункции

// КонтекстыИсполнения
// Возвращает перечисление возможных контекстов исполнения тестов
//
// Возвращаемое значение:
//  ФиксированнаяСтруктура - Контексты исполнения:
//	* Клиент - Строка
//	* Сервер - Строка
Функция КонтекстыИсполнения() Экспорт
	
	Контексты = Новый Структура();
	
	Контексты.Вставить("Клиент", "Клиент");
	Контексты.Вставить("Сервер", "Сервер");
	
	Возврат Новый ФиксированнаяСтруктура(Контексты);
	
КонецФункции

// Возвращает перечисление возможных статусов выполнения теста, жизненный цикл теста
//
// Возвращаемое значение:
//  ФиксированнаяСтруктура - Статусы исполнения теста:
//  * Ожидание- Строка - Тест не выполнялся
//  * Исполнение- Строка - Тест выполняется в данный момент
//  * Успешно- Строка - Тест успешно пройден
//  * Ошибка- Строка - Тест упал с ошибкой выполнения
//  * Сломан- Строка - Тест упал на проверках утверждений
//  * Пропущен- Строка - Тест пропущен по каким либо причинам
//  * НеРеализован- Строка - Тест не реализован
Функция СтатусыИсполненияТеста() Экспорт
	
	Статусы = Новый Структура();
	
	Статусы.Вставить("Ожидание", "Ожидание");
	Статусы.Вставить("Исполнение", "Исполнение");
	Статусы.Вставить("Успешно", "Успешно");
	Статусы.Вставить("Ошибка", "Ошибка");
	Статусы.Вставить("Сломан", "Сломан");
	Статусы.Вставить("Пропущен", "Пропущен");
	Статусы.Вставить("НеРеализован", "НеРеализован");
	
	Возврат Новый ФиксированнаяСтруктура(Статусы);
	
КонецФункции

// Возвращает перечисление возможные уровней исполнения тестов.
// 
// Возвращаемое значение:
//  ФиксированнаяСтруктура - Уровни исполнения:
// * Модуль - Строка
// * НаборТестов - Строка 
// * Тест - Строка
Функция УровниИсполнения() Экспорт
	
	Уровни = Новый Структура;
	Уровни.Вставить("Модуль", "Модуль");
	Уровни.Вставить("НаборТестов", "НаборТестов");
	Уровни.Вставить("Тест", "Тест");
	
	Возврат Новый ФиксированнаяСтруктура(Уровни);
	
КонецФункции

// Возвращает перечисление для описания жизненного цикла прогона тестов
// 
// Возвращаемое значение:
//  ФиксированнаяСтруктура - Этапа прогона:
// * Инициализация - Строка
// * ЗагрузкаТестов - Строка
// * РазрешениеЗависимостей - Строка
// * ПрогонТестов - Строка
// * ФормированиеОтчета - Строка
Функция ЭтапыПрогона() Экспорт
	
	Этапы = Новый Структура;
	Этапы.Вставить("Инициализация", "Инициализация");
	Этапы.Вставить("ЗагрузкаТестов", "ЗагрузкаТестов");
	Этапы.Вставить("РазрешениеЗависимостей", "РазрешениеЗависимостей");
	Этапы.Вставить("ПрогонТестов", "ПрогонТестов");
	Этапы.Вставить("ФормированиеОтчета", "ФормированиеОтчета");
	
	Возврат Новый ФиксированнаяСтруктура(Этапы);
	
КонецФункции

#КонецОбласти

// ПараметрыЗапуска
//  Набор параметров подсистемы тестирования.
//  Параметры на английском, чтобы не держать несколько реализаций чтения и обработки параметров
//
// Возвращаемое значение:
//  Структура - Параметры:
// * ВыполнятьМодульноеТестирование - Булево - Признак необходимости выполнения тестов
// * reportPath - Строка - Файл или каталог сохранения отчета о тестировании
// * filter - см. ПараметрыФильтрации
// * settings - см. НастройкиВыполнения
// * closeAfterTests - Булево - Признак необходимости закрытия приложения по окончании прогона
// * reportFormat - Строка - Формат отчета о тестировании.
//                  Модули реализующие различные форматы отчетов собраны в подсистеме ФормированиеОтчета
// * logging - см. ПараметрыЛогирования
// * showReport - Булево - Признак необходимости отобразить отчет в 1с по окончании тестирования
// * exitCode - Строка - Путь к файлу, в который будет записан коды выхода
// * projectPath - Строка - Путь к каталогу с файлами проекта тестирования, репозиторию
// * ПодключатьВнешниеКомпоненты - Булево - Выполнять установку и подключение внешних компонент при старте.
//                                 Если выключено и включен запрет синхронных вызовов, 
//                                 то компоненты не будут доступы в тонком клиенте.
//                                 Если выключено и разрешены синхронные вызовы,
//                                 то компоненты можно установить вручнуюи тогда они будут доступны на клиенте.
// * ДымовыеТесты - Булево - Рубильник использования дымовых тестов
//                - Структура - Настройки дымовых тестов
// * rpc - Структура - Параметры внешнего запуска тестов. Параметры запуска тестов из EDT без перезапуска предприятия.
Функция ПараметрыЗапуска() Экспорт
	
	Параметры = Новый Структура;
	
	Параметры.Вставить("ВыполнятьМодульноеТестирование", Ложь);
	
	Параметры.Вставить("reportPath", "");
	Параметры.Вставить("closeAfterTests", Истина);
	Параметры.Вставить("filter", ПараметрыФильтрации());
	Параметры.Вставить("settings", НастройкиВыполнения());
	Параметры.Вставить("reportFormat", "jUnit");
	Параметры.Вставить("showReport", Ложь);
	Параметры.Вставить("logging", ПараметрыЛогирования());
	Параметры.Вставить("exitCode", "");
	Параметры.Вставить("projectPath", "");
	Параметры.Вставить("ДымовыеТесты", Ложь);
	Параметры.Вставить("rpc", ПараметрыВнешнегоЗапускаТестов());
	Параметры.Вставить("ПодключатьВнешниеКомпоненты", Истина);
	
	Возврат Параметры;
	
КонецФункции

// Выражение предиката.
//
// Параметры:
//  ВидСравнения - Строка - Возможные варианты см. ЮТПредикаты.Выражения
//  ИмяРеквизита - Строка - Имя реквизита
//  Значение - Произвольный - Значение
//
// Возвращаемое значение:
//  Структура - Выражение предиката:
// * ИмяРеквизита - Неопределено, Строка - Имя проверяемого реквизита
// * ВидСравнения - Строка
// * Значение - Произвольный, Неопределено - Операнд выражения
Функция ВыражениеПредиката(ВидСравнения, ИмяРеквизита = Неопределено, Значение = Неопределено) Экспорт
	
	Выражение = Новый Структура();
	ЮТОбщий.УказатьТипСтруктуры(Выражение, "Предикат");
	
	Выражение.Вставить("ИмяРеквизита", ИмяРеквизита);
	Выражение.Вставить("ВидСравнения", ВидСравнения);
	Выражение.Вставить("Значение", Значение);
	
	Возврат Выражение;
	
КонецФункции

// Доступные параметры (настройки) исполнения тестов
//
// Возвращаемое значение:
//  ФиксированнаяСтруктура - Параметры исполнения теста:
//  * ВТранзакции - Строка - Тест должен выполняться в транзакции
//  * УдалениеТестовыхДанных - Строка - Тест должен удалить созданные тестовые данные
//  * Перед - Строка - Перед тестом должен выполниться указанный обработчик события вместо основного
//  * После - Строка - После теста должен выполниться указанный обработчик события вместо основного
Функция ПараметрыИсполненияТеста() Экспорт
	
	Параметры = Новый Структура();
	Параметры.Вставить("ВТранзакции", "ВТранзакции");
	Параметры.Вставить("УдалениеТестовыхДанных", "УдалениеТестовыхДанных");
	Параметры.Вставить("Перед", "Перед");
	Параметры.Вставить("После", "После");
	
	Возврат Новый ФиксированнаяСтруктура(Параметры);
	
КонецФункции

// Параметры создания объектов, используется при загрузке макетов.
// 
// Параметры:
//  ПараметрыЗаписи - см. ЮТОбщий.ПараметрыЗаписи
//  ФикцияОбязательныхПолей - Булево - Фикция обязательных полей
// 
// Возвращаемое значение:
//  Структура - Параметры создания объектов:
// * ФикцияОбязательныхПолей - Булево
// * ПараметрыЗаписи - см. ЮТОбщий.ПараметрыЗаписи
Функция ПараметрыСозданияОбъектов(Знач ПараметрыЗаписи = Неопределено, ФикцияОбязательныхПолей = Ложь) Экспорт
	
	Если ПараметрыЗаписи = Неопределено Тогда
		ПараметрыЗаписи = ЮТОбщий.ПараметрыЗаписи();
	Иначе
		ВходныеПараметрыЗаписи = ПараметрыЗаписи;
		ПараметрыЗаписи = ЮТОбщий.ПараметрыЗаписи();
		ЗаполнитьЗначенияСвойств(ПараметрыЗаписи, ВходныеПараметрыЗаписи);
	КонецЕсли;
	
	Возврат Новый Структура("ФикцияОбязательныхПолей, ПараметрыЗаписи", ФикцияОбязательныхПолей, ПараметрыЗаписи);
	
КонецФункции

// Создает новое описание зависимости теста.
// 
// Возвращаемое значение:
//  Структура - Новое описание зависимости:
// * Идентификатор - Строка - Идентификатор зависимости
// * МетодРеализации - Строка - Метод, вызываемый для разрешения зависимости
// * Параметры - Массив из Произвольный - Параметры зависимости, будут проброшены в метод
// * Ключ - Неопределено - Уникальный ключ зависимости, рассчитывается движком
// * Асинхронный - Булево - Признак, что зависимость асинхронная. Асинхронность реализуется за счет передачи ОписанияОповещения в метод реализации
// * ОбработкаНаСервере - Булево - Признак обработки зависимости на сервере
// * ДоступностьНаКлиенте - Булево - Признак доступности зависимости на клиенте
// * ДоступностьНаСервере - Булево - Признак доступности зависимости на сервере
Функция НовоеОписаниеЗависимости() Экспорт
	
	Описание = Новый Структура;
	Описание.Вставить("Идентификатор", "");
	Описание.Вставить("МетодРеализации", "");
	Описание.Вставить("Параметры", Новый Массив);
	Описание.Вставить("Ключ", Неопределено);
	Описание.Вставить("Асинхронный", Ложь);
	Описание.Вставить("ОбработкаНаСервере", Ложь);
	Описание.Вставить("ДоступностьНаКлиенте", Истина);
	Описание.Вставить("ДоступностьНаСервере", Истина);
	
	Возврат Описание;
	
КонецФункции

// Новое описание окружения.
// 
// Возвращаемое значение:
//  Структура - Описание окружения:
// * Конфигурация - Строка -
// * ВерсияКонфигурации - Строка -
// * ВерсияПлатформы - Строка -
// * ИнформационнаяСреда - Строка -
// * ТестовыйДвижок - Строка -
// * ВерсияТестовогоДвижка - Строка -
// * ОперационнаяСистемаКлиент - Строка - Возможные значения: Linux, Windows, MacOS
// * АрхитектураКлиент - Строка - Возможные значения: x86_64, i386
// * ОперационнаяСистемаСервер - Строка - Возможные значения: Linux, Windows, MacOS
// * АрхитектураСервер - Строка - Возможные значения: x86_64, i386
// * ВстроенныйЯзык - Строка - Возможные значения: ru, en
// * ФайловаяБаза - Булево -
// * ОбычноеПриложение - Булево -
// * ВебКлиент - Булево -
// * ТолстыйКлиент - Булево -
// * ВремяЗапуска - Дата -
// * Расширения - Массив из Структура - Описание расширений
Функция НовоеОписаниеОкружения() Экспорт
	
	Окружение = Новый Структура;
	Окружение.Вставить("Конфигурация", "");
	Окружение.Вставить("ВерсияКонфигурации", "");
	Окружение.Вставить("ВерсияПлатформы", "");
	Окружение.Вставить("ИнформационнаяСреда", "DEV");
	Окружение.Вставить("ТестовыйДвижок", "YAxUnit");
	Окружение.Вставить("ВерсияТестовогоДвижка", "");
	
	Окружение.Вставить("ВстроенныйЯзык", "");
	
	Окружение.Вставить("ОперационнаяСистемаКлиент", "");
	Окружение.Вставить("АрхитектураКлиент", "");
	
	Окружение.Вставить("ОперационнаяСистемаСервер", "");
	Окружение.Вставить("АрхитектураСервер", "");
	
	Окружение.Вставить("ФайловаяБаза", Ложь);
	Окружение.Вставить("ОбычноеПриложение", Ложь);
	Окружение.Вставить("ВебКлиент", Ложь);
	Окружение.Вставить("ТолстыйКлиент", Ложь);
	Окружение.Вставить("ВремяЗапуска", '00010101');
	
	Окружение.Вставить("Расширения", Новый Массив);
	
	Возврат Окружение;
	
КонецФункции

#Область СтруктурыДанных

// Описание исполняемого тестового модуля.
//  Содержит всю необходимую информацию для прогона тестов, а также данные результата
//
// Возвращаемое значение:
//  Структура - Описание тестового модуля:
// * Метаданные - см. ОписаниеМетаданныеМодуля
// * Теги - Массив из Строка - Коллекция тегов набора
// * НаборыТестов - Массив из см. ОписаниеИсполняемогоНабораТестов
// * Ошибки - Массив из см. ЮТФабрикаСлужебный.ОписаниеВозникшейОшибки
// * НастройкиВыполнения- Структура - Настройки исполнения теста
// * Зависимости- Массив Из см. НовоеОписаниеЗависимости - Зависимости тестового модуля
Функция ОписаниеИсполняемогоТестовогоМодуля() Экспорт
	
	Описание = БазовоеОписаниеИсполняемогоОбъекта();
	
	Описание.Вставить("Метаданные");
	Описание.Вставить("НаборыТестов");
	
	//@skip-check constructor-function-return-section
	Возврат Описание;
	
КонецФункции

// ОписаниеИсполняемогоНабораТестов
//  Возвращает описание исполняемого тестового набора.
//  Содержит данные необходимые для выполнения прогона тестов
//
// Возвращаемое значение:
//  Структура - Описание исполняемого набора тестов:
// * Имя - Строка - Имя набора
// * Представление - Строка - Представление набора
// * Теги - Массив из Строка - Тэги набора
// * Ошибки - Массив из см. ЮТФабрикаСлужебный.ОписаниеВозникшейОшибки - Описания ошибок выполнения теста
// * Режим - Строка - Режим исполнения набора, см. ЮТФабрика.КонтекстыВызова
// * Тесты - Массив из см. ОписаниеИсполняемогоТеста - Тесты набора
// * Выполнять - Булево - Признак, что можно выполнить прогон набора (нет ошибок блокирующих запуск)
// * ДатаСтарта - Число - Дата запуска набора
// * Длительность - Число - Продолжительность выполнения набора
// * НастройкиВыполнения - Структура - Настройки исполнения теста
// * Зависимости- Массив Из см. ЮТФабрика.НовоеОписаниеЗависимости - Зависимости тестового набора
Функция ОписаниеИсполняемогоНабораТестов() Экспорт
	
	Описание = БазовоеОписаниеИсполняемогоОбъекта();
	
	Описание.Вставить("Имя", "");
	Описание.Вставить("Представление", "");
	Описание.Вставить("Режим", "");
	Описание.Вставить("Тесты");
	Описание.Вставить("Выполнять", Ложь);
	Описание.Вставить("ДатаСтарта", 0);
	Описание.Вставить("Длительность", 0);
	
	//@skip-check constructor-function-return-section
	Возврат Описание;
	
КонецФункции

// ОписаниеИсполняемогоТеста
//  Возвращает описание исполняемого теста
//  Содержит данные необходимые для выполнения прогона тестов
//
// Возвращаемое значение:
//  Структура - Описание исполняемого теста:
// * Имя - Строка - Имя/представление теста
// * Метод - Строка - Имя тестового метода
// * ПолноеИмяМетода - Строка - Полное имя тестового метода, ИмяМодуля.ИмяМетода
// * Теги - Массив из Строка - Теги теста
// * Режим - Строка - Режим исполнения теста, см. ЮТФабрика.КонтекстыВызова
// * ДатаСтарта - Число - Дата запуска теста
// * Длительность - Число - Продолжительность выполнения теста
// * Статус - Строка - Статус выполнения теста, см. ЮТФабрика.СтатусыИсполненияТеста
// * Ошибки - Массив из см. ЮТФабрикаСлужебный.ОписаниеВозникшейОшибки - Описания ошибок выполнения теста
// * НастройкиВыполнения- Структура - Настройки исполнения теста
// * Параметры - Неопределено, Массив из Произвольный - Набор параметров теста
// * НомерВНаборе - Число - Порядковый номер теста в наборе
// * Зависимости- Массив Из см. ЮТФабрика.НовоеОписаниеЗависимости - Зависимости теста
Функция ОписаниеИсполняемогоТеста() Экспорт
	
	Описание = БазовоеОписаниеИсполняемогоОбъекта();
	Описание.Вставить("Имя", "");
	Описание.Вставить("Метод", "");
	Описание.Вставить("ПолноеИмяМетода", "");
	Описание.Вставить("Режим", "");
	Описание.Вставить("ДатаСтарта", 0);
	Описание.Вставить("Длительность", 0);
	Описание.Вставить("Статус", "");
	Описание.Вставить("Параметры");
	Описание.Вставить("НомерВНаборе", 0);
	
	//@skip-check constructor-function-return-section
	Возврат Описание;
	
КонецФункции

// Возвращает структуру описания метаданных модуля
// Возвращаемое значение:
//  Структура - Метаданные модуля:
// * Тип - Строка - Тип модуля, поддерживаемые значения: `ОбщийМодуль`, `ВнешняяОбработка`
// * Имя - Строка - Имя модуля
// * Расширение - Строка - Имя расширения, владельца модуля
// * КлиентУправляемоеПриложение - Булево - Доступность контекста
// * КлиентОбычноеПриложение - Булево - Доступность контекста
// * Сервер - Булево - Доступность контекста
// * ВызовСервера - Булево - Доступность контекста
// * Глобальный - Булево - Доступность контекста
Функция ОписаниеМетаданныеМодуля() Экспорт
	
	Описание = Новый Структура;
	Описание.Вставить("Тип", "");
	Описание.Вставить("Имя", "");
	Описание.Вставить("Расширение", "");
	Описание.Вставить("КлиентУправляемоеПриложение", Ложь);
	Описание.Вставить("КлиентОбычноеПриложение", Ложь);
	Описание.Вставить("Сервер", Ложь);
	Описание.Вставить("ВызовСервера", Ложь);
	Описание.Вставить("Глобальный", Ложь);
	
	Возврат Описание;
	
КонецФункции

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// ПараметрыФильтрации
// 	Возвращает структуру отборов для поиска тестов
// Возвращаемое значение:
//  Структура - Параметры фильтрации:
// * extensions - Неопределено - Нет фильтрации по расширениям
//              - Массив из Строка - Список тестовых расширений
// * modules - Неопределено - Нет фильтрации по модулям
//           - Массив из Строка - Список тестовых модулей
// * suites - Неопределено - Нет фильтрации по тестовым наборам
//          - Массив из Строка - Список тестовых наборов
// * paths - Неопределено - Нет фильтрации по путям
//         - Массив из Строка - Список путей до тестовых методов, путь может быть не полным.
//                                  Например:
//                                  + tests - Ищем тесты в расширении tests
//                                  + tests.ОМ_ОбщегоНазначения - Ищем тесты в модуле ОМ_ОбщегоНазначения расширения tests
//                                  + tests.ОМ_ОбщегоНазначения.ПолучитьЗначениеРеквизита - указание конкретного теста
// * tags - Неопределено - Нет фильтрации по тегам
//        - Массив из Строка - Список тэгов
// * contexts - Неопределено - Нет фильтрации по контекстам
//            - Массив из Строка - Список тестируемых контекстов
// * tests - Неопределено - Нет фильтрации по тестам
//         - Массив из Строка - Список полных имен тестовых методов. ИмяМодуля.ИмяМетода{.Контекст}
Функция ПараметрыФильтрации() Экспорт
	
	Параметры = Новый Структура;
	Параметры.Вставить("extensions", Неопределено);
	Параметры.Вставить("modules", Неопределено);
	Параметры.Вставить("suites", Неопределено);
	Параметры.Вставить("tags", Неопределено);
	Параметры.Вставить("contexts", Неопределено);
	Параметры.Вставить("paths", Неопределено);
	Параметры.Вставить("tests", Неопределено);
	
	Возврат Параметры;
	
КонецФункции

Функция НастройкиВыполнения() Экспорт
	
	Настройки = Новый Структура();
	
	ПараметрыИсполнения = ПараметрыИсполненияТеста();
	Настройки.Вставить(ПараметрыИсполнения.ВТранзакции, Ложь);
	
	Возврат Настройки;
	
КонецФункции

Функция ПараметрыЛогирования() Экспорт
	
	Параметры = Новый Структура();
	Параметры.Вставить("file", "");
	Параметры.Вставить("console", Ложь);
	Параметры.Вставить("enable", Неопределено);
	Параметры.Вставить("level", ЮТЛогирование.УровниЛога().Отладка);
	
	Возврат Параметры;
	
КонецФункции

// Структура параметров подключения к серверу внешнего управления
// 
// Возвращаемое значение:
//  Структура - Параметры внешнего запуска тестов:
// * port - Число - Порт сервера
// * enable - Булево - Использовать внешнее управление
// * key - Строка - Ключ клиента, для приветствия
// * transport - Строка - используемый транспортный протокол
Функция ПараметрыВнешнегоЗапускаТестов() Экспорт
	
	Параметры = Новый Структура();
	Параметры.Вставить("port", 0);
	Параметры.Вставить("enable", Ложь);
	Параметры.Вставить("key", "");
	Параметры.Вставить("transport", "ws");
	
	Возврат Параметры;
	
КонецФункции

Функция БазовоеОписаниеИсполняемогоОбъекта() Экспорт
	
	Возврат Новый Структура("Теги, НастройкиВыполнения, Зависимости, Ошибки");
	
КонецФункции

#КонецОбласти
