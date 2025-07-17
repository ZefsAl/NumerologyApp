#  dSYMs for a dylib!
- ENABLE_DEBUG_DYLIB - NO (изменил на время загрузки, заменить потом на YES)
- заменен - Crashlytics - script - ориганал - "${BUILD_DIR%/Build/*}/SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/run"
- проблема так и не исправлена (сослались что apple должен поправить)

https://github.com/firebase/firebase-ios-sdk/issues/13764#issuecomment-2773813470   // <- 
https://github.com/firebase/firebase-ios-sdk/issues/13551
https://github.com/firebase/firebase-ios-sdk/issues/13543
https://github.com/firebase/firebase-ios-sdk/issues/13764
https://github.com/firebase/firebase-ios-sdk/issues/14680 



# ⚠️ Убрал Crashlytics - все равно не работает из-за Facebook
# ⚠️ Отключен Facebook SDK - мешали логи - TODO Включить!





# TODO - Chat 
1. Инициализация не onAppear, ChatPaywall и Auth c Запросом баланса. т.к UI конфигурируется прим в процессе onAppear 
2. Смена DeepSeek AI
3. Вернуть Facebook Analytics
4. Реактивное обновление баланса!
5. ⚠️ Не Обработаны кейсы ошибок в ответе ИИ + Если придет пустой ответ

- Clear HIstory - crash ☑️   
- не появляется клавиатура?  
