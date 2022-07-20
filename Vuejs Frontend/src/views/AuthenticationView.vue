<template>
  <div class="container">
    <div style="width: 65%;" class="front-page">
      <div style="text-align: right;" class="content">
        <h2>LOGIN</h2>
        <form @submit.prevent="login" style="text-align: right !important;">
          <input required autocomplete="on" v-model="loginCredentials.email" type="text" name="login-email" id="login-email" placeholder="E-Mail" />
          <input required autocomplete="off" v-model="loginCredentials.password" type="password" name="login-password" id="login-password" placeholder="Password" />
          <button type="submit">LOGIN</button>
          <input type="submit" value="RESET PASSWORD" />
        </form>
      </div>
      <div class="content">
        <h2>REGISTER</h2>
        <form @submit.prevent="register">
          <input required autocomplete="off" v-model="registerCredentials.firstname" type="text" name="firstname" id="firstname" placeholder="Firstname" />
          <input required autocomplete="off" v-model="registerCredentials.lastname" type="text" name="lastname" id="lastname" placeholder="Lastname" />
          <input required autocomplete="off" v-model="registerCredentials.email" type="text" name="email" id="email" placeholder="E-Mail" />
          <input required autocomplete="off" v-model="registerCredentials.password" type="password" name="password" id="password" placeholder="Password" />
          <input required autocomplete="off" v-model="registerCredentials.place" type="text" name="place" id="place" placeholder="Place" />
          <input required autocomplete="off" v-model="registerCredentials.street" type="text" name="street" id="street" placeholder="Street" />
          <input required autocomplete="off" v-model="registerCredentials.building" type="text" name="building" id="building" placeholder="Building Nr." />
          <input required autocomplete="off" v-model="registerCredentials.zipcode" type="text" name="zipcode" id="zipcode" placeholder="Zipcode" />
          <button type="submit">REGISTER</button>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
import { ref } from 'vue';

export default {

  name: 'AuthenticationView',

  setup() {

    const loginCredentials = ref({
      email: '',
      password: '',
    });

    const registerCredentials = ref({
      firstname: '',
      lastname: '',
      email: '',
      password: '',
      place: '',
      street: '',
      zipcode: '',
    });

    return {

      loginCredentials,
      registerCredentials

    }
  },

  methods: {

    login: function() {
      if (this.loginCredentials.email == null || this.loginCredentials.password == null)
        return
      
      // this.$store.commit('login', this.loginCredentials);
      this.$store.dispatch('login', this.loginCredentials);
    },

    register: function () {
      if (this.registerCredentials.firstname == null
          || this.registerCredentials.lastname == null
          || this.registerCredentials.email == null
          || this.registerCredentials.password == null
          || this.registerCredentials.place == null
          || this.registerCredentials.street == null
          || this.registerCredentials.building == null
          || this.registerCredentials.zipcode == null)
        return 

      this.$store.dispatch('register', this.registerCredentials);
    }

  }
}
</script>

<style>

h2 {
  margin: 0;
}

</style>