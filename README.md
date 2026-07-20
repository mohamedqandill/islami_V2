
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



<img width="1920" height="1080" alt="7" src="https://github.com/user-attachments/assets/16e33db8-441c-4d06-850c-66c7a0c5be0d" />
<img width="1920" height="1080" alt="4" src="https://github.com/user-attachments/assets/6cc98352-d851-4082-a7c8-36275849856d" />
<img width="1024" height="500" alt="Untitled design (3)" src="https://github.com/user-attachments/assets/b71c7fd7-8173-4fb6-bab7-642651457c32" />
<img width="1024" height="500" alt="Untitled design (2)" src="https://github.com/user-attachments/assets/b4499011-e5ce-4f9f-b653-1d4acc8d2ff0" />
<img width="606" height="1280" alt="IMG-20250729-WA0012" src="https://github.com/user-attachments/assets/3b3ad8d9-b55c-4ddd-8bee-996e321c56cd" />

<img width="1920" height="1080" alt="9(1)" src="https://github.com/user-attachments/assets/7e44244f-0571-44b9-816e-e3c56d5f2965" />


