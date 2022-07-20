<template>
  <div class="container">
    <div v-if="this.cartSize > 0">
      <p class="totalprice">{{ this.cartSize }} <span v-if="this.cartSize == 1">Product</span><span v-else>Products</span> Selected Totalling $ {{ totalValue }}</p>
      <button><router-link to="/checkout">Proceed to Checkout</router-link></button>
      <button @click="emptyCart" style="float: right;">Empty Cart</button>

      <CartProduct v-for="(product, i) in this.cartItems" :key="i" :productId="product"/>

    </div>
    <div style="text-align: center;" v-else>
      <h1>Your Cart is Empty</h1>
      <router-link to="/products"><h2>Browse Our Products Here!</h2></router-link>
    </div>
  </div>
</template>

<script>
import CartProduct from '../components/CartProduct.vue';

export default {

  components: {
    CartProduct
  },

  data() {
    return {
      cartSize: this.$store.getters.cartSize,
      cartItems: this.$store.getters.cart
    }
  },

  methods: {
    emptyCart: function() {
      this.$store.commit('emptyCart');
      this.cartSize = 0;
      this.cartItems = [];
    }
  },

  computed: {
    totalValue() {
      return this.cartItems.reduce((acc, item) => acc + item.price, 0);
    }
  }
}
</script>

<style>

.totalprice {
  margin-bottom: 20px;
  font-size: 1.75em;
}

</style>