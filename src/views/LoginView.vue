<template>
  <div class="container login-container">
    <h1>Acessar Plataforma</h1>
    <form @submit.prevent="handleLogin">
      <div class="form-group">
        <label for="email">E-mail</label>
        <input type="email" id="email" v-model="email" required>
      </div>
      <div class="form-group">
        <label for="password">Senha</label>
        <input type="password" id="password" v-model="password" required>
      </div>
      <button type="submit">Entrar</button>
      <div class="links">
        <a href="#">Esqueci minha senha</a>
        <router-link to="/register">Criar uma conta</router-link>
      </div>
      <p v-if="error" class="error-message">{{ error }}</p>
    </form>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'

const email = ref('')
const password = ref('')
const error = ref(null)
const router = useRouter()

const handleLogin = () => {
  error.value = null
  // --- LÓGICA DE BACKEND (SIMULADA) ---
  // Aqui você faria uma chamada para sua API para validar o usuário.
  // Vamos simular um login bem-sucedido.
  if (email.value === 'user@example.com' && password.value === 'password') {
    // Salva um "token" ou info do usuário no localStorage para simular a sessão
    localStorage.setItem('user', JSON.stringify({ name: 'Aluno Teste', email: email.value }))
    // Redireciona para o dashboard
    router.push('/dashboard')
  } else {
    error.value = 'E-mail ou senha inválidos.'
  }
}
</script>

<style scoped>
.login-container {
  max-width: 400px;
  margin: 50px auto;
  text-align: center;
}
.links {
  margin-top: 15px;
  display: flex;
  justify-content: space-between;
}
.error-message {
  color: red;
  margin-top: 10px;
}
</style>
