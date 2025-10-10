<template>
  <div class="dashboard-page">
    <div class="dashboard-header">
      <h1 v-if="user">Olá, {{ user.name }}!</h1>
      <h1 v-else>Bem-vindo(a)!</h1>
      <p>Aqui está um resumo de suas atividades e atalhos importantes.</p>
    </div>

    <div class="dashboard-layout">
      <main class="main-content">
        <div class="card schedule-summary">
          <h2>Cronograma de Hoje</h2>
          <div v-if="todaysSchedule.length > 0">
            <ul>
              <li v-for="item in todaysSchedule" :key="item.id" class="schedule-item">
                <div class="schedule-time">{{ item.time }}</div>
                <div class="schedule-details">
                  <h4>{{ item.discipline }}</h4>
                  <p>{{ item.description }}</p>
                </div>
              </li>
            </ul>
          </div>
          <div v-else class="empty-state">
            <p>Você não tem nenhuma sessão de estudo agendada para hoje. Que tal gerar um cronograma?</p>
            <router-link to="/schedule" class="btn-secondary">Gerar Cronograma</router-link>
          </div>
        </div>
      </main>

      <aside class="sidebar">
        <div class="card quick-access">
          <h2>Acesso Rápido</h2>
          <div class="quick-access-links">
            <router-link v-for="link in quickLinks" :key="link.path" :to="link.path" class="quick-link-item">
              <div class="icon" v-html="link.icon"></div>
              <div class="text">
                <h3>{{ link.title }}</h3>
                <p>{{ link.description }}</p>
              </div>
            </router-link>
          </div>
        </div>

        <div class="card notifications-summary">
          <h2>Notificações</h2>
          <div v-if="notifications.length > 0">
            <ul>
              <li v-for="notification in notifications" :key="notification.id" class="notification-item">
                <p>{{ notification.message }}</p>
                <small>{{ notification.time }}</small>
              </li>
            </ul>
          </div>
          <div v-else class="empty-state-small">
            <p>Nenhuma notificação nova.</p>
          </div>
        </div>
        
        <button @click="logout" class="btn-logout">Sair da Conta</button>
      </aside>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';

const user = ref(null);
const router = useRouter();

// Dados simulados para o layout
const quickLinks = ref([
  {
    title: 'Meus Cursos',
    description: 'Gerencie suas disciplinas',
    path: '/courses',
    icon: `<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"></path><path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"></path></svg>`
  },
  {
    title: 'Disponibilidade',
    description: 'Defina seus horários livres',
    path: '/availability',
    icon: `<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>`
  },
  {
    title: 'Ver Cronograma',
    description: 'Visualize seu plano de estudos',
    path: '/schedule',
    icon: `<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>`
  }
]);

const todaysSchedule = ref([
  { id: 1, time: '09:00 - 11:00', discipline: 'Cálculo I', description: 'Revisar limites e derivadas.' },
  { id: 2, time: '14:00 - 15:30', discipline: 'Banco de Dados', description: 'Praticar modelagem Entidade-Relacionamento.' }
]);

const notifications = ref([
  { id: 1, message: 'Lembrete: Prova de Estrutura de Dados amanhã.', time: 'há 1 hora' }
]);

onMounted(() => {
  const userData = localStorage.getItem('user');
  if (userData) {
    user.value = JSON.parse(userData);
  }
});

const logout = () => {
  localStorage.removeItem('user');
  router.push('/login');
};
</script>

<style scoped>
.dashboard-page {
  width: 100%;
}

.dashboard-header {
  margin-bottom: calc(var(--spacing-unit) * 3);
  padding-bottom: calc(var(--spacing-unit) * 2);
  border-bottom: 1px solid var(--border-color);
}

.dashboard-header h1 {
  margin-bottom: 0.5rem;
}

.dashboard-header p {
  color: #7f8c8d;
  font-size: 1.1rem;
  margin-bottom: 0;
}

.dashboard-layout {
  display: grid;
  grid-template-columns: 2fr 1fr; /* 2/3 para o conteúdo, 1/3 para a sidebar */
  gap: calc(var(--spacing-unit) * 2.5);
}

.main-content {
  display: flex;
  flex-direction: column;
}

.sidebar {
  display: flex;
  flex-direction: column;
  gap: calc(var(--spacing-unit) * 2);
}

.card {
  background-color: white;
  padding: calc(var(--spacing-unit) * 2);
  border-radius: var(--border-radius-base);
  box-shadow: 0 4px 12px var(--shadow-light);
}

.card h2 {
  margin-top: 0;
  margin-bottom: calc(var(--spacing-unit) * 1.5);
  color: var(--primary-dark-color);
  font-size: 1.5rem;
}

/* Acesso Rápido */
.quick-access-links {
  display: flex;
  flex-direction: column;
  gap: var(--spacing-unit);
}

.quick-link-item {
  display: flex;
  align-items: center;
  gap: var(--spacing-unit);
  padding: var(--spacing-unit);
  border-radius: var(--border-radius-base);
  background-color: var(--bg-light);
  transition: background-color 0.2s ease, box-shadow 0.2s ease;
  text-decoration: none;
  color: var(--text-color-dark);
}

.quick-link-item:hover {
  background-color: #eaf5ff;
  box-shadow: 0 2px 8px var(--shadow-light);
}

.quick-link-item .icon {
  color: var(--primary-color);
  background-color: #ddeeff;
  padding: 10px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
}

.quick-link-item .text h3 {
  font-size: 1.1rem;
  margin: 0;
}

.quick-link-item .text p {
  font-size: 0.9rem;
  color: #7f8c8d;
  margin: 0;
}


/* Cronograma do Dia */
.schedule-summary ul, .notifications-summary ul {
  list-style: none;
  padding: 0;
}

.schedule-item {
  display: flex;
  gap: var(--spacing-unit);
  padding: var(--spacing-unit) 0;
  border-bottom: 1px solid var(--border-color);
}
.schedule-item:last-child {
  border-bottom: none;
}

.schedule-time {
  font-weight: 600;
  color: var(--primary-color);
  white-space: nowrap;
}

.schedule-details h4 {
  margin: 0 0 0.25rem 0;
  font-weight: 600;
}

.schedule-details p {
  margin: 0;
  font-size: 0.9rem;
  color: #7f8c8d;
}

/* Notificações */
.notification-item {
  padding: var(--spacing-unit);
  background-color: #fffbe6;
  border-left: 4px solid var(--accent-color);
  border-radius: 4px;
}

.notification-item p { margin-bottom: 0.25rem; font-size: 0.9rem; }
.notification-item small { color: #7f8c8d; }

/* Botão Logout */
.btn-logout {
  background-color: transparent;
  color: var(--primary-color);
  border: 2px solid var(--primary-color);
  margin-top: var(--spacing-unit);
}

.btn-logout:hover {
  background-color: var(--primary-color);
  color: white;
}

.empty-state {
  text-align: center;
  padding: calc(var(--spacing-unit) * 2);
}

.empty-state-small {
  text-align: center;
  padding: var(--spacing-unit);
  font-style: italic;
  color: #7f8c8d;
}

.btn-secondary {
  background-color: var(--secondary-color);
}
.btn-secondary:hover {
  background-color: #27ae60;
}


/* Responsividade */
@media (max-width: 992px) {
  .dashboard-layout {
    grid-template-columns: 1fr; /* Coluna única em telas menores */
  }
}
</style>