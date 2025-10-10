<template>
  <div class="container">
    <router-link to="/dashboard">&larr; Voltar para o Dashboard</router-link>
    <h1>Notificações</h1>

    <div class="actions">
      <button @click="markAllAsRead">Marcar todas como lidas</button>
    </div>

    <ul class="notification-list">
      <li
        v-for="notification in notifications"
        :key="notification.id"
        class="notification-item"
        :class="{ unread: !notification.read }"
      >
        <div class="notification-content">
          <h3>{{ notification.title }}</h3>
          <p>{{ notification.message }}</p>
          <small>{{ notification.timestamp }}</small>
        </div>
        <button v-if="!notification.read" @click="markAsRead(notification.id)">Marcar como lida</button>
      </li>
    </ul>
    <p v-if="notifications.length === 0">Você não tem nenhuma notificação.</p>
  </div>
</template>

<script setup>
import { ref } from 'vue'

// Dados simulados de notificações
const notifications = ref([
  {
    id: 1,
    title: 'Lembrete de Estudo',
    message: 'Sua sessão de estudo de "Cálculo I" começa em 15 minutos.',
    timestamp: 'Hoje, às 13:45',
    read: false
  },
  {
    id: 2,
    title: 'Cronograma Gerado',
    message: 'Seu novo cronograma de estudos para a semana foi gerado com sucesso.',
    timestamp: 'Ontem, às 20:10',
    read: false
  },
  {
    id: 3,
    title: 'Meta Atingida!',
    message: 'Parabéns! Você completou 80% da sua meta de estudos para a disciplina de "Física".',
    timestamp: '02/10/2025',
    read: true
  },
  {
    id: 4,
    title: 'Disponibilidade Atualizada',
    message: 'Seus horários disponíveis para a próxima semana foram salvos.',
    timestamp: '01/10/2025',
    read: true
  }
])

const markAsRead = (id) => {
  const notification = notifications.value.find(n => n.id === id)
  if (notification) {
    notification.read = true
  }
}

const markAllAsRead = () => {
  notifications.value.forEach(n => { n.read = true })
}
</script>

<style scoped>
.notification-list {
  list-style: none;
  padding: 0;
  margin-top: 20px;
}

.notification-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  background-color: #f9f9f9;
  padding: 15px;
  border-radius: 5px;
  margin-bottom: 10px;
  border-left: 5px solid #ccc;
  transition: background-color 0.3s;
}

.notification-item.unread {
  background-color: #fff;
  border-left-color: #42b983;
  font-weight: bold;
}

.notification-content h3 {
  margin: 0 0 5px 0;
  font-size: 1.1em;
}

.notification-content p {
  margin: 0;
  font-weight: normal;
  color: #555;
}

.notification-content small {
  font-weight: normal;
  color: #888;
}

.actions {
  text-align: right;
  margin-bottom: 20px;
}
</style>
