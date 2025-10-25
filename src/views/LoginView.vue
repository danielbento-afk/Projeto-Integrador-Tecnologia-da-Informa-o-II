<template>
  <div class="container login-container">
    <h1>Acessar Plataforma</h1>
    <form @submit.prevent="handleLogin">
      <div class="form-group">
        <label for="email">E-mail</label>
        <input type="email" id="email" v-model.trim="email" required>
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

const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/

function isStrongEnough(pass) {
  // mínimo 8 caracteres, ao menos 1 letra e 1 dígito
  return /^(?=.*[A-Za-z])(?=.*\d).{8,}$/.test(pass)
}

const handleLogin = () => {
  error.value = null

  if (!emailRegex.test(email.value)) {
    error.value = 'Informe um e-mail válido.'
    return
  }

  if (!isStrongEnough(password.value)) {
    error.value = 'A senha deve ter no mínimo 8 caracteres, com letras e números.'
    return
  }

  // --- AUTENTICAÇÃO SIMULADA ---
  // Em produção: chamar API e receber token JWT
  const demoUser = JSON.parse(localStorage.getItem('registered_user') || 'null')
  if (!demoUser || demoUser.email !== email.value) {
    error.value = 'Usuário não encontrado. Crie uma conta.'
    return
  }
  // (Opcional) Conferir hash na API; aqui só comparamos string por simplicidade
  if (demoUser.password !== password.value) {
    error.value = 'Senha incorreta.'
    return
  }

  // Gera um "token" fake e salva sessão
  const fakeToken = Math.random().toString(36).slice(2) + Date.now()
  localStorage.setItem('auth_token', fakeToken)
  localStorage.setItem('user', JSON.stringify({ name: demoUser.name, email: demoUser.email }))

  router.push('/dashboard')
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
