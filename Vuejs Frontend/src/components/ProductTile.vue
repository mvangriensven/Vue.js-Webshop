<template>
    <router-link v-bind:name="this.category" :to="'/product/' + this.id">
        <div class="product-tile">
            <div class="product-image" v-bind:style="{ backgroundImage: 'url(' + this.image + ')' }">
                <div class="product-mark">
                    <div v-if="this.inventory <= 0">
                        <span style="color: red;">Out of Stock!</span>
                    </div>
                    <div v-else-if="this.onSale == 1">
                        On Sale
                    </div>
                    <div v-else-if="this.isFeatured == 1">
                        Featured
                    </div>
                </div>
            </div>
            <div class="product-data">
                <h2>{{ this.name }}</h2>

                <div v-if="this.onSale == 1 && this.salePrice != 0 && this.salePrice != ''">
                    <p><span style="text-decoration: line-through;">${{ this.price }}</span> ${{ this.salePrice }}</p>
                </div>
                <div v-else>
                    <p style="font-weight: bold;">${{ this.price }}</p>
                </div>

            </div>
        </div>
    </router-link>
</template>

<script>
export default {
    name: 'ProductTile',
    props: ['id', 'name', 'category', 'image', 'price', 'onSale', 'salePrice', 'isFeatured', 'inventory']
}
</script>

<style>
.product-tile {
    width: 325px;
    height: 450px;

    margin: 25px;
    padding: 10px;

    text-align: center;
    
    background-color: white;
}

.product-tile h2 {
    padding: 0;
    margin: 5px 0 0 5px;
}

.product-tile .product-image {
    width: 100%;
    height: 80%;

    border-radius: 10px;
    box-shadow: 5px 5px 15px rgba(0, 0, 0, 0.4);

    background-position: center;
    background-repeat: no-repeat;
    background-size: cover;

    background-color: rgba(101, 101, 247, 0.342);
}

.product-tile .product-image .product-mark {
    float: right;
    margin: 10px;
    font-weight: bold;
}

.product-tile .product-data {
    width: 100%;
    height: 20%;
    padding: 10px 0 10px 0;
}

</style>