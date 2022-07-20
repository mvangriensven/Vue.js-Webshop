import { createStore } from 'vuex'
import axios from 'axios';
import VuexPersistence from 'vuex-persist';
import router from '@/router';

const url = 'http://localhost/api/';

const persistentData = new VuexPersistence({
  key: 'webshop',
  storage: window.localStorage
});

export default createStore({
  state() {
    return {
        // Variable used to get the current product id being viewed.
      productId: null,
      categoryId: null,
      cart: [],
      sessionToken: null
    }
  },
  getters: {

    getFeaturedProducts: async function() {
      return await axiosRequest(url + 'getproducts.php?featured=true');
    },

    // Fetches and returns all product data of a specific product
    getProduct: async function(state) {
      return await axiosRequest(url + `getproducts.php?productid=${state.productId}`);
    },

    getCartAsParams: async function(state, getters) {

      let params = '';

      for (let i = 0; i < getters.cartSize; i++) {
        params += state.cart[i]['productId'].toString();

        // Add a comma at end of the string, unless its the last execution round, to prevent the string to end on a comma
        if (i != getters.cartSize - 1)
          params += ',';
      }

      return params

    },

    // Fetches and returns all product data of all items in cart
    getProductData: async function (state, getters) {

      let params = await getters.getCartAsParams;

      return await axiosRequest(url + `getproducts.php?productids=${params}`)

    },

    // Gets all products in randomized order.
    getProducts: async function() {
      return await axiosRequest(url + 'getproducts.php?productid=all');
    },

    getSimilarProducts: async function(state) {
      return await axiosRequest(url + `getproducts.php?similartocategory=${state.categoryId}`);
    },

    cart (state) {
      return state.cart;
    },

    cartSize (state) {
      return state.cart.length;
    },

    getToken (state) {
      return state.sessionToken;
    },

    isLoggedIn (state) {
      if (state.sessionToken == null || state.sessionToken === undefined)
        return false
      else
        return true
    },

    getAllOrders: async function (state, getters) {
      const data = await axiosRequest(url + `orders.php?token=${getters.getToken}&action=get&order=all`);
      return data['response'];
    }

  },
  mutations: {

    setSessionToken (state, token) {
      state.sessionToken = token;
    },

    addToCart (state, product) {
      state.cart.push({
        productId: product[0],
        quantity: 1,
        price: product[1]
      });
    },

    removeFromCart (state, product) {
      console.log(state.cart)
      for (let i = 0; i < state.cart.length; i++) {

        // if product id in row matches product id we want to remove out of it
        if (state.cart[i]['productId'] == product) {
          state.cart.splice(i, 1);
          break;
        }
      }
    },

    emptyCart(state) {
      state.cart = [];
    },
  },

  actions: {

    async placeOrder ({ commit, getters }) {

      if (!getters.isLoggedIn)
        return

      if (getters.cartSize <= 0)
        return

      let params = await getters.getCartAsParams;

      console.log(url + `orders.php?token=${getters.getToken}&action=place&params=${params}`)
      
      let response = await axiosRequest(url + `orders.php?token=${getters.getToken}&action=place&params=${params}`);

      commit('emptyCart');

      alert(response['response']);

      router.push({ path: '/dashboard' })

      return commit 
    },

    async login (state, credentials) {
      if (credentials == null || credentials === undefined)
        return

      let response = await axiosRequest(url + `auth.php?action=login&email=${credentials['email']}&password=${credentials['password']}`);

      switch (response['response']) {
        case "Invalid Login Credentials":
          alert("The provided email or password is incorrect.");
          break;
        case "Valid Login Credentials":
          this.commit('setSessionToken', response['token']);
          router.push({ path: '/dashboard' })
          break;
        default:
          alert(response['response']);
          break;
      }
    },

    async logout ({ getters }) {
      let response = await axiosRequest(url + `auth.php?action=logout&token=${getters.getToken}`)
      console.log(response);
      if (response['response'] != 'Sucessfully logged out' || response['response'] != 'Token Missing') {
        alert(response['response'])
      }

      this.commit('setSessionToken', null);
      router.push({ path: '/authentication' })
    },

    async register (state, credentials) {
      if (credentials == null || credentials === undefined)
        return

      let response = await axiosRequest(url + `auth.php?action=register&firstname=${credentials['firstname']}&lastname=${credentials['lastname']}&email=${credentials['email']}&password=${credentials['password']}&place=${credentials['place']}&street=${credentials['street']}&building=${credentials['building']}&zipcode=${credentials['zipcode']}`);

      switch (response['response']) {
        case "Email in Use":
          alert("The provided email address is already in use!");
          break;
        case "Password too short":
          alert("The provided password is too short, be sure to use at least 7 characters!");
          break;
        case "Password must contain a letter":
          alert("The provided password must contain an alphabetic letter (A - z)!");
          break;
        case "Password must contain a capital letter":
          alert("The provided password must contain at least one CAPITAL letter!");
          break;
        case "Password must contain a small letter":
          alert("THE PROVIDED PASSWORD MUST CONTAIN AT LEAST ONE small LETTER!");
          break;
        case "Registration Complete":
          alert("The registration is complete, you can now log in!");
          break;
        default:
          alert(response['response'])
          break;
      }
    },

    addToCart (state, productData) {
      if (!Number.isInteger(productData[0]) ||  Number.isInteger(productData[1]))
        return

      this.commit('addToCart', productData);
    },

    removeFromCart (state, productId) {
      if (productId == null || productId === undefined || !Number.isInteger(productId))
        return

      this.commit('removeFromCart', productId);
    },    
  },
  modules: {
  },
  plugins: [
    persistentData.plugin
  ]
});

async function axiosRequest(url) {

  let responseData;

  await axios.get(url).then(function (response) {
    responseData = response;
  });
  
  return await responseData.data;

}