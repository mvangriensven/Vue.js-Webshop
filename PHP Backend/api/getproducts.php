<?php

    require 'backend/backend.php';

    $productId = null;
    $categoryId = null;
    $featured = false;
    $similartocategory = null;
    
    if (isset($_GET['productid'])) {
        $productId = $_GET['productid']; 

        if ($productId == "all" || $productId == "ALL")
            echo json_encode(getAllProducts());
        else
            echo json_encode(getProductById($productId));

        exit();
    }

    if (isset($_GET["productids"])) {
        getProductsById($_GET["productids"]);
    }
    
    if (isset($_GET["categoryid"])) {
        $categoryId = $_GET["categoryid"];
        echo json_encode(getProductsByCategory($categoryId));
        exit();
    }

    if (isset($_GET["featured"]) && $_GET["featured"] == "true") {

        $featured = true;

        if ($productId == null && $categoryId == null)
            echo json_encode(getFeaturedProducts());
            exit();
    }

    if (isset($_GET["similartocategory"])) {

        $similartocategory = $_GET["similartocategory"];

        // The maximum amount of similar products we would like to fetch.
        if (isset($_GET["amount"]))
            $amount = $_GET["amount"];
            echo json_encode(getSimilarProducts($similartocategory));
            exit();

        echo json_encode(getSimilarProducts($similartocategory, $amount));

    }

    function getProductById ($productId) {

        GLOBAL $conn;

        $stmt = $conn->prepare("SELECT  c.name AS categoryName,
                                        p.categoryId,
                                        b.name AS brandName,
                                        p.inventory,
                                        p.name AS productName,
                                        p.image,
                                        p.description,
                                        p.specifications,
                                        p.price,
                                        IF (s.productId IS NOT NULL AND s.startDate < NOW() AND s.expiryDate > NOW(), TRUE, FALSE) AS onSale,
                                        IF (s.productId IS NOT NULL AND s.startDate < NOW() AND s.expiryDate > NOW(), ROUND(s.price, 2), FALSE) AS salePrice
                                FROM products AS p
                                INNER JOIN brands AS b ON b.id = p.brandId
                                INNER JOIN categories AS c ON c.id = p.categoryId
                                LEFT JOIN sale AS s ON s.productId = p.id
                                WHERE p.id = :productId");
        $stmt->execute(array(
            ":productId" => $productId
        ));
        return $stmt->fetch();

    }

    function getProductsById ($products) {

        GLOBAL $conn;

        $productIds = explode(',', $products);
        $jsonResponse = new stdClass();

        for ($i = 0; $i < sizeof($productIds); $i++) {

            $stmt = $conn->prepare("SELECT  b.name as brandName,
                                            p.name AS productName,
                                            p.price,
                                            IF (s.productId IS NOT NULL AND s.startDate < NOW() AND s.expiryDate > NOW(), TRUE, FALSE) AS onSale,
                                            IF (s.productId IS NOT NULL AND s.startDate < NOW() AND s.expiryDate > NOW(), ROUND(s.price, 2), FALSE) AS salePrice
                                    FROM products AS p
                                    INNER JOIN brands AS b on b.id = p.brandId
                                    LEFT JOIN sale AS s ON s.productId = p.id
                                    WHERE p.id = :productId");
            $stmt->execute(array(
                ":productId" => $productIds[$i],
            ));
            $data = $stmt->fetch();

            if ($data != null) {
                $jsonResponse->products[$i]['brandName']    = $data['brandName'];
                $jsonResponse->products[$i]['productName']  = $data['productName'];
                $jsonResponse->products[$i]['price']        = $data['price'];
                $jsonResponse->products[$i]['onSale']       = $data['onSale'];
                $jsonResponse->products[$i]['salePrice']    = $data['salePrice'];
            }
        }

        echo json_encode($jsonResponse);
        exit();

    }

    function getAllProducts () {

        GLOBAL $conn;

        $stmt = $conn->prepare("SELECT  p.id AS productId,
                                        c.name AS categoryName,
                                        p.name AS productName,
                                        p.image,
                                        p.price,
                                        p.inventory,
                                        IF (s.productId IS NOT NULL AND s.startDate < NOW() AND s.expiryDate > NOW(), TRUE, FALSE) AS onSale,
                                        IF (s.productId IS NOT NULL AND s.startDate < NOW() AND s.expiryDate > NOW(), ROUND(s.price, 2), FALSE) AS salePrice,
                                        IF (f.productId IS NOT NULL AND f.startDate < NOW() AND f.expiryDate > NOW(), TRUE, FALSE) AS isFeatured
                                        FROM products AS p
                                        INNER JOIN categories AS c ON p.categoryId = c.id
                                        LEFT JOIN sale AS s on s.productId = p.id
                                        LEFT JOIN featured AS f on f.productId = p.id
                                        ORDER BY RAND()");
        $stmt->execute();

        return $stmt->fetchAll();

    }

    function getProductsByCategory ($categoryId) {

        GLOBAL $conn;

        $stmt = $conn->prepare("SELECT  b.name AS brandName,
                                        p.name as productName,
                                        p.image,
                                        p.description,
                                        p.specifications,
                                        p.price,
                                        IF (s.productId IS NOT NULL AND s.startDate < NOW() AND s.expiryDate > NOW(), TRUE, FALSE) AS onSale,
                                        IF (s.productId IS NOT NULL AND s.startDate < NOW() AND s.expiryDate > NOW(), ROUND(s.price, 2), FALSE) AS salePrice,
                                        IF (f.productId IS NOT NULL AND f.startDate < NOW() AND f.expiryDate > NOW(), TRUE, FALSE) AS isFeatured
                                FROM products AS p
                                INNER JOIN categories AS c ON p.categoryId = c.id
                                INNER JOIN brands AS b ON p.brandId = b.id
                                LEFT JOIN sale AS s ON s.productId = p.id
                                LEFT JOIN featured AS f on f.productId = p.id
                                WHERE p.categoryId = :categoryId");
        $stmt->execute(array(
            ":categoryId" => $categoryId
        ));

        return $stmt->fetchAll();
        
    }

    function getFeaturedProducts () {

        GLOBAL $conn;

        $stmt = $conn->prepare("SELECT  p.id AS productId,
                                        c.name AS categoryName,
                                        p.name as productName,
                                        p.image,
                                        p.price,
                                        p.inventory,
                                        IF (s.productId IS NOT NULL AND s.startDate < NOW() AND s.expiryDate > NOW(), TRUE, FALSE) AS onSale,
                                        IF (s.productId IS NOT NULL AND s.startDate < NOW() AND s.expiryDate > NOW(), ROUND(s.price, 2), FALSE) AS salePrice
                                FROM featured AS f
                                INNER JOIN products AS p ON p.id = f.productId
                                INNER JOIN categories AS c ON p.categoryId = c.id
                                LEFT JOIN sale AS s ON s.productId = p.id
                                WHERE f.productId IS NOT NULL AND f.startDate < NOW() AND f.expiryDate > NOW()");

        $stmt->execute();

        return $stmt->fetchAll();

    }

    function getSimilarProducts ($categoryId, $maxAmount = 100) {

        GLOBAL $conn;

        $stmt = $conn->prepare("SELECT  p.id AS productId,
                                        c.name as categoryName,
                                        p.name as productName,
                                        p.image,
                                        p.price,
                                        p.inventory,
                                        IF (s.productId IS NOT NULL AND s.startDate < NOW() AND s.expiryDate > NOW(), TRUE, FALSE) AS onSale,
                                        IF (s.productId IS NOT NULL AND s.startDate < NOW() AND s.expiryDate > NOW(), ROUND(s.price, 2), FALSE) AS salePrice,
                                        IF (f.productId IS NOT NULL AND f.startDate < NOW() AND f.expiryDate > NOW(), TRUE, FALSE) AS isFeatured
                                FROM products AS p
                                INNER JOIN categories AS c on p.categoryId = c.id
                                LEFT JOIN sale AS s ON s.productId = p.id
                                LEFT JOIN featured AS f on f.productId = p.id
                                WHERE p.categoryId = :categoryId ORDER BY RAND() LIMIT :maxAmount");

            // Preferred method of binding values doens't allow us to bind a value to :maxAmount, ->bindValue used as solution.
        $stmt->bindValue(":categoryId", $categoryId, PDO::PARAM_INT);
        $stmt->bindValue(":maxAmount", $maxAmount, PDO::PARAM_INT);
        $stmt->execute();

        return $stmt->fetchAll();

    }

?>