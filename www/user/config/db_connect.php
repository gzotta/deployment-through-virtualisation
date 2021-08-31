<?php

// Connect to database. Parameters: host, user name, password, databe's name.
$conn = mysqli_connect('localhost', 'george', 'test1234', 'bytes_pizza');

// Check connection
if (!$conn) {
    echo 'Connection error: ' . mysqli_connect_error();
}
