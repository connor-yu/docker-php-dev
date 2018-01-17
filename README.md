# docker-php-dev

## 分支说明：
### master: 通过主分支可以启动完整的php开发环境，包括nginx, php-fpm, mariadb
### fpm: php-fpm的Dockerfile
### cli: php-cli的Dockerfile

## 使用步骤：
### 1、将目录下的所有文件复制到项目根目录（如果根目录有index.php,不要覆盖）;
### 2、从终端进入项目根目录，运行命令：docker-compose up -d ;
### 3、已经OK了，就这么简单。
