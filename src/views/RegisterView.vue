<template>
  <div class="container register-container">
    <h1>Criar Nova Conta</h1>
    <form @submit.prevent="handleRegister">
      <div class="form-group">
        <label for="name">Nome Completo</label>
        <input type="text" id="name" v-model.trim="name" required>
      </div>
      <div class="form-group">
        <label for="email">E-mail</label>
        <input type="email" id="email" v-model.trim="email" required>
      </div>
      <div class="form-group">
        <label for="password">Senha</label>
        <input type="password" id="password" v-model="password" required>
        <small>Mínimo 8 caracteres, com letras e números.</small>
      </div>
      <div class="form-group">
        <label for="confirmPassword">Confirmar Senha</label>
        <input type="password" id="confirmPassword" v-model="confirmPassword" required>
      </div>
      <button type="submit">Cadastrar</button>

      <p>Já tem uma conta? <router-link to="/login">Faça login</router-link></p>
      <p v-if="error" class="error-message">{{ error }}</p>
      <p v-if="success" class="success-message">{{ success }}</p>
    </form>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'

const name = ref('')
const email = ref('')
const password = ref('')
const confirmPassword = ref('')
const error = ref(null)
const success = ref(null)
const router = useRouter()

const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
function isStrongEnough(pass) {
  return /^(?=.*[A-Za-z])(?=.*\d).{8,}$/.test(pass)
}

const handleRegister = () => {
  error.value = null
  success.value = null

  if (!name.value) {
    error.value = 'Informe seu nome completo.'
    return
  }
  if (!emailRegex.test(email.value)) {
    error.value = 'Informe um e-mail válido.'
    return
  }
  if (!isStrongEnough(password.value)) {
    error.value = 'A senha deve ter no mínimo 8 caracteres, com letras e números.'
    return
  }
  if (password.value !== confirmPassword.value) {
    error.value = 'As senhas não coincidem.'
    return
  }

  // Evita e-mail duplicado (simulado)
  const existing = JSON.parse(localStorage.getItem('registered_user') || 'null')
  if (existing && existing.email === email.value) {
    error.value = 'Já existe uma conta com este e-mail.'
    return
  }

  // Em produção: enviar para API e salvar hash no backend
  localStorage.setItem('registered_user', JSON.stringify({
    name: name.value,
    email: email.value,
    password: password.value // Em produção: NUNCA guarde senha em texto plano
  }))

  success.value = 'Cadastro realizado com sucesso! Você será redirecionado para o login.'
  setTimeout(() => router.push('/login'), 1200)
}
</script>

<style scoped>
.register-container {
  max-width: 450px;
  margin: 50px auto;
}
.error-message { color: #c0392b; margin-top: 10px; }
.success-message { color: #27ae60; margin-top: 10px; }
small { color: #666; }
</style>
