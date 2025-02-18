# MiWatchLuaWatchfaces

# [English](README.md)

### Примеры циферблатов Xiaomi на движке LUA, для часов 
  Mi Band 8 Pro,  
  Redmi Watch 4,  
  Mi Watch S3,  
  Mi Band 9,  
  Mi Band 9 Pro  

Тут вы можете ознакомиться с примерами циферблатов для различных часов Xiaomi.   
Ознакомиться с языком программирования LUA можно здесь - https://www.lua.org/start.html   

В помощью редактора Easyface можно упаковать циферблаты - https://github.com/m0tral/Easyface  

Данные модели часов работают на базе RTOS NuttX => https://nuttx.apache.org/docs/latest/   
и используют графическую библиотеку LVGL => https://lvgl.io/get-started

Чтобы сконвертировать картинки в нужный формат   
воспользуйтесь онлайн конфертором LVGL converter => https://lvgl.io/tools/imageconverter  
  
<img src="img/lvgl_conv_settings.png"/>   
Тут показаны какие параметры нужно выбрать,   
чтобы получить картинку в нужном формате   
   
Данные приложения можно отлаживать на PC симуляторе,   
Я лично использую Windows 10, вместе с WSl2/Ubuntu.   
Позже добавлю как это делается.   

#### MiBand8Pro примеры   
 - Digital time => пример простых цифровых часов с мигающим разделителем   
 - Analog time  => пример аналоговых часов   
 - Analog time animated  => пример аналоговых часов с плавной стрелкой, анимация + пример события: нажатие   
 - Accelerometer  => пример использования данных акселероментра как источника данных для анимации обьекта   
 - Diffusion  => пример адаптации циферблата с Redmi Watch 4   
 - FlyingCat  => пример с акселерометров, анимацей, нажатием + эффект снега   
 
#### Redmi Watch 4 примеры   
 - Diffusion  => пример родного циферблата   
   TouchEvents => отслеживание параметров тач событий   
 
#### MiBand9 примеры   
 - watchface_366269993  => пример родного циферблата   

#### MiBand9 Pro примеры   
 - PointerTest  => пример виджета Pointer   
 - AnalogTimeTest  => пример виджета AnalogTime   
 - ImageBarTest  => пример виджета ImageBar   
 - CurvedLabelTest  => пример виджета CurvedLabel   

#### MiWatchS3 примеры   

#### Watchfaces примеры для не LUA моделей   
   
#### RedmiWatch 5 Lite примеры   
#### RedmiWatch 5 Active примеры   
#### RedmiWatch 3 Active примеры   

буду дополнять по мере наработок   

