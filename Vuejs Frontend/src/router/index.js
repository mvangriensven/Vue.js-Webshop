import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import store from '../store'

const appName = 'BRAND NAME';

const routes = [
  {
    path: '/',
    name: 'home',
    component: HomeView,
    meta: {
      title: 'Home',
      auth: false
    }
  },
  {
    path: '/aboutus',
    name: 'aboutus',
    component: () => import('../views/AboutPage.vue'),
    meta: {
      title: 'About Page',
      auth: false
    }
  },
  {
    path: '/products',
    name: 'about',
    component: () => import('../views/ProductsView.vue'),
    meta: {
      title: 'Our Products',
      auth: false
    }
  },
  {
    path: '/product/:slug',
    name: 'product',
    component: () => import('../views/ProductView.vue'),
    meta: {
      title: 'My Page Title',
      auth: false
    }
  },
  {
    path: '/authentication',
    name: 'authentication',
    component: () => import('../views/AuthenticationView.vue'),
    meta: {
      title: 'Login or Create an Account',
      auth: false
    }
  },
  {
    path: '/cart',
    name: 'cart',
    component: () => import('../views/CartView.vue'),
    meta: {
      title: 'Your Cart',
      auth: false
    }
  },
  {
    path: '/checkout',
    name: 'checkout',
    component: () => import('../views/CheckoutView.vue'),
    meta: {
      title: 'Checkout',
      auth: false
    }
  },
  {
    path: '/dashboard',
    name: 'Dashboard',
    component: () => import('../views/DashboardView.vue'),
    meta: {
      title: 'Dashboard',
      auth: true
    }
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

router.beforeEach((to, from, next) => {
  // Set page title
  var pageTitle = `${appName} | ${to.meta.title}`;
  document.title = pageTitle

  // To-do: Check for Auth requirements
  if (to.meta.auth == true)
    if (store.state.sessionToken == null)
      router.push({ path: '/authentication' })
  
  if (to.name == 'authentication')
    if (store.state.sessionToken != null)
      router.push({ path: '/dashboard' })


  next()

})

// router.beforeEach((to, from, next) => {
//   var pageTitle = `${appName} | ${to.meta.title}`;

//   //if (to.fullPath.includes('products')) // If router is routing a productS page.
//     pageTitle = `${appName} | ${to.params.slug.toUpperCase()}`;

//   document.title = pageTitle
//   next()
// });

export default router
