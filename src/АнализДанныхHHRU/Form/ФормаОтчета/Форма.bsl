﻿
#Область СобытияФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ОбъектОтчета = РеквизитФормыВЗначение("Отчет");
	ПутьМетаданныхОтчета = ОбъектОтчета.Метаданные().ПолноеИмя();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ПроверитьАвторизациюНаКлиенте(Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора)
	
	Если ИсточникВыбора.ИмяФормы = ПутьМетаданныхОтчета + ".Форма.ЗапросКодаАвторизации" Тогда
		Отчет.ТокенДоступа = ПолучитьТокенДоступа(ВыбранноеЗначение.КодАвторизации);
		ПроверитьАвторизациюНаКлиенте();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СобытияЭлементовФормы

&НаКлиенте
Процедура ПройтиАвторизацию(Команда)
	
	ОткрытьФорму(
		ПутьМетаданныхОтчета+".Форма.ЗапросКодаАвторизации",,
		ЭтаФорма, 
		УникальныйИдентификатор,,,,
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
		
КонецПроцедуры

&НаКлиенте
Процедура ДекорацияНеобходимаАвторизация1Нажатие(Элемент)
	
	ПройтиАвторизацию(Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура ДекорацияНеобходимаАвторизация2Нажатие(Элемент)
	
	УказатьТокенДоступаВручную(Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура ДекорацияНеобходимаАвторизация3Нажатие(Элемент)
	
	НачатьЗапускПриложения(
		Новый ОписаниеОповещения("ЗапускПриложенияЗавершение", ЭтаФорма), 
		"https://dev.hh.ru/admin");
	
КонецПроцедуры

&НаКлиенте
Процедура УказатьТокенДоступаВручную(Команда)
	
	ПоказатьВводСтроки(
		Новый ОписаниеОповещения("УказатьТокенДоступаВручнуюЗавершение", ЭтаФорма),
		Отчет.ТокенДоступа,
		"Токен доступа к ресурсам HeadHunter",
		150,
		Истина);
	
КонецПроцедуры
	
&НаКлиенте
Процедура УказатьТокенДоступаВручнуюЗавершение(Результат, ДопПараметры) Экспорт
	
	Отчет.ТокенДоступа = Результат;
	ПроверитьАвторизациюНаКлиенте();
	
КонецПроцедуры

&НаКлиенте
Процедура СформироватьОтчет(Команда)
	
	Состояние("Проверка авторизации...");
	АвторизацияПройдена = ПроверитьАвторизацию();
	Если АвторизацияПройдена Тогда
		Состояние("Получение и обработка данных...");
		СкомпоноватьРезультат(РежимКомпоновкиРезультата.Непосредственно);
	Иначе
		ПоказатьПредупреждение(,"Пожалуйтса, пройдите авторизацию!");
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура Выйти(Команда)
	
	Отчет.ТокенДоступа = Неопределено;
	ПроверитьАвторизацию();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбратнаяСвязь(Команда)
	
	НачатьЗапускПриложения(
		Новый ОписаниеОповещения("ЗапускПриложенияЗавершение", ЭтаФорма), 
		"http://develplatform.ru/About-us/Contact-us?messageSubject=1С:Анализ%20данных%20HH.ru%20(отчет)");
	
КонецПроцедуры

&НаКлиенте
Процедура ЗапускПриложенияЗавершение(КодВозврата, ДополнительныеПараметры) Экспорт
	
	// Действия не требуются

КонецПроцедуры

&НаКлиенте
Процедура ПосмотретьАнализНаКарте(Команда)
	        	
	ТекстПоиска = ПолучитьТекстПоискаВакансий(); 
	Если НЕ ЗначениеЗаполнено(ТекстПоиска) Тогда
		ПоказатьПредупреждение(, "Для перехода к приложению необходимо заполнить строку поиска!");
		Возврат;
	КонецЕсли;
	
	РезультатПроверкиАвторизации = ПроверитьАвторизацию();
	Если РезультатПроверкиАвторизации Тогда
		НачатьЗапускПриложения(
			Новый ОписаниеОповещения("ЗапускПриложенияЗавершение", ЭтаФорма), 
			"http://alm.develplatform.ru?forceToken="+Отчет.ТокенДоступа+"&forceQuery="+ТекстПоиска);
	Иначе
		НачатьЗапускПриложения(
			Новый ОписаниеОповещения("ЗапускПриложенияЗавершение", ЭтаФорма), 
			"http://alm.develplatform.ru");
			
		ПоказатьПредупреждение(,"Пожалуйтса, пройдите авторизацию!");
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура РезультатОбработкаРасшифровки(Элемент, Расшифровка, СтандартнаяОбработка)
	
	СтруктураРасшифровки = РезультатОбработкаРасшифровкиНаСервере(Расшифровка);
	Если СтруктураРасшифровки.Поле = "Вакансии.ID" Тогда
		НачатьЗапускПриложения(
			Новый ОписаниеОповещения("ЗапускПриложенияЗавершение", ЭтаФорма),
			"https://hh.ru/vacancy/"+СтруктураРасшифровки.Значение);
		СтандартнаяОбработка = Ложь;
	ИначеЕсли СтруктураРасшифровки.Поле = "Вакансии.Работодатель.РаботодательID" Тогда
		НачатьЗапускПриложения(
			Новый ОписаниеОповещения("ЗапускПриложенияЗавершение", ЭтаФорма),
			"https://hh.ru/employer/"+СтруктураРасшифровки.Значение);
		СтандартнаяОбработка = Ложь;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция РезультатОбработкаРасшифровкиНаСервере(Расшифровка)
	
	СтруктураРасшифровки = Новый Структура;
	СтруктураРасшифровки.Вставить("Поле", Неопределено);
	СтруктураРасшифровки.Вставить("Значение", Неопределено);

	ВсеДанныеРасшифровки = ПолучитьИзВременногоХранилища(ДанныеРасшифровки);
	ЗначенияПолейРасшифровки = ВсеДанныеРасшифровки.Элементы[Расшифровка].ПолучитьПоля();
	Если ЗначенияПолейРасшифровки.Количество() > 0 Тогда
		СтруктураРасшифровки.Поле = ЗначенияПолейРасшифровки[0].Поле;
		СтруктураРасшифровки.Значение = ЗначенияПолейРасшифровки[0].Значение;
	КонецЕсли;
	
	Возврат СтруктураРасшифровки;
	
КонецФункции

#КонецОбласти

#Область Служебные

&НаКлиенте
Функция ПолучитьТокенДоступа(КодАвторизации)

	ТокенДоступа = Неопределено;
	
	Попытка
		ЗаголовкиЗапроса = Новый Соответствие;	
		ЗаголовкиЗапроса.Вставить("Content-Type", "application/json;charset=utf-8");
		ЗапросТокена = Новый HTTPЗапрос("/HeadHunter/GetAuthToken?code="+КодАвторизации, ЗаголовкиЗапроса);	
		
		HTTPСоединение = Новый HTTPСоединение("alm.develplatform.ru"); 
	 	HTTPОтвет = HTTPСоединение.Получить(ЗапросТокена);
		
		ОтветСтрокаJSON = HTTPОтвет.ПолучитьТелоКакСтроку();
		
		ЧтениеJSON = Новый ЧтениеJSON;
		ЧтениеJSON.УстановитьСтроку(ОтветСтрокаJSON);
		Пока ЧтениеJSON.Прочитать() Цикл
			Если ЧтениеJSON.ТипТекущегоЗначения = ПредопределенноеЗначение("ТипЗначенияJSON.ИмяСвойства")
				И ЧтениеJSON.ТекущееЗначение = "access_token" Тогда
				Если ЧтениеJSON.Прочитать() Тогда
					ТокенДоступа = ЧтениеJSON.ТекущееЗначение;				
				КонецЕсли;
				Прервать;
			КонецЕсли;
		КонецЦикла;
	Исключение
		ПодробноеОписаниеОшибки = ИнформацияОбОшибке();
		Сообщить("Не удалось выполнить авторизацию: " + ПодробноеОписаниеОшибки.Причина.Описание);
		ТокенДоступа = Неопределено;	
	КонецПопытки;
	
	Возврат ТокенДоступа;
	 	
КонецФункции

&НаКлиенте
Функция ПроверитьАвторизациюНаКлиенте(ПовторныйВход = Ложь)
	
	Если ЗначениеЗаполнено(Отчет.ТокенДоступа) Тогда
		ПроверитьАвторизацию();
		
		Если ЗначениеЗаполнено(Отчет.АвторизированныйПользовательID) Тогда
			Если ПовторныйВход = Истина Тогда
				ПоказатьПредупреждение(, 
					"С возвращением, " + Отчет.АвторизированныйПользователь + "!
					|Приятной работы!", 10, "Приветствую!");
			Иначе
				ПоказатьПредупреждение(, 
					"Здравствуйте, "+Отчет.АвторизированныйПользователь+"!
					|Приятной работы!");
			КонецЕсли;
		Иначе
			ПоказатьПредупреждение(,
				"Вход не выполнен, проверьте настройки авторизации!
				|Возможно токен доступа устарел и необходимо
				|повторно выполнить вход на HH.ru.");
		КонецЕсли;
	КонецЕсли;
	
КонецФункции

&НаСервере
Функция ПроверитьАвторизацию()
	
	АвторизацияПройдена = Ложь;
	
	Если ЗначениеЗаполнено(Отчет.ТокенДоступа) Тогда	
		Попытка
			ЗаголовкиЗапроса = Новый Соответствие;	
			ЗаголовкиЗапроса.Вставить("Content-Type", "application/json;charset=utf-8");
			ЗаголовкиЗапроса.Вставить("User-Agent", "DevelPlatform/1.0 (ypermitin@yandex.ru)");
			ЗаголовкиЗапроса.Вставить("Authorization", "Bearer " + Отчет.ТокенДоступа);
			ЗапросДанныхПользователя = Новый HTTPЗапрос("/me", ЗаголовкиЗапроса);	
			
			ЗащищенноеСоединение = Новый ЗащищенноеСоединениеOpenSSL();
			HTTPСоединение = Новый HTTPСоединение("api.hh.ru",,,,,, ЗащищенноеСоединение); 
		 	HTTPОтвет = HTTPСоединение.Получить(ЗапросДанныхПользователя);
			
			ОтветСтрокаJSON = HTTPОтвет.ПолучитьТелоКакСтроку();
			
			ИмяПользователя = Неопределено;
			ОтчествоПользователя = Неопределено;
			IDПользователя = Неопределено;
			
			ЧтениеJSON = Новый ЧтениеJSON;
			ЧтениеJSON.УстановитьСтроку(ОтветСтрокаJSON);
			Пока ЧтениеJSON.Прочитать() Цикл
				Если ЧтениеJSON.ТипТекущегоЗначения = ПредопределенноеЗначение("ТипЗначенияJSON.ИмяСвойства")
					И ЧтениеJSON.ТекущееЗначение = "first_name" Тогда
					Если ЧтениеJSON.Прочитать() Тогда
						ИмяПользователя = ЧтениеJSON.ТекущееЗначение;				
					КонецЕсли;				
				КонецЕсли;
				
				Если ЧтениеJSON.ТипТекущегоЗначения =ПредопределенноеЗначение("ТипЗначенияJSON.ИмяСвойства")
					И ЧтениеJSON.ТекущееЗначение = "middle_name" Тогда
					Если ЧтениеJSON.Прочитать() Тогда
						ОтчествоПользователя = ЧтениеJSON.ТекущееЗначение;				
					КонецЕсли;				
				КонецЕсли;
				
				Если ЧтениеJSON.ТипТекущегоЗначения = ПредопределенноеЗначение("ТипЗначенияJSON.ИмяСвойства")
					И ЧтениеJSON.ТекущееЗначение = "id" Тогда
					Если ЧтениеJSON.Прочитать() Тогда
						IDПользователя = ЧтениеJSON.ТекущееЗначение;				
					КонецЕсли;				
				КонецЕсли;
			КонецЦикла;
			
			Если ЗначениеЗаполнено(ИмяПользователя)
				И ЗначениеЗаполнено(ОтчествоПользователя)
				И ЗначениеЗаполнено(IDПользователя) Тогда
				Отчет.АвторизированныйПользователь = ИмяПользователя + " " + ОтчествоПользователя;
				Отчет.АвторизированныйПользовательID = IDПользователя;
				АвторизацияПройдена = Истина;
			КонецЕсли;
		Исключение
			АвторизацияПройдена = Ложь;	
		КонецПопытки;
	КонецЕсли;
	
	Если АвторизацияПройдена Тогда
		Элементы.ОсновнаяПанель.ТекущаяСтраница = Элементы.АвторизацияПройдена;
	Иначе
		Элементы.ОсновнаяПанель.ТекущаяСтраница = Элементы.НеобходимаАвторизация;
		Отчет.АвторизированныйПользователь = Неопределено;
		Отчет.АвторизированныйПользовательID = Неопределено;
	КонецЕсли;
		
	Возврат АвторизацияПройдена;
	
КонецФункции

&НаСервере
Функция ПолучитьТекстПоискаВакансий()
	
	НастройкиСУчетомПользовательскихНастроек = Отчет.КомпоновщикНастроек.ПолучитьНастройки();
	
	Возврат СокрЛП(НастройкиСУчетомПользовательскихНастроек.ПараметрыДанных.Элементы.Найти("ПоискВакансий").Значение);
	
КонецФункции

#КонецОбласти
