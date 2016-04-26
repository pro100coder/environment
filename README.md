# Введение

Данная утилита предоставляет набор docker контейнеров для быстрого разворачивание рабочего окружения PHP программиста.
Набор программ входящих в состав:
1. php 5.2, 5.5, 5.6, 7.0
2. MariaDB, PostgreSQL
3. Apache SOLR
4. Nginx

Так же доступны RVM, NPM и композер.
Для смены версии в консоли используется [PhpBrew](https://github.com/phpbrew/phpbrew)
Важно помнить что работа будет происходить не не локальной машине как все привыкли, а на виртуальной машине которая находится у вас на локальной.
Это правило влияет на отладку скриптов и запуск комманд(drush, composer и пр).
Все комманды должны выполнятся внутри виртуальной машины(т.е. контейнера).  

# Установка

1. Устанавливаем на свою ОС [docker](https://docs.docker.com/installation/) и [docker-compose](https://docs.docker.com/compose/install)
4. Добавляем в хосты `docker-host` с IP хоста докера. В ОС Linux это 127.0.0.1, для остальных операционных систем можно узнать с помощью `docker-machine ip default`

## Разворачивание среды

1. Отключаем если утановленны nginx, mysql и пр.
2. Открываем консоль с Docker и Docker compose в директории данного проекта
3. Разворачиваем контейнеры с данными `docker-compose -f docker-compose-datastore.yml up -d`. Если папка проекта названна не enviroment то ко всем коммандам `docker-compose up` следует добавить параметр `-p enviroment`
4. Разворачиваем контейнеры со всем окружением `docker-compose up -d`

# Использование

## Подключение к БД и пр. сервисам

В контейнере нет понятия локальный хост, т.к. все службы разбиты по разным контейнерам.
Для того что бы посмотреть с какими сервисами имеется связь, достаточно выполнить `cat /etc/hosts` внутри контейнера.

## Добавление конфигурации nginx


# Обновление

1. Забрать последние изменения проекта(`git pull`)
2. В папке с проектом запустить `docker-compose up -d`

---
### Литература

1. Настройка автоматической синхронизации http://goo.gl/kL2xno
2. http://www.sitepoint.com/install-xdebug-phpstorm-vagrant/
3. http://randyfay.com/content/remote-command-line-debugging-phpstorm-phpdrupal-including-drush
4. http://randyfay.com/node/130
5. sshfs www-data@127.0.0.1:/srv/www ~/Projects/www-data -p 10022 -oreconnect
6. fusermount -u ~/Projects/www-data
7. http://stackoverflow.com/questions/14310339/using-remote-server-in-phpstorm
8. http://osxfuse.github.io
9. http://debian-help.ru/articles/xhprof-i-xdebug-profilirovanie-profiling-koda-php/
10. /srv/www/system/xhprof/xhprof_lib
11. /usr/local/lib/php/xhprof_lib
12. sudo mount -t cifs //127.0.0.1/public ~/Projects/www-data -o guest,uid=YOU_GROUP,gid=YOU_USER
13. sudo umount -l ~/Projects/www-data
