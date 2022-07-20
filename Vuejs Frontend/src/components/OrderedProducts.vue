<template>
    <div class="orderedProductCard">
        <div class="content">
            <p>Order Nr.{{ this.orderData.id }}</p>
            <p>{{ this.orderData.date }}</p>
            <p>{{ this.orderData.street }}, {{ this.orderData.place }}<br/>{{ this.orderData.zipcode }}</p>
        </div>
        <div class="content">
            <table>
                <tr v-for="(product, i) in this.orderData.products" :key="i">
                    <td>{{ product.productName }}</td>
                    <td v-if="product.onSale == true">${{ product.salePrice }}</td>
                    <td v-if="product.onSale == true"><span style="text-decoration: line-through;">${{ product.price }}</span></td>
                    <td v-else>${{ product.price }}</td>
                </tr>
                <hr/>
                <tr>
                    <td>${{ totalValue }}</td>
                </tr>
            </table>
        </div>
    </div>
</template>

<script>

export default {
    name: 'OrderedProduct',
    props: ['orderData'],

    data() {
        return {
            cartSize: this.$store.getters.cartSize
        }
    },
    computed: {
        totalValue() {
            if (this.orderData.products.length <= 0)
                return

            let totalValue = parseFloat(0);

            for (const product of this.orderData.products) {
                if (product.onSale == true)
                    totalValue = totalValue + parseFloat(product.salePrice)
                else
                    totalValue = totalValue + parseFloat(product.price)
            }
            return totalValue;
        }
    }
}
</script>

<style>
.orderedProductCard {
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

.orderedProductCard .content {
  float: left;
  
  width: calc(50% - 125px - 20px);
  height: 100%;

  padding-left: 20px;
}

.orderedProductCard .content button {
    background-color: rgba(196, 196, 196, 0.85);
}

</style>