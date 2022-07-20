<template>
    <div class="container">
        <div class="flex-container">
            <ProductTile v-for="p in this.productData" :key="p.productId" :id="p.productId" :name="p.productName" :category="p.categoryName" :image="p.image" :price="p.price" :onSale="p.onSale" :salePrice="p.salePrice" :isFeatured="p.isFeatured" :inventory="p.inventory" />
        </div>
    </div>
</template>

<script>
import ProductTile from '@/components/ProductTile.vue';

export default {
    data() {
        return {
            productData: []
        }
    },
    components: {
        ProductTile
    },
    async beforeMount() {
        this.productData = await this.$store.getters.getProducts;
    }
}
</script>

<style>
    h1 {
        margin: 0;
    }
</style>