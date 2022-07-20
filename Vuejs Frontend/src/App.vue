<template>
  <nav>
    <ul>
      <router-link to="/"><li style="float: left; font-size: 1.75em;">BRAND NAME</li></router-link>
      <router-link to="/cart"><li>Cart ({{ this.$store.getters.cartSize }})</li></router-link>
      <li style="cursor: pointer;" v-if="this.$store.getters.isLoggedIn" @click="logout">Logout</li>
      <router-link v-else to="/authentication"><li>Login</li></router-link>
      <router-link v-if="this.$store.getters.isLoggedIn" to="/dashboard"><li>My Account</li></router-link>
      <router-link to="/products"><li>Products</li></router-link>
      <router-link to="/aboutus"><li>About</li></router-link>
      <router-link to="/"><li>Home</li></router-link>
    </ul>
  </nav>
  <router-view/>
</template>

<script>
export default {
  methods: {
    logout: function() {
      this.$store.dispatch('logout');
    }
  }
}
</script>


<style>

html, body, #app {
  padding: 0;
  margin: 0;
  width: 100%;
  height: 100%;
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  scroll-behavior: smooth;
  color: #2c3e50;

  -webkit-touch-callout: none; /* iOS Safari */
  -webkit-user-select: none; /* Safari */
  -khtml-user-select: none; /* Konqueror HTML */
  -moz-user-select: none; /* Old versions of Firefox */
  -ms-user-select: none; /* Internet Explorer/Edge */
  user-select: none; /* Non-prefixed version, currently supported by Chrome, Edge, Opera and Firefox */
}

::-webkit-scrollbar {
  width: 5px;
}

::-webkit-scrollbar-track {
  background: #f1f1f1;
}

::-webkit-scrollbar-thumb {
  background: rgb(90, 90, 90);
}

::-webkit-scrollbar-thumb:hover {
  background: rgb(50, 50, 50);
}

p {
  font-size: 1.4em;
}

h1 {
  font-size: 3.25em;
}

a {
  text-decoration: none;
}

nav {
  /* position: relative; */
  top: 0;
  left: 0;
  width: 100%;
  min-height: 75px;
}

nav a {
  font-weight: bold;
  color: #2c3e50;
}

nav ul {
  list-style-type: none;
}

nav ul li {
  text-align: center;
  float: right;
  font-weight: bold;
  color: #2c3e50;
  /* width: 50px; */
  padding: 30px;
}

nav ul li:hover {
  background-color: #f9f9f9;
  box-shadow: 0px 8 px 16px 0px rgba(0,0,0,0.2);
}

.container {
  width: 85%;
  height: 100%;
  
  padding: 60px;

  margin-left: auto;
  margin-right: auto;
}

.container .flex-container {
  transition: 0.25s linear all;

  padding: 0;
  margin: 0;

  width: 100%;
  min-height: 1px;

  justify-content: center;
  list-style: none;

  -ms-box-orient: horizontal;
  flex-wrap: wrap;
  -webkit-flex-wrap: wrap;

  display: -webkit-box;
  display: -moz-box;
  display: -ms-flexbox;
  display: -moz-flex;
  display: flex;
}

.front-page {
  position: relative;
  width: 100%;
  height: 70%;

  padding: 20px;

  margin-left: auto;
  margin-right: auto;
  margin-bottom: 150px;

  background-color: rgba(220, 220, 220, 0.4);

  border-radius: 10px;
  box-shadow: 5px 5px 10px rgba(82, 82, 82, 0.2);
}

.front-page .cover-image {
  float: left;

  width: 50%;
  height: 100%;

  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
}

.front-page .content {
  float: left;

  width: calc(50% - 140px);
  height: calc(100% - 140px);

  padding: 70px;
}

button, input[type=button], input[type=submit], input[type=reset] {
  background-color: transparent;
  border: 2px solid #555555;
  color: black;
  padding: 16px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  transition-duration: 0.15s;
  cursor: pointer;
}

button:hover, input[type=button]:hover, input[type=submit]:hover, input[type=reset]:hover {
  background-color: #555555;
  color: white;
}

input[type=text], input[type=password] {
  width: 100%;
  padding: 12px 20px;
  margin: 8px 0;
  box-sizing: border-box;
  border: 2px solid #555555;
}

a, a.active, a:link, a:visited, a:hover, a:active, router-link, router-link-active, router-link-exact-active {
  color: black !important;
}
</style>
