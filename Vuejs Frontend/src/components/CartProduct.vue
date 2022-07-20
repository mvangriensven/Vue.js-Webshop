<template>
    <div class="cartCard">
        <img :src="productData.image" alt="">
        <div class="content">
            <div style="min-width: 10px; float: right;">
                <button v-on:click="removeFromCart">Remove</button>
                <p v-if="this.productData.onSale == true" class="price">${{ productData.salePrice }} <span style="text-decoration: line-through;">${{ productData.price }}</span></p>
                <p v-else class="price">${{ productData.price }}</p>
            </div>
            <div style="min-width: 10px;">
                <h3>{{ title }}</h3>
                <p>{{ productData.description }}</p>
            </div>
        </div>
    </div>
</template>

<script>
export default {

    name: 'CartProduct',
    props: ['productId'],

    data() {
        return {
            productData: []
        }
    },

    methods: {
        removeFromCart: function() {
            this.$store.commit('removeFromCart', parseInt([this.productId.productId]));
        }
    },

    computed: {
        title() {
            return this.productData.brandName + ', ' + this.productData.productName
        }
    },

    async beforeMount() {
        
        this.$store.state.productId = this.productId.productId;
        this.productData = await this.$store.getters.getProduct;

    }

}
</script>

<style>

.cartCard {
  background-color: white;
  width: calc(100% - 50px);
  height: 125px;
  border-radius: 10px;
  box-shadow: 5px 5px 15px black;

  padding: 25px;
  margin: 15px 0 15px 0;

  overflow: hidden;

  flex-wrap: wrap;
}

.cartCard img {
  float: left;
  width: 125px;
  height: 125px;

  border-radius: 10px;
  box-shadow: 2px 2px 10px black;
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

</style>