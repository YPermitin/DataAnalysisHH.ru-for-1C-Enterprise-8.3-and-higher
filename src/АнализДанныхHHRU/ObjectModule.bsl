﻿
Перем СоответствиеСимвольныхКодовВалютHHRUиЦБ;

#Область ФормаДополнительнойОбработки 
  
#Область ОбщиеОбязательныеПроцедуры 
  
// Обязательная функция - содержит параметры работы с обработкой  
// 
Функция СведенияОВнешнейОбработке() Экспорт 
      
    РегистрационныеДанные = Новый Структура;
      
    //       * Наименование - Строка - Необязательный. Представление для администратора (наименование элемента справочника). 
    //           Если не заполнено, то берется представление объекта метаданных внешнего объекта. 
    РегистрационныеДанные.Вставить("Наименование", "Анализ данных HH.ru");
      
    //       * БезопасныйРежим - Булево - Необязательный. Признак подключения внешней обработки в безопасном режиме. 
    //           Значение по умолчанию Истина (обработка будет выполняться безопасно). 
    //           Подробнее - см. разделы справки "ВнешниеОтчетыМенеджер.Подключить" и "ВнешниеОбработкиМенеджер.Подключить". 
    РегистрационныеДанные.Вставить("БезопасныйРежим", Ложь);
      
    //       * Версия - Строка - Версия объекта. 
    //           Задается в формате: "<Старший номер>.<Младший номер>". 
    РегистрационныеДанные.Вставить("Версия", "1.0");
      
    //       * ВерсияБСП - Строка - Необязательный. Версия библиотеки, на которую рассчитывают механизмы внешнего объекта. 
    //           Подробнее - см. СтандартныеПодсистемыСервер.ВерсияБиблиотеки(). 
    РегистрационныеДанные.Вставить("ВерсияБСП", "");
      
    //       * Вид - Строка - Вид внешнего объекта. Соответствует реквизиту "Вид" (ПеречислениеСсылка.ВидыДополнительныхОтчетовИОбработок). 
    //           Для определения вида можно использовать функции "Вид*" общего модуля ДополнительныеОтчетыИОбработкиКлиентСервер, 
    //           или указать вид явно: 
    //           ** "ПечатнаяФорма" 
    //           ** "ЗаполнениеОбъекта" 
    //           ** "СозданиеСвязанныхОбъектов" 
    //           ** "Отчет" 
    //           ** "ДополнительнаяОбработка" 
    //           ** "ДополнительныйОтчет" 
    РегистрационныеДанные.Вставить("Вид", "ДополнительныйОтчет");
      
    //       * Информация - Строка - Необязательный. Краткая информация по внешнему объекту. 
    //           В этом параметре для администратора рекомендуется указать описание возможностей внешнего объекта. 
    //           Если не заполнено, то берется комментарий объекта метаданных внешнего объекта.  
    РегистрационныеДанные.Вставить("Информация", "Анализ данных HH.ru");
  
    // Назначение 
    МассивНазначенийОбработки = ПолучитьНазначениеОбработки();
    РегистрационныеДанные.Вставить("Назначение", МассивНазначенийОбработки);
      
    // Команды 
    ТаблицаКомандОбработки = ПолучитьТаблицуКомандОбработки();
    РегистрационныеДанные.Вставить("Команды", ТаблицаКомандОбработки);
      
    // Дополнительные необязательные параметры 
    РегистрационныеДанные.Вставить("ВерсияБСП", "");
      
    // Результат функции 
    Возврат РегистрационныеДанные;
      
КонецФункции
  
// Служебная функция обработки Экспорт - не обязательно  
// 
Функция ПолучитьНазначениеОбработки() Экспорт 
      
    // Инициализация массива 
    МассивНазначенийОбработки = Новый Массив;
      
    // Заполняем массив 
    //МассивНазначенийОбработки.Добавить("Справочник.Организации"); 
      
    /////////////////////////////////////////////////////////////////////////////// 
    //// При добавлении объекта в массив назначений следует убедиться, что в 
    //// его формах (в основном объекта и списка) прописан код по использованию 
    //// подсистемы дополнительных обработок 
    ////  
    //// Например, в форме объекта в процедуре "ПриСозданииНаСервере" прописать: 
    //// ДополнительныеОтчетыИОбработки.ПриСозданииНаСервере(ЭтаФорма); 
    //// *текст кода может меняться в зависимости от версии БСП 
  
    // Результат функции 
    Возврат МассивНазначенийОбработки;
      
КонецФункции
  
// Служебная функция обработки Экспорт - не обязательно  
// 
Функция ПолучитьТаблицуКомандОбработки() Экспорт 
      
    // Инициализация таблицы 
    // Состав может меняться в зависимости от версии БСП 
    тзКоманд = Новый ТаблицаЗначений;
    тзКоманд.Колонки.Добавить("Идентификатор"           , Новый ОписаниеТипов("Строка")); // Это может быть любая текстовая строка, уникальная в пределах данной обработки 
    тзКоманд.Колонки.Добавить("Представление"           , Новый ОписаниеТипов("Строка")); // Представление команды в пользовательском интерфейсе 
    тзКоманд.Колонки.Добавить("ПоказыватьОповещение"    , Новый ОписаниеТипов("Булево")); // Надо показывать оповещение или нет 
    тзКоманд.Колонки.Добавить("Модификатор"             , Новый ОписаниеТипов("Строка")); // Дополнительный модификатор команды 
    тзКоманд.Колонки.Добавить("Использование"           , Новый ОписаниеТипов("Строка")); // Вирант использования команды (см. ниже) 
    тзКоманд.Колонки.Добавить("Скрыть"                  , Новый ОписаниеТипов("Булево")); // Серверная команда, которая вызывается из формы внешней обработки. 
      
    // Колонки ВариантЗапуска и Использование можно и желательно использовать по одиночке 
    // В случае указания обеих их значения должны совпадать 
      
    // Варианты для значения колонки "Использование": 
    //  ОткрытиеФормы – просто открывает форму обработки. 
    //  ВызовКлиентскогоМетода – будет вызвана клиентская процедура из модуля формы обработки (Печать или ВыполнитьКоманду). 
    //  ВызовСерверногоМетода  - будет вызвана серверная процедура из модуля обработки (Печать или ВыполнитьКоманду). 
    //  СценарийВБезопасномРежиме – тоже будет вызвана серверная процедура из модуля обработки в безопасном режиме (исп. с определнной версии БСП). 
  
    ДобавитьКоманду(тзКоманд, "АнализДанныхHHRU", "Анализ данных HH.ru", Ложь, "ОткрытиеФормы", "ПечатьMXL", Ложь);
      
    // Следует обратить внимание на значение колонки "Модификатор" - в зависимости от значения 
    // меняется принцип формирования процедуры "Печать" для внешней печатной формы 
    // Принципы использования данного параметра описаны ниже в модуле 
      
    // Результат функции 
    Возврат тзКоманд;
      
КонецФункции
  
// Добавление команды в таблицу команд 
// 
Процедура ДобавитьКоманду(ТаблицаКоманд, Идентификатор, Представление, ПоказыватьОповещение, Использование, Модификатор, Скрыть)
      
    // Основная команда обработки 
    строкаКоманды = ТаблицаКоманд.Добавить();
    //           ** Идентификатор - Строка - Имя команды. Для печатной формы - список макетов. 
    строкаКоманды.Идентификатор = Идентификатор;
    //           ** Представление - Строка - Представление команды для конечного пользователя. 
    строкаКоманды.Представление = Представление;
    //           ** ПоказыватьОповещение - Булево - Истина = при запуске команды будет показано стандартное оповещение. 
    //               Не работает для команд "ОткрытиеФормы". 
    строкаКоманды.ПоказыватьОповещение = ПоказыватьОповещение;
    //           ** Использование - Строка - Тип команды. Соответствует реквизиту "ВариантЗапуска" (ПеречислениеСсылка.СпособыВызоваДополнительныхОбработок). 
    //               *** "ВызовКлиентскогоМетода" 
    //               *** "ВызовСерверногоМетода" 
    //               *** "ЗаполнениеФормы" 
    //               *** "ОткрытиеФормы" 
    //               *** "СценарийВБезопасномРежиме" 
    строкаКоманды.Использование = Использование;
    //           ** Модификатор - Строка - Вспомогательный модификатор команды. 
    //               *** "ПечатьMXL" для печатных форм на основе макетов MXL. 
    строкаКоманды.Модификатор = Модификатор;
    //           ** Скрыть - Булево - Истина если команду необходимо скрывать в форме элемента. 
    строкаКоманды.Скрыть = Скрыть;
    //       * Разрешения - Массив из ОбъектXDTO {http://www.1c.ru/1cFresh/ApplicationExtensions/Permissions/a.b.c.d}PermissionBase - 
    //           Необязательный. Массив разрешений, предоставленных дополнительному отчету или обработке при работе в безопасном 
    //           режиме. 
    //строкаКоманды.Разрешения ... 
      
КонецПроцедуры
  
#КонецОбласти 
  
/////////////////////////////////////////////////////////////////////////////// 
//// ПРОЧИЕ ВНЕШНИЕ ОБРАБОТКИ 
  
#Область ПрочиеВнешниеОбработки 
  
/////////////////////////////////////////////////////////////////////////////// 
//// Процедура "ВыполнитьКоманду" при использованиии варианта запуска 
//// "ВызовСерверногоМетода" должна находиться в модуле обработки 
////  
//// Описание параметров процедуры: 
//// - Если тип обработки = "ДополнительнаяОбработка" или "ДополнительныйОтчет" 
////        (ИдентификаторКоманды, ПараметрыВыполненияКоманды = Неопределено) 
////  
//// - Если тип обработки = "СозданиеСвязанныхОбъектов" 
////        (ИдентификаторКоманды, ОбъектыНазначения, СозданныеОбъекты, ПараметрыВыполненияКоманды = Неопределено) 
////  
//// - Если тип обработки = "ЗаполнениеОбъекта" 
////        (ИдентификаторКоманды, ОбъектыНазначения, ПараметрыВыполненияКоманды = Неопределено) 
////  
//// - Если тип обработки = "Отчет" 
////        (ИдентификаторКоманды, ОбъектыНазначения, ПараметрыВыполненияКоманды = Неопределено) 
////  
//// В качестве примера приведен вариант для дополнительной обработки/отчета 
////  
  
  
// Обязательная процедура внешней обработки  
// 
// В зависимости от типа обработки может содержать разные параметры 
// Но обязательным всегда есть ИдентификаторКоманды 
Процедура ВыполнитьКоманду(ИдентификаторКоманды, ПараметрыВыполненияКоманды = Неопределено) Экспорт
  
    // Нет серверных команд 
          
КонецПроцедуры
  
#КонецОбласти 
  
//// ...ПРОЧИЕ ВНЕШНИЕ ОБРАБОТКИ 
/////////////////////////////////////////////////////////////////////////////// 
  
#КонецОбласти

#Область СтандартныеСобытия

Процедура Инициализация()
	
	СоответствиеСимвольныхКодовВалютHHRUиЦБ = Новый Соответствие;
	СоответствиеСимвольныхКодовВалютHHRUиЦБ.Вставить("RUR", "RUR");
	СоответствиеСимвольныхКодовВалютHHRUиЦБ.Вставить("AZN", "AZN");
	СоответствиеСимвольныхКодовВалютHHRUиЦБ.Вставить("BYR", "BYN");
	СоответствиеСимвольныхКодовВалютHHRUиЦБ.Вставить("EUR", "EUR");
	СоответствиеСимвольныхКодовВалютHHRUиЦБ.Вставить("GEL", "GEL");
	СоответствиеСимвольныхКодовВалютHHRUиЦБ.Вставить("KGS", "KGS");
	СоответствиеСимвольныхКодовВалютHHRUиЦБ.Вставить("KZT", "KZT");
	СоответствиеСимвольныхКодовВалютHHRUиЦБ.Вставить("UAH", "UAH");
	СоответствиеСимвольныхКодовВалютHHRUиЦБ.Вставить("USD", "USD");
	СоответствиеСимвольныхКодовВалютHHRUиЦБ.Вставить("UZS", "UZS");
	
КонецПроцедуры

Процедура ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	//Получаем схему из макета
	СхемаКомпоновкиДанных = ПолучитьМакет("ОсновнаяСхемаКомпоновкиДанных");        
	//Из схемы возьмем настройки по умолчанию
	Настройки = КомпоновщикНастроек.ПолучитьНастройки();         
	//Помещаем в переменную данные о расшифровке данных
	ДанныеРасшифровки = Новый ДанныеРасшифровкиКомпоновкиДанных;          
	//Формируем макет, с помощью компоновщика макета
	КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;          
	//Передаем в макет компоновки схему, настройки и данные расшифровки
	МакетКомпоновки = КомпоновщикМакета.Выполнить(СхемаКомпоновкиДанных, Настройки, ДанныеРасшифровки);
	
	Если КурсыВалют.Количество() = 0 Тогда
		ЗагрузитьПоследниеКурсыВалют();
	КонецЕсли;
	
	Если Регионы.Количество() = 0 Тогда
		ЗагрузитьТаблицуРегионов();
	КонецЕсли;
	
	Если Валюты.Количество() = 0 Тогда
		ЗагрузитьТаблицуВалют();
	КонецЕсли;
	
	ПараметрВыводитьЛоготип = Настройки.ПараметрыДанных.Элементы.Найти("ВыводитьЛоготип").Значение;
	ПараметрТекстПоиска = СокрЛП(Настройки.ПараметрыДанных.Элементы.Найти("ПоискВакансий").Значение);
	Если ПараметрТекстПоиска <> СокрЛП(ЭтотОбъект.ТекстПоиска) Тогда
		ЗагрузитьДанныеВакансий(ПараметрТекстПоиска);
		ЭтотОбъект.ТекстПоиска = ПараметрТекстПоиска;
	КонецЕсли;
	
	ВнешниеНаборыДанных = Новый Структура;
	ВнешниеНаборыДанных.Вставить("КурсыВалют", КурсыВалют.Выгрузить());
	ВнешниеНаборыДанных.Вставить("ДанныеПоВакансиям", ДанныеВакансий.Выгрузить());
	ВнешниеНаборыДанных.Вставить("Регионы", Регионы.Выгрузить());
	
	//Выполним компоновку с помощью процессора компоновки
	ПроцессорКомпоновкиДанных = Новый ПроцессорКомпоновкиДанных;
	ПроцессорКомпоновкиДанных.Инициализировать(МакетКомпоновки, ВнешниеНаборыДанных,ДанныеРасшифровки);
	
	Если ПараметрВыводитьЛоготип = Истина Тогда
		МакетЛоготип = ПолучитьМакет("МакетЛоготип");
		ОбластьЛоготип = МакетЛоготип.ПолучитьОбласть("Лого");
		ДокументРезультат.Вывести(ОбластьЛоготип);
	КонецЕсли;
	
	//Выводим результат в табличный документ
	ПроцессорВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВТабличныйДокумент;
	ПроцессорВывода.УстановитьДокумент(ДокументРезультат);
	
	ПроцессорВывода.НачатьВывод();
	ЭлементРезультатКомпоновки = ПроцессорКомпоновкиДанных.Следующий();
	Пока ЭлементРезультатКомпоновки <> Неопределено Цикл
		ПроцессорВывода.ВывестиЭлемент(ЭлементРезультатКомпоновки);
		ЭлементРезультатКомпоновки = ПроцессорКомпоновкиДанных.Следующий();
	КонецЦикла;
	ПроцессорВывода.ЗакончитьВывод();
	           	
КонецПроцедуры

#КонецОбласти

#Область HH_RU

Процедура ЗагрузитьДанныеВакансий(ТекстПоиска)
	
	Если НЕ ЗначениеЗаполнено(ТокенДоступа) Тогда
		Возврат;
	КонецЕсли;
	
	ТекущаяСтраница = 1;
	
	ДанныеВакансий.Очистить();
	Пока ТекущаяСтраница <> -1 Цикл	
		Попытка
			UrlЗапроса = "/vacancies?per_page=100&page="
	            + ТекущаяСтраница
	            + "&text=" + ТекстПоиска;
				
			ОтветСтрокаJSON =  ВыполнитьЗапросAPI(UrlЗапроса); 
			
			ЧтениеJSON = Новый ЧтениеJSON;
			ЧтениеJSON.УстановитьСтроку(ОтветСтрокаJSON);
			ОбъектИзJSON = ПрочитатьJSON(ЧтениеJSON, Истина);
			
			Для Каждого Вакансия Из ОбъектИзJSON["items"] Цикл
				НовВакансия = ДанныеВакансий.Добавить();
				НовВакансия.Заголовок = Вакансия["name"];
				НовВакансия.Обязанности = ЗаменитьТегиПодсветки(Вакансия["snippet"]["responsibility"]);
				НовВакансия.Требование = ЗаменитьТегиПодсветки(Вакансия["snippet"]["requirement"]);
				
				НовВакансия.URL = Вакансия["url"];
				НовВакансия.МестоположениеИмя = Вакансия["area"]["name"];
				НовВакансия.МестоположениеUrl = Вакансия["area"]["url"];
				НовВакансия.МестоположениеID = ПреобразоватьКЧислу(Вакансия["area"]["id"]);
				
				// Заполняем регионы
				ЗаполнитьРегионыВакансии(НовВакансия);
				
				НовВакансия.ДатаПубликации = ПреобразоватьКДате(Вакансия["published_at"]); // !!! Необходима конвертация
				НовВакансия.ДатаСоздания = ПреобразоватьКДате(Вакансия["created_at"]);
				
				НовВакансия.Премиум = Вакансия["premium"];
				
				ДанныеПоЗарплате = Вакансия["salary"];
				Если ДанныеПоЗарплате <> Неопределено Тогда
					ВалютаВакансии = ДанныеПоЗарплате["currency"];
					Если ВалютаВакансии <> Неопределено Тогда
						КодВалютыПоДаннымHHRU = СоответствиеСимвольныхКодовВалютHHRUиЦБ.Получить(ВалютаВакансии);
						Если КодВалютыПоДаннымHHRU = Неопределено Тогда
							НовВакансия.ЗарплатаВалюта = ВалютаВакансии;                 
						Иначе
							НовВакансия.ЗарплатаВалюта = КодВалютыПоДаннымHHRU;                 
						КонецЕсли;
					КонецЕсли;
					НовВакансия.ЗарплатаОт = ДанныеПоЗарплате["from"];
					НовВакансия.ЗарплатаДо = ДанныеПоЗарплате["to"];
				КонецЕсли;
				
				ТипВакансии = Вакансия["type"];
				Если ТипВакансии <> Неопределено Тогда
					НовВакансия.ТипВакансииИмя = ТипВакансии["name"];
					НовВакансия.ТипВакансииID = ТипВакансии["id"];
				КонецЕсли;
				
				РаботодательВакансии = Вакансия["employer"];
				Если РаботодательВакансии <> Неопределено Тогда
					НовВакансия.РаботодательВакансииURL = РаботодательВакансии["vacancies_url"];
					НовВакансия.РаботодательURL = РаботодательВакансии["url"];
					НовВакансия.РаботодательИмя = РаботодательВакансии["name"];
					НовВакансия.РаботодательID = РаботодательВакансии["id"];
					ЛогоРаботодателя = РаботодательВакансии["logo_urls"];
					Если ЛогоРаботодателя <> Неопределено Тогда
						НовВакансия.РаботодательЛого = ЛогоРаботодателя["original"];
						НовВакансия.РаботодательЛого90 = ЛогоРаботодателя["90"];
						НовВакансия.РаботодательЛого240 = ЛогоРаботодателя["240"];
					КонецЕсли;
					НовВакансия.РаботодательИмя = РаботодательВакансии["name"];
				КонецЕсли;
				
				АдресВакансии = Вакансия["address"];
				Если АдресВакансии <> Неопределено Тогда
					НовВакансия.Адрес = АдресВакансии["raw"];
				КонецЕсли;
			
				НовВакансия.ID = Вакансия["id"];
				НовВакансия.ВАрхиве = Вакансия["archived"];
				
			КонецЦикла;
			
			ВсегоСтраниц = ОбъектИзJSON["pages"];
			Если ТекущаяСтраница >= ВсегоСтраниц Тогда
				ТекущаяСтраница = -1;
			Иначе
				ТекущаяСтраница = ТекущаяСтраница + 1;
			КонецЕсли;
		Исключение
			ТекущаяСтраница = -1;
		КонецПопытки;
	КонецЦикла;
	
КонецПроцедуры

Процедура ЗагрузитьТаблицуРегионов() Экспорт
	
	Регионы.Очистить();
	ПустойРегион = Регионы.Добавить();
	ПустойРегион.ID = 0;
	ПустойРегион.Имя = "Не заполнен";
	ПустойРегион.РодительID = -1;
	
	Попытка
		UrlЗапроса = "/areas";
		
		ОтветСтрокаJSON = ВыполнитьЗапросAPI(UrlЗапроса); 
		
		ЧтениеJSON = Новый ЧтениеJSON;
		ЧтениеJSON.УстановитьСтроку(ОтветСтрокаJSON);
		ОбъектИзJSON = ПрочитатьJSON(ЧтениеJSON, Истина);
		
		Уровень = 1;
		Для Каждого Регион Из ОбъектИзJSON Цикл
			ЗагрузитьСтрокуРегионы(Регион, Уровень);
		КонецЦикла;
	Исключение
		Регионы.Очистить(); // В случае ошибки иерархию регионов не будем использовать
	КонецПопытки;
	
КонецПроцедуры

Процедура ЗагрузитьТаблицуВалют() Экспорт
	
	Валюты.Очистить();
	
	Попытка
		UrlЗапроса = "/dictionaries";
		
		ОтветСтрокаJSON = ВыполнитьЗапросAPI(UrlЗапроса);
		
		ЧтениеJSON = Новый ЧтениеJSON;
		ЧтениеJSON.УстановитьСтроку(ОтветСтрокаJSON);
		ОбъектИзJSON = ПрочитатьJSON(ЧтениеJSON, Истина);
		
		СправочникВалют = ОбъектИзJSON["currency"];
		Для Каждого Эл Из СправочникВалют Цикл
			НовСтр = Валюты.Добавить();
			НовСтр.Имя = Эл["name"];
			НовСтр.Аббревиатура = Эл["abbr"];
			НовСтр.СимвольныйКод = Эл["code"];
		КонецЦикла;
		
	Исключение
		Валюты.Очистить();
	КонецПопытки;
	
КонецПроцедуры

Процедура ЗагрузитьСтрокуРегионы(СтрокаРегион, Знач Уровень)
	
	НовСтр = Регионы.Добавить();
	НовСтр.Имя = СтрокаРегион["name"];
	НовСтр.ID = ПреобразоватьКЧислу(СтрокаРегион["id"]);
	НовСтр.РодительID =  ПреобразоватьКЧислу(СтрокаРегион["parent_id"]);
	НовСтр.Уровень = Уровень;
	
	ДочерниеРегионы = СтрокаРегион["areas"];
	Если ТипЗнч(ДочерниеРегионы) = Тип("Массив") Тогда
		Для Каждого Регион Из ДочерниеРегионы Цикл
			ЗагрузитьСтрокуРегионы(Регион, Уровень + 1);
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

Функция ВыполнитьЗапросAPI(UrlЗапроса)
	
	ЗаголовкиЗапроса = Новый Соответствие;	
	ЗаголовкиЗапроса.Вставить("Content-Type", "application/json;charset=utf-8");
	ЗаголовкиЗапроса.Вставить("User-Agent", "DevelPlatform/1.0 (ypermitin@yandex.ru)");
	ЗаголовкиЗапроса.Вставить("Authorization", "Bearer " + ТокенДоступа);
	ЗапросДанныхПользователя = Новый HTTPЗапрос(UrlЗапроса, ЗаголовкиЗапроса);	
	
	ЗащищенноеСоединение = Новый ЗащищенноеСоединениеOpenSSL();
	HTTPСоединение = Новый HTTPСоединение("api.hh.ru",,,,,, ЗащищенноеСоединение); 
	HTTPОтвет = HTTPСоединение.Получить(ЗапросДанныхПользователя);
	
	ОтветСтрокаJSON = HTTPОтвет.ПолучитьТелоКакСтроку();
	
	Возврат ОтветСтрокаJSON;
	
КонецФункции

#КонецОбласти

#Область КурсыВалют

Процедура ЗагрузитьПоследниеКурсыВалют() 
	
	ДатаКурса = ТекущаяДата(); 
	
	WSОписание = Новый WSОпределения("http://www.cbr.ru/dailyinfowebserv/dailyinfo.asmx?WSDL");
	СервисЕжедневнойИнформации	= Новый WSПрокси(WSОписание, "http://web.cbr.ru/", "DailyInfo", "DailyInfoSoap"); 
	ТипWSПараметра = СервисЕжедневнойИнформации.ФабрикаXDTO.Пакеты.Получить("http://web.cbr.ru/").Получить("GetCursOnDate"); 
	WSПараметр	= СервисЕжедневнойИнформации.ФабрикаXDTO.Создать(ТипWSПараметра); 
	WSПараметр.On_Date	= ДатаКурса ; 
	СписокКурсов = СервисЕжедневнойИнформации.GetCursOnDate(WSПараметр); 
	
	КурсыВалют.Очистить(); 
	Для Каждого Стр Из СписокКурсов.GetCursOnDateresult.diffgram.ValuteData.ValuteCursOnDate Цикл 
		Строка = КурсыВалют.Добавить() ; 
		Строка.Курс = Стр.Vcurs ; 
		Строка.Номинал = Стр.Vnom ; 
		Строка.СимвольныйКод = Стр.VchCode ; 
		Строка.Код = Прав ("000"+Стр.VCode, 3); 
		Строка.Имя = Стр.VName ; 
	КонецЦикла;
	
	Строка = КурсыВалют.Добавить() ; 
	Строка.Курс = 1 ; 
	Строка.Номинал = 1; 
	Строка.СимвольныйКод = "RUR"; 
	Строка.Код = "934"; 
	Строка.Имя = "Российский рубль"; 
	
КонецПроцедуры 

#КонецОбласти

#Область Служебные

Процедура ЗаполнитьРегионыВакансии(СтрокаВакансии) Экспорт
	
	ИдентификаторРодителя = СтрокаВакансии.МестоположениеID;
	
	Если НЕ ЗначениеЗаполнено(ИдентификаторРодителя) Тогда
		Возврат;
	КонецЕсли;	
	
	УровеньНайденногоРегиона = 10;
	Пока УровеньНайденногоРегиона <> 0 Цикл
		НайденныйРегион = Регионы.НайтиСтроки(Новый Структура("ID", ИдентификаторРодителя));
		Если НайденныйРегион.Количество() > 0 
			И ЗначениеЗаполнено(ИдентификаторРодителя) Тогда
			НайденныйРегионСтрока = НайденныйРегион.Получить(0);
			ИдентификаторРодителя = НайденныйРегионСтрока.РодительID;
			УровеньНайденногоРегиона = НайденныйРегионСтрока.Уровень;
			
			Если УровеньНайденногоРегиона <= 3 Тогда
				СтрокаВакансии["Регион_"+Формат(УровеньНайденногоРегиона,"ЧГ=0")] = НайденныйРегионСтрока.ID;
				СтрокаВакансии["РегионИмя_"+Формат(УровеньНайденногоРегиона,"ЧГ=0")] = НайденныйРегионСтрока.Имя;
				ИдентификаторРодителя = НайденныйРегионСтрока.РодительID;
			КонецЕсли;
						
		КонецЕсли;
		УровеньНайденногоРегиона = УровеньНайденногоРегиона - 1;
	КонецЦикла; 
	
	НезаполненныйРегион = Регионы.НайтиСтроки(Новый Структура("ID", 0));
	Если НайденныйРегион.Количество() > 0 Тогда
		НайденныйРегионСтрока = НайденныйРегион.Получить(0);
		Если Не ЗначениеЗаполнено(СтрокаВакансии.Регион_1) Тогда
			СтрокаВакансии.Регион_1 = НайденныйРегионСтрока.ID;	
			СтрокаВакансии.Регион_1 = НайденныйРегионСтрока.Имя;
		КонецЕсли;
		Если Не ЗначениеЗаполнено(СтрокаВакансии.Регион_2) Тогда
			СтрокаВакансии.Регион_2 = НайденныйРегионСтрока.ID;	
			СтрокаВакансии.Регион_2 = НайденныйРегионСтрока.Имя;
		КонецЕсли;
		Если Не ЗначениеЗаполнено(СтрокаВакансии.Регион_3) Тогда
			СтрокаВакансии.Регион_3 = НайденныйРегионСтрока.ID;	
			СтрокаВакансии.Регион_3 = НайденныйРегионСтрока.Имя;
		КонецЕсли;
	КонецЕсли;
		
	
КонецПроцедуры

Функция ЗаменитьТегиПодсветки(ИсходнаяСтрока, СимволЗамены = """") 
	
	Если ТипЗнч(ИсходнаяСтрока) <> Тип("Строка") Тогда
		Возврат ИсходнаяСтрока;
	КонецЕсли;
	
	Возврат СтрЗаменить(СтрЗаменить(СтрЗаменить(ИсходнаяСтрока, "<highlighttext>", """"), "</highlighttext>", """"), "&quot;", "");
	
КонецФункции

Функция ПреобразоватьКДате(СтроковаяДата)
	
	Попытка
		МассивРазделенныхСтрок = СтрЗаменить(СтроковаяДата, "+", Символы.ПС);
		СтрокаСДатой = СтрПолучитьСтроку(МассивРазделенныхСтрок, 1);
		СтрокаСДатойБезСпецсимволов = СтрЗаменить(СтрЗаменить(СтрЗаменить(СтрокаСДатой, "-", ""), ":", ""), "T", "");		
		ПреобразованнаяДата = Дата(СтрокаСДатойБезСпецсимволов);
		
		// Обрабатываем смещение
		Попытка
			СтрокаСоСмещением = СокрЛП(СтрПолучитьСтроку(МассивРазделенныхСтрок, 2));
			Если ЗначениеЗаполнено(СтрокаСоСмещением) Тогда
				СтрокаСоСмещениемБезСпецсимволов = "00010101"+СтрокаСоСмещением+"00";
				СмещениеДата = Дата(СтрокаСоСмещениемБезСпецсимволов);
				
				ПреобразованнаяДата = ПреобразованнаяДата + Секунда(СмещениеДата) + Минута(СмещениеДата)*60 + Час(СмещениеДата)*60*60;
			КонецЕсли;
		Исключение 
			Сообщить("Не удалось преобразовать смещение " + СтроковаяДата);	
		КонецПопытки;
	
		Возврат ПреобразованнаяДата;
	Исключение
		Сообщить("Не удалось преобразовать дату " + СтроковаяДата);
		Возврат Дата(1,1,1);	
	КонецПопытки;
	
КонецФункции

Функция ПреобразоватьКЧислу(ЗначениеСтрокой)
	
	Попытка
		Возврат Число(ЗначениеСтрокой);
	Исключение
		Возврат 0;
	КонецПопытки;
	
КонецФункции

#КонецОбласти

Инициализация();