<template>
  <div class="container">
    <button @click="placeOrder">Place Order</button>
    <div class="checkoutCard">
        <div class="content">
            <table>
                <tr v-for="(product, i) in productData.products" :key="i">
                    <td>{{ product.brandName }}, {{ product.productName }}</td>
                    <td v-if="product.onSale == true">${{ product.salePrice }}</td>
                    <td v-if="product.onSale == true"><span style="text-decoration: line-through;">${{ product.price }}</span></td>
                    <td v-else>${{ product.price }}</td>
                </tr>
                <hr/>
                <tr>
                    <td v-if="this.cartSize > 1">{{ this.cartSize }} products</td>
                    <td v-else>{{ this.cartSize }} product</td>
                    <td>${{ totalValue }}</td>
                </tr>
            </table>
        </div>
    </div>
  </div>
</template>

<script>
import router from '@/router';

export default {

    data() {
        return {
            productData: [],
            cartSize: this.$store.getters.cartSize
        }
    },
    computed: {
        totalValue() {

            if (this.productData.length <= 0)
                return

            let totalValue = parseFloat(0);

            for (const product of this.productData.products) {

                if (product.onSale == true)
                    totalValue = totalValue + parseFloat(product.salePrice)
                else
                    totalValue = totalValue + parseFloat(product.price)
            }

            return totalValue;
        }
    },
    methods: {
        placeOrder: function() {
            this.$store.dispatch('placeOrder');
        }
    },
    async beforeMount() {

        if (this.$store.getters.isLoggedIn == false) {

            alert("Please create an account before checking out!");
            router.push( { path: '/authentication' } )

        }

        if (this.$store.getters.cartSize <= 0) {
            router.push( { path: '/products' } )
        }

        this.productData = await this.$store.getters.getProductData;

    }

}
</script>

<style>

.checkoutCard {
  background-color: white;
  width: calc(100% - 50px);
  min-height: 25px;
  border-radius: 10px;
  box-shadow: 5px 5px 15px black;

  padding: 25px;
  margin: 15px 0 15px 0;

  overflow: hidden;

  flex-wrap: wrap;
}

.cartCard .content {
  float: left;
  
  width: calc(100% - 125px - 20px);
  height: 100%;

  padding-left: 20px;
}

.cartCard .content button {
    background-color: rgba(235, 123, 123, 0.85);
}

tr td {
    padding: 10px 35px 10px 0;
}

</style>