<template>
  <div class="container register-container">
    <h1>Criar Nova Conta</h1>
    <form @submit.prevent="handleRegister">
      <div class="form-group">
        <label for="name">Nome Completo</label>
        <input type="text" id="name" v-model="name" required>
      </div>
      <div class="form-group">
        <label for="email">E-mail</label>
        <input type="email" id="email" v-model="email" required>
      </div>
      <div class="form-group">
        <label for="password">Senha</label>
        <input type="password" id="password" v-model="password" required>
        </div>
      <div class="form-group">
        <label for="confirmPassword">Confirmar Senha</label>
        <input type="password" id="confirmPassword" v-model="confirmPassword" required>
      </div>
      <button type="submit">Cadastrar</button>
      <p>Já tem uma conta? <router-link to="/login">Faça login</router-link></p>
      <p v-if="error" class="error-message">{{ error }}</p>
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
const router = useRouter()

const handleRegister = () => {
  error.value = null
  if (password.value !== confirmPassword.value) {
    error.value = 'As senhas não coincidem.'
    return
  }
  // --- LÓGICA DE BACKEND (SIMULADA) ---
  // Aqui você chamaria sua API para cadastrar o novo usuário.
  // A API deveria validar se o e-mail já existe.
  console.log('Registrando usuário:', { name: name.value, email: email.value })
  alert('Cadastro realizado com sucesso! (Simulação)')
  router.push('/login')
}
</script>

<style scoped>
.register-container {
  max-width: 450px;
  margin: 50px auto;
}
</style>
