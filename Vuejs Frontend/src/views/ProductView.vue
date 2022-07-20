<template>
    <div class="container">
        <div class="front-page">
            <div class="content">
                <h1>{{ fullname }}</h1>
                <p>{{ this.productData.description }}</p>
                <p v-if="this.productData.inventory <= 0">
                    <span style="color: red;">This product is out of stock!</span>
                </p>
                <p v-else-if="this.productData.inventory < 5">
                    Only {{ this.productData.inventory }} more in stock!
                </p>
                <p v-for="row in this.specifications" v-bind:key="row">
                    - {{ row }}
                </p>

                <div v-if="this.productData.onSale == 0">
                    <p style="font-weight: bold;">${{ this.productData.price }}</p>
                </div>
                <div v-else-if="this.productData.onSale == 1 && this.productData.salePrice != 0">
                    <p><span style="text-decoration: line-through;">${{ this.productData.price }}</span> ${{ this.productData.salePrice }}</p>
                </div>

                <button v-if="this.productData.inventory > 0" @click="addToCart">Add to Cart</button>
            </div>
            <div class="cover-image" v-bind:style="{ backgroundImage: 'url(' + this.productData.image + ')' }"></div>
        </div>

        <hr />
        <h1>Similar Products</h1>
        <div class="flex-container">
            <ProductTile v-for="p in this.similarProducts" :key="p.productId" :id="p.productId" :name="p.productName" :category="p.categoryName" :image="p.image" :price="p.price" :onSale="p.onSale" :salePrice="p.salePrice" :isFeatured="p.isFeatured" />
        </div>
    </div>
</template>

<script>
import ProductTile from '@/components/ProductTile.vue';

export default {
    data() {
        return {
            slug: this.$route.params.slug,
            productData: [],
            similarProducts: [],
            specifications: null,
        }
    },
    components: {
        ProductTile,
    },
    computed: {

        fullname () {
            return this.productData.brandName + ', ' + this.productData.productName;
        },

        productSpecifications () {
            return this.productData.specifications.split(',')
        }

    },
    methods: {
        addToCart: function() {
            if (this.productData.inventory <= 0)
                return

            // If on sale
            if (this.productData.onSale == 1) {

                this.$store.dispatch('addToCart', [parseInt(this.slug), parseFloat(this.productData.salePrice)]);

            } else {

                this.$store.dispatch('addToCart', [parseInt(this.slug), parseFloat(this.productData.price)]);

            }
        }
    },
    async beforeMount() {
        this.$store.state.productId = this.slug;
        this.productData = await this.$store.getters.getProduct;

        this.specifications = this.productSpecifications

        this.$store.state.categoryId = this.productData.categoryId;
        this.similarProducts = await this.$store.getters.getSimilarProducts;
    },
    watch: {
        // Force refresh page on slug change.
        '$route.params.slug'() {
            this.$router.go()
        }
    }
}
</script>

<style>

</style>