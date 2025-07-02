<?php
use App\Domain\Utils\DBUtils;

echo DBUtils::getValue("dbname");
return [
    'dbname' => DBUtils::getValue("dbname"),
    'user' => DBUtils::getValue("user"),
    'password' => DBUtils::getValue("password"),
    'host' => DBUtils::getValue("host"),
    'driver' => DBUtils::getValue("driver")
];