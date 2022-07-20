<?php

    require 'backend/backend.php';

    $jsonResponse = new stdClass();

    // The action we would like to execute, e.g login, register..
    $action;

    if (isset($_GET['action'])) {

        $action = strtoupper($_GET['action']);

        switch ($action) {
            case "LOGIN":

                if (isset($_GET["email"], $_GET["password"])) {
                    $data = login($_GET["email"], $_GET["password"]);
                    $jsonResponse->response = $data[0];
                    $jsonResponse->token = $data[1];
                    echo json_encode($jsonResponse);
                    exit();
                } else {
                    $jsonResponse->response = "Username or Password Missing";
                    echo json_encode($jsonResponse);
                    exit();
                }

                break;

            case "LOGOUT":

                if (isset($_GET["token"])) {
                   $jsonResponse->response = logout($_GET["token"]);
                   $jsonResponse->sentToken = $_GET["token"];
                   echo json_encode($jsonResponse);
                   exit();
                } else {
                   $jsonResponse->response = "Token Missing";
                   echo json_encode($jsonResponse);
                   exit(); 
                }

            case "REGISTER":

                if (isset($_GET["firstname"], $_GET["lastname"], $_GET["email"], $_GET["password"], $_GET["place"], $_GET["street"], $_GET["building"], $_GET["zipcode"])) {
                    $jsonResponse->response = register($_GET["firstname"], $_GET["lastname"], $_GET["email"], $_GET["password"], $_GET["place"], $_GET["street"], $_GET["building"], $_GET["zipcode"]);
                    echo json_encode($jsonResponse);
                    exit();
                } else {
                    $jsonResponse->response = "Required Credentials Missing";
                    echo json_encode($jsonResponse);
                    exit();
                }
                break;

            default:
                $jsonResponse->response = "Invalid Action";
                echo json_encode($jsonResponse);
                exit();
                break;
        }

    } else {

        $jsonResponse->response = "No Action Specified";
        echo json_encode($jsonResponse);
        exit();

    }

    function login($email, $password) {

        GLOBAL $conn;

        // Variable that will be returned
        $returnData = ["Invalid Login Credentials", null];

        $stmt = $conn->prepare("SELECT id, password FROM users WHERE email = :email");
        $stmt->execute(array(
            ":email" => $email,
        ));
        $data = $stmt->fetch();

        if ($data == null)
            return $returnData;

        if (!password_verify($password, $data[1]))
            return $returnData;
        else
            // Set Session
            $sessionToken = generateToken();

            $stmt = $conn->prepare("INSERT INTO sessions (userId, token) VALUES (:userId, :token)");
            $stmt->execute(array(
                ":userId" => $data[0],
                ":token" => $sessionToken,
            ));

            $returnData[0] = "Valid Login Credentials";
            $returnData[1] = $sessionToken;

            return $returnData;

    }

    function logout($token) {

        GLOBAL $conn;

        $stmt = $conn->prepare("DELETE FROM sessions WHERE token = :token");
        $stmt->execute(array(
            ":token" => $token,
        ));

        return 'Sucessfully logged out';

    }

    function register($firstname, $lastname, $email, $password, $place, $street, $building, $zipcode) {

        GLOBAL $conn;

        $stmt = $conn->prepare("SELECT id FROM users WHERE email = :email");
        $stmt->execute(array(
            ":email" => $email,
        ));
        $data = $stmt->fetch();

        $_street = $street . " " . $building;

        if ($data != null)
            return "Email in use";

        // Verify password integrity.
        if (strlen($password) <= 6)
            return "Password too short";

        if (!preg_match("#[0-9]+#", $password))
            return "Password must contain number";

        if (!preg_match("#[a-zA-Z]+#", $password))
            return "Password must contain a letter";

        if (!preg_match("/[A-Z]/", $password))
            return "Password must contain a capital letter";

        if (!preg_match("/[a-z]/", $password))
            return "Password must contain a small letter";

        // Check if the address is already present in our database.
        $stmt = $conn->prepare("SELECT * FROM adresses WHERE place = :place AND street = :street AND zipcode = :zipcode");
        $stmt->execute(array(
            ":place" => $place,
            ":street" => $_street,
            ":zipcode" => $zipcode,
        ));
        $addr = $stmt->fetch();

        $addressId;

        if ($addr == null) {

            $stmt = $conn->prepare("INSERT INTO adresses (place, street, zipcode) VALUES (:place, :street, :zipcode)");
            $stmt->execute(array(
                ":place" => $place,
                ":street" => $_street,
                ":zipcode" => $zipcode,
            ));

            $addressId = $conn->lastInsertId();

        } else {

            $addressId = $addr['id'];

        }

        $stmt = $conn->prepare("INSERT INTO users (firstname, lastname, email, password, address) VALUES (:firstname, :lastname, :email, :password, :address)");
        $stmt->execute(array(
            ":firstname" => $firstname,
            ":lastname" => $lastname,
            ":email" => $email,
            ":password" => password_hash($password, PASSWORD_DEFAULT),
            ":address" => $addressId
        ));

        return "Registration Complete";

    }

    function generateToken($length = 50) {

        $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
        $charactersLength = strlen($characters);
        $randomString = '';

        for ($i = 0; $i < $length; $i++) {
            $randomString .= $characters[rand(0, $charactersLength - 1)];
        }

        return $randomString;

    }

?>