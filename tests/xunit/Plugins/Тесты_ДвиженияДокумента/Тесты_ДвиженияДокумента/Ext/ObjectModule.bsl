﻿Перем КонтекстЯдра;
Перем Ожидаем;
Перем Утверждения;
Перем ГенераторТестовыхДанных;
Перем ЗапросыИзБД;
Перем УтвержденияПроверкаТаблиц;

Перем ДвиженияДокумента;
Перем СтруктураДанных;
Перем Документ;

#Область ЮнитТестирование

Процедура Инициализация(КонтекстЯдраПараметр) Экспорт
	
	КонтекстЯдра				= КонтекстЯдраПараметр;
	ГенераторТестовыхДанных		= КонтекстЯдра.Плагин("СериализаторMXL");
	ДвиженияДокумента 			= КонтекстЯдра.Плагин("ДвиженияДокумента");

КонецПроцедуры

Процедура ЗаполнитьНаборТестов(НаборТестов) Экспорт
	
	НаборТестов.НачатьГруппу("(ВРЕМЕННО ОТКЛЮЧЕНЫ) Проверить движения документов", Истина);
	НаборТестов.Добавить("ОТКЛЮЧЕНО_ТестДолжен_ПроверитьДвиженияДокументаБезНастройкиПроверок", , 
		"Без настройки сравнения");
	НаборТестов.Добавить("ОТКЛЮЧЕНО_ТестДолжен_ПроверитьДвиженияДокументаСНастройкойПроверок", , 
		"С настройкой сравнения");
	НаборТестов.Добавить(
		"ОТКЛЮЧЕНО_ТестДолжен_ПроверитьДвиженияДокументаСНастройкойПроверокСИсключениеРегистраИзПроверок", , 
			"С настройкой сравнения - исключение регистра");
	НаборТестов.Добавить(
			"ОТКЛЮЧЕНО_ТестДолжен_ПроверитьДвиженияДокументаСНастройкойПроверокСИсключениеРегистраИзПроверокВторойСпособ", , 
			"С настройкой сравнения - исключение регистра (способ 2)");
	НаборТестов.Добавить("ОТКЛЮЧЕНО_ТестДолжен_ПроверитьДвиженияДокументаСНастройкойПроверокИсключениеПолейИзПровероки", , 
		"С настройкой сравнения - исключение полей");
	НаборТестов.Добавить("ОТКЛЮЧЕНО_ТестДолжен_ПроверитьДвиженияДокументаСНастройкойПроверокДобавлениеВычисляемогоПоля", , 
		"С настройкой сравнения - добавление вычисляемого поля");
	НаборТестов.Добавить(
		"ОТКЛЮЧЕНО_ТестДолжен_ПроверитьДвиженияДокументаСНастройкойПроверокДобавлениеВычисляемогоПоляНастройкаСверткиРегистров", ,
		"С настройкой сравнения - добавление вычисляемого поля и свертка регистров");
	НаборТестов.Добавить("ОТКЛЮЧЕНО_ТестДолжен_ПроверитьДвиженияДокументаВызватьИсключениеПриОтсутствииДвижений", ,
		"Проверить выдачу исключений при отсутствии движений");
	
КонецПроцедуры

Процедура ПередЗапускомТеста() Экспорт
	
	СоздатьВспомогательныеДанные();
КонецПроцедуры

Процедура ПослеЗапускаТеста() Экспорт
	
	УдалитьДокументы();
	ГенераторТестовыхДанных.УдалитьСозданныеДанные(СтруктураДанных);
	
КонецПроцедуры

#КонецОбласти

Процедура УдалитьДокументы() Экспорт
	Если ЗначениеЗаполнено(Документ) И Документ.Проведен Тогда
		ДокументОбъект = Документ.ПолучитьОбъект();
		ДокументОбъект.Записать(РежимЗаписиДокумента.ОтменаПроведения);
	КонецЕсли;
КонецПроцедуры

Процедура СоздатьВспомогательныеДанные() Экспорт
	
	СтруктураДанных = ГенераторТестовыхДанных.СоздатьДанныеПоМакетам(ЭтотОбъект, "МакетВспомогательныеДанные");

КонецПроцедуры	
	
Процедура ТестДолжен_ПроверитьДвиженияДокументаБезНастройкиПроверок() Экспорт
	
	СтруктураДанных = ГенераторТестовыхДанных.СоздатьДанныеПоМакетам(ЭтотОбъект, "МакетДокументСоВсемиДвижениями");
	
	Документ = СтруктураДанных.Документ2000000001От25_09_201814_11_07;
	
	ПроверитьДвижения(Документ);	

КонецПроцедуры

Процедура ТестДолжен_ПроверитьДвиженияДокументаСНастройкойПроверок() Экспорт
	
	СтруктураДанных = ГенераторТестовыхДанных.СоздатьДанныеПоМакетам(ЭтотОбъект, "МакетДокументСоВсемиДвижениями");
	
	Документ = СтруктураДанных.Документ2000000001От25_09_201814_11_07;
	
	НастройкаПлагина  = ДвиженияДокумента.НоваяНастройкаПроверкиДвиженийДокумента();
		
	ПроверитьДвижения(Документ, НастройкаПлагина);	

КонецПроцедуры

Процедура ТестДолжен_ПроверитьДвиженияДокументаСНастройкойПроверокСИсключениеРегистраИзПроверок() Экспорт
	
	СтруктураДанных = ГенераторТестовыхДанных.СоздатьДанныеПоМакетам(ЭтотОбъект, 
		"МакетДокументБезДвиженийРегистраБухгалтерии");
	
	Документ = СтруктураДанных.Документ2000000001От25_09_201814_11_07;
	
	НастройкаПлагина  = ДвиженияДокумента.НоваяНастройкаПроверкиДвиженийДокумента();
	
	ИсключаемыеРегистры = НастройкаПлагина.ИсключаемыеРегистры;

	// В макете для регистра бухгалтерии удалены некоторые строки движений для регистра бухгалтерии. 
	// Исключаем из проверок регистр бухгалтерии.
	ИсключаемыеРегистры.Добавить("РегистрБухгалтерии.РегистрБухгалтерии1");
	
	ПроверитьДвижения(Документ, НастройкаПлагина);	

КонецПроцедуры

Процедура ТестДолжен_ПроверитьДвиженияДокументаСНастройкойПроверокСИсключениеРегистраИзПроверокВторойСпособ() Экспорт
	
	СтруктураДанных = ГенераторТестовыхДанных.СоздатьДанныеПоМакетам(ЭтотОбъект, 
		"МакетДокументБезДвиженийРегистраБухгалтерии");
	
	Документ = СтруктураДанных.Документ2000000001От25_09_201814_11_07;
	
	НастройкаПлагина  = ДвиженияДокумента.НоваяНастройкаПроверкиДвиженийДокумента();
	
	ПроверяемыеРегистры = НастройкаПлагина.ПроверяемыеРегистры;

	// В макете для регистра бухгалтерии удалены некоторые строки движений для регистра бухгалтерии. 
	// Оставляем в проверках все регистры, кроме регистра бухгалтерии.
	ПроверяемыеРегистры.Добавить("РегистрСведений.РСПодчиненныйРегистратору");
	ПроверяемыеРегистры.Добавить("РегистрНакопления.РегистрНакопления2");
	
	ПроверитьДвижения(Документ, НастройкаПлагина);	

КонецПроцедуры

Процедура ТестДолжен_ПроверитьДвиженияДокументаСНастройкойПроверокИсключениеПолейИзПровероки() Экспорт
	
	СтруктураДанных = ГенераторТестовыхДанных.СоздатьДанныеПоМакетам(ЭтотОбъект, 
		"МакетДокументБезДвиженийРегистровНекорректныеРегистрСведений");
	
	Документ = СтруктураДанных.Документ2000000001От25_09_201814_11_07;
	
	НастройкаПлагина  = ДвиженияДокумента.НоваяНастройкаПроверкиДвиженийДокумента();
	
	ИсключаемыеРегистры = НастройкаПлагина.ИсключаемыеРегистры;
	НастройкиПроверкиРегистров = НастройкаПлагина.НастройкиПроверкиРегистров;

	// В макете для регистра бухгалтерии удалены некоторые движений для регистра бухгалтерии и регистра накопления. 
	//Удаляем из проверок эти регистры.
	ИсключаемыеРегистры.Добавить("РегистрБухгалтерии.РегистрБухгалтерии1");
	ИсключаемыеРегистры.Добавить("РегистрНакопления.РегистрНакопления2");
	
	// В макете для регистра сведений изменены зачения ресурса. Исключим это поле из проверок движений регистра.
	
	// Вариант 1. Исключаем конкретные поля.
	
	// Получаем настройки проверки регистра.	
	НастройкаПроверкиРегистра = ДвиженияДокумента.НоваяНастройкаПроверкиРегистра();
	ИсключаемыеПоля = НастройкаПроверкиРегистра.ИсключаемыеПоля;

	ИсключаемыеПоля.Добавить("РесурсЧисло");

	НастройкиПроверкиРегистров.Вставить("РегистрСведений.РСПодчиненныйРегистратору", НастройкаПроверкиРегистра);
	
	ПроверитьДвижения(Документ, НастройкаПлагина);	
	
	// Вариант 2. Оставляем только те поля, по которым необходимо выполнять проверку.
	
	// Получаем настройки проверки регистра.	
	НастройкаПроверкиРегистра = ДвиженияДокумента.НоваяНастройкаПроверкиРегистра();
	ПроверяемыеПоля = НастройкаПроверкиРегистра.ПроверяемыеПоля;

	ПроверяемыеПоля.Добавить("ПростойСправочник");
	ПроверяемыеПоля.Добавить("ПростойСправочник2");
	ПроверяемыеПоля.Добавить("РеквизитБулево");
	
	НастройкиПроверкиРегистров.Вставить("РегистрСведений.РСПодчиненныйРегистратору", НастройкаПроверкиРегистра);
	
	// Вариант 3. Убираем лишние поля через настройку свертки регистра.
	
	// Получаем настройки проверки регистра.	
	НастройкаПроверкиРегистра = ДвиженияДокумента.НоваяНастройкаПроверкиРегистра();

	НастройкаСвертки = НастройкаПроверкиРегистра.НастройкаСвертки;
	НастройкаСвертки.Свернуть = Истина;
	НастройкаСвертки.КолонкиГруппировок = "ПростойСправочник,ПростойСправочник2,РеквизитБулево";
	НастройкаСвертки.КолонкиСуммирования = "";
	
	НастройкиПроверкиРегистров.Вставить("РегистрСведений.РСПодчиненныйРегистратору", НастройкаПроверкиРегистра);
	
	ПроверитьДвижения(Документ, НастройкаПлагина);	

КонецПроцедуры

Процедура ТестДолжен_ПроверитьДвиженияДокументаСНастройкойПроверокДобавлениеВычисляемогоПоля() Экспорт
	
	СтруктураДанных = ГенераторТестовыхДанных.СоздатьДанныеПоМакетам(ЭтотОбъект, 
		"МакетДокументБезДвиженийРегистраБухгалтерииРегистрНакопления");
	
	Документ = СтруктураДанных.Документ2000000001От25_09_201814_11_07;
	
	НастройкаПлагина  = ДвиженияДокумента.НоваяНастройкаПроверкиДвиженийДокумента();
	
	ИсключаемыеРегистры = НастройкаПлагина.ИсключаемыеРегистры;
	НастройкиПроверкиРегистров = НастройкаПлагина.НастройкиПроверкиРегистров;

	// В макете для регистра бухгалтерии удалены некоторые движений для регистра бухгалтерии и регистра накопления. 
	// Удаляем из проверок эти регистры.
	ИсключаемыеРегистры.Добавить("РегистрБухгалтерии.РегистрБухгалтерии1");
	ИсключаемыеРегистры.Добавить("РегистрНакопления.РегистрНакопления2");
	
	// В макете для регистра сведений изменены зачения ресурса. Исключим это поле из проверок движений регистра.
	
	// Получаем настройки проверки регистра.	
	НастройкаПроверкиРегистра = ДвиженияДокумента.НоваяНастройкаПроверкиРегистра();
	ВычисляемыеПоля = НастройкаПроверкиРегистра.ВычисляемыеПоля;
	ИсключаемыеПоля = НастройкаПроверкиРегистра.ИсключаемыеПоля;
	ПроверяемыеПоля = НастройкаПроверкиРегистра.ПроверяемыеПоля;

	// Исключим из проверки неокторые поля, которые могут учавствовать в проверке движений документа.
	ИсключаемыеПоля.Добавить("РесурсЧисло");
	
	// Получаем настройку вычисляемого поля.
	НовоеВычисляемыеПоля = ДвиженияДокумента.НовоеВычисляемоеПоле();
	НовоеВычисляемыеПоля.Имя 		= "КоличествоВсего";
	НовоеВычисляемыеПоля.Тип 		= Новый ОписаниеТипов("Число");
	НовоеВычисляемыеПоля.Формула 	= "ЗаписьРегистра.РесурсЧисло / 100 + 26";	
	ВычисляемыеПоля.Добавить(НовоеВычисляемыеПоля);	
	
	НастройкиПроверкиРегистров.Вставить("РегистрСведений.РСПодчиненныйРегистратору", НастройкаПроверкиРегистра);
	
	ПроверитьДвижения(Документ, НастройкаПлагина);	

КонецПроцедуры

Процедура ТестДолжен_ПроверитьДвиженияДокументаСНастройкойПроверокДобавлениеВычисляемогоПоляНастройкаСверткиРегистров() 
		Экспорт
	
	СтруктураДанных = ГенераторТестовыхДанных.СоздатьДанныеПоМакетам(ЭтотОбъект, 
		"МакетДокументБезДвиженийРегистраБухгалтерииРегистрНакопления");
	
	Документ = СтруктураДанных.Документ2000000001От25_09_201814_11_07;
	
	НастройкаПлагина  = ДвиженияДокумента.НоваяНастройкаПроверкиДвиженийДокумента();
	
	// НастройкаПлагина  = ДвиженияДокумента.НоваяНастройкаПроверкиДвиженийДокумента();
	ИсключаемыеРегистры = НастройкаПлагина.ИсключаемыеРегистры;
	НастройкиПроверкиРегистров = НастройкаПлагина.НастройкиПроверкиРегистров;

	// В макете для регистра бухгалтерии удалены некоторые движений для регистра бухгалтерии и регистра накопления. 
	// Удаляем из проверок эти регистры.
	ИсключаемыеРегистры.Добавить("РегистрБухгалтерии.РегистрБухгалтерии1");
	ИсключаемыеРегистры.Добавить("РегистрНакопления.РегистрНакопления2");
	
	// В макете для регистра сведений изменены зачения ресурса. Исключим это поле из проверок движений регистра.
	
	// Получаем настройки проверки регистра.	
	НастройкаПроверкиРегистра = ДвиженияДокумента.НоваяНастройкаПроверкиРегистра();
	ВычисляемыеПоля = НастройкаПроверкиРегистра.ВычисляемыеПоля;
	ИсключаемыеПоля = НастройкаПроверкиРегистра.ИсключаемыеПоля;
	ПроверяемыеПоля = НастройкаПроверкиРегистра.ПроверяемыеПоля;

	// Исключим из проверки неокторые поля, которые могут учавствовать в проверке движений документа.
	ИсключаемыеПоля.Добавить("РесурсЧисло");
	
	// Получаем настройку вычисляемого поля.
	НовоеВычисляемыеПоля = ДвиженияДокумента.НовоеВычисляемоеПоле();
	НовоеВычисляемыеПоля.Имя 		= "КоличествоВсего";
	НовоеВычисляемыеПоля.Тип 		= Новый ОписаниеТипов("Число");
	НовоеВычисляемыеПоля.Формула 	= "ЗаписьРегистра.РесурсЧисло / 100 + 26";	
	ВычисляемыеПоля.Добавить(НовоеВычисляемыеПоля);	
	
	НастройкаСвертки = НастройкаПроверкиРегистра.НастройкаСвертки;
	НастройкаСвертки.Свернуть = Истина;
	НастройкаСвертки.КолонкиГруппировок = "РеквизитБулево";
	НастройкаСвертки.КолонкиСуммирования = "КоличествоВсего";
	
	НастройкиПроверкиРегистров.Вставить("РегистрСведений.РСПодчиненныйРегистратору", НастройкаПроверкиРегистра);
	
	ПроверитьДвижения(Документ, НастройкаПлагина);	

КонецПроцедуры

Процедура ТестДолжен_ПроверитьДвиженияДокументаВызватьИсключениеПриОтсутствииДвижений() Экспорт
	
	СтруктураДанных = ГенераторТестовыхДанных.СоздатьДанныеПоМакетам(ЭтотОбъект, 
		"МакетДокументБезДвиженийРегистраБухгалтерииРегистрНакопления");
	
	Документ = СтруктураДанных.Документ2000000001От25_09_201814_11_07;
	Попытка
		ПроверитьДвижения(Документ);
	Исключение
		Возврат;
	КонецПопытки;
	
	ВызватьИсключение "Должны были получить исключение, а его не было";	

КонецПроцедуры

Процедура ПроверитьДвижения(Знач Документ, Знач НастройкаПлагина = Неопределено)	

	ДвиженияДокумента.ПроверитьДвиженияДокумента(Документ, НастройкаПлагина);	
	
КонецПроцедуры
