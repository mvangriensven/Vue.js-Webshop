<?php

    require 'backend/backend.php';

    $jsonResponse = new stdClass();
    
    $action;
    $token;

    if (!isset($_GET['action'])) {
        $jsonResponse->response = "No Action Specified";
        echo json_encode($jsonResponse);
        exit();
    }

    if (!isset($_GET['token'])) {
        $jsonResponse->response = "No Login Token Provided";
        echo json_encode($jsonResponse);
        exit();
    }

    $action = strtoupper($_GET['action']);
    $token  = $_GET['token'];

    switch ($action) {
        case "PLACE":
            $jsonResponse->response = placeOrder($_GET['params'], $token);
            break;
        case "GET":
            if (!isset($_GET['order'])) {
                return "Order ID Missing";
            }

            $orderId = strtoupper($_GET['order']);

            // if ($orderId == 'ALL') {
                $jsonResponse->response = getAllOrders($token);
            // } else {
                // $jsonResponse->response = getOrderById($token, $orderId);
            // }
            break;
        default:
            $jsonResponse->response = "Invalid Action";
            break;
    }

    echo json_encode($jsonResponse);
    exit();

    

    function placeOrder ($params, $sessionToken) {

        GLOBAL $conn;

        $parameters = explode(',', $params);
        
        if (sizeof($parameters) < 1) {
            return 'No Products in Order';
        }

        // A count to keep track of the amount of products we tried to 
        // register but ended up being out of stock.
        // In the case of all products being out of stock we want to
        // notify the user that none of the selected products could be ordered
        // and we will also remove the empty order.
        $outOfStock = 0;

        // Create empty order
        $stmt = $conn->prepare('INSERT INTO orders (user, address) VALUES ((SELECT userId FROM sessions WHERE token = :sessionToken), (SELECT u.address FROM users AS u INNER JOIN sessions AS s ON s.userId = u.id WHERE s.token = :sessionToken))');
        $stmt->execute(array(
            ":sessionToken" => $sessionToken,
        ));
        $orderId = $conn->lastInsertId();

        for ($i = 0; $i < sizeof($parameters); $i++) {

            $stmt = $conn->prepare("SELECT inventory FROM products WHERE id = :productId");
            $stmt->execute(array(
                ":productId" => $parameters[$i],
            ));
            $inventory = $stmt->fetch();

            // Product inventory check before inserting
            if ($inventory[0] > 0) {
                $stmt = $conn->prepare("INSERT INTO orderedproducts (orderid, productid) VALUES (:orderid, :productid)");
                $stmt->execute(array(
                    ':orderid' => $orderId,
                    ':productid' => $parameters[$i],
                ));

                // Decrease inventory of product by 1
                $stmt = $conn->prepare("UPDATE products SET inventory = :inventory WHERE id = :productId");
                $stmt->execute(array(
                    ":inventory" => $inventory[0] - 1,
                    ":productId" => $parameters[$i],
                ));

            } else {
                $outOfStock++;
            }
        }

        // If all products were out of stock, delete the empty order.
        if ($outOfStock == sizeof($parameters)) {
            $stmt = $conn->prepare("DELETE FROM orders WHERE id = :orderId");
            $stmt->execute(array(
                ":orderId" => $orderId,
            ));

            return "All Selected Products are Out of Stock";
        }

        return "Your order has been placed. You will receive a confirmation in your email inbox soon!";
    }

    function getAllOrders($token) {

        GLOBAL $conn;

        $stmt = $conn->prepare("SELECT  o.id,
                                        o.date,
                                        a.place,
                                        a.street,
                                        a.zipcode
                                FROM orders AS o
                                INNER JOIN sessions AS s
                                ON s.userId = o.user
                                INNER JOIN adresses AS a
                                ON o.address = a.id
                                WHERE s.token = :token ORDER BY o.id DESC");
        $stmt->execute(array(
            ":token" => $token,
        ));

        $orders = $stmt->fetchAll();

        for ($i = 0; $i < sizeof($orders); $i++) {

            $stmt = $conn->prepare("SELECT  p.name AS productName,
                                            p.price,

                                            IF (s.productId IS NOT NULL AND s.startDate < NOW() AND s.expiryDate > NOW(), TRUE, FALSE) AS onSale,
                                            IF (s.productId IS NOT NULL AND s.startDate < NOW() AND s.expiryDate > NOW(), ROUND(s.price, 2), FALSE) AS salePrice 
                                    FROM products AS p
                                    LEFT JOIN sale AS s
                                    ON s.productId = p.id
                                    INNER JOIN orderedproducts AS op
                                    ON op.productid = p.id
                                    INNER JOIN orders AS o
                                    ON o.id = op.orderid
                                    WHERE o.id = :orderId");
            $stmt->execute(array(
                ":orderId" => $orders[$i]['id'],
            ));

            $orders[$i]['products'] = $stmt->fetchAll();

        }
        
        return $orders;

    }

?>