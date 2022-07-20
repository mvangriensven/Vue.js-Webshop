# Vue.js Webshop
 A webshop I've build from scratch whilst learning Vue.JS to showcase my understanding and ability to work in the framework

## Foreword
This webshop is by no means an all-round or production ready application, but just a demonstration and showcase of my ability to work with Vue.js, Vuex and API's.

The project is entirely open-source and free to use.

A to-do list of features I plan on integrating can be found down below as well as a list of current features and known bugs.

## Development

This project has been developed using the Vue.js CLI and XAMPP to host our PHP API and MySQL Database.

- The frontend (Vue.js) can be found under '/Vuejs Frontend/':
    - Be sure to adjust the specified api URL in '/Vuejs Frontend/src/store/index.js' at line 6, if needed.
- The Backend (PHP) can be found under '/PHP Backend/api/':
    - Be sure to validate the MySQL Database connection credentials under '/PHP Backend/api/backend/backend.php'.
    - Please review the .htaccess file which can be found under '/PHP Backend/.htaccess' and adjust according to your needs.
        - The .htaccess prevents the api from being called by any other source than the domainname the application is hosted on, in my case this was 127.0.0.1 as this project was developed on a localhost server.
    - **PLEASE BE AWARE THAT IN backend.php** 'Access-Control-Allow-Origin' **IS SET TO** 'localhost'.
- A MySQL Database snippet can be found under '/PHP Backend/webshop.sql'.

A snippet of the used datab

### Features

- On the home page, filtering between categories of featured products.
- Displaying (labeled) product tiles:
    - Display (sale) price.
    - Labels:
        - Labelling products to be on sale.
        - Labelling products to be featured.
        - Labelling products to be out of stock.
- Product Pages:
    - Display a short product description.
    - Display (sale) price.
    - Display product specifications.
    - Ability to add items of interest to cart.
    - Hide 'Add to Cart' button if product is out of stock.
        - Display a message on the product page that the product is out of stock.
    - Display similar products (based on category).
- Create an Account:
    - Insert name and address credentials.
    - Verify inserted credentials before registering the user.
- Login:
    - Verify inserted credentials before authenticating the user with a session token.
- Cart:
    - Empty Cart.
    - Remove selected product from cart (see known bugs).
    - Proceed to checkout.
- Checkout:
    - Placing an order, which will be verified thru the backend.


### To-do

- More extensive validation of user credentials when creating an account.
- Allowing users to change their name and address credentials (infrastructure in place to support this).
- Allowing system administrators to modify product details, its known inventory and whether they are featured and/or on sale.
- Allowing sytem administrators to add new products into the database.
- Adding an indicator whether the customer fulfilled the payment of their order.

### Known Bugs

- Removing a selected product from cart will always remove the bottom product instead.