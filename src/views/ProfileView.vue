<template>
  <div class="container">
    <router-link to="/dashboard">&larr; Voltar para o Dashboard</router-link>
    <h1>Perfil do Usuário</h1>

    <div class="profile-section">
      <h2>Informações Pessoais</h2>
      <form @submit.prevent="saveProfile">
        <div class="form-group">
          <label for="name">Nome</label>
          <input type="text" id="name" v-model="user.name">
        </div>
        <div class="form-group">
          <label for="email">E-mail</label>
          <input type="email" id="email" v-model="user.email" disabled>
          <small>O e-mail não pode ser alterado.</small>
        </div>
        <button type="submit">Salvar Alterações</button>
      </form>
    </div>

    <div class="profile-section">
      <h2>Alterar Senha</h2>
      <form @submit.prevent="changePassword">
        <div class="form-group">
          <label for="currentPassword">Senha Atual</label>
          <input type="password" id="currentPassword" v-model="passwordForm.current">
        </div>
        <div class="form-group">
          <label for="newPassword">Nova Senha</label>
          <input type="password" id="newPassword" v-model="passwordForm.new">
        </div>
        <button type="submit">Alterar Senha</button>
      </form>
    </div>

    <div class="profile-section">
      <h2>Preferências</h2>
      <div class="form-group">
        <label>Tema Visual</label>
        <select v-model="preferences.theme">
          <option value="light">Claro</option>
          <option value="dark">Escuro</option>
        </select>
      </div>
      <div class="form-group">
        <label>Notificações</label>
        <label><input type="checkbox" v-model="preferences.notifications.email"> E-mail</label>
        <label><input type="checkbox" v-model="preferences.notifications.push"> Push (Navegador)</label>
      </div>
       <button @click="savePreferences">Salvar Preferências</button>
    </div>

  </div>
</template>

<script setup>
import { reactive, onMounted } from 'vue'

// Dados do usuário (simulados, carregados do localStorage)
const user = reactive({
  name: '',
  email: ''
})

const passwordForm = reactive({
  current: '',
  new: ''
})

// Dados de preferências (simulados)
const preferences = reactive({
  theme: 'light',
  notifications: {
    email: true,
    push: false
  }
})

onMounted(() => {
  const storedUser = JSON.parse(localStorage.getItem('user'))
  if (storedUser) {
    user.name = storedUser.name
    user.email = storedUser.email
  }
  // Em uma aplicação real, as preferências também viriam do backend
})

const saveProfile = () => {
  // Lógica para salvar o perfil no backend
  // Aqui, vamos apenas atualizar o localStorage
  const updatedUser = { ...JSON.parse(localStorage.getItem('user')), name: user.name }
  localStorage.setItem('user', JSON.stringify(updatedUser))
  alert('Perfil salvo com sucesso!')
}

const changePassword = () => {
  // Lógica para chamar a API de alteração de senha
  if (!passwordForm.current || !passwordForm.new) {
    alert('Por favor, preencha a senha atual e a nova senha.')
    return
  }
  alert('Senha alterada com sucesso! (Simulação)')
  passwordForm.current = ''
  passwordForm.new = ''
}

const savePreferences = () => {
  // Lógica para salvar as preferências do usuário no backend
  console.log('Salvando preferências:', preferences)
  alert('Preferências salvas com sucesso!')
}
</script>

<style scoped>
.profile-section {
  background-color: #f9f9f9;
  border: 1px solid #eee;
  padding: 20px;
  border-radius: 8px;
  margin-top: 25px;
}
.form-group small {
  color: #666;
}
label {
  margin-right: 15px;
}
</style>
