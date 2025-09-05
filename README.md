# Gift Marketplace — тестовое задание

Экран входа с **Firebase Auth** (Apple/Google) → отправка **idToken** на сервер → получение **accessToken** → главный экран (SwiftUI, MVVM, тёмная/светлая темы).


https://github.com/user-attachments/assets/f8b5c2de-c5fb-427e-ad6c-3ec1cd106fff


## Как запустить
**Требования**: iOS 17+
1. Клонировать и открыть проект в Xcode:
- зависимости через Package Dependencies (FirebaseAuth, GoogleSignIn-IOS) подключены;
- capability Sign in with Apple включён.
2. В Firebase Console создать проект и iOS-приложение с Bundle ID проекта.
3. Скачать GoogleService-Info.plist и добавить в таргет проекта.
4. Добавить REVERSED_CLIENT_ID из GoogleService-Info.plist в Info → URL Types → URL Schemes.
5. Запустить. На экране входа доступна авторизация через Apple, Google или пропустить авторизацию через кнопку Skip (Skip действует только на текущую сессию, в сторедж не сохраняется).

## Firebase-конфиг (общий setup)
* Добавить зависимости FirebaseAuth (из firebase-ios-sdk) и GoogleSignIn
* В Firebase Console создать проект и iOS-приложение с Bundle ID проекта.
* Скаченный GoogleService-Info.plist положить в проект (включить в Target).
* В Authentication → Sign-in method включить Apple и Google.
* Включить Capability → Sign In with Apple у таргета.
* Добавить REVERSED_CLIENT_ID из GoogleService-Info.plist в Info → URL Types → URL Schemes.
* В приложении проинициализировать Firebase и GoogleSignIn, а также обрабатывать возврат из Google через .onOpenURL.
* Обработка входа с Apple: генерация nonce + SHA-256, запрос через ASAuthorizationController.
* Обработка входа с Google: получение токенов Google, поддержка signOut() для Google/Firebase.
* Получение Firebase ID Token: после успешного входа запрашивается актуальный Firebase ID Token и отправляется на бэкенд для обмена на серверный accessToken.

Для DEBUG добавлен моковый сервер, на который направляется запрос со скрытым ID Token, в ответ приходит ответ, как с основного сервера. 

## Архитектура
**Технологии**: SwiftUI + MVVM + FirebaseAuth + GoogleSignIn + легкий JSON-RPC клиент.
**Слои и основные файлы**
* **UI**
    * Стартовый экран EntryView решает, что показать: SignInScreen или MainScreen. Критерий: accessToken в @AppStorage. Можно пропустить авторизацию для текущий сессии через кнопку Skip.
    * SignInScreen — кнопки Apple/Google/Skip, лоадер, алерты.
    * MainScreen (TabView), GiftScreen — верстка главного экрана.
* **ViewModel**
    * SignInViewModel:
        1. вход в Firebase (Apple/Google)
        2. Получение токена Firebase
        3. POST запрос на сервер
        4. полученный accessToken пробрасывается через onSignedIn в EntryView
* **Design System**
    * DS — строки/иконки/палитра/конфиг таббара; утилиты (Color(hex:), Image(icon:) и т.п.).

**Обработка ошибок**
* Обработка ошибок авторизации, сетевых ошибок, пользователю показывается алерт с user friendly информацией об ошибке.

**Поток авторизации**
1. Нажатие Apple/Google → Firebase Auth.
2. Получаю idToken.
3. Отправляю idToken на сервер
4. Получаю access_token
5. Сохраняю access_token в UserDefaults
6. Переход на главный экран 
7. Показ алерта в случае ошибки.

## Улучшения для продакшена
- Вынести логику авторизации из SignInViewModel в сервисы по протоколам: AuthService, AppleAuthProvider, GoogleAuthProvider, TokenExchangeService для тестирования и переиспользования.
- Доработать сетевой слой: бекофф, логирование. 
- Хранить accessToken с сервера в KeyChain.
- Доработка функционала главного экрана.  
- Добавить сетевой слой и вьюмодель для главного экрана. 
- Добавить тесты. 
- Добавить локализацию. 
