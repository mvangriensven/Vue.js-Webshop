<template>
  <div class="container">
    <OrderedProducts v-for="(order, i) in this.orderData" :key="i" :orderData="order" />
    <h1 style="text-align: center;" v-if="orderData.length <= 0">Your submitted orders will appear here!</h1>
  </div>
</template>

<script>
import OrderedProducts from '../components/OrderedProducts.vue';

export default {
  name: 'DashboardView',

  components: {
    OrderedProducts
  },

  data() {
    return {
      orderData: []
    }
  },
  async beforeMount() {
    this.orderData = await this.$store.getters.getAllOrders;
  }
}
</script>

<style>

</style>