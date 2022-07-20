<template>
  <div class="container">
    <div class="front-page">
      <div class="content">
        <h1>Lorem Ipsum</h1>
        <p>Lorem Ipsum Dolor Sit Amet</p>
        <router-link to="/">Browse Our Products</router-link>
      </div>
      <div class="cover-image" style="background-image: url('https://i.imgur.com/6a13p71_d.webp?maxwidth=1080&fidelity=grand');">
      </div>
    </div>

    <h2>Featured Products</h2>

    <hr />

    <div id="product-toggles" class="product-toggles">
      <h2 @click="toggleProductButton('FURNITURE', $event)" class="active" id="toggle-furniture">FURNITURE</h2>
      <h2 @click="toggleProductButton('LIGHTING', $event)" id="toggle-lighting">LIGHTING</h2>
      <h2 @click="toggleProductButton('SOFAS', $event)" id="toggle-sofas">SOFAS</h2>
      <h2 @click="toggleProductButton('LOUNGE CHAIRS', $event)" id="toggle-loungechairs">LOUNGE CHAIRS</h2>
    </div>

    <div id="product-containers">
      <div id="product-container" style="display: flex;" class="flex-container">
        <ProductTile v-for="p in this.featuredProducts" :key="p.productId" :id="p.productId" :name="p.productName" :category="p.categoryName" :image="p.image" :price="p.price" :onSale="p.onSale" :salePrice="p.salePrice" :isFeatured="p.isFeatured" :inventory="p.inventory"></ProductTile>
      </div>
    </div>
  </div>
</template>

<script>
import ProductTile from '@/components/ProductTile.vue';

export default { 
  data() {
    return {
      featuredProducts: []
    }
  },

  async beforeMount() {

    this.featuredProducts = await this.$store.getters.getFeaturedProducts;

    // Execute code post page render.
    this.$nextTick(function () {
      this.toggleProductTiles('FURNITURE');
    });

  },

  components: {
    ProductTile
  },

  methods: {

    toggleProductButton(product, source) {
      // Fetch all product toggles
      const productToggles = document.getElementById('product-toggles').children;

      // Loop thru.
      for (let i = 0; i < productToggles.length; i++) {
        if (productToggles[i].id == source.currentTarget.id)
          productToggles[i].classList.add('active');
        else
          productToggles[i].classList.remove('active');
      }

      this.toggleProductTiles(product);
    },

    toggleProductTiles(product) {
      // Fetch all product tiles.
      const productTiles = document.getElementById('product-container').children;

      // Loop thru to disable all elements except the desired one.
      for (let i = 0; i < productTiles.length; i++) {
        if (productTiles[i]['name'] == product) {
          productTiles[i].style.display = 'inline-flex';
        } else {
          productTiles[i].style.display = 'none';
        }
      }
    }

  }
}
</script>

<style>

.product-toggles h2 {
  float: left;
  margin: 10px 50px 10px 0;
  padding: 15px;
  cursor: pointer;
}

.product-toggles .active {
  transition: 0.25s linear all;
  background-color: #e0e0e0b4;
  box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.2);
  border-radius: 5px;
}

</style>