# تطبيق إسلامي (Islami App)

تطبيق إسلامي متكامل مبني باستخدام إطار عمل Flutter. يهدف التطبيق إلى توفير مجموعة من الخدمات والميزات الأساسية التي يحتاجها كل مسلم في حياته اليومية، مع تصميم عصري وتجربة مستخدم سلسة.

## 💡 فكرة التطبيق والميزات الأساسية
يعتبر تطبيق "إسلامي" رفيقك اليومي، حيث يقدم العديد من الميزات التي تساعدك على أداء العبادات بكل سهولة ويسر. من أبرز ميزات التطبيق:
- **إشعارات الصلاة المجدولة بشكل دقيق:** يقوم التطبيق بحساب أوقات الصلاة بناءً على موقعك الجغرافي، ويرسل إشعارات وتنبيهات مجدولة (أذان) لكل صلاة في وقتها المحدد حتى وإن كان التطبيق يعمل في الخلفية أو مغلقاً، وذلك لضمان عدم تفويت أي صلاة.
- **القرآن الكريم والأحاديث النبوية:** واجهة مريحة لقراءة وتصفح سور القرآن الكريم والأحاديث النبوية الشريفة.
- **تحديد اتجاه القبلة:** بوصلة دقيقة وسريعة الاستجابة لمعرفة اتجاه القبلة أينما كنت.
- **تحديد الموقع التلقائي:** الاعتماد على الـ GPS لجلب الموقع الحالي للمستخدم لتحديث أوقات الصلاة بشكل تلقائي ودقيق.
- **دعم اللغات (Localization):** التطبيق يدعم تعدد اللغات بشكل كامل لتناسب شريحة واسعة من المستخدمين.
- **الوضع الليلي والنهاري:** تصميم مرن يتكيف مع تفضيلات المستخدم.

## 🛠️ التقنيات والمكتبات المستخدمة
تم بناء هذا المشروع بالاعتماد على أحدث المكتبات وأفضل الممارسات البرمجية المتاحة في `pubspec.yaml`:

- **إدارة الحالة (State Management):** `provider`
- **الشبكات وجلب البيانات (Networking):** `dio`
- **التخزين المحلي:** `shared_preferences`, `path_provider`
- **تحديد الموقع والقبلة:** `location`, `flutter_compass`
- **حساب أوقات الصلاة والزمن:** `prayers_times`, `timezone`, `flutter_timezone`
- **إدارة المهام في الخلفية والإشعارات (Background Tasks & Notifications):** 
  - `flutter_local_notifications` (للإشعارات المحلية)
  - `workmanager` (لتنفيذ مهام جلب الأوقات في الخلفية)
  - `android_alarm_manager_plus` (لجدولة تنبيهات الأذان بدقة عالية على نظام أندرويد)
  - `firebase_messaging` (لإشعارات الدفع Push Notifications)
- **خدمات فايربيس:** `firebase_core`
- **واجهة المستخدم والتصميم (UI & Design):** 
  - `flutter_screenutil` (لجعل التصميم متجاوباً Responsive مع جميع مقاسات الشاشات)
  - `google_fonts` (للخطوط المخصصة والجميلة)
  - `lottie` (للرسوم المتحركة التفاعلية)
  - `convex_bottom_bar` و `salomon_bottom_bar` (لأشرطة التنقل السفلية العصرية)
  - `flutter_animated_button` و `flutter_advanced_switch` و `flutter_datetime_picker` (لعناصر واجهة مستخدم تفاعلية)
- **تعدد اللغات:** `easy_localization`
- **الصوتيات والوسائط:** `audioplayers` (لتشغيل صوت الأذان)
- **أخرى:** `permission_handler` (لإدارة صلاحيات النظام)، `device_info_plus`، `googleapis_auth`.

## 📱 صور من التطبيق (Screenshots)

إليك بعض اللقطات من داخل التطبيق:

<p align="center">
  <img src="assets/screenshots/4.png" width="250" hspace="10" vspace="10">
  <img src="assets/screenshots/7.png" width="250" hspace="10" vspace="10">
  <img src="assets/screenshots/9(1).png" width="250" hspace="10" vspace="10">
  <img src="assets/screenshots/IMG-20250729-WA0012.png" width="250" hspace="10" vspace="10">
  <img src="assets/screenshots/Untitled design (2).png" width="250" hspace="10" vspace="10">
  <img src="assets/screenshots/Untitled design (3).png" width="250" hspace="10" vspace="10">
</p>
