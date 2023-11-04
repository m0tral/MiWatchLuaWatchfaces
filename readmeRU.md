# MiWatchLuaWatchfaces

# [English](README.md)

### Примеры циферблатов Xiaomi на движке LUA, для часов Mi Band 8 Pro, Mi Watch S3

Тут вы можете ознакомиться с примерами циферблатов для различных часов Xiaomi.
Ознакомиться с языком программирования LUA можно здесь - https://www.lua.org/start.html  

В помощью редактора Easyface можно упаковать циферблаты - https://github.com/m0tral/Easyface  

Данные модели часов работают на базе RTOS NuttX => https://nuttx.apache.org/docs/latest/   
и используют графическую библиотеку LVGL => https://lvgl.io/get-started

Чтобы сконвертировать картинки в нужный формат   
воспользуйтесь онлайн конфертором LVGL converter => https://lvgl.io/tools/imageconverter  
  
<img src="img/lvgl_conv_settings.png"/>   
Тут показаны какие параметры нужно выбрать чтобы получить   
картинку в нужном формате   
   
It's possible to debug all this stuff on PC cross-platform emulator,   
I personally prefer use Windows 10, under WSl2/Ubuntu subsystem.   
Will show you later how to do it.   

#### MiBand8Pro примеры
 - Digital time => пример простых цифровых часов с мигающим разделителем
 - Analog time  => пример аналоговых часов
 - Analog time animated  => пример аналоговых часов с плавной стрелкой, анимация + пример события: нажатие

#### MiWatchS3 примеры

буду дополнять по мере наработок

