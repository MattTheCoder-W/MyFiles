# Instalacja Zabbix

## Wymagania systemowe

 - Ubuntu 22.04 LTS

## Wstępne ustalenia

Hasło do MySQL: `zaq1@WSX`

Hasło do bazy `zabbix`: `password`

## Przed rozpoczęciem

Należy zaktualizować `apt` komendą:

`sudo apt update`

## Instalacja Zabbix

### Instalcja bazy danych MySQL

`sudo apt install mysql-server`

`sudo systemctl enable --now mysql.service`

#### Konfiguracja MySQL

`sudo mysql_secure_installation`

W oknie należy podać ustawić dane logowania do bazy danych (hasło). Na potrzeby dokumentacji będzie to `zaq1@WSX`.

*UWAGA* Wprzypadku błedu przy ustawiania hasła o treści `SET PASSWORD has no significance for user 'root'@'localhost' as the authentication method used doesn't store authentication data in the MySQL server. Please consider using ALTER USER instead if you want to change authentication parameters.` nalezy wykonać dodatkowe kroki:

 - `sudo mysql` (uruchomi to konsolę mysql)
 - w konsoli mysql: `ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'zaq1@WSX';`
 - w konsoli mysql: `exit`

### Instalacja pakietu zabbix

Należy pobrać plik `.deb` zawierający informacje na temat repozytorium `apt` dla zabbixa:

`wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-4+ubuntu22.04_all.deb`

Teraz w katalogu w którym wykonana została powyższa komenda pojawi się plik `zabbix-release_6.0-4+ubuntu22.04_all.deb`.

Należy go użyć w poleceniu `dpkg`:

`sudo dpkg -i zabbix-release_6.0-4+ubuntu22.04_all.deb`

Aby zastosować nowe repozytoria należy wykonać komendę:

`sudo apt update`

### Instalacja zabbix

`sudo apt install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent`

Powyższe polecenie zainstaluje wszystkie potrzebne pakiety a mianowicie:

 - `zabbix-server-mysql` - narzędzia i skrypty do serwera mysql dla zabbixa
 - `zabbix-frontend-php` - stronę frontendową do konfiguracji zabbixa
 - `zabbix-apache-conf` - konfigurację apache dla zabbixa
 - `zabbix-sql-scripts` - skrypty konfiguracyjne dla mysql
 - `zabbix-agent` - agent zabbixowy

### Konfiguracja bazy danych MySQL dla zabbix

Należy uruchomić `konsolę mysql` poleceniem:

`mysql -u root -p`

należy użyć hasła ustawionego przy instalacji mysql czyli w przypadku dokumentacji `zaq1@WSX`.

W konsoli:

`create database zabbix character set utf8mb4 collate utf8mb4_bin;`

`create user zabbix@localhost identified by 'password';` (gdzie password to hasło dla użytkownika zabbixowego, w przypadku dokumentacji to `password`)

`grant all privileges on zabbix.* to zabbix@localhost;`

`set global log_bin_trust_function_creators = 1;`

`quit;`

#### Tworzenie struktury bazy danych

Zabbix udostępnia gotowy skrypt do tworzenia struktury bazy danych który został zainstalowany razem z pakietem `zabbix-sql-scripts`, aby go zastosować należy wykonać:

`zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -u zabbix -p zabbix`

Należy podać hasło dla użytkownika `zabbix`, w przypadku dokumentacji jest to `password`.

#### Zakończenie konfiguracji bazy danych

`mysql -u root -p`

należy podać hasło do MySQL, tutaj `zaq1@WSX`.

W konsoli MYSQL:

`set global log_bin_trust_function_creators = 0;`

`quit;`

W pliku `/etc/zabbix/zabbix_server.conf` należy ustawić hasło do bazy danych (tutaj `zaq1@WSX`):

`DBPassword=zaq1@WSX`

dopisać to do pliku.

### Uruchamianie zabbix

`sudo systemctl restart zabbix-server zabbix-agent apache2`

Jeżeli pojawia się błąd wskazujący na to że apache2 nie istnieje należy zainstalować apache2!

## Sprawdzanie poprawności instalacji

Należy wejść na adres maszyny zabbixowej w przeglądarce z dopiskiem `/zabbix`.

np. `http://127.0.0.1/zabbix` lub `http://192.168.1.10/zabbix`