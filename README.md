## Install the dependencies
```
composer install
```

## Run the appp
```
php -S 0.0.0.0:8080 -t public
```
or
```
composer start
```

Or you can use `docker-compose` to run the app with `docker`, so you can run these commands:
```bash
cd [my-app-name]
docker-compose up -d
```
After that, open `http://localhost:8080` in your browser.

Run this command in the application directory to run the test suite

```bash
composer test
```
```
curl http://localhost:8080/users
```

```
{
  "statusCode": 200,
  "data": [
    {
      "id": 1,
      "username": "shnmkhk",
      "firstName": "Shanmukha",
      "lastName": "Katuri"
    },
    {
      "id": 2,
      "username": "ytnktr",
      "firstName": "Yatin",
      "lastName": "Katuri"
    },
    {
      "id": 3,
      "username": "sljvngll",
      "firstName": "Sailaja",
      "lastName": "Venigalla"
    }
  ]
}
```
![Screenshot](./screenshots/DB_Results_Preview_REST_GET.png "Text to show on mouseover")