<?php

declare(strict_types=1);
namespace App\Domain\Utils;
class DBUtils
{
    const PROP_DB_HOST = "host";
    const PROP_DB_NAME = "dbname";
    const PROP_DB_DRIVER = "driver";
    const PROP_DB_USERNAME = "user";
    const PROP_DB_PASSWORD = "password";
    public static function getValue($key)
    {
        $ini_array = parse_ini_file("db.properties");
        if (isset($ini_array[$key])) {
            $value = $ini_array[$key];
        } else {
            $value = "";
        }
        return $value;
    }
}